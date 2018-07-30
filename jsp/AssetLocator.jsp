<%@ page import="com.hannonhill.cascade.velocity.*" %>
<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.home.FolderContainedAsset" %>

<%
final class AssetLocator
{
    public AssetLocator(
        CascadeObjectProvider cascadeObjectProvider,
        DBDataProvider dBDataProvider )
    {
        this.cascadeObjectProvider = cascadeObjectProvider;
        this.dBDataProvider = dBDataProvider;
        this.locatorTool =
            new LocatorTool( "system", cascadeObjectProvider.getServiceProvider() );
    }
    
    public LocatorTool getLocatorTool()
    {
        return this.locatorTool;
    }
    
    public BlockAPIAdapter locateBlock( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "BLO", path, site );
        return this.cascadeObjectProvider.getBlockAPIAdapter( id );
    }
    
    public FileAPIAdapter locateFile( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "FIL", path, site );
        return this.cascadeObjectProvider.getFileAPIAdapter( id );
    }
    
    public FolderAPIAdapter locateFolder( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "FOL", path, site );
        return this.cascadeObjectProvider.getFolderAPIAdapter( id );
    }
    
    public PageAPIAdapter locatePage( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "PAG", path, site );
        return this.cascadeObjectProvider.getPageAPIAdapter( id );
    }
    
    public ReferenceAPIAdapter locateReference( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "REF", path, site );
        return this.cascadeObjectProvider.getReferenceAPIAdapter( id );
    }
    
    public FormatAPIAdapter locateScriptFormat( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "VEL", path, site );
        return this.cascadeObjectProvider.getFormatAPIAdapter( id );
    }
    
    public SiteAPIAdapter locateSite( String site )
    {
        String id = this.dBDataProvider.getSiteId( site );
        return this.cascadeObjectProvider.getSiteAPIAdapter( id );
    }
    
    public SymlinkAPIAdapter locateSymlink( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "SYM", path, site );
        return this.cascadeObjectProvider.getSymlinkAPIAdapter( id );
    }
    
    public TemplateAPIAdapter locateTemplate( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "TEM", path, site );
        return this.cascadeObjectProvider.getTemplateAPIAdapter( id );
    }
    
    public FormatAPIAdapter locateXSLTFormat( String path, String site )
    {
        String id = this.dBDataProvider.getAssetId( "XSL", path, site );
        return this.cascadeObjectProvider.getFormatAPIAdapter( id );
    }

    private CascadeObjectProvider cascadeObjectProvider;
    private DBDataProvider dBDataProvider;
    private LocatorTool locatorTool;
}
%>