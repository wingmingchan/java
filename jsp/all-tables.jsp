<%@ include file = "functions.jsp" %>
<%! String title = "All Tables"; %>
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
    initialize( stmt );
    String sql = "SELECT tablespace_name, table_name FROM all_tables " +
                 "WHERE tablespace_name LIKE 'C%' " +
                 "AND table_name like 'CXML_%' " +
                 "ORDER BY table_name";

    rs         = stmt.executeQuery( sql );
    out.println( getTable( rs ) );
    finalize( rs, stmt );
}
catch( SQLException e )
{
    out.println( e );
}
%>
<p><a href="index.jsp">Back to Index</a></p>
</body>
</html>