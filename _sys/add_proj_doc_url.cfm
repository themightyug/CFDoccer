<cfquery datasource="#global.DSN#">
	ALTER TABLE APP."project"
	ADD COLUMN "proj_doc_url" VARCHAR(256)
</cfquery>