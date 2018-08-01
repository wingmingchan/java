<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>

<%
final class DBDataProvider
{
    // types that can have relationship
    public static final String BLOCK_TYPE                = "block";
    public static final String CONFIGURATION_SET_TYPE    = "pageconfigurationset";
    public static final String CONTENT_TYPE_TYPE         = "contenttype";
    public static final String DATA_DEFINITION_TYPE      = "datadefinition";
    public static final String DESTINATION_TYPE          = "destination";
    public static final String EDITOR_CONFIGURATION_TYPE = "editorconfiguration";
    public static final String FILE_TYPE                 = "file";
    public static final String FOLDER_TYPE               = "folder";
    public static final String FORMAT_TYPE               = "format";
    public static final String METADATA_SET_TYPE         = "metadataset";
    public static final String PAGE_TYPE                 = "page";
    public static final String PUBLISH_SET_TYPE          = "publishset";
    public static final String REFERENCE_TYPE            = "reference";
    public static final String SYMLINK_TYPE              = "symlink";
    public static final String TEMPLATE_TYPE             = "template";
    public static final String TRANSPORT_TYPE            = "transport";
    public static final String WORKFLOW_DEFINITION_TYPE  = "workflowdefinition";
    
    
    // TAGS!!
    
    
    // SQL statements
    public final String GET_GROUP_NAMES_STATEMENT = "SELECT name FROM CXML_GROUP";
    public final String GET_USER_NAMES_STATEMENT  = "SELECT username FROM CXML_USER";
    public final String GET_USER_NAMES_IN_GROUP_STATEMENT = 
        "SELECT username FROM CXML_GROUP_MEMBERSHIP WHERE groupname='%g'";
    public final String GET_FOLDER_CHILDREN_IDS_STATEMENT =
        "SELECT id FROM CXML_FOLDERCONTENT WHERE parentfolderid='%f' AND " +
        "iscurrentversion='1' ";
    public final String GET_ASSET_AUDITS_BY_ACTION_STATEMENT =
        "SELECT id, tstamp, username FROM CXML_AUDIT WHERE action='%a' AND " +
        "entityid='%eid'";
    public final String GET_ASSET_ID_STATEMENT =
        "SELECT f.id FROM CXML_FOLDERCONTENT f " +
        "WHERE f.assettype='%t' AND f.cachepath='%p' AND " +
        "f.siteid=(SELECT s.id FROM CXML_SITE s WHERE " +
        "s.name='%s')";
    public final String GET_SITE_ID_STATEMENT =
        "SELECT s.id FROM CXML_SITE s WHERE " +
        "s.name='%s'";

    public DBDataProvider()
    {
        try
        {
            this.context = new InitialContext();
            this.ds = ( DataSource )context.lookup( "java:comp/env/jdbc/CascadeDS" );
            openStatement();
        }
        catch( NamingException e )
        {
            System.out.println( e );
        }
    }
    
    public void closeStatement()
    {
        try
        {
            if( !this.conn.isClosed() )
            {
                this.conn.close();
            }
            if( !this.stmt.isClosed() )
            {
                this.stmt.close();
            }
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
    }
    
    public LinkedHashMap<String, ArrayList<ArrayList<String>>> getAssetAuditsByAction(
        String eid, String... actions )
    {
        return this.getAssetAuditsByAction( true, eid, actions );
    }
    
    public LinkedHashMap<String, ArrayList<ArrayList<String>>> getAssetAuditsByAction(
        boolean closeStmt, String eid, String... actions )
    {
        LinkedHashMap<String, ArrayList<ArrayList<String>>> actionAuditMap =
            new LinkedHashMap<String, ArrayList<ArrayList<String>>>();
        
        try
        {
            openStatement();
            
            for( String action : actions )
            {
                ResultSet rs = this.getResultSet(
                    this.GET_ASSET_AUDITS_BY_ACTION_STATEMENT.replace( "%eid", eid ).
                        replace( "%a", action )
                );
            
                actionAuditMap.put( action, this.getResultSetRecords( rs ) );
            }
            
            if( closeStmt )
            {
                closeStatement();
            }
        }
        catch( SQLException e)
        {
            System.out.println( e.getMessage() );            
        }

        return actionAuditMap;
    }
    
    public String getAssetId( String type, String path, String site )
    {
        return this.getAssetId( true, type, path, site );
    }
    
    public String getAssetId(
        boolean closeStmt, String type, String path, String site )
    {
        String id = "";
        
        if( path.length() > 1 && path.startsWith( "/" ) )
        {
            path = path.substring( 1 );
        }
        
        if( path.length() > 1 && path.endsWith( "/" ) )
        {
            path = path.substring( 0, path.length() - 1 );
        }
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet(
                this.GET_ASSET_ID_STATEMENT.replace( "%t", type ).
                replace( "%p", path ).replace( "%s", site ) );
            
            boolean found = rs.next();
            
            if( found )
            {
                id = rs.getString( 1 );
            }
            
            if( closeStmt )
            {
                closeStatement();
            }
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
        
        return id;
    }
   
    public ArrayList<String> getAssetTags( String assetId )
    {
        return this.getAssetTags( true, assetId );
    }
    
    public ArrayList<String> getAssetTags( boolean closeStmt, String assetId )
    {
        ArrayList<String> tags = new ArrayList<String>();
        String sql = "SELECT name FROM CXML_TAG WHERE id IN " +
            "(SELECT tagid FROM CXML_TAG_FCE_LINK WHERE assetid='" + assetId + "')";
        populateList( closeStmt, sql, tags );

        return tags;
    }
    
    public ArrayList<String> getFolderChildrenIDs( String fid )
    {
        return this.getFolderChildrenIDs( true, fid );
    }
    
    public ArrayList<String> getFolderChildrenIDs( boolean closeStmt, String fid )
    {
        ArrayList<String> childrenIDs = new ArrayList<String>();
        populateList(
            closeStmt, this.GET_FOLDER_CHILDREN_IDS_STATEMENT.replace( "%f", fid ),
            childrenIDs );
        
        return childrenIDs;
    }
    
    
    public ArrayList<String> getGroupNames()
    {
        return this.getGroupNames( true );
    }
    
    public ArrayList<String> getGroupNames( boolean closeStmt )
    {
        ArrayList<String> groupNames = new ArrayList<String>();
        populateList( closeStmt, this.GET_GROUP_NAMES_STATEMENT, groupNames );
        
        return groupNames;
    }

    public ResultSet getResultSet( String sql ) throws SQLException
    {
        ResultSet rs = this.stmt.executeQuery( sql );
        return rs;
    }
    
    public ArrayList<String> getResultSetList( ResultSet rs )
    {
        ArrayList<String> list = new ArrayList<String>();
        
        try
        {
            while( rs.next() )
            {
                list.add( rs.getString( 1 ) );
            }
        }
        catch( SQLException e )
        {
            System.out.println( e.getMessage() );            
        }

        return list;
    }

    public ArrayList<ArrayList<String>> getResultSetRecords( ResultSet rs )
    {
        ArrayList<ArrayList<String>> records = new ArrayList<ArrayList<String>>();
        
        try
        {
            int columnCount = rs.getMetaData().getColumnCount();
            
            while( rs.next() )
            {
                ArrayList<String> row = new ArrayList<String>();
                
                for( int i=1; i <= columnCount; i++ )
                {
                    row.add( rs.getString( i ) );
                }
                
                records.add( row );
            }
        }
        catch( SQLException e )
        {
            System.out.println( e.getMessage() );            
        }

        return records;
    }
    
    public String getSiteId( String site )
    {
        return this.getSiteId( true, site );
    }   
    
    public String getSiteId( boolean closeStmt, String site )
    {
        String id = "";
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet(
                this.GET_SITE_ID_STATEMENT.replace( "%s", site ) );
            
            boolean found = rs.next();
            
            if( found )
            {
                id = rs.getString( 1 );
            }
            
            if( closeStmt )
            {
                closeStatement();
            }
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
        
        return id;
    }

    public ArrayList<String> getSystemWideTags()
    {
        return this.getSystemWideTags( true );
    }
    
    public ArrayList<String> getSystemWideTags( boolean closeStmt )
    {
        ArrayList<String> tags = new ArrayList<String>();
        String sql = "SELECT name FROM CXML_TAG WHERE siteid IS NULL";
        populateList( closeStmt, sql, tags );

        return tags;
    }
    
    public ArrayList<String> getUserNames()
    {
        return this.getUserNames( true );
    }

    public ArrayList<String> getUserNames( boolean closeStmt )
    {
        ArrayList<String> usernames = new ArrayList<String>();
        populateList( closeStmt, this.GET_USER_NAMES_STATEMENT, usernames );
        
        return usernames;
    }

    public ArrayList<String> getUserNamesInGroup( String g )
    {
        return this.getUserNamesInGroup( true, g );
    }

    public ArrayList<String> getUserNamesInGroup( boolean closeStmt, String g )
    {
        ArrayList<String> usernames = new ArrayList<String>();
        String sql = this.GET_USER_NAMES_IN_GROUP_STATEMENT.replace( "%g", g );
        populateList( closeStmt, sql, usernames );
        
        return usernames;
    }
    
    public boolean hasDataDefinitionBlockRelationship(
        String ddId, ArrayList<String> result )
    {
        return this.hasDataDefinitionBlockRelationship( true, ddId, result );
    }
    
    public boolean hasDataDefinitionBlockRelationship(
        boolean closeStmt, String ddId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_FOLDERCONTENT " +
            "WHERE structureddatadefinitionid='" + ddId + "' " +
            "AND iscurrentversion=1";

        return populateList( closeStmt, sql, result );
    }

    public boolean hasConfigurationSetContentTypeRelationship(
        String pcsId, ArrayList<String> result )
    {
        return this.hasConfigurationSetContentTypeRelationship( true, pcsId, result );
    }
    
    public boolean hasConfigurationSetContentTypeRelationship(
        boolean closeStmt, String pcsId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_CONTENTTYPE " +
            "WHERE pageconfigurationsetid='" + pcsId + "' " +
            "AND iscurrentversion=1";

        return populateList( closeStmt, sql, result );
    }
    
    public boolean hasDataDefinitionContentTypeRelationship(
        String ddId, ArrayList<String> result )
    {
        return this.hasDataDefinitionContentTypeRelationship( true, ddId, result );
    }
    
    public boolean hasDataDefinitionContentTypeRelationship(
        boolean closeStmt, String ddId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_CONTENTTYPE " +
            "WHERE structureddatadefinitionid='" + ddId + "' " +
            "AND iscurrentversion=1";
        
        return populateList( closeStmt, sql, result );
    }
    
    public boolean hasMetadataSetAssetRelationship(
        String msId, ArrayList<String> result )
    {
        return this.hasMetadataSetAssetRelationship( true, msId, result );
    }
    
    public boolean hasMetadataSetAssetRelationship(
        boolean closeStmt, String msId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_FOLDERCONTENT " +
            "WHERE metadatasetid='" + msId + "' " +
            "AND iscurrentversion=1";
        
        return populateList( closeStmt, sql, result );
    }

    public boolean hasMetadataSetContentTypeRelationship(
        String msId, ArrayList<String> result )
    {
        return this.hasMetadataSetContentTypeRelationship( true, msId, result );
    }
    
    public boolean hasMetadataSetContentTypeRelationship(
        boolean closeStmt, String msId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_CONTENTTYPE " +
            "WHERE metadatasetid='" + msId + "' " +
            "AND iscurrentversion=1";
        
        return populateList( closeStmt, sql, result );
    }
    
    public boolean hasContentTypePageRelationship( String ctId, ArrayList<String> result )
    {
        return this.hasContentTypePageRelationship( true, ctId, result );
    }
        
    public boolean hasContentTypePageRelationship(
        boolean closeStmt, String ctId, ArrayList<String> result )
    {
        String sql = "SELECT id FROM CXML_FOLDERCONTENT " +
            "WHERE contenttypeid='" + ctId + "' " +
            "AND iscurrentversion=1";

        return populateList( closeStmt, sql, result );
    }
    
    public boolean hasPublishRelatedAssetRecordRelationship(
        String sourceId, 
        LinkedHashMap<String,ArrayList<String>> result )
    {
        return this.hasPublishRelatedAssetRecordRelationship( true, sourceId, result );
    }
    
    public boolean hasPublishRelatedAssetRecordRelationship(
        boolean closeStmt, String sourceId, 
        LinkedHashMap<String,ArrayList<String>> result )
    {
        String sql = "SELECT relatedassetid, relatedassettype " +
            "FROM CXML_PUBLISHRELATEDASSETRECORD " +
            "WHERE sourceassetid='" + sourceId + "'";
            
        boolean found = false;
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet( sql );
            found = rs.next();
            
            if( found )
            {
                ArrayList<String> list = new ArrayList<String>();
                list.add( rs.getString( 1 ) );
                result.put( rs.getString( 2 ), list );

                while( rs.next() )
                {
                    String id   = rs.getString( 1 );
                    String type = rs.getString( 2 );
                    
                    if( result.get( type ) == null )
                    {
                        list = new ArrayList<String>();
                        list.add( id );
                        result.put( type, list );
                    }
                    else
                    {
                        result.get( type ).add( id );
                    }
                }
            }
           
            if( closeStmt )
            {
                closeStatement();
            }
            
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
        
        return found;    
    }

    
    public boolean hasStructuredDataRelationship(
        String type, String id, LinkedHashMap<String,ArrayList<String>> result )
    {
        return this.hasStructuredDataRelationship( true, type, id, result );
    }

    public boolean hasStructuredDataRelationship(
        boolean closeStmt, String type, String id, 
        LinkedHashMap<String,ArrayList<String>> result )
    {
        String colName = "";
        
        if( type.equals( this.PAGE_TYPE ) )
        {
            colName = "pageid";
        }
        else if( type.equals( this.FILE_TYPE ) )
        {
            colName = "fileid";
        }
        else if( type.equals( this.SYMLINK_TYPE ) )
        {
            colName = "symlinkid";
        }
        else if( type.equals( this.BLOCK_TYPE ) )
        {
            colName = "blockid";
        }
        
        if( colName.equals( "" ) )
            return false;
        
        String sql = "SELECT sd.ownerentityid, f.assettype FROM CXML_STRUCTUREDDATA sd, " +
            "CXML_FOLDERCONTENT f " +
            "WHERE sd." + colName + "='" + id + "' AND sd.ownerentityid=f.id " +
            "AND f.iscurrentversion=1";
            
        boolean found = false;
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet( sql );
            this.populateMap( type, rs, result );
           
            if( closeStmt )
            {
                closeStatement();
            }
            
            found = ( result.size() > 0 );
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
        
        return found;    
    }
    
    public boolean hasTemplateConfigurationSetRelationship(
        String templateId, ArrayList<String> result )
    {
        return this.hasTemplateConfigurationSetRelationship( true, templateId, result );
    }

    public boolean hasTemplateConfigurationSetRelationship(
        boolean closeStmt, String templateId, ArrayList<String> result )
    {
        String sql = "SELECT pageconfigurationsetid FROM CXML_PAGECONFIGURATION " +
            "WHERE templateid='" + templateId + "' " +
            "AND pageconfigurationsetid IN( " +
            "SELECT id FROM CXML_PAGECONFIGURATIONSET WHERE iscurrentversion=1)";

        return populateList( closeStmt, sql, result );
    }

    public void openStatement()
    {
        try
        {
            if( this.conn == null || this.conn.isClosed() )
            {
                this.conn = this.ds.getConnection();
                this.conn.setReadOnly( true );
            }
            
            if( this.stmt == null || this.stmt.isClosed() )
            {
                this.stmt = this.conn.createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY
                );
            }
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
    }
    
    private boolean populateList(
        boolean closeStmt, String sql, ArrayList<String> result
    )
    {
        try
        {
            openStatement();
        
            ResultSet rs = this.getResultSet( sql );
        
            while( rs.next() )
            {
                result.add( rs.getString( 1 ) );
            }
       
            if( closeStmt )
            {
                closeStatement();
            }
        }
        catch( SQLException e )
        {
            System.out.println( e );
        }
        
        return ( result.size() > 0 );    
    }
    
    private void populateMap(
        String type, ResultSet rs, LinkedHashMap<String,ArrayList<String>> result )
        throws SQLException
    {
        if( rs.next() )
        {
            ArrayList<String> list = new ArrayList<String>();
            list.add( rs.getString( 1 ) );
            
            while( rs.next() )
            {
                list.add( rs.getString( 1 ) );
            }
            
            result.put( type, list );
        }
    }
    
    private InitialContext context;
    private DataSource ds;
    private Connection conn;
    private Statement stmt;
}
%>