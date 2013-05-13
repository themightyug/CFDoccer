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

<cfset FunctionData = CreateObject("component", "#global.CfcPrefix#FunctionData")>
<cfset FunctionData.Init(global)>

<cfset ParameterData = CreateObject("component", "#global.CfcPrefix#ParameterData")>
<cfset ParameterData.Init(global)>



<cfset qProject = ProjectData.Select(url.id)>
<cfset qComponent = ComponentData.SelectAll(url.id)>


<cfset Page.CSS = "cfdoccer.css">
<cfset Page.Title = "#qProject.proj_name# - Project Documentation">
<cfinclude template="#global.Path.Includes#DocHeader.cfm">
<cfoutput>

	<table class="dataGrid">
		<cfloop query="qComponent">
			<cfset qFunction = FunctionData.SelectAll(qComponent.cfc_id)>
			<tr>
				<th class="cfcName">
					<h2><a href="#qComponent.cfc_file#.html" title="#qComponent.cfc_id#">#qComponent.cfc_name# &gt;</a></h2>
				</th>
				<th class="cfcHint">
					<div class="hint">#iif(qComponent.cfc_hint neq "", "qComponent.cfc_hint", de(""))#</div>
					<div>
						#qFunction.RecordCount# functions
					</div>
				</th>
			</tr>
			<tr class="cfcSummary">
				<td colspan="2">
					<div class="multiCols">
						<cfloop query="qFunction">
							<cfset param_summary = Trim(ParameterData.GetParameterSummary(qFunction.func_id))>
							<div title="#HtmlEditFormat(param_summary)#">#qFunction.func_name#()</div>
						</cfloop>
					</div>
				</td>
			</tr>
		</cfloop>
	</table>

</cfoutput>
<cfinclude template="#global.Path.Includes#DocFooter.cfm">