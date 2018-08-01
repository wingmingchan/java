<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test getUserNamesInGroup"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
out.println( "<pre>" );
out.println( dbDataProvider.getUserNamesInGroup( "Administrators" ) );
out.println( "</pre>" );
%>
</body>
</html>