<!---

	CFDoccer

	Doccer component

	ross, 06/05/2013, creation

--->
<cfcomponent displayname="Doccer" output="false">


	<cfset doc_root = "">


	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">
		<cfargument name="r" required="yes" hint="project doc root full path">

		<cfset global = arguments.g>
		<cfset doc_root = arguments.r>
	</cffunction>


	<cffunction name="GenerateBuildUrl">
		<cfargument name="class" required="yes">
		<cfargument name="id" required="yes">

		<cfset var local = structnew()>

		<cfset local.url = "http://#cgi.server_name#:#cgi.server_port#">

		<cfset local.url = local.url & REReplaceNoCase(cgi.script_name, "\/project_refresh\.cfm$", "", "ALL")>
		<cfset local.url = ListAppend(local.url, "build", "/")>
		<cfset local.url = ListAppend(local.url, "#arguments.class#.cfm?id=#UrlEncodedFormat(arguments.id)#", "/")>

		<cfreturn local.url>
	</cffunction>


	<cffunction name="ClearDirectory">
		<cfset var local = structnew()>

		<cfif DirectoryExists(doc_root)>
			<cfdirectory action="list" directory="#doc_root#" name="local.qDir" type="file">

			<cfloop query="local.qDir">
				<cffile action="delete" file="#doc_root##local.qDir.name#">
				<cfoutput><div class="status">Deleting #doc_root##local.qDir.name#</div></cfoutput>
			</cfloop>
		<cfelse>
			<cfoutput><div class="status">Creating doc root #doc_root#</div></cfoutput>
			<cfdirectory action="create" directory="#doc_root#">
		</cfif>
	</cffunction>


	<cffunction name="CopySkelFiles">
		<cfset var local = structnew()>

		<cfset local.files = "cfdoccer.css,jquery-1.9.1.min.js">

		<cfloop list="#local.files#" index="local.f">
			<cfset local.src = ExpandPath(global.Root) & "build/" & local.f>
			<cfset local.dest = doc_root>

			<cfoutput><div class="status">Copying #local.f#</div></cfoutput>

			<cffile action="copy" source="#local.src#" destination="#local.dest#">
		</cfloop>
	</cffunction>


	<cffunction name="DocumentProject">
		<cfargument name="qProj" required="yes">

		<cfset var local = structnew()>

		<!--- copy associated css and js files --->
		<cfset CopySkelFiles()>

		<cfset local.build_url = GenerateBuildUrl("project", arguments.qProj.proj_id)>

		<cfoutput><div class="status">Using #local.build_url#</div></cfoutput>

		<cfhttp url="#local.build_url#" result="local.html" timeout="240">

		<cfif local.html.statuscode neq "200 OK">
			<cfoutput><div class="error"><cfdump var="#local.html#"></div></cfoutput>
			<cfreturn>
		</cfif>

		<cfset local.filename = "index.html">

		<cffile action="write" charset="#local.html.charset#" file="#doc_root##local.filename#" output="#local.html.filecontent#">

		<cfoutput><div class="status">Written #doc_root##local.filename#</div></cfoutput>
	</cffunction>


	<cffunction name="DocumentComponents">
		<cfargument name="qCom" required="yes">

		<cfset var local = structnew()>

		<cfloop query="arguments.qCom">
			<cfset local.build_url = GenerateBuildUrl("component", arguments.qCom.cfc_id)>

			<cfoutput><div class="status">Using #local.build_url#</div></cfoutput>

			<cfhttp url="#local.build_url#" result="local.html" timeout="240">

			<cfif local.html.statuscode neq "200 OK">
				<cfoutput><div class="error"><cfdump var="#local.html#"></div></cfoutput>
				<cfreturn>
			</cfif>

			<cfset local.filename = "#arguments.qCom.cfc_name#.html">

			<cffile action="write" charset="#local.html.charset#" file="#doc_root##local.filename#" output="#local.html.filecontent#">

			<cfoutput><div class="status">Written #doc_root##local.filename#</div><cfflush></cfoutput>
		</cfloop>
	</cffunction>


</cfcomponent>