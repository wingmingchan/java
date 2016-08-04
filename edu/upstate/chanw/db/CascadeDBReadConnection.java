package edu.upstate.chanw.db;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.xml.sax.InputSource;
import java.sql.*;

public class CascadeDBReadConnection
{
    public static Connection getConnection() throws SQLException
    {
        String url      = "";
        String username = "";
        String password = "";
        String drivers  = "";
        
        try
        {
            String contextPath = System.getProperty( "catalina.home" ) + "/conf/context.xml";
            XPath xpath = XPathFactory.newInstance().newXPath();
            InputSource inputSource = new InputSource( contextPath );
    
            username = xpath.evaluate( "/Context/Resource/@username", inputSource );
            password = xpath.evaluate( "/Context/Resource/@password", inputSource );
            url      = xpath.evaluate( "/Context/Resource/@url", inputSource );
            drivers  = xpath.evaluate( "/Context/Resource/@driverClassName", inputSource );
        }
        catch( XPathExpressionException e )
        {
            // if failed, hard-code the information here
            url      = "";
            username = "";
            password = "";
            drivers  = "";
        }
        
        System.setProperty( "jdbc.drivers", drivers );
        
        return DriverManager.getConnection( url, username, password );
    }
}