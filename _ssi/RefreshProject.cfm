<!---

	CFDoccer

	Project indexer

	ross, 19/04/2013, creation

--->
<cfoutput>

<cfset scanner = CreateObject("component", "#global.CfcPrefix#ComponentScanner")>
<cfset scanner.Init(global)>


<cfdirectory action="list" directory="#qProject.proj_path##qProject.proj_cfc_root#" filter="*.cfc" listinfo="name" type="file" name="qDir">

<cfset scanner.SetProject(qProject)>
<cfset scanner.LoadComponents(qDir)>
<cfset num_components = ArrayLen(scanner.GetComponentStack())>

<div class="status">Found #num_components# components</div>



<cfif num_components gt 0>
	<div class="status">Begin scanning components at #DateFormat(now(), global.DateFormat)# #TimeFormat(now(), global.TimeFormat)#</div>
	<cfset scanner.ScanComponents()>
</cfif>

</cfoutput>