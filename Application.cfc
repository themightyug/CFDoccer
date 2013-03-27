<!---

	CFDoccer - CFC Documenter

	ross, 26/03/2013, creation

--->
<cfcomponent output="false" displayname="Application">
	<cfset This.name = "CFDoccer">
	<cfset This.Sessionmanagement = true>
	<cfset This.applicationtimeout = "#createtimespan(5,0,0,0)#">


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
		<cfset request.Global = structnew()>

		<cfif application.ServerRole eq "development">
			<cfset request.Global.CfcPrefix = "cfdoccer.cfc.">
			<cfset request.Global.DSN = "cfdoccer">
		<cfelseif application.ServerRole eq "live">

		</cfif>

		<cfreturn true>
	</cffunction>


</cfcomponent>