<!---

	CFDoccer

	Build Component documentation page

	ross, 12/05/2013, creation

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



<cfset qComponent = ComponentData.Select(url.id)>
<cfset qProject = ProjectData.Select(qComponent.cfc_project)>
<cfset qFunction = FunctionData.SelectAll(url.id)>



<cfset Page.CSS = "cfdoccer.css">
<cfset Page.Title = "#qProject.proj_name# - Project Documentation">
<cfinclude template="#global.Path.Includes#DocHeader.cfm">
<cfoutput>

	<nav id="navMain">
		<a href="index.html">&lt; #qProject.proj_name#</a>
	</nav>

	<table class="dataGrid">
		<cfloop query="qComponent">
			<cfset qFunction = FunctionData.SelectAll(qComponent.cfc_id)>
			<tr>
				<th class="cfcName">
					<h2>#qComponent.cfc_name#</h2>
					<div class="hint">#iif(qComponent.cfc_hint neq "", "qComponent.cfc_hint", de(""))#</div>
					<br/>
				</th>
			</tr>
			<tr>
				<td valign="top">
					<br/>
					<nav id="navOptions">
						<a href="##" onclick="$('##comments').slideToggle();">Show/Hide comments &gt;</a>
					</nav>
					<pre id="comments">#HtmlEditFormat(qComponent.cfc_comments)#</pre>

					<table class="dataGrid functionTable">
						<cfloop query="qFunction">
							<cfset qArg = ParameterData.SelectAll(qFunction.func_id)>
							<tr>
								<th>
									<h3>#qFunction.func_name#()</h3>
								</th>
								<th>
									#HtmlEditFormat(qFunction.func_hint)#
								</th>
							</tr>
							<tr>
								<td valign="top">
									<cfif qArg.RecordCount gt 0>
										<table class="dataGrid argTable">
											<tr>
												<th>Argument</th>
												<th>Type</th>
												<th>Default</th>
												<th>Hint</th>
											</tr>
											<cfloop query="qArg">
												<tr>
													<td>
														#iif(qArg.param_required neq 0, de("<b>"), de(""))#
														#qArg.param_name#
														#iif(qArg.param_required neq 0, de("</b>"), de(""))#
													</td>
													<td>
														#qArg.param_type#
													</td>
													<td>
														#qArg.param_default#
													</td>
													<td>
														#HtmlEditFormat(qArg.param_hint)#
													</td>
												</tr>
											</cfloop>
										</table>
									</cfif>
									<cfif qFunction.func_returns neq "">
										<div class="funcReturns"><b>Returns:</b> #func_returns#</div>
									</cfif>
								</td>
								<td valign="top">
									#HtmlEditFormat(qFunction.func_comments)#
								</td>
							</tr>
						</cfloop>
					</table>
				</td>
			</tr>
		</cfloop>
	</table>

</cfoutput>
<cfinclude template="#global.Path.Includes#DocFooter.cfm">