<%@ include file = "functions.jsp" %>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%! String title = "ACL Entry"; %>
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
    String sql = "select * from cxml_aclentry where groupName like 'vitality'";                   
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