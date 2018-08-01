<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasDataDefinitionBlockRelationship"; %>
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
dbDataProvider.hasDataDefinitionBlockRelationship(
	"e20fa55d8b7f08ee5b3e46a8b69f3f02", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>