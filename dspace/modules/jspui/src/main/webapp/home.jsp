
<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Home page JSP
  -
  - Attributes:
  -    communities - Community[] all communities in DSpace
  -    recent.submissions - RecetSubmissions
  --%>

<%@page import="org.dspace.core.Utils"%>
<%@page import="org.dspace.content.Bitstream"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Locale"%>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.core.I18nUtil" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.app.webui.components.RecentSubmissions" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.core.NewsManager" %>
<%@ page import="org.dspace.browse.ItemCounter" %>
<%@ page import="org.dspace.content.Metadatum" %>
<%@ page import="org.dspace.content.Item" %>

<%
    Community[] communities = (Community[]) request.getAttribute("communities");

    Locale sessionLocale = UIUtil.getSessionLocale(request);
    Config.set(request.getSession(), Config.FMT_LOCALE, sessionLocale);
    String topNews = NewsManager.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-top.html"));
    String sideNews = NewsManager.readNewsFile(LocaleSupport.getLocalizedMessage(pageContext, "news-side.html"));

    boolean feedEnabled = ConfigurationManager.getBooleanProperty("webui.feed.enable");
    String feedData = "NONE";
    if (feedEnabled)
    {
        feedData = "ALL:" + ConfigurationManager.getProperty("webui.feed.formats");
    }
    
    ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));

    RecentSubmissions submissions = (RecentSubmissions) request.getAttribute("recent.submissions");
%>

<dspace:layout locbar="nolink" titlekey="jsp.home.title" feedData="<%= feedData %>">

	<!--<div class="jumbotron">
        <%= topNews %>
	</div>-->
    <!-- Banner encabezado, transladado de header-default /  sólo aparece en el HOME -->
    <div class="container banner">
    <div class="row">
    <iframe src="<%= request.getContextPath() %>/wideView/index.html" frameborder="0" scrolling="no" id="iframe">
       <div class="col-md-9 brand">
           <h1><fmt:message key="jsp.layout.header-default.brand.heading" /></h1>
            <fmt:message key="jsp.layout.header-default.brand.description" /> 
            <img width="100%" src='<%= request.getContextPath() %>/image/mainImg.svg'/>
        </div>
        <div class="col-md-3" id="anosLogo">
            <img width="100%" style="position:relative; top:46px;" src="<%= request.getContextPath() %>/image/40anos.svg" alt="DSpace logo" />
        </div> 
    </iframe>
         
    </div>
</div>
    

<div class="row">
<%
if (submissions != null && submissions.count() > 0)
{
%>
        <div class="col-md-8">
        <div class="panel panel-primary">        
        <div id="recent-submissions-carousel" class="panel-heading carousel slide">
          <h3><fmt:message key="jsp.collection-home.recentsub"/>
              <%
    if(feedEnabled)
    {
	    	String[] fmts = feedData.substring(feedData.indexOf(':')+1).split(",");
	    	String icon = null;
	    	int width = 0;
	    	for (int j = 0; j < fmts.length; j++)
	    	{
	    		if ("rss_1.0".equals(fmts[j]))
	    		{
	    		   icon = "rss1.gif";
	    		   width = 80;
	    		}
	    		else if ("rss_2.0".equals(fmts[j]))
	    		{
	    		   icon = "rss2.gif";
	    		   width = 80;
	    		}
	    		else
	    	    {
	    	       icon = "rss.gif";
	    	       width = 36;
	    	    }
	%>
	    <a href="<%= request.getContextPath() %>/feed/<%= fmts[j] %>/site"><img src="<%= request.getContextPath() %>/image/<%= icon %>" alt="RSS Feed" width="<%= width %>" height="15" style="margin: 3px 0 3px" /></a>
	<%
	    	}
	    }
	%>
          </h3>
          
		  <!-- Wrapper for slides -->
		  <div class="carousel-inner">
		    <%
		    boolean first = true;
		    for (Item item : submissions.getRecentSubmissions())
		    {
		        Metadatum[] dcv = item.getMetadata("dc", "title", null, Item.ANY);
		        String displayTitle = "Untitled";
		        if (dcv != null & dcv.length > 0)
		        {
		            displayTitle = Utils.addEntities(dcv[0].value);
		        }
		        dcv = item.getMetadata("dc", "description", "abstract", Item.ANY);
		        String displayAbstract = "";
		        if (dcv != null & dcv.length > 0)
		        {
		            displayAbstract = Utils.addEntities(dcv[0].value);
		        }
		%>
		    <div style="padding-bottom: 50px; min-height: 200px;" class="item <%= first?"active":""%>">
		      <div style="padding-left: 80px; padding-right: 80px; display: inline-block;"><%= StringUtils.abbreviate(displayTitle, 400) %> 
		      	<a href="<%= request.getContextPath() %>/handle/<%=item.getHandle() %>" class="btn btn-success">See</a>
                        <p><%= StringUtils.abbreviate(displayAbstract, 500) %></p>
		      </div>
		    </div>
		<%
				first = false;
		     }
		%>
		  </div>

		  <!-- Controls -->
		  <a class="left carousel-control" href="#recent-submissions-carousel" data-slide="prev">
		    <span class="icon-prev"></span>
		  </a>
		  <a class="right carousel-control" href="#recent-submissions-carousel" data-slide="next">
		    <span class="icon-next"></span>
		  </a>

          <ol class="carousel-indicators">
		    <li data-target="#recent-submissions-carousel" data-slide-to="0" class="active"></li>
		    <% for (int i = 1; i < submissions.count(); i++){ %>
		    <li data-target="#recent-submissions-carousel" data-slide-to="<%= i %>"></li>
		    <% } %>
	      </ol>
     </div></div></div>
<%
}
%>
<!--<div class="col-md-4">
    <%= sideNews %>
</div>-->
   
</div><!-- ROW -->
<div class="listContainer container row">
<%
if (communities != null && communities.length != 0)
{
%>
    <h1><fmt:message key="jsp.home.com1"/></h1>
    <!--<p><fmt:message key="jsp.home.com2"/></p>-->
	
    <div class="contentContainer">		
               
				<div class="list-group" id="communities-list">
<%
	boolean showLogos = ConfigurationManager.getBooleanProperty("jspui.home-page.logos", true);
    for (int i = 0; i < communities.length; i++)
    {
%><div class="list-group-item communityItem">
<%  
		Bitstream logo = communities[i].getLogo();
		if (showLogos && logo != null) { %>
	<div class="communityItemImg">
        <img alt="Logo"  src="<%= request.getContextPath() %>/retrieve/<%= logo.getID() %>" /> 
	</div>
    
    
	<div class="communityItemContent">
<% } else { %>
	<div class="communityItemContent">
<% }  %>		
		<h3 class="list-group-item-heading"><a href="<%= request.getContextPath() %>/handle/<%= communities[i].getHandle() %>"><%= communities[i].getMetadata("name") %></a>
<%
        if (ConfigurationManager.getBooleanProperty("webui.strengths.show"))
        {
%>
		<span class="badge pull-right"><%= ic.getCount(communities[i]) %></span>
<%
        }

%>
		</h3>
		<p><%= communities[i].getMetadata("short_description") %></p>
    </div>
</div>                            
<%
    }
%>
	</div>
	</div>
<%
}
%>
    </div> <!-- aqui termina la lista de comunidades-->
	<%
    	int discovery_panel_cols = 8;
    	int discovery_facet_cols = 4;
    %>
	<%@ include file="discovery/static-sidebar-facet.jsp" %>


<div class="row">
	<%@ include file="discovery/static-tagcloud-facet.jsp" %>
</div>
	
</div>
        
        <script>
        
             
            var breadcrumb = document.getElementsByClassName('breadcrumb')[0];
            breadcrumb.style.display= "none";
            
            /*Displays colums for home discovery */
             var discoveryHomeDisplay = function(){
             var facetArray = document.getElementsByClassName('facet');
                    for(var i =0; i < facetArray.length; i++){
                        var facet = facetArray[i];

                            if(window.innerWidth < 660){
                                facet.style.width = '100%';
                                facet.style.marginTop = '10px';
                                facet.style.marginLeft = '0px';
                            }
                            else
                            {
                                facet.style.width = '30%';   
                                facet.style.float = 'left';
                                facet.style.margin = '10px 10px';
                            }    
                    }
             }
             
           
             discoveryHomeDisplay();
             
               
             
             window.onresize = function(){
             discoveryHomeDisplay();
             }
            
        </script>
</dspace:layout>
