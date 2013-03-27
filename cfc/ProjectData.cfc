<!---

	CFDoccer

	ross, 27/03/2013, creation

--->

<cfcomponent displayname="ProjectData" hint="Project data access component" output="false">

	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">

		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="New">
		<cfset var local = structnew()>

		<cfset local.project = structnew()>
		<cfset local.project.proj_id = "">
		<cfset local.project.proj_cfc_root = "">
		<cfset local.project.proj_name = "">
		<cfset local.project.proj_path = "">

		<cfreturn local.project>
	</cffunction>


	<cffunction name="Create">
		<cfargument name="project" required="yes">

		<cfset var local = structnew()>

		<cfquery result="local.q" datasource="#global.DSN#">
			INSERT INTO project (
				proj_cfc_root,
				proj_name,
				proj_path
			) VALUES (
				'#arguments.project.proj_cfc_root#',
				'#arguments.project.proj_name#',
				'#arguments.project.proj_path#'
			)
		</cfquery>

		<cfreturn local.q.IDENTITYCOL>
	</cffunction>


	<cffunction name="Update">
		<cfargument name="project" required="yes">

		<cfquery datasource="#global.DSN#">
			UPDATE project
			SET
				proj_cfc_root = '#arguments.project.proj_cfc_root#',
				proj_name = '#arguments.project.proj_name#,
				proj_path = '#arguments.project.proj_path#'
			WHERE
				proj_id = #val(arguments.project.proj_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Delete">
		<cfargument name="proj_id" required="yes">

		<cfquery datasource="#global.DSN#">
			DELETE FROM
				project
			WHERE
				proj_id = #val(arguments.project.proj_id)#
		</cfquery>
	</cffunction>


	<cffunction name="Select">
		<cfargument name="proj_id" required="yes">

		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				project
			WHERE
				proj_id = #val(arguments.proj_id)#
		</cfquery>

		<cfreturn local.q>
	</cffunction>


	<cffunction name="SelectAll">
		<cfset var local = structnew()>

		<cfquery name="local.q" datasource="#global.DSN#">
			SELECT
				*
			FROM
				project
			ORDER BY
				proj_name
		</cfquery>

		<cfreturn local.q>
	</cffunction>


</cfcomponent>