<%@ page import="com.hannonhill.cascade.model.service.ServiceProviderHolderBean" %>
<%@ include file = "LoginChecker.jsp" %>

<%! String title = "Test LoginChecker"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
try
{
    LoginInformationBean login =
        ( LoginInformationBean )session.getAttribute( "user" );
    LoginChecker loginChecker = new LoginChecker( login, "Administrators" );
}
catch( LoginCheckerException e )
{
    out.println( e.getMessage() );
}
%>
</body>
</html>