<!---

	CFDoccer

	Page Class

	ross, 18/04/2013, creation

--->


<cfcomponent hint="Page class">

	<cffunction name="Init" access="public">
		<cfargument name="g" required="yes" hint="Global variable structure">
		<cfset global = g>
	</cffunction>


	<cffunction name="NewPage" access="public" hint="Returns a new page structure">
		<cfset var local = structnew()>
		<cfset local.Page = structnew()>

		<!--- Default values --->
		<cfset local.Page.Title = "CFDoccer">
		<cfset local.Page.Type = "public">
		<cfset local.Page.Css = "main.css">
		<cfset local.Page.Js = "">
		<cfset local.Page.BodyOnload = "">
		<cfset local.Page.MetaKeywords = "">
		<cfset local.Page.MetaDescription = "Generates API documentation for ColdFusion projects">
		<cfset local.Page.Content = "">

		<cfreturn local.Page>
	</cffunction>


</cfcomponent>

