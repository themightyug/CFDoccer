<!---

	CFDoccer

	Page Header

	ross, 18/04/2013, creation

--->
<cfoutput>


<!doctype HTML>
<html>
	<head>
		<title>#Page.Title# - CFDoccer</title>
		<style type="text/css">
			<cfloop list="#Page.Css#" index="css">
				@import "#global.Url.Css##css#";
			</cfloop>
		</style>
		<cfloop list="#Page.Js#" index="js">
			<script src="#global.Url.Js##js#" type="text/javascript"></script>
		</cfloop>
	</head>

	<body>

		<div id="bodyOuter">
			<div id="bodyInner">
				<div id="content">

					<h1>#Page.Title#</h1>

</cfoutput>