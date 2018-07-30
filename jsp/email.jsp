<%@ page import="com.hannonhill.cascade.model.service.*" %>
<%@ page import="com.hannonhill.cascade.email.Email" %>

<%! String title = "Test Email"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
/*//*/
ServiceProvider serviceProvider = ServiceProviderHolderBean.getServiceProvider();
EmailService emailService       = serviceProvider.getEmailService();
Email email = new Email( "chanw@upstate.edu", "Test", "Message from JSP", null, true );
emailService.sendEmail( email );
System.out.println( "Email sent" );
%>
</body>
</html>