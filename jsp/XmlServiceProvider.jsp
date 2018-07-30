<%@ page import="org.jdom.input.SAXBuilder" %>
<%@ page import="org.jdom.*" %>

<%@ page import="java.io.*" %>
<%@ page import="javax.xml.transform.*" %>
<%@ page import="javax.xml.transform.stream.*" %>
<%
final class XmlServiceProvider
{
    public XmlServiceProvider()
    {
        this.saxBuilder = new SAXBuilder();
    }
    
    public Element buildJdomElement( String xml )
    {
        Element root = new Element( "dummy" );
        
        try
        {
            StringReader stringReader = new StringReader( xml );
            root = this.saxBuilder.build( stringReader ).getRootElement();
        }
        catch( JDOMException e )
        {
            System.out.println( e.getMessage() );
        }
        catch( IOException e )
        {
            System.out.println( e.getMessage() );
        }
        
        return root;
    }
    
    public String getTransformedString( String xml, String xsl )
    {
        String transformedString = "";
        StreamSource xslSS = new StreamSource( new StringReader( xsl ) );
        StreamSource xmlSS = new StreamSource( new StringReader( xml ) );
        StringWriter sWriter = new StringWriter();
        StreamResult streamResult = new StreamResult( sWriter );
        
        try
        {
            Transformer transformer =
                TransformerFactory.newInstance().newTransformer( xslSS );
            transformer.transform( xmlSS, streamResult );
            transformedString = sWriter.toString();
        }
        catch( TransformerConfigurationException e )
        {
            System.out.println( e.getMessage() );
        }
        catch( TransformerException e )
        {
            System.out.println( e.getMessage() );
        }
        
        return transformedString;
    }
    
    private SAXBuilder saxBuilder;
}
%>