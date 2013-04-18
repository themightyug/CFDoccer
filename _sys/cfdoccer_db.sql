--<ScriptOptions statementTerminator=";"/>

DROP INDEX "APP"."idx_func_name";

DROP INDEX "APP"."SQL130325233230880";

DROP INDEX "APP"."idx_chlog_date";

DROP INDEX "APP"."SQL130325233809220";

DROP INDEX "APP"."idx_proj_name";

DROP INDEX "APP"."SQL130325234129120";

DROP INDEX "APP"."SQL130325233634710";

DROP INDEX "APP"."idx_func_component";

DROP INDEX "APP"."idx_proj_path";

DROP INDEX "APP"."idx_chlog_component";

DROP INDEX "APP"."idx_cfc_file";

DROP INDEX "APP"."idx_param_function";

DROP INDEX "APP"."SQL130325234304740";

DROP INDEX "APP"."idx_param_order";

DROP TABLE "APP"."parameter";

DROP TABLE "APP"."component";

DROP TABLE "APP"."function";

DROP TABLE "APP"."changelog";

DROP TABLE "APP"."project";

CREATE TABLE "APP"."parameter" (
		"param_id" INTEGER NOT NULL,
		"param_function" INTEGER,
		"param_name" VARCHAR(256),
		"param_order" INTEGER,
		"param_hint" VARCHAR(256),
		"param_required" null,
		"param_default" VARCHAR(256),
		"param_type" VARCHAR(256)
	);

CREATE TABLE "APP"."component" (
		"cfc_comments" VARCHAR(1024),
		"cfc_hint" VARCHAR(256),
		"cfc_id" INTEGER NOT NULL,
		"cfc_project" INTEGER,
		"cfc_file" VARCHAR(512),
		"cfc_name" VARCHAR(258)
	);

CREATE TABLE "APP"."function" (
		"func_id" INTEGER NOT NULL,
		"func_component" INTEGER,
		"func_name" VARCHAR(256),
		"func_line" INTEGER,
		"func_hint" VARCHAR(256),
		"func_returns" VARCHAR(256),
		"func_comments" VARCHAR(512)
	);

CREATE TABLE "APP"."changelog" (
		"chlog_id" INTEGER NOT NULL,
		"chlog_component" INTEGER,
		"chlog_person" VARCHAR(256),
		"chlog_date" DATE,
		"chlog_message" VARCHAR(512)
	);

CREATE TABLE "APP"."project" (
		"proj_cfc_root" VARCHAR(255),
		"proj_id" INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		"proj_name" VARCHAR(256),
		"proj_path" VARCHAR(282),
		PRIMARY KEY ("proj_id")
	);

CREATE INDEX "APP"."idx_func_name" ON "APP"."function" ("func_name" ASC);

CREATE UNIQUE INDEX "APP"."SQL130325233230880" ON "APP"."project" ("proj_id" ASC);

CREATE INDEX "APP"."idx_chlog_date" ON "APP"."changelog" ("chlog_date" ASC);

CREATE UNIQUE INDEX "APP"."SQL130325233809220" ON "APP"."component" ("cfc_id" ASC);

CREATE INDEX "APP"."idx_proj_name" ON "APP"."project" ("proj_cfc_root" ASC);

CREATE UNIQUE INDEX "APP"."SQL130325234129120" ON "APP"."parameter" ("param_id" ASC);

CREATE UNIQUE INDEX "APP"."SQL130325233634710" ON "APP"."function" ("func_id" ASC);

CREATE INDEX "APP"."idx_func_component" ON "APP"."function" ("func_component" ASC);

CREATE INDEX "APP"."idx_proj_path" ON "APP"."project" ("proj_path" ASC);

CREATE INDEX "APP"."idx_chlog_component" ON "APP"."changelog" ("chlog_component" ASC);

CREATE UNIQUE INDEX "APP"."idx_cfc_file" ON "APP"."component" ("cfc_file" ASC);

CREATE INDEX "APP"."idx_param_function" ON "APP"."parameter" ("param_function" ASC);

CREATE UNIQUE INDEX "APP"."SQL130325234304740" ON "APP"."changelog" ("chlog_id" ASC);

CREATE INDEX "APP"."idx_param_order" ON "APP"."parameter" ("param_order" ASC);

