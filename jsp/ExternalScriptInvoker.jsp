<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%
final class ExternalScriptInvoker
{
    public ExternalScriptInvoker( String url ) throws Exception
    {
        if( url.trim().equals( "" ) )
        {
            throw new Exception( "The URL cannot be empty." );
        }
        
        this.urlString   = url.trim();
        
        // Open connection
        URL urlObj      = new URL( this.urlString );
        this.connection = ( HttpURLConnection )urlObj.openConnection();
        this.connection.setDoOutput( true );
        this.connection.setRequestMethod( "POST" ); 
        this.connection.setRequestProperty(
            "Content-Type", "application/x-www-form-urlencoded" ); 
        this.connection.setRequestProperty( "charset", "utf-8" );
        this.connection.setRequestProperty( "Content-Length", "" );
    }
    
    public String invokeExternalScript() throws Exception
    {
        // Send request
        OutputStreamWriter writer = new OutputStreamWriter( this.connection.getOutputStream() );
        writer.flush();
        writer.close();
        
        // Read response
        InputStreamReader reader = new InputStreamReader( this.connection.getInputStream() );
        int data = reader.read();
        StringBuffer buffer = new StringBuffer( 1000 );
        
        while( data != -1 )
        {
            buffer.append( ( char )data );
            data = reader.read();
        }
        reader.close();
        return buffer.toString();
    }

    private String urlString;
    private HttpURLConnection connection;
}
%>