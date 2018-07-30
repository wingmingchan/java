<%@ page import="com.hannonhill.cascade.api.operation.Publish" %>
<%@ page import="com.hannonhill.cascade.api.operation.result.*" %>
<%@ page import="com.hannonhill.cascade.model.dom.identifier.EntityTypes" %>
<%@ page import="edu.upstate.chanw.plugin.publishtrigger.CustomIdentifier" %>

<%! String title = "Test Publish"; %>
<html>
<head>
<title><% out.print( title ); %></title>
</head>
<body class="bg_white">
<h1><% out.print( title ); %></h1>
<%
CustomIdentifier id = new CustomIdentifier();
id.setId( "8953824d8b7f08ee282259f09d38cf3f" );
id.setType( EntityTypes.TYPE_PAGE );

Publish publish = new Publish();
publish.setToPublish( id );
publish.setUsername( "chanw" );
publish.setMode( "publish" );
publish.perform();
%>
</body>
</html>