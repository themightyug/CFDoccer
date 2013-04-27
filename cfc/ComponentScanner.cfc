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

		<cfset local.parser = CreateObject("component", "#global.CfcPrefix#ComponentParser")>
		<cfset local.parser.Init(global)>

		<cfoutput>

			<cfloop from="1" to="#ArrayLen(qComp)#" index="local.i">
				<cfset local.cfc_path = ComponentPath(qComp[local.i])>
				<div class="status">Opening #local.cfc_path#</div>

				<cfset local.cfc = FileRead(local.cfc_path)>
				<div class="status">File size: #LSNumberFormat(Len(local.cfc))# bytes</div>

				<cfset local.parser.SetDocument(local.cfc)>

				<cfset local.component_data = local.parser.GetComponentData()>

				<cfset local.component_data.cfc_file = qComp[local.i]>
				<cfset local.component_data.cfc_project = proj.proj_id>
				<cfif local.component_data.cfc_name eq "">
					<cfset local.component_data.cfc_name = local.component_data.cfc_file>
				</cfif>

				<cfdump var="#local.component_data#">
			</cfloop>

		</cfoutput>
	</cffunction>


</cfcomponent>