<!---

	CFDoccer

	ross, 18/04/2013, creation

--->

<cfcomponent displayname="FunctionData" output="false">

	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">

		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="New">
		<cfset var local = structnew()>

		<cfset local.function = structnew()>
		<cfset local.function.func_id = "">
		<cfset local.function.func_component = "">
		<cfset local.function.func_name = "">
		<cfset local.function.func_line = "">
		<cfset local.function.func_hint = "">
		<cfset local.function.func_returns = "">
		<cfset local.function.func_comments = "">

		<cfreturn local.function>
	</cffunction>


	<cffunction name="Create">
		<cfargument name="component" required="yes">

		<cfset var local = structnew()>

		<cfquery result="local.q" datasource="#global.DSN#">
			INSERT INTO APP."function" (
				"func_component",
				"func_name",
				"func_line",
				"func_hint",
				"func_returns",
				"func_comments"
			) VALUES (
				#Val(arguments.function.func_component)#,
				'#arguments.function.func_name#',
				#Val(arguments.function.func_line)#,
				'#arguments.function.func_hint#',
				'#arguments.function.fun_returns#',
				'#arguments.function.func_comments#'
			)
		</cfquery>

		<cfreturn local.q.IDENTITYCOL>
	</cffunction>


	<cffunction name="Update">
		<cfargument name="component" required="yes">

		<cfquery datasource="#global.DSN#">
			UPDATE APP."function"
			SET
				"func_component" = #Val(arguments.function.func_component)#,
				"func_name" = '#arguments.function.func_name#,
				"func_line" = #Val(arguments.function.func_line)#,
				"func_hint" = '#arguments.function.func_hint#',
				"func_returns" = '#arguments.function.func_returns#',
				"func_comments" = '#arguments.function.func_comments#'
			WHERE
				"func_id" = #val(arguments.function.func_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Delete">
		<cfargument name="func_id" required="yes">

		<cfquery datasource="#global.DSN#">
			DELETE FROM
				APP."function"
			WHERE
				"func_id" = #val(arguments.function.func_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Select">
		<cfargument name="func_id" required="yes">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."function"
			WHERE
				"func_id" = #val(arguments.func_id)#
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="SelectAll">
		<cfargument name="component" required="no" default="">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."function"
			<cfif arguments.component neq "">
				WHERE "func_component" = #val(arguments.component)#
			</cfif>
			ORDER BY
				"func_name"
		</cfquery>

		<cfreturn local.q>
	</cffunction>


</cfcomponent>