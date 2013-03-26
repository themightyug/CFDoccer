CREATE TABLE project (proj_cfc_root VARCHAR(256),
 proj_id INTEGER PRIMARY KEY,
 proj_name VARCHAR(256),
 proj_path VARCHAR(256));
CREATE TABLE function (func_id INTEGER PRIMARY KEY,
 func_component NUMERIC,
 func_name VARCHAR(256),
 func_line NUMERIC,
 func_hint VARCHAR(256),
 func_returns VARCHAR(256),
 func_comments VARCHAR(256));
CREATE TABLE component (cfc_comments VARCHAR(256),
 cfc_hint VARCHAR(256),
 cfc_id INTEGER PRIMARY KEY,
 cfc_project NUMERIC,
 cfc_file VARCHAR(256),
 cfc_name VARCHAR(256));
CREATE TABLE parameter (param_id INTEGER PRIMARY KEY,
 param_function NUMERIC,
 param_name VARCHAR(256),
 param_order NUMERIC,
 param_hint VARCHAR(256),
 param_required VARCHAR(256),
 param_default VARCHAR(256),
 param_type VARCHAR(256));
CREATE TABLE changelog (chlog_id INTEGER PRIMARY KEY,
 chlog_component NUMERIC,
 chlog_person VARCHAR(256),
 chlog_date VARCHAR(256),
 chlog_message VARCHAR(256));
CREATE INDEX idx_proj_name ON project(proj_name ASC);
CREATE UNIQUE INDEX idx_proj_path ON project(proj_path ASC);
CREATE INDEX idx_cfc_file ON component(cfc_file ASC);
CREATE INDEX idx_func_component ON function(func_component ASC);
CREATE INDEX idx_func_name ON function(func_name ASC);
CREATE INDEX idx_param_function ON parameter(param_function ASC);
CREATE INDEX idx_param_order ON parameter(param_order ASC);
CREATE INDEX idx_chlog_component ON changelog(chlog_component ASC);
CREATE INDEX idx_chlog_date ON changelog(chlog_date ASC);

