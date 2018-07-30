<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.home.FolderContainedAsset" %>

<%@ include file="CascadeObjectProvider.jsp" %>
<%@ include file="FolderTreeProvider.jsp" %>

<%! String title = "Test FolderTreeProvider"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body>
<h1><% out.print( title ); %></h1>
<%
CascadeObjectProvider cascadeObjectProvider = new CascadeObjectProvider();
FolderAPIAdapter folder =
    cascadeObjectProvider.getFolderAPIAdapter( "3255124b8b7f0856002a5e11f5c25286" );
FolderTreeProvider folderTreeProvider = new FolderTreeProvider( cascadeObjectProvider );
folderTreeProvider.addFolderChildren( "3255124b8b7f0856002a5e11f5c25286" ); 
DefaultMutableTreeNode tree = folderTreeProvider.getTree();

out.println( "<pre>" );
for( Enumeration<DefaultMutableTreeNode> nodeList =
    tree.preorderEnumeration(); nodeList.hasMoreElements(); )
{
    FolderContainedAsset folderContainedAsset =
        ( FolderContainedAsset )nodeList.nextElement().getUserObject();
    out.println( folderContainedAsset.getIdentifer().getId() + " : " +
        folderContainedAsset.getIdentifer().getType() );
}
out.println( "</pre>" ); 
%>
</body>
</html>