<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test hasTemplateConfigurationSetRelationship"; %>
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
// from template to configuration sets
// 1db71c3f8b7f08ee7df4e217fd764404: xml template
// 421cac528b7f08ee0ed2ecda4e87e277: Page configuration set
dbDataProvider.hasTemplateConfigurationSetRelationship(
	"1db71c3f8b7f08ee7df4e217fd764404", result );

out.println( result );
out.println( "</pre>" );
%>
</body>
</html>