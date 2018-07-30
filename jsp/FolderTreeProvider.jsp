<%@ page import="javax.swing.tree.DefaultMutableTreeNode" %>
<%@ page import="java.util.*" %>

<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.home.FolderContainedAsset" %>

<%
final class FolderTreeProvider
{
    public FolderTreeProvider( CascadeObjectProvider cascadeObjectProvider )
    {
        this.root = new DefaultMutableTreeNode();
        this.cascadeObjectProvider = cascadeObjectProvider;
        this.keyNodeMap = new LinkedHashMap<String, DefaultMutableTreeNode>();
    }
    
    public void addFolderChildren( String fid )
    {
        FolderAPIAdapter folder = this.cascadeObjectProvider.getFolderAPIAdapter( fid );
        this.root.setUserObject( folder );
        this.keyNodeMap.put( folder.getIdentifier().getId(), this.root );
        this.addFolderChildrenHelper( folder, this.root, this.keyNodeMap );
    }
    
    public DefaultMutableTreeNode getTree()
    {
        return this.root;
    }
    
    private void addFolderChildrenHelper(
        FolderAPIAdapter folder, DefaultMutableTreeNode tree, 
        LinkedHashMap<String, DefaultMutableTreeNode> map )
    {
        List<FolderContainedAsset> children = folder.getChildren();
        String folderId = folder.getIdentifier().getId();
        DefaultMutableTreeNode folderNode = map.get( folderId );
        
        if( children.size() > 0 )
        {
            for( FolderContainedAsset child : children )
            {
                DefaultMutableTreeNode newChildNode = new DefaultMutableTreeNode( child );
                folderNode.add( newChildNode );
                map.put( child.getIdentifier().getId(), newChildNode );
                
                if( child instanceof FolderAPIAdapter )
                {
                    this.addFolderChildrenHelper( (FolderAPIAdapter)child, tree, map );
                }
            }
        }
    }

    private DefaultMutableTreeNode root;
    private CascadeObjectProvider cascadeObjectProvider;
    private LinkedHashMap<String, DefaultMutableTreeNode> keyNodeMap;
}
%>