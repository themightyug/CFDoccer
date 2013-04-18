<!---

	CFDoccer

	ross, 27/03/2013, creation

--->


<cfset ProjectData = CreateObject("component", "#global.CfcPrefix#ProjectData")>
<cfset ProjectData.Init(global)>



<cfset qProject = ProjectData.SelectAll()>


<cfoutput>
	<cfdump var="#global#">

	<cfdump var="#qProject#">

</cfoutput>