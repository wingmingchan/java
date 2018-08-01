<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasStructuredDataRelationship"; %>
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

// from block to consumer pages or blocks
dbDataProvider.hasStructuredDataRelationship(
	DBDataProvider.BLOCK_TYPE, "9e0f94978b7f08ee30f79ea3b9b1f469", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>