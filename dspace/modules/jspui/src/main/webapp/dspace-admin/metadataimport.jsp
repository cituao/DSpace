<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Form to upload a csv metadata file
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
    String message = (String)request.getAttribute("message");
    if (message == null)
    {
        message = "";
    }
    else
    {
        message = "<p><b>" + message + "</b></p>";
    }
%>

<dspace:layout style="submission" titlekey="jsp.dspace-admin.metadataimport.title"
               navbar="admin"
               locbar="link"
               parenttitlekey="jsp.administer"
               parentlink="/dspace-admin" 
               nocache="true">
    <br/>

    <h1><fmt:message key="jsp.dspace-admin.metadataimport.title"/></h1>
<br/><br/><br/>
    <form method="post" enctype="multipart/form-data" action="">

        <%= message %>

        <p align="center">
            <input class="resumable-drop" type="file" size="40" name="file"/>
            <!--<input class="form-control" type="file" size="40" name="file"/>-->
            
        </p>
        <br/><br/><br/>
        <p align="center">
            <input class="btn btn-primary" type="submit" name="submit" value="<fmt:message key="jsp.dspace-admin.general.upload"/>" />
        </p>

    </form>
    
</dspace:layout>
      <script>
    /* makes header bar dark */
    var header = document.getElementsByTagName('header')[0];
    var nav = document.getElementsByTagName('nav')[0];
    header.style.backgroundColor = "black";
        nav.style.paddingTop = "12px";
    </script>
