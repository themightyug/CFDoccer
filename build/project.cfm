<!---

	CFDoccer

	Build Project documentation page

	ross, 11/05/2013, creation

--->
<cfsetting showdebugoutput="false">

<cfparam name="url.id" default="">


<cfif url.id neq val(url.id)>
	<cfthrow message="Invalid ID specified">
</cfif>



<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>

<cfset ComponentData = CreateObject("component", "#global.CfcPrefix#ComponentData")>
<cfset ComponentData.Init(global)>



<cfset qProject = ProjectData.Select(url.id)>
<cfset qComponent = ComponentData.SelectAll(url.id)>


<cfset Page.Title = "#qProject.proj_name# - Project Documentation">
<cfinclude template="#global.Path.Includes#PageHeader.cfm">
<cfoutput>


	<cfloop query="qComponent">
		<div class="component">
			<div class="head">
				<h2>#qComponent.cfc_name##iif(qComponent.cfc_hint neq "", de(" - #qComponent.cfc_hint#"), de(""))#</h2>

			</div>
		</div>
	</cfloop>


</cfoutput>
<cfinclude template="#global.Path.Includes#PageFooter.cfm">