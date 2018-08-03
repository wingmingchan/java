<%@ page import="com.hannonhill.cascade.model.service.ServiceProviderHolderBean" %>
<%@ page import="com.hannonhill.cascade.view.beans.security.LoginInformationBean" %>
<%@ include file = "LoginCheckerException.jsp" %>
<%
final class LoginChecker
{
    public LoginChecker( LoginInformationBean login, String groupAllowedIn ) 
        throws LoginCheckerException
    {
        if( login == null )
        {
            throw new LoginCheckerException(
                "A valid LoginInformationBean object must be provided." );
        }
        
        if( groupAllowedIn.trim().equals( "" ) )
        {
            throw new LoginCheckerException( "A valid group name must be provided." );
        }
        
        if( ServiceProviderHolderBean.getServiceProvider().getGroupService().get(
            groupAllowedIn.trim() ) == null )
        {
            throw new LoginCheckerException( "A valid group name must be provided." );
        }
        
        this.login          = login;
        this.groupAllowedIn = groupAllowedIn.trim();
        
        if( !this.isUserInGroup() )
        {
            throw new LoginCheckerException(
                "You are not authorized to view pages here." );
        }
    }
    
    private boolean isUserInGroup()
    {
        boolean allowed = false;
            
        if( ServiceProviderHolderBean.getServiceProvider().getUserService().
            userIsInGroup( this.login.getUsername(), this.groupAllowedIn )
        )
        {
            allowed = true;
        }
        
        return allowed;
    }
    
    private LoginInformationBean login;
    private String groupAllowedIn;
}
%>