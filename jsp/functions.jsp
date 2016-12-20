<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%!
Context context = null;
DataSource ds   = null;
Connection conn = null;

Statement initialize( Statement stmt ) throws SQLException, NamingException
{
    context = new InitialContext();
    ds      = ( DataSource )
              ( ( Context ) context.lookup( "java:comp/env" ) ).lookup(
              "jdbc/CascadeDS" );
    conn    = ds.getConnection();
    stmt    = conn.createStatement(
              ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
    
    return stmt;
}

String getTable( ResultSet rs ) throws SQLException
{
    StringBuffer tableString = new StringBuffer();
    int counter = 0;
    
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
    
    return tableString.toString();
}

void finalize( ResultSet rs, Statement stmt ) throws SQLException
{
    if( rs != null )
        rs.close();
           
    if( stmt != null )
        stmt.close();
    
    if( conn != null )
        conn.close();
}
%>