<%@ page import="java.sql.*" %>

<%@ include file="DBDataProvider.jsp" %>

<%! String title = "Test DBDataProvider"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
DBDataProvider dbDataProvider = new DBDataProvider();
out.println( "<pre>" );
/*/
ResultSet rs = dbDataProvider.getResultSet( "SELECT name FROM CXML_GROUP" );
out.println( dbDataProvider.getResultSetRecords( rs ) );
while( rs.next() )
{
	out.println( rs.getString( 1 ) );
}
//out.println( dbDataProvider.getGroupNames() );
//out.println( dbDataProvider.getUserNamesInGroup( "Administrators" ) );
//out.println( dbDataProvider.getFolderChildrenIDs( "a29c1b018b7f0856002a5e113ba198e1" ) );
out.println( dbDataProvider.getAssetAuditsByAction(
	"37a171568b7f0856002a5e115e3a806e", "edit", "publish" ) );
/*/
out.println( dbDataProvider.getAssetId( "FOL", "/_extra/", "formats" ) );
out.println( "</pre>" );
%>
</body>
</html>