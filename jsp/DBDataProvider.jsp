<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>

<%
final class DBDataProvider
{
    public final String GET_GROUP_NAMES_STATEMENT = "SELECT name FROM CXML_GROUP";
    public final String GET_USER_NAMES_STATEMENT  = "SELECT username FROM CXML_USER";
    public final String GET_USER_NAMES_IN_GROUP_STATEMENT  = 
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
   
    public ArrayList<String> getFolderChildrenIDs( String fid )
    {
        return this.getFolderChildrenIDs( true, fid );
    }
    
    public ArrayList<String> getFolderChildrenIDs( boolean closeStmt, String fid )
    {
        ArrayList<String> childrenIDs = new ArrayList<String>();
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet(
                this.GET_FOLDER_CHILDREN_IDS_STATEMENT.replace( "%f", fid ) );
            
            while( rs.next() )
            {
                childrenIDs.add( rs.getString( 1 ) );
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
        
        return childrenIDs;
    }
    
    
    public ArrayList<String> getGroupNames()
    {
        return this.getGroupNames( true );
    }
    
    public ArrayList<String> getGroupNames( boolean closeStmt )
    {
        ArrayList<String> groupNames = new ArrayList<String>();
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet( this.GET_GROUP_NAMES_STATEMENT );
            
            while( rs.next() )
            {
                groupNames.add( rs.getString( 1 ) );
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

    public ArrayList<String> getUserNames()
    {
        return this.getUserNames( true );
    }

    public ArrayList<String> getUserNames( boolean closeStmt )
    {
        ArrayList<String> usernames = new ArrayList<String>();
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet( this.GET_USER_NAMES_STATEMENT );
            
            while( rs.next() )
            {
                usernames.add( rs.getString( 1 ) );
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
        
        return usernames;
    }

    public ArrayList<String> getUserNamesInGroup( String g )
    {
        return this.getUserNamesInGroup( true, g );
    }

    public ArrayList<String> getUserNamesInGroup( boolean closeStmt, String g )
    {
        ArrayList<String> usernames = new ArrayList<String>();
        
        try
        {
            openStatement();
            
            ResultSet rs = this.getResultSet(
                this.GET_USER_NAMES_IN_GROUP_STATEMENT.replace( "%g", g ) );
            
            while( rs.next() )
            {
                usernames.add( rs.getString( 1 ) );
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
        
        return usernames;
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
    
    private InitialContext context;
    private DataSource ds;
    private Connection conn;
    private Statement stmt;
}
%>