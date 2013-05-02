<!---

	CFDoccer

	ross, 02/05/2013, creation

--->


<cfset ComponentData = CreateObject("component", "#global.CfcPrefix#ComponentData")>
<cfset ComponentData.Init(global)>



<cfset qComponent = ComponentData.SelectAll()>


<cfoutput>
	<cfdump var="#qComponent#">

</cfoutput>