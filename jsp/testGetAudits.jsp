<%@ page import="java.sql.*" %>

<%@ include file="CascadeObjectProvider.jsp" %>
<%@ include file="FolderMapProvider.jsp" %>
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

CascadeObjectProvider cascadeObjectProvider = new CascadeObjectProvider();
FolderMapProvider folderMapProvider = new FolderMapProvider( cascadeObjectProvider );
folderMapProvider.addFolderChildren( "3255124b8b7f0856002a5e11f5c25286" ); 
LinkedHashMap<String, FolderContainedAsset> map = folderMapProvider.getMap();

Set<String> aIds = map.keySet();
LinkedHashMap<String, LinkedHashMap<String, ArrayList<ArrayList<String>>>> auditMap =
    new LinkedHashMap<String, LinkedHashMap<String, ArrayList<ArrayList<String>>>>();

for( String key : map.keySet() )
{
    auditMap.put(
        key, dbDataProvider.getAssetAuditsByAction( key, "edit", "publish" ) );
}

out.println( "<pre>" );
out.println( auditMap );
out.println( "</pre>" );
%>
</body>
</html>