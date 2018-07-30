<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.home.FolderContainedAsset" %>

<%@ include file="CascadeObjectProvider.jsp" %>
<%@ include file="FolderMapProvider.jsp" %>

<%! String title = "Test FolderMapProvider"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
CascadeObjectProvider cascadeObjectProvider = new CascadeObjectProvider();
FolderMapProvider folderMapProvider = new FolderMapProvider( cascadeObjectProvider );

folderMapProvider.addFolderChildren( "3255124b8b7f0856002a5e11f5c25286" ); 
LinkedHashMap<String, FolderContainedAsset> map = folderMapProvider.getMap();

/*//*/
out.println( "<pre>" );
for( String key : map.keySet() )
{
    FolderContainedAsset folderContainedAsset =
        ( FolderContainedAsset )map.get( key );
    out.println( folderContainedAsset.getIdentifer().getId() + " : " +
        folderContainedAsset.getIdentifer().getType() );
}
out.println( "</pre>" ); 
%>
</body>
</html>