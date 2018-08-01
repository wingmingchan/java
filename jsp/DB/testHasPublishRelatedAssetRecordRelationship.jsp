<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasPublishRelatedAssetRecordRelationship"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
LinkedHashMap<String,ArrayList<String>> result =
	new LinkedHashMap<String,ArrayList<String>>();

out.println( "<pre>" );
// from source folder to related publishable assets like folders, pages, files
dbDataProvider.hasPublishRelatedAssetRecordRelationship(
	"9a13bda18b7f08ee5d439b318dba5677", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>