<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test getAssetTags"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
out.println( "<pre>" );

out.println( dbDataProvider.getAssetTags( "1ab0d2d48b7f08ee7e7e4ece7e58ac2a" ) );

out.println( "</pre>" );
%>
</body>
</html>