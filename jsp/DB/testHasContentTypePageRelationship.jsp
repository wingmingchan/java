<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasContentTypePageRelationship"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
ArrayList<String> result = new ArrayList<String>();

out.println( "<pre>" );
dbDataProvider.hasContentTypePageRelationship(
	"4224297e8b7f08ee0ed2ecda7b51db59", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>