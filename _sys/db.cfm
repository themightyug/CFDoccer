

<!---
<cfquery datasource="#global.DSN#">
	DROP TABLE "APP"."parameter"
</cfquery>
<cfquery datasource="#global.DSN#">
	DROP TABLE "APP"."component"
</cfquery>
<cfquery datasource="#global.DSN#">
	DROP TABLE "APP"."function"
</cfquery>
<cfquery datasource="#global.DSN#">
	DROP TABLE "APP"."changelog"
</cfquery>
<cfquery datasource="#global.DSN#">
	DROP TABLE "APP"."project"
</cfquery>
--->
<!---
<cfquery datasource="#global.DSN#">
CREATE TABLE "APP"."parameter" (
		"param_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"param_function" INTEGER,
		"param_name" VARCHAR(256),
		"param_order" INTEGER,
		"param_hint" VARCHAR(256),
		"param_required" BOOLEAN NOT NULL,
		"param_default" VARCHAR(256),
		"param_type" VARCHAR(256),
		PRIMARY KEY ("param_id")
	)
</cfquery>


<cfquery datasource="#global.DSN#">
CREATE TABLE "APP"."component" (
		"cfc_comments" VARCHAR(1024),
		"cfc_hint" VARCHAR(256),
		"cfc_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"cfc_project" INTEGER,
		"cfc_file" VARCHAR(512),
		"cfc_name" VARCHAR(258),
		PRIMARY KEY ("cfc_id")
	)
</cfquery>


<cfquery datasource="#global.DSN#">
CREATE TABLE "APP"."function" (
		"func_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"func_component" INTEGER,
		"func_name" VARCHAR(256),
		"func_line" INTEGER,
		"func_hint" VARCHAR(256),
		"func_returns" VARCHAR(256),
		"func_comments" VARCHAR(512),
		PRIMARY KEY ("func_id")
	)
</cfquery>


<cfquery datasource="#global.DSN#">
CREATE TABLE "APP"."changelog" (
		"chlog_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"chlog_component" INTEGER,
		"chlog_person" VARCHAR(256),
		"chlog_date" DATE,
		"chlog_message" VARCHAR(512),
		PRIMARY KEY ("chlog_id")
	)
</cfquery>



<cfquery datasource="#global.DSN#">
CREATE TABLE "APP"."project" (
		"proj_cfc_root" VARCHAR(255),
		"proj_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"proj_name" VARCHAR(256),
		"proj_path" VARCHAR(282),
		"proj_refreshed" TIMESTAMP,
		"proj_doc_url" VARCHAR(256),
		PRIMARY KEY ("proj_id")
	)
</cfquery>
--->

<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_func_name" ON "APP"."function" ("func_name" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_chlog_date" ON "APP"."changelog" ("chlog_date" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_proj_name" ON "APP"."project" ("proj_cfc_root" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_func_component" ON "APP"."function" ("func_component" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_proj_path" ON "APP"."project" ("proj_path" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_chlog_component" ON "APP"."changelog" ("chlog_component" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_cfc_file" ON "APP"."component" ("cfc_file" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_param_function" ON "APP"."parameter" ("param_function" ASC)
</cfquery>
<cfquery datasource="#global.DSN#">
	CREATE INDEX "APP"."idx_param_order" ON "APP"."parameter" ("param_order" ASC)
</cfquery>