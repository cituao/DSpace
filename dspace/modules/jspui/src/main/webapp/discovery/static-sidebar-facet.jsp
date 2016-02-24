<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - fragment JSP to be included in site, community or collection home to show discovery facets
  -
  - Attributes required:
  -    discovery.fresults    - the facets result to show
  -    discovery.facetsConf  - the facets configuration
  -    discovery.searchScope - the search scope 
  --%>

<%@page import="org.dspace.discovery.configuration.DiscoverySearchFilterFacet"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.dspace.discovery.DiscoverResult.FacetResult"%>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>

<%
	boolean brefine = false;
	
	Map<String, List<FacetResult>> mapFacetes = (Map<String, List<FacetResult>>) request.getAttribute("discovery.fresults");
	List<DiscoverySearchFilterFacet> facetsConf = (List<DiscoverySearchFilterFacet>) request.getAttribute("facetsConfig");
	String searchScope = (String) request.getAttribute("discovery.searchScope");
	if (searchScope == null)
	{
	    searchScope = "";
	}
	
	if (mapFacetes != null)
	{
	    for (DiscoverySearchFilterFacet facetConf : facetsConf)
		{
		    String f = facetConf.getIndexFieldName();
		    List<FacetResult> facet = mapFacetes.get(f);
		    if (facet != null && facet.size() > 0)
		    {
		        brefine = true;
		        break;
		    }
		    else
		    {
		        facet = mapFacetes.get(f+".year");
			    if (facet != null && facet.size() > 0)
			    {
			        brefine = true;
			        break;
			    }
		    }
		}
	}
	if (brefine) {
%>
<!--<div class="col-md-<%= discovery_panel_cols %>">-->
<div class="panel-heading">
    <h3 class="facets"><fmt:message key="jsp.search.facet.refine" /></h3>
</div>
<div id="facets" class="facetsBox row panel">
<%
	for (DiscoverySearchFilterFacet facetConf : facetsConf)
	{
    	String f = facetConf.getIndexFieldName();
    	List<FacetResult> facet = mapFacetes.get(f);
 	    if (facet == null)
 	    {
 	        facet = mapFacetes.get(f+".year");
 	    }
 	    if (facet == null)
 	    {
 	        continue;
 	    }
	    String fkey = "jsp.search.facet.refine."+f;
	    int limit = facetConf.getFacetLimit()+1;
	    %>
        <!--<div id="facet_<%= f %>" class="facet col-md-<%= discovery_facet_cols %>"> old -->
    <div id="facet_<%= f %>" class="facet">
	    <h4 class="facetName sideInput"><fmt:message key="<%= fkey %>" /><img  id="dropdownIcon" class="pull-right" src="<%= request.getContextPath() %>/image/dropdownIconN.png"/><img  id="dropupIcon" class="pull-right" src="<%= request.getContextPath() %>/image/dropupIconN.png"/></h4>
	    <ul  id="facet-list-group"><%
	    int idx = 1;
	    int currFp = UIUtil.getIntParameter(request, f+"_page"); 
	    if (currFp < 0)
	    {
	        currFp = 0;
	    }
	    if (facet != null)
	    {
		    for (FacetResult fvalue : facet)
		    { 
		        if (idx != limit)
		        {
		        %><li class="list-group-item facetItem"><span class="badge"><%= fvalue.getCount() %></span> <a href="<%= request.getContextPath()
		            + searchScope
	                + "/simple-search?filterquery="+URLEncoder.encode(fvalue.getAsFilterQuery(),"UTF-8")
	                + "&amp;filtername="+URLEncoder.encode(f,"UTF-8")
	                + "&amp;filtertype="+URLEncoder.encode(fvalue.getFilterType(),"UTF-8") %>"
	                title="<fmt:message key="jsp.search.facet.narrow"><fmt:param><%=fvalue.getDisplayedValue() %></fmt:param></fmt:message>">
	                <%= StringUtils.abbreviate(fvalue.getDisplayedValue(),36) %></a></li><%
		        }
		        idx++;
		    }
		    if (currFp > 0 || idx > limit)
		    {
		        %><li class="list-group-item facetItem"><span style="visibility: hidden;">.</span>
		        <% if (currFp > 0) { %>
                 <div class="control-pre-next pull-left" style="margin-left: -10px;">
		        <a  href="<%= request.getContextPath()
		                + searchScope
		                + "?"+f+"_page="+(currFp-1) %>"><!--<fmt:message key="jsp.search.facet.refine.previous" />--><img src="<%= request.getContextPath() %>/image/previous.png"></a>
                </div>
	            <% } %>
	            <% if (idx > limit) { %>
	            <div class="control-pre-next pull-right">
                    <a href="<%= request.getContextPath()
		            + searchScope
	                + "?"+f+"_page="+(currFp+1) %>"><!--<fmt:message key="jsp.search.facet.refine.next" />--><img src="<%= request.getContextPath() %>/image/next.png"></a>
                </div>
	            <%
	            }
	            %></li><%
		    }
	    }
	    %></ul></div><%
	}
%></div><!--</div>--><%
	}
%>
                    
                    <script>
                    var facetHeader = document.getElementsByClassName('facetName');
                    var on = "true";
                    
                    $(facetHeader).click(function(){ 
                        var facet = $(this).parent('.facet');
                        var dropdown = $(this).find('#dropdownIcon');
                        var dropup = $(this).find('#dropupIcon');
                        if(on == "true"){
                            $(facet).find("#facet-list-group").addClass('facetOff'); 
                            $(facet).find("#facet-list-group").removeClass('facetOn'); 
                            $(dropdown).fadeTo("fast",1);
                            $(dropup).fadeTo("fast",0);
                            on="false";     
                        }else if(on == "false"){
                            $(facet).find("#facet-list-group").removeClass('facetOff'); 
                            $(facet).find("#facet-list-group").addClass('facetOn');
                             $(dropdown).fadeTo("fast",0);
                            $(dropup).fadeTo("fast",1);
                            on="true";
                        }
                    });
                        
                    </script>
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    