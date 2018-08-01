<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasConfigurationSetContentTypeRelationship"; %>
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
dbDataProvider.hasConfigurationSetContentTypeRelationship(
	"421cac528b7f08ee0ed2ecda4e87e277", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>