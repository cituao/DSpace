<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Page that displays the list of choices of login pages
  - offered by multiple stacked authentication methods.
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Iterator" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="java.sql.SQLException" %>

<%@ page import="org.apache.log4j.Logger" %>

<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.authenticate.AuthenticationManager" %>
<%@ page import="org.dspace.authenticate.AuthenticationMethod" %>
<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.core.LogManager" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<dspace:layout navbar="off" locbar="off" titlekey="jsp.login.chooser.title" nocache="true">
<br/>
<br/>
<br/>
    <table border="0" width="100%" >
        <tr>
            <td align="left">
                <%-- <H1>Log In to DSpace</H1> --%>
       <h1 style="text-align:center"><fmt:message key="jsp.login.chooser.heading"/><div style="width:50px; display:inline-block;"><h5><dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#login\" %>"><fmt:message key="jsp.help"/></dspace:popup></h5></div></h1>
            </td>
          
        </tr>
    </table>
    <p></p>
    <br/>
    <br/>
   
   
          <!--<h2  style="text-align:center"><fmt:message key="jsp.login.chooser.chooseyour"/></h2>-->
            <br/>
            
           
          <div  id="loginChooser">
             
<%
    Iterator ai = AuthenticationManager.authenticationMethodIterator();
    AuthenticationMethod am;
    Context context = null;
    try
    {
    	context = UIUtil.obtainContext(request);
    	int count = 0;
    	String url = null;
    	while (ai.hasNext())
    	{
        am = (AuthenticationMethod)ai.next();
        if ((url = am.loginPageURL(context, request, response)) != null)
        {
   
%>
            <div><a style="display:block" href="<%= url %>">
               
                 <% if(count == 0){ %>
                    <img style="display:block; margin: 0 auto; margin-top:42px; margin-bottom: 20px;" src="<%= request.getContextPath() %>/image/logoLineaRoja.png">
                    
                    <% } else { %>
                    <img style="display:block; margin: 0 auto;"src="<%= request.getContextPath() %>/image/userIconBig.png">
                          <% } %>
		<%-- This kludge is necessary because fmt:message won't
                     evaluate its attributes, so we can't use it on java expr --%>
            
                 <strong><p align="center" class="red"><%= javax.servlet.jsp.jstl.fmt.LocaleSupport.getLocalizedMessage(pageContext, am.loginPageTitle(context)) %></p>
                       </strong></a></div>
                        
<%
        count++;
        }
        }
    }
    catch(SQLException se)
    {
    	// Database error occurred.
        Logger log = Logger.getLogger("org.dspace.jsp");
        log.warn(LogManager.getHeader(context,
                "database_error",
                se.toString()), se);

        // Also email an alert
        UIUtil.sendAlert(request, se);
        JSPManager.showInternalError(request, response);
    }
    finally 
    {
    	context.abort();
    }
  
%>
        
          </div>
     


</dspace:layout>
    <script type="text/javascript">
        var header= document.getElementsByTagName('header')[0];
        
        header.style.display = "none";
    
          
           document.onreadystatechange = function () {
            var footer = document.getElementsByTagName('footer')[0];
            footer.style.display = "none";
           }
          
          
	  </script>
