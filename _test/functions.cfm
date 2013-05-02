<!---

	CFDoccer

	ross, 02/05/2013, creation

--->


<cfset FunctionData = CreateObject("component", "#global.CfcPrefix#FunctionData")>
<cfset FunctionData.Init(global)>



<cfset qFunction = FunctionData.SelectAll()>


<cfoutput>
	<cfdump var="#qFunction#">

</cfoutput>