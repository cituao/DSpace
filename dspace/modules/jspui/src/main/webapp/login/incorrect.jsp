<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Display message indicating password is incorrect, and allow a retry
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>


<dspace:layout style="submission" navbar="default"
               locbar="nolink"
               titlekey="jsp.login.incorrect.title">

<br/><br/><br/><br/>
    <%-- <p align="center"><strong>The e-mail address and password you supplied were not valid.  Please try again, or have you <a href="<%= request.getContextPath() %>/forgot">forgotten your password</a>?</strong></p> --%>
     <p align="center"><strong>:/  <fmt:message key="jsp.login.incorrect.text">
        <fmt:param><%= request.getContextPath() %>/forgot</fmt:param>
    </fmt:message></strong></p>

    <dspace:include page="/components/login-form.jsp" />
    
    
</dspace:layout>

    <script type="text/javascript">
        var header= document.getElementsByTagName('header')[0];
        var breadcrumb = document.getElementsByClassName('breadcrumb')[0];         
        header.style.display = "none";
        breadcrumb.style.display = "none";
          
           document.onreadystatechange = function () {
            var footer = document.getElementsByTagName('footer')[0];
            footer.style.display = "none";
           }
          
          
	  </script>