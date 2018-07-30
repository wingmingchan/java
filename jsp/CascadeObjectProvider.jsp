<%@ page import="com.hannonhill.cascade.model.service.*" %>
<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.common.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.common.BaseAsset" %>
<%@ page import="com.hannonhill.cascade.api.asset.common.Identifier" %>
<%@ page import="com.hannonhill.cascade.model.dom.*" %>
<%@ page import="com.hannonhill.cascade.model.dom.identifier.EntityType" %>
<%@ page import="com.hannonhill.cascade.api.operation.Read" %>
<%@ page import="com.hannonhill.cascade.api.operation.result.ReadOperationResult" %>

<%
final class CascadeObjectProvider
{
    public CascadeObjectProvider()
    {
        this.serviceProvider = ServiceProviderHolderBean.getServiceProvider();
    }

    // asset factory
    public AssetFactory getAssetFactory( String id )
    {
        return this.getAssetFactoryService().get( id );
    }
    
    public AssetFactoryAPIAdapter getAssetFactoryAPIAdapter( String id )
    {
        return ( AssetFactoryAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getAssetFactory( id ), true, this.serviceProvider );
    }
    
    public AssetFactoryService getAssetFactoryService()
    {
        return this.serviceProvider.getAssetFactoryService();
    }
    
    // block
    public Block getBlock( String id )
    {
        return this.getBlockService().get( id );
    }
    
    public BlockAPIAdapter getBlockAPIAdapter( String id )
    {
        return ( BlockAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getBlock( id ), true, this.serviceProvider );
    }
    
    public BlockService getBlockService()
    {
        return this.serviceProvider.getBlockService();
    }
    
    // content type
    public ContentType getContentType( Page p )
    {
        return this.serviceProvider.getContentTypeService().get(
            p.getContentType().getId()
        );
    }
    
    public ContentTypeService getContentTypeService()
    {
        return this.serviceProvider.getContentTypeService();
    }
    
    // data definition
    public StructuredDataDefinition getStructuredDataDefinition( Page p )
    {
        return this.getStructuredDataDefinitionService().get(
            this.getContentType( p ).getStructuredDataDefinition().getId()
        );
    }
    
    public StructuredDataDefinitionService getStructuredDataDefinitionService()
    {
        return this.serviceProvider.getStructuredDataDefinitionService();
    }

    // destination
    public Destination getDestination( String id )
    {
        return this.getDestinationService().get( id );
    }
    
    public DestinationAPIAdapter getDestinationAPIAdapter( String id )
    {
        return ( DestinationAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getDestination( id ), true, this.serviceProvider );
    }
    
    public DestinationService getDestinationService()
    {
        return this.serviceProvider.getDestinationService();
    }
    
    // destination container
    public DestinationContainer getDestinationContainer( String id )
    {
        return this.getDestinationContainerService().get( id );
    }
    
    public DestinationContainerAPIAdapter getDestinationContainerAPIAdapter( String id )
    {
        return ( DestinationContainerAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getDestinationContainer( id ), true, this.serviceProvider );
    }
    
    public SiteDestinationContainerService getDestinationContainerService()
    {
        return this.serviceProvider.getDestinationContainerService();
    }
    
    // file
    public File getFile( String id )
    {
        return this.getFileService().get( id );
    }
    
    public FileAPIAdapter getFileAPIAdapter( String id )
    {
        return ( FileAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getFile( id ), true, this.serviceProvider );
    }
    
    public FileService getFileService()
    {
        return this.serviceProvider.getFileService();
    }
    
    // folder
    public Folder getFolder( String id )
    {
        return this.getFolderService().get( id );
    }
    
    public FolderAPIAdapter getFolderAPIAdapter( String id )
    {
        return ( FolderAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getFolder( id ), true, this.serviceProvider );
    }
    
    public FolderService getFolderService()
    {
        return this.serviceProvider.getFolderService();
    }
    
    // format
    public Format getFormat( String id )
    {
        return this.getFormatService().get( id );
    }
    
    public FormatAPIAdapter getFormatAPIAdapter( String id )
    {
        return ( FormatAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getFormat( id ), true, this.serviceProvider );
    }
    
    public FormatService getFormatService()
    {
        return this.serviceProvider.getFormatService();
    }
    
    // metadata set
    public MetadataSet getMetadataSet( Page p )
    {
        return this.getMetadataSetService().get(
            this.getContentType( p ).getMetadataSet().getId()
        );
    }
    
    public MetadataSetService getMetadataSetService()
    {
        return this.serviceProvider.getMetadataSetService();
    }
 
    // page
    public Page getPage( String id )
    {
        return this.getPageService().get( id );
    }
    
    public PageAPIAdapter getPageAPIAdapter( String id )
    {
        return ( PageAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getPage( id ), true, this.serviceProvider );
    }
    
    public PageService getPageService()
    {
        return this.serviceProvider.getPageService();
    }
    
    // page configuration
    public PageConfiguration getDefaultPageConfiguration( Page p )
    {
        return this.getPageConfigurationService().get(
            this.getPageConfigurationSet( p ).getDefaultConfiguration().getId()
        );
    }
    
    public PageConfiguration getPageConfiguration( String id )
    {
        return this.getPageConfigurationService().get( id );
    }
    
    public PageConfigurationAPIAdapter getPageConfigurationAPIAdapter( String id )
    {
        return ( PageConfigurationAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getPageConfiguration( id ), true, this.serviceProvider );
    }
    
    public PageConfigurationService getPageConfigurationService()
    {
        return this.serviceProvider.getPageConfigurationService();
    }
            
    // page configuration set
    public PageConfigurationSet getPageConfigurationSet( Page p )
    {
        return this.getPageConfigurationSetService().get(
            this.getContentType( p ).getPageConfigurationSet().getId()
        );
    }
    
    public PageConfigurationSetService getPageConfigurationSetService()
    {
        return this.serviceProvider.getPageConfigurationSetService();
    }
        
    // preferences
    public PreferencesService getPreferencesService()
    {
        return this.serviceProvider.getPreferencesService();
    }
    
    public BaseAsset getReadBaseAsset( String id, EntityType type ) throws Exception
    {
        Read read = new Read();
        CustomIdentifier cid = new CustomIdentifier();
        cid.setId( id );
        cid.setType( type );
        read.setToRead( cid );
        read.setUsername( "system" );
        ReadOperationResult result = ( ReadOperationResult )read.perform();
        return result.getAsset();
    }
    
    // reference, the type is ambiguous, hence the full name
    public com.hannonhill.cascade.model.dom.Reference getReference( String id )
    {
        return this.getReferenceService().get( id );
    }
    
    public ReferenceAPIAdapter getReferenceAPIAdapter( String id )
    {
        return ( ReferenceAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getReference( id ), true, this.serviceProvider );
    }
 
    public ReferenceService getReferenceService()
    {
        return this.serviceProvider.getReferenceService();
    }
    
    // site
    public Site getSite( String id )
    {
        return this.getSiteService().get( id );
    }
    
    public Site getSiteByName( String name )
    {
        return this.getSiteService().getByName( name );
    }
    
    public SiteAPIAdapter getSiteAPIAdapter( String id )
    {
        return ( SiteAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getSite( id ), true, this.serviceProvider );
    }
    
    public SiteAPIAdapter getSiteAPIAdapterByName( String name )
    {
        return ( SiteAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getSiteByName( name ), true, this.serviceProvider );
    }
    
    public SiteService getSiteService()
    {
        return this.serviceProvider.getSiteService();
    }
    
    // symlink
    public Symlink getSymlink( String id )
    {
        return this.getSymlinkService().get( id );
    }
    
    public SymlinkAPIAdapter getSymlinkAPIAdapter( String id )
    {
        return ( SymlinkAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getSymlink( id ), true, this.serviceProvider );
    }
    
    public SymlinkService getSymlinkService()
    {
        return this.serviceProvider.getSymlinkService();
    }
    
    // template
    public Template getTemplate( String id )
    {
        return this.getTemplateService().get( id );
    }
    
    public TemplateAPIAdapter getTemplateAPIAdapter( String id )
    {
        return ( TemplateAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getTemplate( id ), true, this.serviceProvider );
    }
    
    public TemplateService getTemplateService()
    {
        return this.serviceProvider.getTemplateService();
    }
    
    // transport
    public Transport getTransport( String id )
    {
        return this.getTransportService().get( id );
    }
    
    public FTPTransportAPIAdapter getFTPTransportAPIAdapter( String id )
    {
        return ( FTPTransportAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getTransport( id ), true, this.serviceProvider );
    }
    
    public TransportService getTransportService()
    {
        return this.serviceProvider.getTransportService();
    }

    // user
    public User getUser( String id )
    {
        return this.getUserService().get( id );
    }
    
    public UserAPIAdapter getUserAPIAdapter( String id )
    {
        return ( UserAPIAdapter )APIAdapterFactory.createAPIAdapter(
            this.getUser( id ), true, this.serviceProvider );
    }
    
    public UserService getUserService()
    {
        return this.serviceProvider.getUserService();
    }
    
    public ServiceProvider getServiceProvider()
    {
        return this.serviceProvider;
    }
    
    public CustomIdentifier getCustomIdentifier()
    {
        return new CustomIdentifier();
    }
    
    final class CustomIdentifier implements Identifier
    {        
        public String getId() 
        {
            return this.id;
        }

        public EntityType getType()
        {
            return this.type;
        }

        public void setId( String id )
        {
            this.id = id;
        }

        public void setType( EntityType type )
        {
            this.type = type;
        }

        private String id;
        private EntityType type;
    }

    private ServiceProvider serviceProvider;
}
%>