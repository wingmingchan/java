<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasMetadataSetContentTypeRelationship"; %>
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
dbDataProvider.hasMetadataSetContentTypeRelationship(
	"4135873a8b7f08ee0ed2ecdaca6a2fa2", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>