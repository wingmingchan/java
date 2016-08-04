package edu.upstate.chanw.db;

import java.sql.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import org.xml.sax.InputSource;

/*
All database-specific information has been removed from this class.
Therefore, there are only a few methods left.
*/

public class CascadeDB
{
	public CascadeDB() throws SQLException
	{
		try
		{
			conn            = CascadeDBReadConnection.getConnection();
			stat            = conn.createStatement( 
							      ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
			result          = null;
		}
		catch( SQLException e )
		{
			System.out.println( "Printing from CascadeDBReadConnection " + e.getMessage() );
			throw e;
		}
	}
	
	@Override
	public void finalize() throws Exception
	{
		stat.close();
		conn.close();
		result          = null;
	}

	public Document getDataAsDocument( String sql ) throws Exception
	{
		result = stat.executeQuery( sql );
		String xmlString = "<records>";
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ResultSetMetaData rsmd = result.getMetaData();
		int columnsNumber = rsmd.getColumnCount();
		
		while( result.next() )
		{
			String temp = "<record>";
			
			for( int i = 1; i <= columnsNumber; i++ )
			{
				String temp1 = "<item>" + result.getString( i ) + "</item>";
				temp += temp1;
			}
			
			temp += "</record>";
			xmlString += temp;
		}
		
		xmlString += "</records>";
		
		InputSource is = new InputSource( new java.io.StringReader( xmlString ) );
		Document dom   = builder.parse( is );
		
		return dom;
	}

	public ResultSet getResultSet( String sql ) throws SQLException
	{
		result = null;
		result = stat.executeQuery( sql );
		return result;
	}
	
	private Connection conn;
	private Statement stat;
	private ResultSet result;
}