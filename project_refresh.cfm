<!---

	CFDoccer

	Project refresh

	ross, 18/04/2013, creation

--->
<cfsetting requesttimeout="300">


<cfparam name="url.proj_id" default="">
<cfparam name="action" default="">


<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>


<cfif IsDefined("form.BtnConfirm")>
	<cfset action = "refresh">
<cfelseif IsDefined("form.BtnConfirmSave")>
	<cfset action = "save">
<cfelse>
	<cfset action = "confirm">
</cfif>


<cfset qProject = ProjectData.Select(url.proj_id)>







<cfset Page.Title = "Refresh project '#qProject.proj_name#'">
<cfset Page.JS = ListAppend(Page.JS, "dialogues.js")>
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

	<cfif action eq "confirm">
		<form method="post">
			<div class="dialogue">
				<section class="body">
					Are you sure you want to refresh this project?
				</section>
				<section class="buttonRow">
					<input type="submit" name="BtnConfirm" value=" Yes &gt; " />
				</section>
				<section class="working">
					Working... <img src="#global.url.img#working.gif" alt="working" />
				</section>
			</div>
		</form>
	</cfif>


	<cfif action eq "refresh">
		<code>
			<cfinclude template="#global.path.includes#RefreshProject.cfm">
		</code>

		<form method="post">
			<div class="dialogue">
				<section class="body">
					Ready to save HTML documentation for this project?
				</section>
				<section class="buttonRow">
					<input type="submit" name="BtnConfirmSave" value=" Yes &gt; " />
				</section>
				<section class="working">
					Working... <img src="#global.url.img#working.gif" alt="working" />
				</section>
			</div>
		</form>
	</cfif>


	<cfif action eq "save">
		<code>
			<cfinclude template="#global.path.includes#SaveDocumentation.cfm">
		</code>
	</cfif>


</cfoutput>
<cfinclude template="#global.Path.Includes#PageFooter.cfm">

