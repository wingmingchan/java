<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%!
Context context = null;
DataSource ds   = null;
Connection conn = null;

Statement initialize( Statement stmt )
{
    try
    {
        context = new InitialContext();
        ds      = ( DataSource )
            ( ( Context ) context.lookup( "java:comp/env" ) ).lookup( "jdbc/CascadeDS" );
        conn    = ds.getConnection();
        stmt    = conn.createStatement( 
            ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
    }
    catch( SQLException e ){ System.out.println( e ); }
    catch( NamingException e ){ System.out.println( e ); }
    
    return stmt;
}

String getTable( ResultSet rs )
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
    catch( SQLException e ){ System.out.println( e ); }
    
    return tableString.toString();
}

void finalize( ResultSet rs, Statement stmt )
{
    try
    {
       if( rs != null )
           rs.close();
    }
    catch( SQLException e ){ System.out.println( e ); }

    try
    {
       if( stmt != null )
           stmt.close();
    }
    catch( SQLException e ){ System.out.println( e ); }
    
    try
    {
        if( conn != null )
            conn.close();
    }
    catch( SQLException e ){ System.out.println( e ); }
}
%>