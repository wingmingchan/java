<%@ page import="com.hannonhill.cascade.model.dom.identifier.EntityTypes" %>
<%@ page import="com.hannonhill.cascade.velocity.*" %>
<%@ page import="com.hannonhill.cascade.api.adapters.*" %>

<%@ include file="CascadeObjectProvider.jsp" %>
<%@ include file="DBDataProvider.jsp" %>
<%@ include file="AssetLocator.jsp" %>

<%! String title = "Test AssetLocator"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
CascadeObjectProvider cascadeObjectProvider = new CascadeObjectProvider();
DBDataProvider dBDataProvider = new DBDataProvider();
AssetLocator assetLocator = new AssetLocator( cascadeObjectProvider, dBDataProvider );

/*
*/
//BlockAPIAdapter objAPI = assetLocator.locateBlock( "_cascade/blocks/code/about-index-top-movie-text", "formats" );
//FileAPIAdapter objAPI = assetLocator.locateFile( "/_extra/about.mp4", "formats" );
//FolderAPIAdapter objAPI = assetLocator.locateFolder( "/", "formats" );
//PageAPIAdapter objAPI = assetLocator.locatePage( "velocity/index", "formats" );
//ReferenceAPIAdapter objAPI = assetLocator.locateReference( "velocity/formats-index", "formats" );
//SymlinkAPIAdapter objAPI = assetLocator.locateSymlink( "cascade-admin", "formats" );
//TemplateAPIAdapter objAPI = assetLocator.locateTemplate( "core/xml", "_brisk" );
//FormatAPIAdapter objAPI = assetLocator.locateScriptFormat( "core/startup", "_brisk" );
//FormatAPIAdapter objAPI = assetLocator.locateXSLTFormat( "core/page-template", "_brisk" );
//SiteAPIAdapter objAPI = assetLocator.locateSite( "_brisk" );

//out.println( objAPI.getClass().getName() );

LocatorTool locatorTool = assetLocator.getLocatorTool();
BlockAPIAdapter objAPI = ( BlockAPIAdapter )locatorTool.locateBlock(
    "_cascade/blocks/code/about-index-top-movie-text", "formats" );
    
out.println( ( locatorTool )  );
out.println( objAPI.getClass().getName() );
%>
</body>
</html>