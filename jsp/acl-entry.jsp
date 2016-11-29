<%@ page import="java.sql.*" %>
<%@ page import="edu.upstate.chanw.db.*" %>
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
try
{
	CascadeDB db = new CascadeDB();	
    String sql   = "SELECT * FROM cxml_aclentry WHERE groupName LIKE 'vitality'";                   
    db.executeQuery( sql );
    out.println( db.getTable() );
    db.finalize();
}
catch( SQLException e )
{
    out.println( e );
}
%>
<p><a href="index.jsp">Back to Index</a></p>
</body>
</html>