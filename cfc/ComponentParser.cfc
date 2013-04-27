<!---

	CFDoccer

	Component parser

	ross, 25/04/2013, creation

--->

<cfcomponent displayname="ComponentParser" output="false">

	<cfset document = "">


	<cffunction name="Init">
		<cfargument name="g" required="yes" hint="request.global">
		<cfset global = arguments.g>
	</cffunction>


	<cffunction name="SetDocument">
		<cfargument name="doc" required="yes">

		<cfset document = arguments.doc>
	</cffunction>


	<cffunction name="GetComponentData">
		<cfset var local = structnew()>

		<cfset local.ComponentData = CreateObject("component", "#global.CfcPrefix#ComponentData")>
		<cfset local.ComponentData.Init(global)>
		<cfset local.cfc = ComponentData.New()>

		<cfset local.cfc.cfc_hint = "">
		<cfset local.cfc.cfc_name = "">
		<cfset local.cfc.cfc_comments = "">


		<!--- comments --->
		<cfset local.regex = "\<!---[^\>]*---\>">
		<cfset local.found = REFind(local.regex, document, 1, true)>
		<cfif ArrayLen(local.found.pos) gt 0 and ArrayLen(local.found.len) gt 0>
			<cfif local.found.pos[1] gt 0 and local.found.len[1] gt 0>
				<cfset local.cfc.cfc_comments = Trim(Mid(document, local.found.pos[1], local.found.len[1]))>
			</cfif>
		</cfif>

		<!--- cfcomponent tag --->
		<cfset local.regex = "\<cfcomponent [^\>]*\>">
		<cfset local.found = REFindNoCase(local.regex, document, 1, true)>
		<cfif ArrayLen(local.found.pos) gt 0 and ArrayLen(local.found.len) gt 0>
			<cfif local.found.pos[1] gt 0 and local.found.len[1] gt 0>
				<cfset local.cfcomponent_tag = Trim(Mid(document, local.found.pos[1], local.found.len[1]))>

				<cfset local.cfc.cfc_hint = GetAttributeValue(local.cfcomponent_tag, "hint")>

				<cfset local.cfc.cfc_name = GetAttributeValue(local.cfcomponent_tag, "displayname")>
			</cfif>
		</cfif>


		<cfreturn local.cfc>
	</cffunction>


	<cffunction name="GetAttributeValue">
		<cfargument name="tag" required="yes">
		<cfargument name="attr_name" required="yes">

		<cfset var local = structnew()>
		<cfset local.attr_value = "">

		<cfset local.found = REFindNoCase("#arguments.attr_name#=\""[a-zA-Z0-9 ]+\""", arguments.tag, 1, true)>
		<cfif ArrayLen(local.found.pos) gt 0 and ArrayLen(local.found.len) gt 0>
			<cfloop from="1" to="#ArrayLen(local.found.pos)#" index="local.i">
				<cfif local.found.pos[local.i] gt 0 and local.found.len[local.i] gt 0>
					<cfset local.pair = Mid(arguments.tag, local.found.pos[local.i], local.found.len[local.i])>
					<cfif ListLen(local.pair, "=") eq 2>
						<cfif LCase(ListFirst(local.pair, "=")) eq LCase(arguments.attr_name)>
							<cfset local.attr_value = ListLast(local.pair, "=")>
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn local.attr_value>
	</cffunction>


</cfcomponent>