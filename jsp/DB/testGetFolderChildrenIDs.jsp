<%@ page import="java.sql.*" %>

<%@ include file="../DBDataProvider.jsp" %>

<%! String title = "Test getFolderChildrenIDs"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
out.println( "<pre>" );

out.println( dbDataProvider.getFolderChildrenIDs( "a29c1b018b7f0856002a5e113ba198e1" ) );

out.println( "</pre>" );
%>
</body>
</html>