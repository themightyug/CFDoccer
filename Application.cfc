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

		<cfreturn true>
	</cffunction>


	<cffunction name="OnRequest">
		<cfargument type="String" name="targetPage" required="true"/>

		<cfset session.Global.test = "moo">
		<cfset variables.global = session.Global>

		<cfinclude template="#arguments.targetPage#">
	</cffunction>



</cfcomponent>