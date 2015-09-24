<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Component which displays a login form and associated information
  --%>
  <%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
  <%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>
    <div class="panel-primary" id="loginContainer">
	<div class="login-body">
        </br></br></br></br></br>
     <form name="loginform" class="form-horizontal" id="loginform" method="post" action="<%= request.getContextPath() %>/password-login">
         <span class="notoItalic"><fmt:message key="jsp.login.password.heading"/></span>
      
	  <!--<p><fmt:message key="jsp.components.login-form.enter"/></p>-->
		<div class="form-group">
           <!-- <label class="col-md-offset-3 col-md-2 control-label" for="tlogin_email"><fmt:message key="jsp.components.login-form.email"/></label>-->
            <div class="col-md-3">
            	<img src="<%= request.getContextPath() %>/image/userIconB.svg"></image><input class="form-control-login" type="text" name="login_email" id="tlogin_email" placeholder="myemail@mail.com" tabindex="1" />
            </div>
        </div>
        <div class="form-group">
          <!--  <label class="col-md-offset-3 col-md-2 control-label" for="tlogin_password"><fmt:message key="jsp.components.login-form.password"/></label>-->
            <div class="col-md-3">
                <img src="<%= request.getContextPath() %>/image/passwordIcon.svg">
            	<input class="form-control-login" type="password"  name="login_password" id="tlogin_password" tabindex="2" />
            </div>
        </div>
        <div class="row">
        <!--<div class="col-md-6">-->
        	<input type="submit" class="btn btn-primary" name="login_submit" value="<fmt:message key="jsp.components.login-form.login"/>" tabindex="3" />
      
        <!-- </div>-->
  		<p id="forgot"><a href="<%= request.getContextPath() %>/forgot"><fmt:message key="jsp.components.login-form.forgot"/></a></p>
             </div>
      </form>
        <div id="register">
            <span id="helpLoginButton" >
                <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#login\"%>"><div class="btn btn-primary" style="border-radius:0"><img alt="help" src="<%= request.getContextPath() %>/image/helpIconw.png" /> </div><!--<fmt:message key="jsp.help"/>--></dspace:popup></span>
            
        <h1 class="noto">Just arrived?</h1>
            <p class="cabin">By registering you will be able to get full services we offer</p>
        <p style="width:224px; margin-top:30px;"><strong><a class="btn btn-primary" href="<%= request.getContextPath() %>/register"><fmt:message key="jsp.components.login-form.newuser"/></a></strong></p>
        </div>
      <script type="text/javascript">
          var header= document.getElementsByTagName('header')[0];
         
		  document.loginform.login_email.focus();
          header.style.display = "none";
         
          
           document.onreadystatechange = function () {
            var footer = document.getElementsByTagName('footer')[0];
            footer.style.display = "none";
           }
          
          
	  </script>
	</div>
</div>