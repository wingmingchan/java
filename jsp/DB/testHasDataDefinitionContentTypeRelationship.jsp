<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasDataDefinitionContentTypeRelationship"; %>
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
dbDataProvider.hasDataDefinitionContentTypeRelationship(
	"414f24e78b7f08ee0ed2ecda53e3e5bf", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>