<%@ page import="java.util.*" %>

<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.home.FolderContainedAsset" %>

<%
final class FolderMapProvider
{
    public FolderMapProvider( CascadeObjectProvider cascadeObjectProvider )
    {
        this.cascadeObjectProvider = cascadeObjectProvider;
        this.idAssetMap = new LinkedHashMap<String, FolderContainedAsset>();
    }
    public void addFolderChildren( String fid )
    {
        FolderAPIAdapter folder = this.cascadeObjectProvider.getFolderAPIAdapter( fid );
        this.idAssetMap.put( folder.getIdentifier().getId(), folder );
        this.addFolderChildrenHelper( folder, this.idAssetMap );
    }

    
    public LinkedHashMap<String, FolderContainedAsset> getMap()
    {
        return this.idAssetMap;
    }
    
    private void addFolderChildrenHelper(
        FolderAPIAdapter folder, LinkedHashMap<String, FolderContainedAsset> map )
    {
        List<FolderContainedAsset> children = folder.getChildren();
        String folderId = folder.getIdentifier().getId();
        
        if( children.size() > 0 )
        {
            for( FolderContainedAsset child : children )
            {
                map.put( child.getIdentifier().getId(), child );
                
                if( child instanceof FolderAPIAdapter )
                {
                    this.addFolderChildrenHelper( (FolderAPIAdapter)child, map );
                }
            }
        }
    }

    private CascadeObjectProvider cascadeObjectProvider;
    private LinkedHashMap<String, FolderContainedAsset> idAssetMap;
}
%>