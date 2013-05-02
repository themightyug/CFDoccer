<!---

	CFDoccer

	ross, 07/04/2013, creation

--->

<cfcomponent displayname="ComponentData" hint="Component data access component" output="false">

	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">

		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="New">
		<cfset var local = structnew()>

		<cfset local.component = structnew()>
		<cfset local.component.cfc_id = "">
		<cfset local.component.cfc_hint = "">
		<cfset local.component.cfc_name = "">
		<cfset local.component.cfc_file = "">
		<cfset local.component.cfc_comments = "">
		<cfset local.component.cfc_project = "">

		<cfreturn local.component>
	</cffunction>


	<cffunction name="Create">
		<cfargument name="component" required="yes">

		<cfset var local = structnew()>

		<cfquery result="local.q" datasource="#global.DSN#">
			INSERT INTO APP."component" (
				"cfc_hint",
				"cfc_name",
				"cfc_file",
				"cfc_comments",
				"cfc_project"
			) VALUES (
				'#arguments.component.cfc_hint#',
				'#arguments.component.cfc_name#',
				'#arguments.component.cfc_file#',
				'#Left(arguments.component.cfc_comments, 1024)#',
				#val(arguments.component.cfc_project)#
			)
		</cfquery>

		<cfreturn local.q.IDENTITYCOL>
	</cffunction>


	<cffunction name="Update">
		<cfargument name="component" required="yes">

		<cfquery datasource="#global.DSN#">
			UPDATE APP."component"
			SET
				"cfc_hint" = '#arguments.component.cfc_hint#',
				"cfc_name" = '#arguments.component.cfc_name#,
				"cfc_file" = '#arguments.component.cfc_file#',
				"cfc_comments" = '#arguments.component.cfc_comments#',
				"cfc_project" = #val(arguments.component.cfc_project)#
			WHERE
				"cfc_id" = #val(arguments.component.cfc_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Delete">
		<cfargument name="cfc_id" required="yes">

		<cfquery datasource="#global.DSN#">
			DELETE FROM
				APP."component"
			WHERE
				"cfc_id" = #val(arguments.component.cfc_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Select">
		<cfargument name="cfc_id" required="yes">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."component"
			WHERE
				"cfc_id" = #val(arguments.cfc_id)#
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="SelectAll">
		<cfargument name="project" required="no" default="">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				APP."component"
			<cfif arguments.project neq "">
				WHERE "cfc_project" = #val(arguments.project)#
			</cfif>
			ORDER BY
				"cfc_name"
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="ClearProject">
		<cfargument name="proj_id" required="yes">

		<cfquery datasource="#global.DSN#">
			DELETE FROM APP."parameter"
			WHERE "param_function" IN (
				SELECT "func_id"
				FROM APP."function"
				WHERE "func_component" IN (
					SELECT "cfc_id"
					FROM APP."component"
					WHERE "cfc_project" = #val(arguments.proj_id)#
				)
			)
		</cfquery>

		<cfquery datasource="#global.DSN#">
			DELETE FROM APP."function"
			WHERE "func_component" IN (
				SELECT "cfc_id"
				FROM APP."component"
				WHERE "cfc_project" = #val(arguments.proj_id)#
			)
		</cfquery>

		<cfquery datasource="#global.DSN#">
			DELETE FROM APP."component"
			WHERE "cfc_project" = #val(arguments.proj_id)#
		</cfquery>
	</cffunction>


</cfcomponent>