<!---

	CFDoccer

	Project documentation generator

	ross, 06/05/2013, creation

--->
<cfoutput>


<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>

<cfset qProject = ProjectData.Select(url.proj_id)>


<cfset FunctionData = CreateObject("component", "#global.CfcPrefix#FunctionData")>
<cfset FunctionData.Init(global)>

<cfset ParameterData = CreateObject("component", "#global.CfcPrefix#ParameterData")>
<cfset ParameterData.Init(global)>

<cfset ComponentData = CreateObject("component", "#global.CfcPrefix#ComponentData")>
<cfset ComponentData.Init(global)>

<cfset Doccer = CreateObject("component", "#global.CfcPrefix#Doccer")>
<cfset Doccer.Init(global, qProject.proj_path & "/_doc/")>



<cfset qComponents = ComponentData.SelectAll(qProject.proj_id)>


<cfif qComponents.RecordCount gt 0>
	<div class="status">Begin documenting components at #DateFormat(now(), global.DateFormat)# #TimeFormat(now(), global.TimeFormat)#</div>

	<cfset Doccer.ClearDirectory()>

	<cfset Doccer.DocumentProject(qProject)>

	<cfset Doccer.DocumentComponents(qComponents)>

	<cfset ProjectData.UpdateRefreshed(qProject.proj_id)>
	<div class="status">Documentation completed at #DateFormat(now(), global.DateFormat)# #TimeFormat(now(), global.TimeFormat)#</div>
</cfif>

</cfoutput>