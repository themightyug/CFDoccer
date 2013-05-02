<!---

	CFDoccer

	Component scanner

	ross, 21/04/2013, creation

--->

<cfcomponent name="ComponentScanner" output="false">

	<cfset qComp = ArrayNew(1)>
	<cfset proj = "">


	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">

		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="SetProject">
		<cfargument name="qProj" required="yes">

		<cfset proj = arguments.qProj>
	</cffunction>


	<cffunction name="LoadComponents">
		<cfargument name="q" required="yes">

		<cfloop query="arguments.q">
			<cfset ArrayAppend(qComp, arguments.q.name)>
		</cfloop>
	</cffunction>


	<cffunction name="GetComponentStack">
		<cfreturn qComp>
	</cffunction>


	<cffunction name="ComponentPath">
		<cfargument name="component_file" required="yes">

		<cfset var local = structnew()>

		<cfset local.path = proj.proj_path & proj.proj_cfc_root & "/" & arguments.component_file>

		<cfreturn local.path>
	</cffunction>


	<cffunction name="ScanComponents" enablecfoutput="true">
		<cfset var local = structnew()>

		<cfset local.ComponentData = CreateObject("component", "#global.CfcPrefix#ComponentData")>
		<cfset local.ComponentData.Init(global)>

		<cfset local.FunctionData = CreateObject("component", "#global.CfcPrefix#FunctionData")>
		<cfset local.FunctionData.Init(global)>

		<cfset local.ParameterData = CreateObject("component", "#global.CfcPrefix#ParameterData")>
		<cfset local.ParameterData.Init(global)>

		<cfset local.parser = CreateObject("component", "#global.CfcPrefix#ComponentParser")>
		<cfset local.parser.Init(global)>

		<cfoutput>

			<div>Flushing existing data from the database...</div>
			<cfset local.ComponentData.ClearProject(proj.proj_id)>

			<cfloop from="1" to="#ArrayLen(qComp)#" index="local.i">
				<cfset local.cfc_path = ComponentPath(qComp[local.i])>
				<br/><br/><div class="status">Opening #local.cfc_path#</div>

				<cfset local.cfc = FileRead(local.cfc_path)>
				<div class="status">File size: #LSNumberFormat(Len(local.cfc))# bytes</div>

				<cfset local.parser.SetDocument(local.cfc)>

				<!--- cfcomponent --->
				<cfset local.component_data = local.parser.GetComponentData()>
				<cfset local.component_data.cfc_file = qComp[local.i]>
				<cfset local.component_data.cfc_project = proj.proj_id>
				<cfif local.component_data.cfc_name eq "">
					<cfset local.component_data.cfc_name = local.component_data.cfc_file>
				</cfif>

				<cfset local.component_data.cfc_id = local.ComponentData.Create(local.component_data)>
				<div class="component">#local.component_data.cfc_name#</div>

				<!--- cffunction --->
				<cfset local.component_functions = local.parser.GetFunctions()>
				<cfloop from="1" to="#ArrayLen(local.component_functions)#" index="local.i">
					<cfset local.component_functions[local.i].func_component = local.component_data.cfc_id>

					<cfset local.component_functions[local.i].func_id = local.FunctionData.Create(local.component_functions[local.i])>
					<div class="function">#local.component_functions[local.i].func_name#() #ArrayLen(local.component_functions[local.i].cfarguments)# args</div>

					<!--- cfarguments --->
					<cfloop from="1" to="#ArrayLen(local.component_functions[local.i].cfarguments)#" index="local.ii">
						<cfset local.component_functions[local.i].cfarguments[local.ii].param_function = local.component_functions[local.i].func_id>
						<cfset local.component_functions[local.i].cfarguments[local.ii].param_id = local.ParameterData.Create(local.component_functions[local.i].cfarguments[local.ii])>
					</cfloop>
				</cfloop>

			</cfloop>

		</cfoutput>
	</cffunction>


</cfcomponent>