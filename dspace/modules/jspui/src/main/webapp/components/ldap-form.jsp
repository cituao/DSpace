<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Component which displays a login form and associated information
  --%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>
    <%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
        <%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<div class="panel-primary" id="loginContainer">
<div class="login-body">
    
</br></br></br></br></br></br>
           <form name="loginform" class="form-horizontal" id="loginform" method="post" action="<%= request.getContextPath() %>/ldap-login">
  <div id="helpLoginButton">
      <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#login\"%>"><div class="btn btn-primary" style="border-radius:0"><img alt="help" src="<%= request.getContextPath() %>/image/helpIconw.png" /></div><!-- <fmt:message key="jsp.help"/> --></dspace:popup></div>
            <span class="notoItalic"><fmt:message key="jsp.login.ldap.heading"/></span>
              <br/>
               <br/>
               <br/>
                    <div class="form-group">
                        <div class="col-md-3">
                            <!-- <fmt:message key="jsp.components.ldap-form.username-or-email"/> -->
                            <img src="<%= request.getContextPath() %>/image/userIconB.svg">
                            <input class="form-control-login" placeholder="myemail@uao.edu.co" tabindex="1" type="text" name="login_netid">
                        </div>
                        
                    </div>
                    <div class="form-group">
                        <div class="col-md-3">
                            <!-- <fmt:message key="jsp.components.ldap-form.password"/> -->
                            <img src="<%= request.getContextPath() %>/image/passwordIcon.svg">
                            <input class="form-control-login" tabindex="2" type="password" name="login_password">
                        </div>
                    </div>
                    <div class="row">
			                <input type="submit" tabindex="3" class="btn btn-primary" name="login_submit" value="<fmt:message key="jsp.components.ldap-form.login.button"/>">
                        
                    </div>
              
            </form>
   <!-- <div id="register" >
        <p><strong><a href="<%= request.getContextPath() %>/register"><fmt:message key="jsp.components.ldap-form.newuser"/></a></strong></p>            
	    <p><fmt:message key="jsp.components.ldap-form.enter"/></p>
    </div>-->
        
    
</div>
</div>
             <script type="text/javascript">
          var header= document.getElementsByTagName('header')[0];
         
          header.style.display = "none";
         
          
           document.onreadystatechange = function () {
            var footer = document.getElementsByTagName('footer')[0];
            footer.style.display = "none";
           }
          
          
	  </script>
