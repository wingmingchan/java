<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasMetadataSetAssetRelationship"; %>
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
dbDataProvider.hasMetadataSetAssetRelationship(
	"1cd91a998b7f08ee7df4e217a65462b1", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>