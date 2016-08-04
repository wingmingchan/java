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
		
		try
		{
			String contextPath = System.getProperty( "catalina.home" ) + "/conf/context.xml";
			XPath xpath = XPathFactory.newInstance().newXPath();
			InputSource inputSource = new InputSource( contextPath );
	
			username = xpath.evaluate( "/Context/Resource/@username", inputSource );
			password = xpath.evaluate( "/Context/Resource/@password", inputSource );
			url      = xpath.evaluate( "/Context/Resource/@url", inputSource );
			String drivers  = xpath.evaluate( "/Context/Resource/@driverClassName", inputSource );
	      
			if( drivers != null ) 
				System.setProperty( "jdbc.drivers", drivers );
		}
		catch( XPathExpressionException e )
		{
			// if failed, hard-code the information here
			url      = "";
			username = "";
			password = "";
		}
		
		return DriverManager.getConnection( url, username, password );
	}
}
