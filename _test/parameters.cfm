<!---

	CFDoccer

	ross, 02/05/2013, creation

--->


<cfset ParameterData = CreateObject("component", "#global.CfcPrefix#ParameterData")>
<cfset ParameterData.Init(global)>



<cfset qParameter = ParameterData.SelectAll()>


<cfoutput>
	<cfdump var="#qParameter#">

</cfoutput>