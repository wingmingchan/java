<%@ include file = "functions.jsp" %>
<%! String title = "Modify Record"; %>
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
    String sql = "update cxml_foldercontent set isCurrentVersion = 1 where id = "  +
                 "'1f2213cf8b7ffe834c5fe91e5f36b295'";
    stmt.execute( sql );

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