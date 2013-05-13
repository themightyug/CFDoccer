<!---

	CFDoccer

	ross, 18/04/2013, creation

--->
<cfcomponent displayname="ParameterData" output="false">

	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">

		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="New">
		<cfset var local = structnew()>

		<cfset local.parameter = structnew()>
		<cfset local.parameter.param_id = "">
		<cfset local.parameter.param_function = "">
		<cfset local.parameter.param_name = "">
		<cfset local.parameter.param_order = "">
		<cfset local.parameter.param_hint = "">
		<cfset local.parameter.param_required = "">
		<cfset local.parameter.param_default = "">
		<cfset local.parameter.param_type = "">

		<cfreturn local.parameter>
	</cffunction>


	<cffunction name="Create">
		<cfargument name="parameter" required="yes">

		<cfset var local = structnew()>

		<cfquery result="local.q" datasource="#global.DSN#">
			INSERT INTO APP."parameter" (
				"param_function",
				"param_name",
				"param_order",
				"param_hint",
				"param_required",
				"param_default",
				"param_type"
			) VALUES (
				#Val(arguments.parameter.param_function)#,
				'#arguments.parameter.param_name#',
				#Val(arguments.parameter.param_order)#,
				'#arguments.parameter.param_hint#',
				#Iif(Val(arguments.parameter.param_required) eq 0, de("false"), de("true"))#,
				'#arguments.parameter.param_default#',
				'#arguments.parameter.param_type#'
			)
		</cfquery>

		<cfreturn local.q.IDENTITYCOL>
	</cffunction>


	<cffunction name="Update">
		<cfargument name="parameter" required="yes">

		<cfquery datasource="#global.DSN#">
			UPDATE APP."parameter"
			SET
				"param_function" = #Val(arguments.parameter.param_function)#,
				"param_name" = '#arguments.parameter.param_name#,
				"param_order" = #Val(arguments.parameter.param_order)#,
				"param_hint" = '#arguments.parameter.param_hint#',
				"param_required" = #Val(arguments.parameter.param_required)#,
				"param_default" = '#arguments.parameter.param_default#',
				"param_type" = '#arguments.parameter.param_type#'
			WHERE
				"param_id" = #val(arguments.parameter.param_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Delete">
		<cfargument name="param_id" required="yes">

		<cfquery datasource="#global.DSN#">
			DELETE FROM
				APP."parameter"
			WHERE
				"param_id" = #val(arguments.parameter.param_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Select">
		<cfargument name="param_id" required="yes">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."parameter"
			WHERE
				"param_id" = #val(arguments.param_id)#
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="SelectAll">
		<cfargument name="function" required="no" default="">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."parameter"
			<cfif arguments.function neq "">
				WHERE "param_function" = #val(arguments.function)#
			</cfif>
			ORDER BY
				"param_order"
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="GetParameterSummary">
		<cfargument name="func_id" required="yes">

		<cfset var local = structnew()>
		<cfset local.result = "">

		<cfset local.qParam = SelectAll(arguments.func_id)>

		<cfloop query="local.qParam">
			<cfset local.result = ListAppend(local.result, "#local.qParam.param_type# #local.qParam.param_name##iif(local.qParam.param_required eq 1, de("*"), de(""))#")>
		</cfloop>

		<cfreturn local.result>
	</cffunction>


</cfcomponent>