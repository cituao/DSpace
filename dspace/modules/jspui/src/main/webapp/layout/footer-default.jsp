<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Footer for home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>

<%
    String sidebar = (String) request.getAttribute("dspace.layout.sidebar");
%>

            <%-- Right-hand side bar if appropriate --%>
<%
    if (sidebar != null)
    {
%>
	</div>
	<div class="col-md-3">
                    <%= sidebar %>
    </div>
    </div>       
<%
    }
%>
</div>
</main>
            <%-- Page footer --%>
             <footer class="navbar navbar-inverse navbar-bottom">
           
              <!--  <div  id="citContainer">
                    <div class="citFooterBox">
                        <img class="pull-left" width="120px" src="<%= request.getContextPath() %>/image/citLogotipo.png" /> 
                        <div id="citInfoBox" class="pull-left">
                        Centro de Innovación TIC</br>
Edificio Aulas 4 - Segundo Piso</br>
PBX: (057) (2) 318 8000 - Ext. 12420 - 12425
                        </div>
                        
                    </div>
                </div>-->
        
             <div id="designedby" class="container text-muted footerContainer">
             <!--<fmt:message key="jsp.layout.footer-default.theme-by"/> -->
                 <div class="footerBox"><a id="logoFooter" href="http://www.uao.edu.co"><img src="<%= request.getContextPath() %>/image/uaologo.svg"  alt="Universidad Autónoma de Occidente" /></a></div>
                 <div class="footerBox">Cll 25# 115-85</br>
Km 2 vía Cali-Jamundí</br>
Cali, Colombia</div>
                  <div class="footerBox">buzon@uao.edu.co<br>
www.uao.edu.co<br>
                PBX:+57 2 318 8000 <br>
01 800091 34 35</div>
            
                <div class="footerBox" style="border:none">
                <a target="_blank" href="https://www.facebook.com/BibliotecaUAOCali/?ref=hl"><img class="socialIcon" src="<%= request.getContextPath() %>/image/facebook.svg" /></a>
                    <a target="_blank" href="https://twitter.com/biblioUAO"><img class="socialIcon" src="<%= request.getContextPath() %>/image/twitter.svg" /></a>
                   <a target="_blank" href="https://www.youtube.com/user/bibliotecauao"> <img class="socialIcon" src="<%= request.getContextPath() %>/image/youtube.svg" /></a>
                </div>
                
               
			<div id="footer_feedback" >    
                 <p class="text-muted" style="margin-bottom: 2px;">Tema personalizado por <a href="http://cit.uao.edu.co/portal/" id="cit-credits" role="CITcredits" target="_blank">Centro de Innovación TIC</a></p>
                                <p class="text-muted"><fmt:message key="jsp.layout.footer-default.text"/>&nbsp;-
                                <a target="_blank" href="<%= request.getContextPath() %>/feedback"><fmt:message key="jsp.layout.footer-default.feedback"/></a>
                                <a href="<%= request.getContextPath() %>/htmlmap"></a></p>
               
            </div>
			</div>
    </footer>
    </body>
</html>