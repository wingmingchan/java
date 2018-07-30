<%@ include file="ExternalScriptInvoker.jsp" %>

<%! String title = "Test ExternalScriptInvoker"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
ExternalScriptInvoker externalScriptInvoker = new ExternalScriptInvoker(
    "http://web.upstate.edu/chanw/retrieve-tb-name.php?" +    
    "id=85ebedf98b7f08ee6c49236e733d058d" );
    
String result = externalScriptInvoker.invokeExternalScript();
out.println( result );
%>
</body>
</html>