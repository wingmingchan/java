<%@ page import="org.jdom.*" %>
<%@ page import="org.jdom.xpath.*" %>
<%@ page import="com.hannonhill.cascade.model.service.*" %>
<%@ include file = "XmlServiceProvider.jsp" %>

<%! String title = "Test XmlServiceProvider"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
XmlServiceProvider xmlServiceProvider = new XmlServiceProvider();

Element root =
    xmlServiceProvider.buildJdomElement( "<system-xml><p>Hello</p></system-xml>" );

out.println( root.getChild( "p" ).getValue() );
out.println( ( (org.jdom.Element)org.jdom.xpath.XPath.selectNodes( root, "p" ).get( 0 ) ).getValue() );
%>
</body>
</html>