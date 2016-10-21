<%@ include file = "functions.jsp" %>
<%! String title = "Record Count of All Tables"; %>
<html>
<head>
<title><% out.print( title ); %></title>
<link href="http://www.upstate.edu/assets/global.css" 
    media="all" rel="stylesheet" type="text/css"/>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>

<%
Statement stmt = null;
ResultSet rs   = null;

try
{
    stmt       = initialize( stmt );
    String sql = "SELECT table_name FROM all_tables " +
                 "WHERE tablespace_name LIKE 'C%' " +
                 "AND table_name like 'CXML_%' " +
                 "ORDER BY table_name";

    rs         = stmt.executeQuery( sql );
    
    if( rs.next() )
    {
        rs.beforeFirst();
        
        while( rs.next() )
        {
            ResultSet subRs   = null;
            Statement subStmt = null;
            String tableName  = rs.getString( 1 );
            String subSql     = "SELECT count(*) Count FROM " + tableName;
            
            subStmt = initialize( subStmt );
            subRs   = subStmt.executeQuery( subSql );
            out.println( "<h2>" + tableName + "</h2>" );
            out.println( getTable( subRs ) + "<hr />" );
            
            if( subRs != null )
                subRs.close();
                
            if( subStmt != null )
                subStmt.close();
        }
    }
    
    finalize( rs, stmt );
}
catch( SQLException e )
{
    out.println( "Error: " + e );
}
%>
<p><a href="index.jsp">Back to Index</a></p>
</body>
</html>