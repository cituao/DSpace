<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Community home JSP
  -
  - Attributes required:
  -    community             - Community to render home page for
  -    collections           - array of Collections in this community
  -    subcommunities        - array of Sub-communities in this community
  -    last.submitted.titles - String[] of titles of recently submitted items
  -    last.submitted.urls   - String[] of URLs of recently submitted items
  -    admin_button - Boolean, show admin 'edit' button
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="org.dspace.app.webui.components.RecentSubmissions" %>

<%@ page import="org.dspace.app.webui.servlet.admin.EditCommunitiesServlet" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.ItemCounter" %>
<%@ page import="org.dspace.content.*" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.core.Utils" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%
    // Retrieve attributes
    Community community = (Community) request.getAttribute( "community" );
    Collection[] collections =
        (Collection[]) request.getAttribute("collections");
    Community[] subcommunities =
        (Community[]) request.getAttribute("subcommunities");
   
    
    RecentSubmissions rs = (RecentSubmissions) request.getAttribute("recently.submitted");
    
    Boolean editor_b = (Boolean)request.getAttribute("editor_button");
    boolean editor_button = (editor_b == null ? false : editor_b.booleanValue());
    Boolean add_b = (Boolean)request.getAttribute("add_button");
    boolean add_button = (add_b == null ? false : add_b.booleanValue());
    Boolean remove_b = (Boolean)request.getAttribute("remove_button");
    boolean remove_button = (remove_b == null ? false : remove_b.booleanValue());

	// get the browse indices
    BrowseIndex[] bis = BrowseIndex.getBrowseIndices();

    // Put the metadata values into guaranteed non-null variables
    String name = community.getMetadata("name");
    String intro = community.getMetadata("introductory_text");
    String copyright = community.getMetadata("copyright_text");
    String sidebar = community.getMetadata("side_bar_text");
    Bitstream logo = community.getLogo();
    
    boolean feedEnabled = ConfigurationManager.getBooleanProperty("webui.feed.enable");
    String feedData = "NONE";
    if (feedEnabled)
    {
        feedData = "comm:" + ConfigurationManager.getProperty("webui.feed.formats");
    }
    
    ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));
%>

<%@page import="org.dspace.app.webui.servlet.MyDSpaceServlet"%>
<dspace:layout locbar="commLink" title="<%= name %>" feedData="<%= feedData %>">
<div class="sideContainer">
    <div class="well" id="community">
        <div class="row">
            <div id="communityMainTitle">
                 <%  if (logo != null) { %>
                 <div id="communityImgContainer">
                    <img class="img-responsive" alt="Logo" src="<%= request.getContextPath() %>/retrieve/<%= logo.getID() %>" />
                 </div> 
                 <% } %>
                <h1 class="white" style="line-height:100%;"><%= name %>
                    <%
                        if(ConfigurationManager.getBooleanProperty("webui.strengths.show"))
                        {
                    %>
                        : [<%= ic.getCount(community) %>]
                    <%
                        }
                    %>
                </h1>
                <a class="statisticsLink btn" href="<%= request.getContextPath() %>/handle/<%= community.getHandle() %>/statistics">
                    <fmt:message key="jsp.community-home.display-statistics"/>
                </a>
                <p class="copyrightText"><%= copyright %></p>
                <h4 class="lightRed"><fmt:message key="jsp.community-home.heading1"/></h4>
            </div><!--itemMainTitle-->
         </div><!--row-->
        <% if (StringUtils.isNotBlank(intro)) { %>
        <%= intro %>
        <% } %>
    </div><!--well-->

    <% if(editor_button || add_button)  // edit button(s)
    { %>
   
		 <div class="panel panel-warning">
             <div class="panel-heading">
                 <h3 class="white"><fmt:message key="jsp.admintools"/>
             	<span class="pull-right white">
             		<dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.site-admin\")%>"><fmt:message key="jsp.adminhelp"/></dspace:popup>
             	</span>
                 </h3>   
             	</div>
             <div class="panel-body">
             <% if(editor_button) { %>
	            <form method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
		          <input type="hidden" name="community_id" value="<%= community.getID() %>" />
		          <input type="hidden" name="action" value="<%=EditCommunitiesServlet.START_EDIT_COMMUNITY%>" />
                  <%--<input type="submit" value="Edit..." />--%>
                  <input class="btn btn-default col-md-12" type="submit" value="<fmt:message key="jsp.general.edit.button"/>" />
                </form>
             <% } %>
             <% if(add_button) { %>

				<form method="post" action="<%=request.getContextPath()%>/tools/collection-wizard">
		     		<input type="hidden" name="community_id" value="<%= community.getID() %>" />
                    <input class="btn btn-default col-md-12" type="submit" value="<fmt:message key="jsp.community-home.create1.button"/>" />
                </form>
                
                <form method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
                    <input type="hidden" name="action" value="<%= EditCommunitiesServlet.START_CREATE_COMMUNITY%>" />
                    <input type="hidden" name="parent_community_id" value="<%= community.getID() %>" />
                    <%--<input type="submit" name="submit" value="Create Sub-community" />--%>
                    <input class="btn btn-default col-md-12" type="submit" name="submit" value="<fmt:message key="jsp.community-home.create2.button"/>" />
                 </form>
             <% } %>
            <% if( editor_button ) { %>
                <form method="post" action="<%=request.getContextPath()%>/mydspace">
                  <input type="hidden" name="community_id" value="<%= community.getID() %>" />
                  <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_EXPORT_ARCHIVE %>" />
                  <input class="btn btn-default col-md-12" type="submit" value="<fmt:message key="jsp.mydspace.request.export.community"/>" />
                </form>
              <form method="post" action="<%=request.getContextPath()%>/mydspace">
                <input type="hidden" name="community_id" value="<%= community.getID() %>" />
                <input type="hidden" name="step" value="<%= MyDSpaceServlet.REQUEST_MIGRATE_ARCHIVE %>" />
                <input class="btn btn-default col-md-12" type="submit" value="<fmt:message key="jsp.mydspace.request.export.migratecommunity"/>" />
              </form>
               <form method="post" action="<%=request.getContextPath()%>/dspace-admin/metadataexport">
                 <input type="hidden" name="handle" value="<%= community.getHandle() %>" />
                 <input class="btn btn-default col-md-12" type="submit" value="<fmt:message key="jsp.general.metadataexport.button"/>" />
               </form>
			<% } %>
			</div>
		</div>
    <% } %>
        
        
    <%-- Browse --%>
    <div class="panel panel-primary">
        <div class="panel-heading"><h3><fmt:message key="jsp.general.browse"/></h3></div>
        <div class="panel-body">
        <%-- Insert the dynamic list of browse options --%>
    <%
        for (int i = 0; i < bis.length; i++)
        {
            String key = "browse.menu." + bis[i].getName();
    %>
        <form method="get" action="<%= request.getContextPath() %>/handle/<%= community.getHandle() %>/browse">
            <input type="hidden" name="type" value="<%= bis[i].getName() %>"/>
            <%-- <input type="hidden" name="community" value="<%= community.getHandle() %>" /> --%>
            <h4><input class="btn sideInput" type="submit" name="submit_browse" value="<fmt:message key="<%= key %>"/>"/></h4>
        </form>
    <%
       }
    %> 

        </div>
    </div>

    <div class="row">

        <%
            int discovery_panel_cols = 12;
            int discovery_facet_cols = 4;
        %>
        <%@ include file="discovery/static-sidebar-facet.jsp" %>
    </div>

    <div class="row">
        <%@ include file="discovery/static-tagcloud-facet.jsp" %>
    </div>
</div> <!--  sideContainer -->


    
<!-- collection LIST per community .itemListContent !-->
    
    <div class="row contentContainer" >
<%
	boolean showLogos = ConfigurationManager.getBooleanProperty("jspui.community-home.logos", true);
	if (subcommunities.length != 0)
    {
%>
	<div class="listContainer">

		<h1><fmt:message key="jsp.community-home.heading3"/></h1>
   
        <div class="list-group" id="collections-list">
<%
        for (int j = 0; j < subcommunities.length; j++)
        {
%>
			<div class="list-group-item collectionItem row">  
<%  
		Bitstream logoCom = subcommunities[j].getLogo();
		if (showLogos && logoCom != null) { %>
			
		        <img alt="Logo" class="collectionItemtImg" src="<%= request.getContextPath() %>/retrieve/<%= logoCom.getID() %>" /> 
			
			<div class="collectionItemContent">
<% } else { %>
     <img alt="Logo" class="collectionItemImg" src="<%= request.getContextPath() %>/image/noCollectionImg.jpg" />
			<div class="collectionItemContent">
<% }  %>		

	      <h4 class="list-group-item-heading "><a href="<%= request.getContextPath() %>/handle/<%= subcommunities[j].getHandle() %>">
	                <%= subcommunities[j].getMetadata("name") %></a>
<%
                if (ConfigurationManager.getBooleanProperty("webui.strengths.show"))
                {
%>
                    [<%= ic.getCount(subcommunities[j]) %>]
<%
                }
%>
	    		<% if (remove_button) { %>
	                <form class="btn-group" method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
			          <input type="hidden" name="parent_community_id" value="<%= community.getID() %>" />
			          <input type="hidden" name="community_id" value="<%= subcommunities[j].getID() %>" />
			          <input type="hidden" name="action" value="<%=EditCommunitiesServlet.START_DELETE_COMMUNITY%>" />
	                  <button type="submit" class="btn btn-xs btn-danger"><span class="glyphicon glyphicon-trash"></span></button>
	                </form>
	    		<% } %>
			    </h4>
                <p class="collectionDescription"><%= subcommunities[j].getMetadata("short_description") %></p>
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

<%
    if (collections.length != 0)
    {
%>
	<div class="listContainer">

        <%-- <h2>Collections in this community</h2> --%>
		<h1><fmt:message key="jsp.community-home.heading2"/></h1>
		<div class="list-group" id="collections-list">
<%
        for (int i = 0; i < collections.length; i++)
        {
%>
			<div class="list-group-item collectionItem row">  
<%  
		Bitstream logoCol = collections[i].getLogo();
		if (showLogos && logoCol != null) { %>
			
		        <img alt="Logo" class="collectionItemImg" src="<%= request.getContextPath() %>/retrieve/<%= logoCol.getID() %>" /> 
			
			<div class="collectionItemContent">
<% } else { %>
    <img alt="Logo" class="collectionItemImg" src="<%= request.getContextPath() %>/image/noCollectionImg.jpg" />
			<div class="collectionItemContent">
<% }  %>		

	      <h3 class="list-group-item-heading noto"><a href="<%= request.getContextPath() %>/handle/<%= collections[i].getHandle() %>">
	      <%= collections[i].getMetadata("name") %></a>
              
<%
            if(ConfigurationManager.getBooleanProperty("webui.strengths.show"))
            {
%>
                [<%= ic.getCount(collections[i]) %>]
<%
            }
%>
	    <% if (remove_button) { %>
	      <form class="btn-group" method="post" action="<%=request.getContextPath()%>/tools/edit-communities">
	          <input type="hidden" name="parent_community_id" value="<%= community.getID() %>" />
	          <input type="hidden" name="community_id" value="<%= community.getID() %>" />
	          <input type="hidden" name="collection_id" value="<%= collections[i].getID() %>" />
	          <input type="hidden" name="action" value="<%=EditCommunitiesServlet.START_DELETE_COLLECTION%>" />
	          <button type="submit" class="btn btn-xs btn-danger"><span class="glyphicon glyphicon-trash"></span></button>
	      </form>
	    <% } %>
		</h3>
      <p class="collectionDescription"><%= collections[i].getMetadata("short_description") %></p>
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

	<div class="row">
<%
	if (rs != null)
	{ %>

        <div class="panel panel-primary">        
        <div id="recent-submissions-carousel" class="panel-heading carousel slide">
        <%-- Recently Submitted items --%>
			<h3><fmt:message key="jsp.community-home.recentsub"/>
<%
    if(feedEnabled)
    {
    	String[] fmts = feedData.substring(5).split(",");
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
    <a href="<%= request.getContextPath() %>/feed/<%= fmts[j] %>/<%= community.getHandle() %>"><img src="<%= request.getContextPath() %>/image/<%= icon %>" alt="RSS Feed" width="<%= width %>" height="15" style="margin: 3px 0 3px" /></a>
<%
    	}
    }
%>
			</h3>
		
	<%
		Item[] items = rs.getRecentSubmissions();
		boolean first = true;
		if(items!=null && items.length>0) 
		{ 
	%>	
		<!-- Wrapper for slides -->
		  <div class="carousel-inner">
	<%	for (int i = 0; i < items.length; i++)
		{
			Metadatum[] dcv = items[i].getMetadata("dc", "title", null, Item.ANY);
			String displayTitle = "Untitled";
			if (dcv != null)
			{
				if (dcv.length > 0)
				{
					displayTitle = Utils.addEntities(dcv[0].value);
				}
			}
			%>
		    <div style="padding-bottom: 50px; min-height: 200px;" class="item <%= first?"active":""%>">
		      <div style="padding-left: 80px; padding-right: 80px; display: inline-block;"><%= StringUtils.abbreviate(displayTitle, 400) %> 
		      	<a href="<%= request.getContextPath() %>/handle/<%=items[i].getHandle() %>" class="btn btn-success">See</a>
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
		    <% for (int i = 1; i < rs.count(); i++){ %>
		    <li data-target="#recent-submissions-carousel" data-slide-to="<%= i %>"></li>
		    <% } %>
	      </ol>
		
		<%
		}
		%>
		  
     </div></div>
<%
	}
%>
	<div class="col-md-4">
    	<%= sidebar %>
	</div>
</div>	
    
</div><!-- contentContainer end collection list -->


	

   
</dspace:layout>
