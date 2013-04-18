<cfquery datasource="#global.DSN#">
	ALTER TABLE APP."project"
	ADD COLUMN "proj_refreshed" TIMESTAMP
</cfquery>