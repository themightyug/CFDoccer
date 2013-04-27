<!---

	CFDoccer - CFC Documenter

	ross, 26/03/2013, creation

--->
<cfcomponent name="Application" output="false" displayname="Application">
	<cfset This.name = "CFDoccer">
	<cfset This.Sessionmanagement = true>
	<cfset This.applicationtimeout = "#createtimespan(0,0,0,1)#">
	<cfset This.sessiontimeout = "#CreateTimeSpan(0,0,0,1)#">


	<cffunction name="OnApplicationStart">
		<cfset StructClear(application)>

		<cfset application.ServerRole = "development">
		<cfif cgi.SERVER_NAME eq "127.0.0.1">
			<cfset application.ServerRole = "development">
			<cfsetting requesttimeout="60" showdebugoutput="true" enablecfoutputonly="true"
/>
		<cfelseif cgi.SERVER_NAME eq "10.8.0.1">
			<cfset application.ServerRole = "live">
			<cfsetting requesttimeout="60" showdebugoutput="false" enablecfoutputonly="true"
/>
		</cfif>

		<cfreturn true>
	</cffunction>


	<cffunction name="OnSessionStart">
		<cfset session.Global = StructNew()>

		<cfif application.ServerRole eq "development">
			<cfset session.Global.CfcPrefix = "cfdoccer.cfc.">
			<cfset session.Global.DSN = "cfdoccer">
		<cfelseif application.ServerRole eq "live">

		</cfif>

		<cfset session.Global.DateFormat = "dd/mm/yyyy">
		<cfset session.Global.TimeFormat = "HH:mm:ss">

		<cfparam name="session.msg" default="">

		<cfreturn true>
	</cffunction>


	<cffunction name="OnRequestStart">
		<cfargument type="String" name="template" required="true">

		<cfset var local = StructNew()>

		<cfset local.basePath = getDirectoryFromPath(
			getCurrentTemplatePath()
		)/>
		<cfset local.targetPath = getDirectoryFromPath(
			expandPath(arguments.template)
		)/>
		<cfset local.requestDepth = (
			listLen( local.targetPath, "\/" ) -
			listLen( local.basePath, "\/" )
		)/>
		<cfset request.webRoot = repeatString(
			"../",
			local.requestDepth
		)/>
		<cfif local.requestDepth eq 0>
			<cfset request.webRoot = "./">
		</cfif>

		<cfset session.Global.Root = request.webRoot>
		<cfset session.Global.Path = StructNew()>
		<cfset session.Global.Path.Includes = session.Global.Root & "_ssi/">

		<cfset session.Global.Url = StructNew()>
		<cfset session.Global.Url.Css = session.Global.Root & "css/">
		<cfset session.Global.Url.Js = session.Global.Root & "js/">
		<cfset session.Global.Url.Img = session.Global.Root & "img/">
	</cffunction>


	<cffunction name="OnRequest">
		<cfargument type="String" name="targetPage" required="true"/>

		<cfset variables.global = session.Global>

		<cfset var PageData = CreateObject("component", "#variables.global.CfcPrefix#Page")>
		<cfset PageData.Init(variables.global)>
		<cfset variables.Page = PageData.NewPage()>

		<cfinclude template="#arguments.targetPage#">
	</cffunction>



</cfcomponent>