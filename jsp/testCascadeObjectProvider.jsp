<%@ page import="com.hannonhill.cascade.model.dom.*" %>
<%@ page import="com.hannonhill.cascade.api.adapters.*" %>
<%@ page import="com.hannonhill.cascade.api.asset.common.BaseAsset" %>
<%@ page import="com.hannonhill.cascade.model.dom.identifier.EntityTypes" %>

<%@ include file="CascadeObjectProvider.jsp" %>

<%! String title = "Test CascadeObjectProvider"; %>
<html>
<head>
<title><% out.print( title ); %></title>
<link href="http://www.upstate.edu/assets/global.css" 
    media="all" rel="stylesheet" type="text/css"/>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
CascadeObjectProvider cascadeObjectProvider = new CascadeObjectProvider();
/*/
/*/
Object obj = cascadeObjectProvider.getUserAPIAdapter( "chanw" );
//Object obj = cascadeObjectProvider.getSiteAPIAdapterByName( "formats" );
out.println( obj );
/*//*/

Page pageDom = cascadeObjectProvider.getPage( "275f515a8b7f08ee5668fbfd3fe3e766" );
ContentType ct = cascadeObjectProvider.getContentType( pageDom );
PageConfigurationSet pcs = cascadeObjectProvider.getPageConfigurationSet( pageDom );
PageConfiguration pc = cascadeObjectProvider.getDefaultPageConfiguration( pageDom );
MetadataSet ms = cascadeObjectProvider.getMetadataSet( pageDom );
StructuredDataDefinition dd = cascadeObjectProvider.getStructuredDataDefinition( pageDom );

out.println( dd.getXml() );

BaseAsset a = cascadeObjectProvider.getReadBaseAsset(
    "275f515a8b7f08ee5668fbfd3fe3e766", EntityTypes.TYPE_PAGE );
out.println( a );
%>
</body>
</html>