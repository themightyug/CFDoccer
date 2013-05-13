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
				<cfset local.cfc.cfc_comments = Trim(Mid(document, local.found.pos[1]+5, local.found.len[1]-9))>
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


	<cffunction name="GetFunctions">
		<cfset var local = structnew()>
		<cfset local.functions = arraynew(1)>

		<cfset local.FunctionData = CreateObject("component", "#global.CfcPrefix#FunctionData")>
		<cfset local.FunctionData.Init(global)>

		<!--- find all the functions --->
		<cfset local.regex = "\<cffunction [^\>]*\>">
		<cfset local.p = 1>
		<cfset local.prev_p = 1>

		<cfset local.found = REFindNoCase(local.regex, document, local.p, true)>
		<cfloop condition="local.found.pos[1] gt 0">
			<cfset local.prev_p = local.p>
			<cfset local.found = REFindNoCase(local.regex, document, local.p, true)>
			<cfif local.found.pos[1] gt 0 and local.found.len[1] gt 0>
				<cfset local.cffunction_tag = Trim(Mid(document, local.found.pos[1], local.found.len[1]))>

				<cfset local.func = local.FunctionData.New()>
				<cfset local.func.func_name = GetAttributeValue(local.cffunction_tag, "name")>
				<cfset local.func.func_hint = GetAttributeValue(local.cffunction_tag, "hint")>
				<cfset local.func.func_returns = GetAttributeValue(local.cffunction_tag, "returntype")>

				<cfset local.comment_block = Mid(document, local.prev_p, local.found.pos[1] - local.prev_p)>
				<cfset local.func.func_comments = GetCommentsBlock(local.comment_block)>


				<!--- find all the cfarguments within the function --->
				<cfset local.func.cfarguments = ArrayNew(1)>
				<cfset local.cfargument_block_end = FindNoCase("</cffunction>", document, local.p) - local.p>
				<cfset local.cfargument_block = Mid(document, local.p, local.cfargument_block_end)>
				<cfset local.func.cfarguments = GetArguments(local.cfargument_block)>

				<cfset ArrayAppend(local.functions, local.func)>

				<cfset local.p = local.found.pos[1] + local.found.len[1]>
			</cfif>
		</cfloop>

		<cfreturn local.functions>
	</cffunction>


	<cffunction name="GetArguments">
		<cfargument name="block" required="yes">

		<cfset var local = StructNew()>
		<cfset local.args = ArrayNew(1)>

		<cfset local.ParameterData = CreateObject("component", "#global.CfcPrefix#ParameterData")>
		<cfset local.ParameterData.Init(global)>

		<cfset local.regex = "\<cfargument [^\>]*\>">
		<cfset local.p = 1>
		<cfset local.found = REFindNoCase(local.regex, arguments.block, local.p, true)>

		<cfset local.counter = 0>
		<cfloop condition="local.found.pos[1] gt 0">
			<cfset local.found = REFindNoCase(local.regex, arguments.block, local.p, true)>
			<cfif local.found.pos[1] gt 0 and local.found.len[1] gt 0>
				<cfset local.counter = local.counter + 1>

				<cfset local.cfargument_tag = Trim(Mid(arguments.block, local.found.pos[1], local.found.len[1]))>

				<cfset local.arg = local.ParameterData.New()>
				<cfset local.arg.param_name = GetAttributeValue(local.cfargument_tag, "name")>
				<cfset local.arg.param_order = local.counter>
				<cfset local.arg.param_hint = GetAttributeValue(local.cfargument_tag, "hint")>
				<cfset local.arg.param_required = GetAttributeValue(local.cfargument_tag, "required")>
				<cfset local.arg.param_default = GetAttributeValue(local.cfargument_tag, "default")>
				<cfset local.arg.param_type = GetAttributeValue(local.cfargument_tag, "type")>

				<cfif lcase(local.arg.param_required) eq "yes" or lcase(local.arg.param_required) eq "true">
					<cfset local.arg.param_required = 1>
				<cfelse>
					<cfset local.arg.param_required = 0>
				</cfif>

				<cfset ArrayAppend(local.args, local.arg)>
				<cfset local.p = local.found.pos[1] + local.found.len[1]>
			</cfif>
		</cfloop>

		<cfreturn local.args>
	</cffunction>


	<cffunction name="GetCommentsBlock">
		<cfargument name="text_block" required="yes">

		<cfset var local = structnew()>
		<cfset local.comment = "">

		<cfset arguments.text_block = REReplaceNoCase(arguments.text_block, ".*\</cffunction\>", "", "ONE")>

		<cfset local.regex = "\<!---[^\>]*---\>[\s]*$">
		<cfset local.found = REFind(local.regex, arguments.text_block, 1, true)>

		<cfif ArrayLen(local.found.pos) gt 0 and ArrayLen(local.found.len) gt 0>
			<cfif local.found.pos[1] gt 0 and local.found.len[1] gt 0>
				<cfset local.comment = Trim(Mid(arguments.text_block, local.found.pos[1], local.found.len[1]))>
			</cfif>
		</cfif>

		<cfset local.comment = REReplace(local.comment, "^\<!---", "", "ALL")>
		<cfset local.comment = REReplace(local.comment, "---\>$", "", "ALL")>

		<cfreturn local.comment>
	</cffunction>


	<cffunction name="GetAttributeValue">
		<cfargument name="tag" required="yes">
		<cfargument name="attr_name" required="yes">

		<cfset var local = structnew()>
		<cfset local.attr_value = "">

		<cfset local.found = REFindNoCase("#arguments.attr_name#[\s]*=[\s]*\""[a-zA-Z0-9 .,_\-]+\""", arguments.tag, 1, true)>
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

		<cfif Left(local.attr_value, 1) eq """" and Right(local.attr_value, 1) eq """">
			<cfset local.attr_value = Mid(local.attr_value, 2, Len(attr_value) - 2)>
		</cfif>

		<cfreturn local.attr_value>
	</cffunction>


</cfcomponent>