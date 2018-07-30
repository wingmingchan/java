<%@ include file = "XmlServiceProvider.jsp" %>

<%! String title = "Test XSLT"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
XmlServiceProvider xmlServiceProvider = new XmlServiceProvider();

String books = "<books>" +
    "<book>" + 
    "<name>My Book</name><author>John Doe</author>" +
    "</book>" +
    "</books>";

String xsl = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>" +
    "<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" " + 
    "version=\"1.0\">" +
    "<xsl:output indent=\"yes\" method=\"xml\" omit-xml-declaration=\"yes\"/>" +
    "<xsl:template match=\"books\">" +
    "<p>" + "<xsl:apply-templates select=\"//name | //author\"/>" + "</p>" +
    "</xsl:template>" + 
    "<xsl:template match=\"author\">" +
    "<strong><xsl:value-of select=\".\"/></strong>" +
    "</xsl:template>" +
    "<xsl:template match=\"name\">" +
    "<em><xsl:value-of select=\".\"/></em> BY " +
    "</xsl:template>" +
    "</xsl:stylesheet>";

out.println( xmlServiceProvider.getTransformedString( books, xsl ) );
%>
</body>
</html>