package edu.upstate.chanw.db;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.w3c.dom.*;

//import javax.naming.NamingException;
import javax.xml.parsers.*;
import org.xml.sax.InputSource;

public class CascadeDB
{
    public CascadeDB() throws SQLException, NamingException
    {
        try
        {
            context = new InitialContext();            
            ds = ( DataSource )
                    ( ( Context ) context.lookup( "java:comp/env" ) ).lookup( "jdbc/CascadeDS" );
            conn    = ds.getConnection();
            stmt = conn.createStatement( 
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );            
        }
        catch( SQLException e ){ throw e; }
        catch( NamingException e ){ throw e; }
    }
    
    public void executeQuery( String sql ) throws SQLException
    {
        try
        {
            rs = stmt.executeQuery( sql );
        }
        catch( SQLException e )
        {
            throw e;
        }
    }
    
    public String getTable() throws SQLException
    {
        StringBuffer tableString = new StringBuffer();
        int counter = 0;
        
        try
        {
            if( rs.next() )
            {
                ResultSetMetaData m = rs.getMetaData();
                int columnCount     = m.getColumnCount();
        
                tableString.append(
                    "<table class='tcellspacing1 tcellpadding5' summary='Table'>" );
                tableString.append( "<tr class='bg1 text_white'>" );
        
                for( int i = 1; i <= columnCount; i++ )
                    tableString.append( "<th>" + m.getColumnName( i ) + "</th>" );

                tableString.append( "</tr>" );
        
                rs.beforeFirst();
        
                while( rs.next() )
                {
                    if( counter % 2 == 0 )
                        tableString.append( "<tr>" );
                    else
                        tableString.append( "<tr class='tablerow1'>" );
            
                    for( int i = 1; i <= columnCount; i++ )
                        tableString.append( "<td>" + rs.getString( i ) + "</td>" );
            
                    tableString.append( "</tr>" );
                    counter++;
                }

                tableString.append( "</table>" );
            }
        }
        catch( SQLException e ){ throw e; }
        
        return tableString.toString();
    }
    
    @Override
    public void finalize() throws SQLException
    {
        try
        {
           if( rs != null )
               rs.close();
        }
        catch( SQLException e ){ throw e; }

        try
        {
           if( stmt != null )
               stmt.close();
        }
        catch( SQLException e ){ throw e; }
        
        try
        {
            if( conn != null )
                conn.close();
        }
        catch( SQLException e ){ throw e; }
    }
    
    public Document getDataAsDocument( String sql ) throws Exception
    {
        rs = stmt.executeQuery( sql );
        String xmlString = "<records>";
        
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnsNumber = rsmd.getColumnCount();
        
        while( rs.next() )
        {
            String temp = "<record>";
            
            for( int i = 1; i <= columnsNumber; i++ )
            {
                String temp1 = "<item>" + rs.getString( i ) + "</item>";
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
        rs = stmt.executeQuery( sql );
        return rs;
    }
    
/*    
    public Statement getStatement() throws SQLException
    {
        return stmt;
    }
*/
    private InitialContext context;
    private Connection conn;
    private DataSource ds;
    private Statement stmt;
    private ResultSet rs;

}
