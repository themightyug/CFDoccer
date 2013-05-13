<!---

	CFDoccer Projects page

	ross, 18/04/2013, creation

--->

<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>


<cfif IsDefined("url.remove")>
	<cfset ProjectData.Delete(url.remove)>
	<cfset session.msg = "The project has been removed">
</cfif>



<cfset qProject = ProjectData.SelectAll()>




<cfset Page.Title = "Projects">
<cfinclude template="#global.Path.Includes#PageHeader.cfm">
<cfoutput>

	<nav id="navMain"></nav>
	<nav id="navOptions">
		<a href="project_edit.cfm">New project &gt;</a>
	</nav>

	<cfif session.msg neq "">
		<div id="msg">#session.msg#</div>
		<cfset session.msg = "">
	</cfif>

	<table class="dataGrid">
		<caption>Projects</caption>
		<thead>
			<tr>
				<th>ID</th>
				<th>Name</th>
				<th>CFC Path</th>
				<th class="action">Remove</th>
				<th class="action">Refreshed</th>
				<th class="action">View</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="qProject">
				<tr>
					<td>
						<a href="project_edit.cfm?proj_id=#qProject.proj_id#">#qProject.proj_id#</a>
					</td>
					<td>#qProject.proj_name#</td>
					<td>#qProject.proj_path##qProject.proj_cfc_root#</td>
					<td>
						<a href="?remove=#qProject.proj_id#">remove</a>
					</td>
					<td>
						<a href="project_refresh.cfm?proj_id=#qProject.proj_id#">#iif(qProject.proj_refreshed eq "", de("never"), "DateFormat(qProject.proj_refreshed, global.DateFormat)")#</a>
					</td>
					<td>
						<cfif qProject.proj_refreshed neq "">
							<a href="#qProject.proj_doc_url#/index.html">documentation</a>
						<cfelse>
							&nbsp;
						</cfif>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>


</cfoutput>
<cfinclude template="#global.Path.Includes#PageFooter.cfm">