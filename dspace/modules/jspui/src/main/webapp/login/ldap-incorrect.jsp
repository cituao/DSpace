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

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<dspace:layout navbar="off"
			   locbar="nolink"
			   titlekey="jsp.login.ldap-incorrect.title">

    <p align="center"><strong>:/<fmt:message key="jsp.login.ldap-incorrect.errormsg"/>  </strong></p>

    <dspace:include page="/components/ldap-form.jsp" />
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