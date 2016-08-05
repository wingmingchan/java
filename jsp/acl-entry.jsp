<%@ page import="edu.upstate.chanw.db.*" %>
<%@ page import="java.sql.*" %>
<%! String title = "ACL Entry"; %>
<html>
<head>
<title><% out.print( title ); %></title>
<link href="http://www.upstate.edu/assets/global.css" 
    media="all" rel="stylesheet" type="text/css"/>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
String sql   = "select * from cxml_aclentry where groupName like 'vitality' ";

CascadeDB db = new CascadeDB();
ResultSet rs = db.getResultSet( sql );

if( rs.next() )
{
    ResultSetMetaData m = rs.getMetaData();
    int columnCount     = m.getColumnCount();
    
    out.println( "<table class='tcellspacing1 tcellpadding5' summary='Table'>" );
    out.print( "<tr class='bg1 text_white'>" );
    
    for( int i = 1; i <= columnCount; i++ )
        out.print( "<th>" + m.getColumnName( i ) + "</th>" );

    out.print( "</tr>" );
    
    // move cursor back
    rs.beforeFirst();

    while( rs.next() )
    {
        out.print( "<tr>" );
        
        for( int i = 1; i <= columnCount; i++ )
            out.print( "<td>" + rs.getString( i ) + "</td>" );
        
        out.println( "</tr>" );
    }

    out.println( "</table>" );
}
%>
<p><a href="index.jsp">Back to Index</a></p>
</body>
</html>