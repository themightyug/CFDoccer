<!---

	CFDoccer

	Project edit

	ross, 18/04/2013, creation

--->
<cfparam name="url.proj_id" default="-1">


<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>



<cfif val(url.proj_id) lt 0>
	<cfset mode = "create">
<cfelse>
	<cfset mode = "update">
</cfif>


<cfset qProject = ProjectData.Select(url.proj_id)>


<cfif IsDefined("form.BtnSubmit")>

	<cfif mode eq "create">
		<cfset qProject = ProjectData.New()>
	</cfif>

	<cfset qProject.proj_name = form.proj_name>
	<cfset qProject.proj_path = form.proj_path>
	<cfset qProject.proj_cfc_root = form.proj_cfc_root>
	<cfset qProject.proj_doc_url = form.proj_doc_url>

	<cfif mode eq "create">
		<cfset ProjectData.Create(qProject)>
	<cfelseif mode eq "update">
		<cfset ProjectData.Update(qProject)>
	</cfif>

	<cfset session.msg = "Project " & mode & "d">
	<cflocation url="index.cfm">

<cfelse>

	<cfset form.proj_name = qProject.proj_name>
	<cfset form.proj_path = qProject.proj_path>
	<cfset form.proj_cfc_root = qProject.proj_cfc_root>
	<cfset form.proj_doc_url = qProject.proj_doc_url>

</cfif>






<cfset Page.Title = "#iif(mode eq "create", de("New Project"), de("Update Project"))#">
<cfinclude template="#global.Path.Includes#PageHeader.cfm">
<cfoutput>

	<nav id="navMain">
		<a href="index.cfm">&lt; Back to Projects</a>
	</nav>
	<nav id="navOptions">
		<a href="project_edit.cfm">New project &gt;</a>
	</nav>


	<cfif session.msg neq "">
		<div id="msg">#session.msg#</div>
		<cfset session.msg = "">
	</cfif>


	<form method="post">
		<table class="dataForm">
			<caption>Project</caption>
			<tbody>
				<tr>
					<th>Name</th>
					<td>
						<input type="text" name="proj_name" value="#form.proj_name#" maxlength="255" />
					</td>
				</tr>
				<tr>
					<th>Path</th>
					<td>
						<input type="text" name="proj_path" value="#form.proj_path#" maxlength="255" />
					</td>
				</tr>
				<tr>
					<th>CFC Root</th>
					<td>
						<input type="text" name="proj_cfc_root" value="#form.proj_cfc_root#" maxlength="255" />
					</td>
				</tr>
				<tr>
					<th>Documentation URL</th>
					<td>
						<input type="url" name="proj_doc_url" value="#form.proj_doc_url#" maxlength="255" />
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" class="buttonRow">
						<input type="submit" name="BtnSubmit" value=" Submit &gt; ">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>


</cfoutput>
<cfinclude template="#global.Path.Includes#PageFooter.cfm">

