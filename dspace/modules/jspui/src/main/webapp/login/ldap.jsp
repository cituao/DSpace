<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Page that displays the netid/password login form
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<dspace:layout navbar="off"
		locbar="off"
		titlekey="jsp.login.ldap.title">
		
    <table border="0" width="90%">
        <tr>
            <td align="right" class="standard">
              
            </td>
        </tr>
    </table>

    <dspace:include page="/components/ldap-form.jsp" />
</dspace:layout>
 <script>
     /* makes header bar dark */
    var header = document.getElementsByTagName('header')[0];
    header.style.backgroundColor = "black";
    </script>