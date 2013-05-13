<!---

	CFDoccer

	Documentation Header

	ross, 12/05/2013, creation

--->
<cfoutput>


<!doctype HTML>
<html>
	<head>
		<title>#Page.Title#</title>
		<style type="text/css">
			<cfloop list="#Page.Css#" index="css">
				@import "./#css#";
			</cfloop>
		</style>
		<script src="./jquery-1.9.1.min.js" type="text/javascript"></script>
		<cfloop list="#Page.Js#" index="js">
			<script src="./#js#" type="text/javascript"></script>
		</cfloop>
	</head>

	<body>

		<div id="bodyOuter">
			<div id="bodyInner">
				<div id="content">

					<h1>#Page.Title#</h1>

</cfoutput>