--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-06-09 14:04:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 266 (class 1255 OID 39809)
-- Name: newid(); Type: FUNCTION; Schema: public; Owner: cuba
--

CREATE FUNCTION newid() RETURNS uuid
    LANGUAGE sql
    AS $$select md5(random()::text || clock_timestamp()::text)::uuid$$;


ALTER FUNCTION public.newid() OWNER TO cuba;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 247 (class 1259 OID 40074)
-- Name: act_evt_log; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_evt_log (
    log_nr_ integer NOT NULL,
    type_ character varying(64),
    proc_def_id_ character varying(64),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ bytea,
    lock_owner_ character varying(255),
    lock_time_ timestamp without time zone,
    is_processed_ smallint DEFAULT 0
);


ALTER TABLE act_evt_log OWNER TO cuba;

--
-- TOC entry 246 (class 1259 OID 40072)
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE; Schema: public; Owner: cuba
--

CREATE SEQUENCE act_evt_log_log_nr__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE act_evt_log_log_nr__seq OWNER TO cuba;

--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 246
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuba
--

ALTER SEQUENCE act_evt_log_log_nr__seq OWNED BY act_evt_log.log_nr_;


--
-- TOC entry 236 (class 1259 OID 39985)
-- Name: act_ge_bytearray; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE act_ge_bytearray OWNER TO cuba;

--
-- TOC entry 235 (class 1259 OID 39980)
-- Name: act_ge_property; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_ge_property OWNER TO cuba;

--
-- TOC entry 250 (class 1259 OID 40236)
-- Name: act_hi_actinst; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_actinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_actinst OWNER TO cuba;

--
-- TOC entry 255 (class 1259 OID 40278)
-- Name: act_hi_attachment; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64),
    time_ timestamp without time zone
);


ALTER TABLE act_hi_attachment OWNER TO cuba;

--
-- TOC entry 254 (class 1259 OID 40270)
-- Name: act_hi_comment; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE act_hi_comment OWNER TO cuba;

--
-- TOC entry 253 (class 1259 OID 40262)
-- Name: act_hi_detail; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_hi_detail OWNER TO cuba;

--
-- TOC entry 256 (class 1259 OID 40286)
-- Name: act_hi_identitylink; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64)
);


ALTER TABLE act_hi_identitylink OWNER TO cuba;

--
-- TOC entry 249 (class 1259 OID 40225)
-- Name: act_hi_procinst; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_procinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255)
);


ALTER TABLE act_hi_procinst OWNER TO cuba;

--
-- TOC entry 251 (class 1259 OID 40245)
-- Name: act_hi_taskinst; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_taskinst OWNER TO cuba;

--
-- TOC entry 252 (class 1259 OID 40254)
-- Name: act_hi_varinst; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_hi_varinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    rev_ integer,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE act_hi_varinst OWNER TO cuba;

--
-- TOC entry 257 (class 1259 OID 40312)
-- Name: act_id_group; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE act_id_group OWNER TO cuba;

--
-- TOC entry 260 (class 1259 OID 40333)
-- Name: act_id_info; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE act_id_info OWNER TO cuba;

--
-- TOC entry 258 (class 1259 OID 40320)
-- Name: act_id_membership; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE act_id_membership OWNER TO cuba;

--
-- TOC entry 259 (class 1259 OID 40325)
-- Name: act_id_user; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64)
);


ALTER TABLE act_id_user OWNER TO cuba;

--
-- TOC entry 248 (class 1259 OID 40084)
-- Name: act_procdef_info; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_procdef_info (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    rev_ integer,
    info_json_id_ character varying(64)
);


ALTER TABLE act_procdef_info OWNER TO cuba;

--
-- TOC entry 237 (class 1259 OID 39993)
-- Name: act_re_deployment; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone
);


ALTER TABLE act_re_deployment OWNER TO cuba;

--
-- TOC entry 238 (class 1259 OID 40002)
-- Name: act_re_model; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_model OWNER TO cuba;

--
-- TOC entry 241 (class 1259 OID 40029)
-- Name: act_re_procdef; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    has_graphical_notation_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_procdef OWNER TO cuba;

--
-- TOC entry 245 (class 1259 OID 40063)
-- Name: act_ru_event_subscr; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_event_subscr OWNER TO cuba;

--
-- TOC entry 239 (class 1259 OID 40011)
-- Name: act_ru_execution; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    lock_time_ timestamp without time zone
);


ALTER TABLE act_ru_execution OWNER TO cuba;

--
-- TOC entry 243 (class 1259 OID 40047)
-- Name: act_ru_identitylink; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64)
);


ALTER TABLE act_ru_identitylink OWNER TO cuba;

--
-- TOC entry 240 (class 1259 OID 40020)
-- Name: act_ru_job; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_job OWNER TO cuba;

--
-- TOC entry 242 (class 1259 OID 40038)
-- Name: act_ru_task; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    form_key_ character varying(255)
);


ALTER TABLE act_ru_task OWNER TO cuba;

--
-- TOC entry 244 (class 1259 OID 40055)
-- Name: act_ru_variable; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_ru_variable OWNER TO cuba;

--
-- TOC entry 228 (class 1259 OID 39834)
-- Name: bpm_proc_actor; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_actor (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    user_id uuid,
    proc_instance_id uuid NOT NULL,
    proc_role_id uuid NOT NULL,
    order_ integer
);


ALTER TABLE bpm_proc_actor OWNER TO cuba;

--
-- TOC entry 230 (class 1259 OID 39847)
-- Name: bpm_proc_attachment; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_attachment (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    file_id uuid,
    type_id uuid,
    comment_ text,
    proc_instance_id uuid,
    proc_task_id uuid,
    author_id uuid
);


ALTER TABLE bpm_proc_attachment OWNER TO cuba;

--
-- TOC entry 229 (class 1259 OID 39839)
-- Name: bpm_proc_attachment_type; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_attachment_type (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    code character varying(255)
);


ALTER TABLE bpm_proc_attachment_type OWNER TO cuba;

--
-- TOC entry 225 (class 1259 OID 39810)
-- Name: bpm_proc_definition; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_definition (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255),
    code character varying(255),
    act_id character varying(255),
    active boolean,
    model_id uuid
);


ALTER TABLE bpm_proc_definition OWNER TO cuba;

--
-- TOC entry 227 (class 1259 OID 39826)
-- Name: bpm_proc_instance; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_instance (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    entity_name character varying(255),
    entity_id uuid,
    active boolean,
    cancelled boolean,
    act_process_instance_id character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    proc_definition_id uuid NOT NULL,
    started_by_id uuid,
    start_comment text,
    cancel_comment text,
    entity_editor_name character varying(255),
    description text
);


ALTER TABLE bpm_proc_instance OWNER TO cuba;

--
-- TOC entry 233 (class 1259 OID 39868)
-- Name: bpm_proc_model; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_model (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    act_model_id character varying(255),
    description text
);


ALTER TABLE bpm_proc_model OWNER TO cuba;

--
-- TOC entry 226 (class 1259 OID 39818)
-- Name: bpm_proc_role; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_role (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    proc_definition_id uuid NOT NULL,
    order_ integer
);


ALTER TABLE bpm_proc_role OWNER TO cuba;

--
-- TOC entry 231 (class 1259 OID 39855)
-- Name: bpm_proc_task; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_task (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    proc_instance_id uuid NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    outcome character varying(255),
    proc_actor_id uuid,
    act_execution_id character varying(255) NOT NULL,
    name character varying(255),
    act_task_id character varying(255),
    comment_ text,
    cancelled boolean,
    claim_date timestamp without time zone,
    act_process_definition_id character varying(255),
    act_task_definition_key character varying(255)
);


ALTER TABLE bpm_proc_task OWNER TO cuba;

--
-- TOC entry 232 (class 1259 OID 39863)
-- Name: bpm_proc_task_user_link; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_proc_task_user_link (
    proc_task_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE bpm_proc_task_user_link OWNER TO cuba;

--
-- TOC entry 234 (class 1259 OID 39876)
-- Name: bpm_stencil_set; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE bpm_stencil_set (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    json_data text NOT NULL
);


ALTER TABLE bpm_stencil_set OWNER TO cuba;

--
-- TOC entry 262 (class 1259 OID 40361)
-- Name: pm_company_goal; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE pm_company_goal (
    id uuid NOT NULL,
    version integer NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255)
);


ALTER TABLE pm_company_goal OWNER TO cuba;

--
-- TOC entry 261 (class 1259 OID 40353)
-- Name: pm_project; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE pm_project (
    id uuid NOT NULL,
    version integer NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    manager_id uuid NOT NULL,
    description character varying(255),
    state character varying(50)
);


ALTER TABLE pm_project OWNER TO cuba;

--
-- TOC entry 264 (class 1259 OID 40374)
-- Name: pm_project_goal; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE pm_project_goal (
    id uuid NOT NULL,
    version integer NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    company_goal_id uuid NOT NULL,
    project_id uuid
);


ALTER TABLE pm_project_goal OWNER TO cuba;

--
-- TOC entry 265 (class 1259 OID 40379)
-- Name: pm_project_user_link; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE pm_project_user_link (
    project_id uuid NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE pm_project_user_link OWNER TO cuba;

--
-- TOC entry 263 (class 1259 OID 40366)
-- Name: pm_task; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE pm_task (
    id uuid NOT NULL,
    version integer NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    project_id uuid,
    executor_id uuid NOT NULL,
    estimation integer,
    description text,
    start_date date,
    end_date date,
    state character varying(50)
);


ALTER TABLE pm_task OWNER TO cuba;

--
-- TOC entry 199 (class 1259 OID 39453)
-- Name: sec_constraint; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_constraint (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    code character varying(255),
    check_type character varying(50) DEFAULT 'db'::character varying,
    operation_type character varying(50) DEFAULT 'read'::character varying,
    entity_name character varying(255) NOT NULL,
    join_clause character varying(500),
    where_clause character varying(1000),
    groovy_script character varying(1000),
    filter_xml character varying(1000),
    is_active boolean DEFAULT true,
    group_id uuid
);


ALTER TABLE sec_constraint OWNER TO cuba;

--
-- TOC entry 205 (class 1259 OID 39535)
-- Name: sec_entity_log; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_entity_log (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    event_ts timestamp without time zone,
    user_id uuid,
    change_type character(1),
    entity character varying(100),
    entity_id uuid,
    string_entity_id character varying(255),
    int_entity_id integer,
    long_entity_id bigint,
    changes text
);


ALTER TABLE sec_entity_log OWNER TO cuba;

--
-- TOC entry 206 (class 1259 OID 39552)
-- Name: sec_entity_log_attr; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_entity_log_attr (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    item_id uuid,
    name character varying(50),
    value character varying(1500),
    value_id uuid,
    messages_pack character varying(200)
);


ALTER TABLE sec_entity_log_attr OWNER TO cuba;

--
-- TOC entry 207 (class 1259 OID 39566)
-- Name: sec_filter; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_filter (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    component character varying(200),
    name character varying(255),
    code character varying(200),
    xml text,
    user_id uuid
);


ALTER TABLE sec_filter OWNER TO cuba;

--
-- TOC entry 194 (class 1259 OID 39386)
-- Name: sec_group; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_group (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    parent_id uuid
);


ALTER TABLE sec_group OWNER TO cuba;

--
-- TOC entry 195 (class 1259 OID 39397)
-- Name: sec_group_hierarchy; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_group_hierarchy (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    group_id uuid,
    parent_id uuid,
    hierarchy_level integer
);


ALTER TABLE sec_group_hierarchy OWNER TO cuba;

--
-- TOC entry 204 (class 1259 OID 39522)
-- Name: sec_logged_attr; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_logged_attr (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    entity_id uuid,
    name character varying(50)
);


ALTER TABLE sec_logged_attr OWNER TO cuba;

--
-- TOC entry 203 (class 1259 OID 39515)
-- Name: sec_logged_entity; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_logged_entity (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    name character varying(100),
    auto boolean,
    manual boolean
);


ALTER TABLE sec_logged_entity OWNER TO cuba;

--
-- TOC entry 198 (class 1259 OID 39442)
-- Name: sec_permission; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_permission (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    permission_type integer,
    target character varying(100),
    value integer,
    role_id uuid
);


ALTER TABLE sec_permission OWNER TO cuba;

--
-- TOC entry 210 (class 1259 OID 39603)
-- Name: sec_presentation; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_presentation (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    component character varying(200),
    name character varying(255),
    xml character varying(7000),
    user_id uuid,
    is_auto_save boolean
);


ALTER TABLE sec_presentation OWNER TO cuba;

--
-- TOC entry 223 (class 1259 OID 39789)
-- Name: sec_remember_me; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_remember_me (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    user_id uuid NOT NULL,
    token character varying(32) NOT NULL
);


ALTER TABLE sec_remember_me OWNER TO cuba;

--
-- TOC entry 193 (class 1259 OID 39377)
-- Name: sec_role; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_role (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    loc_name character varying(255),
    description character varying(1000),
    is_default_role boolean,
    role_type integer
);


ALTER TABLE sec_role OWNER TO cuba;

--
-- TOC entry 213 (class 1259 OID 39650)
-- Name: sec_screen_history; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_screen_history (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    user_id uuid,
    caption character varying(255),
    url text,
    entity_id uuid,
    substituted_user_id uuid
);


ALTER TABLE sec_screen_history OWNER TO cuba;

--
-- TOC entry 211 (class 1259 OID 39617)
-- Name: sec_search_folder; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_search_folder (
    folder_id uuid NOT NULL,
    filter_component character varying(200),
    filter_xml character varying(7000),
    user_id uuid,
    presentation_id uuid,
    apply_default boolean,
    is_set boolean,
    entity_type character varying(50)
);


ALTER TABLE sec_search_folder OWNER TO cuba;

--
-- TOC entry 200 (class 1259 OID 39470)
-- Name: sec_session_attr; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_session_attr (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(50),
    str_value character varying(1000),
    datatype character varying(20),
    group_id uuid
);


ALTER TABLE sec_session_attr OWNER TO cuba;

--
-- TOC entry 196 (class 1259 OID 39412)
-- Name: sec_user; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_user (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    login character varying(50) NOT NULL,
    login_lc character varying(50) NOT NULL,
    password character varying(255),
    name character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    middle_name character varying(255),
    position_ character varying(255),
    email character varying(100),
    language_ character varying(20),
    time_zone character varying(50),
    time_zone_auto boolean,
    active boolean,
    group_id uuid NOT NULL,
    ip_mask character varying(200),
    change_password_at_logon boolean
);


ALTER TABLE sec_user OWNER TO cuba;

--
-- TOC entry 197 (class 1259 OID 39426)
-- Name: sec_user_role; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_user_role (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    user_id uuid,
    role_id uuid
);


ALTER TABLE sec_user_role OWNER TO cuba;

--
-- TOC entry 201 (class 1259 OID 39484)
-- Name: sec_user_setting; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_user_setting (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    user_id uuid,
    client_type character(1),
    name character varying(255),
    value text
);


ALTER TABLE sec_user_setting OWNER TO cuba;

--
-- TOC entry 202 (class 1259 OID 39499)
-- Name: sec_user_substitution; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sec_user_substitution (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    user_id uuid NOT NULL,
    substituted_user_id uuid NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone
);


ALTER TABLE sec_user_substitution OWNER TO cuba;

--
-- TOC entry 209 (class 1259 OID 39590)
-- Name: sys_app_folder; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_app_folder (
    folder_id uuid NOT NULL,
    filter_component character varying(200),
    filter_xml character varying(7000),
    visibility_script text,
    quantity_script text,
    apply_default boolean
);


ALTER TABLE sys_app_folder OWNER TO cuba;

--
-- TOC entry 219 (class 1259 OID 39746)
-- Name: sys_attr_value; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_attr_value (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    category_attr_id uuid NOT NULL,
    code character varying(100),
    entity_id uuid,
    string_entity_id character varying(255),
    int_entity_id integer,
    long_entity_id bigint,
    string_value character varying,
    integer_value integer,
    double_value numeric,
    date_value timestamp without time zone,
    boolean_value boolean,
    entity_value uuid,
    string_entity_value character varying(255),
    int_entity_value integer,
    long_entity_value bigint,
    parent_id uuid
);


ALTER TABLE sys_attr_value OWNER TO cuba;

--
-- TOC entry 217 (class 1259 OID 39722)
-- Name: sys_category; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_category (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(255) NOT NULL,
    special character varying(50),
    entity_type character varying(100) NOT NULL,
    is_default boolean,
    discriminator integer
);


ALTER TABLE sys_category OWNER TO cuba;

--
-- TOC entry 218 (class 1259 OID 39731)
-- Name: sys_category_attr; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_category_attr (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    category_entity_type character varying(4000),
    name character varying(255),
    code character varying(100) NOT NULL,
    category_id uuid NOT NULL,
    entity_class character varying(500),
    data_type character varying(200),
    default_string character varying,
    default_int integer,
    default_double numeric,
    default_date timestamp without time zone,
    default_date_is_current boolean,
    default_boolean boolean,
    default_entity_value uuid,
    default_str_entity_value character varying(255),
    default_int_entity_value integer,
    default_long_entity_value bigint,
    enumeration character varying(500),
    order_no integer,
    screen character varying(255),
    required boolean,
    lookup boolean,
    target_screens character varying(4000),
    width character varying(20),
    rows_count integer,
    is_collection boolean,
    join_clause character varying(4000),
    where_clause character varying(4000),
    filter_xml text
);


ALTER TABLE sys_category_attr OWNER TO cuba;

--
-- TOC entry 187 (class 1259 OID 39324)
-- Name: sys_config; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_config (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    name character varying(255),
    value text
);


ALTER TABLE sys_config OWNER TO cuba;

--
-- TOC entry 185 (class 1259 OID 39308)
-- Name: sys_db_changelog; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_db_changelog (
    script_name character varying(300) NOT NULL,
    create_ts timestamp without time zone DEFAULT now(),
    is_init integer DEFAULT 0
);


ALTER TABLE sys_db_changelog OWNER TO cuba;

--
-- TOC entry 216 (class 1259 OID 39705)
-- Name: sys_entity_snapshot; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_entity_snapshot (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    entity_meta_class character varying(50) NOT NULL,
    entity_id uuid,
    string_entity_id character varying(255),
    int_entity_id integer,
    long_entity_id bigint,
    author_id uuid NOT NULL,
    view_xml text NOT NULL,
    snapshot_xml text NOT NULL,
    snapshot_date timestamp without time zone NOT NULL
);


ALTER TABLE sys_entity_snapshot OWNER TO cuba;

--
-- TOC entry 190 (class 1259 OID 39346)
-- Name: sys_entity_statistics; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_entity_statistics (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    name character varying(50),
    instance_count bigint,
    fetch_ui integer,
    max_fetch_ui integer,
    lazy_collection_threshold integer,
    lookup_screen_threshold integer
);


ALTER TABLE sys_entity_statistics OWNER TO cuba;

--
-- TOC entry 188 (class 1259 OID 39333)
-- Name: sys_file; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_file (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    name character varying(500) NOT NULL,
    ext character varying(20),
    file_size bigint,
    create_date timestamp without time zone
);


ALTER TABLE sys_file OWNER TO cuba;

--
-- TOC entry 208 (class 1259 OID 39580)
-- Name: sys_folder; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_folder (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    folder_type character(1),
    parent_id uuid,
    name character varying(100),
    tab_name character varying(100),
    sort_order integer
);


ALTER TABLE sys_folder OWNER TO cuba;

--
-- TOC entry 212 (class 1259 OID 39641)
-- Name: sys_fts_queue; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_fts_queue (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    entity_id uuid,
    string_entity_id character varying(255),
    int_entity_id integer,
    long_entity_id bigint,
    entity_name character varying(200),
    change_type character(1),
    source_host character varying(255),
    indexing_host character varying(255),
    fake boolean
);


ALTER TABLE sys_fts_queue OWNER TO cuba;

--
-- TOC entry 220 (class 1259 OID 39768)
-- Name: sys_jmx_instance; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_jmx_instance (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    node_name character varying(255),
    address character varying(500) NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE sys_jmx_instance OWNER TO cuba;

--
-- TOC entry 189 (class 1259 OID 39341)
-- Name: sys_lock_config; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_lock_config (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    name character varying(100),
    timeout_sec integer
);


ALTER TABLE sys_lock_config OWNER TO cuba;

--
-- TOC entry 221 (class 1259 OID 39776)
-- Name: sys_query_result_seq; Type: SEQUENCE; Schema: public; Owner: cuba
--

CREATE SEQUENCE sys_query_result_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sys_query_result_seq OWNER TO cuba;

--
-- TOC entry 222 (class 1259 OID 39778)
-- Name: sys_query_result; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_query_result (
    id bigint DEFAULT nextval('sys_query_result_seq'::regclass) NOT NULL,
    session_id uuid NOT NULL,
    query_key integer NOT NULL,
    entity_id uuid,
    string_entity_id character varying(255),
    int_entity_id integer,
    long_entity_id bigint
);


ALTER TABLE sys_query_result OWNER TO cuba;

--
-- TOC entry 224 (class 1259 OID 39801)
-- Name: sys_rest_api_token; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_rest_api_token (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    access_token_value character varying(255),
    access_token_bytes bytea,
    authentication_key character varying(255),
    authentication_bytes bytea,
    expiry timestamp without time zone
);


ALTER TABLE sys_rest_api_token OWNER TO cuba;

--
-- TOC entry 192 (class 1259 OID 39362)
-- Name: sys_scheduled_execution; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_scheduled_execution (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    task_id uuid,
    server character varying(512),
    start_time timestamp with time zone,
    finish_time timestamp with time zone,
    result text
);


ALTER TABLE sys_scheduled_execution OWNER TO cuba;

--
-- TOC entry 191 (class 1259 OID 39352)
-- Name: sys_scheduled_task; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_scheduled_task (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    defined_by character varying(1) DEFAULT 'B'::character varying,
    class_name character varying(500),
    script_name character varying(500),
    bean_name character varying(50),
    method_name character varying(50),
    method_params character varying(1000),
    user_name character varying(50),
    is_singleton boolean,
    is_active boolean,
    period integer,
    timeout integer,
    start_date timestamp without time zone,
    time_frame integer,
    start_delay integer,
    permitted_servers character varying(4096),
    log_start boolean,
    log_finish boolean,
    last_start_time timestamp with time zone,
    last_start_server character varying(512),
    description character varying(1000),
    cron character varying(100),
    scheduling_type character varying(1) DEFAULT 'P'::character varying
);


ALTER TABLE sys_scheduled_task OWNER TO cuba;

--
-- TOC entry 215 (class 1259 OID 39686)
-- Name: sys_sending_attachment; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_sending_attachment (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp without time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    message_id uuid,
    content bytea,
    content_file_id uuid,
    content_id character varying(50),
    name character varying(500),
    disposition character varying(50),
    text_encoding character varying(50)
);


ALTER TABLE sys_sending_attachment OWNER TO cuba;

--
-- TOC entry 214 (class 1259 OID 39670)
-- Name: sys_sending_message; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_sending_message (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    version integer,
    update_ts timestamp with time zone,
    updated_by character varying(50),
    delete_ts timestamp without time zone,
    deleted_by character varying(50),
    address_to text,
    address_from character varying(100),
    caption character varying(500),
    email_headers character varying(500),
    content_text text,
    content_text_file_id uuid,
    deadline timestamp with time zone,
    status integer,
    date_sent timestamp without time zone,
    attempts_count integer,
    attempts_made integer,
    attachments_name text
);


ALTER TABLE sys_sending_message OWNER TO cuba;

--
-- TOC entry 186 (class 1259 OID 39315)
-- Name: sys_server; Type: TABLE; Schema: public; Owner: cuba
--

CREATE TABLE sys_server (
    id uuid NOT NULL,
    create_ts timestamp without time zone,
    created_by character varying(50),
    update_ts timestamp without time zone,
    updated_by character varying(50),
    name character varying(255),
    is_running boolean,
    data text
);


ALTER TABLE sys_server OWNER TO cuba;

--
-- TOC entry 2389 (class 2604 OID 40077)
-- Name: act_evt_log log_nr_; Type: DEFAULT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('act_evt_log_log_nr__seq'::regclass);


--
-- TOC entry 2937 (class 0 OID 40074)
-- Dependencies: 247
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 246
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: public; Owner: cuba
--

SELECT pg_catalog.setval('act_evt_log_log_nr__seq', 1, false);


--
-- TOC entry 2926 (class 0 OID 39985)
-- Dependencies: 236
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_ge_bytearray VALUES ('12', 1, 'process.bpmn20.xml', '11', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566223e0a20203c7369676e616c2069643d2270726f6a656374417070726f76656422206e616d653d2270726f6a656374417070726f766564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c70726f636573732069643d227461736b2d776622206e616d653d225461736b2057462220697345786563757461626c653d2274727565223e0a202020203c657874656e73696f6e456c656d656e74733e0a2020202020203c61637469766974693a6576656e744c697374656e6572206576656e74733d225441534b5f435245415445442c5441534b5f41535349474e45442c50524f434553535f434f4d504c455445442c54494d45525f46495245442c41435449564954595f43414e43454c4c45442220636c6173733d22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e6572223e3c2f61637469766974693a6576656e744c697374656e65723e0a2020202020203c637562613a70726f63526f6c657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226578656375746f7222206e616d653d226578656375746f72223e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226d616e6167657222206e616d653d226d616e61676572223e3c2f637562613a70726f63526f6c653e0a2020202020203c2f637562613a70726f63526f6c65733e0a2020202020203c637562613a6c6f63616c697a6174696f6e7320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d227275223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22d09ed186d0b5d0bdd0bad0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22d0a0d0b0d0b1d0bed182d0b020d0bdd0b0d0b420d0b7d0b0d0b4d0b0d187d0b5d0b9223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22d09ed186d0b5d0bdd0b5d0bdd0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22d09fd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22d097d0b0d0bfd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22d097d0b0d0b2d0b5d180d188d0b5d0bdd0b0223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d22656e223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a2020202020203c2f637562613a6c6f63616c697a6174696f6e733e0a202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c73746172744576656e742069643d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e3c2f73746172744576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d45464346313843452d444639432d344437352d413835342d3538393436333035334430372220736f757263655265663d227369642d34414346434531442d303336362d343743432d413845432d43423337324436454439453622207461726765745265663d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422206e616d653d2253657420455354494d4154494f4e0a222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154494f4e27297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622206e616d653d2253657420455354494d41544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154454427297d223e3c2f736572766963655461736b3e0a202020203c757365725461736b2069643d22657374696d6174696f6e22206e616d653d22457374696d6174696f6e223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22657374696d61746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36393230454232462d433230322d344436442d424642332d3139423039314444463246332220736f757263655265663d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422207461726765745265663d22657374696d6174696f6e223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d46384546413243432d323343432d344531392d423534312d4641303434323239413838332220736f757263655265663d22657374696d6174696f6e22207461726765745265663d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d34393333384646332d373145452d343942442d423345452d3138433531354136393131382220736f757263655265663d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622207461726765745265663d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422206e616d653d225369676e616c205461736b20457374696d61746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b457374696d6174656427297d223e3c2f736572766963655461736b3e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222206e616d653d225761697420666f722070726f6a65637420617070726f76616c223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d2270726f6a656374417070726f766564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d36383636333336442d394533352d343744342d384332382d3238373439303544463041352220736f757263655265663d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422207461726765745265663d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22706c616e6e696e6742794d616e6167657222206e616d653d22506c616e6e696e67206279206d616e61676572223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22706c616e223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6d616e616765725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36424437333643372d463136382d343237432d384535322d4138373434384338333930382220736f757263655265663d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222207461726765745265663d22706c616e6e696e6742794d616e61676572223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22776f726b4f6e5461736b22206e616d653d22576f726b206f6e207461736b223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22636f6d706c65746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c736572766963655461736b2069643d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022206e616d653d225369676e616c205461736b20436f6d706c65746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b436f6d706c6574656427297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722206e616d653d2253657420494e5f574f524b222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27494e5f574f524b27297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d42383937333531322d353138312d343333392d393342432d3342433236304345383039302220736f757263655265663d22706c616e6e696e6742794d616e6167657222207461726765745265663d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35443345324445342d454635412d344444442d393136322d3132384546333141454334382220736f757263655265663d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722207461726765745265663d22776f726b4f6e5461736b223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422206e616d653d2253657420434f4d504c45544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27434f4d504c4554454427297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d39424237363738322d444331452d343636332d393944452d4643333144313430373531342220736f757263655265663d22776f726b4f6e5461736b22207461726765745265663d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35363143343738422d323344462d343744452d394433442d4436433743393942463830312220736f757263655265663d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422207461726765745265663d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e3c2f73657175656e6365466c6f773e0a202020203c656e644576656e742069643d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d46313832303146332d334636422d343231452d424334462d4136374345444141433641352220736f757263655265663d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022207461726765745265663d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f7461736b2d7766223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d227461736b2d7766222069643d2242504d4e506c616e655f7461736b2d7766223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536222069643d2242504d4e53686170655f7369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d2233392e3132352220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544222069643d2242504d4e53686170655f7369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223135302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436222069643d2242504d4e53686170655f7369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223534302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22657374696d6174696f6e222069643d2242504d4e53686170655f657374696d6174696f6e223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434222069643d2242504d4e53686170655f7369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032222069643d2242504d4e53686170655f7369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223934352e302220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22706c616e6e696e6742794d616e61676572222069643d2242504d4e53686170655f706c616e6e696e6742794d616e61676572223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223931302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22776f726b4f6e5461736b222069643d2242504d4e53686170655f776f726b4f6e5461736b223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223532352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330222069643d2242504d4e53686170655f7369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223132302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237222069643d2242504d4e53686170655f7369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844222069643d2242504d4e53686170655f7369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545222069643d2242504d4e53686170655f7369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d2234302e3132352220793d223232312e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037222069643d2242504d4e456467655f7369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037223e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236392e31323435383534323932313838372220793d223130302e3131313532313038313235383133223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223135302e302220793d223130302e3731323832353237383831303431223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031222069643d2242504d4e456467655f7369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223232302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438222069643d2242504d4e456467655f7369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223632352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138222069643d2242504d4e456467655f7369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223634302e302220793d2239382e3631313131313131313131313131223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d2239352e3937323232323232323232323233223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135222069643d2242504d4e456467655f7369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223934352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633222069643d2242504d4e456467655f7369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223235302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930222069643d2242504d4e456467655f7369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223931302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038222069643d2242504d4e456467655f7369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223131352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223139352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833222069643d2242504d4e456467655f7369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223534302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135222069643d2242504d4e456467655f7369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223132302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236382e3132352220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134222069643d2242504d4e456467655f7369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223532352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray VALUES ('13', 1, 'process.task-wf.png', '11', '\x89504e470d0a1a0a0000000d49484452000003fc0000011d0806000000b1266cf5000036094944415478daeddd0b9455f59d27fa5a1333e94c6e2693bb5626ab5792d5c95d76c665675c5919bdf12e6f324e5f7bd2e9d8d7a4a3960508041f182208065f6d6c8c8e91a811297cc5241a8d91286d881215a11e3c448df800445069458492978ac85351ff737e5b76e5703ce7d4a92aaaa8c7e7b3d67f71ea9c53a75ebf2ffffd3b7befffaeab030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007a454ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622d5b37a468e0c399205431600f68b98c8162e5c98366dda94de7aeb2de3008dcd9b37a7f9f3e76f2d4c6cc7ab4af5ac9e9123438e64c19005806e8b77ad4d647d66427b6beedcb92b55a57a56cfc8912147b260c80240b7c5216a2692be330a93d91e55a99ed5337264c8912c18b200d06d717e9449a44f4d664955aa67f58c1c1972240b862c00f4ea64b6fef5ede9ece94bb211b74d3e26b3fe5acfdbdf589f5e5c7c4b7aa6e9926cc4edb84f0daa67cc0b72842cc802c0a098cc76ef7e2bbdf6e6cef68f17acdcd03e99c5edfcfe4d6fec486f6cdb69323299f58b8db36d5bdad2f2072f4a4bef3b679f11f7c563ea503dcb9179418e9005590018d093594c64b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f66713beebfefa975e9fcc273ae9efd5cdabadd846632ebfb0dffda67eefd40b39f8f75cfcc5287ea598ecc0b72842cc802c0c09ecc5eddba239d77d7b2f6c9aba331f1774bd3da57df342199ccfa7cc3bfb2f5a7151bfe784c1daa6739322fc811b2200b0003be41ba7f495bcd93d95d7f5a63323299f58b867ff9dc8b2b36fcf1983a54cf72645e90236441160006fc641687a8e593d539772e4d773cfc527a61c31bd988db715ffef8034b9dfb6c32d3f01bead9bc605e90235990055900e8d39359ac2e1b0bce149f8f169357e9f3e2bee2f3d5e273ac4c6b32ebeb0d7facca5fa9e18fc7d4a17a9623f3821c210bb200306027b37287a3c53bd6a5cf8bfbca3dd7a46432ebcb0dffaa45d7566cf8e33175a89ee5c8bc2047c8822c0098cc4c6626b37ed8f0bfd6b62c2d9f33e98387f317ee8bc7d4a17a9623f3821c210bb2003060273387ab99cc0672c31f63f5e3b77da0e18ffbd4a07ac6bc2047c8822c000c8a0669de8a0d352f4813cf351999ccfa45c3bf7b775af5f00d1f3c9cbf705f3ca60ed5b31c9917e40859900580013f99cd5e56fb2567fef8d43a9391c9accf37fcdbb6b4a5e7174dab780e7f3c16cf518bea598ecc0b72842cc802c0809dcc5eddba235d306359cd93d9b9772d4d9bded861423299f5cd8db3ddbbd3fa552de9e9d9ff5cb1d9cf473c279e6b6fbf7a9623f3821cc9822cc802c0809ccc76ecdc9d6e6859951d9236f3f19753eb8a7dcf578bdb710dda394fbf924d7a372f7821edd22099ccfa603d77b457dfde7ef58c79418e90055900185493593ea16dd8f2e7056662c1997c328bdbf9fdafbfb9d3446632ebb3f55ccb5efd6a7bfbd5a57a9623f3821cc9822cc802c0809bcccaad4c9b4f66569a3599f5977aee6ab39f0f75a99ee5c8bc2047b2200bb20030e02733c364a69e0df52c47861cc982210b002633c364a69ed5b37a9623438e64c19005009399613253cfea193932e448160c5900309999cc50cfea1939922364411680be21a574d0534f3d35f2965b6e69bafcf2cb5f1f3b76ecdb23478e4c279d74521a366cd87b63c68c79fba28b2e5a73f5d557cff8c52f7e7198df98c9cc64867a56cfc8911cc9912c18b230e0fbc4bf58b66cd9e85b6fbd75fee4c993b78e1b376e4f719ff8fdef7fffad0b2fbcf0c59ffef4a7b717c67ff11beb838dfef4e9d36fb8e4924bde1a3f7e7cfaf9cf7f9e1e7df4d1d4d6d69676edda9542fcbb69d3a6f4c4134fa4c21f3a9d75d659ef4d9c38b16decd8b1dff71b349999cc50cfea1939922364411654e5c06bf4efbefbeedb2ebdf4d23d9de913274c98f0d2e9a79f7eaadf601fd0dcdcfc9d42a3bffd9c73cec9fe48efbcf34eaad592254bd205175cf0ee983163569d70c20907fb6d9acc4c66a867f58c1cc911b2200bf4bcf18d2dedbfeff1d35a27edf37163cb1f2734b6fcf7729f77f1c577fdfbc2e36fe61f4f686cbdb442b33fe18753ef7f6ffcd4a6b4f8f1cef789e79f7ffe3ba3478f5ed9993e71c2d5cd9f297c6f4b3afbbba8f4330c7a77dd75d7efcf38e38c346bd6ac4efd014bcd9e3d3b9d7aeaa9bbbffffdef9feeb76a323399a19ed533722447c8822cd03b0dffe93f9ff51fc64f6b5e917f3c614ad3ff35beb17959275ee7cd9246ffa07beeb9a7e507ff7c55fad9af1f4c6fbfbda75b7de2a851a376f6f4defed29f81823973e63c3876ecd8f4fcf3cfa7fde1a5975e4a71eec60f7ef083f17ebb26339319ea593d234772842cc8023ddff08f9fda3cf1acc6d6f3f28fcf6a6cbe6ac2b49631d963d35a2e2adcff4661ec3e6b6acbd5d9e3d35aeb0b1fdf9abf463ef2667fdebc798f15dfbffbed77d26fe7ac4813af9b97cebbbe258dbde0f274f8e187a7fff89ffecf74fa65bf4fffe3847169c40537c50ee0ac065eddb23dfde8170fa5df35af4ce75c3f2ffda175693ae38c3376beb46ee30f0bafb7b130aebda669c7c3f13d64df5763cbfab3a6359f90bd5931b5e55fc74f6bfd76f6264663f32fe2f1c2683bebdad663b3ef77ca82bf9cd0d8b2a870dfcec2e78d2bf73350307dfaf43ba3d98f732df6a778bdc21f73d7f0e1c347f82d9bcc4c66a867f58c1cc911b2200bf45cc37ff1c5ad07c5defcf71be496b4f7df3571d87efebcb86f4263f3ff8c26f9fd37085a2e885300e2f6d8c6a6430bf72fcc9f1b7bf6f33ef1b2db1e496f6cdb9dee9eff7c9a72f33de9affffaafd3d78ef9c734e19a07d3c2850bd393cfbd92ae9cfe585affea9b69f1e2c5e9ca2baf4c471e7964faffbe3d2afdcb0db3d3f65d6fa7575edd9ecebd617ef67a679e7fd9ae7fbe69c14b675fdbf4c5f1d35a1aa361bff8e28bffdd59d7341d116f04c4edf81eb39f696af335f10645dcce9edfd8b2f6fd37049a7f93fd2c85c63fdfab5ffa330c7a0f3cf0c03f8c1e3dfabdfdb567bfdc9efe912347bed9d0d07088dfb6c9cc64867a56cfc8911c210bb240cf34fcb1273ff6e2177f5c68a42f7bbf396e397def1ef5b67853a0f0bc9fef7ddeadb1973f6e47537dd6b496ff3f6e3ffae8a3a3e274efe813db366f4b8dfffa44b620df59d7cc497ff3a5ff9a0a7d64b6b73f1af830e7b197d282a56b3fd00f5e7e4b73faef7f7f7cb682ff8e1d3bd3f9372ec8eebf6bce92f4fdf3afdc197d62d6d8dfd2fa17f175c75cd7fa7f143ede3ea1b1f598587b60eff7b8bd78cf7dece9cfef2ffd3d14ff0c144c9a34695b9cb3df930ac5f0eef0e1c317fb6d9bcc4c66a867f58c1cc911b2200bf44cc35f18cbc736deff1f8b3e7ef687d736ffd5de8fdf1edbb8e0537bf780af1e3fa5f5cb7bef9f3da1b1e96b7b6faf8e7f6335feb8625bde27cefed3ea34e74f2fa4638f3d368dfdd90369e9b36bd2bbefbe97e63df57276a87eb8e5bea7d38ad5afeed307bef7de7be987d7b6a696c7dfffdca1675e92feb5f5cfcfffedefe7be3574e8d047e23483d8b3bff70885f171f8fe84c6e6c913a6359fb1f7fbda1c7bf6cbfcccdbcfbe6efee7e210ffc2ed3f15ff0c14dc76db6d536235feb7df7e3bf5b4b163c7beded0d030cc6fdd646632433dab67e4488e90055960ff37fcf9defcfce3098dad77157d7c6d34fde31b5bef8dc3dff3c3fcf3dbef37db2d6d7198fccc99337f5bdc27fef4b77f4a234e39231d73cc31e94fcb5f4e937eb5283b877f7ad3ca6c2f7fb8e8970fa55fdd7ccb3e3de0732fbf9eee6c7936fbfc78fef7ceb93a35340c697ffe9e77de4d63c68cd97057f38a6bde3ff2203b47ff577bf7f22f89663ebec738a73fceeddffb786bfe6645bc2190dd37ad7945bc9151fc33a888bab804c3c53be2d27bbd61d9b265c95e7e9399c90cf5ac9e91233942166481be2bf6ee5f7ae9a57b8afbc4e9d3a7a7430e39246ddebcb962bf377ffefcecb0fd871f7eb8fdbedfcf7f3e2d2fdaebbf6ddbb6f4a52f7d297bbddcd2a54bb3bdfc453deabf8b863e8e56f0d7e886c21fe41f620186ee5c7eafb34e3bedb4d70a45f079bffdf21a1a1ae616c6ff6b323399a967433d234772842cc802072247cb962d1b5ddc27eed9b3271d7cf0c1d939fb95ecdebd3baed096860c1992ce3cf3ccf62303aeb8e3b1f62300725117f17af1bab951a3466dc8fbc4bd7bfa37e62bf1d34537de78e3cc5ffef297a9375d7ffdf52f16fe9013fdf6cb8b77c4624418ebebeb8f349999ccd4b3a19ee5488ee488039385c71e7b2c7ded6b5f4b1ff9c847d2473ffad174d45147a5458b16658fc54ed0183d513f955e3bbfbf74ecefaf230b7274ebadb7ce2fee13e3eff8e52f7fb96a9f3763c68c3474e8d0144705c4bf3367ceacfafc58bdbff80d842953a62cd127ee67975e7ae92b8f3efa68af36fc8b172fde55f843cef2dbaf1ec2a2f140b977e16cd8d9b053cf867a962339922359e8d92c7cf18b5fcc1ae2382df5c9279fcc6e7fee739febf1fae9a811df5f8dba865f8e2ae568f2e4c95b8bfbc4d8635fe81d2bf678afbdf65a1a316244baf5d65bb38fe3df912347a62d5bb654fc9cb864dfa9a79edafef1c30f3ffc923e713ffbc10f7eb06bfdfaf5bddaf0c7f5160b7fc8757efb3587b0fd5db8e230dab0b361a79e0df52c47722447b2d0b35988bdfad1103ffbecb3559be5175e78211d71c411e9c31ffe703af1c413f7792cbf3d71e2c4f4b18f7d2c7dea539f4a37dd7453f6589cef7ce8a187669ff7e94f7f3afdfad7bfee72c35fe9b5eeb9e79eec7ce9b83f7e9eaf7ffdebd9f75bfa3a575c714576fbc20b2f940539aa1b376edc9ee23ef1f0c30f4f0b172eacd8e35d77dd7559f3be7dfbf6f6f3f44f39e59474e38d3756db119cad0990dbb061c3a6c2f7b2b6f8fb8d4b07965b999f1a8d1831e2ddb88e626f8aaf57f843eef6dbef5c088bdf858bc36f6cd8d9b053cf867a962339922359e8d92ce44d7034ea63c68cc9f6f4976bbabff18d6f64b7e310e638acb95cc31f8f2d5fbe3cbbfdc94f7e327b2c1af4386d60eddab5d9fd9ff8c427badcf0577aadf8373e5ebd7a75f678dc8e37278a5f279ab2f877d4a851b22047598e62ef7c719f78d04107a54a7d63bc81d4d0d09066cf9ebdcffdf7df7f7f76ff4b2fbd54f6f3e2fcfdba6c7dc07dfac45df9f79a2ddcd7d8b2d35fad9b7ff003a18642333a1836ecfad65093ea593d1b7d61a85f3932f6ff9c12e7ec47f3134d7f3427f1264069d31de7f8c7ed685862946bf88b9bf50f7de843d9ed68c2cf3befbcac01aff639b534fc955e2bd61d88dbb187ff9bdffc66b6273656592fb726c0d4a9536561908e53cfb9228dbb7a763aeb9ab9e9b4f3a766f7bdb16d77fad12f1e4abf6b5e99cefcd90369c1d2b5592f577cff39d7cf4be75ffef374f6d967a7ed3bdfbfff5fe73d97ae99f178bafdc167d2f8a94d69c235b3d353ab36b6f782f19c77de7937addbb42dd59f7d6d76df838fad4ee7dfb820fbfa674d6db93adbbb3fa5f5cb131a5b16e9dabb61f8f0e1ef1ca03dfcbbfcf63bfdaedbe2fafafa638f3efae8831cba694f8e7a36d4b31cc9911cc942ef6621df731ecd7d771bfefce3389c396ecf9a35abdb0d7fa5d78aef277e27e3c68dcbd61f88fb636d82e2d789f3b3e370ff38f45f16066f8e0aadda770be39bb1577dc48811efcd7ff2a574ddef9f4adb77bd9dfef3670f4ee7de30fffd73ed9f6e6bbf7f76cbc385267d4eb6c6455c7aefcae98fa54d5b76a4bbe73f9fe62f599b1d5572f2a963d379d7b7b6f783bfbaefe9f4d2faad697ad38af437ffcf3f14b78a1bbff783f3decaf7ea9f35adb5be70fb567fb56e183366ccf6de3e877fe3c68d3b4acfcda06a08f799c472d526b36a2bca561b71ee579cd7556d62a92b5911b696d56bcb7d5eb9db311e79e491ecbef8b7aec2eab3871d7658fbfdf16e762d2bd796be4e1cbaf6852f7c217bb73b2e09929f4b57fcce7b4cecb52e686332ebb97ade1f8b11d5756225e3d21cd4ede7058d7afaf56d9cc95157571c1fecf343b5fb3ffef18f67cdd28e1d3be46890cd2979131df5fcf8e38f976d96e3f671c71dd77ed8fe9d77de5973c39fbf51902f08d89d86bfd26b7df5ab5f6dcfd02bafbc92ddfecc673ef381d719366c5876bbb5b5d59c32c87234bde5856bcfbd71d1c6f72f85d7bc6cfcb4969f8f1d3bf6adebee5e9c9e5df35ad6c31d71c4ff9d265edb92ddfee51f9765f7c765f7c68d3b2b4d983a37bb7fce632fb51f05107bfef7bcf36e76fb92fff59334bef09cfc127cf73ef46fe9b115ebd3f937cc4b871efa37d91b08b1d7ff5f7eb968cfb82b67be1d5f3fbed7f1539baf9930adf90c7fb56e38f7dc7397f6f62afd858d86c7adbe5853081f696868f876e92456cb64d6d51565ab4d2e951eabe56b95fbdc4a1b55575d75d53ee7cc957e6e3ed9d6159d7356cbf75a7cdf1d77dc91dd8e854562e36df4e8d1d9c73141173fb7dc217b26b3deafe7de5e7db8a71bf0bed8e0abe7c19323f343f5af57e9fe6baeb9a67dd135391a5c73ca92254bdadfb88a9d01f1c655fee653718dc41b4c71c9b2784e6c5fd4ed3d84bea3863f0eaf8fd78e73e7bbdbf0577aad356bd6a4ef7ce73bd91b6ff13dc521fff1265ee9ebdc77df7dd9ed5874d09c32b8725468f4df1edbb8e053631b9b0e2ddc5e1d87d2373636ae3a7b5a4b5af4f4baf4de7befa57193ae4be75ff99becf60faf6dcdeebff7de7bd369e75e957e73ff93599f77cb7d4fa715ab5fcd6ec7e1f96b366c4defbefb5e9ad9b2348dfed1f5d9d127e1c9e737664702fc68caefb2bcc4eb6ddbf9765abb79fb82095367ef88af1fdfeb59d35a7f7ff6d4967ff057eb861ffde84757145f5fb1374c9e3c79a1eb2b560d61d977ab3b3399555b5136ced91a3e7c78fb1e97ef7ef7bb69ddba75edef0ad7b2e153ebd7eaec065dbc8bfead6f7d2bbb2ffe8dc5674a3f37f6b0c4c7712e5da549a9a3af97bfd39daf501b93747c1cf7173fb7f037d0f0f7817aee89e6bad28ac5e57250eef657bef295ec7363afdfa44993b20da9f8dc5815f9f6db6fafb85a7247af1f97b48937a0e27b8ae79e71c61969ebd6ad1daef2ace197a35a73647ee85ac31fab4dd775f2726c7234f0e6946a23e683c2366eb62321e693a89738e2c4e92db2d01f725468f2af8da67f7c63ebbd857fdfbcf8e2bbfefd830fafb8ffc7d7ff21fdf4b77f4a13af9b97a6fca6a9b0fdf3dfd2732fbf9eee6c79365dfe9b47b2f3f32fb97e66763e7eb8e8970fb5efd55ffa6f9bd2a45f2dca3e777ad3ca74fd8d37656f46c576cd2baf6e4f85af93fec7ff3c363df0c003d939ffd1f44ffaf9dc8d13a635ef8eaf1fdfd784c696d72fbea5f52ffcd5ba61e8d0a19f1d3366ccdbefbcf34eaf35fcc3860d8beb2b7ede6fbf7baa4d66d55694cd3784626f4bbc6b1db76365d95af7e0946ef455fb5a9ddda08bcf8f0dcb982ca3498a8feb4ace418b26e72ffff22fe3b21dd9fdb14119f777e6ebe51bafa58fc76b959ecf567a589cc9acf7ebb9270ee9af65c5e26ab57af7dd77b7bf51142356645eb56a5597565e2efe383fda248e42c957798ea6bfa3559e6d9c516b8ecc0f95bf5e5d07a78215efb195a3c139a7541bf17f7334f8c5a7b0e4470268f865a13f6a7a3edd32f6fc9fbc97f78971387e9c063be5b6b9d9b9fab1d3f87bdffb5ed6c0d762cb962d69c48811e957bffa55f671d445bc5e7e987f2cf53664c89017f4893da0d0d42c7fe289277aa5d95fb0604153e18fb8d06fbde727b34a2bca96eea9a9abb0f84c670ee7acf4b53abb41973738b1c7346f6c8a9f174d56dc8e1568e3e3d8cb1a1f97fe2e3afa7ab1c1564bc31fcd5aac38aae1efff0d7fe9fdb5ac585cad562bbd7e5dc9e19db5acbc5cd7c1a24f95f25957b4cab38d333a9323f343e7f7f06bf8cd29863965b019dfd8b2e4d2cb26bf58dc274e9f3e3d8dfa97dbd2e34f2e4985e63c5d72c925d9dfb7d611ff87c7e73df7dc73d99196f17ab9071f7cf0767d620f897337264c98b0ab17f6f2ef193e7cf8b2c2d71be6b7de7b9359e98ab2c50dc5fe3847b3dad7eaec065decb98906261692898daaf8b8f879fff88fff58764f4cbe8157ebd7cb1bb0d84b1a1faf58b1a2e21ede38d45bc33ff01afe5a562cee6ec35febcacbc51fe787401737fcd128d5f2b56d9cd1d91c991f3a7f487f1cb923471a7ec39c32589c72ca2927fcf0873fdc53dc27c6e28efff44fffd4ad4b001e7ffcf1a9e4f2f05b860c19f2a43eb1078d1a356af1bdf7defb6e4f76fb37de78e3cc78d7a6a3f3aee8fe64566d45d978572d3e8e737ff3c3d563319a782cdf031387e6d4721864475fabb31b74c50d76e9f9f37188666cecc5b9d2f96bdc7cf3cdd963b1484e5716ed8bf388e2e37c719bb8bff4b93ffef18f35fc03b0e1afb66271690ebadaf0575a2db9daebe78754171fd21f872e6bf8d95f39323f74ade18fdf49dcbef0c20be5689037fc75fde0ea2f7d6d215959e8df468f1ebd2c5f6c2fbfc4fab1c71e9b8e39e698ec30fdce88374ff3cf2dbe34fc95575ef94b7d620f8b7325bef7bdef6d7bfef9e77ba4d97ff6d9671717bec6fa86868643fcb67b7e32abb6a26c6c184553912f0a16e767c6eaadf906529c131c9f932f3cd6d10457ed6b7565832e6fb02fbbecb27d1e9b366d5af6ef45175dd4fe1ab11054fe78fe33d4ba41171b6f71de50dc1797e72bbd2c5ffedcfcbc6c0d7fff6ef84bebb6da8ac5a539e86ac35f69b5e46aaf1f8bf6c56ab5f17931a2d92f5db44fc34f7772647ee8fc39fc757b2fcb377efc7839d2f00fb8abbf68f8a9a54f2c6ccbec2cee13a3598f3dfdf1c66e2cba578ba883388c3ff6ec1737fbcb962dbb479fd84beaebeb4f3aedb4d3dedcb469d37e6df65f79e59567860c19f2b24334facf646698ccd4b37a56957264c8912cf4cfabbf54bae246fe66581cf912f797be212d0b545268ee878e1e3d7a47699f18e7e0c70eb4a8a94b2fbd342d5cb8b0bd998fc5f8162f5e1c7befd391471e993daff89cfd50a8cb870a7de21a7d62efbe8333f294534ed9f2fcf3cfef9713fa57ae5cb9289afdfafafaf3fd766dd8d9b0433dab67e4488e18080d7f5d1fbefa4bb52b6ec42931757b17be8c372934fcd46ae8d0a1a34e3ffdf40f1c111e8d7dfc8de3ea56871f7e783ae8a083daeb2a9afc3872318e02285a8dbf7dcf7e34fbfac40320f6f417fea05b0afff16ceec6427ebbaebbeebabbe2f08c7813c16fd5869d0d3bd4b37a468ee48881d2f0f7e5abbf54bbe246b9abc168f8e94c9f386cd8b0ad7ff8c31fb677a34fdcf2b39ffdec167de20116e76a0c1932a4e9b4d34e6b7be28927b6766625fed6d6d659279f7cf2e3b1f08273316cd8d9b0433dab67e4488e18e80d7f5fbafa4bb52b6e68f8d94f7d62f3e8d1a3373cf9e4933b3bb34378ce9c39d3870d1bb6589fd8b7fea0c747e33f62c4888d3ff9c94f962c5cb8f0c5750585ff20b2633276eedcf9eafaf5ebff6ddebc79cd975c72c99ca14387be187fc078b7c62a8b36ec6cd8a19ed5337224470c8686bf2f5dfda5da1537e2d0febabd87f4e75783d1f0d38d3eb179e4c8919b264f9efccc430f3db4a6adad6d7d7e0e7fa14fdc50c8c2734d4d4d7fbcf8e28b1fd027f671853fd0671b1a1ac617fe40330a637561ecda7b1dc5f8776d61cc2a8c89f18e8fdf960d3b1b76a867f58c1cc9911c0de486bfae0f5ffda5da15376221c1c30e3b2cfb1ee3dc6a0d3ffa44b0616798ccd4b37a468e0c3992054316a84934fc7e0b60323399a19ed533722447c8822ca0e1074c662633f56ca867e4488e90055940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b3a19ee5c89023593064010d3f98cc0c93997a56cfc8912147b260c8021a7e309999cc50cfea19399223644116d0f003263393997a36d433722447c8822ca0e1079399613253cf867a468ee40859900534fc6032334c66ead950cf7264c8912c18b280861f4c6686c94c3dab67e4c89023593064010d3f98cc4c66a867f58c1c1972240b862c68f8019399c90cf5ac9e912339421664010d3f60323399a967433d234772842cc8021a7e3099192633f56ca8673932e448160c5940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b37a468e0c3992054316d0f083c9cc64867a56cfc8911c210bb280861f309999ccd4b3a19e912339421664010d3f98cc0c93997a36d433722447c8822ca0e1079399613253cf867a9623438e64c1900534fcd0873537379b44faced85598ccf6a84af5ac9e9123438e64c190050dbf861fba6dc18205eb376dda6422e903a3adaded7785c96ca5aa54cfea193932e448160c59d0f06bf8a1db5a5a5a8e9b376fde1b1b376edc69423970ef5ac744d6d4d4b4a6308e5795ea593d2347722447b260c882865fc30ffb45e13fd063e7ce9dbb380e958af3a38c5e1ff17b5f692253cfea193932e448160c5940c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e1070000000d3f000000a0e10700000034fc00000080861f000000d0f0030000001a7e000000d0f0030000001a7e00000040c30f00000068f8010000000d3f00000068f8010000000d3f000000a0e10700000034fc00000080861f000000d0f003000080861f000000d0f0030000001a7e00000040c30f00000068f801000040c30f00000068f8010000000d3f000000a0e10700000034fc00000080861f00000034fc00000080861f000000d0f0030000001a7e00000040c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e10700000034fc00000030109afb59d1e0773016fb4d01000040ff6af80f2f8c3dd51afefafafa63fda6000000a0ff35fd0f5469f81f39fae8a30ff25b02000080fed7f01f5ea9e16f6868f8b6df10000000f4dfa6bfdcb9fc8beddd07000080feddf07fe05c7ee7ee030000c0005068f067dabb0f00000003afe13fb2e8dcfdbff71b0100008001223f97dfde7d00000018580d7fb662bfdf0403464ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622e5c89023593064418ee4488ed4aea176d92f22940b172e4c9b366d4a6fbdf5967180c6e6cd9bd3fcf9f3b716427abcaa9423438e64c190053992233952bb86daa5dbe21d38a1ec33e17c6beedcb92b55a51c1972240b862cc8913a9623b56ba85dba2d0eb7118abe330ac1dca32ae5c89023593064418e0c3952bb86daa5dbe25c0f81e853c1b448881c1972240b862cc89121476ad750bbf46e30d7bfbe3d9d3d7d4936e2b620092672244774250bdbdf589f5e5c7c4b7aa6e9926cc4edb84ffdca02e614393207186a975e0ae6eedd6fa5d7dedcd9fef182951bda2795b89ddfbfe98d1de98d6d3b054b30e5488ee448163afcfb6cdbd296963f78515a7adf39fb8cb82f1e53c3b22047e614393207186a971e0e664c28b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f2a713beebfefa975e9fcc273ae9efd5cdabaddc4229872244772240bd5ff3e6b9fb9f7031b7af958f7cc2c352c0b72644e91237380a176e9e960beba75473aefae65ed93484763e2ef96a6b5afbe295c822947722447b25075ac6cfd69c58dbd784c0dcb821c9953e4c81c60a85d7a2198f72f69ab7952b9eb4f6b044b30e5488ee448163afcfb2c9f7b71c58dbd784c0dcb821c9953e4c81c60a85d7a219871a8583e699c73e7d274c7c32fa51736bc918db81df7e58f3fb0d43937822947722447b260634f1630a7c891da3507a85dfa74306395d758f8a5f8bcb098444a9f17f7159f37169f638558c1942339922359a8366245e64a1b7bf1981a96053932a7c89139c050bbf46030cb1d1616ef1c973e2fee2bf75c01134c3992233992854a63d5a26b2b6eecc5636a5816e4c89c2247e60043ed6252114ce4c890a37eb8b1f75adbb2b47ccea40f1eca59b82f1e53c3b22047e614393207186a971e0ca6c3c604133992237a6a632fc6eac76ffbc0c65edca77e6501738a1c99030cb54b2f0573de8a0d352f0c13cf152cc1942339922359e8f06fb47b775af5f00d1f3c94b3705f3ca68665418ecc2972640e30d42ebd10ccd9cb6abff4cb1f9f5a2758822947722447b250f56fb36d4b5b7a7ed1b48ae76fc663f11c752c0b72644e91237380a176e9c160beba7547ba60c6b29a279573ef5a9a36bdb143b804538ee4488e64a1ec1e9df5ab5ad2d3b3ffb9e2865e3ee239f15c7b7a64418ecc2972640e30d42e3d14cc1d3b77a71b5a56658786cd7cfce5d4ba62dff3c6e2765c0b76ced3af6493cfcd0b5e48bb045330e5488ee448163ab947c79e1e59c09c2247e6007380daa5b7df89db3bb16cd8f2e7855e62e1977c5289dbf9fdafbfb9d38422987224477244d92cd4b247a7da9e1e352d0b72644e91237380a176e98149a5dc0ab1f9a462c557c1448ee4885ab2d0d50dbd7ca869599023738a1c99030cb54b2f4c2a8660224772842cc802722447a85db58b601a822947861cc982210bc8911ca95d43ed22988660ca912147b260c8027224476ad750bb08a6602247861cc982210b7264c891da35d4eed0a1433f5b5f5f7fe649279d34a3305615c6b6c24885b1ab3056171e9b59f877623c4f300dc1448ee408599005e4c89023b5ab76fbb88686866f17c6dcc2786b6f835fcb682d3c7f98601a82891cc911b2200bc8911ca94ab5ab76fb9842d3fef9c278a0134d7eb9b1f084134e3858300dc1448ee408599005e4488e50bb6ab70fa8afaf3fa9a1a1e1b5e2e67de8d0a1e9f2cb2f4f2d2d2de9e5975f4e6fbef9660a3b76ec486d6d6d69d1a24569ca9429e9e4934f2e6dfab70df4bdfd822998c8911c210bb2801c1972a476d56e7f68f68f2d34e8ef1437fab7df7e7bdab46953aac5962d5bb2e7c7e71537fe85d73c55300dc1448ee408599005e4488e50bb6af7c0edd96f6ff6cf3efbec6c6f7e57c4e79d73ce39a54dff30c134041339922364411690233942edaadd5e14e7ec171fc63f69d2a4f6c3f6bb2a0ef7bfecb2cb4a0fef3f44300dc1448ee408599005e4488e50bb6ab797c44afcc57bf6bbdbec1737fd257bfa170aa62198c8911c210bb2801cc9116a57edf64eb3ffede273f6bb7a187fb5c3fb8bcfe91f6887f60ba660224772842cc8027264c891da55bb7d7eef7e2cb8d713a64f9f3e60f7f20ba660224772842cc8027264c891da55bb7dced0a1433f9b2fd4177be15f7bedb51e69f863f5fe924bf67dbed2f75478ecf0fafafa998269f44430fb5b7d99e00c399205431690233952bb8686bf4b0ae13a336fc2afb8e28ad493a64c9952dcf04f2c17f6c29855187be2398331988f3df658fadad7be963ef2918fa48f7ef4a3e9a8a38e4a8b162dca1e2b7ca96cf44431577aedfcfed2b1bfbf4e6f04b3bfd69709cee84b139c1cc9822cc8821c1972d43f6ab778db3d7a8bc30e3b2ceb350e545fd197fb8701ddf017c235236fc2e7cd9bd7a30d7f34ae450dffac4a61cfc7600ce617bff8c5aca0972d5b969e7cf2c9ecf6e73ef7b91e2fe68e82b4bf8276201afefe5e5f2638a32f4c7072240bb2200b7264c851ff6cf8e3766b6b6b763b9afe03dd446bf87bbfe15f95876c7f2fd657aaadadadb8e15f5b5f5f7f641cbe531af6c1dcf0c75efd28e8679f7db66ab1bff0c20be988238e481ffef087d389279eb8cf63f9ed891327a68f7dec63e9539ffa54bae9a69bb2c7e6cf9f9f0e3df4d0ecf33efde94fa75ffffad75d6ef82bbdd63df7dc93bef4a52f65f7c7cff3f5af7f3dfb7e4b5f278e2889db175e78618f0473a0d49709ce3890139c1cc9822cc8821c1972d4ff1bfefce3d83e2f7daca3fea05c4f51cb631d3daf5a3f53eee738f5d453b3dee2cb5ffe72d62bc591d0f98ed2785efc1b1f7ff5ab5fd5f09734fcdbf290edaf4bf155bb445f51a8dfad14f6c1dcf0e74d700462cc9831ed055c1a9e6f7ce31bd9ed993367a6193366940d563cb67cf9f2ecf6273ff9c9ecb108731ccab376eddaecfe4f7ce2135d6ef82bbd56fc1b1faf5ebd3a7b3c6e47988b5fe7c61b6fccfe1d356ad47e9f54f62e10396ba0d49709ce38501b6772240b8639458e0c73cac0dac31fcd72e9631df507e57a8a5a1eebe879d5fa99723f47ec548c11b76387e21d77dcb1cfcec30b2eb820fb387f4341c3ffe786bf3d64bda15ac8fbf3d89fff29c6a90f23478ecc9afe28da7813a0343c711e4edcdeb56b5736ca05ab38241ffad087b2dbd1849f77de7959035eed736a69f82bbd56fe6e5bbc5bf7cd6f7e335d77dd7569f3e6cd65d704983a75ea7e9f54066a8d0d8661a3a8cf6d9c19b230e8877a9423c39cd25f6bb7789b3b7a8168ec172e5cf8816dfb5afb83e29ea2d6c7aa3daf5a3f53eee7287e5e7c6edcfecc673e93feeaaffe2a7bde17bef085eccd846ddbb669f8fbc81efe5d279e78e231857f1fb187bffcc8df658b82ee6ec39f7f7cc8218764b767cd9ad5ed86bfd26bc5f713bf9371e3c665eb0fc4fdb13641f1eb9c79e699d9213971e87f4f1d363650eacb3bdac6813cfc528e64411664418e0c391a1887f4577aacd6fea02b8f557b5e771afee823e2b1499326651f5f75d555d9bfe3c78f770e7f9986ff809dc39f7f0f0d0d0d7f5ff878a186ffcf818bc36a1e7ffcf1b2cd72dc3eeeb8e3da0f81b9f3ce3b3b1dac7c41c0ee34fc955e2bce9b89db8f3cf2487ae59557b2dbf1ee5be9eb0c1b362cbb1d8718f56430fb7b7d0df609aeda952baa8d381f2d0ef7aa76fa4cbc131c47a27cfce31f4f43860c695f6b22469c76923f7ef0c107ef737858f13be651e7715ffc5b5772258bba2eae8e5b57e1ca187555ae9a51cbfdf173c61b71f1e6ab1c0dac39259f3be270c9f878ce9c39d9c77184557c9c1f461935dd97174bea28b707e2fb9585c1d734f5c4bc53faff72ece18c1d3bb5d46c67f35debfc158fc736667373f307be8fb84c773c16f3c68a152be4688037fcb5f607fbbbe1afd6cf94fb5e6fbffdf6f63725e228e2786cddba75592de7a714e739d1f0efdbf01ff055fa737bdff55b38981bfe254b96b44f323119c424933714752587dec43938f19c58c0a2aec2221ca51fc7e410af1de7ce77b7e1aff45a6bd6ac49dff9ce77b24932bea7383c2826c1d2d7b9efbefbb2dbb148476f04b3bfd6d7609fe0ba7ae58a6a351db51b8ffddddffd5df64e717e3e58be726d7e4e58642b9ae3d1a347671fc76454bac114ef2817afbf5129579d591db72b79ec68928cdbd75c734dfbc2397234b0e69458f3a5aee814b03834333ece0f0dcdf77c444df7e5867f7f7cad9e6ef86561e06f9bf5c4bc536e6e2877ca6677f35debfc15b763d1b3b81d6f28943e16db71713bceab96a381dff0d7da1fecef86bf5a3f53ee7b8d7a8ec7635b6ad5aa55ed8f0f1f3e3c7bfce8a38fb64a7f39f5f5f567e6218bff487ad29429538a1bfe8995bea7bdeffa3d32188359eb88775c274f9e9cfd671e7b258b1b09878d550f667fabafc13ec155bb7245ac0d11ffc9e77b61befbddef66eff4e6ef54579ae86272c9df512ef735f3a354f23dfe3121d515adfa9abf6e6c247deb5bdfcaee8b7fe3dcb88e26b94a6fccf546c31fe7b4d5bae12a47fd6b4ec9173bcaf72e7ee52b5fd9e7e8aa78732bdfe88f3d77b1d1149989ac9c71c61969ebd6adfbd44bbc4ee962ab1d5d5da596d72db74a73e951637535ac1cdd9b57839185c1d734f5c4bc536e6ec89b938efecfef4cbe6b9dbfaacd4bf91b0871faa56db3c1d1571ca8d1dd7e2676da4426231b7545475d6af84b0c1d3af4b3f98a9985dbd984dd13b66cd9924e3ef9e4e286fff382d9f5118d4a04a2f870b39e28f281d8f0d3bf7254edca15b1b865ddde43d0e2e898b81d2bbe76b401151b37f158de8c948e7cc3ad74632d3f5f2c7fedf87ee2b93151c56be67b61aaede12fb73a6ead87f4d7d2f0573bcaa074e34e8e06ce9c126fe6c41e9218719455fc9df33d74b11724fee6f1586c18e57bfc624f60de4844735e5c2f71886f9c92d599ababd4f2bae55669ae56db7de16a30b230f8b6cd7a62de29f7ff7234d4a587507737dfb5ce5f713bffdaa5479ee5238e0ab36da6e1efcbfd4ccc05f1b971544efe86b0bea2f2bb6a73f3463cce8de8097b2f6b938f85826968f8a9354795ae5c51ba47a5aec22297a523368ce2b17883b3da1b021d6d30e54d4dbe604c4c5c7515ce9fafb63a6e6fede1d7f00fec3925bf424a3402f1378ebd8e51777b0f936d6f88cb2d92549a9bb8bfd29b4995aeae52cbeb965ba5b95abdf685abc1c8c2e0dc36dbdff34eb9b921deac3afbecb36b3a0da5d67cd73a7fe523de842e3d7534e6aa380a27ceffb76da6afd0570c9c86ffdb79331e7bf9f7f7e27df17af1baf9d7287cbd61826908269dcd51e9952b8a1b8cce34cdf16e725d9543faf3e6225ff825162c2ab70731f6ecc706571c56191b59f1715d8d6b63d41dc043fa63634e8e06de9c72d14517b5ffbdf3c58ce230c7bc0188c6a2f870e5e2c63c9a9a8e6aaba3abab74e6756b7d83aa2f5c0d461606f7b6d9fe9a772acd0df9a1c81d35fcb5e6bbd6f92b6e474622a3b1a652f163b1e73f5f27207604da36d357e82b06884223de9a37e4f19fc6feba445f6c004f9c38f1bde2bdfb471f7df44182d9f1e164d55610ef2b0b27756745e5ba1e5a08caa432b07254edca15918bf838ce05ce0f4d8c452fe3b17caf4c1cb65fba61961fea1be7ddc76377df7d77f671be37235ff4283f14385fc426eeafb4b156ee5cccbed6f0c7efa9aec6f399e5a8ffcd2971187efef79e366dda0716938ca6b9f890e4e243efe3b0e55a6aabdad5553af3ba95eab534b77de16a30b230f8b6cd7a62dea93437fcf8c73fae697ba8d67c7766fe8aef317eae38bd267f63237f2c4e15a82b3a0dcdb699865fc33f301afecf17c6e6bc318f4354bbdbf447b37fd96597151fcabfada1a1e110c1ac3e3a5a41bc2f35fcdd69da35fcd492a36a57aed8b06143d664e48b84c57994717e633c76f3cd37671b31f139e5f650c4c65a6cc8142ffa557cde583c1e6f00d4edbdd451b9cb1a156facc5ff755d69f8eb3a7189bdee9cc35fb7f7b27cb55e9f568efadf9c12f345be973dbfdc579c7b5cb7f7d0f7fc728c712a4bac861c9989114d79e9e27a95eaaddad5553af3ba95b2519adbbe70351859187cdb663d31ef549a1bf2c6baa3eda15af3dd99f92b3f873acf48e963f1b3d5ed5dd3c3b699865fc33f40d4d7d79f942fe097efe9efeae1fdf179257bf607dca1fc3d15cc8e5610af6525e458c1353f3a20debc890da3786eac729c4f42f973f3892bde50c857a42dfe4fbf332bd2567a6e7ef997f8d9e2fed28d37c1c404678243166401399223b53bb75777eed5d23354ba624a5d952bb054fa9c386239dea48dfb4bdf68aad647d495b98a8cdaedfa9efe91c54d7f9c7b1f7fec5865bfd6d5f86381bee273f663d4d7d79f2f98b58d8e5610af6525e4384439bf144bdddec5c5f27791f395918b9f9b1f45f0b77ffbb71f68f83bb3226db5e7c621cff91b19f9d7d3f063e3ccc619b2200bc8d19f17bf2c37e448edf654c35f4bcf50e98a297555aec052e973f22347e273f23ea6333d47f15564d46e37f7f417c696e2863d1af8385768debc79d9defbfc70ff3884a8adad2d5bcdb4b1b1318d1831629fbdfa71187fbc892098b58f8e5610efec4ac8953eae2b5a8db9daeb746645da6acf2df77d6bf8d1e4d838431664013992230e4cc35fcbc795ae985257e50a2c953ea75a3f504bcf516ec14cb5dbf53dfd9f2fbe5c5f17c7c28178ce7e4f07b3a315c4bbb31272470d7fb9ebb4766645da6acfd5f063e3ccc619b2200bc8911cd1bf1afe4a574ce9cae7d4d2f077f62a186ab7fb8dfff17b1bff3d9d69f463affe405b8dbfb782d9d10ae2dd5909b95c486fbbedb6f630c6d72c7d5e6756a4adf6dc6a87f0082636ce6c9c210bb2801cc991daed7b0d7fa52ba674e5738e3beeb8f67ee0ce3befacb9e7d0f0f782a143877eb6d0f88f2f34f2330a637561ecdadbdcc7bf6b0b6356614c8c230304b3fba3da0ae2dd5909b95c48e3fcff38fc260eb989c36f4a9fd7991569ab3d3716e988a317e2678aef5fc38f8d331b67c8822c20477244df6ef82b5d31a52b9f13bd46f438d13be4fd40f4061df51c1a7e4c2a7de8b27826156c9cc911b2200bc89121476ab774c4d500264f9e9cad03173b03eb7af9d2e36a974115cc81b2f2ab60ca912147b260c8027224476ab7ef8f38943f1afcfcd27b471d7554fb51cc6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176114cc1448e0c3992054316e4c89023b56ba85d045330912339421664013932e448edaa5d04d3104ce4488e900559408ee408b5ab76114c4330e5c8902359306401399223b56ba85d04d3104c3932e448160c59408ee448ed1a6a17c1144ce4c89023593064418e0c3952bb86da453005133992236441169023438ed4aeda45300dc1448ee408599005e4c89023b5ab76114c433091233942166401399223d4aeda45300dc19423438e64c19005e4488ed4aea176114cc1448e0c3992054316e4c89023b56ba85d0453309123438e64c190053932e448ed1a6a17c1144ce4488e900559408e0c3952bb6a17c134041339922364411690233942edaa5d04d3104c3932e448160c59408ee448ed1a6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176e9587373b340f49db1ab10cc3daa528e0c3992054316e4c89023b56ba85dba6dc18205eb376dda24147d60b4b5b5fdae10cc95aa528e0c3992054316e4481dcb91da35d42eddd6d2d272dcbc79f3ded8b871e34ee13870efc045289b9a9ad614c6f1aa528e0c3992054316e4488ee448ed1a6a97fda2500cc7ce9d3b77711cf611e77a18bd3ee2f7be5228e5c8902359306401399223b56ba85d0000000000000000000000000000000000000000000000000000000000000000000000068cff0dc2a0a6105799a6d20000000049454e44ae426082', true);
INSERT INTO act_ge_bytearray VALUES ('16', 1, 'process.bpmn20.xml', '15', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566223e0a20203c7369676e616c2069643d227461736b457374696d6174656422206e616d653d227461736b457374696d61746564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c7369676e616c2069643d227461736b436f6d706c6574656422206e616d653d227461736b436f6d706c65746564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c70726f636573732069643d2270726f6a6563742d776622206e616d653d2250726f6a6563742057462220697345786563757461626c653d2274727565223e0a202020203c657874656e73696f6e456c656d656e74733e0a2020202020203c61637469766974693a6576656e744c697374656e6572206576656e74733d225441534b5f435245415445442c5441534b5f41535349474e45442c50524f434553535f434f4d504c455445442c54494d45525f46495245442c41435449564954595f43414e43454c4c45442220636c6173733d22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e6572223e3c2f61637469766974693a6576656e744c697374656e65723e0a2020202020203c637562613a70726f63526f6c657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226d616e6167657222206e616d653d226d616e61676572223e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a70726f63526f6c6520636f64653d2270726f6a6563744f6666696365456d706c6f79656522206e616d653d2270726f6a6563744f6666696365456d706c6f796565223e3c2f637562613a70726f63526f6c653e0a2020202020203c2f637562613a70726f63526f6c65733e0a2020202020203c637562613a6c6f63616c697a6174696f6e7320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d227275223e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d0bfd180d0bed0b5d0bad182d0bdd18bd0bc20d0bed184d0b8d181d0bed0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c2e617070726f7665222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c2e617070726f7665222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d22656e223e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c2e617070726f7665222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c2e617070726f7665222076616c75653d22223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a2020202020203c2f637562613a6c6f63616c697a6174696f6e733e0a202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c73746172744576656e742069643d227369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430223e3c2f73746172744576656e743e0a202020203c736572766963655461736b2069643d227369642d37353031463341322d343231392d343935312d383742362d43414434304631323442333122206e616d653d225365742049444541222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c274944454127297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d43363743333142432d304137392d344536312d424433322d3646394539373434393244332220736f757263655265663d227369642d37373642303732312d303735362d344335302d383032312d31363034334341314241443022207461726765745265663d227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331223e3c2f73657175656e6365466c6f773e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d32414345433541452d383143422d344238362d413632322d38383944364637444446453222206e616d653d225761697420666f72207461736b7320657374696d6174696f6e0a223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d227461736b457374696d61746564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c736572766963655461736b2069643d227369642d37423431423830382d413131442d344134342d383537362d39364530424633354230333022206e616d653d2253657420455354494d41544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27455354494d4154454427297d223e3c2f736572766963655461736b3e0a202020203c706172616c6c656c476174657761792069643d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e3c2f706172616c6c656c476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d43374346383445362d364438462d344243322d393338332d3642463346393631423446392220736f757263655265663d227369642d37423431423830382d413131442d344134342d383537362d39364530424633354230333022207461726765745265663d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d226d616e61676572417070726f76616c22206e616d653d224d616e6167657220617070726f76616c223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22617070726f7665223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6d616e616765725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d45313441304435392d353436352d344534452d423245312d4646373439333444383646442220736f757263655265663d227369642d45393432324139312d463735422d343042322d394332452d39333835303433354133353922207461726765745265663d226d616e61676572417070726f76616c223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d2270726f6a6563744f6666696365417070726f76616c22206e616d653d2250726f6a656374206f666669636520617070726f76616c223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22617070726f7665223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b70726f6a6563744f6666696365456d706c6f7965655d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b747275655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d34314532373734412d444530442d343841432d413641392d4232353038314546393946322220736f757263655265663d227369642d45393432324139312d463735422d343042322d394332452d39333835303433354133353922207461726765745265663d2270726f6a6563744f6666696365417070726f76616c223e3c2f73657175656e6365466c6f773e0a202020203c706172616c6c656c476174657761792069643d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f706172616c6c656c476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d34394542314131422d354232312d344139432d414638442d3446343235313243423846382220736f757263655265663d226d616e61676572417070726f76616c22207461726765745265663d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d34383631363334362d413334352d344336382d423138342d31353945374331323844423722206e616d653d2253657420455845435554494f4e222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27455845435554494f4e27297d223e3c2f736572766963655461736b3e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d43313932433337462d303534312d343436392d424233302d32314644364134463642413322206e616d653d225761697420666f72207461736b7320636f6d706c6574696f6e223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d227461736b436f6d706c65746564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c736572766963655461736b2069643d227369642d44394332353945302d304243352d343430412d393234412d37333541324646423741463422206e616d653d2253657420434f4d504c45544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27434f4d504c4554454427297d223e3c2f736572766963655461736b3e0a202020203c656e644576656e742069643d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d37334234343642442d304537302d343637452d393442362d3244433042334631353341312220736f757263655265663d227369642d44394332353945302d304243352d343430412d393234412d37333541324646423741463422207461726765745265663d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d44424533353631352d393041322d343341442d383842462d3841343646423036353341392220736f757263655265663d227369642d37353031463341322d343231392d343935312d383742362d43414434304631323442333122207461726765745265663d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e3c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792069643d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144222064656661756c743d227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541223e3c2f6578636c7573697665476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d42433139313930392d434633362d343736362d423938352d3931374333313243313045392220736f757263655265663d227369642d32414345433541452d383143422d344238362d413632322d38383944364637444446453222207461726765745265663d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144223e3c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792069643d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145222064656661756c743d227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746223e3c2f6578636c7573697665476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d42364635454533442d373030392d343445462d413138392d3037324341374641364337412220736f757263655265663d227369642d43313932433337462d303534312d343436392d424233302d32314644364134463642413322207461726765745265663d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d36363631384530342d393342342d343544412d393638422d39334134443439383641343922206e616d653d225369676e616c207461736b7320746861742070726f6a65637420617070726f766564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c617465645461736b7328656e7469747949642c202770726f6a656374417070726f76656427297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d44423535423131322d434437442d344534342d394245422d3737353541303642333243412220736f757263655265663d227369642d34383631363334362d413334352d344336382d423138342d31353945374331323844423722207461726765745265663d227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d41433236333439372d363544312d343239312d384130432d4243303934383939323744392220736f757263655265663d227369642d36363631384530342d393342342d343544412d393638422d39334134443439383641343922207461726765745265663d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d31344344324537322d313537412d344541322d383131362d3633423134413537384343352220736f757263655265663d2270726f6a6563744f6666696365417070726f76616c22207461726765745265663d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d32394243423741392d344545302d343744362d393243382d3844423746333333393236372220736f757263655265663d227369642d36434432453631352d353646312d344235322d383945442d46393544384133433132354122207461726765745265663d227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d30394531334437422d424242462d344341452d383846302d33373445393539413132363322206e616d653d22416c6c207461736b7320657374696d617465642220736f757263655265663d227369642d45314633334132362d424337352d343246302d424342312d42423832373134423838314422207461726765745265663d227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027455354494d4154454427293d3d20747275657d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d42304135443945412d464135372d344439412d423638342d3430303946354145394535412220736f757263655265663d227369642d45314633334132362d424337352d343246302d424342312d42423832373134423838314422207461726765745265663d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d45333539363042442d343942412d343834442d383842362d38443034413941434142333522206e616d653d22416c6c207461736b7320636f6d706c657465640a2220736f757263655265663d227369642d41453537453936462d434246462d344533342d414437322d33443434424444354330414522207461726765745265663d227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027434f4d504c4554454427293d3d20747275657d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d41313546433046322d443639342d343636322d393839432d3433314136414137463837462220736f757263655265663d227369642d41453537453936462d434246462d344533342d414437322d33443434424444354330414522207461726765745265663d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e3c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f70726f6a6563742d7766223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d2270726f6a6563742d7766222069643d2242504d4e506c616e655f70726f6a6563742d7766223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430222069643d2242504d4e53686170655f7369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d22302e302220793d2238302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331222069643d2242504d4e53686170655f7369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223130352e302220793d2235352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532222069643d2242504d4e53686170655f7369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223330302e302220793d2238302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330222069643d2242504d4e53686170655f7369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223537302e302220793d2235352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539222069643d2242504d4e53686170655f7369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223732302e302220793d2237352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d226d616e61676572417070726f76616c222069643d2242504d4e53686170655f6d616e61676572417070726f76616c223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d2231352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2270726f6a6563744f6666696365417070726f76616c222069643d2242504d4e53686170655f70726f6a6563744f6666696365417070726f76616c223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d223132302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541222069643d2242504d4e53686170655f7369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223936302e302220793d2239302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237222069643d2242504d4e53686170655f7369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d22313032302e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133222069643d2242504d4e53686170655f7369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223730352e302220793d223236352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634222069643d2242504d4e53686170655f7369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223330302e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436222069643d2242504d4e53686170655f7369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223231302e302220793d223236362e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144222069643d2242504d4e53686170655f7369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223339302e302220793d2237352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145222069643d2242504d4e53686170655f7369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223538352e302220793d223236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439222069643d2242504d4e53686170655f7369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335222069643d2242504d4e456467655f7369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223538352e343630373834333133373235352220793d223238302e3436303738343331333732353437223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223430302e302220793d223238302e30393738343733353831323133223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637222069643d2242504d4e456467655f7369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223939392e352220793d223131302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313037302e302220793d223131302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313037302e302220793d223234302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541222069643d2242504d4e456467655f7369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223431302e352220793d2237352e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223431302e352220793d2231352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223332362e343938363038313530353935362220793d2238352e33363736353830393337343139223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539222069643d2242504d4e456467655f7369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223332392e393939373934343137373536382220793d2239352e3037383533323935353036363739223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223339302e33393437333638343231303532362220793d2239352e3339343733363834323130353236223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433222069643d2242504d4e456467655f7369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433223e0a20202020202020203c6f6d6764693a776179706f696e7420783d2233302e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223130352e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741222069643d2242504d4e456467655f7369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223730352e303030313433303135383232332220793d223238302e30363535303135353838383239223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223632342e353833333333333333333333342220793d223238302e34313636363636363636363637223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335222069643d2242504d4e456467655f7369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e352220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e352220793d223132392e35223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632222069643d2242504d4e456467655f7369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d223131342e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746222069643d2242504d4e456467655f7369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223630352e352220793d223236302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223630352e352220793d223230352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e302220793d223230352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e302220793d223236352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633222069643d2242504d4e456467655f7369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223432392e35343534353435343534353435362220793d2239352e3435343534353435343534353435223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223537302e302220793d2239352e3131393333313734323234333435223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639222069643d2242504d4e456467655f7369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223637302e302220793d2239352e3230373436383837393636383036223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e343136363636363636363636362220793d2239352e3431363636363636363636363637223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341222069643d2242504d4e456467655f7369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341223e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313032302e302220793d223238322e3232363836313531373034393433223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d223238362e3435373839383339393434333235223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638222069643d2242504d4e456467655f7369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e302220793d2239302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439222069643d2242504d4e456467655f7369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644222069643d2242504d4e456467655f7369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d2237352e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139222069643d2242504d4e456467655f7369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223230352e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223330302e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131222069643d2242504d4e456467655f7369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223330302e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223233382e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray VALUES ('17', 1, 'process.project-wf.png', '15', '\x89504e470d0a1a0a0000000d494844520000046a0000014a08060000004523b99700004fd84944415478daeddd0b749455bae7ff3a0d1edba61d8f6bc6e5b86cdbee19c761b1582eba0796cc7844c6e339e21206db5b5149041a91200748822878900641fe8d57a0004545051a458c8818e562aa2a37b90882101004844043202422f7040cb8ffefb3a9b77c53d43da9fbf7b3d65ea97b2a95ecf7d9ef2ffbddafcd0600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020cdf4e9d3e7577c0a00000000000049e670381ee8d7af9f22ac0100249252aafddebd7b8bd7ad5b77c1ed76abd2d2525a829bcbe552959595df1b2d8fbf4800008014d0af5fbf678cb65f821a3e0d0040224948535555a5eaebebd5b973e768496a0d0d0daaa2a2e284cbe57a90bf4a00008024193870e02ffbf5ebf79ed1d63df4d043ff95a006009068329386902665c29a73a5a5a53bf8ab04000048026f30f3a5d1de95c0466e23a80100249a1cee4448923aadb4b4b499bf4a00008004ebd7afdf1fe45027bbdd3eceef76821a004042c91a2904242915d430160000004824efa2c1f576bbfd7efffb086a0000a91ad49c3e7e58edddf08efac6354937b92cb711ae10d4000000a42dcba2c17f08723f83330040ca0535a78ed5aa6dabc6ab2d9f3dd9a2c96d721f010b410d0000405af15f3438d8e3086a0000a918d41cf8e6934b421ab31dfca6848085a0060000207d045a3498a00600904e41cd8eb2e7830635721f010b410d0000405a08b66830410d00209d829a6da513830635721f010b410d000040ca0bb56830410d0080a08646500300009020e1160d26a80100a453502367790a16d4c87d042c04350000002929d24583096a0000e914d4ec5e3d2b685023f711b010d4000000a49c68160d26a80100a4535073b4b65a6dfb7cc2a5873d19b7c97d042c04350000002925da4583096a0000e914d448abf96ac125418ddc46b84250030000905262593498a00600905641cdd9b36af79ad72e3decc9b84dee236021a80100004809b12e1a4c5003004897a0e6d4b15ab56bf5cca06bd4c87df2184216821a000080a469eda2c104350080940f6ace9e5587777bd4d695ff1134a4319b3c461ecbec1a821a000080846b8b4583096a0000a91cd4849b45c3ec1a821a00008094d0568b0613d400005239a88964164da8d935042e043500000071d7968b0613d400005239a88935a4311b810b410d0000405cb5f5a2c104350080540e6a68043500000029295e8b0613d40000086a6804350000005188e7a2c104350000821a1a410d000040e481495c170d26a8010010d4d0086a0000002290884583096a0000043534821a000080f0414942160d26a8010010d4d0086a0000008248f4a2c104350000821a1a410d00004000c9583498a0060040504323a8010000b8341849caa2c104350000821a1a410d0000804532170d26a8010010d4d0086a0000007e0e4492ba6830410d0080a0864650030000b25eaa2c1a4c50030020a8a111d4000080ac964a8b0613d40000086a6804350000206ba5daa2c104350000821a1a410d0000c84aa9b86830410d002001f5afd468ff4c504350030000904ac1474a2e1a4c50030048444d9126818ddd6eef9e0a418df1ed7c6deddab5fa36f96abd9da086a006000064a0545f3498a0060090a8a0c6d256049a6193aca0e6a5975ed2b7bdf0c20b0435043500002093a5c3a2c104350080240435be1936d6c02619414dc78e1dd5bdf7deab6f93af9d3a756a11d4545454e8db2ebbec3275edb5d7aa79f3e6b578fee8d1a355870e1dd435d75ca3de78e38d90cfd9b3678fead6ad9bbefde1871f6ef17d1a1a1a54fffefdd5e5975faeaeb8e20af5c0030fa883070fb6f85e3d7af4d0cf27a8010000886d509a168b0613d400009215d45867d8c82151c9086a860d1ba6c3913367cee80045ae5b0314095cd6af5faf0e1c38a06fbbeaaaab5a3c7fe9d2a56adbb66dfaf2d5575f1df23977df7db7ef39c5c5c52dbecfc08103f5e54d9b36a9cd9b37ebcbf278ebf772bbddead0a143043500102ba554fbbd7bf716af5bb7ee826c546543474b6c73b95caab2b2f27ba3e5f11789444aa74583096a400da55143e3163ed0a26cc9086accc064c28409be10c51aa0d4d4d4a83163c6e8992cd6db6d7e8747c9e576edda857c8e044272b9a9a949b740f7599bdc66fd5ef29c441efa94e97f6f6cc5802c2403ccaaaa2a555f5fcfaaf1496c328db4a2a2e28431e07c90bf4a2468e09e568b0613d4801a4aa386b29d4c62a8b5c16eb7f7eed9b3677b795c32821a99492301cbf5d75faf67d4c8756b80228746c9e5929292b0414db8e74412d4040a636c495a33279367d4d07f812c25ff056480993203cd7346a1d9c15f25e2295d170d6600036a288d1aca763209414d8b80c6948ca0462ecbda2f72d9783f97dc670628724852a4414db0e7f4eddbd7376b67f1e2c52deecbc9c9d197659d1bf379b7df7e3b410dfd17405b92a9da0cf0526ad5fa66fe2a112fe9bc68300318504369d450b693090c6ad63a1c8efbfc039a640735cf3efbacbe3c65ca944bee9b3d7bb60e5e060d1a14715013ec39724854972e5df40c9ec18307ebdb65168fdc575757a7d7a9918584e5b9b23ecdfefdfb096ae8bf00da52220b0d8dc5d090d4429fd68b063380013594460d653b9980cf2ae00c9a6cebfb575e79a59a3a75aa3ebc4ace0025e1cb2db7dc42dfa7ff0248c541e6e11f4eab518b36eb269719145268901e3261d1600630a086d2a8a16c27096913d3e490270966cc5370df76db6d6aeddab5f47dfa2f8054283467cf9e53474f36faae57eea8f30d32e5b2797bfdf133eaf8a9460689141aa46681cf88458319c0801a4aa386b29d24a8a111d400c8ea422303cc85ab6bd4d3c5d5eaf3ad8754f9f6c36afc47db7c834cb92cb77ff6f54135d678cc2b2b77aa13a719685268902a326dd1e04806308f3cf248077ef3a0865243c18e1e410d7d9ffe0b20230bcdf727cea8311f54fb0695e1dae8f7b7a803df9fa458506890023271d1e0700318e36b4fa3d5f4e9d3e757fc05801a4a0d053b7a0435c969b6242c284c500320ab0acdf2cdb5110f323ff8723fc5894283d428e819b96870a8018c37a4a977381c77f017006a283514ece811d410d4d07f01646ca191a9dae620f2c9c55bd47b6bf6a93d75c77593cb729b79ff8a2db514270a0d922c93170d0e13d410d2801a4aa386b2a39791414d454585ead4a9933e3df6b5d75eabe6cd9bd72210314f952d8bff7efbedb711dfd7a3470fd5ad5b377ddbd1a347557e7ebeef94db43870e55274e9c50efbdf79e7e6c5e5e9e7e5cfffefdf5f5850b17867d5ff47dfa2f80362e3472360a59e8d07a3cbd0c2afd1f27b7598fb797e770260b0a0d9256c8337ad1e0203fb3cca4518434a086d2a8a1ece8656a502361c8faf5ebd5810307740072d55557b50844962c59a2962d5ba62fdf79e79d11dfe776bbd5a14387f46d12d2c86d12cc141717ebcb12d6c8fd72f9c61b6fd48ffbfdef7fafafcb7b09f7bee8fbf45f006d5c68024dcb96ff00fa3f4e6e0bf458068b141a244eb62c1a1c24a4a96700036a288d1aca8e5e2607353535356acc98317af68b3504312f373535e9269765364c34f799df43ee0bf6f8ce9d3bebeb656565faab043491bc2ffa3efd1700834c0699c84ad9b46870a0904666d23080013594460d65472f93839a8e1d3beae0a3a4a4246c5023872e457a9ff57bc87dfe8fefd0a183be6fd8b061fa7adfbe7df557997d13c9fba2efd37f01b471a161da36834ca445e1ceaa45830385340c60400da55143d9d1cbf4a0c69cedb269d3a68081c882050b7c61c9bdf7de1bf17dd6ef216bd9d8fc0e7d928046ee33afcb5a34f275f1e2c511bd2ffa3efd17409c0a4df9f6ba88174294c73248a4d02031b271d160f1c8238f749053705bd7a46100036a288d1aca8e5e260735b367cfd6a1c8a04183020622b2964cbb76edf42148723852a4f759bf872c263c78f060fd7da44948238b09cb7df2555e439e235f1b1a1a227a5ff47dfa2f8038159a95d5919f5af4d3af0f3248a4d02031053beb160db6ead3a7cfaf18c0801a4aa386b2a3972d414d2ca7c14e465842dfa7ff024840a1f9fec419f5747175c483cca73ed8a2ea8f9f61a048a1419c64eba2c10c60400da55143d94e12d4043e24ca5cf0379afbe8fbf45f00695c68ce349e55af7976eba9d94bbffabb2adbdef2787bb95cbefdb0fa7ceb213d187dbb728f6a3a7b96812285067190ad8b063380013594460d653b49504323a80140a1f11b68d61dfb79614359e8d01c64ca65f3f61f4e3632c0a4d02046e182976c5d3498010ca8a1346a28db49821a1a410dfd17a0d0846972360a7390c99929283468b3025cf6d0430fdd14e8be6c5d34380abdbc03985e7c14a086d2a8a16c27096ae8fb0435002834340a0d5ae5e1871fbe4b0ab0f74c46ffc5af3067f5a2c111b8cb68c78c36cdfbb5371f09a8a1d450fe2ad94ed2f7e9fb0435002834340a0d5a537c8bbd418db4b53d7bf66ccfa2c151ed7c983b1df29fe2067642400da586f257c97692be4fdf27a80140a1a151681013ef02c14d96a046dafb2c1a1cf5ce47b8db016a283594ed24db49fa3e7d9fa00600858646a141d8c23bd32fa4d1cd6eb797f0e904d52bcc4e86793f6b31801a4a0d653bc97692be4fdf27a80162a594fa65757575fefcf9f32ba64e9d7a62e4c891cd03070ed43b2c7979793f3dfef8e3e7c68d1bb7f7f9e79f5f68b4ffc92746a1a1d020ddb7570f3df4d0afed76fbb140418dd19a8dfbbaf369c7bc73c17f8c410da586b29d643b49dfa7efa763285312646c686d1be88188fb0ecf92254b164c9e3cb9b9b0b050bdfefaeb6addba75aab6b65635353529215febebebd5c68d1b95b163a40a0a0a7e2a2a2ada3764c890c17c82141a0a0dd2757be570380a43156109718cd6994ffe929d8a5e717a3c400da586b29d047d9fbe9feca0a6abfcc32ecc18918015f163ece00c7aeeb9e7ce3ef9e4937aa7e6fcf9f32a529b376f5663c78e3d9f9f9fbf23d8296d41a1a1d064af42a7c7f71916ce2c9bd0e2bad3f36991d37347a0e74d9cf8c13f1af79f34af1739cb2607da5efd70a2514d59b0568d9e5dae9acf5f886a7b65bea651687787f96fc901a38dbef8be26fec2785f67d9f988fa3fbff2bc53ec84801a4a0d653bc97692be4fdf4fa3b0664588f1a13ef1043d106dced86f69bf6cd932cfd0a1435549494954018dbf952b57aa4183063532bb864243a141a0a066c8eb25bf2a9ce9de6e5e2f9ae6fa6f854e7775a4af337ede869381b657955b0ea88f2a76a90b177e8a7a7bf5c4ecb226cb29b9cd76ca6855b2668dc3e1e8e57f9aee82e9ae5b8c9fe14b763e92f27c801a4a0d653b09fa3e7d3f91414dd760418d3146bc8fde87b88434e5e5e5eb478c18a176eddaa5dac2be7dfb94b113d53878f0e07fe713a6d05068600d6a0a67b8471738cbc698d70b9cee978a667a86e9fb667ac61bb71f97992a05333cafe8fb6796d98debf3cdd7309b757b65bd7df8c8429553f0a21af1ca2af5d8731faafff1873b54c78e1dd563f98faba7667bd4079e1dcaf9e1c64b9edb7f489114dbc6bc3f3ffeedb0c97f3b5d306da5ef3d5c7cdf65e38cc7351aed48c14cf7438533cbee33be2e92fb46cdaeb8a1c8e9f9aad0e976f83f2e037f95e116c44cf4eb00d4506a683a6e2795a5b19da4efd3f7d323ac09b456cd0666d3202ee43fd312d2c81a0e6d495e6fc89021a71c0e471e9f32858642030943264e2c6b2fb367f4ac1ae3baf7eb7e39bcc97c9cdc56e474ff9b841d170312cfd372a8945cdebaebc097852f145fb2bd5ab468917a6cd22275ebffb9438d7de95df5ce4715aab1b151edaf3ba19e79f30bb561c30635f99537d563cf2e545dbadda61f6f3a7cf4b47ae16f552a2727e782b1bd9a1ee83d78df7f63c174d7b5239cae4e12c218ef6b941c325538cbf5bf8deba545b3cb6e0af4b80cddf968abe9f8fcc718d4506aa82d4bb7939104356c27e9fbf4fdd40a6a2e59ab86b5691017b2c6831c3ed056336902cdace9dfbfff3163e7a7239f36858642435023336764d68cf57a81d33345ae17cdf00cd10188d3532b618ef1b8d7bd8f9b2fb36a647b357cc21cb5ea8b2dbe6d8c2c149c9797a7baddf62fead9375dfab6275ffd798d9ab33f9e574fbd56a12f7fbe7e9f3e3c4a7e979d3b77d6c5559ebfb472b7dabab7416f071f1ff3fc993173567fefff1ef4fb98e9b9cdb8fd55792f3fbf2ff72209695accbcf17b5c06f15fe0f21f8c36c0fb351afecf63e14c5043a9a199ba9d6c8ba086ed247d9fbe9f42ec76fb5266d320aee46c2993264d3a276b3cc4d3679f7dd6989b9bbb964f9c4243a121a831dab611cee5ffc972fddb2766b96ff45eff7184b3f21aef4c949ac269655dbcb7af343625ff22dbabb1afba5a8434bd7bf75677dd7597faa8ec1be5d9b85fdf3e764ea59e49236bd5947ffd77f5be7b87befd9dcfb6aaed35dfebcba74e9df23df7d97756fb5e73d44c8f1a3d76fc5701dec3c951b35c37fffb2cd77ff6cdf471962d2f707a465e9c25e4d93f6c76d9af033d2ec3763e7a5bc296b7bc3b186f4511d6047b1e3b21a0865243336d3bd996410ddb49fa3e7d3f75829aee96b569e88f687b4b972e7d57ce96f2e38f3faa781b366c581d8740516828340435e6ec19f37a91b3ec03cbf55912d6143acb3e91c0c33c1c4a2ecbd14d4f3ef994facbdc2fd4c255dfe8ed8acca491a0454297e7dffd52fd70f2e2e9b8b77c57af26bcb55a9ffd69d26b9fe8593562bcf15cebd9a09a9b9b559f3eff4f8d7ce953df6b7e58be5315ce70a949f3d66c6af91eca72bdb37d1ae5502cf37d15bde2be5e2ecb2150054ef7f0408fcbd09d8f017e3b19918435d690c66cfd2df7b31603a8a1d4d06c096962096ad84ed2f7e9fb29c25cab86d9346873329b66f2e4c9cd724adb44d8b265cb3966d55068283468abed95ac31230b0437343404ddee545454e8ff76ac59b326e86324e491c3a0ac6bd6b0bd8a68a72050e8122aac09f4f8b9011ecf5a0ca086524333653b198fa086ed247d9fbe9f1a414dd7fbefbf9f7d03b4bdeaeaea7c5940b835a7e18ed6a04183ea8c3feadf65fb67ef70384a8df6cf141a0a0d7d21b2bee0bfbd92993037dd74935ab16245d0edcdd9b367d5e38f3f2e0b04abe1c387879c3928bf5b793d79dd4cdc5e45fa3987d8f9e81545f81228ac8934a4f1df09613a31a8a1d4d074df4ec623a8613b49dfa7efa74640abe8836873f3e7cfaf983b77ae4aa469d3a66d36767c4667fb676f39a6b1548e71a4d05068e80ba1fb82fff64a7e175dba7409b9bd292e2e56b9b9b94a66e1c8d7a54b97867c7cf7eedd5b043f99b4bd8af4738e7127205c58136d4863fdfe0d36fe630c6a283534fdb793f1086ad84ed2f7e9fbc963f6fd693666b7a1ad4d9d3af5c4ba75eb121ad4ac59b3669f1ccfc720f3e7d3b979db8a40ffc5a1d05068e80b81b757324366f2e4c941b735478f1e5503060c50f3e7cfd7d7e5ebc08103d5b163c7823ee7c5175f5483070fcec8ed55a49f73800148a4038f6061cd2f620c694cacc5006a28353453b693f1086ad84e06e076bbe973a9d39a8cbedf9ca1214d6f4b1f243045db19397264f3e1c387131ad4d4d5d5d51b85ef0083cc4b0603beffe25807050c321964d217026faf1e183c4e555555a9f3e72fa831732a2ed9d6cc9e3d5b872ea74f9ff6ad43f3e8a38faa3973e65cf2d8e56bf7eaaf5f7eb95e0d7f7979466eaf22fd9c5bb9f31128acd9d98a90a62d7786400da5514353613b198fa086eda49fcacacac3f5f5f5f4bb1468b5b5b5ef1b7d7f47068734f441b43df9efb29cda3691e4fb1945af894166e0c180f5bf3832ed964126834cfac2c5bee0bfbd1af6e2a741b75f7bf6ec9181b55ab97265cb4066f9727dfbbe7dfb5adc6e063db23e8d4daf5b9c79dbab483f675bebff331b28ac694d48e33f00e238705043a9a1e9b09d54716c6c27c3f0783c7dcbcbcb8f1f3972a491be97bc993412d2b85caefd467b3043feb4c2f5fd5ef441b459414a86080a21cddb1864a656e36f327ecd919ba7f29f7955154c2fd5a7ca1e306c8cefbec1a35f306eff5c3df3e617eaebdd47949cd2db6c9b761d51ef7ebe5d6f5baaf734a8290bd6aaa2e9ab54d1e437f5a9b84b37fc1ccaac58b747151aaf53e474aba595bbf56dfeaf7577ded88b0b11ff785ebf6e36fd0ebc672e9036ad95e5450e77f29f49b3d37b7b6b4ca3afd0a26dd42e6a6892b693c9086a6cdef7258ff9a76cdfcf71b95cbd8d71f40639ec46c6d3b48437f9dc77646048132e8461660d5a6fc080013f257a464d6363631d336a42fed76683dd6eefddb367cff6f238821afe1b982d7de1b1b1337473387254de9ff355d1b415e7ccbe50e8f4340e7c34ffa77d878eeab0e6f0d1d3ca5ee4d4335e248859f9658ddebe7836ee57afbc5ba106154e52ce45556acdd65af551c5ae16dba0b55fae5703868e564fccf2e8ebf25ace0f2f9ef27bd5977b55f77b06e8cb4b8ce7add95e7f323737b7a960baab9bf11e8ec8fb2d9ce179bac0e9de34c259794d81d333b26086e7954cdae6b4c17f8342cda8798b1935a0865243b3643bc98c1a207344dbb7e88b689d1123469c4bf41a35870e1ddac91a35010703fe83005b320699ebd7af57b7df7ebbbafcf2cbd515575ca16ebbed36b57af5eab0cfaba8a8503d7af408789f39b0b05e9676e59557aa912347aa3367ce5c729ff53966bbe5965b7cb7d7d4d430c8ccb0be203366acb35b46cd2a3f6b3ea670a6e7b6c2e7debee059bf536f476436ccbffda9bf5ea34666bdc84c18f1b795db54c17f4c55635f7e5f6df9ae5e2df67cab36eeacbbb830f0d65a1df24c786bb57a625a892a78ee6d7da893bcd6d6bd0dfa3112eef4ec9dab2f3ff96ab97cd925dbab61b3cb7e6dbca7d3fabd383df30b9d6e87f77d390b6696d933699b6319609cb2c5678d9a58c21afe3b85b8d5d078d63dff7a16ea7b05db290f5547d7ae5dab6f93afd1d6ce48be5fa8dbfd6b78860635f1d84e860a74da624792ed24109f90a6770ccf3b455883988c1f3f7e77a2cffab46ad5aae59cf5a9c56060adc3e1b82fc82020e141cdcd37dfac070bd5d5d56ad3a64dfaf20d37dc10f679810687a1821ab93c7dfa747d79f4e8d1615fe3abafbe6a3140940561096a32ab2f144e5fd5bceffb1f87f9f78542a7e7e4a859ae9b5f71cede6bce8299346f8defac4f733edeacf6d45e3c93d3e4374bd580fc223563f13a7ddb1b9f6c51bb0ffca0ef7b6256993ad5f8a39e41f397b995ea914787ab929212fd5aa6b1d33f56f9054f5fbc3ca7527d577b62f55ffe32f1d342a7bbd0686f7adfcfca22a7eb76efe58f47cd70fddf4cdae6041898443ac008760aee40677d8a26ace16c26886b0d8d77dd8bf67b057a6eb0b0e4a5975ed2b7bdf0c20b01839a486a67b8ef17ec76ff1a9e61414dbcb693f10a6ad84e02a915d2b4d5f391ad5e7cf1c5b98684063513264cf8cc2880a3196486fc2f4dd2821af90f9f0c16befdf6db4bee6b686850fdfbf7f7fd27f081071e50070f1ed4d76d41fe93172aa891b3f05807a9a106bdf25f3bb94f169495af0f3ffc30414d86f5853aa5fa15383d870b9d9eb3462b2b9c56d6e5621852962b871d8d9ae539ffd7d73e54172efca467c5bc38cfa5ba74e9a2170296333f9d387142154c5fa5de7c73ae0e59e436f3abf8b07ca70e6bde2ca9d6cf79edb5396ad0a047d55fe67ea116aefa463f66c42b2bd4f2e52bf4659991f3d46c4f5391d3d36c7cffb764568d191c4d9cf8c13fca65e3be1fcccb99b2cd897180112ca4f98710f74712d674b571ba4bc4b986c6bbee45fabda20d6a3a76eca8eebdf75e7d9b7cedd4a9d325cf8da476c61ad4f8d7f00c096ae2b99d8c5750c37612888f68170d6fcdeb002d3df3cc33ff7df8f0e117ce9f3f9fb0933ee5e4e4ec310ae1eff8f42393e8a0c6fcaf5c870e1dd4b061c3f47ffdccfbcc819efc1770f3e6cdfaf2dd77df1df38c1af3fa65975d1672aab5ac4372cd35d7a8ebaebb4e4e97ac6f97c1aedc4e5093bddb2b396ce9a69b6e522b565c0c562474fef39fffac039b481c3b764c0d183040bdf5d65bfabafc6ee5f5e475d95e4535c00817d2d8620c6bcc29c3f7f1d78f78d6d078d63dff7a16ea7b451bd4c8f3253092438fa48ecaf5586a67a8ef670b7108967f0dcff21ada9a1db1d604356c2781f8f6e95e6dd47f995983e88d1a35eabb8d1b3726eab0a785c64e4f159f7aea0635d2e47879199cca4052363c32b094dbfdff83284d6e6beba0c6fff94b962cd1b78f1933465fffe31fffa8af27e3b321a849adedd5a2458bf47f95b76cd9a2727272d4a44993a23a23c1840913f4f376eedca93a77eeac5f8fed5554038c48439a68c31af3fbb1f38184d4d078d6bd48bf57b4414d7171b1fe2adb31f9ba74e9d2168f8bb476da629c514350d3663b62b106356c2781f8f6e55e6ddc7f596018d179f4d1471f7ae289279a1330abe698b143b4c9e170e4f1a9a7765063b603070eb418949a03d640335962096acc69d3325d3bd46bf4e9d327e07ff7ccc127414d766faff2f2f2f4e9525b73bad5071f7c507f657b15920c2cfca7d70f8822a40915d6f4f7fb3efcd70949a9a1f1a87b917eaf68831a9949d3ae5d3b75fdf5d7ebb044ae5b1f1769edb4b5f2d027b3865343836e27e311d4b09d04e21bd2f48e53ff25ac4174f2f3f3ab6551cd7892f570e4bfd3511ef7cb2033c1418dcc4e908d8d9c99c25c8450163f94fb64e6815c7fe38d377c8b20cad92be43ef33f8372d849a869d5d6cbf23a7279dcb871410786325d5b06a27ffad39f7cb7bdfdf6dbfa71b23e09410ddb2bf97bebddbbb7baebaebbf4e14cd1901d0df3b9f23a6caf22de39e81520748924a4b185791e031824bc86c6bbee45fabda20d6ae4b29c754a2e1bdbaa16f745533b630d6afc6b383534e876921d3d2033439a58faaf751b41d08af0640d8641830635eedab52b2e214d7575f532e37b1c76381c1df9b4533ba89163f0cd5387ca204f4e1d6a9efe53067e325d5b8e7197fbe538fdfdfbf7fb0680575f7db57ecec2850b233e3d77616161c863e267ce9ca9bf8e1f3fdef7385984d1bcdffcfe0435d9bdbd929d249959233b41e69a35e1c8ef520e77929934d69086ed55d403190959fadba23fe5b6fff3a2ddb901daa486c6b3eed9fcd67809f5bd62096a9e7df6597d79ca94292dee8ba676da6258a326500da786c6bcc317cd8e1edb49203e620d4f5a7be822610dc233767272f3f3f3cfd4d7d7b7694873f0e0c12f727272f67308417a0435340699e9bcbd923566644160f98fb19cbabbaaaaca17c2c822c11b366c90d932aa7bf7eefa71d63569d85e25758011cbe1020035941a9a09dbc94877f4d84e02f10d696209405bbb1838c12b22939b9b3b68c89021a7da6a668dfc675a767aec76fb583e5d06990c329188ed950432f27b1a3e7cb8eadab5ab6adfbebdaf884a383378f0603debc6727627b657c90d6bf8af12a8a1d4d06cde4e46b2a3c77612886f1f8d352c694d50637e7f025844c6d849e997979777e2e38f3f3edd8a05868fbdfcf2cbefc8e103461bc8a7ca20934126d85e65a4d64ec3671a3fa8a1d450b6936c2781648634ad09495a1bd458fb38610dc2933520727272dcf9f9f9759b366d6a8c6287a7e9f3cf3f5f64ec386d90853859e3814126834cb0bdca9a9d906807184cf90535941aca7692ed2490ae214d5b05356df97e90453b400fca0ed0c08103eba74e9dfacd175f7cb1bfb6b6f6b0b9e643636363dda1438776ba5cae4f274e9cb822373777afecf0c87fa5395b0a834c0699607bc580870109a8a1346a28db49208544129caa38b6707d9e6016913376687ee370380a8d1d9a62a3d518ad49ce94e2fd7ac06825461b2dffd9e6d36290c920136cafd80909a1abd14e19ed3e3e325043a9a16c27d94e0209f44fdeb0645a98c72523a811d3bc63565a80c69f2f1864d2186402b1e9e5ddb9e815e2fe06763e400da586b29d643b0924b10f869bb9c28c9a14435003069934069940eb04fb8f31d3f8410da5865243d94e02a9d2074fd958a386a0066090c92013c8e29d100620a086d2a8a16c278154ec83ad99c1c2599f086ac02093c6201348cb01d0340620a086d2a8a16c278114ee83b1f6bdd60635b21e55037d9fa0060c32690c328144eae51dbc70bc35a8a1346a6890eda4770784ed2490bcb14aac614d6b821af3f02bd6a322a801834c1a834c20e1fe898f00d4501a35941d102085c53ab326d6a0c6fc7e84346c27c12093c6201300a8a1346a283b20000230cfb8164d58134b50c39a346c27c12093c6201300a8a1346a283b2000a20851223d1431daa0865370b39d04834c1a834c00a08652bba8a1ec800088423487414513d4441b0281ed241864d2186402003594460d6507243328a5daefddbbb778ddba7517dc6eb7fedba325b6b95c2e555959f9bdd1f23238ac8934a889e5b02ab09d04834c1a834c00a086d2a8a1ec8064060969aaaaaa547d7d3d7d2f89ada1a1415554549c70b95c0f666858134950d3da538083ed241864d2186402003594460d650724bdc94c1a429a94096bce197d7f479afe29b5f670250e77623b09069934069900006a2835941d10c8e14ef4b994eafbcd69fce714eb599a583898ed241864d218640200a8a1d450764040dfa7efc741b4872f71b813db49506868141a000035941aca0e08a2edfba78f1f567b37bca3be714dd24d2ecb6df457fa7e2bc297ae463b65b4fbe8896c2741a1a151680000d4506a283b2088b0ef9f3a56abb6ad1aafb67cf6648b26b7c97df459fa7e00bdbc214caf10f73710d2b09d04858646a101005043a9a1ec8020cabe7fe09b4f2e0969cc76f09b12fa2c7d3f9860336b38dc89ed242834340a0d00801a4a0d650704b1f6fd1d65cf070d6ae43efa2c7d3f8ab0869086ed242834340a0d00801a4a0d650704ade9fbdb4a27060d6ae43efa2c7d3fc2b0661a210ddb49506868141a000035941aca0e08086ae8fb49f6dbdffe7684f1457e364ec1cd7612141a1a850600400da586b20382d6f47d39cb53b0a046eea3cfd2f723e8bb25f7df7fbfead9b3677b7a1ddb496419b7dbcd063e755a9351689af9ab04006a288d1aca0e487a0735bb57cf0a1ad4c87df459829a50ec767b77a3ef364bff75381ccca8613b896c53595979b8bebe9e8d7c0ab4dadadaf78d42b383bf4a00a086d2a8a1ec80a4775073b4b65a6dfb7cc2a5873d19b7c97df45b829a3041cd52e9bbdeb6815ec7761259c6e3f1f42d2f2f3f7ee4c8914636f4c9fb2fa00c305d2ed77ea33dc85f2500504369d4507640d23ba89156f3d5824b821ab98d7e4b5013a6cf763567d398cd6eb7b39830db49641b6360d3dbd8c06d9029c3b2a1a325bcc9e7be83012600504369d45076403224a8397b56ed5ef3daa5873d19b7c97d042c043521fa6c8935a43167d5b0560ddb4900000000ec802086a0e6d4b15ab56bf5cca06bd4c87df2184216829a00fdf592d9346673381cf7d1fbd84e0200000060070491063567cfaac3bb3d6aebcaff081ad2984d1e238f65760d418d5f7f5d1128a4f1b6b5f43eb69300000000d8014104414db85934ccae21a889a0af069d4dc35a356c2701000000b0038228829a4866d1849a5d43e0425013646d9a4bd6aaa107b29d04000000c00e08c20435b1863466237021a8a1fff239030000006007043188f4f4dc34821afa2f9f3300000000b003126704350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e6700000000600724ce1c0e47a9d1fe99a086a086fecb761200000000d8014981cf4a9a043676bbbd7b3c821ae3e9be76f9e597ab5b6eb945ad5fbfbe55af15eb7ba9a8a8503d7af488fa790b172e54d75e7bad6ad7ae9d7ebefff5d6be2f821afa2f9f33000000007640e00b6a2c6d45a019366d11d4c8e5b2b2327d59c29a64cc44893550b9ecb2cbf4f34e9c38a19a9a9a2eb9ce8c1afa2f9f3300000000b003128fa0c637c3c61ad8b45550635e97a0c37a9fcc4ae9d6ad9bbeede8d1a32a3f3f5f5d71c5157a06ced0a1437520e2ff5a0d0d0daa7ffffefa31f2d8071e78401d3c7850dfb77fff7ed5b3674ffd7d3a76eca8d6ae5dab1f67b3cceef17f9fc1beaffff302bd8ef572a0ef1deefd12d4d07ff99c01000000b00382a0418d75868d1c12d5d6336aba74e9d2e23eb7dbad0e1d3aa46f93b0446e7befbdf7547171b1be2ca189ff6b0d1c38505fdeb46993dabc79b3be7cf7dd77ebfbeeb9e71e7d5d42129b65068f2dc48c9a48bf6fb8ebc1be77a8f74b5043ffe5730600000090cde1032dcad6566bd4c89a2e9d3a75525555552deeb31e3e64ce5891dba4d9bcb358fc0311ff992dd6c799f74573e853a4df37dcf560df3bd4fb8db665fadf1b5b31821a0000000020d46ad936d8edf6de3d7bf66c2f8f6bcb439fc2dd278705f907261d3a74081a88045a232696a026d2efdbdaa0a62dd6b4c9e4193520a80100000000829a20018d2991418d798890f510a461c3865df2f89c9c1c7df98d37ded08713c9e5db6fbfbdc5e147ab57af6e71f891042fb6208b0047fa7d233df4c9ff7b877abf04354846dfe753000000008014dc59f3b6b50e87e33eff80c694c8a04616f51d3c78b09e81224dc212eb62c272f8945caeababd3e18ab9f8afacf7220bf9ca7d353535ead65b6fd50bfa76eedcd9773af0b7df7e5b5d7df5d5fa35e414dbd17c5f5b84414db0ef1deafd12d420197d9f4f0100000000526f672de00c1a7fad096adaaa9d3973468721d75d775dd2df4bb21b410d086a00000000208ba5425073e79d77aa2bafbc522d5ebc98a086a006ad44500300000000692c15821a1a410dda0e410d00000000a431821a821a6416821a0000000048630435b12d964c50835445500300000000698ca086a0069985a00600000000d25822839a8a8a0ad5a953277d7aeb6bafbd56cd9b37af4520629ee2fa965b6e51df7efb6dc4f7f5e8d14375ebd6cd772aeefcfc7cdfa9b2870e1daa4fc5fdde7befe9c7e6e5e5e9c7f5efdf5f5f975379877b5f0435482704350000000090c61219d44818b27efd7a75e0c0011d805c75d5552d0291254b96a865cb96e9cb7226a848ef73bbddead0a143fa360969e43609668a8b8bf565096be47eb97ce38d37eac7fdfef7bfd7d7e5bd847b5f0435482704350000000090c61219d4d4d4d4a83163c6e8d92f364b08625e6e6a6ad24d2ecb6c9868ee33bf87dc17ecf19d3b77d6d7cbcacaf457096822795f0435482704350000000090c61219d474ecd851071f25252561831a397429d2fbacdf43eef37f7c870e1df47dc3860dd3d7fbf6edabbfcaec9b48de17410dd209410d00000000a4b1440635e66c974d9b36050c44162c58e00b4beebdf7de88efb37e0f59cbc6e677e8930434729f795dd6a291af8b172f8ee87d11d4209d10d400000000401a4b6450337bf66c1d8a0c1a34286020226bc9b46bd74e1f82248723457a9ff57bc862c283070fd6df479a8434b298b0dc275fe535e439f2b5a1a121a2f74550837442500300000000692c154ecf6d0b1188d892109624b311d4a0b5086a00000000208da5425063ce7e89f63e821ae05204350000000090c65221a8a111d4a0ed10d400000000401a23a821a8416621a80100000080344650435083cc42500300000000698ca086a0069985a00600000000d218410d410d320b410d00000000a431821a821a6416821a00000000486304350435c82c04350000000090c6086a086a9059086a00000000208d11d410d420b310d400000000401a23a821a8416621a80100000080344650435083cc42500300000000698ca086a0069985a00600000000d218410d410d320b410d00000000a431821a821a6416821a00000000486304350435c82c04350000000090c6086a086a9059086a00000000208d11d410d420b310d400000000401a23a821a8416621a80100000080344650435083cc4250030000000069cced761390a44e6b2a2d2d6de6af12ad4150030000000069acb2b2f2707d7d3d21490ab4dadadaf74b4b4b77f05789d620a8010000008034e6f178fa9697971f3f72e448236149f266d24848e372b9f61bed41fe2ad11a04350000000090e65c2e57efd2d2d20d72d88dac91424b7893cf7d07210dda02410d0000000000408a20a8010000000000481104350000000000002982a0060000000000204510d4000000202e834c5ae634fea20180a0060000000c32c1ef1200d8ee020000000c32c1ef1200d8ee020000804126f85d0200db5d000000804126f85d0200db5d00000030c804bf4b0000db5d00000030c804bf4b0060bb0b0000000699e077090060bb0b0000000699e07709006c77010000c02013fc2e01006c77010000c02013fc2e0180ed2e000000186482df250080ed2e000000186482df2500b0dd050000001864f2bb0400b0dd05000000834cf0bb0400b6bb00000000834c7e970000b6bb0000006090097e9700c076170000006090c9ef1200c076170000000c32c1ef1200d8ee020000000c32f95d0200d8ee020000804126f85d0200db5d000000804126bf4b0000db5d00000030c804bf4b0060bb0b00000030c804bf4b0060bb0b0000000699e07709006c77010000000699e077090089ddc696c876364cdbc0270500000076eec1ef1200e2bf8ded6ab4e650418ddd6eefcd270500000076eec1ef120012b39d5d1122a859dbb367cff67c4a00000060e71efc2e012031dbd9aec1821a87c3711f9f10000000d8b907bf4b0048ecb636d05a351b984d0300000076eec1ef120012bfadbd64ad1ad6a6010000003bf7e07709004962b7db97329b06000000ecdc83df2500a400bbdddeddb2364d2f3e11000000b0730f7e970090dc6dae5eab86d93400000060e71efc2e0120f9dbdcae6c7701204529a5daefddbbb778ddba7517dc6eb72a2d2da525b8b95c2e555959f9bdd1f2f88b04d8b9e77709c60c34c60cf4051a7d0140169322535555a5eaebebd5b973e768496a0d0d0daaa2a2e28451741ee4af1260e79edf251833d01833d01768f40500594afe13409149996273aeb4b474077f95003bf7fc2ec19881c69881be40a32f00c852325d938d7cea34a3d034f35709b073cfef128c19688c19e80b34fa02802c25c778b2814fa942c38e0ac0ce3dbf4b3066a03166a02fd0e80b002834e1dbe11f4eab518b36eb2697290c141a809d7bf0bb64ccc0988131037d81be405f008004159ab367cfa9a3271b7dd72b77d4f90a8d5c366faf3f7e461d3fd548a1a0d000ecdc83df256306c60c8c19e80bf405fa0200c4a3d0489159b8ba463d5d5cad3edf7a48956f3facc67fb4cd5768e4b2dcfed9d707d558e331afacdca94e9ca6d8506880e4eddc3ff2c8231df844086ac098813103e80bf40500c8c842f3fd89336acc07d5bec212ae8d7e7f8b3af0fd498a05850648cacebdf1b5a7d16afaf4e9f32b3e15821a306660cc00fa027d010032aed0485bbeb936e242f3c197fb2914141a20293bf7de90a6dee170dcc127425003c60c8c19405fa02f0040c6161a99ae69169227176f51efadd9a7f6d41dd74d2ecb6de6fd2bb6d45228283440b2821a421a821a306660cc00fa027d010032b7d0c88af4b2d899f5985a292cfe8f93dbacc7dcca7358cd9e42032470c75e66d228421a821a306660cc00fa027d010032bad0049a9a29ff05f07f9cdc16e8b1140c0a0d90a090a69e9d7b821a306660cc00fa027d81bf4a00141a0a0d85064881904666d2b0734f5003c60c8c19405fa02ff0570920e30b0d53372934403a8434ecdc13d48031036306d01768f405005951687e5e0cad2ee2c5d0e4b1140a0a0d104f8f3cf248073905b7754d1a76eed3369429f12e041daa6de09362cc4063cc405fa0d1170050682c6d6575e4a717fcf4eb83140a0a0d10777dfaf4f995df0e3f7d263d839aae466b0e15d4d8edf6de7c528c19688c19e80b34fa02000a8db77d7fe28c7abab83ae242f3d4075b54fdf133140b0a0d90e81d7efa4cfafeee5684086ad6f6ecd9b33d9f1263061a6306fa028dbe008042e36d671acfaad73cbbf5f4cca55ffd5d956d6f79ccad5c2edf7e587dbef5902e486f57ee514d67cf522c283400410d22fddd750d16d4381c8efbf8841833d01833d01768f40500149a00c5a6eed8cf8b9bc9626766a191cbe6ed3f9c6ca4c8506800821ac4f2fb0bb456cd0666d33066a03166a02fd0e80b00283411345991de2c34ac4e4fa10152402f6f50d38b8f226d839a4bd6aa616d1ac60c34c60cf4051a7d010085860d3c8506483f7719ed98d1a679bfb2739fa6ec76fb5266d33066a03166a02fd0e80b0040a1a1d000e91fd298e18ccca86920ac49dba0a6bb656d1a66473166a03166a02fd0e80b0028346ce02934401a8734e16e471a30d7aa61360d63061a6306fa028dbe00804243a1a1d000e9a3579830c6bc9f5919e917d474656168c60c34c60cf4051a7d01c800b9b9b9bfb1dbedc38dc15db1d1761bed9477fa7493d16abcc7bd8f96c7f1695168283440468434e1421866d6a438a5d42fabababf3e7cf9f5f3175ead41323478e6c1e3870a03ef4292f2fefa7c71f7ffcdcb871e3f63efffcf30b8df63ff9c41833d01833d01768f405200d381c8efb8c566ab473014eeb19ac95198fcfe3d3a3d0506880b473972dba9932d13e1e090a68962c59b260f2e4c9cd858585eaf5d75f57ebd6ad53b5b5b5aaa9a94909f95a5f5faf366edca8e6cf9faf0a0a0a7e2a2a2ada3764c890c17c828c19688c19e80b34fa029082faf5ebf73b87c3b1328a702650ab7ae8a1876ee2d3a4d0506880b40a697ac7f0bc538435b129747a7cdba2c29965135a5c777a3e2d727aee08f4bc89133ff847e3fe93e6f52267d964f9ba6eddba41cf3df7dcd9279f7c5287303f9c68545316ac55a36797abe6f31754289b376f5663c78e3d9f9f9fbf43eab7f99ad1983871e22f8cf77596df2c6306c60ca02fd01700b421bbddde2f2727e7076be8929b9babfefad7bf2a8fc7a3fefef7bfab93274fea41dd993367f47fe856af5eada64d9ba61e79e411ffb0e614b36b2834141a2063439ab67a7ed60735435e2ff955e14cf776f37ad134d77f2b74baab237d9df1f3369c5cb66c9967e8d0a1aaa4a4449d3f7f5ed7e9ca2d07d44715bbd4850b3fa948ad5cb9520d1a34a8f189d9654dd1fe3c05d35db7183fc397fc6619333066007d81be00a0ed429ade0e87e3bc35a059b870a19e1e1d8963c78ee9c7cbf3ac818df19a593f959a4243a1015254b8858313fd3a5919d414ce708f2e70968d31af1738dd2f15cdf40cd3f7cdf48c376e3f2e33550a66785ed1f7cf2cb31bd7e79baf61b65dbb76f96ab2f5f6e1230b554ec18b6ac42babd463cf7da8fec71fee501d3b76548fe53fae9e9aed511f787628e7871b033e37d87bb8f8becbc619b7351aed48c14cf7438533cbee33be2e92fb46cdaeb8a1c8e9f9aad0e976f83f8edf3c6306c60ca02fd017004416d2f4b38634a3468dd2b3676221cf9369d77e614d56cfaca1d0506880140e69daeab02566d6c410d44c9c58d65e66cfe85935c675efd7fd727893f938b9adc8e9fe37093b2e06249ea7e55029b9bc75d7812f0b5f28bee49f2a8b162d528f4d5aa46efd3f77a8b12fbdabdef9a842353636aafd7527d4336f7ea1366cd8a026bff2a67aecd985aa4bb7dbf4e34d878f9e562f2f5aa7860c19e29b19ebff1ebcefbfb160baebda114e572709618cf7354a0e992a9ce5fadfc6f5d2a2d96537057a1cbf79c60c8c19405fa02f000843d6a4b11eee3461c204dfe14db192c3a2a64c99e27f1854470a0d8d4203a404ff8580ffc16803bc5fa3e1ff3c16188e32a89199333263c57abdc0e99922d78b667886e800c4e9a99530c778dcebdec7cd975935b226cdf00973d4aa2fb6f8eaaf2c149c9797a7baddf62fead9375dfab6275ffd798d9ab33f9e574fbd56a12f7fbe7e9f3e3c4ab6899d3b77d6f55a9ebfb472b7dabab741eddbb74f3d3ee6f93363e6acfedeff3de8f731d3739b71fbabf25e7e7e5fee4512d2b49879e3f738306660cc00fa027d0140183939392eeb4c9ad68634d6b0c66f664d15858646a1015226a4e96d095bde329af27e8d34ac09f63cc29a28821aa36d1be15cfe9f2cd7bf7d6296fb46eff51f47382baff1ce44a9299c56d6c57bfb4aa3ccfecba44993ce8d7dd5d522a4e9ddbbb7baebaebbd44765df28cfc6fdfaf6b1732af54c1a59aba6fcebbfabf7dd3bf4edef7cb6556daff95e5f3e75ea94efb9cfbeb3daf79aa3667ad4e8b1e3bf0af01e4e8e9ae5baf9df67b9feb36fa68fb36c7981d333f2e22c21cffe61b3cb7e1de87160ccc09801f405fa028010e414dcd63569623ddc29d46150d6356bb2f510280a0d850648d190460cf0862d2a8ab0c61ad298adbfe57ed6ac8930a83167cf98d78b9c651f58aecf92b0a6d059f689041ee6e15072598e6e7af2c9a7d45fe67ea116aefa46d75c994923418b842ecfbffba5fae1e4c5d3716ff9ae5e4d786bb53efbd3a4d73ed1b36ac478e3b9d6b341353737ab3e7dfe9f1af9d2a7bed7fcb07ca72a9ce15293e6add9d4f23d94e57a67fb34caa158e6fb2a7ac57dbd5c9643a00a9ceee1811e07c60c8c19405fa02f00081dd4949a218a2c041c0f72dc7bb6cfaaa1d050688014102c3c0914ba840a6b023d7e6e80c7b3664d9c18a5f59793274f6e9653705b6bad2c10dcd0d010b41e575454e85abc66cd9aa08f9190470e83b2ae59b365cb9673b9b9b96bf9e419333066007d81be0020ce8c41d76fcc058465d6cbd1a347e312d4c8d9a0fc4eddfdbb60efc9b8afabdd6e5f4aa1a125b3d064eadf2108696cc10f478a34ac8934a4f10f6ba23a0c8a3e185a757575fe8811237ca7e196993037dd74935ab16245d05a7cf6ec59f5f8e38fab9c9c1c357cf870f5e38f3f067dac6c23e5f5e4754d83060daa0b55bff9bd316660cc00fa02410d8036601495e16678f2c20b2fa8789a366d9a35a8191da8c819adc468cdf2180a0d2d198526d3ff0e91b5220d4bc28535d18634d6efdf608b60660d7d3032f3e7cfaf983b776e8b60a54b972e21eb707171b1fea78cccc291af4b972e0df9f8eeddbbb7087e8c3abe3950fde6f7969831c3faf5ebd5edb7dfae2ebffc7275c51557a8db6ebb4dad5ebd5adf67f6c778d4cb60af2db3b37af4e81197d78ea6f9bf8f585e33dccfc29881f1338da0064828a3a8149be1497979795c831a194c58829a926045ce6c141a5a220b4db6fc1d22ab439a480f3f0a16d6fc22c690c61472cd1afa6074a64e9d7a62ddba75be1a2b3364264f9e1cb406cb8cd9010306a8f9f3e7ebebf275e0c0817ac66b302fbef8a21a3c78b0effa9a356bf659eb37bfb7c48e196ebef966ddefaaababd5a64d9bf4e51b6eb821eef53258f0d116214b3c5e2396d70cf71cc60c8c9f69043540a2839add667169eb4584fdd5d6d65a839a0376bbbdbb4c13f52f720435b444169a6cfb3b04214d2bc29a9dad086982be1ffa606c468e1cd97cf8f0615f8deddab5abaaaaaa0a5a8367cf9ead4397d3a74febeb7ffddb5af5d8b0423567ce9ca0cf79eba3d57acd9bf3e72fa831732a545d5d5dbdd46f7e6fc91933c82c1ae97bdf7efb6dc8a061cf9e3daa5bb76eeab2cb2e530f3ffc708bfbcccba3478f561d3a7450d75c738d7ae38d377cb34a3a75eaa49f77edb5d7aa79f3e6050d3164568f757b10eaf9cb962dd36b1ec9edf233c8cc15798ffeaf2d33bbe5f2b871e3c23e2fd4fb302f0f1b364cdf2fef65c1820541df63a0d760ccc0f899465003243ba839651697b63a2577a853755b8ad98560458ea0869688e65de0ba24dbfe0e91555a7bd6a540614d6b429a1661cd6f7ffbdb11f4c1d8c96c183915b7a97dfbf62dae5bc9ceadc3e1502b57aed4d77ffae927f5e4abe56af9f2e5faf67dfbf6057c9e843336bd6ef1cfa7fe367e27e7f8bd2567cc60061912b0480821336b02053577df7db7be2c87b6c9e16e81420cb96fdbb66dfaf2d5575fadef9300430eaf3a70e080befdaaabae8a6a464db0e7cb57b95e5353a3ef97cb1224595f430243f93a68d020dfeb857a5e24336a24e891504b2e4b2015cbcf68dd39e5ef9ef1338da006486450e32b2e8910aab8654363039f3a2ddbff1669d9d18ccdfcb456960939dcc97f26cd4eefedad21ef4bdd7ffffdfc9e5ad144f59e063565c15a3564ca47ea932fbed3a7db2edd703178397eeaac7ae6cd2fd4532fbeab0a6794aaf2aff7ebdb0fd69f52338a37ea85880b473da1c6bcf49e3e6db79cbe7b5bcdf7fa31729a70b36dda7544bdfbf976ea780a8c19e4307209e924ac913e24e18d7fd060ce1091604d5aa0a0c61a6ab46bd74e5f964064cc98313a0c09f59c600149b0e7cb5a3a725966b1dc73cf3d7a76979c99ccfa1a669b316386eff5423d2f9a439f5af333fa053534c6cf0435043540c6cfa8697af8e187ef32beae65460d2d998526dbfe0e9195336a7ac5f8fc50336ade6aed8c1af37dd1072f5534c3fdb722a7fbdf0aa7555e57e8f49c94db0a677a9c054ecfc8891327fea260baabdbc89797eb9d70cfc6fd6afeca6dea0f77fc49cd5f5eadd66cad551f55ecbab8a68c71f9aff32a94236f8072576d504fbd56a16fb7062faf7d50a51e1b3b437df9e57a557fec8c9af8f66a7dfbe1a3a7d58ce2aff4ef5b829f955fd6a8c6c6c6bafc71b3cfcbfb70381cffeac8ebbf35d8efad6086e715ba60fcc60ce68c1009655a1bd498d7e53037b95c525212535013ecf9f21ee4e7193972a45e53476e97f576acaf216b2cc9e14d72a893f97aa19e176d5013ebcfc89881f1338da00648565093b4356accf7600cf67a19d7abb235a809751687d69ca140fecbf6fbdfff5eff27eaca2bafd4a763b51edb2dd38ccdfbe514ace631eafeffe15abb76adbe4dbeda821c076e0e166fb9e516fdf3841bf404daf10b767ba8fbfc6f979f530674120a465b68b2e5ef105947429153b6f8ac51134b581374cd1cfae0cf0a9d9ed3016e6b9cf84ed92fe5f2b0d965bf961932b2468d042e5bbeab578e91cfabf74b2ad462cfb76ae3ce3a5d77dff864b32a18fb9c9a32658aba70e12735764ea5be5d829cd55b0feacb12de5867cfc8cc1ab1b472b75afaf95abd632bdf43c29d43870eed2c9851fa93f57d3cfeecbca640bfb782996576ba5fdb8e19cc9041eaec575f7d1530f090cb7dfbf6f51ddeb478f1e288831a33e031172a0e176298b37a4e9c38a1439560cfbff5d65b7de309e36f485fbefefaeb2f79edbcbc3c7db9acac2cecf342bd8f587e46ffd760cc907e414d3cc6d381c69e9b376fd65ffff8c73ffa1e2767dc93595be67d81c6abe1c6e6a1fe6e23191f473abe97f729416fac0b6f13d400890b6a927ed62793f7bf1455d916d4c47a1687501b57991e2cf7fdebbffeab1e70c871da725d8214b9ffbdf7ded3d76561490935f2f3f3f57519d0f91784975e7aa9c5b1f1c18a830cacacdf2392a0269a9fcd16c17ff4a64f9fee5b2431d64293e97f87c8dab0269a9935c14ec11de8ac4fd1843511ad99431fbc18d48c9a5d7143c1acb2dec6e52fbdb71d979934132796b52f74ba0b9f717ea4cffa34e7e3cd6a4fed3155f0d7f7d484bfce506f7cb245ed3ef0835e87a6c8e9568f164d52fbf7ef572bd6ed551f57edbeb848f0675bd576ef214ee3deac529bbfd9add7aa915906a649f3d6f8cefa647e8f55ab562d2f9c5eda6c7d1f467b53de5ffe5fe66e70e4f5df62fede46cd70fd5fba5edb8e196427d0dc11959d2dd91135ff9962ad8572788fb9e328bf3f9bf7f0a1703b83327690d796756222096ade7efb6dbdbe8d7c9f850b17067dbefcfdfde94f7fd23bcff23ee4b023d939f67fedcf3efb4c5f960590c33d2fd4fb88e567f47f0dc60ce917d4c4633c1dec3ef9a7a0dc2e8b519be3e3a79f7e3ae473c28dcd6d119cbd2cdc6d918eef031d32495003a418bbdd3edc2c2ed269e369dab469d6a06674b0f7e4fd2fc5da6c2934a1cee220c762f7efdfdff7df81071e78401d3c7830ec190a648066f3fe372dd0f734ff4b65a6f832a893eb72bb75c32dffbdbbf7de7bf56df25516e1b385f9cf5cb0c16022829a53a74e455c98c3159a4cfd3b44d68735e166d6040b69fe21c4fd9184355d8dd6608b62664f36f7c1a299eea1854ecfd9c299eeed239cae4edea0e67ea3d5eadb9d9eb7767e57337feedcb97ac15f392bd3e8591ef5c73ffe2f3d6b46ae7ffded41356cc2eb6aecac957a96cc87e53bf5ede23f5eaf54cddecb5fef3ea2d7b5915067c4ffb748edaca9d3b36f64bd9abca297d58a152b7cdf63c284099fcd595c3edffa3e64568df7fd9d9c38f1837f94dfdb238f8d6c96cb74bbf8ef9c066af29ffaa953a7ea1d35a9f3d69d415a7c0ef760cc90fcbe108ff174b0dbe5f5e4ac61d2a4bf49482463d050cf0937366f8ba026d2f17dcf9e3d096a8054979b9bfb1b73057be3b23a7af4685c429a63c78ec994d69f2c41cdef2834e1cfe2200b06dabc5374cde994723687701b57094b6cde29bc81ee370b93ff865e8a57a0535bca604f5e53aedbc2cca8914214eba14f9114225b98299fd6b0884203b4106e464bb890c6166358631e7e751fbf82b6f3cc33cffcf7e1c3875f900581457373b39ee62ec18a98fcea52f558e1785d0722add303060c506fbdf596be2edb48793d795df3a44f3939397bb2b17ea75b50233b8212cc580f013167ded058972353fb423cc6d3a1c6ab329bc6bccded76877d4eb8b1795b0435918eef654d28ffc3ffe80b400a72381ca5668022d33de3c17b2a64b3555168223b8b837fd26f0bb270a07f93a9bb729f046fa1829c701b72f3b49e13264cf0fd17c016e49859f99e32e3a6aaaa2a69336a086a80b082cdac8934a48936ac31bf1f214d1c8c1a35eabb8d1b37b6a8b5321372cb962d6af8d40fd5b393a7e86d5da44db6f5b266c2ce9d3bf5a2aef27aa655ab562dccd6fa9d6e410d8da0265bfb425b8fa743ddb760c102dffde6ba4aa19e136e6c6ede1fe86c65918e8f231ddfcb7a3e46fd20a801d220a8b9cf0c5164564d5b2f2a2caf670cfc7cb3698cef9747a189ec2c0ed6333744533ce43f69b610d32bcdd3526edbb64d5fdfbe7dbbbe2eb75b5f5b66d2489190c5fb64e32fd76d119e25c196c4439f2430a2d00041c9cc1affc390064411d2840a6bfafb7d9f480eb7428c1e7df4d1879e78e2896673568d9005595b7bdaf3071f7cd077fa6f73c28d51c737656bfd26a8a1316648afbed056e3e960f7d5d5d5a96baeb946371927cbecc370873e851b9b9b876e050a58221d1f473abe97cbb28032410d90068c0159996f01c051a3daec54ddb2636f0c22cf5b67d3f4ecd9b33d8526b2b338c87f36e5baacd86e4e51948504c39da140567c97fb645d19b96fc99225faba1412eb6263b2989e5c3717d593db836dc8031dcf9a6a418d7c4e7279dcb871141a207c58635d60d81aba4412d2d8c23c2fda058c11a3fcfcfc6aeb22c0b2cdefddbbb7baebaebbf4e14cd1901d0df3b9f23aa6175f7c716e36d7ef4c0b6a62d9398be6ac93e9de027d3e8c1952bf2fc4633c1dacaf141616fa5ecf9c751e6e31e17063f37beeb9475f979f5766a7cb65ff7e668b7031e148c6f7cf3efb2c410d902641cdef8cd660062ab2d1696d582321cd942953acebd29c72381c1d2934919fc541127b99c22989badc2fc7d3ca591022394381140f592f4666c2c8f365636f3d465dee97e2201b68398d5fa0d3735b37e4727ad758821a5b14a7da6ecd1a3536efe9b9a57852688088f81f0625214b7f5bf4a7dcf67f5e2f429ac4d66f6330deb86bd7ae16618dccac911d1773cd9a70649b28873b49bdb68634d5d5d5cb8cdb0e6773fdceb4a026d9410f410de2d117e2319eb645707a6ed95eca6c99484ecf1d6a6c2eef47ce0865be7ff907a9b9287034ffc88c747cbf7bf76e821a205dd8edf67ee6c2c2e6cc9a580f8392e7f9cda451d93e659a69cc4c6306d220ac69ad40875521cef2f2f272f3f3f3cfd4d7d75fb23e9c0cd865c760f2e4c9fabfb46608238b046fd8b0419f82bb7bf7eefa71d63569c4c18307bfc8c9c9d9cf214fc91f33983b54e6cea6ec189a67b731ef939d3ef310075907434ecd6bee980e1d3ad4b788a975e72cd8d970cc1d47d959949d4a09fd648732dc597264b68d1c7e2ccf9133e2c882ab91beffd6fe6ce66c020929e571f273c975d9f90ef573caf7923e22b7fb9fb69b3103e3671ae3672025f4ebd76fa035ac91356ba4c0453a7d5a1e27033deb9a34d2ec76fb580a0d85864203647458d3d6a10fa260d4eb4143860c39659d59630632b2bd93b37c74edda55b56fdfdeb7232ae1cce0c183f5ac1bcbd99d7c336924a4a17ea7565023874b2c5bb64c5fbef3ce3b5bdc27679e3974e890be4d820c9bf79007f3c4001268f80735a1ce86631e8a21018dcd728a6f5b88ffc24b4823879e986b845c75d55511bfffd6fe6c72bf5cbef1c61bf5e36436815c97f712eae79430cae65d3bc4fcfe04358c9f698c9f819423336b8c76cc1ab44860232ba7979797ebd932e661517278536d6dad5e65dde974caa93d2ff82d4a784ac21f3e550a0d85064869ad3d5c89c39d52a47ee7e5e59df8f8e38f4f5b17188ed2b1975f7ef91d39dc89fa9d7a418dcc8892660b70d61aebfa1ad6c553833d3edcd970029dea375c50535353a3c68c19e35bd4d4e6779872b8f7dfda9f4d0edfb379cfc263b39c5c20929fd3fa7a04358c9f698c9f819424c7bc5b4fdb1d63abe298760a0d850648bbb026da19312c1c9c62f53b2727c79d9f9f5fb769d3a6c628029aa6cf3fff7c515e5ede06ea777a0435fea7dc0d740619ebe365d1d460414da0b3e1c412d4980bbaca02d7e1821afff7df163fdbb061c3f4f5be7dfbeaaf32fb26d29f93a086f1338df133904e03be07bd814d7334018dfc178eb3435068283440da89f6f0250e774ae1fa2d81cdc08103eba74e9dfacd175f7cb1bfb6b6f6b0b9464d636363dda1438776ba5cae4f274e9cb8223737772ff53bf5839a050b16f84210397b4cb030c33cd4c77a78908418fe8f0f75361cf3d02799356db31cfa14ea2c3966e861be967f5013eafdb7c5cf665e973572e4ebe2c58bc3fe9c720894cd7be893f97c821ac6cf34c6cf405a300670bf71381c85c600aed86835466bf28632f2f580d14a8c365afe93c7a745a1a1d0005911d67435da29a3ddc74746fd4662821a598b45ce08238716c96146c1c20c597057d61f92e0449a0419d6c584e535c29d0d475effd65b6fd5a1871c52246bcf843b4bceecd9b3f5ebf82fca1bc9fb6f8b9f4dbeca6b983fa32c221ceee79433eb4808253fa7bc2e410de3671ae36700141a1a85064845bdbc214caf10f73710d200890d6a5a5bfb646d41799debaebb2e654ee96d4b83d37d336660fc4ca32f00a0d0d02834402a0836b386c39d80048f19ccd923adad7d7236a52bafbcd2774850a25aa8f7df563f1b6306c6cf34fa020050682834403686358434006306c60ca02fd01700804243a3d0002910d64c23a40118333066007d81be0000141a1a8506483e599346d9380537c098813103e80bf40500a0d0d02834404af8273e028031036306d017e80b0040a1a1516800008c19688c19e80b34fa0200506828340000306660ccc09881be40a32f00a0d0d028340000c60c34c60cf405fe06e90b0040a1a1d00000c09881c69881be40a32f00a0d0d028340000306660cc00fa027d01002834141a00001833d01833d01768f40500141a1a85060000c60c8c19405fa02f000085864243a101003066a03166a02fd0e80b002834340a0d00008c19183380be405f00000a0d8d42030060cc4063cc405fa0d11700804243a101008031036306d017e80b0040a1a1516800008c19688c19e80b34fa0200506828340000306660cc00fa027d01002834340a0d008031038d31037d81465f00000a0d85060000c60c8c19405fa02f0040ea73bbdd6ce053a7351985a699bf4a000063061a6306fa028dbe00204b5556561eaeafaf67239f02adb6b6f67da3d0ece0af1200c09881c69881be40a32f00c8521e8fa76f7979f9f123478e34b2b14fde7f02a4c8b85caefd467b90bf4a000063061a6306fa028dbe00208b191bb7dea5a5a51b64daa01ce3494b7893cf7d07450600c09881c69881be40a32f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002cfe7fb0af81d1e95461f70000000049454e44ae426082', true);
INSERT INTO act_ge_bytearray VALUES ('2534', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2521', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5034', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2559', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2569', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2585', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2592', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2609', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2602', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5021', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('2', 3, 'source', NULL, '\x7b227265736f757263654964223a2231222c2270726f70657274696573223a7b2270726f636573735f6964223a227461736b2d7766222c226e616d65223a22d098d181d0bfd0bed0bbd0bdd0b5d0bdd0b8d0b520d0b7d0b0d0b4d0b0d187222c22646f63756d656e746174696f6e223a22222c2270726f636573735f617574686f72223a22222c2270726f636573735f76657273696f6e223a22222c2270726f636573735f6e616d657370616365223a22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566222c22657865637574696f6e6c697374656e657273223a22222c226576656e746c697374656e657273223a227b5c226576656e744c697374656e6572735c223a5c225b7b5c5c5c22636c6173734e616d655c5c5c223a205c5c5c22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e65725c5c5c222c205c5c5c22696d706c656d656e746174696f6e5c5c5c223a205c5c5c22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e65725c5c5c222c205c5c5c226576656e745c5c5c223a205c5c5c225441534b5f435245415445442c205441534b5f41535349474e45442c2050524f434553535f434f4d504c455445442c2054494d45525f46495245442c2041435449564954595f43414e43454c4c45445c5c5c222c205c5c5c226576656e74735c5c5c223a205b7b5c5c5c226576656e745c5c5c223a205c5c5c225441534b5f435245415445445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c225441534b5f41535349474e45445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2250524f434553535f434f4d504c455445445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2254494d45525f46495245445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2241435449564954595f43414e43454c4c45445c5c5c227d5d7d5d5c227d222c227369676e616c646566696e6974696f6e73223a225c225b7b5c5c5c2269645c5c5c223a205c5c5c2270726f6a656374417070726f7665645c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c2270726f6a656374417070726f7665645c5c5c222c205c5c5c2273636f70655c5c5c223a205c5c5c22676c6f62616c5c5c5c227d5d5c22222c226d657373616765646566696e6974696f6e73223a22222c2270726f63726f6c6573223a225c225b7b5c5c5c22636f64655c5c5c223a205c5c5c226578656375746f725c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c226578656375746f725c5c5c227d2c207b5c5c5c22636f64655c5c5c223a205c5c5c226d616e616765725c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c226d616e616765725c5c5c227d5d5c22222c226c6f63616c697a6174696f6e223a225c225b7b5c5c5c226b65795c5c5c223a205c5c5c22657374696d6174696f6e5c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d09ed186d0b5d0bdd0bad0b05c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c22657374696d6174696f6e2e657374696d617465645c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d09ed186d0b5d0bdd0b5d0bdd0b05c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c22706c616e6e696e6742794d616e616765725c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d09fd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c22706c616e6e696e6742794d616e616765722e706c616e5c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d097d0b0d0bfd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d182d18c5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c22776f726b4f6e5461736b5c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d0a0d0b0d0b1d0bed182d0b020d0bdd0b0d0b420d0b7d0b0d0b4d0b0d187d0b5d0b95c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c22776f726b4f6e5461736b2e636f6d706c657465645c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d097d0b0d0b2d0b5d180d188d0b5d0bdd0b05c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d5d5c22227d2c227374656e63696c223a7b226964223a2242504d4e4469616772616d227d2c226368696c64536861706573223a5b7b227265736f757263654964223a227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22222c22696e69746961746f72223a22222c227374617274666f726d223a22227d2c227374656e63696c223a7b226964223a2253746172744e6f6e654576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a36392e3132352c2279223a3131357d2c2275707065724c656674223a7b2278223a33392e3132352c2279223a38357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3134392e37393639303236333830353230372c2279223a3130302e37313133313532363132343934357d2c2275707065724c656674223a7b2278223a36392e38333539303938363139343739332c2279223a3130302e31313638303937333837353035357d7d2c22646f636b657273223a5b7b2278223a31352c2279223a31357d2c7b2278223a33382e3632352c2279223a34317d5d2c22746172676574223a7b227265736f757263654964223a227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544227d7d2c7b227265736f757263654964223a227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420455354494d4154494f4e5c6e222c22736572766963657461736b726573756c747661726961626c65223a22222c227461736b73746174652d7461736b6964223a22656e746974794964222c227461736b73746174652d656e756d76616c7565223a22455354494d4154494f4e222c227461736b73746174652d656e746974796964223a22656e746974794964227d2c227374656e63696c223a7b226964223a227461736b5374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3235302c2279223a3134307d2c2275707065724c656674223a7b2278223a3135302c2279223a36307d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a227570646174655461736b5374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d7461736b69647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420455354494d41544544222c22736572766963657461736b726573756c747661726961626c65223a22222c227461736b73746174652d7461736b6964223a22656e746974794964222c227461736b73746174652d656e756d76616c7565223a22455354494d41544544222c227461736b73746174652d656e746974796964223a22656e746974794964227d2c227374656e63696c223a7b226964223a227461736b5374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3634302c2279223a3134307d2c2275707065724c656674223a7b2278223a3534302c2279223a36307d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a227570646174655461736b5374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d7461736b69647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d39423433313643462d443444412d344636392d393331432d394531363432464532384442222c2270726f70657274696573223a7b226f766572726964656964223a22657374696d6174696f6e222c226e616d65223a22457374696d6174696f6e222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22757365727461736b61737369676e6d656e74223a22222c2264756564617465646566696e6974696f6e223a22222c227072696f72697479646566696e6974696f6e223a22222c227461736b6c697374656e657273223a22222c227461736b6f7574636f6d6573223a5b7b226e616d65223a22657374696d61746564222c22666f726d223a7b226e616d65223a227374616e6461726450726f63466f726d222c2263617074696f6e223a225374616e6461726420666f726d222c22706172616d73223a5b5d7d7d5d2c227461736b70726f63726f6c65223a226578656375746f72222c22636c61696d616c6c6f776564223a2266616c7365227d2c227374656e63696c223a7b226964223a22557365725461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3433302c2279223a3134307d2c2275707065724c656674223a7b2278223a3333302c2279223a36307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d39423433313643462d443444412d344636392d393331432d394531363432464532384442227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3332392e37383132352c2279223a3130307d2c2275707065724c656674223a7b2278223a3235302e32313837352c2279223a3130307d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d39423433313643462d443444412d344636392d393331432d394531363432464532384442227d7d2c7b227265736f757263654964223a227369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3533392e37383132352c2279223a3130307d2c2275707065724c656674223a7b2278223a3433302e32313837352c2279223a3130307d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436227d7d2c7b227265736f757263654964223a227369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3733342e353437323630353739333437332c2279223a39382e36303530343534333237353936357d2c2275707065724c656674223a7b2278223a3634302e323138333634343230363532372c2279223a39352e39383437393833313732343033357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a33352c2279223a33357d5d2c22746172676574223a7b227265736f757263654964223a227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434227d7d2c7b227265736f757263654964223a227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225369676e616c205461736b20457374696d61746564222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a66616c73652c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22736572766963657461736b636c617373223a22222c22736572766963657461736b65787072657373696f6e223a22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b457374696d6174656427297d222c22736572766963657461736b64656c656761746565787072657373696f6e223a22222c22736572766963657461736b6669656c6473223a22222c22736572766963657461736b726573756c747661726961626c65223a22227d2c227374656e63696c223a7b226964223a22536572766963655461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3833352c2279223a3134307d2c2275707065724c656674223a7b2278223a3733352c2279223a36307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225761697420666f722070726f6a65637420617070726f76616c222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22222c227369676e616c726566223a2270726f6a656374417070726f766564227d2c227374656e63696c223a7b226964223a2243617463685369676e616c4576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3937352c2279223a3131357d2c2275707065724c656674223a7b2278223a3934352c2279223a38357d7d2c22646f636b657273223a5b7b2278223a3936302c2279223a3130307d5d7d2c7b227265736f757263654964223a227369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3934342e36343435333132352c2279223a3130307d2c2275707065724c656674223a7b2278223a3833352e32313837352c2279223a3130307d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a31352c2279223a31357d5d2c22746172676574223a7b227265736f757263654964223a227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032227d7d2c7b227265736f757263654964223a227369642d31453943394645452d343946342d343032462d393243342d353144334231374541463531222c2270726f70657274696573223a7b226f766572726964656964223a22706c616e6e696e6742794d616e61676572222c226e616d65223a22506c616e6e696e67206279206d616e61676572222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22757365727461736b61737369676e6d656e74223a22222c2264756564617465646566696e6974696f6e223a22222c227072696f72697479646566696e6974696f6e223a22222c227461736b6c697374656e657273223a22222c227461736b6f7574636f6d6573223a5b7b226e616d65223a22706c616e222c22666f726d223a7b226e616d65223a227374616e6461726450726f63466f726d222c2263617074696f6e223a225374616e6461726420666f726d222c22706172616d73223a5b5d7d7d5d2c227461736b70726f63726f6c65223a226d616e61676572222c22636c61696d616c6c6f776564223a2266616c7365227d2c227374656e63696c223a7b226964223a22557365725461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313031302c2279223a3237357d2c2275707065724c656674223a7b2278223a3931302c2279223a3139357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d31453943394645452d343946342d343032462d393243342d353144334231374541463531227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3936302c2279223a3139342e393736353632357d2c2275707065724c656674223a7b2278223a3936302c2279223a3131352e3736353632357d7d2c22646f636b657273223a5b7b2278223a31352c2279223a31357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d31453943394645452d343946342d343032462d393243342d353144334231374541463531227d7d2c7b227265736f757263654964223a227369642d33364231324439332d354444312d343138382d384237332d354134434630374446334232222c2270726f70657274696573223a7b226f766572726964656964223a22776f726b4f6e5461736b222c226e616d65223a22576f726b206f6e207461736b222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22757365727461736b61737369676e6d656e74223a22222c2264756564617465646566696e6974696f6e223a22222c227072696f72697479646566696e6974696f6e223a22222c227461736b6c697374656e657273223a22222c227461736b6f7574636f6d6573223a5b7b226e616d65223a22636f6d706c65746564222c22666f726d223a7b226e616d65223a227374616e6461726450726f63466f726d222c2263617074696f6e223a225374616e6461726420666f726d222c22706172616d73223a5b5d7d7d5d2c227461736b70726f63726f6c65223a226578656375746f72222c22636c61696d616c6c6f776564223a2266616c7365227d2c227374656e63696c223a7b226964223a22557365725461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3632352c2279223a3237357d2c2275707065724c656674223a7b2278223a3532352c2279223a3139357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225369676e616c205461736b20436f6d706c65746564222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a66616c73652c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22736572766963657461736b636c617373223a22222c22736572766963657461736b65787072657373696f6e223a22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b436f6d706c6574656427297d222c22736572766963657461736b64656c656761746565787072657373696f6e223a22222c22736572766963657461736b6669656c6473223a22222c22736572766963657461736b726573756c747661726961626c65223a22227d2c227374656e63696c223a7b226964223a22536572766963655461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3232302c2279223a3237357d2c2275707065724c656674223a7b2278223a3132302c2279223a3139357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420494e5f574f524b222c22736572766963657461736b726573756c747661726961626c65223a22222c227461736b73746174652d7461736b6964223a22656e746974794964222c227461736b73746174652d656e756d76616c7565223a22494e5f574f524b222c227461736b73746174652d656e746974796964223a22656e746974794964227d2c227374656e63696c223a7b226964223a227461736b5374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3833352c2279223a3237357d2c2275707065724c656674223a7b2278223a3733352c2279223a3139357d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a227570646174655461736b5374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d7461736b69647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3930392e37383132352c2279223a3233357d2c2275707065724c656674223a7b2278223a3833352e32313837352c2279223a3233357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237227d7d2c7b227265736f757263654964223a227369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d33364231324439332d354444312d343138382d384237332d354134434630374446334232227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3733342e37383132352c2279223a3233357d2c2275707065724c656674223a7b2278223a3632352e32313837352c2279223a3233357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d33364231324439332d354444312d343138382d384237332d354134434630374446334232227d7d2c7b227265736f757263654964223a227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420434f4d504c45544544222c22736572766963657461736b726573756c747661726961626c65223a22222c227461736b73746174652d7461736b6964223a22656e746974794964222c227461736b73746174652d656e756d76616c7565223a22434f4d504c45544544222c227461736b73746174652d656e746974796964223a22656e746974794964227d2c227374656e63696c223a7b226964223a227461736b5374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3433302c2279223a3237357d2c2275707065724c656674223a7b2278223a3333302c2279223a3139357d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a227570646174655461736b5374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d7461736b69647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a227461736b73746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3532342e34383832383132352c2279223a3233357d2c2275707065724c656674223a7b2278223a3433302e35313137313837352c2279223a3233357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844227d7d2c7b227265736f757263654964223a227369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3332392e37383132352c2279223a3233357d2c2275707065724c656674223a7b2278223a3232302e32313837352c2279223a3233357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330227d7d2c7b227265736f757263654964223a227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22227d2c227374656e63696c223a7b226964223a22456e644e6f6e654576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a36382e3132352c2279223a3234397d2c2275707065724c656674223a7b2278223a34302e3132352c2279223a3232317d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3131392e323039393630393337352c2279223a3233357d2c2275707065724c656674223a7b2278223a36382e373034313031353632352c2279223a3233357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a31342c2279223a31347d5d2c22746172676574223a7b227265736f757263654964223a227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545227d7d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313230302c2279223a313035307d2c2275707065724c656674223a7b2278223a302c2279223a307d7d2c227374656e63696c736574223a7b2275726c223a227374656e63696c736574732f62706d6e322e302f62706d6e322e302e6a736f6e222c226e616d657370616365223a22687474703a2f2f62336d6e2e6f72672f7374656e63696c7365742f62706d6e322e3023227d2c227373657874656e73696f6e73223a5b5d7d', NULL);
INSERT INTO act_ge_bytearray VALUES ('5059', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5069', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5085', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('4', 3, 'source', NULL, '\x7b227265736f757263654964223a2233222c2270726f70657274696573223a7b2270726f636573735f6964223a2270726f6a6563742d7766222c226e616d65223a22d098d181d0bfd0bed0bbd0bdd0b5d0bdd0b8d0b520d0bfd180d0bed0b5d0bad182d0b0222c22646f63756d656e746174696f6e223a22222c2270726f636573735f617574686f72223a22222c2270726f636573735f76657273696f6e223a22222c2270726f636573735f6e616d657370616365223a22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566222c22657865637574696f6e6c697374656e657273223a22222c226576656e746c697374656e657273223a227b5c226576656e744c697374656e6572735c223a5c225b7b5c5c5c22636c6173734e616d655c5c5c223a205c5c5c22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e65725c5c5c222c205c5c5c22696d706c656d656e746174696f6e5c5c5c223a205c5c5c22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e65725c5c5c222c205c5c5c226576656e745c5c5c223a205c5c5c225441534b5f435245415445442c205441534b5f41535349474e45442c2050524f434553535f434f4d504c455445442c2054494d45525f46495245442c2041435449564954595f43414e43454c4c45445c5c5c222c205c5c5c226576656e74735c5c5c223a205b7b5c5c5c226576656e745c5c5c223a205c5c5c225441534b5f435245415445445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c225441534b5f41535349474e45445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2250524f434553535f434f4d504c455445445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2254494d45525f46495245445c5c5c227d2c207b5c5c5c226576656e745c5c5c223a205c5c5c2241435449564954595f43414e43454c4c45445c5c5c227d5d7d5d5c227d222c227369676e616c646566696e6974696f6e73223a225c225b7b5c5c5c2269645c5c5c223a205c5c5c227461736b457374696d617465645c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c227461736b457374696d617465645c5c5c222c205c5c5c2273636f70655c5c5c223a205c5c5c22676c6f62616c5c5c5c227d2c207b5c5c5c2269645c5c5c223a205c5c5c227461736b436f6d706c657465645c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c227461736b436f6d706c657465645c5c5c222c205c5c5c2273636f70655c5c5c223a205c5c5c22676c6f62616c5c5c5c227d5d5c22222c226d657373616765646566696e6974696f6e73223a22222c2270726f63726f6c6573223a225c225b7b5c5c5c22636f64655c5c5c223a205c5c5c226d616e616765725c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c226d616e616765725c5c5c227d2c207b5c5c5c22636f64655c5c5c223a205c5c5c2270726f6a6563744f6666696365456d706c6f7965655c5c5c222c205c5c5c226e616d655c5c5c223a205c5c5c2270726f6a6563744f6666696365456d706c6f7965655c5c5c227d5d5c22222c226c6f63616c697a6174696f6e223a225c225b7b5c5c5c226b65795c5c5c223a205c5c5c226d616e61676572417070726f76616c5c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c2270726f6a6563744f6666696365417070726f76616c5c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d0bfd180d0bed0b5d0bad182d0bdd18bd0bc20d0bed184d0b8d181d0bed0bc5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c226d616e61676572417070726f76616c2e617070726f76655c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d2c207b5c5c5c226b65795c5c5c223a205c5c5c2270726f6a6563744f6666696365417070726f76616c2e617070726f76655c5c5c222c205c5c5c2276616c75655c5c5c223a207b5c5c5c2272755c5c5c223a205c5c5c22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c5c5c5c222c205c5c5c22656e5c5c5c223a205c5c5c225c5c5c227d7d5d5c22227d2c227374656e63696c223a7b226964223a2242504d4e4469616772616d227d2c226368696c64536861706573223a5b7b227265736f757263654964223a227369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22222c22696e69746961746f72223a22222c227374617274666f726d223a22227d2c227374656e63696c223a7b226964223a2253746172744e6f6e654576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a33302c2279223a3131307d2c2275707065724c656674223a7b2278223a302c2279223a38307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225365742049444541222c22736572766963657461736b726573756c747661726961626c65223a22222c2270726f6a65637473746174652d656e746974796964223a22656e746974794964222c2270726f6a65637473746174652d656e756d76616c7565223a2249444541227d2c227374656e63696c223a7b226964223a2270726f6a6563745374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3230352c2279223a3133357d2c2275707065724c656674223a7b2278223a3130352c2279223a35357d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a2275706461746550726f6a6563745374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e7469747969647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3130342e37383132352c2279223a39357d2c2275707065724c656674223a7b2278223a33302e32313837352c2279223a39357d7d2c22646f636b657273223a5b7b2278223a31352c2279223a31357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331227d7d2c7b227265736f757263654964223a227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225761697420666f72207461736b7320657374696d6174696f6e5c6e222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22222c227369676e616c726566223a227461736b457374696d61746564227d2c227374656e63696c223a7b226964223a2243617463685369676e616c4576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3333302c2279223a3131307d2c2275707065724c656674223a7b2278223a3330302c2279223a38307d7d2c22646f636b657273223a5b7b2278223a3331352c2279223a39357d5d7d2c7b227265736f757263654964223a227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420455354494d41544544222c22736572766963657461736b726573756c747661726961626c65223a22222c2270726f6a65637473746174652d656e746974796964223a22656e746974794964222c2270726f6a65637473746174652d656e756d76616c7565223a22455354494d41544544227d2c227374656e63696c223a7b226964223a2270726f6a6563745374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3637302c2279223a3133357d2c2275707065724c656674223a7b2278223a3537302c2279223a35357d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a2275706461746550726f6a6563745374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e7469747969647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c2273657175656e6365666c6f776f72646572223a22227d2c227374656e63696c223a7b226964223a22506172616c6c656c47617465776179227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644227d2c7b227265736f757263654964223a227369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3736302c2279223a3131357d2c2275707065724c656674223a7b2278223a3732302c2279223a37357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3731392e373330343737333538353536312c2279223a39352e34313338313934303831323637387d2c2275707065724c656674223a7b2278223a3637302e383934353232363431343433392c2279223a39352e32313131383035393138373332327d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a32302e352c2279223a32302e357d5d2c22746172676574223a7b227265736f757263654964223a227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539227d7d2c7b227265736f757263654964223a227369642d44353544333542422d423436382d343335382d393436432d443131334643393330304139222c2270726f70657274696573223a7b226f766572726964656964223a226d616e61676572417070726f76616c222c226e616d65223a224d616e6167657220617070726f76616c222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22757365727461736b61737369676e6d656e74223a22222c2264756564617465646566696e6974696f6e223a22222c227072696f72697479646566696e6974696f6e223a22222c227461736b6c697374656e657273223a22222c227461736b6f7574636f6d6573223a5b7b226e616d65223a22617070726f7665222c22666f726d223a7b226e616d65223a227374616e6461726450726f63466f726d222c2263617074696f6e223a225374616e6461726420666f726d222c22706172616d73223a5b5d7d7d5d2c227461736b70726f63726f6c65223a226d616e61676572222c22636c61696d616c6c6f776564223a2266616c7365227d2c227374656e63696c223a7b226964223a22557365725461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3932352c2279223a39357d2c2275707065724c656674223a7b2278223a3832352c2279223a31357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d44353544333542422d423436382d343335382d393436432d443131334643393330304139227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3832342e36313332383132352c2279223a37342e32357d2c2275707065724c656674223a7b2278223a3734302e352c2279223a35357d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a3734302e352c2279223a35357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d44353544333542422d423436382d343335382d393436432d443131334643393330304139227d7d2c7b227265736f757263654964223a227369642d44464246354145452d384539302d343343312d413244442d383243353132393346453034222c2270726f70657274696573223a7b226f766572726964656964223a2270726f6a6563744f6666696365417070726f76616c222c226e616d65223a2250726f6a656374206f666669636520617070726f76616c222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22757365727461736b61737369676e6d656e74223a22222c2264756564617465646566696e6974696f6e223a22222c227072696f72697479646566696e6974696f6e223a22222c227461736b6c697374656e657273223a22222c227461736b6f7574636f6d6573223a5b7b226e616d65223a22617070726f7665222c22666f726d223a7b226e616d65223a227374616e6461726450726f63466f726d222c2263617074696f6e223a225374616e6461726420666f726d222c22706172616d73223a5b5d7d7d5d2c227461736b70726f63726f6c65223a2270726f6a6563744f6666696365456d706c6f796565222c22636c61696d616c6c6f776564223a747275657d2c227374656e63696c223a7b226964223a22557365725461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3932352c2279223a3230307d2c2275707065724c656674223a7b2278223a3832352c2279223a3132307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d44464246354145452d384539302d343343312d413244442d383243353132393346453034227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3832342e36313332383132352c2279223a3136307d2c2275707065724c656674223a7b2278223a3734302e352c2279223a3131352e363438343337357d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a3734302e352c2279223a3136307d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d44464246354145452d384539302d343343312d413244442d383243353132393346453034227d7d2c7b227265736f757263654964223a227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c2273657175656e6365666c6f776f72646572223a22227d2c227374656e63696c223a7b226964223a22506172616c6c656c47617465776179227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313030302c2279223a3133307d2c2275707065724c656674223a7b2278223a3936302c2279223a39307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3938302c2279223a39302e30393337357d2c2275707065724c656674223a7b2278223a3932352e32313837352c2279223a35357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a3938302c2279223a35357d2c7b2278223a32302c2279223a32307d5d2c22746172676574223a7b227265736f757263654964223a227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541227d7d2c7b227265736f757263654964223a227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420455845435554494f4e222c22736572766963657461736b726573756c747661726961626c65223a22222c2270726f6a65637473746174652d656e746974796964223a22656e746974794964222c2270726f6a65637473746174652d656e756d76616c7565223a22455845435554494f4e227d2c227374656e63696c223a7b226964223a2270726f6a6563745374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313132302c2279223a3332307d2c2275707065724c656674223a7b2278223a313032302c2279223a3234307d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a2275706461746550726f6a6563745374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e7469747969647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225761697420666f72207461736b7320636f6d706c6574696f6e222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22222c227369676e616c726566223a227461736b436f6d706c65746564227d2c227374656e63696c223a7b226964223a2243617463685369676e616c4576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3733352c2279223a3239357d2c2275707065724c656674223a7b2278223a3730352c2279223a3236357d7d2c22646f636b657273223a5b7b2278223a3732302c2279223a3238307d5d7d2c7b227265736f757263654964223a227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a2253657420434f4d504c45544544222c22736572766963657461736b726573756c747661726961626c65223a22222c2270726f6a65637473746174652d656e746974796964223a22656e746974794964222c2270726f6a65637473746174652d656e756d76616c7565223a22434f4d504c45544544227d2c227374656e63696c223a7b226964223a2270726f6a6563745374617465227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3430302c2279223a3332307d2c2275707065724c656674223a7b2278223a3330302c2279223a3234307d7d2c22646f636b657273223a5b5d2c22637573746f6d223a7b2274797065223a22736572766963655461736b222c226265616e4e616d65223a22706d5f50726f6a65637473222c226d6574686f644e616d65223a2275706461746550726f6a6563745374617465222c226d6574686f6441726773223a5b7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e7469747969647061636b616765222c2274797065223a226a6176612e7574696c2e55554944227d2c7b2270726f70657274795061636b6167654e616d65223a2270726f6a65637473746174652d656e756d76616c75657061636b616765222c2274797065223a226a6176612e6c616e672e537472696e67227d5d7d7d2c7b227265736f757263654964223a227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22657865637574696f6e6c697374656e657273223a22227d2c227374656e63696c223a7b226964223a22456e644e6f6e654576656e74227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3233382c2279223a3239347d2c2275707065724c656674223a7b2278223a3231302c2279223a3236367d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3239392e37383132352c2279223a3238307d2c2275707065724c656674223a7b2278223a3233382e37383132352c2279223a3238307d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a31342c2279223a31347d5d2c22746172676574223a7b227265736f757263654964223a227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436227d7d2c7b227265736f757263654964223a227369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3239392e3632352c2279223a39357d2c2275707065724c656674223a7b2278223a3230362c2279223a39357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a31352c2279223a31357d5d2c22746172676574223a7b227265736f757263654964223a227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532227d7d2c7b227265736f757263654964223a227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c2273657175656e6365666c6f776f72646572223a7b2273657175656e6365466c6f774f72646572223a5b227369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633222c227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541225d7d7d2c227374656e63696c223a7b226964223a224578636c757369766547617465776179227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541227d2c7b227265736f757263654964223a227369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3433302c2279223a3131357d2c2275707065724c656674223a7b2278223a3339302c2279223a37357d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3339302e313031353736323035343832392c2279223a39352e33393332303139363936363232317d2c2275707065724c656674223a7b2278223a3333302e393231383631323934353137312c2279223a39352e30383333363035333033333737397d7d2c22646f636b657273223a5b7b2278223a31352c2279223a31357d2c7b2278223a32302e352c2279223a32302e357d5d2c22746172676574223a7b227265736f757263654964223a227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144227d7d2c7b227265736f757263654964223a227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c2273657175656e6365666c6f776f72646572223a7b2273657175656e6365466c6f774f72646572223a5b227369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335222c227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746225d7d7d2c227374656e63696c223a7b226964223a224578636c757369766547617465776179227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335227d2c7b227265736f757263654964223a227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3632352c2279223a3330307d2c2275707065724c656674223a7b2278223a3538352c2279223a3236307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3730342e363837353039353334333838312c2279223a3238302e343133363031393739343037387d2c2275707065724c656674223a7b2278223a3632352e323835313436373135363131392c2279223a3238302e303636383636373730353932327d7d2c22646f636b657273223a5b7b2278223a31352c2279223a31357d2c7b2278223a32302e352c2279223a32302e357d5d2c22746172676574223a7b227265736f757263654964223a227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145227d7d2c7b227265736f757263654964223a227369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22416c6c207461736b7320636f6d706c657465645c6e222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027434f4d504c4554454427293d3d20747275657d222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a66616c73652c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3538342e353339303634343134383135362c2279223a3238302e343538393830353536353834387d2c2275707065724c656674223a7b2278223a3430302e393032333431383335313834342c2279223a3238302e303939363133313933343135327d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634227d7d2c7b227265736f757263654964223a227369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22416c6c207461736b7320657374696d61746564222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027455354494d4154454427293d3d20747275657d222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a66616c73652c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3536392e383938343430333438303030382c2279223a39352e34353236393134393639353232377d2c2275707065724c656674223a7b2278223a3433302e33323232363237373639393932352c2279223a39352e31313935373431323830343737337d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330227d7d2c7b227265736f757263654964223a227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a225369676e616c207461736b7320746861742070726f6a65637420617070726f766564222c22646f63756d656e746174696f6e223a22222c226173796e6368726f6e6f7573646566696e6974696f6e223a2266616c7365222c226578636c7573697665646566696e6974696f6e223a2266616c7365222c22657865637574696f6e6c697374656e657273223a22222c226d756c7469696e7374616e63655f74797065223a224e6f6e65222c226d756c7469696e7374616e63655f63617264696e616c697479223a22222c226d756c7469696e7374616e63655f636f6c6c656374696f6e223a226175746f5f6576616c756174696f6e222c226d756c7469696e7374616e63655f7661726961626c65223a22222c226d756c7469696e7374616e63655f636f6e646974696f6e223a22222c226973666f72636f6d70656e736174696f6e223a2266616c7365222c22736572766963657461736b636c617373223a22222c22736572766963657461736b65787072657373696f6e223a22247b706d5f50726f6a656374732e7369676e616c52656c617465645461736b7328656e7469747949642c202770726f6a656374417070726f76656427297d222c22736572766963657461736b64656c656761746565787072657373696f6e223a22222c22736572766963657461736b6669656c6473223a22222c22736572766963657461736b726573756c747661726961626c65223a22227d2c227374656e63696c223a7b226964223a22536572766963655461736b227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3932352c2279223a3332307d2c2275707065724c656674223a7b2278223a3832352c2279223a3234307d7d2c22646f636b657273223a5b5d7d2c7b227265736f757263654964223a227369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313031392e383834373739333731393239322c2279223a3238362e34353535303638373532393831377d2c2275707065724c656674223a7b2278223a3932352e303533363937313930353730382c2279223a3238322e32333139393331323437303138337d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a36352e3337352c2279223a34387d5d2c22746172676574223a7b227265736f757263654964223a227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439227d7d2c7b227265736f757263654964223a227369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22227d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3832342e333531353632352c2279223a3238307d2c2275707065724c656674223a7b2278223a3733352e35333132352c2279223a3238307d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a31352c2279223a31357d5d2c22746172676574223a7b227265736f757263654964223a227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133227d7d2c7b227265736f757263654964223a227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a747275652c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3431302e352c2279223a38342e39383238343338373239313631327d2c2275707065724c656674223a7b2278223a3332362e393537393830313236373036342c2279223a31357d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a3431302e352c2279223a31357d2c7b2278223a31352c2279223a31357d5d2c22746172676574223a7b227265736f757263654964223a227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532227d7d2c7b227265736f757263654964223a227369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3938302e352c2279223a3136307d2c2275707065724c656674223a7b2278223a3932352e3435333132352c2279223a3133302e303632357d7d2c22646f636b657273223a5b7b2278223a35302c2279223a34307d2c7b2278223a3938302e352c2279223a3136307d2c7b2278223a32302e352c2279223a32302e357d5d2c22746172676574223a7b227265736f757263654964223a227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541227d7d2c7b227265736f757263654964223a227369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a2266616c7365222c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313037302c2279223a3233392e323733343337357d2c2275707065724c656674223a7b2278223a313030302e33373839303632352c2279223a3131302e357d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a313037302c2279223a3131302e357d2c7b2278223a35302c2279223a34307d5d2c22746172676574223a7b227265736f757263654964223a227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237227d7d2c7b227265736f757263654964223a227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746222c2270726f70657274696573223a7b226f766572726964656964223a22222c226e616d65223a22222c22646f63756d656e746174696f6e223a22222c22636f6e646974696f6e73657175656e6365666c6f77223a22222c22657865637574696f6e6c697374656e657273223a22222c2264656661756c74666c6f77223a747275652c22666c6f776f7574636f6d65223a22222c2273686f776469616d6f6e646d61726b6572223a66616c73657d2c227374656e63696c223a7b226964223a2253657175656e6365466c6f77227d2c226368696c64536861706573223a5b5d2c226f7574676f696e67223a5b7b227265736f757263654964223a227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133227d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a3732302c2279223a3236342e393337357d2c2275707065724c656674223a7b2278223a3630352e352c2279223a3230357d7d2c22646f636b657273223a5b7b2278223a32302e352c2279223a32302e357d2c7b2278223a3630352e352c2279223a3230357d2c7b2278223a3732302c2279223a3230357d2c7b2278223a31352c2279223a31357d5d2c22746172676574223a7b227265736f757263654964223a227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133227d7d5d2c22626f756e6473223a7b226c6f7765725269676874223a7b2278223a313232302c2279223a313035307d2c2275707065724c656674223a7b2278223a302c2279223a307d7d2c227374656e63696c736574223a7b2275726c223a227374656e63696c736574732f62706d6e322e302f62706d6e322e302e6a736f6e222c226e616d657370616365223a22687474703a2f2f62336d6e2e6f72672f7374656e63696c7365742f62706d6e322e3023227d2c227373657874656e73696f6e73223a5b5d7d', NULL);
INSERT INTO act_ge_bytearray VALUES ('5092', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5102', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5138', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5151', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5186', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5176', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5202', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5109', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5209', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10024', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5226', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('7521', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5219', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('5242', 1, 'process.bpmn20.xml', '5241', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566223e0a20203c7369676e616c2069643d2270726f6a656374417070726f76656422206e616d653d2270726f6a656374417070726f766564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c70726f636573732069643d227461736b2d776622206e616d653d22d098d181d0bfd0bed0bbd0bdd0b5d0bdd0b8d0b520d0b7d0b0d0b4d0b0d1872220697345786563757461626c653d2274727565223e0a202020203c657874656e73696f6e456c656d656e74733e0a2020202020203c61637469766974693a6576656e744c697374656e6572206576656e74733d225441534b5f435245415445442c5441534b5f41535349474e45442c50524f434553535f434f4d504c455445442c54494d45525f46495245442c41435449564954595f43414e43454c4c45442220636c6173733d22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e6572223e3c2f61637469766974693a6576656e744c697374656e65723e0a2020202020203c637562613a70726f63526f6c657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226578656375746f7222206e616d653d226578656375746f72223e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226d616e6167657222206e616d653d226d616e61676572223e3c2f637562613a70726f63526f6c653e0a2020202020203c2f637562613a70726f63526f6c65733e0a2020202020203c637562613a6c6f63616c697a6174696f6e7320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d227275223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22d09ed186d0b5d0bdd0bad0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22d0a0d0b0d0b1d0bed182d0b020d0bdd0b0d0b420d0b7d0b0d0b4d0b0d187d0b5d0b9223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22d09ed186d0b5d0bdd0b5d0bdd0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22d09fd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22d097d0b0d0bfd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22d097d0b0d0b2d0b5d180d188d0b5d0bdd0b0223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d22656e223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a2020202020203c2f637562613a6c6f63616c697a6174696f6e733e0a202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c73746172744576656e742069643d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e3c2f73746172744576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d45464346313843452d444639432d344437352d413835342d3538393436333035334430372220736f757263655265663d227369642d34414346434531442d303336362d343743432d413845432d43423337324436454439453622207461726765745265663d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422206e616d653d2253657420455354494d4154494f4e0a222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154494f4e27297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622206e616d653d2253657420455354494d41544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154454427297d223e3c2f736572766963655461736b3e0a202020203c757365725461736b2069643d22657374696d6174696f6e22206e616d653d22457374696d6174696f6e223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22657374696d61746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36393230454232462d433230322d344436442d424642332d3139423039314444463246332220736f757263655265663d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422207461726765745265663d22657374696d6174696f6e223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d46384546413243432d323343432d344531392d423534312d4641303434323239413838332220736f757263655265663d22657374696d6174696f6e22207461726765745265663d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d34393333384646332d373145452d343942442d423345452d3138433531354136393131382220736f757263655265663d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622207461726765745265663d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422206e616d653d225369676e616c205461736b20457374696d61746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b457374696d6174656427297d223e3c2f736572766963655461736b3e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222206e616d653d225761697420666f722070726f6a65637420617070726f76616c223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d2270726f6a656374417070726f766564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d36383636333336442d394533352d343744342d384332382d3238373439303544463041352220736f757263655265663d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422207461726765745265663d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22706c616e6e696e6742794d616e6167657222206e616d653d22506c616e6e696e67206279206d616e61676572223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22706c616e223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6d616e616765725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36424437333643372d463136382d343237432d384535322d4138373434384338333930382220736f757263655265663d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222207461726765745265663d22706c616e6e696e6742794d616e61676572223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22776f726b4f6e5461736b22206e616d653d22576f726b206f6e207461736b223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22636f6d706c65746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c736572766963655461736b2069643d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022206e616d653d225369676e616c205461736b20436f6d706c65746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b436f6d706c6574656427297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722206e616d653d2253657420494e5f574f524b222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27494e5f574f524b27297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d42383937333531322d353138312d343333392d393342432d3342433236304345383039302220736f757263655265663d22706c616e6e696e6742794d616e6167657222207461726765745265663d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35443345324445342d454635412d344444442d393136322d3132384546333141454334382220736f757263655265663d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722207461726765745265663d22776f726b4f6e5461736b223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422206e616d653d2253657420434f4d504c45544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27434f4d504c4554454427297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d39424237363738322d444331452d343636332d393944452d4643333144313430373531342220736f757263655265663d22776f726b4f6e5461736b22207461726765745265663d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35363143343738422d323344462d343744452d394433442d4436433743393942463830312220736f757263655265663d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422207461726765745265663d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e3c2f73657175656e6365466c6f773e0a202020203c656e644576656e742069643d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d46313832303146332d334636422d343231452d424334462d4136374345444141433641352220736f757263655265663d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022207461726765745265663d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f7461736b2d7766223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d227461736b2d7766222069643d2242504d4e506c616e655f7461736b2d7766223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536222069643d2242504d4e53686170655f7369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d2233392e3132352220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544222069643d2242504d4e53686170655f7369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223135302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436222069643d2242504d4e53686170655f7369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223534302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22657374696d6174696f6e222069643d2242504d4e53686170655f657374696d6174696f6e223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434222069643d2242504d4e53686170655f7369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032222069643d2242504d4e53686170655f7369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223934352e302220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22706c616e6e696e6742794d616e61676572222069643d2242504d4e53686170655f706c616e6e696e6742794d616e61676572223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223931302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22776f726b4f6e5461736b222069643d2242504d4e53686170655f776f726b4f6e5461736b223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223532352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330222069643d2242504d4e53686170655f7369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223132302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237222069643d2242504d4e53686170655f7369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844222069643d2242504d4e53686170655f7369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545222069643d2242504d4e53686170655f7369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d2234302e3132352220793d223232312e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037222069643d2242504d4e456467655f7369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037223e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236392e31323435383534323932313838372220793d223130302e3131313532313038313235383133223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223135302e302220793d223130302e3731323832353237383831303431223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031222069643d2242504d4e456467655f7369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223232302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438222069643d2242504d4e456467655f7369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223632352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138222069643d2242504d4e456467655f7369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223634302e302220793d2239382e3631313131313131313131313131223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d2239352e3937323232323232323232323233223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135222069643d2242504d4e456467655f7369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223934352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633222069643d2242504d4e456467655f7369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223235302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930222069643d2242504d4e456467655f7369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223931302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038222069643d2242504d4e456467655f7369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223131352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223139352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833222069643d2242504d4e456467655f7369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223534302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135222069643d2242504d4e456467655f7369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223132302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236382e3132352220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134222069643d2242504d4e456467655f7369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223532352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray VALUES ('5243', 1, 'process.task-wf.png', '5241', '\x89504e470d0a1a0a0000000d49484452000003fc0000011d0806000000b1266cf5000036094944415478daeddd0b9455f59d27fa5a1333e94c6e2693bb5626ab5792d5c95d76c665675c5919bdf12e6f324e5f7bd2e9d8d7a4a3960508041f182208065f6d6c8c8e91a811297cc5241a8d91286d881215a11e3c448df800445069458492978ac85351ff737e5b76e5703ce7d4a92aaaa8c7e7b3d67f71ea9c53a75ebf2ffffd3b7befffaeab030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007a454ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622d5b37a468e0c399205431600f68b98c8162e5c98366dda94de7aeb2de3008dcd9b37a7f9f3e76f2d4c6cc7ab4af5ac9e9123438e64c19005806e8b77ad4d647d66427b6beedcb92b55a57a56cfc8912147b260c80240b7c5216a2692be330a93d91e55a99ed5337264c8912c18b200d06d717e9449a44f4d664955aa67f58c1c1972240b862c00f4ea64b6fef5ede9ece94bb211b74d3e26b3fe5acfdbdf589f5e5c7c4b7aa6e9926cc4edb84f0daa67cc0b72842cc802c0a098cc76ef7e2bbdf6e6cef68f17acdcd03e99c5edfcfe4d6fec486f6cdb69323299f58b8db36d5bdad2f2072f4a4bef3b679f11f7c563ea503dcb9179418e9005590018d093594c64b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f66713beebfefa975e9fcc273ae9efd5cdabadd846632ebfb0dffda67eefd40b39f8f75cfcc5287ea598ecc0b72842cc802c0c09ecc5eddba239d77d7b2f6c9aba331f1774bd3da57df342199ccfa7cc3bfb2f5a7151bfe784c1daa6739322fc811b2200b0003be41ba7f495bcd93d95d7f5a63323299f58b867ff9dc8b2b36fcf1983a54cf72645e90236441160006fc641687a8e593d539772e4d773cfc527a61c31bd988db715ffef8034b9dfb6c32d3f01bead9bc605e90235990055900e8d39359ac2e1b0bce149f8f169357e9f3e2bee2f3d5e273ac4c6b32ebeb0d7facca5fa9e18fc7d4a17a9623f3821c210bb200306027b37287a3c53bd6a5cf8bfbca3dd7a46432ebcb0dffaa45d7566cf8e33175a89ee5c8bc2047c8822c0098cc4c6626b37ed8f0bfd6b62c2d9f33e98387f317ee8bc7d4a17a9623f3821c210bb2003060273387ab99cc0672c31f63f5e3b77da0e18ffbd4a07ac6bc2047c8822c000c8a0669de8a0d352f4813cf351999ccfa45c3bf7b775af5f00d1f3c9cbf705f3ca60ed5b31c9917e40859900580013f99cd5e56fb2567fef8d43a9391c9accf37fcdbb6b4a5e7174dab780e7f3c16cf518bea598ecc0b72842cc802c0809dcc5eddba235d306359cd93d9b9772d4d9bded861423299f5cd8db3ddbbd3fa552de9e9d9ff5cb1d9cf473c279e6b6fbf7a9623f3821cc9822cc802c0809ccc76ecdc9d6e6859951d9236f3f19753eb8a7dcf578bdb710dda394fbf924d7a372f7821edd22099ccfa603d77b457dfde7ef58c79418e90055900185493593ea16dd8f2e7056662c1997c328bdbf9fdafbfb9d3446632ebb3f55ccb5efd6a7bfbd5a57a9623f3821cc9822cc802c0809bcccaad4c9b4f66569a3599f5977aee6ab39f0f75a99ee5c8bc2047b2200bb20030e02733c364a69e0df52c47861cc982210b002633c364a69ed5b37a9623438e64c19005009399613253cfea193932e448160c5900309999cc50cfea1939922364411680be21a574d0534f3d35f2965b6e69bafcf2cb5f1f3b76ecdb23478e4c279d74521a366cd87b63c68c79fba28b2e5a73f5d557cff8c52f7e7198df98c9cc64867a56cfc8911cc9912c18b230e0fbc4bf58b66cd9e85b6fbd75fee4c993b78e1b376e4f719ff8fdef7fffad0b2fbcf0c59ffef4a7b717c67ff11beb838dfef4e9d36fb8e4924bde1a3f7e7cfaf9cf7f9e1e7df4d1d4d6d69676edda9542fcbb69d3a6f4c4134fa4c21f3a9d75d659ef4d9c38b16decd8b1dff71b349999cc50cfea1939922364411654e5c06bf4efbefbeedb2ebdf4d23d9de913274c98f0d2e9a79f7eaadf601fd0dcdcfc9d42a3bffd9c73cec9fe48efbcf34eaad592254bd205175cf0ee983163569d70c20907fb6d9acc4c66a867f58c1cc911b2200bf4bcf18d2dedbfeff1d35a27edf37163cb1f2734b6fcf7729f77f1c577fdfbc2e36fe61f4f686cbdb442b33fe18753ef7f6ffcd4a6b4f8f1cef789e79f7ffe3ba3478f5ed9993e71c2d5cd9f297c6f4b3afbbba8f4330c7a77dd75d7efcf38e38c346bd6ac4efd014bcd9e3d3b9d7aeaa9bbbffffdef9feeb76a323399a19ed533722447c8822cd03b0dffe93f9ff51fc64f6b5e917f3c614ad3ff35beb17959275ee7cd9246ffa07beeb9a7e507ff7c55fad9af1f4c6fbfbda75b7de2a851a376f6f4defed29f81823973e63c3876ecd8f4fcf3cfa7fde1a5975e4a71eec60f7ef083f17ebb26339319ea593d234772842cc8023ddff08f9fda3cf1acc6d6f3f28fcf6a6cbe6ac2b49631d963d35a2e2adcff4661ec3e6b6acbd5d9e3d35aeb0b1fdf9abf463ef2667fdebc798f15dfbffbed77d26fe7ac4813af9b97cebbbe258dbde0f274f8e187a7fff89ffecf74fa65bf4fffe3847169c40537c50ee0ac065eddb23dfde8170fa5df35af4ce75c3f2ffda175693ae38c3376beb46ee30f0bafb7b130aebda669c7c3f13d64df5763cbfab3a6359f90bd5931b5e55fc74f6bfd76f6264663f32fe2f1c2683bebdad663b3ef77ca82bf9cd0d8b2a870dfcec2e78d2bf73350307dfaf43ba3d98f732df6a778bdc21f73d7f0e1c347f82d9bcc4c66a867f58c1cc911b2200bf45cc37ff1c5ad07c5defcf71be496b4f7df3571d87efebcb86f4263f3ff8c26f9fd37085a2e885300e2f6d8c6a6430bf72fcc9f1b7bf6f33ef1b2db1e496f6cdb9dee9eff7c9a72f33de9affffaafd3d78ef9c734e19a07d3c2850bd393cfbd92ae9cfe585affea9b69f1e2c5e9ca2baf4c471e7964faffbe3d2afdcb0db3d3f65d6fa7575edd9ecebd617ef67a679e7fd9ae7fbe69c14b675fdbf4c5f1d35a1aa361bff8e28bffdd59d7341d116f04c4edf81eb39f696af335f10645dcce9edfd8b2f6fd37049a7f93fd2c85c63fdfab5ffa330c7a0f3cf0c03f8c1e3dfabdfdb567bfdc9efe912347bed9d0d07088dfb6c9cc64867a56cfc8911c210bb240cf34fcb1273ff6e2177f5c68a42f7bbf396e397def1ef5b67853a0f0bc9fef7ddeadb1973f6e47537dd6b496ff3f6e3ffae8a3a3e274efe813db366f4b8dfffa44b620df59d7cc497ff3a5ff9a0a7d64b6b73f1af830e7b197d282a56b3fd00f5e7e4b73faef7f7f7cb682ff8e1d3bd3f9372ec8eebf6bce92f4fdf3afdc197d62d6d8dfd2fa17f175c75cd7fa7f143ede3ea1b1f598587b60eff7b8bd78cf7dece9cfef2ffd3d14ff0c144c9a34695b9cb3df930ac5f0eef0e1c317fb6d9bcc4c66a867f58c1cc911b2200bf44cc35f18cbc736deff1f8b3e7ef687d736ffd5de8fdf1edbb8e0537bf780af1e3fa5f5cb7bef9f3da1b1e96b7b6faf8e7f6335feb8625bde27cefed3ea34e74f2fa4638f3d368dfdd90369e9b36bd2bbefbe97e63df57276a87eb8e5bea7d38ad5afeed307bef7de7be987d7b6a696c7dfffdca1675e92feb5f5cfcfffedefe7be3574e8d047e23483d8b3bff70885f171f8fe84c6e6c913a6359fb1f7fbda1c7bf6cbfcccdbcfbe6efee7e210ffc2ed3f15ff0c14dc76db6d536235feb7df7e3bf5b4b163c7beded0d030cc6fdd646632433dab67e4488e90055960ff37fcf9defcfce3098dad77157d7c6d34fde31b5bef8dc3dff3c3fcf3dbef37db2d6d7198fccc99337f5bdc27fef4b77f4a234e39231d73cc31e94fcb5f4e937eb5283b877f7ad3ca6c2f7fb8e8970fa55fdd7ccb3e3de0732fbf9eee6c7936fbfc78fef7ceb93a35340c697ffe9e77de4d63c68cd97057f38a6bde3ff2203b47ff577bf7f22f89663ebec738a73fceeddffb786bfe6645bc2190dd37ad7945bc9151fc33a888bab804c3c53be2d27bbd61d9b265c95e7e9399c90cf5ac9e91233942166481be2bf6ee5f7ae9a57b8afbc4e9d3a7a7430e39246ddebcb962bf377ffefcecb0fd871f7eb8fdbedfcf7f3e2d2fdaebbf6ddbb6f4a52f7d297bbddcd2a54bb3bdfc453deabf8b863e8e56f0d7e886c21fe41f620186ee5c7eafb34e3bedb4d70a45f079bffdf21a1a1ae616c6ff6b323399a967433d234772842cc802072247cb962d1b5ddc27eed9b3271d7cf0c1d939fb95ecdebd3baed096860c1992ce3cf3ccf62303aeb8e3b1f62300725117f17af1bab951a3466dc8fbc4bd7bfa37e62bf1d34537de78e3cc5ffef297a9375d7ffdf52f16fe9013fdf6cb8b77c4624418ebebeb8f349999ccd4b3a19ee5488ee488039385c71e7b2c7ded6b5f4b1ff9c847d2473ffad174d45147a5458b16658fc54ed0183d513f955e3bbfbf74ecefaf230b7274ebadb7ce2fee13e3eff8e52f7fb96a9f3763c68c3474e8d0144705c4bf3367ceacfafc58bdbff80d842953a62cd127ee67975e7ae92b8f3efa68af36fc8b172fde55f843cef2dbaf1ec2a2f140b977e16cd8d9b053cf867a962339922359e8d92c7cf18b5fcc1ae2382df5c9279fcc6e7fee739febf1fae9a811df5f8dba865f8e2ae568f2e4c95b8bfbc4d8635fe81d2bf678afbdf65a1a316244baf5d65bb38fe3df912347a62d5bb654fc9cb864dfa9a79edafef1c30f3ffc923e713ffbc10f7eb06bfdfaf5bddaf0c7f5160b7fc8757efb3587b0fd5db8e230dab0b361a79e0df52c47722447b2d0b35988bdfad1103ffbecb3559be5175e78211d71c411e9c31ffe703af1c413f7792cbf3d71e2c4f4b18f7d2c7dea539f4a37dd7453f6589cef7ce8a187669ff7e94f7f3afdfad7bfee72c35fe9b5eeb9e79eec7ce9b83f7e9eaf7ffdebd9f75bfa3a575c714576fbc20b2f940539aa1b376edc9ee23ef1f0c30f4f0b172eacd8e35d77dd7559f3be7dfbf6f6f3f44f39e59474e38d3756db119cad0990dbb061c3a6c2f7b2b6f8fb8d4b07965b999f1a8d1831e2ddb88e626f8aaf57f843eef6dbef5c088bdf858bc36f6cd8d9b053cf867a962339922359e8d92ce44d7034ea63c68cc9f6f4976bbabff18d6f64b7e310e638acb95cc31f8f2d5fbe3cbbfdc94f7e327b2c1af4386d60eddab5d9fd9ff8c427badcf0577aadf8373e5ebd7a75f678dc8e37278a5f279ab2f877d4a851b22047598e62ef7c719f78d04107a54a7d63bc81d4d0d09066cf9ebdcffdf7df7f7f76ff4b2fbd54f6f3e2fcfdba6c7dc07dfac45df9f79a2ddcd7d8b2d35fad9b7ff003a18642333a1836ecfad65093ea593d1b7d61a85f3932f6ff9c12e7ec47f3134d7f3427f1264069d31de7f8c7ed685862946bf88b9bf50f7de843d9ed68c2cf3befbcac01aff639b534fc955e2bd61d88dbb187ff9bdffc66b6273656592fb726c0d4a9536561908e53cfb9228dbb7a763aeb9ab9e9b4f3a766f7bdb16d77fad12f1e4abf6b5e99cefcd90369c1d2b5592f577cff39d7cf4be75ffef374f6d967a7ed3bdfbfff5fe73d97ae99f178bafdc167d2f8a94d69c235b3d353ab36b6f782f19c77de7937addbb42dd59f7d6d76df838fad4ee7dfb820fbfa674d6db93adbbb3fa5f5cb131a5b16e9dabb61f8f0e1ef1ca03dfcbbfcf63bfdaedbe2fafafa638f3efae8831cba694f8e7a36d4b31cc9911cc942ef6621df731ecd7d771bfefce3389c396ecf9a35abdb0d7fa5d78aef277e27e3c68dcbd61f88fb636d82e2d789f3b3e370ff38f45f16066f8e0aadda770be39bb1577dc48811efcd7ff2a574ddef9f4adb77bd9dfef3670f4ee7de30fffd73ed9f6e6bbf7f76cbc385267d4eb6c6455c7aefcae98fa54d5b76a4bbe73f9fe62f599b1d5572f2a963d379d7b7b6f783bfbaefe9f4d2faad697ad38af437ffcf3f14b78a1bbff783f3decaf7ea9f35adb5be70fb567fb56e183366ccf6de3e877fe3c68d3b4acfcda06a08f799c472d526b36a2bca561b71ee579cd7556d62a92b5911b696d56bcb7d5eb9db311e79e491ecbef8b7aec2eab3871d7658fbfdf16e762d2bd796be4e1cbaf6852f7c217bb73b2e09929f4b57fcce7b4cecb52e686332ebb97ade1f8b11d5756225e3d21cd4ede7058d7afaf56d9cc95157571c1fecf343b5fb3ffef18f67cdd28e1d3be46890cd2979131df5fcf8e38f976d96e3f671c71dd77ed8fe9d77de5973c39fbf51902f08d89d86bfd26b7df5ab5f6dcfd02bafbc92ddfecc673ef381d719366c5876bbb5b5d59c32c87234bde5856bcfbd71d1c6f72f85d7bc6cfcb4969f8f1d3bf6adebee5e9c9e5df35ad6c31d71c4ff9d265edb92ddfee51f9765f7c765f7c68d3b2b4d983a37bb7fce632fb51f05107bfef7bcf36e76fb92fff59334bef09cfc127cf73ef46fe9b115ebd3f937cc4b871efa37d91b08b1d7ff5f7eb968cfb82b67be1d5f3fbed7f1539baf9930adf90c7fb56e38f7dc7397f6f62afd858d86c7adbe5853081f696868f876e92456cb64d6d51565ab4d2e951eabe56b95fbdc4a1b55575d75d53ee7cc957e6e3ed9d6159d7356cbf75a7cdf1d77dc91dd8e854562e36df4e8d1d9c73141173fb7dc217b26b3deafe7de5e7db8a71bf0bed8e0abe7c19323f343f5af57e9fe6baeb9a67dd135391a5c73ca92254bdadfb88a9d01f1c655fee653718dc41b4c71c9b2784e6c5fd4ed3d84bea3863f0eaf8fd78e73e7bbdbf0577aad356bd6a4ef7ce73bd91b6ff13dc521fff1265ee9ebdc77df7dd9ed5874d09c32b8725468f4df1edbb8e053631b9b0e2ddc5e1d87d2373636ae3a7b5a4b5af4f4baf4de7befa57193ae4be75ff99becf60faf6dcdeebff7de7bd369e75e957e73ff93599f77cb7d4fa715ab5fcd6ec7e1f96b366c4defbefb5e9ad9b2348dfed1f5d9d127e1c9e737664702fc68caefb2bcc4eb6ddbf9765abb79fb82095367ef88af1fdfeb59d35a7f7ff6d4967ff057eb861ffde84757145f5fb1374c9e3c79a1eb2b560d61d977ab3b3399555b5136ced91a3e7c78fb1e97ef7ef7bb69ddba75edef0ad7b2e153ebd7eaec065dbc8bfead6f7d2bbb2ffe8dc5674a3f37f6b0c4c7712e5da549a9a3af97bfd39daf501b93747c1cf7173fb7f037d0f0f7817aee89e6bad28ac5e57250eef657bef295ec7363afdfa44993b20da9f8dc5815f9f6db6fafb85a7247af1f97b48937a0e27b8ae79e71c61969ebd6ad1daef2ace197a35a73647ee85ac31fab4dd775f2726c7234f0e6946a23e683c2366eb62321e693a89738e2c4e92db2d01f725468f2af8da67f7c63ebbd857fdfbcf8e2bbfefd830fafb8ffc7d7ff21fdf4b77f4a13af9b97a6fca6a9b0fdf3dfd2732fbf9eee6c79365dfe9b47b2f3f32fb97e66763e7eb8e8970fb5efd55ffa6f9bd2a45f2dca3e777ad3ca74fd8d37656f46c576cd2baf6e4f85af93fec7ff3c363df0c003d939ffd1f44ffaf9dc8d13a635ef8eaf1fdfd784c696d72fbea5f52ffcd5ba61e8d0a19f1d3366ccdbefbcf34eaf35fcc3860d8beb2b7ede6fbf7baa4d66d55694cd3784626f4bbc6b1db76365d95af7e0946ef455fb5a9ddda08bcf8f0dcb982ca3498a8feb4ace418b26e72ffff22fe3b21dd9fdb14119f777e6ebe51bafa58fc76b959ecf567a589cc9acf7ebb9270ee9af65c5e26ab57af7dd77b7bf51142356645eb56a5597565e2efe383fda248e42c957798ea6bfa3559e6d9c516b8ecc0f95bf5e5d07a78215efb195a3c139a7541bf17f7334f8c5a7b0e4470268f865a13f6a7a3edd32f6fc9fbc97f78971387e9c063be5b6b9d9b9fab1d3f87bdffb5ed6c0d762cb962d69c48811e957bffa55f671d445bc5e7e987f2cf53664c89017f4893da0d0d42c7fe289277aa5d95fb0604153e18fb8d06fbde727b34a2bca96eea9a9abb0f84c670ee7acf4b53abb41973738b1c7346f6c8a9f174d56dc8e1568e3e3d8cb1a1f97fe2e3afa7ab1c1564bc31fcd5aac38aae1efff0d7fe9fdb5ac585cad562bbd7e5dc9e19db5acbc5cd7c1a24f95f25957b4cab38d333a9323f343e7f7f06bf8cd29863965b019dfd8b2e4d2cb26bf58dc274e9f3e3d8dfa97dbd2e34f2e4985e63c5d72c925d9dfb7d611ff87c7e73df7dc73d99196f17ab9071f7cf0767d620f897337264c98b0ab17f6f2ef193e7cf8b2c2d71be6b7de7b9359e98ab2c50dc5fe3847b3dad7eaec065decb98906261692898daaf8b8f879fff88fff58764f4cbe8157ebd7cb1bb0d84b1a1faf58b1a2e21ede38d45bc33ff01afe5a562cee6ec35febcacbc51fe787401737fcd128d5f2b56d9cd1d91c991f3a7f487f1cb923471a7ec39c32589c72ca2927fcf0873fdc53dc27c6e28efff44fffd4ad4b001e7ffcf1a9e4f2f05b860c19f2a43eb1078d1a356af1bdf7defb6e4f76fb37de78e3cc78d7a6a3f3aee8fe64566d45d978572d3e8e737ff3c3d563319a782cdf031387e6d4721864475fabb31b74c50d76e9f9f37188666cecc5b9d2f96bdc7cf3cdd963b1484e5716ed8bf388e2e37c719bb8bff4b93ffef18f35fc03b0e1afb66271690ebadaf0575a2db9daebe78754171fd21f872e6bf8d95f39323f74ade18fdf49dcbef0c20be5689037fc75fde0ea2f7d6d215959e8df468f1ebd2c5f6c2fbfc4fab1c71e9b8e39e698ec30fdce88374ff3cf2dbe34fc95575ef94b7d620f8b7325bef7bdef6d7bfef9e77ba4d97ff6d9671717bec6fa86868643fcb67b7e32abb6a26c6c184553912f0a16e767c6eaadf906529c131c9f932f3cd6d10457ed6b7565832e6fb02fbbecb27d1e9b366d5af6ef45175dd4fe1ab11054fe78fe33d4ba41171b6f71de50dc1797e72bbd2c5ffedcfcbc6c0d7fff6ef84bebb6da8ac5a539e86ac35f69b5e46aaf1f8bf6c56ab5f17931a2d92f5db44fc34f7772647ee8fc39fc757b2fcb377efc7839d2f00fb8abbf68f8a9a54f2c6ccbec2cee13a3598f3dfdf1c66e2cba578ba883388c3ff6ec1737fbcb962dbb479fd84beaebeb4f3aedb4d3dedcb469d37e6df65f79e59567860c19f2b24334facf646698ccd4b37a56957264c8912cf4cfabbf54bae246fe66581cf912f797be212d0b545268ee878e1e3d7a47699f18e7e0c70eb4a8a94b2fbd342d5cb8b0bd998fc5f8162f5e1c7befd391471e993daff89cfd50a8cb870a7de21a7d62efbe8333f294534ed9f2fcf3cfef9713fa57ae5cb9289afdfafafaf3fd766dd8d9b0433dab67e4488e18080d7f5d1fbefa4bb52b6ec42931757b17be8c372934fcd46ae8d0a1a34e3ffdf40f1c111e8d7dfc8de3ea56871f7e783ae8a083daeb2a9afc3872318e02285a8dbf7dcf7e34fbfac40320f6f417fea05b0afff16ceec6427ebbaebbeebabbe2f08c7813c16fd5869d0d3bd4b37a468ee48881d2f0f7e5abbf54bbe246b9abc168f8e94c9f386cd8b0ad7ff8c31fb677a34fdcf2b39ffdec167de20116e76a0c1932a4e9b4d34e6b7be28927b6766625fed6d6d659279f7cf2e3b1f08273316cd8d9b0433dab67e4488e18e80d7f5fbafa4bb52b6e68f8d94f7d62f3e8d1a3373cf9e4933b3bb34378ce9c39d3870d1bb6589fd8b7fea0c747e33f62c4888d3ff9c94f962c5cb8f0c5750585ff20b2633276eedcf9eafaf5ebff6ddebc79cd975c72c99ca14387be187fc078b7c62a8b36ec6cd8a19ed5337224470c8686bf2f5dfda5da1537e2d0febabd87f4e75783d1f0d38d3eb179e4c8919b264f9efccc430f3db4a6adad6d7d7e0e7fa14fdc50c8c2734d4d4d7fbcf8e28b1fd027f671853fd0671b1a1ac617fe40330a637561ecda7b1dc5f8776d61cc2a8c89f18e8fdf960d3b1b76a867f58c1cc9911c0de486bfae0f5ffda5da15376221c1c30e3b2cfb1ee3dc6a0d3ffa44b0616798ccd4b37a468e0c3992054316a84934fc7e0b60323399a19ed533722447c8822ca0e1074c662633f56ca867e4488e90055940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b3a19ee5c89023593064010d3f98cc0c93997a56cfc8912147b260c8021a7e309999cc50cfea19399223644116d0f003263393997a36d433722447c8822ca0e1079399613253cf867a468ee40859900534fc6032334c66ead950cf7264c8912c18b280861f4c6686c94c3dab67e4c89023593064010d3f98cc4c66a867f58c1c1972240b862c68f8019399c90cf5ac9e912339421664010d3f60323399a967433d234772842cc8021a7e3099192633f56ca8673932e448160c5940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b37a468e0c3992054316d0f083c9cc64867a56cfc8911c210bb280861f309999ccd4b3a19e912339421664010d3f98cc0c93997a36d433722447c8822ca0e1079399613253cf867a9623438e64c1900534fcd0873537379b44faced85598ccf6a84af5ac9e9123438e64c190050dbf861fba6dc18205eb376dda6422e903a3adaded7785c96ca5aa54cfea193932e448160c59d0f06bf8a1db5a5a5a8e9b376fde1b1b376edc69423970ef5ac744d6d4d4b4a6308e5795ea593d2347722447b260c882865fc30ffb45e13fd063e7ce9dbb380e958af3a38c5e1ff17b5f692253cfea193932e448160c5940c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e1070000000d3f000000a0e10700000034fc00000080861f000000d0f0030000001a7e000000d0f0030000001a7e00000040c30f00000068f8010000000d3f00000068f8010000000d3f000000a0e10700000034fc00000080861f000000d0f003000080861f000000d0f0030000001a7e00000040c30f00000068f801000040c30f00000068f8010000000d3f000000a0e10700000034fc00000080861f00000034fc00000080861f000000d0f0030000001a7e00000040c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e10700000034fc00000030109afb59d1e0773016fb4d01000040ff6af80f2f8c3dd51afefafafa63fda6000000a0ff35fd0f5469f81f39fae8a30ff25b02000080fed7f01f5ea9e16f6868f8b6df10000000f4dfa6bfdcb9fc8beddd07000080feddf07fe05c7ee7ee030000c0005068f067dabb0f00000003afe13fb2e8dcfdbff71b0100008001223f97dfde7d00000018580d7fb662bfdf0403464ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622e5c89023593064418ee4488ed4aea176d92f22940b172e4c9b366d4a6fbdf5967180c6e6cd9bd3fcf9f3b716427abcaa9423438e64c190053992233952bb86daa5dbe21d38a1ec33e17c6beedcb92b55a51c1972240b862cc8913a9623b56ba85dba2d0eb7118abe330ac1dca32ae5c89023593064418e0c3952bb86daa5dbe25c0f81e853c1b448881c1972240b862cc89121476ad750bbf46e30d7bfbe3d9d3d7d4936e2b620092672244774250bdbdf589f5e5c7c4b7aa6e9926cc4edb84ffdca02e614393207186a975e0ae6eedd6fa5d7dedcd9fef182951bda2795b89ddfbfe98d1de98d6d3b054b30e5488ee448163afcfb6cdbd296963f78515a7adf39fb8cb82f1e53c3b22047e614393207186a971e0e664c28b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f2a713beebfefa975e9fcc273ae9efd5cdabaddc4229872244772240bd5ff3e6b9fb9f7031b7af958f7cc2c352c0b72644e91237380a176e9e960beba75473aefae65ed93484763e2ef96a6b5afbe295c822947722447b25075ac6cfd69c58dbd784c0dcb821c9953e4c81c60a85d7a2198f72f69ab7952b9eb4f6b044b30e5488ee448163afcfb2c9f7b71c58dbd784c0dcb821c9953e4c81c60a85d7a219871a8583e699c73e7d274c7c32fa51736bc918db81df7e58f3fb0d43937822947722447b260634f1630a7c891da3507a85dfa74306395d758f8a5f8bcb098444a9f17f7159f37169f638558c1942339922359a8366245e64a1b7bf1981a96053932a7c89139c050bbf46030cb1d1616ef1c973e2fee2bf75c01134c3992233992854a63d5a26b2b6eecc5636a5816e4c89c2247e60043ed6252114ce4c890a37eb8b1f75adbb2b47ccea40f1eca59b82f1e53c3b22047e614393207186a971e0ca6c3c604133992237a6a632fc6eac76ffbc0c65edca77e6501738a1c99030cb54b2f0573de8a0d352f0c13cf152cc1942339922359e8f06fb47b775af5f00d1f3c94b3705f3ca68665418ecc2972640e30d42ebd10ccd9cb6abff4cb1f9f5a2758822947722447b250f56fb36d4b5b7a7ed1b48ae76fc663f11c752c0b72644e91237380a176e9c160beba7547ba60c6b29a279573ef5a9a36bdb143b804538ee4488e64a1ec1e9df5ab5ad2d3b3ffb9e2865e3ee239f15c7b7a64418ecc2972640e30d42e3d14cc1d3b77a71b5a56658786cd7cfce5d4ba62dff3c6e2765c0b76ced3af6493cfcd0b5e48bb045330e5488ee448163ab947c79e1e59c09c2247e6007380daa5b7df89db3bb16cd8f2e7855e62e1977c5289dbf9fdafbfb9d38422987224477244d92cd4b247a7da9e1e352d0b72644e91237380a176e98149a5dc0ab1f9a462c557c1448ee4885ab2d0d50dbd7ca869599023738a1c99030cb54b2f4c2a8660224772842cc802722447a85db58b601a822947861cc982210bc8911ca95d43ed22988660ca912147b260c8027224476ad750bb08a6602247861cc982210b7264c891da35d4eed0a1433f5b5f5f7fe649279d34a3305615c6b6c24885b1ab3056171e9b59f877623c4f300dc1448ee408599005e4c89023b5ab76fbb88686866f17c6dcc2786b6f835fcb682d3c7f98601a82891cc911b2200bc8911ca94ab5ab76fb9842d3fef9c278a0134d7eb9b1f084134e3858300dc1448ee408599005e4488e50bb6ab70fa8afaf3fa9a1a1e1b5e2e67de8d0a1e9f2cb2f4f2d2d2de9e5975f4e6fbef9660a3b76ec486d6d6d69d1a24569ca9429e9e4934f2e6dfab70df4bdfd822998c8911c210bb2801c1972a476d56e7f68f68f2d34e8ef1437fab7df7e7bdab46953aac5962d5bb2e7c7e71537fe85d73c55300dc1448ee408599005e4488e50bb6af7c0edd96f6ff6cf3efbec6c6f7e57c4e79d73ce39a54dff30c134041339922364411690233942edaadd5e14e7ec171fc63f69d2a4f6c3f6bb2a0ef7bfecb2cb4a0fef3f44300dc1448ee408599005e4488e50bb6ab797c44afcc57bf6bbdbec1737fd257bfa170aa62198c8911c210bb2801cc9116a57edf64eb3ffede273f6bb7a187fb5c3fb8bcfe91f6887f60ba660224772842cc8027264c891da55bb7d7eef7e2cb8d713a64f9f3e60f7f20ba660224772842cc8027264c891da55bb7dced0a1433f9b2fd4177be15f7bedb51e69f863f5fe924bf67dbed2f75478ecf0fafafa998269f44430fb5b7d99e00c399205431690233952bb8686bf4b0ae13a336fc2afb8e28ad493a64c9952dcf04f2c17f6c29855187be2398331988f3df658fadad7be963ef2918fa48f7ef4a3e9a8a38e4a8b162dca1e2b7ca96cf44431577aedfcfed2b1bfbf4e6f04b3bfd69709cee84b139c1cc9822cc8821c1972d43f6ab778db3d7a8bc30e3b2ceb350e545fd197fb8701ddf017c235236fc2e7cd9bd7a30d7f34ae450dffac4a61cfc7600ce617bff8c5aca0972d5b969e7cf2c9ecf6e73ef7b91e2fe68e82b4bf8276201afefe5e5f2638a32f4c7072240bb2200b7264c851ff6cf8e3766b6b6b763b9afe03dd446bf87bbfe15f95876c7f2fd657aaadadadb8e15f5b5f5f7f641cbe531af6c1dcf0c75efd28e8679f7db66ab1bff0c20be988238e481ffef087d389279eb8cf63f9ed891327a68f7dec63e9539ffa54bae9a69bb2c7e6cf9f9f0e3df4d0ecf33efde94fa75ffffad75d6ef82bbdd63df7dc93bef4a52f65f7c7cff3f5af7f3dfb7e4b5f278e2889db175e78618f0473a0d49709ce3890139c1cc9822cc8821c1972d4ff1bfefce3d83e2f7daca3fea05c4f51cb631d3daf5a3f53eee738f5d453b3dee2cb5ffe72d62bc591d0f98ed2785efc1b1f7ff5ab5fd5f09734fcdbf290edaf4bf155bb445f51a8dfad14f6c1dcf0e74d700462cc9831ed055c1a9e6f7ce31bd9ed993367a6193366940d563cb67cf9f2ecf6273ff9c9ecb108731ccab376eddaecfe4f7ce2135d6ef82bbd56fc1b1faf5ebd3a7b3c6e47988b5fe7c61b6fccfe1d356ad47e9f54f62e10396ba0d49709ce38501b6772240b8639458e0c73cac0dac31fcd72e9631df507e57a8a5a1eebe879d5fa99723f47ec548c11b76387e21d77dcb1cfcec30b2eb820fb387f4341c3ffe786bf3d64bda15ac8fbf3d89fff29c6a90f23478ecc9afe28da7813a0343c711e4edcdeb56b5736ca05ab38241ffad087b2dbd1849f77de7959035eed736a69f82bbd56fe6e5bbc5bf7cd6f7e335d77dd7569f3e6cd65d704983a75ea7e9f54066a8d0d8661a3a8cf6d9c19b230e8877a9423c39cd25f6bb7789b3b7a8168ec172e5cf8816dfb5afb83e29ea2d6c7aa3daf5a3f53eee7287e5e7c6edcfecc673e93feeaaffe2a7bde17bef085eccd846ddbb669f8fbc81efe5d279e78e231857f1fb187bffcc8df658b82ee6ec39f7f7cc8218764b767cd9ad5ed86bfd26bc5f713bf9371e3c665eb0fc4fdb13641f1eb9c79e699d9213971e87f4f1d363650eacb3bdac6813cfc528e64411664418e0c391a1887f4577aacd6fea02b8f557b5e771afee823e2b1499326651f5f75d555d9bfe3c78f770e7f9986ff809dc39f7f0f0d0d0d7f5ff878a186ffcf818bc36a1e7ffcf1b2cd72dc3eeeb8e3da0f81b9f3ce3b3b1dac7c41c0ee34fc955e2bce9b89db8f3cf2487ae59557b2dbf1ee5be9eb0c1b362cbb1d8718f56430fb7b7d0df609aeda952baa8d381f2d0ef7aa76fa4cbc131c47a27cfce31f4f43860c695f6b22469c76923f7ef0c107ef737858f13be651e7715ffc5b5772258bba2eae8e5b57e1ca187555ae9a51cbfdf173c61b71f1e6ab1c0dac39259f3be270c9f878ce9c39d9c77184557c9c1f461935dd97174bea28b707e2fb9585c1d734f5c4bc53faff72ece18c1d3bb5d46c67f35debfc158fc736667373f307be8fb84c773c16f3c68a152be4688037fcb5f607fbbbe1afd6cf94fb5e6fbffdf6f63725e228e2786cddba75592de7a714e739d1f0efdbf01ff055fa737bdff55b38981bfe254b96b44f323119c424933714752587dec43938f19c58c0a2aec2221ca51fc7e410af1de7ce77b7e1aff45a6bd6ac49dff9ce77b24932bea7383c2826c1d2d7b9efbefbb2dbb148476f04b3bfd6d7609fe0ba7ae58a6a351db51b8ffddddffd5df64e717e3e58be726d7e4e58642b9ae3d1a347671fc76454bac114ef2817afbf5129579d591db72b79ec68928cdbd75c734dfbc2397234b0e69458f3a5aee814b03834333ece0f0dcdf77c444df7e5867f7f7cad9e6ef86561e06f9bf5c4bc536e6e2877ca6677f35debfc15b763d1b3b81d6f28943e16db71713bceab96a381dff0d7da1fecef86bf5a3f53ee7b8d7a8ec7635b6ad5aa55ed8f0f1f3e3c7bfce8a38fb64a7f39f5f5f567e6218bff487ad29429538a1bfe8995bea7bdeffa3d32188359eb88775c274f9e9cfd671e7b258b1b09878d550f667fabafc13ec155bb7245ac0d11ffc9e77b61befbddef66eff4e6ef54579ae86272c9df512ef735f3a354f23dfe3121d515adfa9abf6e6c247deb5bdfcaee8b7fe3dcb88e26b94a6fccf546c31fe7b4d5bae12a47fd6b4ec9173bcaf72e7ee52b5fd9e7e8aa78732bdfe88f3d77b1d1149989ac9c71c61969ebd6adfbd44bbc4ee962ab1d5d5da596d72db74a73e951637535ac1cdd9b57839185c1d734f5c4bc536e6ec89b938efecfef4cbe6b9dbfaacd4bf91b0871faa56db3c1d1571ca8d1dd7e2676da4426231b7545475d6af84b0c1d3af4b3f98a9985dbd984dd13b66cd9924e3ef9e4e286fff382d9f5118d4a04a2f870b39e28f281d8f0d3bf7254edca15b1b865ddde43d0e2e898b81d2bbe76b401151b37f158de8c948e7cc3ad74632d3f5f2c7fedf87ee2b93151c56be67b61aaede12fb73a6ead87f4d7d2f0573bcaa074e34e8e06ce9c126fe6c41e9218719455fc9df33d74b11724fee6f1586c18e57bfc624f60de4844735e5c2f71886f9c92d599ababd4f2bae55669ae56db7de16a30b230f8b6cd7a62de29f7ff7234d4a587507737dfb5ce5f713bffdaa5479ee5238e0ab36da6e1efcbfd4ccc05f1b971544efe86b0bea2f2bb6a73f3463cce8de8097b2f6b938f85826968f8a9354795ae5c51ba47a5aec22297a523368ce2b17883b3da1b021d6d30e54d4dbe604c4c5c7515ce9fafb63a6e6fede1d7f00fec3925bf424a3402f1378ebd8e51777b0f936d6f88cb2d92549a9bb8bfd29b4995aeae52cbeb965ba5b95abdf685abc1c8c2e0dc36dbdff34eb9b921deac3afbecb36b3a0da5d67cd73a7fe523de842e3d7534e6aa380a27ceffb76da6afd0570c9c86ffdb79331e7bf9f7f7e27df17af1baf9d7287cbd61826908269dcd51e9952b8a1b8cce34cdf16e725d9543faf3e6225ff825162c2ab70731f6ecc706571c56191b59f1715d8d6b63d41dc043fa63634e8e06de9c72d14517b5ffbdf3c58ce230c7bc0188c6a2f870e5e2c63c9a9a8e6aaba3abab74e6756b7d83aa2f5c0d461606f7b6d9fe9a772acd0df9a1c81d35fcb5e6bbd6f92b6e474622a3b1a652f163b1e73f5f27207604da36d357e82b06884223de9a37e4f19fc6feba445f6c004f9c38f1bde2bdfb471f7df44182d9f1e164d55610ef2b0b27756745e5ba1e5a08caa432b07254edca15918bf838ce05ce0f4d8c452fe3b17caf4c1cb65fba61961fea1be7ddc76377df7d77f671be37235ff4283f14385fc426eeafb4b156ee5cccbed6f0c7efa9aec6f399e5a8ffcd2971187efef79e366dda0716938ca6b9f890e4e243efe3b0e55a6aabdad5553af3ba95eab534b77de16a30b230f8b6cd7a62dea93437fcf8c73fae697ba8d67c7766fe8aef317eae38bd267f63237f2c4e15a82b3a0dcdb699865fc33f301afecf17c6e6bc318f4354bbdbf447b37fd96597151fcabfada1a1e110c1ac3e3a5a41bc2f35fcdd69da35fcd492a36a57aed8b06143d664e48b84c57994717e633c76f3cd37671b31f139e5f650c4c65a6cc8142ffa557cde583c1e6f00d4edbdd451b9cb1a156facc5ff755d69f8eb3a7189bdee9cc35fb7f7b27cb55e9f568efadf9c12f345be973dbfdc579c7b5cb7f7d0f7fc728c712a4bac861c9989114d79e9e27a95eaaddad5553af3ba95b2519adbbe70351859187cdb663d31ef549a1bf2c6baa3eda15af3dd99f92b3f873acf48e963f1b3d5ed5dd3c3b699865fc33f40d4d7d79f942fe097efe9efeae1fdf179257bf607dca1fc3d15cc8e5610af6525e458c1353f3a20debc890da3786eac729c4f42f973f3892bde50c857a42dfe4fbf332bd2567a6e7ef997f8d9e2fed28d37c1c404678243166401399223b53bb75777eed5d23354ba624a5d952bb054fa9c386239dea48dfb4bdf68aad647d495b98a8cdaedfa9efe91c54d7f9c7b1f7fec5865bfd6d5f86381bee273f663d4d7d79f2f98b58d8e5610af6525e4384439bf144bdddec5c5f27791f395918b9f9b1f45f0b77ffbb71f68f83bb3226db5e7c621cff91b19f9d7d3f063e3ccc619b2200bc8d19f17bf2c37e448edf654c35f4bcf50e98a297555aec052e973f22347e273f23ea6333d47f15564d46e37f7f417c696e2863d1af8385768debc79d9defbfc70ff3884a8adad2d5bcdb4b1b1318d1831629fbdfa71187fbc892098b58f8e5610efec4ac8953eae2b5a8db9daeb746645da6acf2df77d6bf8d1e4d838431664013992230e4cc35fcbc795ae985257e50a2c953ea75a3f504bcf516ec14cb5dbf53dfd9f2fbe5c5f17c7c28178ce7e4f07b3a315c4bbb31272470d7fb9ebb4766645da6acfd5f063e3ccc619b2200bc8911cd1bf1afe4a574ce9cae7d4d2f077f62a186ab7fb8dfff17b1bff3d9d69f463affe405b8dbfb782d9d10ae2dd5909b95c486fbbedb6f630c6d72c7d5e6756a4adf6dc6a87f0082636ce6c9c210bb2801cc991daed7b0d7fa52ba674e5738e3beeb8f67ee0ce3befacb9e7d0f0f782a143877eb6d0f88f2f34f2330a637561ecdadbdcc7bf6b0b6356614c8c230304b3fba3da0ae2dd5909b95c48e3fcff38fc260eb989c36f4a9fd7991569ab3d3716e988a317e2678aef5fc38f8d331b67c8822c20477244df6ef82b5d31a52b9f13bd46f438d13be4fd40f4061df51c1a7e4c2a7de8b27826156c9cc911b2200bc89121476ab774c4d500264f9e9cad03173b03eb7af9d2e36a974115cc81b2f2ab60ca912147b260c8027224476ab7ef8f38943f1afcfcd27b471d7554fb51cc6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176114cc1448e0c3992054316e4c89023b56ba85d045330912339421664013932e448edaa5d04d3104ce4488e900559408ee408b5ab76114c4330e5c8902359306401399223b56ba85d04d3104c3932e448160c59408ee448ed1a6a17c1144ce4c89023593064418e0c3952bb86da453005133992236441169023438ed4aeda45300dc1448ee408599005e4c89023b5ab76114c433091233942166401399223d4aeda45300dc19423438e64c19005e4488ed4aea176114cc1448e0c3992054316e4c89023b56ba85d0453309123438e64c190053932e448ed1a6a17c1144ce4488e900559408e0c3952bb6a17c134041339922364411690233942edaa5d04d3104c3932e448160c59408ee448ed1a6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176e9587373b340f49db1ab10cc3daa528e0c3992054316e4c89023b56ba85dba6dc18205eb376dda24147d60b4b5b5fdae10cc95aa528e0c3992054316e4481dcb91da35d42eddd6d2d272dcbc79f3ded8b871e34ee13870efc045289b9a9ad614c6f1aa528e0c3992054316e4488ee448ed1a6a97fda2500cc7ce9d3b77711cf611e77a18bd3ee2f7be5228e5c8902359306401399223b56ba85d0000000000000000000000000000000000000000000000000000000000000000000000068cff0dc2a0a6105799a6d20000000049454e44ae426082', true);
INSERT INTO act_ge_bytearray VALUES ('5246', 1, 'process.bpmn20.xml', '5245', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566223e0a20203c7369676e616c2069643d2270726f6a656374417070726f76656422206e616d653d2270726f6a656374417070726f766564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c70726f636573732069643d227461736b2d776622206e616d653d22d098d181d0bfd0bed0bbd0bdd0b5d0bdd0b8d0b520d0b7d0b0d0b4d0b0d1872220697345786563757461626c653d2274727565223e0a202020203c657874656e73696f6e456c656d656e74733e0a2020202020203c61637469766974693a6576656e744c697374656e6572206576656e74733d225441534b5f435245415445442c5441534b5f41535349474e45442c50524f434553535f434f4d504c455445442c54494d45525f46495245442c41435449564954595f43414e43454c4c45442220636c6173733d22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e6572223e3c2f61637469766974693a6576656e744c697374656e65723e0a2020202020203c637562613a70726f63526f6c657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226578656375746f7222206e616d653d226578656375746f72223e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226d616e6167657222206e616d653d226d616e61676572223e3c2f637562613a70726f63526f6c653e0a2020202020203c2f637562613a70726f63526f6c65733e0a2020202020203c637562613a6c6f63616c697a6174696f6e7320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d227275223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22d09ed186d0b5d0bdd0bad0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22d0a0d0b0d0b1d0bed182d0b020d0bdd0b0d0b420d0b7d0b0d0b4d0b0d187d0b5d0b9223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22d09ed186d0b5d0bdd0b5d0bdd0b0223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22d09fd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22d097d0b0d0bfd0bbd0b0d0bdd0b8d180d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22d097d0b0d0b2d0b5d180d188d0b5d0bdd0b0223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d22656e223e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22657374696d6174696f6e2e657374696d61746564222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e61676572222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22706c616e6e696e6742794d616e616765722e706c616e222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d22776f726b4f6e5461736b2e636f6d706c65746564222076616c75653d22223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a2020202020203c2f637562613a6c6f63616c697a6174696f6e733e0a202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c73746172744576656e742069643d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e3c2f73746172744576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d45464346313843452d444639432d344437352d413835342d3538393436333035334430372220736f757263655265663d227369642d34414346434531442d303336362d343743432d413845432d43423337324436454439453622207461726765745265663d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422206e616d653d2253657420455354494d4154494f4e0a222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154494f4e27297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622206e616d653d2253657420455354494d41544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27455354494d4154454427297d223e3c2f736572766963655461736b3e0a202020203c757365725461736b2069643d22657374696d6174696f6e22206e616d653d22457374696d6174696f6e223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22657374696d61746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36393230454232462d433230322d344436442d424642332d3139423039314444463246332220736f757263655265663d227369642d41364544334341412d394537442d343236342d383442372d46393335414234463941454422207461726765745265663d22657374696d6174696f6e223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d46384546413243432d323343432d344531392d423534312d4641303434323239413838332220736f757263655265663d22657374696d6174696f6e22207461726765745265663d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d34393333384646332d373145452d343942442d423345452d3138433531354136393131382220736f757263655265663d227369642d39464244423738442d384331372d343132392d423139302d35383938354435313843443622207461726765745265663d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422206e616d653d225369676e616c205461736b20457374696d61746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b457374696d6174656427297d223e3c2f736572766963655461736b3e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222206e616d653d225761697420666f722070726f6a65637420617070726f76616c223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d2270726f6a656374417070726f766564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d36383636333336442d394533352d343744342d384332382d3238373439303544463041352220736f757263655265663d227369642d38303335384432312d363731342d344438312d413445332d36434446363433373432343422207461726765745265663d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22706c616e6e696e6742794d616e6167657222206e616d653d22506c616e6e696e67206279206d616e61676572223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22706c616e223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6d616e616765725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d36424437333643372d463136382d343237432d384535322d4138373434384338333930382220736f757263655265663d227369642d36343035323542372d323139382d344244392d413444342d30354434323735394638303222207461726765745265663d22706c616e6e696e6742794d616e61676572223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d22776f726b4f6e5461736b22206e616d653d22576f726b206f6e207461736b223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22636f6d706c65746564223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6578656375746f725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c736572766963655461736b2069643d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022206e616d653d225369676e616c205461736b20436f6d706c65746564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c6174656450726f6a65637428656e7469747949642c20277461736b436f6d706c6574656427297d223e3c2f736572766963655461736b3e0a202020203c736572766963655461736b2069643d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722206e616d653d2253657420494e5f574f524b222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27494e5f574f524b27297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d42383937333531322d353138312d343333392d393342432d3342433236304345383039302220736f757263655265663d22706c616e6e696e6742794d616e6167657222207461726765745265663d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35443345324445342d454635412d344444442d393136322d3132384546333141454334382220736f757263655265663d227369642d43383431433846322d414132332d343643382d413130462d43394134304139394539323722207461726765745265663d22776f726b4f6e5461736b223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422206e616d653d2253657420434f4d504c45544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7570646174655461736b537461746528656e7469747949642c27434f4d504c4554454427297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d39424237363738322d444331452d343636332d393944452d4643333144313430373531342220736f757263655265663d22776f726b4f6e5461736b22207461726765745265663d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d35363143343738422d323344462d343744452d394433442d4436433743393942463830312220736f757263655265663d227369642d43313543353742392d413334442d343533362d423031462d31443533453043373443384422207461726765745265663d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e3c2f73657175656e6365466c6f773e0a202020203c656e644576656e742069643d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d46313832303146332d334636422d343231452d424334462d4136374345444141433641352220736f757263655265663d227369642d36334533463342342d334344362d344342392d423633382d42444635313541334341433022207461726765745265663d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e3c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f7461736b2d7766223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d227461736b2d7766222069643d2242504d4e506c616e655f7461736b2d7766223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536222069643d2242504d4e53686170655f7369642d34414346434531442d303336362d343743432d413845432d434233373244364544394536223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d2233392e3132352220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544222069643d2242504d4e53686170655f7369642d41364544334341412d394537442d343236342d383442372d463933354142344639414544223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223135302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436222069643d2242504d4e53686170655f7369642d39464244423738442d384331372d343132392d423139302d353839383544353138434436223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223534302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22657374696d6174696f6e222069643d2242504d4e53686170655f657374696d6174696f6e223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434222069643d2242504d4e53686170655f7369642d38303335384432312d363731342d344438312d413445332d364344463634333734323434223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d2236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032222069643d2242504d4e53686170655f7369642d36343035323542372d323139382d344244392d413444342d303544343237353946383032223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223934352e302220793d2238352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22706c616e6e696e6742794d616e61676572222069643d2242504d4e53686170655f706c616e6e696e6742794d616e61676572223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223931302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22776f726b4f6e5461736b222069643d2242504d4e53686170655f776f726b4f6e5461736b223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223532352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330222069643d2242504d4e53686170655f7369642d36334533463342342d334344362d344342392d423633382d424446353135413343414330223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223132302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237222069643d2242504d4e53686170655f7369642d43383431433846322d414132332d343643382d413130462d433941343041393945393237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223733352e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844222069643d2242504d4e53686170655f7369642d43313543353742392d413334442d343533362d423031462d314435334530433734433844223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223333302e302220793d223139352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545222069643d2242504d4e53686170655f7369642d42303733374635362d303539422d343534332d413533302d344245433436313032383545223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d2234302e3132352220793d223232312e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037222069643d2242504d4e456467655f7369642d45464346313843452d444639432d344437352d413835342d353839343633303533443037223e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236392e31323435383534323932313838372220793d223130302e3131313532313038313235383133223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223135302e302220793d223130302e3731323832353237383831303431223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031222069643d2242504d4e456467655f7369642d35363143343738422d323344462d343744452d394433442d443643374339394246383031223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223232302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438222069643d2242504d4e456467655f7369642d35443345324445342d454635412d344444442d393136322d313238454633314145433438223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223632352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138222069643d2242504d4e456467655f7369642d34393333384646332d373145452d343942442d423345452d313843353135413639313138223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223634302e302220793d2239382e3631313131313131313131313131223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d2239352e3937323232323232323232323233223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135222069643d2242504d4e456467655f7369642d36383636333336442d394533352d343744342d384332382d323837343930354446304135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223934352e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633222069643d2242504d4e456467655f7369642d36393230454232462d433230322d344436442d424642332d313942303931444446324633223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223235302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223333302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930222069643d2242504d4e456467655f7369642d42383937333531322d353138312d343333392d393342432d334243323630434538303930223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223931302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223833352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038222069643d2242504d4e456467655f7369642d36424437333643372d463136382d343237432d384535322d413837343438433833393038223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223131352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223936302e302220793d223139352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833222069643d2242504d4e456467655f7369642d46384546413243432d323343432d344531392d423534312d464130343432323941383833223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223534302e302220793d223130302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135222069643d2242504d4e456467655f7369642d46313832303146332d334636422d343231452d424334462d413637434544414143364135223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223132302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d2236382e3132352220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134222069643d2242504d4e456467655f7369642d39424237363738322d444331452d343636332d393944452d464333314431343037353134223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223532352e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223433302e302220793d223233352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray VALUES ('5247', 1, 'process.task-wf.png', '5245', '\x89504e470d0a1a0a0000000d49484452000003fc0000011d0806000000b1266cf5000036094944415478daeddd0b9455f59d27fa5a1333e94c6e2693bb5626ab5792d5c95d76c665675c5919bdf12e6f324e5f7bd2e9d8d7a4a3960508041f182208065f6d6c8c8e91a811297cc5241a8d91286d881215a11e3c448df800445069458492978ac85351ff737e5b76e5703ce7d4a92aaaa8c7e7b3d67f71ea9c53a75ebf2ffffd3b7befffaeab030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007a454ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622d5b37a468e0c399205431600f68b98c8162e5c98366dda94de7aeb2de3008dcd9b37a7f9f3e76f2d4c6cc7ab4af5ac9e9123438e64c19005806e8b77ad4d647d66427b6beedcb92b55a57a56cfc8912147b260c80240b7c5216a2692be330a93d91e55a99ed5337264c8912c18b200d06d717e9449a44f4d664955aa67f58c1c1972240b862c00f4ea64b6fef5ede9ece94bb211b74d3e26b3fe5acfdbdf589f5e5c7c4b7aa6e9926cc4edb84f0daa67cc0b72842cc802c0a098cc76ef7e2bbdf6e6cef68f17acdcd03e99c5edfcfe4d6fec486f6cdb69323299f58b8db36d5bdad2f2072f4a4bef3b679f11f7c563ea503dcb9179418e9005590018d093594c64b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f66713beebfefa975e9fcc273ae9efd5cdabadd846632ebfb0dffda67eefd40b39f8f75cfcc5287ea598ecc0b72842cc802c0c09ecc5eddba239d77d7b2f6c9aba331f1774bd3da57df342199ccfa7cc3bfb2f5a7151bfe784c1daa6739322fc811b2200b0003be41ba7f495bcd93d95d7f5a63323299f58b867ff9dc8b2b36fcf1983a54cf72645e90236441160006fc641687a8e593d539772e4d773cfc527a61c31bd988db715ffef8034b9dfb6c32d3f01bead9bc605e90235990055900e8d39359ac2e1b0bce149f8f169357e9f3e2bee2f3d5e273ac4c6b32ebeb0d7facca5fa9e18fc7d4a17a9623f3821c210bb200306027b37287a3c53bd6a5cf8bfbca3dd7a46432ebcb0dffaa45d7566cf8e33175a89ee5c8bc2047c8822c0098cc4c6626b37ed8f0bfd6b62c2d9f33e98387f317ee8bc7d4a17a9623f3821c210bb2003060273387ab99cc0672c31f63f5e3b77da0e18ffbd4a07ac6bc2047c8822c000c8a0669de8a0d352f4813cf351999ccfa45c3bf7b775af5f00d1f3c9cbf705f3ca60ed5b31c9917e40859900580013f99cd5e56fb2567fef8d43a9391c9accf37fcdbb6b4a5e7174dab780e7f3c16cf518bea598ecc0b72842cc802c0809dcc5eddba235d306359cd93d9b9772d4d9bded861423299f5cd8db3ddbbd3fa552de9e9d9ff5cb1d9cf473c279e6b6fbf7a9623f3821cc9822cc802c0809ccc76ecdc9d6e6859951d9236f3f19753eb8a7dcf578bdb710dda394fbf924d7a372f7821edd22099ccfa603d77b457dfde7ef58c79418e90055900185493593ea16dd8f2e7056662c1997c328bdbf9fdafbfb9d3446632ebb3f55ccb5efd6a7bfbd5a57a9623f3821cc9822cc802c0809bcccaad4c9b4f66569a3599f5977aee6ab39f0f75a99ee5c8bc2047b2200bb20030e02733c364a69e0df52c47861cc982210b002633c364a69ed5b37a9623438e64c19005009399613253cfea193932e448160c5900309999cc50cfea1939922364411680be21a574d0534f3d35f2965b6e69bafcf2cb5f1f3b76ecdb23478e4c279d74521a366cd87b63c68c79fba28b2e5a73f5d557cff8c52f7e7198df98c9cc64867a56cfc8911cc9912c18b230e0fbc4bf58b66cd9e85b6fbd75fee4c993b78e1b376e4f719ff8fdef7fffad0b2fbcf0c59ffef4a7b717c67ff11beb838dfef4e9d36fb8e4924bde1a3f7e7cfaf9cf7f9e1e7df4d1d4d6d69676edda9542fcbb69d3a6f4c4134fa4c21f3a9d75d659ef4d9c38b16decd8b1dff71b349999cc50cfea1939922364411654e5c06bf4efbefbeedb2ebdf4d23d9de913274c98f0d2e9a79f7eaadf601fd0dcdcfc9d42a3bffd9c73cec9fe48efbcf34eaad592254bd205175cf0ee983163569d70c20907fb6d9acc4c66a867f58c1cc911b2200bf4bcf18d2dedbfeff1d35a27edf37163cb1f2734b6fcf7729f77f1c577fdfbc2e36fe61f4f686cbdb442b33fe18753ef7f6ffcd4a6b4f8f1cef789e79f7ffe3ba3478f5ed9993e71c2d5cd9f297c6f4b3afbbba8f4330c7a77dd75d7efcf38e38c346bd6ac4efd014bcd9e3d3b9d7aeaa9bbbffffdef9feeb76a323399a19ed533722447c8822cd03b0dffe93f9ff51fc64f6b5e917f3c614ad3ff35beb17959275ee7cd9246ffa07beeb9a7e507ff7c55fad9af1f4c6fbfbda75b7de2a851a376f6f4defed29f81823973e63c3876ecd8f4fcf3cfa7fde1a5975e4a71eec60f7ef083f17ebb26339319ea593d234772842cc8023ddff08f9fda3cf1acc6d6f3f28fcf6a6cbe6ac2b49631d963d35a2e2adcff4661ec3e6b6acbd5d9e3d35aeb0b1fdf9abf463ef2667fdebc798f15dfbffbed77d26fe7ac4813af9b97cebbbe258dbde0f274f8e187a7fff89ffecf74fa65bf4fffe3847169c40537c50ee0ac065eddb23dfde8170fa5df35af4ce75c3f2ffda175693ae38c3376beb46ee30f0bafb7b130aebda669c7c3f13d64df5763cbfab3a6359f90bd5931b5e55fc74f6bfd76f6264663f32fe2f1c2683bebdad663b3ef77ca82bf9cd0d8b2a870dfcec2e78d2bf73350307dfaf43ba3d98f732df6a778bdc21f73d7f0e1c347f82d9bcc4c66a867f58c1cc911b2200bf45cc37ff1c5ad07c5defcf71be496b4f7df3571d87efebcb86f4263f3ff8c26f9fd37085a2e885300e2f6d8c6a6430bf72fcc9f1b7bf6f33ef1b2db1e496f6cdb9dee9eff7c9a72f33de9affffaafd3d78ef9c734e19a07d3c2850bd393cfbd92ae9cfe585affea9b69f1e2c5e9ca2baf4c471e7964faffbe3d2afdcb0db3d3f65d6fa7575edd9ecebd617ef67a679e7fd9ae7fbe69c14b675fdbf4c5f1d35a1aa361bff8e28bffdd59d7341d116f04c4edf81eb39f696af335f10645dcce9edfd8b2f6fd37049a7f93fd2c85c63fdfab5ffa330c7a0f3cf0c03f8c1e3dfabdfdb567bfdc9efe912347bed9d0d07088dfb6c9cc64867a56cfc8911c210bb240cf34fcb1273ff6e2177f5c68a42f7bbf396e397def1ef5b67853a0f0bc9fef7ddeadb1973f6e47537dd6b496ff3f6e3ffae8a3a3e274efe813db366f4b8dfffa44b620df59d7cc497ff3a5ff9a0a7d64b6b73f1af830e7b197d282a56b3fd00f5e7e4b73faef7f7f7cb682ff8e1d3bd3f9372ec8eebf6bce92f4fdf3afdc197d62d6d8dfd2fa17f175c75cd7fa7f143ede3ea1b1f598587b60eff7b8bd78cf7dece9cfef2ffd3d14ff0c144c9a34695b9cb3df930ac5f0eef0e1c317fb6d9bcc4c66a867f58c1cc911b2200bf44cc35f18cbc736deff1f8b3e7ef687d736ffd5de8fdf1edbb8e0537bf780af1e3fa5f5cb7bef9f3da1b1e96b7b6faf8e7f6335feb8625bde27cefed3ea34e74f2fa4638f3d368dfdd90369e9b36bd2bbefbe97e63df57276a87eb8e5bea7d38ad5afeed307bef7de7be987d7b6a696c7dfffdca1675e92feb5f5cfcfffedefe7be3574e8d047e23483d8b3bff70885f171f8fe84c6e6c913a6359fb1f7fbda1c7bf6cbfcccdbcfbe6efee7e210ffc2ed3f15ff0c14dc76db6d536235feb7df7e3bf5b4b163c7beded0d030cc6fdd646632433dab67e4488e90055960ff37fcf9defcfce3098dad77157d7c6d34fde31b5bef8dc3dff3c3fcf3dbef37db2d6d7198fccc99337f5bdc27fef4b77f4a234e39231d73cc31e94fcb5f4e937eb5283b877f7ad3ca6c2f7fb8e8970fa55fdd7ccb3e3de0732fbf9eee6c7936fbfc78fef7ceb93a35340c697ffe9e77de4d63c68cd97057f38a6bde3ff2203b47ff577bf7f22f89663ebec738a73fceeddffb786bfe6645bc2190dd37ad7945bc9151fc33a888bab804c3c53be2d27bbd61d9b265c95e7e9399c90cf5ac9e91233942166481be2bf6ee5f7ae9a57b8afbc4e9d3a7a7430e39246ddebcb962bf377ffefcecb0fd871f7eb8fdbedfcf7f3e2d2fdaebbf6ddbb6f4a52f7d297bbddcd2a54bb3bdfc453deabf8b863e8e56f0d7e886c21fe41f620186ee5c7eafb34e3bedb4d70a45f079bffdf21a1a1ae616c6ff6b323399a967433d234772842cc802072247cb962d1b5ddc27eed9b3271d7cf0c1d939fb95ecdebd3baed096860c1992ce3cf3ccf62303aeb8e3b1f62300725117f17af1bab951a3466dc8fbc4bd7bfa37e62bf1d34537de78e3cc5ffef297a9375d7ffdf52f16fe9013fdf6cb8b77c4624418ebebeb8f349999ccd4b3a19ee5488ee488039385c71e7b2c7ded6b5f4b1ff9c847d2473ffad174d45147a5458b16658fc54ed0183d513f955e3bbfbf74ecefaf230b7274ebadb7ce2fee13e3eff8e52f7fb96a9f3763c68c3474e8d0144705c4bf3367ceacfafc58bdbff80d842953a62cd127ee67975e7ae92b8f3efa68af36fc8b172fde55f843cef2dbaf1ec2a2f140b977e16cd8d9b053cf867a962339922359e8d92c7cf18b5fcc1ae2382df5c9279fcc6e7fee739febf1fae9a811df5f8dba865f8e2ae568f2e4c95b8bfbc4d8635fe81d2bf678afbdf65a1a316244baf5d65bb38fe3df912347a62d5bb654fc9cb864dfa9a79edafef1c30f3ffc923e713ffbc10f7eb06bfdfaf5bddaf0c7f5160b7fc8757efb3587b0fd5db8e230dab0b361a79e0df52c47722447b2d0b35988bdfad1103ffbecb3559be5175e78211d71c411e9c31ffe703af1c413f7792cbf3d71e2c4f4b18f7d2c7dea539f4a37dd7453f6589cef7ce8a187669ff7e94f7f3afdfad7bfee72c35fe9b5eeb9e79eec7ce9b83f7e9eaf7ffdebd9f75bfa3a575c714576fbc20b2f940539aa1b376edc9ee23ef1f0c30f4f0b172eacd8e35d77dd7559f3be7dfbf6f6f3f44f39e59474e38d3756db119cad0990dbb061c3a6c2f7b2b6f8fb8d4b07965b999f1a8d1831e2ddb88e626f8aaf57f843eef6dbef5c088bdf858bc36f6cd8d9b053cf867a962339922359e8d92ce44d7034ea63c68cc9f6f4976bbabff18d6f64b7e310e638acb95cc31f8f2d5fbe3cbbfdc94f7e327b2c1af4386d60eddab5d9fd9ff8c427badcf0577aadf8373e5ebd7a75f678dc8e37278a5f279ab2f877d4a851b22047598e62ef7c719f78d04107a54a7d63bc81d4d0d09066cf9ebdcffdf7df7f7f76ff4b2fbd54f6f3e2fcfdba6c7dc07dfac45df9f79a2ddcd7d8b2d35fad9b7ff003a18642333a1836ecfad65093ea593d1b7d61a85f3932f6ff9c12e7ec47f3134d7f3427f1264069d31de7f8c7ed685862946bf88b9bf50f7de843d9ed68c2cf3befbcac01aff639b534fc955e2bd61d88dbb187ff9bdffc66b6273656592fb726c0d4a9536561908e53cfb9228dbb7a763aeb9ab9e9b4f3a766f7bdb16d77fad12f1e4abf6b5e99cefcd90369c1d2b5592f577cff39d7cf4be75ffef374f6d967a7ed3bdfbfff5fe73d97ae99f178bafdc167d2f8a94d69c235b3d353ab36b6f782f19c77de7937addbb42dd59f7d6d76df838fad4ee7dfb820fbfa674d6db93adbbb3fa5f5cb131a5b16e9dabb61f8f0e1ef1ca03dfcbbfcf63bfdaedbe2fafafa638f3efae8831cba694f8e7a36d4b31cc9911cc942ef6621df731ecd7d771bfefce3389c396ecf9a35abdb0d7fa5d78aef277e27e3c68dcbd61f88fb636d82e2d789f3b3e370ff38f45f16066f8e0aadda770be39bb1577dc48811efcd7ff2a574ddef9f4adb77bd9dfef3670f4ee7de30fffd73ed9f6e6bbf7f76cbc385267d4eb6c6455c7aefcae98fa54d5b76a4bbe73f9fe62f599b1d5572f2a963d379d7b7b6f783bfbaefe9f4d2faad697ad38af437ffcf3f14b78a1bbff783f3decaf7ea9f35adb5be70fb567fb56e183366ccf6de3e877fe3c68d3b4acfcda06a08f799c472d526b36a2bca561b71ee579cd7556d62a92b5911b696d56bcb7d5eb9db311e79e491ecbef8b7aec2eab3871d7658fbfdf16e762d2bd796be4e1cbaf6852f7c217bb73b2e09929f4b57fcce7b4cecb52e686332ebb97ade1f8b11d5756225e3d21cd4ede7058d7afaf56d9cc95157571c1fecf343b5fb3ffef18f67cdd28e1d3be46890cd2979131df5fcf8e38f976d96e3f671c71dd77ed8fe9d77de5973c39fbf51902f08d89d86bfd26b7df5ab5f6dcfd02bafbc92ddfecc673ef381d719366c5876bbb5b5d59c32c87234bde5856bcfbd71d1c6f72f85d7bc6cfcb4969f8f1d3bf6adebee5e9c9e5df35ad6c31d71c4ff9d265edb92ddfee51f9765f7c765f7c68d3b2b4d983a37bb7fce632fb51f05107bfef7bcf36e76fb92fff59334bef09cfc127cf73ef46fe9b115ebd3f937cc4b871efa37d91b08b1d7ff5f7eb968cfb82b67be1d5f3fbed7f1539baf9930adf90c7fb56e38f7dc7397f6f62afd858d86c7adbe5853081f696868f876e92456cb64d6d51565ab4d2e951eabe56b95fbdc4a1b55575d75d53ee7cc957e6e3ed9d6159d7356cbf75a7cdf1d77dc91dd8e854562e36df4e8d1d9c73141173fb7dc217b26b3deafe7de5e7db8a71bf0bed8e0abe7c19323f343f5af57e9fe6baeb9a67dd135391a5c73ca92254bdadfb88a9d01f1c655fee653718dc41b4c71c9b2784e6c5fd4ed3d84bea3863f0eaf8fd78e73e7bbdbf0577aad356bd6a4ef7ce73bd91b6ff13dc521fff1265ee9ebdc77df7dd9ed5874d09c32b8725468f4df1edbb8e053631b9b0e2ddc5e1d87d2373636ae3a7b5a4b5af4f4baf4de7befa57193ae4be75ff99becf60faf6dcdeebff7de7bd369e75e957e73ff93599f77cb7d4fa715ab5fcd6ec7e1f96b366c4defbefb5e9ad9b2348dfed1f5d9d127e1c9e737664702fc68caefb2bcc4eb6ddbf9765abb79fb82095367ef88af1fdfeb59d35a7f7ff6d4967ff057eb861ffde84757145f5fb1374c9e3c79a1eb2b560d61d977ab3b3399555b5136ced91a3e7c78fb1e97ef7ef7bb69ddba75edef0ad7b2e153ebd7eaec065dbc8bfead6f7d2bbb2ffe8dc5674a3f37f6b0c4c7712e5da549a9a3af97bfd39daf501b93747c1cf7173fb7f037d0f0f7817aee89e6bad28ac5e57250eef657bef295ec7363afdfa44993b20da9f8dc5815f9f6db6fafb85a7247af1f97b48937a0e27b8ae79e71c61969ebd6ad1daef2ace197a35a73647ee85ac31fab4dd775f2726c7234f0e6946a23e683c2366eb62321e693a89738e2c4e92db2d01f725468f2af8da67f7c63ebbd857fdfbcf8e2bbfefd830fafb8ffc7d7ff21fdf4b77f4a13af9b97a6fca6a9b0fdf3dfd2732fbf9eee6c79365dfe9b47b2f3f32fb97e66763e7eb8e8970fb5efd55ffa6f9bd2a45f2dca3e777ad3ca74fd8d37656f46c576cd2baf6e4f85af93fec7ff3c363df0c003d939ffd1f44ffaf9dc8d13a635ef8eaf1fdfd784c696d72fbea5f52ffcd5ba61e8d0a19f1d3366ccdbefbcf34eaf35fcc3860d8beb2b7ede6fbf7baa4d66d55694cd3784626f4bbc6b1db76365d95af7e0946ef455fb5a9ddda08bcf8f0dcb982ca3498a8feb4ace418b26e72ffff22fe3b21dd9fdb14119f777e6ebe51bafa58fc76b959ecf567a589cc9acf7ebb9270ee9af65c5e26ab57af7dd77b7bf51142356645eb56a5597565e2efe383fda248e42c957798ea6bfa3559e6d9c516b8ecc0f95bf5e5d07a78215efb195a3c139a7541bf17f7334f8c5a7b0e4470268f865a13f6a7a3edd32f6fc9fbc97f78971387e9c063be5b6b9d9b9fab1d3f87bdffb5ed6c0d762cb962d69c48811e957bffa55f671d445bc5e7e987f2cf53664c89017f4893da0d0d42c7fe289277aa5d95fb0604153e18fb8d06fbde727b34a2bca96eea9a9abb0f84c670ee7acf4b53abb41973738b1c7346f6c8a9f174d56dc8e1568e3e3d8cb1a1f97fe2e3afa7ab1c1564bc31fcd5aac38aae1efff0d7fe9fdb5ac585cad562bbd7e5dc9e19db5acbc5cd7c1a24f95f25957b4cab38d333a9323f343e7f7f06bf8cd29863965b019dfd8b2e4d2cb26bf58dc274e9f3e3d8dfa97dbd2e34f2e4985e63c5d72c925d9dfb7d611ff87c7e73df7dc73d99196f17ab9071f7cf0767d620f897337264c98b0ab17f6f2ef193e7cf8b2c2d71be6b7de7b9359e98ab2c50dc5fe3847b3dad7eaec065decb98906261692898daaf8b8f879fff88fff58764f4cbe8157ebd7cb1bb0d84b1a1faf58b1a2e21ede38d45bc33ff01afe5a562cee6ec35febcacbc51fe787401737fcd128d5f2b56d9cd1d91c991f3a7f487f1cb923471a7ec39c32589c72ca2927fcf0873fdc53dc27c6e28efff44fffd4ad4b001e7ffcf1a9e4f2f05b860c19f2a43eb1078d1a356af1bdf7defb6e4f76fb37de78e3cc78d7a6a3f3aee8fe64566d45d978572d3e8e737ff3c3d563319a782cdf031387e6d4721864475fabb31b74c50d76e9f9f37188666cecc5b9d2f96bdc7cf3cdd963b1484e5716ed8bf388e2e37c719bb8bff4b93ffef18f35fc03b0e1afb66271690ebadaf0575a2db9daebe78754171fd21f872e6bf8d95f39323f74ade18fdf49dcbef0c20be5689037fc75fde0ea2f7d6d215959e8df468f1ebd2c5f6c2fbfc4fab1c71e9b8e39e698ec30fdce88374ff3cf2dbe34fc95575ef94b7d620f8b7325bef7bdef6d7bfef9e77ba4d97ff6d9671717bec6fa86868643fcb67b7e32abb6a26c6c184553912f0a16e767c6eaadf906529c131c9f932f3cd6d10457ed6b7565832e6fb02fbbecb27d1e9b366d5af6ef45175dd4fe1ab11054fe78fe33d4ba41171b6f71de50dc1797e72bbd2c5ffedcfcbc6c0d7fff6ef84bebb6da8ac5a539e86ac35f69b5e46aaf1f8bf6c56ab5f17931a2d92f5db44fc34f7772647ee8fc39fc757b2fcb377efc7839d2f00fb8abbf68f8a9a54f2c6ccbec2cee13a3598f3dfdf1c66e2cba578ba883388c3ff6ec1737fbcb962dbb479fd84beaebeb4f3aedb4d3dedcb469d37e6df65f79e59567860c19f2b24334facf646698ccd4b37a56957264c8912cf4cfabbf54bae246fe66581cf912f797be212d0b545268ee878e1e3d7a47699f18e7e0c70eb4a8a94b2fbd342d5cb8b0bd998fc5f8162f5e1c7befd391471e993daff89cfd50a8cb870a7de21a7d62efbe8333f294534ed9f2fcf3cfef9713fa57ae5cb9289afdfafafaf3fd766dd8d9b0433dab67e4488e18080d7f5d1fbefa4bb52b6ec42931757b17be8c372934fcd46ae8d0a1a34e3ffdf40f1c111e8d7dfc8de3ea56871f7e783ae8a083daeb2a9afc3872318e02285a8dbf7dcf7e34fbfac40320f6f417fea05b0afff16ceec6427ebbaebbeebabbe2f08c7813c16fd5869d0d3bd4b37a468ee48881d2f0f7e5abbf54bbe246b9abc168f8e94c9f386cd8b0ad7ff8c31fb677a34fdcf2b39ffdec167de20116e76a0c1932a4e9b4d34e6b7be28927b6766625fed6d6d659279f7cf2e3b1f08273316cd8d9b0433dab67e4488e18e80d7f5fbafa4bb52b6e68f8d94f7d62f3e8d1a3373cf9e4933b3bb34378ce9c39d3870d1bb6589fd8b7fea0c747e33f62c4888d3ff9c94f962c5cb8f0c5750585ff20b2633276eedcf9eafaf5ebff6ddebc79cd975c72c99ca14387be187fc078b7c62a8b36ec6cd8a19ed5337224470c8686bf2f5dfda5da1537e2d0febabd87f4e75783d1f0d38d3eb179e4c8919b264f9efccc430f3db4a6adad6d7d7e0e7fa14fdc50c8c2734d4d4d7fbcf8e28b1fd027f671853fd0671b1a1ac617fe40330a637561ecda7b1dc5f8776d61cc2a8c89f18e8fdf960d3b1b76a867f58c1cc9911c0de486bfae0f5ffda5da15376221c1c30e3b2cfb1ee3dc6a0d3ffa44b0616798ccd4b37a468e0c3992054316a84934fc7e0b60323399a19ed533722447c8822ca0e1074c662633f56ca867e4488e90055940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b3a19ee5c89023593064010d3f98cc0c93997a56cfc8912147b260c8021a7e309999cc50cfea19399223644116d0f003263393997a36d433722447c8822ca0e1079399613253cf867a468ee40859900534fc6032334c66ead950cf7264c8912c18b280861f4c6686c94c3dab67e4c89023593064010d3f98cc4c66a867f58c1c1972240b862c68f8019399c90cf5ac9e912339421664010d3f60323399a967433d234772842cc8021a7e3099192633f56ca8673932e448160c5940c30f2633c364a69e0df52c47861cc982210b68f8c1646698ccd4b37a468e0c3992054316d0f083c9cc64867a56cfc8911c210bb280861f309999ccd4b3a19e912339421664010d3f98cc0c93997a36d433722447c8822ca0e1079399613253cf867a9623438e64c1900534fcd0873537379b44faced85598ccf6a84af5ac9e9123438e64c190050dbf861fba6dc18205eb376dda6422e903a3adaded7785c96ca5aa54cfea193932e448160c59d0f06bf8a1db5a5a5a8e9b376fde1b1b376edc69423970ef5ac744d6d4d4b4a6308e5795ea593d2347722447b260c882865fc30ffb45e13fd063e7ce9dbb380e958af3a38c5e1ff17b5f692253cfea193932e448160c5940c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e1070000000d3f000000a0e10700000034fc00000080861f000000d0f0030000001a7e000000d0f0030000001a7e00000040c30f00000068f8010000000d3f00000068f8010000000d3f000000a0e10700000034fc00000080861f000000d0f003000080861f000000d0f0030000001a7e00000040c30f00000068f801000040c30f00000068f8010000000d3f000000a0e10700000034fc00000080861f00000034fc00000080861f000000d0f0030000001a7e00000040c30f0000001a7e00000040c30f00000068f8010000000d3f000000a0e10700000034fc00000030109afb59d1e0773016fb4d01000040ff6af80f2f8c3dd51afefafafa63fda6000000a0ff35fd0f5469f81f39fae8a30ff25b02000080fed7f01f5ea9e16f6868f8b6df10000000f4dfa6bfdcb9fc8beddd07000080feddf07fe05c7ee7ee030000c0005068f067dabb0f00000003afe13fb2e8dcfdbff71b0100008001223f97dfde7d00000018580d7fb662bfdf0403464ae9a0175f7c71c6a38f3efa6e7373739a3b77aed1cba3a9a9292d58b0e0d5c218a622e5c89023593064418ee4488ed4aea176d92f22940b172e4c9b366d4a6fbdf5967180c6e6cd9bd3fcf9f3b716427abcaa9423438e64c190053992233952bb86daa5dbe21d38a1ec33e17c6beedcb92b55a51c1972240b862cc8913a9623b56ba85dba2d0eb7118abe330ac1dca32ae5c89023593064418e0c3952bb86daa5dbe25c0f81e853c1b448881c1972240b862cc89121476ad750bbf46e30d7bfbe3d9d3d7d4936e2b620092672244774250bdbdf589f5e5c7c4b7aa6e9926cc4edb84ffdca02e614393207186a975e0ae6eedd6fa5d7dedcd9fef182951bda2795b89ddfbfe98d1de98d6d3b054b30e5488ee448163afcfb6cdbd296963f78515a7adf39fb8cb82f1e53c3b22047e614393207186a971e0e664c28b72f5a9d2e98b12ccd79fa95346fc5fa74d1ef97b74f2a713beebfefa975e9fcc273ae9efd5cdabaddc4229872244772240bd5ff3e6b9fb9f7031b7af958f7cc2c352c0b72644e91237380a176e9e960beba75473aefae65ed93484763e2ef96a6b5afbe295c822947722447b25075ac6cfd69c58dbd784c0dcb821c9953e4c81c60a85d7a2198f72f69ab7952b9eb4f6b044b30e5488ee448163afcfb2c9f7b71c58dbd784c0dcb821c9953e4c81c60a85d7a219871a8583e699c73e7d274c7c32fa51736bc918db81df7e58f3fb0d43937822947722447b260634f1630a7c891da3507a85dfa74306395d758f8a5f8bcb098444a9f17f7159f37169f638558c1942339922359a8366245e64a1b7bf1981a96053932a7c89139c050bbf46030cb1d1616ef1c973e2fee2bf75c01134c3992233992854a63d5a26b2b6eecc5636a5816e4c89c2247e60043ed6252114ce4c890a37eb8b1f75adbb2b47ccea40f1eca59b82f1e53c3b22047e614393207186a971e0ca6c3c604133992237a6a632fc6eac76ffbc0c65edca77e6501738a1c99030cb54b2f0573de8a0d352f0c13cf152cc1942339922359e8f06fb47b775af5f00d1f3c94b3705f3ca68665418ecc2972640e30d42ebd10ccd9cb6abff4cb1f9f5a2758822947722447b250f56fb36d4b5b7a7ed1b48ae76fc663f11c752c0b72644e91237380a176e9c160beba7547ba60c6b29a279573ef5a9a36bdb143b804538ee4488e64a1ec1e9df5ab5ad2d3b3ffb9e2865e3ee239f15c7b7a64418ecc2972640e30d42e3d14cc1d3b77a71b5a56658786cd7cfce5d4ba62dff3c6e2765c0b76ced3af6493cfcd0b5e48bb045330e5488ee448163ab947c79e1e59c09c2247e6007380daa5b7df89db3bb16cd8f2e7855e62e1977c5289dbf9fdafbfb9d38422987224477244d92cd4b247a7da9e1e352d0b72644e91237380a176e98149a5dc0ab1f9a462c557c1448ee4885ab2d0d50dbd7ca869599023738a1c99030cb54b2f4c2a8660224772842cc802722447a85db58b601a822947861cc982210bc8911ca95d43ed22988660ca912147b260c8027224476ad750bb08a6602247861cc982210b7264c891da35d4eed0a1433f5b5f5f7fe649279d34a3305615c6b6c24885b1ab3056171e9b59f877623c4f300dc1448ee408599005e4c89023b5ab76fbb88686866f17c6dcc2786b6f835fcb682d3c7f98601a82891cc911b2200bc8911ca94ab5ab76fb9842d3fef9c278a0134d7eb9b1f084134e3858300dc1448ee408599005e4488e50bb6ab70fa8afaf3fa9a1a1e1b5e2e67de8d0a1e9f2cb2f4f2d2d2de9e5975f4e6fbef9660a3b76ec486d6d6d69d1a24569ca9429e9e4934f2e6dfab70df4bdfd822998c8911c210bb2801c1972a476d56e7f68f68f2d34e8ef1437fab7df7e7bdab46953aac5962d5bb2e7c7e71537fe85d73c55300dc1448ee408599005e4488e50bb6af7c0edd96f6ff6cf3efbec6c6f7e57c4e79d73ce39a54dff30c134041339922364411690233942edaadd5e14e7ec171fc63f69d2a4f6c3f6bb2a0ef7bfecb2cb4a0fef3f44300dc1448ee408599005e4488e50bb6ab797c44afcc57bf6bbdbec1737fd257bfa170aa62198c8911c210bb2801cc9116a57edf64eb3ffede273f6bb7a187fb5c3fb8bcfe91f6887f60ba660224772842cc8027264c891da55bb7d7eef7e2cb8d713a64f9f3e60f7f20ba660224772842cc8027264c891da55bb7dced0a1433f9b2fd4177be15f7bedb51e69f863f5fe924bf67dbed2f75478ecf0fafafa998269f44430fb5b7d99e00c399205431690233952bb8686bf4b0ae13a336fc2afb8e28ad493a64c9952dcf04f2c17f6c29855187be2398331988f3df658fadad7be963ef2918fa48f7ef4a3e9a8a38e4a8b162dca1e2b7ca96cf44431577aedfcfed2b1bfbf4e6f04b3bfd69709cee84b139c1cc9822cc8821c1972d43f6ab778db3d7a8bc30e3b2ceb350e545fd197fb8701ddf017c235236fc2e7cd9bd7a30d7f34ae450dffac4a61cfc7600ce617bff8c5aca0972d5b969e7cf2c9ecf6e73ef7b91e2fe68e82b4bf8276201afefe5e5f2638a32f4c7072240bb2200b7264c851ff6cf8e3766b6b6b763b9afe03dd446bf87bbfe15f95876c7f2fd657aaadadadb8e15f5b5f5f7f641cbe531af6c1dcf0c75efd28e8679f7db66ab1bff0c20be988238e481ffef087d389279eb8cf63f9ed891327a68f7dec63e9539ffa54bae9a69bb2c7e6cf9f9f0e3df4d0ecf33efde94fa75ffffad75d6ef82bbdd63df7dc93bef4a52f65f7c7cff3f5af7f3dfb7e4b5f278e2889db175e78618f0473a0d49709ce3890139c1cc9822cc8821c1972d4ff1bfefce3d83e2f7daca3fea05c4f51cb631d3daf5a3f53eee738f5d453b3dee2cb5ffe72d62bc591d0f98ed2785efc1b1f7ff5ab5fd5f09734fcdbf290edaf4bf155bb445f51a8dfad14f6c1dcf0e74d700462cc9831ed055c1a9e6f7ce31bd9ed993367a6193366940d563cb67cf9f2ecf6273ff9c9ecb108731ccab376eddaecfe4f7ce2135d6ef82bbd56fc1b1faf5ebd3a7b3c6e47988b5fe7c61b6fccfe1d356ad47e9f54f62e10396ba0d49709ce38501b6772240b8639458e0c73cac0dac31fcd72e9631df507e57a8a5a1eebe879d5fa99723f47ec548c11b76387e21d77dcb1cfcec30b2eb820fb387f4341c3ffe786bf3d64bda15ac8fbf3d89fff29c6a90f23478ecc9afe28da7813a0343c711e4edcdeb56b5736ca05ab38241ffad087b2dbd1849f77de7959035eed736a69f82bbd56fe6e5bbc5bf7cd6f7e335d77dd7569f3e6cd65d704983a75ea7e9f54066a8d0d8661a3a8cf6d9c19b230e8877a9423c39cd25f6bb7789b3b7a8168ec172e5cf8816dfb5afb83e29ea2d6c7aa3daf5a3f53eee7287e5e7c6edcfecc673e93feeaaffe2a7bde17bef085eccd846ddbb669f8fbc81efe5d279e78e231857f1fb187bffcc8df658b82ee6ec39f7f7cc8218764b767cd9ad5ed86bfd26bc5f713bf9371e3c665eb0fc4fdb13641f1eb9c79e699d9213971e87f4f1d363650eacb3bdac6813cfc528e64411664418e0c391a1887f4577aacd6fea02b8f557b5e771afee823e2b1499326651f5f75d555d9bfe3c78f770e7f9986ff809dc39f7f0f0d0d0d7f5ff878a186ffcf818bc36a1e7ffcf1b2cd72dc3eeeb8e3da0f81b9f3ce3b3b1dac7c41c0ee34fc955e2bce9b89db8f3cf2487ae59557b2dbf1ee5be9eb0c1b362cbb1d8718f56430fb7b7d0df609aeda952baa8d381f2d0ef7aa76fa4cbc131c47a27cfce31f4f43860c695f6b22469c76923f7ef0c107ef737858f13be651e7715ffc5b5772258bba2eae8e5b57e1ca187555ae9a51cbfdf173c61b71f1e6ab1c0dac39259f3be270c9f878ce9c39d9c77184557c9c1f461935dd97174bea28b707e2fb9585c1d734f5c4bc53faff72ece18c1d3bb5d46c67f35debfc158fc736667373f307be8fb84c773c16f3c68a152be4688037fcb5f607fbbbe1afd6cf94fb5e6fbffdf6f63725e228e2786cddba75592de7a714e739d1f0efdbf01ff055fa737bdff55b38981bfe254b96b44f323119c424933714752587dec43938f19c58c0a2aec2221ca51fc7e410af1de7ce77b7e1aff45a6bd6ac49dff9ce77b24932bea7383c2826c1d2d7b9efbefbb2dbb148476f04b3bfd6d7609fe0ba7ae58a6a351db51b8ffddddffd5df64e717e3e58be726d7e4e58642b9ae3d1a347671fc76454bac114ef2817afbf5129579d591db72b79ec68928cdbd75c734dfbc2397234b0e69458f3a5aee814b03834333ece0f0dcdf77c444df7e5867f7f7cad9e6ef86561e06f9bf5c4bc536e6e2877ca6677f35debfc15b763d1b3b81d6f28943e16db71713bceab96a381dff0d7da1fecef86bf5a3f53ee7b8d7a8ec7635b6ad5aa55ed8f0f1f3e3c7bfce8a38fb64a7f39f5f5f567e6218bff487ad29429538a1bfe8995bea7bdeffa3d32188359eb88775c274f9e9cfd671e7b258b1b09878d550f667fabafc13ec155bb7245ac0d11ffc9e77b61befbddef66eff4e6ef54579ae86272c9df512ef735f3a354f23dfe3121d515adfa9abf6e6c247deb5bdfcaee8b7fe3dcb88e26b94a6fccf546c31fe7b4d5bae12a47fd6b4ec9173bcaf72e7ee52b5fd9e7e8aa78732bdfe88f3d77b1d1149989ac9c71c61969ebd6adfbd44bbc4ee962ab1d5d5da596d72db74a73e951637535ac1cdd9b57839185c1d734f5c4bc536e6ec89b938efecfef4cbe6b9dbfaacd4bf91b0871faa56db3c1d1571ca8d1dd7e2676da4426231b7545475d6af84b0c1d3af4b3f98a9985dbd984dd13b66cd9924e3ef9e4e286fff382d9f5118d4a04a2f870b39e28f281d8f0d3bf7254edca15b1b865ddde43d0e2e898b81d2bbe76b401151b37f158de8c948e7cc3ad74632d3f5f2c7fedf87ee2b93151c56be67b61aaede12fb73a6ead87f4d7d2f0573bcaa074e34e8e06ce9c126fe6c41e9218719455fc9df33d74b11724fee6f1586c18e57bfc624f60de4844735e5c2f71886f9c92d599ababd4f2bae55669ae56db7de16a30b230f8b6cd7a62de29f7ff7234d4a587507737dfb5ce5f713bffdaa5479ee5238e0ab36da6e1efcbfd4ccc05f1b971544efe86b0bea2f2bb6a73f3463cce8de8097b2f6b938f85826968f8a9354795ae5c51ba47a5aec22297a523368ce2b17883b3da1b021d6d30e54d4dbe604c4c5c7515ce9fafb63a6e6fede1d7f00fec3925bf424a3402f1378ebd8e51777b0f936d6f88cb2d92549a9bb8bfd29b4995aeae52cbeb965ba5b95abdf685abc1c8c2e0dc36dbdff34eb9b921deac3afbecb36b3a0da5d67cd73a7fe523de842e3d7534e6aa380a27ceffb76da6afd0570c9c86ffdb79331e7bf9f7f7e27df17af1baf9d7287cbd61826908269dcd51e9952b8a1b8cce34cdf16e725d9543faf3e6225ff825162c2ab70731f6ecc706571c56191b59f1715d8d6b63d41dc043fa63634e8e06de9c72d14517b5ffbdf3c58ce230c7bc0188c6a2f870e5e2c63c9a9a8e6aaba3abab74e6756b7d83aa2f5c0d461606f7b6d9fe9a772acd0df9a1c81d35fcb5e6bbd6f92b6e474622a3b1a652f163b1e73f5f27207604da36d357e82b06884223de9a37e4f19fc6feba445f6c004f9c38f1bde2bdfb471f7df44182d9f1e164d55610ef2b0b27756745e5ba1e5a08caa432b07254edca15918bf838ce05ce0f4d8c452fe3b17caf4c1cb65fba61961fea1be7ddc76377df7d77f671be37235ff4283f14385fc426eeafb4b156ee5cccbed6f0c7efa9aec6f399e5a8ffcd2971187efef79e366dda0716938ca6b9f890e4e243efe3b0e55a6aabdad5553af3ba95eab534b77de16a30b230f8b6cd7a62dea93437fcf8c73fae697ba8d67c7766fe8aef317eae38bd267f63237f2c4e15a82b3a0dcdb699865fc33f301afecf17c6e6bc318f4354bbdbf447b37fd96597151fcabfada1a1e110c1ac3e3a5a41bc2f35fcdd69da35fcd492a36a57aed8b06143d664e48b84c57994717e633c76f3cd37671b31f139e5f650c4c65a6cc8142ffa557cde583c1e6f00d4edbdd451b9cb1a156facc5ff755d69f8eb3a7189bdee9cc35fb7f7b27cb55e9f568efadf9c12f345be973dbfdc579c7b5cb7f7d0f7fc728c712a4bac861c9989114d79e9e27a95eaaddad5553af3ba95b2519adbbe70351859187cdb663d31ef549a1bf2c6baa3eda15af3dd99f92b3f873acf48e963f1b3d5ed5dd3c3b699865fc33f40d4d7d79f942fe097efe9efeae1fdf179257bf607dca1fc3d15cc8e5610af6525e458c1353f3a20debc890da3786eac729c4f42f973f3892bde50c857a42dfe4fbf332bd2567a6e7ef997f8d9e2fed28d37c1c404678243166401399223b53bb75777eed5d23354ba624a5d952bb054fa9c386239dea48dfb4bdf68aad647d495b98a8cdaedfa9efe91c54d7f9c7b1f7fec5865bfd6d5f86381bee273f663d4d7d79f2f98b58d8e5610af6525e4384439bf144bdddec5c5f27791f395918b9f9b1f45f0b77ffbb71f68f83bb3226db5e7c621cff91b19f9d7d3f063e3ccc619b2200bc8d19f17bf2c37e448edf654c35f4bcf50e98a297555aec052e973f22347e273f23ea6333d47f15564d46e37f7f417c696e2863d1af8385768debc79d9defbfc70ff3884a8adad2d5bcdb4b1b1318d1831629fbdfa71187fbc892098b58f8e5610efec4ac8953eae2b5a8db9daeb746645da6acf2df77d6bf8d1e4d838431664013992230e4cc35fcbc795ae985257e50a2c953ea75a3f504bcf516ec14cb5dbf53dfd9f2fbe5c5f17c7c28178ce7e4f07b3a315c4bbb31272470d7fb9ebb4766645da6acfd5f063e3ccc619b2200bc8911cd1bf1afe4a574ce9cae7d4d2f077f62a186ab7fb8dfff17b1bff3d9d69f463affe405b8dbfb782d9d10ae2dd5909b95c486fbbedb6f630c6d72c7d5e6756a4adf6dc6a87f0082636ce6c9c210bb2801cc991daed7b0d7fa52ba674e5738e3beeb8f67ee0ce3befacb9e7d0f0f782a143877eb6d0f88f2f34f2330a637561ecdadbdcc7bf6b0b6356614c8c230304b3fba3da0ae2dd5909b95c48e3fcff38fc260eb989c36f4a9fd7991569ab3d3716e988a317e2678aef5fc38f8d331b67c8822c20477244df6ef82b5d31a52b9f13bd46f438d13be4fd40f4061df51c1a7e4c2a7de8b27826156c9cc911b2200bc89121476ab774c4d500264f9e9cad03173b03eb7af9d2e36a974115cc81b2f2ab60ca912147b260c8027224476ab7ef8f38943f1afcfcd27b471d7554fb51cc6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176114cc1448e0c3992054316e4c89023b56ba85d045330912339421664013932e448edaa5d04d3104ce4488e900559408ee408b5ab76114c4330e5c8902359306401399223b56ba85d04d3104c3932e448160c59408ee448ed1a6a17c1144ce4c89023593064418e0c3952bb86da453005133992236441169023438ed4aeda45300dc1448ee408599005e4c89023b5ab76114c433091233942166401399223d4aeda45300dc19423438e64c19005e4488ed4aea176114cc1448e0c3992054316e4c89023b56ba85d0453309123438e64c190053932e448ed1a6a17c1144ce4488e900559408e0c3952bb6a17c134041339922364411690233942edaa5d04d3104c3932e448160c59408ee448ed1a6a17c13404538e0c399205431690233952bb86da453005133932e448160c599023438ed4aea176e9587373b340f49db1ab10cc3daa528e0c3992054316e4c89023b56ba85dba6dc18205eb376dda24147d60b4b5b5fdae10cc95aa528e0c3992054316e4481dcb91da35d42eddd6d2d272dcbc79f3ded8b871e34ee13870efc045289b9a9ad614c6f1aa528e0c3992054316e4488ee448ed1a6a97fda2500cc7ce9d3b77711cf611e77a18bd3ee2f7be5228e5c8902359306401399223b56ba85d0000000000000000000000000000000000000000000000000000000000000000000000068cff0dc2a0a6105799a6d20000000049454e44ae426082', true);
INSERT INTO act_ge_bytearray VALUES ('5250', 1, 'process.bpmn20.xml', '5249', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e61637469766974692e6f72672f70726f63657373646566223e0a20203c7369676e616c2069643d227461736b457374696d6174656422206e616d653d227461736b457374696d61746564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c7369676e616c2069643d227461736b436f6d706c6574656422206e616d653d227461736b436f6d706c65746564222061637469766974693a73636f70653d22676c6f62616c223e3c2f7369676e616c3e0a20203c70726f636573732069643d2270726f6a6563742d776622206e616d653d22d098d181d0bfd0bed0bbd0bdd0b5d0bdd0b8d0b520d0bfd180d0bed0b5d0bad182d0b02220697345786563757461626c653d2274727565223e0a202020203c657874656e73696f6e456c656d656e74733e0a2020202020203c61637469766974693a6576656e744c697374656e6572206576656e74733d225441534b5f435245415445442c5441534b5f41535349474e45442c50524f434553535f434f4d504c455445442c54494d45525f46495245442c41435449564954595f43414e43454c4c45442220636c6173733d22636f6d2e6861756c6d6f6e742e62706d2e636f72652e656e67696e652e6c697374656e65722e42706d41637469766974694c697374656e6572223e3c2f61637469766974693a6576656e744c697374656e65723e0a2020202020203c637562613a70726f63526f6c657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a70726f63526f6c6520636f64653d226d616e6167657222206e616d653d226d616e61676572223e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a70726f63526f6c6520636f64653d2270726f6a6563744f6666696365456d706c6f79656522206e616d653d2270726f6a6563744f6666696365456d706c6f796565223e3c2f637562613a70726f63526f6c653e0a2020202020203c2f637562613a70726f63526f6c65733e0a2020202020203c637562613a6c6f63616c697a6174696f6e7320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d227275223e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d0bfd180d0bed0b5d0bad182d0bdd18bd0bc20d0bed184d0b8d181d0bed0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d0bdd0b8d0b520d180d183d0bad0bed0b2d0bed0b4d0b8d182d0b5d0bbd0b5d0bc223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c2e617070726f7665222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c2e617070726f7665222076616c75653d22d0a1d0bed0b3d0bbd0b0d181d0bed0b2d0b0d182d18c223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a20202020202020203c637562613a6c6f63616c697a6174696f6e206c616e673d22656e223e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d2270726f6a6563744f6666696365417070726f76616c2e617070726f7665222076616c75653d22223e3c2f637562613a6d73673e0a202020202020202020203c637562613a6d7367206b65793d226d616e61676572417070726f76616c2e617070726f7665222076616c75653d22223e3c2f637562613a6d73673e0a20202020202020203c2f637562613a6c6f63616c697a6174696f6e3e0a2020202020203c2f637562613a6c6f63616c697a6174696f6e733e0a202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c73746172744576656e742069643d227369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430223e3c2f73746172744576656e743e0a202020203c736572766963655461736b2069643d227369642d37353031463341322d343231392d343935312d383742362d43414434304631323442333122206e616d653d225365742049444541222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c274944454127297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d43363743333142432d304137392d344536312d424433322d3646394539373434393244332220736f757263655265663d227369642d37373642303732312d303735362d344335302d383032312d31363034334341314241443022207461726765745265663d227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331223e3c2f73657175656e6365466c6f773e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d32414345433541452d383143422d344238362d413632322d38383944364637444446453222206e616d653d225761697420666f72207461736b7320657374696d6174696f6e0a223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d227461736b457374696d61746564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c736572766963655461736b2069643d227369642d37423431423830382d413131442d344134342d383537362d39364530424633354230333022206e616d653d2253657420455354494d41544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27455354494d4154454427297d223e3c2f736572766963655461736b3e0a202020203c706172616c6c656c476174657761792069643d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e3c2f706172616c6c656c476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d43374346383445362d364438462d344243322d393338332d3642463346393631423446392220736f757263655265663d227369642d37423431423830382d413131442d344134342d383537362d39364530424633354230333022207461726765745265663d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d226d616e61676572417070726f76616c22206e616d653d224d616e6167657220617070726f76616c223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22617070726f7665223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b6d616e616765725d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b66616c73655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d45313441304435392d353436352d344534452d423245312d4646373439333444383646442220736f757263655265663d227369642d45393432324139312d463735422d343042322d394332452d39333835303433354133353922207461726765745265663d226d616e61676572417070726f76616c223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d2270726f6a6563744f6666696365417070726f76616c22206e616d653d2250726f6a656374206f666669636520617070726f76616c223e0a2020202020203c657874656e73696f6e456c656d656e74733e0a20202020202020203c637562613a6f7574636f6d657320786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e0a202020202020202020203c637562613a6f7574636f6d65206e616d653d22617070726f7665223e0a2020202020202020202020203c637562613a666f726d206e616d653d227374616e6461726450726f63466f726d223e3c2f637562613a666f726d3e0a202020202020202020203c2f637562613a6f7574636f6d653e0a20202020202020203c2f637562613a6f7574636f6d65733e0a20202020202020203c637562613a70726f63526f6c6520786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b70726f6a6563744f6666696365456d706c6f7965655d5d3e3c2f637562613a70726f63526f6c653e0a20202020202020203c637562613a636c61696d416c6c6f77656420786d6c6e733a637562613d22687474703a2f2f736368656d61732e6861756c6d6f6e742e636f6d2f62706d2f352e352f62706d2e787364223e3c215b43444154415b747275655d5d3e3c2f637562613a636c61696d416c6c6f7765643e0a2020202020203c2f657874656e73696f6e456c656d656e74733e0a202020203c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d34314532373734412d444530442d343841432d413641392d4232353038314546393946322220736f757263655265663d227369642d45393432324139312d463735422d343042322d394332452d39333835303433354133353922207461726765745265663d2270726f6a6563744f6666696365417070726f76616c223e3c2f73657175656e6365466c6f773e0a202020203c706172616c6c656c476174657761792069643d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f706172616c6c656c476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d34394542314131422d354232312d344139432d414638442d3446343235313243423846382220736f757263655265663d226d616e61676572417070726f76616c22207461726765745265663d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d34383631363334362d413334352d344336382d423138342d31353945374331323844423722206e616d653d2253657420455845435554494f4e222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27455845435554494f4e27297d223e3c2f736572766963655461736b3e0a202020203c696e7465726d65646961746543617463684576656e742069643d227369642d43313932433337462d303534312d343436392d424233302d32314644364134463642413322206e616d653d225761697420666f72207461736b7320636f6d706c6574696f6e223e0a2020202020203c7369676e616c4576656e74446566696e6974696f6e207369676e616c5265663d227461736b436f6d706c65746564223e3c2f7369676e616c4576656e74446566696e6974696f6e3e0a202020203c2f696e7465726d65646961746543617463684576656e743e0a202020203c736572766963655461736b2069643d227369642d44394332353945302d304243352d343430412d393234412d37333541324646423741463422206e616d653d2253657420434f4d504c45544544222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e75706461746550726f6a656374537461746528656e7469747949642c27434f4d504c4554454427297d223e3c2f736572766963655461736b3e0a202020203c656e644576656e742069643d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d37334234343642442d304537302d343637452d393442362d3244433042334631353341312220736f757263655265663d227369642d44394332353945302d304243352d343430412d393234412d37333541324646423741463422207461726765745265663d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d44424533353631352d393041322d343341442d383842462d3841343646423036353341392220736f757263655265663d227369642d37353031463341322d343231392d343935312d383742362d43414434304631323442333122207461726765745265663d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e3c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792069643d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144222064656661756c743d227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541223e3c2f6578636c7573697665476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d42433139313930392d434633362d343736362d423938352d3931374333313243313045392220736f757263655265663d227369642d32414345433541452d383143422d344238362d413632322d38383944364637444446453222207461726765745265663d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144223e3c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792069643d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145222064656661756c743d227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746223e3c2f6578636c7573697665476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d42364635454533442d373030392d343445462d413138392d3037324341374641364337412220736f757263655265663d227369642d43313932433337462d303534312d343436392d424233302d32314644364134463642413322207461726765745265663d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145223e3c2f73657175656e6365466c6f773e0a202020203c736572766963655461736b2069643d227369642d36363631384530342d393342342d343544412d393638422d39334134443439383641343922206e616d653d225369676e616c207461736b7320746861742070726f6a65637420617070726f766564222061637469766974693a65787072657373696f6e3d22247b706d5f50726f6a656374732e7369676e616c52656c617465645461736b7328656e7469747949642c202770726f6a656374417070726f76656427297d223e3c2f736572766963655461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d44423535423131322d434437442d344534342d394245422d3737353541303642333243412220736f757263655265663d227369642d34383631363334362d413334352d344336382d423138342d31353945374331323844423722207461726765745265663d227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d41433236333439372d363544312d343239312d384130432d4243303934383939323744392220736f757263655265663d227369642d36363631384530342d393342342d343544412d393638422d39334134443439383641343922207461726765745265663d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d31344344324537322d313537412d344541322d383131362d3633423134413537384343352220736f757263655265663d2270726f6a6563744f6666696365417070726f76616c22207461726765745265663d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d32394243423741392d344545302d343744362d393243382d3844423746333333393236372220736f757263655265663d227369642d36434432453631352d353646312d344235322d383945442d46393544384133433132354122207461726765745265663d227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d30394531334437422d424242462d344341452d383846302d33373445393539413132363322206e616d653d22416c6c207461736b7320657374696d617465642220736f757263655265663d227369642d45314633334132362d424337352d343246302d424342312d42423832373134423838314422207461726765745265663d227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027455354494d4154454427293d3d20747275657d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d42304135443945412d464135372d344439412d423638342d3430303946354145394535412220736f757263655265663d227369642d45314633334132362d424337352d343246302d424342312d42423832373134423838314422207461726765745265663d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d45333539363042442d343942412d343834442d383842362d38443034413941434142333522206e616d653d22416c6c207461736b7320636f6d706c657465640a2220736f757263655265663d227369642d41453537453936462d434246462d344533342d414437322d33443434424444354330414522207461726765745265663d227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b706d5f50726f6a656374732e6973416c6c5461736b73496e537461746528656e7469747949642c2027434f4d504c4554454427293d3d20747275657d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d41313546433046322d443639342d343636322d393839432d3433314136414137463837462220736f757263655265663d227369642d41453537453936462d434246462d344533342d414437322d33443434424444354330414522207461726765745265663d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e3c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f70726f6a6563742d7766223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d2270726f6a6563742d7766222069643d2242504d4e506c616e655f70726f6a6563742d7766223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430222069643d2242504d4e53686170655f7369642d37373642303732312d303735362d344335302d383032312d313630343343413142414430223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d22302e302220793d2238302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331222069643d2242504d4e53686170655f7369642d37353031463341322d343231392d343935312d383742362d434144343046313234423331223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223130352e302220793d2235352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532222069643d2242504d4e53686170655f7369642d32414345433541452d383143422d344238362d413632322d383839443646374444464532223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223330302e302220793d2238302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330222069643d2242504d4e53686170655f7369642d37423431423830382d413131442d344134342d383537362d393645304246333542303330223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223537302e302220793d2235352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539222069643d2242504d4e53686170655f7369642d45393432324139312d463735422d343042322d394332452d393338353034333541333539223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223732302e302220793d2237352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d226d616e61676572417070726f76616c222069643d2242504d4e53686170655f6d616e61676572417070726f76616c223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d2231352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2270726f6a6563744f6666696365417070726f76616c222069643d2242504d4e53686170655f70726f6a6563744f6666696365417070726f76616c223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d223132302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541222069643d2242504d4e53686170655f7369642d36434432453631352d353646312d344235322d383945442d463935443841334331323541223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223936302e302220793d2239302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237222069643d2242504d4e53686170655f7369642d34383631363334362d413334352d344336382d423138342d313539453743313238444237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d22313032302e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133222069643d2242504d4e53686170655f7369642d43313932433337462d303534312d343436392d424233302d323146443641344636424133223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d223730352e302220793d223236352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634222069643d2242504d4e53686170655f7369642d44394332353945302d304243352d343430412d393234412d373335413246464237414634223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223330302e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436222069643d2242504d4e53686170655f7369642d37453039413631322d373536412d343331382d383545422d303643324442313939443436223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223231302e302220793d223236362e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144222069643d2242504d4e53686170655f7369642d45314633334132362d424337352d343246302d424342312d424238323731344238383144223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223339302e302220793d2237352e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145222069643d2242504d4e53686170655f7369642d41453537453936462d434246462d344533342d414437322d334434344244443543304145223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223538352e302220793d223236302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439222069643d2242504d4e53686170655f7369642d36363631384530342d393342342d343544412d393638422d393341344434393836413439223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223832352e302220793d223234302e30223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335222069643d2242504d4e456467655f7369642d45333539363042442d343942412d343834442d383842362d384430344139414341423335223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223538352e343630373834333133373235352220793d223238302e3436303738343331333732353437223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223430302e302220793d223238302e30393738343733353831323133223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637222069643d2242504d4e456467655f7369642d32394243423741392d344545302d343744362d393243382d384442374633333339323637223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223939392e352220793d223131302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313037302e302220793d223131302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313037302e302220793d223234302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541222069643d2242504d4e456467655f7369642d42304135443945412d464135372d344439412d423638342d343030394635414539453541223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223431302e352220793d2237352e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223431302e352220793d2231352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223332362e343938363038313530353935362220793d2238352e33363736353830393337343139223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539222069643d2242504d4e456467655f7369642d42433139313930392d434633362d343736362d423938352d393137433331324331304539223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223332392e393939373934343137373536382220793d2239352e3037383533323935353036363739223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223339302e33393437333638343231303532362220793d2239352e3339343733363834323130353236223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433222069643d2242504d4e456467655f7369642d43363743333142432d304137392d344536312d424433322d364639453937343439324433223e0a20202020202020203c6f6d6764693a776179706f696e7420783d2233302e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223130352e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741222069643d2242504d4e456467655f7369642d42364635454533442d373030392d343445462d413138392d303732434137464136433741223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223730352e303030313433303135383232332220793d223238302e30363535303135353838383239223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223632342e353833333333333333333333342220793d223238302e34313636363636363636363637223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335222069643d2242504d4e456467655f7369642d31344344324537322d313537412d344541322d383131362d363342313441353738434335223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e352220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e352220793d223132392e35223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632222069643d2242504d4e456467655f7369642d34314532373734412d444530442d343841432d413641392d423235303831454639394632223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d223131342e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d223136302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746222069643d2242504d4e456467655f7369642d41313546433046322d443639342d343636322d393839432d343331413641413746383746223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223630352e352220793d223236302e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223630352e352220793d223230352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e302220793d223230352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e302220793d223236352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633222069643d2242504d4e456467655f7369642d30394531334437422d424242462d344341452d383846302d333734453935394131323633223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223432392e35343534353435343534353435362220793d2239352e3435343534353435343534353435223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223537302e302220793d2239352e3131393333313734323234333435223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639222069643d2242504d4e456467655f7369642d43374346383445362d364438462d344243322d393338332d364246334639363142344639223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223637302e302220793d2239352e3230373436383837393636383036223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223732302e343136363636363636363636362220793d2239352e3431363636363636363636363637223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341222069643d2242504d4e456467655f7369642d44423535423131322d434437442d344534342d394245422d373735354130364233324341223e0a20202020202020203c6f6d6764693a776179706f696e7420783d22313032302e302220793d223238322e3232363836313531373034393433223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d223238362e3435373839383339393434333235223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638222069643d2242504d4e456467655f7369642d34394542314131422d354232312d344139432d414638442d344634323531324342384638223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223932352e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223938302e302220793d2239302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439222069643d2242504d4e456467655f7369642d41433236333439372d363544312d343239312d384130432d424330393438393932374439223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223733352e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644222069643d2242504d4e456467655f7369642d45313441304435392d353436352d344534452d423245312d464637343933344438364644223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d2237352e35223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223734302e352220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223832352e302220793d2235352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139222069643d2242504d4e456467655f7369642d44424533353631352d393041322d343341442d383842462d384134364642303635334139223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223230352e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223330302e302220793d2239352e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131222069643d2242504d4e456467655f7369642d37334234343642442d304537302d343637452d393442362d324443304233463135334131223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223330302e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223233382e302220793d223238302e30223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO act_ge_bytearray VALUES ('5251', 1, 'process.project-wf.png', '5249', '\x89504e470d0a1a0a0000000d494844520000046a0000014a08060000004523b99700004fd84944415478daeddd0b749455bae7ff3a0d1edba61d8f6bc6e5b86cdbee19c761b1582eba0796cc7844c6e339e21206db5b5149041a91200748822878900641fe8d57a0004545051a458c8818e562aa2a37b90882101004844043202422f7040cb8ffefb3a9b77c53d43da9fbf7b3d65ea97b2a95ecf7d9ef2ffbddafcd0600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020cdf4e9d3e7577c0a00000000000049e670381ee8d7af9f22ac0100249252aafddebd7b8bd7ad5b77c1ed76abd2d2525a829bcbe552959595df1b2d8fbf4800008014d0af5fbf678cb65f821a3e0d0040224948535555a5eaebebd5b973e768496a0d0d0daaa2a2e284cbe57a90bf4a00008024193870e02ffbf5ebf79ed1d63df4d043ff95a006009068329386902665c29a73a5a5a53bf8ab04000048026f30f3a5d1de95c0466e23a80100249a1cee4448923aadb4b4b499bf4a00008004ebd7afdf1fe45027bbdd3eceef76821a004042c91a2904242915d430160000004824efa2c1f576bbfd7efffb086a0000a91ad49c3e7e58edddf08efac6354937b92cb711ae10d4000000a42dcba2c17f08723f83330040ca0535a78ed5aa6dabc6ab2d9f3dd9a2c96d721f010b410d0000405af15f3438d8e3086a0000a918d41cf8e6934b421ab31dfca6848085a0060000207d045a3498a00600904e41cd8eb2e7830635721f010b410d0000405a08b66830410d00209d829a6da513830635721f010b410d000040ca0bb56830410d0080a08646500300009020e1160d26a80100a453502367790a16d4c87d042c04350000002929d24583096a0000e914d4ec5e3d2b685023f711b010d4000000a49c68160d26a80100a4535073b4b65a6dfb7cc2a5873d19b7c97d042c04350000002925da4583096a0000e914d448abf96ac125418ddc46b84250030000905262593498a00600905641cdd9b36af79ad72e3decc9b84dee236021a80100004809b12e1a4c5003004897a0e6d4b15ab56bf5cca06bd4c87df2184216821a000080a469eda2c104350080940f6ace9e5587777bd4d695ff1134a4319b3c461ecbec1a821a000080846b8b4583096a0000a91cd4849b45c3ec1a821a00008094d0568b0613d400005239a88964164da8d935042e043500000071d7968b0613d400005239a88935a4311b810b410d0000405cb5f5a2c104350080540e6a68043500000029295e8b0613d40000086a6804350000005188e7a2c104350000821a1a410d000040e481495c170d26a8010010d4d0086a0000002290884583096a0000043534821a000080f0414942160d26a8010010d4d0086a0000008248f4a2c104350000821a1a410d00004000c9583498a0060040504323a8010000b8341849caa2c104350000821a1a410d0000804532170d26a8010010d4d0086a0000007e0e4492ba6830410d0080a0864650030000b25eaa2c1a4c50030020a8a111d4000080ac964a8b0613d40000086a6804350000206ba5daa2c104350000821a1a410d0000c84aa9b86830410d002001f5afd468ff4c504350030000904ac1474a2e1a4c50030048444d9126818ddd6eef9e0a418df1ed7c6deddab5fa36f96abd9da086a006000064a0545f3498a0060090a8a0c6d256049a6193aca0e6a5975ed2b7bdf0c20b0435043500002093a5c3a2c104350080240435be1936d6c02619414dc78e1dd5bdf7deab6f93af9d3a756a11d4545454e8db2ebbec3275edb5d7aa79f3e6b578fee8d1a355870e1dd435d75ca3de78e38d90cfd9b3678fead6ad9bbefde1871f6ef17d1a1a1a54fffefdd5e5975faeaeb8e20af5c0030fa883070fb6f85e3d7af4d0cf27a8010000886d509a168b0613d400009215d45867d8c82151c9086a860d1ba6c3913367cee80045ae5b0314095cd6af5faf0e1c38a06fbbeaaaab5a3c7fe9d2a56adbb66dfaf2d5575f1df23977df7db7ef39c5c5c52dbecfc08103f5e54d9b36a9cd9b37ebcbf278ebf772bbddead0a143043500102ba554fbbd7bf716af5bb7ee826c546543474b6c73b95caab2b2f27ba3e5f11789444aa74583096a400da55143e3163ed0a26cc9086accc064c28409be10c51aa0d4d4d4a83163c6e8992cd6db6d7e8747c9e576edda857c8e044272b9a9a949b740f7599bdc66fd5ef29c441efa94e97f6f6cc5802c2403ccaaaa2a555f5fcfaaf1496c328db4a2a2e28431e07c90bf4a2468e09e568b0613d4801a4aa386b29d4c62a8b5c16eb7f7eed9b3677b795c32821a99492301cbf5d75faf67d4c8756b80228746c9e5929292b0414db8e74412d4040a636c495a33279367d4d07f812c25ff056480993203cd7346a1d9c15f25e2295d170d6600036a288d1aca763209414d8b80c6948ca0462ecbda2f72d9783f97dc670628724852a4414db0e7f4eddbd7376b67f1e2c52deecbc9c9d197659d1bf379b7df7e3b410dfd17405b92a9da0cf0526ad5fa66fe2a112fe9bc68300318504369d450b693090c6ad63a1c8efbfc039a640735cf3efbacbe3c65ca944bee9b3d7bb60e5e060d1a14715013ec39724854972e5df40c9ec18307ebdb65168fdc575757a7d7a9918584e5b9b23ecdfefdfb096ae8bf00da52220b0d8dc5d090d4429fd68b063380013594460d653b9980cf2ae00c9a6cebfb575e79a59a3a75aa3ebc4ace0025e1cb2db7dc42dfa7ff0248c541e6e11f4eab518b36eb269719145268901e3261d1600630a086d2a8a16c27096913d3e490270966cc5370df76db6d6aeddab5f47dfa2f8054283467cf9e53474f36faae57eea8f30d32e5b2797bfdf133eaf8a9460689141aa46681cf88458319c0801a4aa386b29d24a8a111d400c8ea422303cc85ab6bd4d3c5d5eaf3ad8754f9f6c36afc47db7c834cb92cb77ff6f54135d678cc2b2b77aa13a719685268902a326dd1e04806308f3cf248077ef3a0865243c18e1e410d7d9ffe0b20230bcdf727cea8311f54fb0695e1dae8f7b7a803df9fa458506890023271d1e0700318e36b4fa3d5f4e9d3e757fc05801a4a0d053b7a0435c969b6242c284c500320ab0acdf2cdb5110f323ff8723fc5894283d428e819b96870a8018c37a4a977381c77f017006a283514ece811d410d4d07f01646ca191a9dae620f2c9c55bd47b6bf6a93d75c77593cb729b79ff8a2db514270a0d922c93170d0e13d410d2801a4aa386b2a39791414d454585ead4a9933e3df6b5d75eabe6cd9bd72210314f952d8bff7efbedb711dfd7a3470fd5ad5b377ddbd1a347557e7ebeef94db43870e55274e9c50efbdf79e7e6c5e5e9e7e5cfffefdf5f5850b17867d5ff47dfa2f80362e3472360a59e8d07a3cbd0c2afd1f27b7598fb797e770260b0a0d9256c8337ad1e0203fb3cca4518434a086d2a8a1ece8656a502361c8faf5ebd5810307740072d55557b50844962c59a2962d5ba62fdf79e79d11dfe776bbd5a14387f46d12d2c86d12cc141717ebcb12d6c8fd72f9c61b6fd48ffbfdef7fafafcb7b09f7bee8fbf45f006d5c68024dcb96ff00fa3f4e6e0bf458068b141a244eb62c1a1c24a4a96700036a288d1aca8e5e2607353535356acc98317af68b3504312f373535e9269765364c34f799df43ee0bf6f8ce9d3bebeb656565faab043491bc2ffa3efd1700834c0699c84ad9b46870a0904666d23080013594460d65472f93839a8e1d3beae0a3a4a4246c5023872e457a9ff57bc87dfe8fefd0a183be6fd8b061fa7adfbe7df557997d13c9fba2efd37f01b471a161da36834ca445e1ceaa45830385340c60400da55143d9d1cbf4a0c69cedb269d3a68081c882050b7c61c9bdf7de1bf17dd6ef216bd9d8fc0e7d928046ee33afcb5a34f275f1e2c511bd2ffa3efd17409c0a4df9f6ba88174294c73248a4d02031b271d160f1c8238f749053705bd7a46100036a288d1aca8e5e260735b367cfd6a1c8a04183020622b2964cbb76edf42148723852a4f759bf872c263c78f060fd7da44948238b09cb7df2555e439e235f1b1a1a227a5ff47dfa2f8038159a95d5919f5af4d3af0f3248a4d02031053beb160db6ead3a7cfaf18c0801a4aa386b2a3972d414d2ca7c14e465842dfa7ff024840a1f9fec419f5747175c483cca73ed8a2ea8f9f61a048a1419c64eba2c10c60400da55143d94e12d4043e24ca5cf0379afbe8fbf45f00695c68ce349e55af7976eba9d94bbffabb2adbdef2787bb95cbefdb0fa7ceb213d187dbb728f6a3a7b96812285067190ad8b063380013594460d653b49504323a80140a1f11b68d61dfb79614359e8d01c64ca65f3f61f4e3632c0a4d02046e182976c5d3498010ca8a1346a28db49821a1a410dfd17a0d0846972360a7390c99929283468b3025cf6d0430fdd14e8be6c5d34380abdbc03985e7c14a086d2a8a16c27096ae8fb0435002834340a0d5ae5e1871fbe4b0ab0f74c46ffc5af3067f5a2c111b8cb68c78c36cdfbb5371f09a8a1d450fe2ad94ed2f7e9fb0435002834340a0d5a537c8bbd418db4b53d7bf66ccfa2c151ed7c983b1df29fe2067642400da586f257c97692be4fdf27a80140a1a151681013ef02c14d96a046dafb2c1a1cf5ce47b8db016a283594ed24db49fa3e7d9fa00600858646a141d8c23bd32fa4d1cd6eb797f0e904d52bcc4e86793f6b31801a4a0d653bc97692be4fdf27a80162a594fa65757575fefcf9f32ba64e9d7a62e4c891cd03070ed43b2c7979793f3dfef8e3e7c68d1bb7f7f9e79f5f68b4ffc92746a1a1d020ddb7570f3df4d0afed76fbb140418dd19a8dfbbaf369c7bc73c17f8c410da586b29d643b49dfa7efa763285312646c686d1be88188fb0ecf92254b164c9e3cb9b9b0b050bdfefaeb6addba75aab6b65635353529215febebebd5c68d1b95b163a40a0a0a7e2a2a2ada3764c890c17c82141a0a0dd2757be570380a43156109718cd6994ffe929d8a5e717a3c400da586b29d047d9fbe9feca0a6abfcc32ecc18918015f163ece00c7aeeb9e7ce3ef9e4937aa7e6fcf9f32a529b376f5663c78e3d9f9f9fbf23d8296d41a1a1d064af42a7c7f71916ce2c9bd0e2bad3f36991d37347a0e74d9cf8c13f1af79f34af1739cb2607da5efd70a2514d59b0568d9e5dae9acf5f886a7b65bea651687787f96fc901a38dbef8be26fec2785f67d9f988fa3fbff2bc53ec84801a4a0d653bc97692be4fdf4fa3b0664588f1a13ef1043d106dced86f69bf6cd932cfd0a1435549494954018dbf952b57aa4183063532bb864243a141a0a066c8eb25bf2a9ce9de6e5e2f9ae6fa6f854e7775a4af337ede869381b657955b0ea88f2a76a90b177e8a7a7bf5c4ecb226cb29b9cd76ca6855b2668dc3e1e8e57f9aee82e9ae5b8c9fe14b763e92f27c801a4a0d653b09fa3e7d3f91414dd760418d3146bc8fde87b88434e5e5e5eb478c18a176eddaa5dac2be7dfb94b113d53878f0e07fe713a6d05068600d6a0a67b8471738cbc698d70b9cee978a667a86e9fb667ac61bb71f97992a05333cafe8fb6796d98debf3cdd7309b757b65bd7df8c8429553f0a21af1ca2af5d8731faafff1873b54c78e1dd563f98faba7667bd4079e1dcaf9e1c64b9edb7f489114dbc6bc3f3ffeedb0c97f3b5d306da5ef3d5c7cdf65e38cc7351aed48c14cf7438533cbee33be2e92fb46cdaeb8a1c8e9f9aad0e976f83f2e037f95e116c44cf4eb00d4506a683a6e2795a5b19da4efd3f7d323ac09b456cd0666d3202ee43fd312d2c81a0e6d495e6fc89021a71c0e471e9f32858642030943264e2c6b2fb367f4ac1ae3baf7eb7e39bcc97c9cdc56e474ff9b841d170312cfd372a8945cdebaebc097852f145fb2bd5ab468917a6cd22275ebffb9438d7de95df5ce4715aab1b151edaf3ba19e79f30bb561c30635f99537d563cf2e545dbadda61f6f3a7cf4b47ae16f552a2727e782b1bd9a1ee83d78df7f63c174d7b5239cae4e12c218ef6b941c325538cbf5bf8deba545b3cb6e0af4b80cddf968abe9f8fcc718d4506aa82d4bb7939104356c27e9fbf4fdd40a6a2e59ab86b5691017b2c6831c3ed056336902cdace9dfbfff3163e7a7239f36858642435023336764d68cf57a81d33345ae17cdf00cd10188d3532b618ef1b8d7bd8f9b2fb36a647b357cc21cb5ea8b2dbe6d8c2c149c9797a7baddf62fead9375dfab6275ffd798d9ab33f9e574fbd56a12f7fbe7e9f3e3c4a7e979d3b77d6c5559ebfb472b7dabab7416f071f1ff3fc993173567fefff1ef4fb98e9b9cdb8fd55792f3fbf2ff72209695accbcf17b5c06f15fe0f21f8c36c0fb351afecf63e14c5043a9a199ba9d6c8ba086ed247d9fbe9f42ec76fb5266d320aee46c2993264d3a276b3cc4d3679f7dd6989b9bbb964f9c4243a121a831dab611cee5ffc972fddb2766b96ff45eff7184b3f21aef4c949ac269655dbcb7af343625ff22dbabb1afba5a8434bd7bf75677dd7597faa8ec1be5d9b85fdf3e764ea59e49236bd5947ffd77f5be7b87befd9dcfb6aaed35dfebcba74e9df23df7d97756fb5e73d44c8f1a3d76fc5701dec3c951b35c37fffb2cd77ff6cdf471962d2f707a465e9c25e4d93f6c76d9af033d2ec3763e7a5bc296b7bc3b186f4511d6047b1e3b21a0865243336d3bd996410ddb49fa3e7d3f75829aee96b569e88f687b4b972e7d57ce96f2e38f3faa781b366c581d8740516828340435e6ec19f37a91b3ec03cbf55912d6143acb3e91c0c33c1c4a2ecbd14d4f3ef994facbdc2fd4c255dfe8ed8acca491a0454297e7dffd52fd70f2e2e9b8b77c57af26bcb55a9ffd69d26b9fe8593562bcf15cebd9a09a9b9b559f3eff4f8d7ce953df6b7e58be5315ce70a949f3d66c6af91eca72bdb37d1ae5502cf37d15bde2be5e2ecb2150054ef7f0408fcbd09d8f017e3b19918435d690c66cfd2df7b31603a8a1d4d06c096962096ad84ed2f7e9fb29c25cab86d9346873329b66f2e4c9cd724adb44d8b265cb3966d55068283468abed95ac31230b0437343404ddee545454e8ff76ac59b326e86324e491c3a0ac6bd6b0bd8a68a72050e8122aac09f4f8b9011ecf5a0ca086524333653b198fa086ed247d9fbe9f1a414dd7fbefbf9f7d03b4bdeaeaea7c5940b835a7e18ed6a04183ea8c3feadf65fb67ef70384a8df6cf141a0a0d7d21b2bee0bfbd92993037dd74935ab16245d0edcdd9b367d5e38f3f2e0b04abe1c387879c3928bf5b793d79dd4cdc5e45fa3987d8f9e81545f81228ac8934a4f1df09613a31a8a1d4d074df4ec623a8613b49dfa7efa74640abe8836873f3e7cfaf983b77ae4aa469d3a66d36767c4667fb676f39a6b1548e71a4d05068e80ba1fb82fff64a7e175dba7409b9bd292e2e56b9b9b94a66e1c8d7a54b97867c7cf7eedd5b043f99b4bd8af4738e7127205c58136d4863fdfe0d36fe630c6a283534fdb793f1086ad84ed2f7e9fbc963f6fd693666b7a1ad4d9d3af5c4ba75eb121ad4ac59b3669f1ccfc720f3e7d3b979db8a40ffc5a1d05068e80b81b757324366f2e4c941b735478f1e5503060c50f3e7cfd7d7e5ebc08103d5b163c7823ee7c5175f5483070fcec8ed55a49f73800148a4038f6061cd2f620c694cacc5006a28353453b693f1086ad84e06e076bbe973a9d39a8cbedf9ca1214d6f4b1f243045db19397264f3e1c387131ad4d4d5d5d51b85ef0083cc4b0603beffe25807050c321964d217026faf1e183c4e555555a9f3e72fa831732a2ed9d6cc9e3d5b872ea74f9ff6ad43f3e8a38faa3973e65cf2d8e56bf7eaaf5f7eb95e0d7f7979466eaf22fd9c5bb9f31128acd9d98a90a62d7786400da5514353613b198fa086eda49fcacacac3f5f5f5f4bb1468b5b5b5ef1b7d7f47068734f441b43df9efb29cda3691e4fb1945af894166e0c180f5bf3832ed964126834cfac2c5bee0bfbd1af6e2a741b75f7bf6ec9181b55ab97265cb4066f9727dfbbe7dfb5adc6e063db23e8d4daf5b9c79dbab483f675bebff331b28ac694d48e33f00e238705043a9a1e9b09d54716c6c27c3f0783c7dcbcbcb8f1f3972a491be97bc993412d2b85caefd467b3043feb4c2f5fd5ef441b459414a86080a21cddb1864a656e36f327ecd919ba7f29f7955154c2fd5a7ca1e306c8cefbec1a35f306eff5c3df3e617eaebdd47949cd2db6c9b761d51ef7ebe5d6f5baaf734a8290bd6aaa2e9ab54d1e437f5a9b84b37fc1ccaac58b747151aaf53e474aba595bbf56dfeaf7577ded88b0b11ff785ebf6e36fd0ebc672e9036ad95e5450e77f29f49b3d37b7b6b4ca3afd0a26dd42e6a6892b693c9086a6cdef7258ff9a76cdfcf71b95cbd8d71f40639ec46c6d3b48437f9dc77646048132e8461660d5a6fc080013f257a464d6363631d336a42fed76683dd6eefddb367cff6f238821afe1b982d7de1b1b1337473387254de9ff355d1b415e7ccbe50e8f4340e7c34ffa77d878eeab0e6f0d1d3ca5ee4d4335e248859f9658ddebe7836ee57afbc5ba106154e52ce45556acdd65af551c5ae16dba0b55fae5703868e564fccf2e8ebf25ace0f2f9ef27bd5977b55f77b06e8cb4b8ce7add95e7f323737b7a960baab9bf11e8ec8fb2d9ce179bac0e9de34c259794d81d333b26086e7954cdae6b4c17f8342cda8798b1935a0865243b3643bc98c1a207344dbb7e88b689d1123469c4bf41a35870e1ddac91a35010703fe83005b320699ebd7af57b7df7ebbbafcf2cbd515575ca16ebbed36b57af5eab0cfaba8a8503d7af408789f39b0b05e9676e59557aa912347aa3367ce5c729ff53966bbe5965b7cb7d7d4d430c8ccb0be203366acb35b46cd2a3f6b3ea670a6e7b6c2e7debee059bf536f476436ccbffda9bf5ea34666bdc84c18f1b795db54c17f4c55635f7e5f6df9ae5e2df67cab36eeacbbb830f0d65a1df24c786bb57a625a892a78ee6d7da893bcd6d6bd0dfa3112eef4ec9dab2f3ff96ab97cd925dbab61b3cb7e6dbca7d3fabd383df30b9d6e87f77d390b6696d933699b6319609cb2c5678d9a58c21afe3b85b8d5d078d63dff7a16ea7b05db290f5547d7ae5dab6f93afd1d6ce48be5fa8dbfd6b78860635f1d84e860a74da624792ed24109f90a6770ccf3b455883988c1f3f7e77a2cffab46ad5aae59cf5a9c56060adc3e1b82fc82020e141cdcd37dfac070bd5d5d56ad3a64dfaf20d37dc10f679810687a1821ab93c7dfa747d79f4e8d1615fe3abafbe6a3140940561096a32ab2f144e5fd5bceffb1f87f9f78542a7e7e4a859ae9b5f71cede6bce8299346f8defac4f733edeacf6d45e3c93d3e4374bd580fc223563f13a7ddb1b9f6c51bb0ffca0ef7b6256993ad5f8a39e41f397b995ea914787ab929212fd5aa6b1d33f56f9054f5fbc3ca7527d577b62f55ffe32f1d342a7bbd0686f7adfcfca22a7eb76efe58f47cd70fddf4cdae6041898443ac008760aee40677d8a26ace16c26886b0d8d77dd8bf67b057a6eb0b0e4a5975ed2b7bdf0c20b01839a486a67b8ef17ec76ff1a9e61414dbcb693f10a6ad84e02a915d2b4d5f391ad5e7cf1c5b98684063513264cf8cc2880a3196486fc2f4dd2821af90f9f0c16befdf6db4bee6b686850fdfbf7f7fd27f081071e50070f1ed4d76d41fe93172aa891b3f05807a9a106bdf25f3bb94f169495af0f3ffc30414d86f5853aa5fa15383d870b9d9eb3462b2b9c56d6e5621852962b871d8d9ae539ffd7d73e54172efca467c5bc38cfa5ba74e9a2170296333f9d387142154c5fa5de7c73ae0e59e436f3abf8b07ca70e6bde2ca9d6cf79edb5396ad0a047d55fe67ea116aefa463f66c42b2bd4f2e52bf4659991f3d46c4f5391d3d36c7cffb764568d191c4d9cf8c13fca65e3be1fcccb99b2cd897180112ca4f98710f74712d674b571ba4bc4b986c6bbee45fabda20d6a3a76eca8eebdf75e7d9b7cedd4a9d325cf8da476c61ad4f8d7f00c096ae2b99d8c5750c37612888f68170d6fcdeb002d3df3cc33ff7df8f0e117ce9f3f9fb0933ee5e4e4ec310ae1eff8f42393e8a0c6fcaf5c870e1dd4b061c3f47ffdccfbcc819efc1770f3e6cdfaf2dd77df1df38c1af3fa65975d1672aab5ac4372cd35d7a8ebaebb4e4e97ac6f97c1aedc4e5093bddb2b396ce9a69b6e522b565c0c562474fef39fffac039b481c3b764c0d183040bdf5d65bfabafc6ee5f5e475d95e4535c00817d2d8620c6bcc29c3f7f1d78f78d6d078d63dff7a16ea7b451bd4c8f3253092438fa48ecaf5586a67a8ef670b7108967f0dcff21ada9a1db1d604356c2781f8f6e95e6dd47f995983e88d1a35eabb8d1b3726eab0a785c64e4f159f7aea0635d2e47879199cca4052363c32b094dbfdff83284d6e6beba0c6fff94b962cd1b78f1933465fffe31fffa8af27e3b321a849adedd5a2458bf47f95b76cd9a2727272d4a44993a23a23c1840913f4f376eedca93a77eeac5f8fed5554038c48439a68c31af3fbb1f38184d4d078d6bd48bf57b4414d7171b1fe2adb31f9ba74e9d2168f8bb476da629c514350d3663b62b106356c2781f8f6e55e6ddc7f596018d179f4d1471f7ae289279a1330abe698b143b4c9e170e4f1a9a7765063b603070eb418949a03d640335962096acc69d3325d3bd46bf4e9d327e07ff7ccc127414d766faff2f2f2f4e9525b73bad5071f7c507f657b15920c2cfca7d70f8822a40915d6f4f7fb3efcd70949a9a1f1a87b917eaf68831a9949d3ae5d3b75fdf5d7ebb044ae5b1f1769edb4b5f2d027b3865343836e27e311d4b09d04e21bd2f48e53ff25ac4174f2f3f3ab6551cd7892f570e4bfd3511ef7cb2033c1418dcc4e908d8d9c99c25c8450163f94fb64e6815c7fe38d377c8b20cad92be43ef33f8372d849a869d5d6cbf23a7279dcb871410786325d5b06a27ffad39f7cb7bdfdf6dbfa71b23e09410ddb2bf97bebddbbb7baebaebbf4e14cd1901d0df3b9f23a6caf22de39e81520748924a4b185791e031824bc86c6bbee45fabda20d6ae4b29c754a2e1bdbaa16f745533b630d6afc6b383534e876921d3d2033439a58faaf751b41d08af0640d8641830635eedab52b2e214d7575f532e37b1c76381c1df9b4533ba89163f0cd5387ca204f4e1d6a9efe53067e325d5b8e7197fbe538fdfdfbf7fb0680575f7db57ecec2850b233e3d77616161c863e267ce9ca9bf8e1f3fdef7385984d1bcdffcfe0435d9bdbd929d249959233b41e69a35e1c8ef520e77929934d69086ed55d403190959fadba23fe5b6fff3a2ddb901daa486c6b3eed9fcd67809f5bd62096a9e7df6597d79ca94292dee8ba676da6258a326500da786c6bcc317cd8e1edb49203e620d4f5a7be822610dc233767272f3f3f3cfd4d7d7b7694873f0e0c12f727272f67308417a0435340699e9bcbd923566644160f98fb19cbabbaaaaca17c2c822c11b366c90d932aa7bf7eefa71d63569d85e25758011cbe1020035941a9a09dbc94877f4d84e02f10d696209405bbb1838c12b22939b9b3b68c89021a7da6a668dfc675a767aec76fb583e5d06990c329188ed950432f27b1a3e7cb8eadab5ab6adfbebdaf884a383378f0603debc6727627b657c90d6bf8af12a8a1d4d06cde4e46b2a3c77612886f1f8d352c694d50637e7f025844c6d849e997979777e2e38f3f3edd8a05868fbdfcf2cbefc8e103461bc8a7ca20934126d85e65a4d64ec3671a3fa8a1d450b6936c2781648634ad09495a1bd458fb38610dc2933520727272dcf9f9f9759b366d6a8c6287a7e9f3cf3f5f64ec386d90853859e3814126834cb0bdca9a9d906807184cf90535941aca7692ed2490ae214d5b05356df97e90453b400fca0ed0c08103eba74e9dfacd175f7cb1bfb6b6f6b0b9e643636363dda1438776ba5cae4f274e9cb822373777afecf0c87fa5395b0a834c0699607bc580870109a8a1346a28db49208544129caa38b6707d9e6016913376687ee370380a8d1d9a62a3d518ad49ce94e2fd7ac06825461b2dffd9e6d36290c920136cafd80909a1abd14e19ed3e3e325043a9a16c27d94e0209f44fdeb0645a98c72523a811d3bc63565a80c69f2f1864d2186402b1e9e5ddb9e815e2fe06763e400da586b29d643b0924b10f869bb9c28c9a14435003069934069940eb04fb8f31d3f8410da5865243d94e02a9d2074fd958a386a0066090c92013c8e29d100620a086d2a8a16c278154ec83ad99c1c2599f086ac02093c6201348cb01d0340620a086d2a8a16c278114ee83b1f6bdd60635b21e55037d9fa0060c32690c328144eae51dbc70bc35a8a1346a6890eda4770784ed2490bcb14aac614d6b821af3f02bd6a322a801834c1a834c20e1fe898f00d4501a35941d102085c53ab326d6a0c6fc7e84346c27c12093c6201300a8a1346a283b20000230cfb8164d58134b50c39a346c27c12093c6201300a8a1346a283b2000a20851223d1431daa0865370b39d04834c1a834c00a08652bba8a1ec800088423487414513d4441b0281ed241864d2186402003594460d6507243328a5daefddbbb778ddba7517dc6eb7fedba325b6b95c2e555959f9bdd1f23238ac8934a889e5b02ab09d04834c1a834c00a086d2a8a1ec8064060969aaaaaa547d7d3d7d2f89ada1a1415554549c70b95c0f666858134950d3da538083ed241864d2186402003594460d650724bdc94c1a429a94096bce197d7f479afe29b5f670250e77623b09069934069900006a2835941d10c8e14ef4b994eafbcd69fce714eb599a583898ed241864d218640200a8a1d450764040dfa7efc741b4872f71b813db49506868141a000035941aca0e08a2edfba78f1f567b37bca3be714dd24d2ecb6df457fa7e2bc297ae463b65b4fbe8896c2741a1a151680000d4506a283b2088b0ef9f3a56abb6ad1aafb67cf6648b26b7c97df459fa7e00bdbc214caf10f73710d2b09d04858646a101005043a9a1ec8020cabe7fe09b4f2e0969cc76f09b12fa2c7d3f9860336b38dc89ed242834340a0d00801a4a0d650704b1f6fd1d65cf070d6ae43efa2c7d3f8ab0869086ed242834340a0d00801a4a0d650704ade9fbdb4a27060d6ae43efa2c7d3fc2b0661a210ddb49506868141a000035941aca0e08086ae8fb49f6dbdffe7684f1457e364ec1cd7612141a1a850600400da586b20382d6f47d39cb53b0a046eea3cfd2f723e8bb25f7df7fbfead9b3677b7a1ddb496419b7dbcd063e755a9351689af9ab04006a288d1aca0e487a0735bb57cf0a1ad4c87df459829a50ec767b77a3ef364bff75381ccca8613b896c53595979b8bebe9e8d7c0ab4dadadaf78d42b383bf4a00a086d2a8a1ec80a4775073b4b65a6dfb7cc2a5873d19b7c97df45b829a3041cd52e9bbdeb6815ec7761259c6e3f1f42d2f2f3f7ee4c8914636f4c9fb2fa00c305d2ed77ea33dc85f2500504369d4507640d23ba89156f3d5824b821ab98d7e4b5013a6cf763567d398cd6eb7b39830db49641b6360d3dbd8c06d9029c3b2a1a325bcc9e7be83012600504369d45076403224a8397b56ed5ef3daa5873d19b7c97d042c043521fa6c8935a43167d5b0560ddb4900000000ec802086a0e6d4b15ab56bf5cca06bd4c87df2184216829a00fdf592d9346673381cf7d1fbd84e0200000060070491063567cfaac3bb3d6aebcaff081ad2984d1e238f65760d418d5f7f5d1128a4f1b6b5f43eb69300000000d8014104414db85934ccae21a889a0af069d4dc35a356c2701000000b0038228829a4866d1849a5d43e0425013646d9a4bd6aaa107b29d04000000c00e08c20435b1863466237021a8a1fff239030000006007043188f4f4dc34821afa2f9f3300000000b003126704350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e67000000006007244510d410d4d07ff99c01000000801d90144150435043ffe573060000000076405204410d410dfd97cf1900000000d801491104350435f45f3e6700000000600724ce1c0e47a9d1fe99a086a086fecb761200000000d8014981cf4a9a043676bbbd7b3c821ae3e9be76f9e597ab5b6eb945ad5fbfbe55af15eb7ba9a8a8503d7af488fa790b172e54d75e7bad6ad7ae9d7ebefff5d6be2f821afa2f9f33000000007640e00b6a2c6d45a019366d11d4c8e5b2b2327d59c29a64cc44893550b9ecb2cbf4f34e9c38a19a9a9a2eb9ce8c1afa2f9f3300000000b003128fa0c637c3c61ad8b45550635e97a0c37a9fcc4ae9d6ad9bbeede8d1a32a3f3f5f5d71c5157a06ced0a1437520e2ff5a0d0d0daa7ffffefa31f2d8071e78401d3c7850dfb77fff7ed5b3674ffd7d3a76eca8d6ae5dab1f67b3cceef17f9fc1beaffff302bd8ef572a0ef1deefd12d4d07ff99c01000000b00382a0418d75868d1c12d5d6336aba74e9d2e23eb7dbad0e1d3aa46f93b0446e7befbdf7547171b1be2ca189ff6b0d1c38505fdeb46993dabc79b3be7cf7dd77ebfbeeb9e71e7d5d42129b65068f2dc48c9a48bf6fb8ebc1be77a8f74b5043ffe5730600000090cde1032dcad6566bd4c89a2e9d3a75525555552deeb31e3e64ce5891dba4d9bcb358fc0311ff992dd6c799f74573e853a4df37dcf560df3bd4fb8db665fadf1b5b31821a0000000020d46ad936d8edf6de3d7bf66c2f8f6bcb439fc2dd278705f907261d3a74081a88045a232696a026d2efdbdaa0a62dd6b4c9e4193520a80100000000829a20018d2991418d798890f510a461c3865df2f89c9c1c7df98d37ded08713c9e5db6fbfbdc5e147ab57af6e71f891042fb6208b0047fa7d233df4c9ff7b877abf04354846dfe753000000008014dc59f3b6b50e87e33eff80c694c8a04616f51d3c78b09e81224dc212eb62c272f8945caeababd3e18ab9f8afacf7220bf9ca7d353535ead65b6fd50bfa76eedcd9773af0b7df7e5b5d7df5d5fa35e414dbd17c5f5b84414db0ef1deafd12d420197d9f4f0100000000526f672de00c1a7fad096adaaa9d3973468721d75d775dd2df4bb21b410d086a00000000208ba5425073e79d77aa2bafbc522d5ebc98a086a006ad44500300000000692c15821a1a410dda0e410d00000000a431821a821a6416821a0000000048630435b12d964c50835445500300000000698ca086a0069985a00600000000d25822839a8a8a0ad5a953277d7aeb6bafbd56cd9b37af4520629ee2fa965b6e51df7efb6dc4f7f5e8d14375ebd6cd772aeefcfc7cdfa9b2870e1daa4fc5fdde7befe9c7e6e5e5e9c7f5efdf5f5f975379877b5f0435482704350000000090c61219d44818b27efd7a75e0c0011d805c75d5552d0291254b96a865cb96e9cb7226a848ef73bbddead0a143fa360969e43609668a8b8bf565096be47eb97ce38d37eac7fdfef7bfd7d7e5bd847b5f0435482704350000000090c61219d4d4d4d4a83163c6e8d92f364b08625e6e6a6ad24d2ecb6c9868ee33bf87dc17ecf19d3b77d6d7cbcacaf457096822795f0435482704350000000090c61219d474ecd851071f25252561831a397429d2fbacdf43eef37f7c870e1df47dc3860dd3d7fbf6edabbfcaec9b48de17410dd209410d00000000a4b1440635e66c974d9b36050c44162c58e00b4beebdf7de88efb37e0f59cbc6e677e8930434729f795dd6a291af8b172f8ee87d11d4209d10d400000000401a4b6450337bf66c1d8a0c1a34286020226bc9b46bd74e1f82248723457a9ff57bc862c283070fd6df479a8434b298b0dc275fe535e439f2b5a1a121a2f74550837442500300000000692c154ecf6d0b1188d892109624b311d4a0b5086a00000000208da5425063ce7e89f63e821ae05204350000000090c65221a8a111d4a0ed10d400000000401a23a821a8416621a80100000080344650435083cc42500300000000698ca086a0069985a00600000000d218410d410d320b410d00000000a431821a821a6416821a00000000486304350435c82c04350000000090c6086a086a9059086a00000000208d11d410d420b310d400000000401a23a821a8416621a80100000080344650435083cc42500300000000698ca086a0069985a00600000000d218410d410d320b410d00000000a431821a821a6416821a00000000486304350435c82c04350000000090c6086a086a9059086a00000000208d11d410d420b310d400000000401a23a821a8416621a80100000080344650435083cc4250030000000069cced761390a44e6b2a2d2d6de6af12ad4150030000000069acb2b2f2707d7d3d21490ab4dadadaf74b4b4b77f05789d620a8010000008034e6f178fa9697971f3f72e448236149f266d24848e372b9f61bed41fe2ad11a04350000000090e65c2e57efd2d2d20d72d88dac91424b7893cf7d07210dda02410d0000000000408a20a8010000000000481104350000000000002982a0060000000000204510d4000000202e834c5ae634fea20180a0060000000c32c1ef1200d8ee020000000c32c1ef1200d8ee020000804126f85d0200db5d000000804126f85d0200db5d00000030c804bf4b0000db5d00000030c804bf4b0060bb0b0000000699e077090060bb0b0000000699e07709006c77010000c02013fc2e01006c77010000c02013fc2e0180ed2e000000186482df250080ed2e000000186482df2500b0dd050000001864f2bb0400b0dd05000000834cf0bb0400b6bb00000000834c7e970000b6bb0000006090097e9700c076170000006090c9ef1200c076170000000c32c1ef1200d8ee020000000c32f95d0200d8ee020000804126f85d0200db5d000000804126bf4b0000db5d00000030c804bf4b0060bb0b00000030c804bf4b0060bb0b0000000699e07709006c77010000000699e077090089ddc696c876364cdbc0270500000076eec1ef1200e2bf8ded6ab4e650418ddd6eefcd270500000076eec1ef120012b39d5d1122a859dbb367cff67c4a00000060e71efc2e012031dbd9aec1821a87c3711f9f10000000d8b907bf4b0048ecb636d05a351b984d0300000076eec1ef120012bfadbd64ad1ad6a6010000003bf7e07709004962b7db97329b06000000ecdc83df2500a400bbdddeddb2364d2f3e11000000b0730f7e970090dc6dae5eab86d93400000060e71efc2e0120f9dbdcae6c7701204529a5daefddbbb778ddba7517dc6eb72a2d2da525b8b95c2e555959f9bdd1f2f88b04d8b9e77709c60c34c60cf4051a7d0140169322535555a5eaebebd5b973e768496a0d0d0daaa2a2e28451741ee4af1260e79edf251833d01833d01768f40500594afe13409149996273aeb4b474077f95003bf7fc2ec19881c69881be40a32f00c852325d938d7cea34a3d034f35709b073cfef128c19688c19e80b34fa02802c25c778b2814fa942c38e0ac0ce3dbf4b3066a03166a02fd0e80b002834e1dbe11f4eab518b36eb2697290c141a809d7bf0bb64ccc0988131037d81be405f008004159ab367cfa9a3271b7dd72b77d4f90a8d5c366faf3f7e461d3fd548a1a0d000ecdc83df256306c60c8c19e80bf405fa0200c4a3d0489159b8ba463d5d5cad3edf7a48956f3facc67fb4cd5768e4b2dcfed9d707d558e331afacdca94e9ca6d8506880e4eddc3ff2c8231df844086ac098813103e80bf40500c8c842f3fd89336acc07d5bec212ae8d7e7f8b3af0fd498a05850648cacebdf1b5a7d16afaf4e9f32b3e15821a306660cc00fa027d010032aed0485bbeb936e242f3c197fb2914141a20293bf7de90a6dee170dcc127425003c60c8c19405fa02f0040c6161a99ae69169227176f51efadd9a7f6d41dd74d2ecb6de6fd2bb6d45228283440b2821a421a821a306660cc00fa027d010032b7d0c88af4b2d899f5985a292cfe8f93dbacc7dcca7358cd9e42032470c75e66d228421a821a306660cc00fa027d010032bad0049a9a29ff05f07f9cdc16e8b1140c0a0d90a090a69e9d7b821a306660cc00fa027d81bf4a00141a0a0d85064881904666d2b0734f5003c60c8c19405fa02ff0570920e30b0d53372934403a8434ecdc13d48031036306d01768f405005951687e5e0cad2ee2c5d0e4b1140a0a0d104f8f3cf248073905b7754d1a76eed3369429f12e041daa6de09362cc4063cc405fa0d1170050682c6d6575e4a717fcf4eb83140a0a0d10777dfaf4f995df0e3f7d263d839aae466b0e15d4d8edf6de7c528c19688c19e80b34fa02000a8db77d7fe28c7abab83ae242f3d4075b54fdf133140b0a0d90e81d7efa4cfafeee5684086ad6f6ecd9b33d9f1263061a6306fa028dbe008042e36d671acfaad73cbbf5f4cca55ffd5d956d6f79ccad5c2edf7e587dbef5902e486f57ee514d67cf522c283400410d22fddd750d16d4381c8efbf8841833d01833d01768f40500149a00c5a6eed8cf8b9bc9626766a191cbe6ed3f9c6ca4c8506800821ac4f2fb0bb456cd0666d33066a03166a02fd0e80b00283411345991de2c34ac4e4fa10152402f6f50d38b8f226d839a4bd6aa616d1ac60c34c60cf4051a7d010085860d3c8506483f7719ed98d1a679bfb2739fa6ec76fb5266d33066a03166a02fd0e80b0040a1a1d000e91fd298e18ccca86920ac49dba0a6bb656d1a66473166a03166a02fd0e80b0028346ce02934401a8734e16e471a30d7aa61360d63061a6306fa028dbe00804243a1a1d000e9a3579830c6bc9f5919e917d474656168c60c34c60cf4051a7d01c800b9b9b9bfb1dbedc38dc15db1d1761bed9477fa7493d16abcc7bd8f96c7f1695168283440468434e1421866d6a438a5d42fabababf3e7cf9f5f3175ead41323478e6c1e3870a03ef4292f2fefa7c71f7ffcdcb871e3f63efffcf30b8df63ff9c41833d01833d01768f405200d381c8efb8c566ab473014eeb19ac95198fcfe3d3a3d0506880b473972dba9932d13e1e090a68962c59b260f2e4c9cd858585eaf5d75f57ebd6ad53b5b5b5aaa9a94909f95a5f5faf366edca8e6cf9faf0a0a0a7e2a2a2ada3764c890c17c828c19688c19e80b34fa029082faf5ebf73b87c3b1328a702650ab7ae8a1876ee2d3a4d0506880b40a697ac7f0bc538435b129747a7cdba2c29965135a5c777a3e2d727aee08f4bc89133ff847e3fe93e6f52267d964f9ba6eddba41cf3df7dcd9279f7c5287303f9c68545316ac55a36797abe6f31754289b376f5663c78e3d9f9f9fbf43eab7f99ad1983871e22f8cf77596df2c6306c60ca02fd01700b421bbddde2f2727e7076be8929b9babfefad7bf2a8fc7a3fefef7bfab93274fea41dd993367f47fe856af5eada64d9ba61e79e411ffb0e614b36b2834141a2063439ab67a7ed60735435e2ff955e14cf776f37ad134d77f2b74baab237d9df1f3369c5cb66c9967e8d0a1aaa4a4449d3f7f5ed7e9ca2d07d44715bbd4850b3fa948ad5cb9520d1a34a8f189d9654dd1fe3c05d35db7183fc397fc6619333066007d81be00a0ed429ade0e87e3bc35a059b870a19e1e1d8963c78ee9c7cbf3ac818df19a593f959a4243a1015254b8858313fd3a5919d414ce708f2e70968d31af1738dd2f15cdf40cd3f7cdf48c376e3f2e33550a66785ed1f7cf2cb31bd7e79baf61b65dbb76f96ab2f5f6e1230b554ec18b6ac42babd463cf7da8fec71fee501d3b76548fe53fae9e9aed511f787628e7871b033e37d87bb8f8becbc619b7351aed48c14cf7438533cbee33be2e92fb46cdaeb8a1c8e9f9aad0e976f83f8edf3c6306c60ca02fd017004416d2f4b38634a3468dd2b3676221cf9369d77e614d56cfaca1d0506880140e69daeab02566d6c410d44c9c58d65e66cfe85935c675efd7fd727893f938b9adc8e9fe37093b2e06249ea7e55029b9bc75d7812f0b5f28bee49f2a8b162d528f4d5aa46efd3f77a8b12fbdabdef9a842353636aafd7527d4336f7ea1366cd8a026bff2a67aecd985aa4bb7dbf4e34d878f9e562f2f5aa7860c19e29b19ebff1ebcefbfb160baebda114e572709618cf7354a0e992a9ce5fadfc6f5d2a2d96537057a1cbf79c60c8c19405fa02f000843d6a4b11eee3461c204dfe14db192c3a2a64c99e27f1854470a0d8d4203a404ff8580ffc16803bc5fa3e1ff3c16188e32a89199333263c57abdc0e99922d78b667886e800c4e9a99530c778dcebdec7cd975935b226cdf00973d4aa2fb6f8eaaf2c149c9797a7baddf62fead9375dfab6275ffd798d9ab33f9e574fbd56a12f7fbe7e9f3e3c4ab6899d3b77d6f55a9ebfb472b7dabab741eddbb74f3d3ee6f93363e6acfedeff3de8f731d3739b71fbabf25e7e7e5fee4512d2b49879e3f738306660cc00fa027d0140183939392eeb4c9ad68634d6b0c66f664d15858646a1015226a4e96d095bde329af27e8d34ac09f63cc29a28821aa36d1be15cfe9f2cd7bf7d6296fb46eff51f47382baff1ce44a9299c56d6c57bfb4aa3ccfecba44993ce8d7dd5d522a4e9ddbbb7baebaebbd44765df28cfc6fdfaf6b1732af54c1a59aba6fcebbfabf7dd3bf4edef7cb6556daff95e5f3e75ea94efb9cfbeb3daf79aa3667ad4e8b1e3bf0af01e4e8e9ae5baf9df67b9feb36fa68fb36c7981d333f2e22c21cffe61b3cb7e1de87160ccc09801f405fa028010e414dcd63569623ddc29d46150d6356bb2f510280a0d850648d190460cf0862d2a8ab0c61ad298adbfe57ed6ac8930a83167cf98d78b9c651f58aecf92b0a6d059f689041ee6e15072598e6e7af2c9a7d45fe67ea116aefa46d75c994923418b842ecfbffba5fae1e4c5d3716ff9ae5e4d786bb53efbd3a4d73ed1b36ac478e3b9d6b341353737ab3e7dfe9f1af9d2a7bed7fcb07ca72a9ce15293e6add9d4f23d94e57a67fb34caa158e6fb2a7ac57dbd5c9643a00a9ceee1811e07c60c8c19405fa02f00081dd4949a218a2c041c0f72dc7bb6cfaaa1d050688014102c3c0914ba840a6b023d7e6e80c7b3664d9c18a5f59793274f6e9653705b6bad2c10dcd0d010b41e575454e85abc66cd9aa08f9190470e83b2ae59b365cb9673b9b9b96bf9e419333066007d81be0020ce8c41d76fcc058465d6cbd1a347e312d4c8d9a0fc4eddfdbb60efc9b8afabdd6e5f4aa1a125b3d064eadf2108696cc10f478a34ac8934a4f10f6ba23a0c8a3e185a757575fe8811237ca7e196993037dd74935ab16245d05a7cf6ec59f5f8e38fab9c9c1c357cf870f5e38f3f067dac6c23e5f5e4754d83060daa0b55bff9bd316660cc00fa02410d8036601495e16678f2c20b2fa8789a366d9a35a8191da8c819adc468cdf2180a0d2d198526d3ff0e91b5220d4bc28535d18634d6efdf608b60660d7d3032f3e7cfaf983b776e8b60a54b972e21eb707171b1fea78cccc291af4b972e0df9f8eeddbbb7087e8c3abe3950fde6f7969831c3faf5ebd5edb7dfae2ebffc7275c51557a8db6ebb4dad5ebd5adf67f6c778d4cb60af2db3b37af4e81197d78ea6f9bf8f585e33dccfc29881f1338da0064828a3a8149be1497979795c831a194c58829a926045ce6c141a5a220b4db6fc1d22ab439a480f3f0a16d6fc22c690c61472cd1afa6074a64e9d7a62ddba75be1a2b3364264f9e1cb406cb8cd9010306a8f9f3e7ebebf275e0c0817ac66b302fbef8a21a3c78b0effa9a356bf659eb37bfb7c48e196ebef966ddefaaababd5a64d9bf4e51b6eb821eef53258f0d116214b3c5e2396d70cf71cc60c8c9f69043540a2839add667169eb4584fdd5d6d65a839a0376bbbdbb4c13f52f720435b444169a6cfb3b04214d2bc29a9dad086982be1ffa606c468e1cd97cf8f0615f8deddab5abaaaaaa0a5a8367cf9ead4397d3a74febeb7ffddb5af5d8b0423567ce9ca0cf79eba3d57acd9bf3e72fa831732a545d5d5dbdd46f7e6fc91933c82c1ae97bdf7efb6dc8a061cf9e3daa5bb76eeab2cb2e530f3ffc708bfbcccba3478f561d3a7450d75c738d7ae38d377cb34a3a75eaa49f77edb5d7aa79f3e6050d3164568f757b10eaf9cb962dd36b1ec9edf233c8cc15798ffeaf2d33bbe5f2b871e3c23e2fd4fb302f0f1b364cdf2fef65c1820541df63a0d760ccc0f899465003243ba839651697b63a2577a853755b8ad98560458ea0869688e65de0ba24dbfe0e91555a7bd6a540614d6b429a1661cd6f7ffbdb11f4c1d8c96c183915b7a97dfbf62dae5bc9ceadc3e1502b57aed4d77ffae927f5e4abe56af9f2e5faf67dfbf6057c9e843336bd6ef1cfa7fe367e27e7f8bd2567cc60061912b0480821336b02053577df7db7be2c87b6c9e16e81420cb96fdbb66dfaf2d5575fadef9300430eaf3a70e080befdaaabae8a6a464db0e7cb57b95e5353a3ef97cb1224595f430243f93a68d020dfeb857a5e24336a24e891504b2e4b2015cbcf68dd39e5ef9ef1338da006486450e32b2e8910aab8654363039f3a2ddbff1669d9d18ccdfcb456960939dcc97f26cd4eefedad21ef4bdd7ffffdfc9e5ad144f59e063565c15a3564ca47ea932fbed3a7db2edd703178397eeaac7ae6cd2fd4532fbeab0a6794aaf2aff7ebdb0fd69f52338a37ea85880b473da1c6bcf49e3e6db79cbe7b5bcdf7fa31729a70b36dda7544bdfbf976ea780a8c19e4307209e924ac913e24e18d7fd060ce1091604d5aa0a0c61a6ab46bd74e5f964064cc98313a0c09f59c600149b0e7cb5a3a725966b1dc73cf3d7a76979c99ccfa1a669b316386eff5423d2f9a439f5af333fa053534c6cf0435043540c6cfa8697af8e187ef32beae65460d2d998526dbfe0e9195336a7ac5f8fc50336ade6aed8c1af37dd1072f5534c3fdb722a7fbdf0aa7555e57e8f49c94db0a677a9c054ecfc8891327fea260baabdbc89797eb9d70cfc6fd6afeca6dea0f77fc49cd5f5eadd66cad551f55ecbab8a68c71f9aff32a94236f8072576d504fbd56a16fb7062faf7d50a51e1b3b437df9e57a557fec8c9af8f66a7dfbe1a3a7d58ce2aff4ef5b829f955fd6a8c6c6c6bafc71b3cfcbfb70381cffeac8ebbf35d8efad6086e715ba60fcc60ce68c1009655a1bd498d7e53037b95c525212535013ecf9f21ee4e7193972a45e53476e97f576acaf216b2cc9e14d72a893f97aa19e176d5013ebcfc89881f1338da00648565093b4356accf7600cf67a19d7abb235a809751687d69ca140fecbf6fbdfff5eff27eaca2bafd4a763b51edb2dd38ccdfbe514ace631eafeffe15abb76adbe4dbeda821c076e0e166fb9e516fdf3841bf404daf10b767ba8fbfc6f979f530674120a465b68b2e5ef105947429153b6f8ac51134b581374cd1cfae0cf0a9d9ed3016e6b9cf84ed92fe5f2b0d965bf961932b2468d042e5bbeab578e91cfabf74b2ad462cfb76ae3ce3a5d77dff864b32a18fb9c9a32658aba70e12735764ea5be5d829cd55b0feacb12de5867cfc8cc1ab1b472b75afaf95abd632bdf43c29d43870eed2c9851fa93f57d3cfeecbca640bfb782996576ba5fdb8e19cc9041eaec575f7d1530f090cb7dfbf6f51ddeb478f1e288831a33e031172a0e176298b37a4e9c38a1439560cfbff5d65b7de309e36f485fbefefaeb2f79edbcbc3c7db9acac2cecf342bd8f587e46ffd760cc907e414d3cc6d381c69e9b376fd65ffff8c73ffa1e2767dc93595be67d81c6abe1c6e6a1fe6e23191f473abe97f729416fac0b6f13d400890b6a927ed62793f7bf1455d916d4c47a1687501b57991e2cf7fdebbffeab1e70c871da725d8214b9ffbdf7ded3d76561490935f2f3f3f57519d0f91784975e7aa9c5b1f1c18a830cacacdf2392a0269a9fcd16c17ff4a64f9fee5b2431d64293e97f87c8dab0269a9935c14ec11de8ac4fd1843511ad99431fbc18d48c9a5d7143c1acb2dec6e52fbdb71d979934132796b52f74ba0b9f717ea4cffa34e7e3cd6a4fed3155f0d7f7d484bfce506f7cb245ed3ef0835e87a6c8e9568f164d52fbf7ef572bd6ed551f57edbeb848f0675bd576ef214ee3deac529bbfd9add7aa915906a649f3d6f8cefa647e8f55ab562d2f9c5eda6c7d1f467b53de5ffe5fe66e70e4f5df62fede46cd70fd5fba5edb8e196427d0dc11959d2dd91135ff9962ad8572788fb9e328bf3f9bf7f0a1703b83327690d796756222096ade7efb6dbdbe8d7c9f850b17067dbefcfdfde94f7fd23bcff23ee4b023d939f67fedcf3efb4c5f960590c33d2fd4fb88e567f47f0dc60ce917d4c4633c1dec3ef9a7a0dc2e8b519be3e3a79f7e3ae473c28dcd6d119cbd2cdc6d918eef031d32495003a418bbdd3edc2c2ed269e369dab469d6a06674b0f7e4fd2fc5da6c2934a1cee220c762f7efdfdff7df81071e78401d3c7830ec190a648066f3fe372dd0f734ff4b65a6f832a893eb72bb75c32dffbdbbf7de7bf56df25516e1b385f9cf5cb0c16022829a53a74e455c98c3159a4cfd3b44d68735e166d6040b69fe21c4fd9184355d8dd6608b62664f36f7c1a299eea1854ecfd9c299eeed239cae4edea0e67ea3d5eadb9d9eb7767e57337feedcb97ac15f392bd3e8591ef5c73ffe2f3d6b46ae7ffded41356cc2eb6aecac957a96cc87e53bf5ede23f5eaf54cddecb5fef3ea2d7b5915067c4ffb748edaca9d3b36f64bd9abca297d58a152b7cdf63c284099fcd595c3edffa3e64568df7fd9d9c38f1837f94dfdb238f8d6c96cb74bbf8ef9c066af29ffaa953a7ea1d35a9f3d69d415a7c0ef760cc90fcbe108ff174b0dbe5f5e4ac61d2a4bf49482463d050cf0937366f8ba026d2f17dcf9e3d096a8054979b9bfb1b73057be3b23a7af4685c429a63c78ec994d69f2c41cdef2834e1cfe2200b06dabc5374cde994723687701b57094b6cde29bc81ee370b93ff865e8a57a0535bca604f5e53aedbc2cca8914214eba14f9114225b98299fd6b0884203b4106e464bb890c6166358631e7e751fbf82b6f3cc33cffcf7e1c3875f900581457373b39ee62ec18a98fcea52f558e1785d0722add303060c506fbdf596be2edb48793d795df3a44f3939397bb2b17ea75b50233b8212cc580f013167ded058972353fb423cc6d3a1c6ab329bc6bccded76877d4eb8b1795b0435918eef654d28ffc3ffe80b400a72381ca5668022d33de3c17b2a64b3555168223b8b837fd26f0bb270a07f93a9bb729f046fa1829c701b72f3b49e13264cf0fd17c016e49859f99e32e3a6aaaa2a69336a086a80b082cdac8934a48936ac31bf1f214d1c8c1a35eabb8d1b37b6a8b5321372cb962d6af8d40fd5b393a7e86d5da44db6f5b266c2ce9d3bf5a2aef27aa655ab562dccd6fa9d6e410d8da0265bfb425b8fa743ddb760c102dffde6ba4aa19e136e6c6ede1fe86c65918e8f231ddfcb7a3e46fd20a801d220a8b9cf0c5164564d5b2f2a2caf670cfc7cb3698cef9747a189ec2c0ed6333744533ce43f69b610d32bcdd3526edbb64d5fdfbe7dbbbe2eb75b5f5b66d2489190c5fb64e32fd76d119e25c196c4439f2430a2d00041c9cc1affc390064411d2840a6bfafb7d9f480eb7428c1e7df4d1879e78e2896673568d9005595b7bdaf3071f7cd077fa6f73c28d51c737656bfd26a8a1316648afbed056e3e960f7d5d5d5a96baeb946371927cbecc370873e851b9b9b876e050a58221d1f473abe97cbb28032410d90068c0159996f01c051a3daec54ddb2636f0c22cf5b67d3f4ecd9b33d8526b2b338c87f36e5baacd86e4e51948504c39da140567c97fb645d19b96fc99225faba1412eb6263b2989e5c3717d593db836dc8031dcf9a6a418d7c4e7279dcb871141a207c58635d60d81aba4412d2d8c23c2fda058c11a3fcfcfc6aeb22c0b2cdefddbbb7baebaebbf4e14cd1901d0df3b9f23aa6175f7c716e36d7ef4c0b6a62d9398be6ac93e9de027d3e8c1952bf2fc4633c1dacaf141616fa5ecf9c751e6e31e17063f37beeb9475f979f5766a7cb65ff7e668b7031e148c6f7cf3efb2c410d902641cdef8cd660062ab2d1696d582321cd942953acebd29c72381c1d2934919fc541127b99c22989badc2fc7d3ca591022394381140f592f4666c2c8f365636f3d465dee97e2201b68398d5fa0d3735b37e4727ad758821a5b14a7da6ecd1a3536efe9b9a57852688088f81f0625214b7f5bf4a7dcf67f5e2f429ac4d66f6330deb86bd7ae16618dccac911d1773cd9a70649b28873b49bdb68634d5d5d5cb8cdb0e6773fdceb4a026d9410f410de2d117e2319eb645707a6ed95eca6c99484ecf1d6a6c2eef47ce0865be7ff907a9b9287034ffc88c747cbf7bf76e821a205dd8edf67ee6c2c2e6cc9a580f8392e7f9cda451d93e659a69cc4c6306d220ac69ad40875521cef2f2f272f3f3f3cfd4d7d75fb23e9c0cd865c760f2e4c9fabfb46608238b046fd8b0419f82bb7bf7eefa71d63569c4c18307bfc8c9c9d9cf214fc91f33983b54e6cea6ec189a67b731ef939d3ef310075907434ecd6bee980e1d3ad4b788a975e72cd8d970cc1d47d959949d4a09fd648732dc597264b68d1c7e2ccf9133e2c882ab91beffd6fe6ce66c020929e571f273c975d9f90ef573caf7923e22b7fb9fb69b3103e3671ae3672025f4ebd76fa035ac91356ba4c0453a7d5a1e27033deb9a34d2ec76fb580a0d85864203647458d3d6a10fa260d4eb4143860c39659d59630632b2bd93b37c74edda55b56fdfdeb7232ae1cce0c183f5ac1bcbd99d7c336924a4a17ea7565023874b2c5bb64c5fbef3ce3b5bdc27679e3974e890be4d820c9bf79007f3c4001268f80735a1ce86631e8a21018dcd728a6f5b88ffc24b4823879e986b845c75d55511bfffd6fe6c72bf5cbef1c61bf5e36436815c97f712eae79430cae65d3bc4fcfe04358c9f698c9f819423336b8c76cc1ab44860232ba7979797ebd932e661517278536d6dad5e65dde974caa93d2ff82d4a784ac21f3e550a0d85064869ad3d5c89c39d52a47ee7e5e59df8f8e38f4f5b17188ed2b1975f7ef91d39dc89fa9d7a418dcc8892660b70d61aebfa1ad6c553833d3edcd970029dea375c50535353a3c68c19e35bd4d4e6779872b8f7dfda9f4d0edfb379cfc263b39c5c20929fd3fa7a04358c9f698c9f819424c7bc5b4fdb1d63abe298760a0d850648bbb026da19312c1c9c62f53b2727c79d9f9f5fb769d3a6c628029aa6cf3fff7c515e5ede06ea777a0435fea7dc0d740619ebe365d1d460414da0b3e1c412d4980bbaca02d7e1821afff7df163fdbb061c3f4f5be7dfbeaaf32fb26d29f93a086f1338df133904e03be07bd814d7334018dfc178eb3435068283440da89f6f0250e774ae1fa2d81cdc08103eba74e9dfacd175f7cb1bfb6b6f6b0b9464d636363dda1438776ba5cae4f274e9cb8223737772ff53bf5839a050b16f84210397b4cb030c33cd4c77a78908418fe8f0f75361cf3d02799356db31cfa14ea2c3966e861be967f5013eafdb7c5cf665e973572e4ebe2c58bc3fe9c720894cd7be893f97c821ac6cf34c6cf405a300670bf71381c85c600aed86835466bf28632f2f580d14a8c365afe93c7a745a1a1d0005911d67435da29a3ddc74746fd4662821a598b45ce08238716c96146c1c20c597057d61f92e0449a0419d6c584e535c29d0d475effd65b6fd5a1871c52246bcf843b4bceecd9b3f5ebf82fca1bc9fb6f8b9f4dbeca6b983fa32c221ceee79433eb4808253fa7bc2e410de3671ae36700141a1a85064845bdbc214caf10f73710d200890d6a5a5bfb646d41799debaebb2e654ee96d4b83d37d336660fc4ca32f00a0d0d02834402a0836b386c39d80048f19ccd923adad7d7236a52bafbcd2774850a25aa8f7df563f1b6306c6cf34fa020050682834403686358434006306c60ca02fd01700804243a3d0002910d64c23a40118333066007d81be0000141a1a8506483e599346d9380537c098813103e80bf40500a0d0d02834404af8273e028031036306d017e80b0040a1a1516800008c19688c19e80b34fa0200506828340000306660ccc09881be40a32f00a0d0d028340000c60c34c60cf405fe06e90b0040a1a1d00000c09881c69881be40a32f00a0d0d028340000306660cc00fa027d01002834141a00001833d01833d01768f40500141a1a85060000c60c8c19405fa02f000085864243a101003066a03166a02fd0e80b002834340a0d00008c19183380be405f00000a0d8d42030060cc4063cc405fa0d11700804243a101008031036306d017e80b0040a1a1516800008c19688c19e80b34fa0200506828340000306660cc00fa027d01002834340a0d008031038d31037d81465f00000a0d85060000c60c8c19405fa02f0040ea73bbdd6ce053a7351985a699bf4a000063061a6306fa028dbe00204b5556561eaeafaf67239f02adb6b6f67da3d0ece0af1200c09881c69881be40a32f00c8521e8fa76f7979f9f123478e34b2b14fde7f02a4c8b85caefd467b90bf4a000063061a6306fa028dbe00208b191bb7dea5a5a51b64daa01ce3494b7893cf7d07450600c09881c69881be40a32f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002cfe7fb0af81d1e95461f70000000049454e44ae426082', true);
INSERT INTO act_ge_bytearray VALUES ('5273', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10054', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10044', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('7543', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10070', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('7565', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10095', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10227', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10108', 2, 'hist.var-estimation_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009657374696d61746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10133', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10143', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10159', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10255', 2, 'hist.var-projectOfficeApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f7374536967426974737870477a393a33a9c7293806b9f8afd77a647878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10166', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10176', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10014', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10183', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10273', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10217', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10245', 2, 'hist.var-managerApproval_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740007617070726f7665737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10315', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10332', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10301', 2, 'hist.var-planningByManager_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740004706c616e737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787062cadb68efac8af0d62e8e6cd27409f47878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10283', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787031cd44b14b0f95ec11429a66614cc48f7878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10290', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);
INSERT INTO act_ge_bytearray VALUES ('10325', 2, 'hist.var-workOnTask_result', NULL, '\xaced000573720024636f6d2e6861756c6d6f6e742e62706d2e636f72652e50726f635461736b526573756c74daa6870f29ace32d0200014c00086f7574636f6d657374000f4c6a6176612f7574696c2f4d61703b7870737200116a6176612e7574696c2e486173684d61700507dac1c31660d103000246000a6c6f6164466163746f724900097468726573686f6c6478703f4000000000000c77080000001000000001740009636f6d706c65746564737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a657870000000017704000000017372000e6a6176612e7574696c2e55554944bc9903f7986d852f0200024a000c6c65617374536967426974734a000b6d6f737453696742697473787093d945e5b6386d388505414d8b6b1a717878', NULL);


--
-- TOC entry 2925 (class 0 OID 39980)
-- Dependencies: 235
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_ge_property VALUES ('schema.version', '5.20.0.2', 1);
INSERT INTO act_ge_property VALUES ('schema.history', 'create(5.20.0.2)', 1);
INSERT INTO act_ge_property VALUES ('next.dbid', '12501', 6);


--
-- TOC entry 2940 (class 0 OID 40236)
-- Dependencies: 250
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_hi_actinst VALUES ('2502', 'project-wf:1:18', '2501', '2501', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-08 15:08:28.29', '2017-06-08 15:08:28.301', 11, '');
INSERT INTO act_hi_actinst VALUES ('2506', 'project-wf:1:18', '2501', '2501', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-08 15:08:28.302', '2017-06-08 15:08:28.312', 10, '');
INSERT INTO act_hi_actinst VALUES ('2511', 'task-wf:1:14', '2510', '2510', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-08 15:08:28.399', '2017-06-08 15:08:28.399', 0, '');
INSERT INTO act_hi_actinst VALUES ('2515', 'task-wf:1:14', '2510', '2510', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-08 15:08:28.4', '2017-06-08 15:08:28.406', 6, '');
INSERT INTO act_hi_actinst VALUES ('2524', 'task-wf:1:14', '2523', '2523', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-08 15:08:28.467', '2017-06-08 15:08:28.467', 0, '');
INSERT INTO act_hi_actinst VALUES ('2528', 'task-wf:1:14', '2523', '2523', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-08 15:08:28.467', '2017-06-08 15:08:28.471', 4, '');
INSERT INTO act_hi_actinst VALUES ('2537', 'task-wf:1:14', '2523', '2523', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-08 15:08:41.705', '2017-06-08 15:08:41.716', 11, '');
INSERT INTO act_hi_actinst VALUES ('2538', 'task-wf:1:14', '2523', '2523', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-08 15:08:41.716', '2017-06-08 15:08:41.753', 37, '');
INSERT INTO act_hi_actinst VALUES ('2539', 'project-wf:1:18', '2501', '2501', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-08 15:08:41.739', '2017-06-08 15:08:41.752', 13, '');
INSERT INTO act_hi_actinst VALUES ('2509', 'project-wf:1:18', '2501', '2507', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-08 15:08:28.312', '2017-06-08 15:08:41.735', 13423, '');
INSERT INTO act_hi_actinst VALUES ('2529', 'task-wf:1:14', '2523', '2523', 'estimation', '2530', NULL, 'Estimation', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-08 15:08:28.471', '2017-06-08 15:08:41.705', 13234, '');
INSERT INTO act_hi_actinst VALUES ('2547', 'task-wf:1:14', '2510', '2510', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-08 15:09:04.319', '2017-06-08 15:09:04.327', 8, '');
INSERT INTO act_hi_actinst VALUES ('2548', 'task-wf:1:14', '2510', '2510', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-08 15:09:04.327', '2017-06-08 15:09:04.38', 53, '');
INSERT INTO act_hi_actinst VALUES ('2549', 'project-wf:1:18', '2501', '2501', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-08 15:09:04.338', '2017-06-08 15:09:04.342', 4, '');
INSERT INTO act_hi_actinst VALUES ('2550', 'project-wf:1:18', '2501', '2501', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-08 15:09:04.342', '2017-06-08 15:09:04.346', 4, '');
INSERT INTO act_hi_actinst VALUES ('2551', 'project-wf:1:18', '2501', '2501', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-08 15:09:04.346', '2017-06-08 15:09:04.346', 0, '');
INSERT INTO act_hi_actinst VALUES ('2542', 'project-wf:1:18', '2501', '2540', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-08 15:08:41.752', '2017-06-08 15:09:04.334', 22582, '');
INSERT INTO act_hi_actinst VALUES ('2516', 'task-wf:1:14', '2510', '2510', 'estimation', '2517', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-08 15:08:28.406', '2017-06-08 15:09:04.319', 35913, '');
INSERT INTO act_hi_actinst VALUES ('2575', 'project-wf:1:18', '2501', '2552', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-08 15:11:38.266', '2017-06-08 15:11:38.268', 2, '');
INSERT INTO act_hi_actinst VALUES ('2554', 'project-wf:1:18', '2501', '2552', 'managerApproval', '2555', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:09:04.349', '2017-06-08 15:11:38.266', 153917, '');
INSERT INTO act_hi_actinst VALUES ('2611', 'task-wf:1:14', '2523', '2523', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-08 15:13:15.541', '2017-06-08 15:13:15.545', 4, '');
INSERT INTO act_hi_actinst VALUES ('2577', 'project-wf:1:18', '2501', '2553', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-08 15:11:49.549', '2017-06-08 15:11:49.551', 2, '');
INSERT INTO act_hi_actinst VALUES ('2578', 'project-wf:1:18', '2501', '2501', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-08 15:11:49.557', '2017-06-08 15:11:49.563', 6, '');
INSERT INTO act_hi_actinst VALUES ('2579', 'project-wf:1:18', '2501', '2501', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-08 15:11:49.563', '2017-06-08 15:11:49.607', 44, '');
INSERT INTO act_hi_actinst VALUES ('2545', 'task-wf:1:14', '2523', '2543', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-08 15:08:41.753', '2017-06-08 15:11:49.592', 187839, '');
INSERT INTO act_hi_actinst VALUES ('2573', 'task-wf:1:14', '2510', '2571', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-08 15:09:04.381', '2017-06-08 15:11:49.57', 165189, '');
INSERT INTO act_hi_actinst VALUES ('2561', 'project-wf:1:18', '2501', '2553', 'projectOfficeApproval', '2562', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-08 15:09:04.37', '2017-06-08 15:11:49.549', 165179, '');
INSERT INTO act_hi_actinst VALUES ('2597', 'task-wf:1:14', '2510', '2510', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-08 15:12:05.764', '2017-06-08 15:12:05.782', 18, '');
INSERT INTO act_hi_actinst VALUES ('2580', 'task-wf:1:14', '2510', '2510', 'planningByManager', '2581', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:11:49.574', '2017-06-08 15:12:05.764', 16190, '');
INSERT INTO act_hi_actinst VALUES ('2604', 'task-wf:1:14', '2523', '2523', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-08 15:12:14.789', '2017-06-08 15:12:14.797', 8, '');
INSERT INTO act_hi_actinst VALUES ('2587', 'task-wf:1:14', '2523', '2523', 'planningByManager', '2588', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:11:49.594', '2017-06-08 15:12:14.789', 25195, '');
INSERT INTO act_hi_actinst VALUES ('2612', 'task-wf:1:14', '2523', '2523', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-08 15:13:15.545', '2017-06-08 15:13:15.558', 13, '');
INSERT INTO act_hi_actinst VALUES ('2613', 'project-wf:1:18', '2501', '2501', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-08 15:13:15.554', '2017-06-08 15:13:15.557', 3, '');
INSERT INTO act_hi_actinst VALUES ('2617', 'task-wf:1:14', '2523', '2523', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-08 15:13:15.558', '2017-06-08 15:13:15.558', 0, '');
INSERT INTO act_hi_actinst VALUES ('2596', 'project-wf:1:18', '2501', '2594', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-08 15:11:49.607', '2017-06-08 15:13:15.552', 85945, '');
INSERT INTO act_hi_actinst VALUES ('2605', 'task-wf:1:14', '2523', '2523', 'workOnTask', '2606', NULL, 'Work on task', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-08 15:12:14.797', '2017-06-08 15:13:15.541', 60744, '');
INSERT INTO act_hi_actinst VALUES ('2618', 'task-wf:1:14', '2510', '2510', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-08 15:13:53.668', '2017-06-08 15:13:53.673', 5, '');
INSERT INTO act_hi_actinst VALUES ('2619', 'task-wf:1:14', '2510', '2510', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-08 15:13:53.673', '2017-06-08 15:13:53.692', 19, '');
INSERT INTO act_hi_actinst VALUES ('2620', 'project-wf:1:18', '2501', '2501', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-08 15:13:53.682', '2017-06-08 15:13:53.685', 3, '');
INSERT INTO act_hi_actinst VALUES ('2621', 'project-wf:1:18', '2501', '2501', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-08 15:13:53.685', '2017-06-08 15:13:53.688', 3, '');
INSERT INTO act_hi_actinst VALUES ('2622', 'project-wf:1:18', '2501', '2501', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-08 15:13:53.688', '2017-06-08 15:13:53.688', 0, '');
INSERT INTO act_hi_actinst VALUES ('2623', 'task-wf:1:14', '2510', '2510', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-08 15:13:53.692', '2017-06-08 15:13:53.692', 0, '');
INSERT INTO act_hi_actinst VALUES ('2598', 'task-wf:1:14', '2510', '2510', 'workOnTask', '2599', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-08 15:12:05.782', '2017-06-08 15:13:53.668', 107886, '');
INSERT INTO act_hi_actinst VALUES ('2616', 'project-wf:1:18', '2501', '2614', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-08 15:13:15.558', '2017-06-08 15:13:53.68', 38122, '');
INSERT INTO act_hi_actinst VALUES ('5002', 'project-wf:1:18', '5001', '5001', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:41:29.742', '2017-06-09 10:41:29.752', 10, '');
INSERT INTO act_hi_actinst VALUES ('5006', 'project-wf:1:18', '5001', '5001', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 10:41:29.752', '2017-06-09 10:41:29.761', 9, '');
INSERT INTO act_hi_actinst VALUES ('5011', 'task-wf:1:14', '5010', '5010', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:41:29.852', '2017-06-09 10:41:29.853', 1, '');
INSERT INTO act_hi_actinst VALUES ('5015', 'task-wf:1:14', '5010', '5010', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 10:41:29.853', '2017-06-09 10:41:29.86', 7, '');
INSERT INTO act_hi_actinst VALUES ('5024', 'task-wf:1:14', '5023', '5023', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:41:29.932', '2017-06-09 10:41:29.932', 0, '');
INSERT INTO act_hi_actinst VALUES ('5028', 'task-wf:1:14', '5023', '5023', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 10:41:29.932', '2017-06-09 10:41:29.936', 4, '');
INSERT INTO act_hi_actinst VALUES ('5037', 'task-wf:1:14', '5010', '5010', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:42:16.242', '2017-06-09 10:42:16.248', 6, '');
INSERT INTO act_hi_actinst VALUES ('5038', 'task-wf:1:14', '5010', '5010', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 10:42:16.248', '2017-06-09 10:42:16.283', 35, '');
INSERT INTO act_hi_actinst VALUES ('5039', 'project-wf:1:18', '5001', '5001', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 10:42:16.268', '2017-06-09 10:42:16.282', 14, '');
INSERT INTO act_hi_actinst VALUES ('5016', 'task-wf:1:14', '5010', '5010', 'estimation', '5017', NULL, 'Estimation', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:41:29.86', '2017-06-09 10:42:16.241', 46381, '');
INSERT INTO act_hi_actinst VALUES ('5009', 'project-wf:1:18', '5001', '5007', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 10:41:29.762', '2017-06-09 10:42:16.264', 46502, '');
INSERT INTO act_hi_actinst VALUES ('5047', 'task-wf:1:14', '5023', '5023', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:42:30.445', '2017-06-09 10:42:30.451', 6, '');
INSERT INTO act_hi_actinst VALUES ('5048', 'task-wf:1:14', '5023', '5023', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 10:42:30.452', '2017-06-09 10:42:30.501', 49, '');
INSERT INTO act_hi_actinst VALUES ('5049', 'project-wf:1:18', '5001', '5001', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 10:42:30.463', '2017-06-09 10:42:30.466', 3, '');
INSERT INTO act_hi_actinst VALUES ('5050', 'project-wf:1:18', '5001', '5001', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:42:30.467', '2017-06-09 10:42:30.471', 4, '');
INSERT INTO act_hi_actinst VALUES ('5051', 'project-wf:1:18', '5001', '5001', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:42:30.471', '2017-06-09 10:42:30.471', 0, '');
INSERT INTO act_hi_actinst VALUES ('5042', 'project-wf:1:18', '5001', '5040', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 10:42:16.282', '2017-06-09 10:42:30.459', 14177, '');
INSERT INTO act_hi_actinst VALUES ('5029', 'task-wf:1:14', '5023', '5023', 'estimation', '5030', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:41:29.936', '2017-06-09 10:42:30.445', 60509, '');
INSERT INTO act_hi_actinst VALUES ('5075', 'project-wf:1:18', '5001', '5052', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:43:58.236', '2017-06-09 10:43:58.237', 1, '');
INSERT INTO act_hi_actinst VALUES ('5054', 'project-wf:1:18', '5001', '5052', 'managerApproval', '5055', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:42:30.474', '2017-06-09 10:43:58.236', 87762, '');
INSERT INTO act_hi_actinst VALUES ('5096', 'project-wf:1:18', '5001', '5094', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 10:45:25.578', '2017-06-09 10:47:02.066', 96488, '');
INSERT INTO act_hi_actinst VALUES ('5077', 'project-wf:1:18', '5001', '5053', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:45:25.52', '2017-06-09 10:45:25.522', 2, '');
INSERT INTO act_hi_actinst VALUES ('5078', 'project-wf:1:18', '5001', '5001', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 10:45:25.525', '2017-06-09 10:45:25.531', 6, '');
INSERT INTO act_hi_actinst VALUES ('5079', 'project-wf:1:18', '5001', '5001', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 10:45:25.531', '2017-06-09 10:45:25.578', 47, '');
INSERT INTO act_hi_actinst VALUES ('5045', 'task-wf:1:14', '5010', '5043', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 10:42:16.283', '2017-06-09 10:45:25.538', 189255, '');
INSERT INTO act_hi_actinst VALUES ('5061', 'project-wf:1:18', '5001', '5053', 'projectOfficeApproval', '5062', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 10:42:30.492', '2017-06-09 10:45:25.52', 175028, '');
INSERT INTO act_hi_actinst VALUES ('5073', 'task-wf:1:14', '5023', '5071', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 10:42:30.501', '2017-06-09 10:45:25.559', 175058, '');
INSERT INTO act_hi_actinst VALUES ('5097', 'task-wf:1:14', '5010', '5010', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 10:45:43.99', '2017-06-09 10:45:43.995', 5, '');
INSERT INTO act_hi_actinst VALUES ('5080', 'task-wf:1:14', '5010', '5010', 'planningByManager', '5081', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:45:25.54', '2017-06-09 10:45:43.989', 18449, '');
INSERT INTO act_hi_actinst VALUES ('5104', 'task-wf:1:14', '5023', '5023', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 10:45:53.168', '2017-06-09 10:45:53.173', 5, '');
INSERT INTO act_hi_actinst VALUES ('5087', 'task-wf:1:14', '5023', '5023', 'planningByManager', '5088', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:45:25.562', '2017-06-09 10:45:53.168', 27606, '');
INSERT INTO act_hi_actinst VALUES ('5111', 'task-wf:1:14', '5010', '5010', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 10:47:02.054', '2017-06-09 10:47:02.059', 5, '');
INSERT INTO act_hi_actinst VALUES ('5112', 'task-wf:1:14', '5010', '5010', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 10:47:02.059', '2017-06-09 10:47:02.072', 13, '');
INSERT INTO act_hi_actinst VALUES ('5113', 'project-wf:1:18', '5001', '5001', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 10:47:02.068', '2017-06-09 10:47:02.072', 4, '');
INSERT INTO act_hi_actinst VALUES ('5117', 'task-wf:1:14', '5010', '5010', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 10:47:02.072', '2017-06-09 10:47:02.072', 0, '');
INSERT INTO act_hi_actinst VALUES ('5098', 'task-wf:1:14', '5010', '5010', 'workOnTask', '5099', NULL, 'Work on task', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:45:43.995', '2017-06-09 10:47:02.054', 78059, '');
INSERT INTO act_hi_actinst VALUES ('5119', 'project-wf:1:18', '5118', '5118', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:51:17.416', '2017-06-09 10:51:17.416', 0, '');
INSERT INTO act_hi_actinst VALUES ('5123', 'project-wf:1:18', '5118', '5118', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 10:51:17.416', '2017-06-09 10:51:17.421', 5, '');
INSERT INTO act_hi_actinst VALUES ('5128', 'task-wf:1:14', '5127', '5127', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:51:17.45', '2017-06-09 10:51:17.451', 1, '');
INSERT INTO act_hi_actinst VALUES ('5132', 'task-wf:1:14', '5127', '5127', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 10:51:17.451', '2017-06-09 10:51:17.454', 3, '');
INSERT INTO act_hi_actinst VALUES ('5141', 'task-wf:1:14', '5140', '5140', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 10:51:17.483', '2017-06-09 10:51:17.484', 1, '');
INSERT INTO act_hi_actinst VALUES ('5145', 'task-wf:1:14', '5140', '5140', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 10:51:17.484', '2017-06-09 10:51:17.487', 3, '');
INSERT INTO act_hi_actinst VALUES ('5154', 'task-wf:1:14', '5127', '5127', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:52:18.534', '2017-06-09 10:52:18.539', 5, '');
INSERT INTO act_hi_actinst VALUES ('5155', 'task-wf:1:14', '5127', '5127', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 10:52:18.539', '2017-06-09 10:52:18.552', 13, '');
INSERT INTO act_hi_actinst VALUES ('5146', 'task-wf:1:14', '5140', '5140', 'estimation', '5147', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:51:17.487', '2017-06-09 10:52:47.125', 89638, '');
INSERT INTO act_hi_actinst VALUES ('5105', 'task-wf:1:14', '5023', '5023', 'workOnTask', '5106', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:45:53.173', '2017-06-09 12:22:44.848', 5811675, '');
INSERT INTO act_hi_actinst VALUES ('5116', 'project-wf:1:18', '5001', '5114', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 10:47:02.072', '2017-06-09 12:22:44.857', 5742785, '');
INSERT INTO act_hi_actinst VALUES ('5156', 'project-wf:1:18', '5118', '5118', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 10:52:18.549', '2017-06-09 10:52:18.552', 3, '');
INSERT INTO act_hi_actinst VALUES ('5133', 'task-wf:1:14', '5127', '5127', 'estimation', '5134', NULL, 'Estimation', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:51:17.454', '2017-06-09 10:52:18.534', 61080, '');
INSERT INTO act_hi_actinst VALUES ('5126', 'project-wf:1:18', '5118', '5124', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 10:51:17.421', '2017-06-09 10:52:18.547', 61126, '');
INSERT INTO act_hi_actinst VALUES ('5164', 'task-wf:1:14', '5140', '5140', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:52:47.125', '2017-06-09 10:52:47.129', 4, '');
INSERT INTO act_hi_actinst VALUES ('5165', 'task-wf:1:14', '5140', '5140', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 10:52:47.129', '2017-06-09 10:52:47.159', 30, '');
INSERT INTO act_hi_actinst VALUES ('5166', 'project-wf:1:18', '5118', '5118', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 10:52:47.136', '2017-06-09 10:52:47.139', 3, '');
INSERT INTO act_hi_actinst VALUES ('5167', 'project-wf:1:18', '5118', '5118', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 10:52:47.139', '2017-06-09 10:52:47.143', 4, '');
INSERT INTO act_hi_actinst VALUES ('5168', 'project-wf:1:18', '5118', '5118', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:52:47.143', '2017-06-09 10:52:47.143', 0, '');
INSERT INTO act_hi_actinst VALUES ('5159', 'project-wf:1:18', '5118', '5157', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 10:52:18.552', '2017-06-09 10:52:47.134', 28582, '');
INSERT INTO act_hi_actinst VALUES ('5233', 'project-wf:1:18', '5118', '5231', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 11:00:12.199', '2017-06-09 11:00:34.362', 22163, '');
INSERT INTO act_hi_actinst VALUES ('5192', 'project-wf:1:18', '5118', '5170', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:54:25.956', '2017-06-09 10:54:25.958', 2, '');
INSERT INTO act_hi_actinst VALUES ('5178', 'project-wf:1:18', '5118', '5170', 'projectOfficeApproval', '5179', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 10:52:47.153', '2017-06-09 10:54:25.956', 98803, '');
INSERT INTO act_hi_actinst VALUES ('5194', 'project-wf:1:18', '5118', '5169', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 10:54:48.739', '2017-06-09 10:54:48.74', 1, '');
INSERT INTO act_hi_actinst VALUES ('5195', 'project-wf:1:18', '5118', '5118', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 10:54:48.742', '2017-06-09 10:54:48.748', 6, '');
INSERT INTO act_hi_actinst VALUES ('5196', 'project-wf:1:18', '5118', '5118', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 10:54:48.748', '2017-06-09 10:54:48.782', 34, '');
INSERT INTO act_hi_actinst VALUES ('5162', 'task-wf:1:14', '5127', '5160', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 10:52:18.553', '2017-06-09 10:54:48.752', 150199, '');
INSERT INTO act_hi_actinst VALUES ('5190', 'task-wf:1:14', '5140', '5188', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 10:52:47.159', '2017-06-09 10:54:48.769', 121610, '');
INSERT INTO act_hi_actinst VALUES ('5171', 'project-wf:1:18', '5118', '5169', 'managerApproval', '5172', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:52:47.143', '2017-06-09 10:54:48.739', 121596, '');
INSERT INTO act_hi_actinst VALUES ('5214', 'task-wf:1:14', '5140', '5140', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 10:56:26.707', '2017-06-09 10:56:26.712', 5, '');
INSERT INTO act_hi_actinst VALUES ('5204', 'task-wf:1:14', '5140', '5140', 'planningByManager', '5205', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:54:48.771', '2017-06-09 10:56:26.707', 97936, '');
INSERT INTO act_hi_actinst VALUES ('5221', 'task-wf:1:14', '5127', '5127', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 10:56:31.754', '2017-06-09 10:56:31.758', 4, '');
INSERT INTO act_hi_actinst VALUES ('5197', 'task-wf:1:14', '5127', '5127', 'planningByManager', '5198', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:54:48.756', '2017-06-09 10:56:31.754', 102998, '');
INSERT INTO act_hi_actinst VALUES ('5228', 'task-wf:1:14', '5127', '5127', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 11:00:12.186', '2017-06-09 11:00:12.191', 5, '');
INSERT INTO act_hi_actinst VALUES ('5229', 'task-wf:1:14', '5127', '5127', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 11:00:12.191', '2017-06-09 11:00:12.199', 8, '');
INSERT INTO act_hi_actinst VALUES ('5230', 'project-wf:1:18', '5118', '5118', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 11:00:12.197', '2017-06-09 11:00:12.199', 2, '');
INSERT INTO act_hi_actinst VALUES ('5234', 'task-wf:1:14', '5127', '5127', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 11:00:12.199', '2017-06-09 11:00:12.199', 0, '');
INSERT INTO act_hi_actinst VALUES ('5222', 'task-wf:1:14', '5127', '5127', 'workOnTask', '5223', NULL, 'Work on task', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:56:31.758', '2017-06-09 11:00:12.186', 220428, '');
INSERT INTO act_hi_actinst VALUES ('5213', 'project-wf:1:18', '5118', '5211', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 10:54:48.782', '2017-06-09 11:00:12.195', 323413, '');
INSERT INTO act_hi_actinst VALUES ('5235', 'task-wf:1:14', '5140', '5140', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 11:00:34.353', '2017-06-09 11:00:34.358', 5, '');
INSERT INTO act_hi_actinst VALUES ('5236', 'task-wf:1:14', '5140', '5140', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 11:00:34.358', '2017-06-09 11:00:34.376', 18, '');
INSERT INTO act_hi_actinst VALUES ('5237', 'project-wf:1:18', '5118', '5118', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 11:00:34.364', '2017-06-09 11:00:34.366', 2, '');
INSERT INTO act_hi_actinst VALUES ('5238', 'project-wf:1:18', '5118', '5118', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 11:00:34.366', '2017-06-09 11:00:34.372', 6, '');
INSERT INTO act_hi_actinst VALUES ('5239', 'project-wf:1:18', '5118', '5118', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 11:00:34.372', '2017-06-09 11:00:34.372', 0, '');
INSERT INTO act_hi_actinst VALUES ('5240', 'task-wf:1:14', '5140', '5140', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 11:00:34.376', '2017-06-09 11:00:34.376', 0, '');
INSERT INTO act_hi_actinst VALUES ('5215', 'task-wf:1:14', '5140', '5140', 'workOnTask', '5216', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:56:26.712', '2017-06-09 11:00:34.353', 247641, '');
INSERT INTO act_hi_actinst VALUES ('5254', 'project-wf:2:5252', '5253', '5253', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 11:11:29.713', '2017-06-09 11:11:29.713', 0, '');
INSERT INTO act_hi_actinst VALUES ('5258', 'project-wf:2:5252', '5253', '5253', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 11:11:29.713', '2017-06-09 11:11:29.718', 5, '');
INSERT INTO act_hi_actinst VALUES ('5263', 'task-wf:3:5248', '5262', '5262', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 11:11:29.766', '2017-06-09 11:11:29.766', 0, '');
INSERT INTO act_hi_actinst VALUES ('5267', 'task-wf:3:5248', '5262', '5262', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 11:11:29.766', '2017-06-09 11:11:29.77', 4, '');
INSERT INTO act_hi_actinst VALUES ('7502', 'project-wf:2:5252', '7501', '7501', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:02:05.834', '2017-06-09 12:02:05.849', 15, '');
INSERT INTO act_hi_actinst VALUES ('7506', 'project-wf:2:5252', '7501', '7501', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 12:02:05.849', '2017-06-09 12:02:05.863', 14, '');
INSERT INTO act_hi_actinst VALUES ('7511', 'task-wf:3:5248', '7510', '7510', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:02:05.943', '2017-06-09 12:02:05.943', 0, '');
INSERT INTO act_hi_actinst VALUES ('5261', 'project-wf:2:5252', '5253', '5259', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 11:11:29.718', '2017-06-09 12:09:33.833', 3484115, '');
INSERT INTO act_hi_actinst VALUES ('5268', 'task-wf:3:5248', '5262', '5262', 'estimation', '5269', NULL, 'Estimation', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 11:11:29.771', '2017-06-09 12:09:33.782', 3484011, '');
INSERT INTO act_hi_actinst VALUES ('7509', 'project-wf:2:5252', '7501', '7507', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 12:02:05.863', '2017-06-09 12:11:57.999', 592136, '');
INSERT INTO act_hi_actinst VALUES ('7515', 'task-wf:3:5248', '7510', '7510', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 12:02:05.943', '2017-06-09 12:02:05.95', 7, '');
INSERT INTO act_hi_actinst VALUES ('7524', 'project-wf:2:5252', '7523', '7523', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:04:17.418', '2017-06-09 12:04:17.419', 1, '');
INSERT INTO act_hi_actinst VALUES ('7528', 'project-wf:2:5252', '7523', '7523', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 12:04:17.419', '2017-06-09 12:04:17.425', 6, '');
INSERT INTO act_hi_actinst VALUES ('7533', 'task-wf:3:5248', '7532', '7532', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:04:17.462', '2017-06-09 12:04:17.463', 1, '');
INSERT INTO act_hi_actinst VALUES ('7537', 'task-wf:3:5248', '7532', '7532', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 12:04:17.463', '2017-06-09 12:04:17.467', 4, '');
INSERT INTO act_hi_actinst VALUES ('7546', 'project-wf:2:5252', '7545', '7545', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:05:00.054', '2017-06-09 12:05:00.055', 1, '');
INSERT INTO act_hi_actinst VALUES ('7550', 'project-wf:2:5252', '7545', '7545', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 12:05:00.055', '2017-06-09 12:05:00.061', 6, '');
INSERT INTO act_hi_actinst VALUES ('7555', 'task-wf:3:5248', '7554', '7554', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:05:00.094', '2017-06-09 12:05:00.095', 1, '');
INSERT INTO act_hi_actinst VALUES ('7559', 'task-wf:3:5248', '7554', '7554', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 12:05:00.095', '2017-06-09 12:05:00.1', 5, '');
INSERT INTO act_hi_actinst VALUES ('10002', 'task-wf:3:5248', '5262', '5262', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:09:33.782', '2017-06-09 12:09:33.795', 13, '');
INSERT INTO act_hi_actinst VALUES ('10003', 'task-wf:3:5248', '5262', '5262', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:09:33.795', '2017-06-09 12:09:33.894', 99, '');
INSERT INTO act_hi_actinst VALUES ('10004', 'project-wf:2:5252', '5253', '5253', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:09:33.836', '2017-06-09 12:09:33.85', 14, '');
INSERT INTO act_hi_actinst VALUES ('10005', 'project-wf:2:5252', '5253', '5253', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:09:33.85', '2017-06-09 12:09:33.855', 5, '');
INSERT INTO act_hi_actinst VALUES ('10006', 'project-wf:2:5252', '5253', '5253', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:09:33.855', '2017-06-09 12:09:33.855', 0, '');
INSERT INTO act_hi_actinst VALUES ('10039', 'project-wf:2:5252', '7501', '10037', 'managerApproval', '10040', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:11:58.013', '2017-06-09 12:12:26.876', 28863, '');
INSERT INTO act_hi_actinst VALUES ('10030', 'project-wf:2:5252', '5253', '10008', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:09:55.525', '2017-06-09 12:09:55.528', 3, '');
INSERT INTO act_hi_actinst VALUES ('10016', 'project-wf:2:5252', '5253', '10008', 'projectOfficeApproval', '10017', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:09:33.885', '2017-06-09 12:09:55.525', 21640, '');
INSERT INTO act_hi_actinst VALUES ('10032', 'task-wf:3:5248', '7510', '7510', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:11:57.985', '2017-06-09 12:11:57.992', 7, '');
INSERT INTO act_hi_actinst VALUES ('10033', 'task-wf:3:5248', '7510', '7510', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:11:57.992', '2017-06-09 12:11:58.035', 43, '');
INSERT INTO act_hi_actinst VALUES ('10034', 'project-wf:2:5252', '7501', '7501', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:11:58.002', '2017-06-09 12:11:58.006', 4, '');
INSERT INTO act_hi_actinst VALUES ('10035', 'project-wf:2:5252', '7501', '7501', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:11:58.006', '2017-06-09 12:11:58.011', 5, '');
INSERT INTO act_hi_actinst VALUES ('10036', 'project-wf:2:5252', '7501', '7501', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:11:58.011', '2017-06-09 12:11:58.011', 0, '');
INSERT INTO act_hi_actinst VALUES ('7516', 'task-wf:3:5248', '7510', '7510', 'estimation', '7517', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:02:05.95', '2017-06-09 12:11:57.984', 592034, '');
INSERT INTO act_hi_actinst VALUES ('10076', 'project-wf:2:5252', '10075', '10075', 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:19:50.727', '2017-06-09 12:19:50.728', 1, '');
INSERT INTO act_hi_actinst VALUES ('10060', 'project-wf:2:5252', '7501', '10038', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:12:09.151', '2017-06-09 12:12:09.152', 1, '');
INSERT INTO act_hi_actinst VALUES ('10046', 'project-wf:2:5252', '7501', '10038', 'projectOfficeApproval', '10047', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:11:58.028', '2017-06-09 12:12:09.151', 11123, '');
INSERT INTO act_hi_actinst VALUES ('10062', 'project-wf:2:5252', '7501', '10037', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:12:26.876', '2017-06-09 12:12:26.877', 1, '');
INSERT INTO act_hi_actinst VALUES ('10063', 'project-wf:2:5252', '7501', '7501', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 12:12:26.88', '2017-06-09 12:12:26.886', 6, '');
INSERT INTO act_hi_actinst VALUES ('10064', 'project-wf:2:5252', '7501', '7501', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 12:12:26.886', '2017-06-09 12:12:26.91', 24, '');
INSERT INTO act_hi_actinst VALUES ('10058', 'task-wf:3:5248', '7510', '10056', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:11:58.035', '2017-06-09 12:12:26.893', 28858, '');
INSERT INTO act_hi_actinst VALUES ('10080', 'project-wf:2:5252', '10075', '10075', 'sid-7501F3A2-4219-4951-87B6-CAD40F124B31', NULL, NULL, 'Set IDEA', 'serviceTask', NULL, '2017-06-09 12:19:50.728', '2017-06-09 12:19:50.733', 5, '');
INSERT INTO act_hi_actinst VALUES ('10085', 'task-wf:3:5248', '10084', '10084', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:19:50.81', '2017-06-09 12:19:50.81', 0, '');
INSERT INTO act_hi_actinst VALUES ('10089', 'task-wf:3:5248', '10084', '10084', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 12:19:50.81', '2017-06-09 12:19:50.814', 4, '');
INSERT INTO act_hi_actinst VALUES ('10098', 'task-wf:3:5248', '10097', '10097', 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', NULL, NULL, NULL, 'startEvent', NULL, '2017-06-09 12:19:50.846', '2017-06-09 12:19:50.847', 1, '');
INSERT INTO act_hi_actinst VALUES ('10102', 'task-wf:3:5248', '10097', '10097', 'sid-A6ED3CAA-9E7D-4264-84B7-F935AB4F9AED', NULL, NULL, 'Set ESTIMATION ', 'serviceTask', NULL, '2017-06-09 12:19:50.847', '2017-06-09 12:19:50.851', 4, '');
INSERT INTO act_hi_actinst VALUES ('10090', 'task-wf:3:5248', '10084', '10084', 'estimation', '10091', NULL, 'Estimation', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:19:50.814', '2017-06-09 12:20:19.929', 29115, '');
INSERT INTO act_hi_actinst VALUES ('10083', 'project-wf:2:5252', '10075', '10081', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 12:19:50.733', '2017-06-09 12:20:19.94', 29207, '');
INSERT INTO act_hi_actinst VALUES ('7560', 'task-wf:3:5248', '7554', '7554', 'estimation', '7561', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:05:00.1', '2017-06-09 12:22:49.892', 1069792, '');
INSERT INTO act_hi_actinst VALUES ('7553', 'project-wf:2:5252', '7545', '7551', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 12:05:00.061', '2017-06-09 12:22:49.902', 1069841, '');
INSERT INTO act_hi_actinst VALUES ('7531', 'project-wf:2:5252', '7523', '7529', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 12:04:17.426', '2017-06-09 12:22:54.66', 1117234, '');
INSERT INTO act_hi_actinst VALUES ('10009', 'project-wf:2:5252', '5253', '10007', 'managerApproval', '10010', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:09:33.857', '2017-06-09 12:23:25.01', 831153, '');
INSERT INTO act_hi_actinst VALUES ('10028', 'task-wf:3:5248', '5262', '10026', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:09:33.895', '2017-06-09 12:23:25.021', 831126, '');
INSERT INTO act_hi_actinst VALUES ('10065', 'task-wf:3:5248', '7510', '7510', 'planningByManager', '10066', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:12:26.895', '2017-06-09 12:23:39.486', 672591, '');
INSERT INTO act_hi_actinst VALUES ('10074', 'project-wf:2:5252', '7501', '10072', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:12:26.91', '2017-06-09 12:24:16.435', 709525, '');
INSERT INTO act_hi_actinst VALUES ('10111', 'task-wf:3:5248', '10084', '10084', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:20:19.929', '2017-06-09 12:20:19.934', 5, '');
INSERT INTO act_hi_actinst VALUES ('10112', 'task-wf:3:5248', '10084', '10084', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:20:19.934', '2017-06-09 12:20:19.945', 11, '');
INSERT INTO act_hi_actinst VALUES ('10113', 'project-wf:2:5252', '10075', '10075', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:20:19.942', '2017-06-09 12:20:19.945', 3, '');
INSERT INTO act_hi_actinst VALUES ('10121', 'task-wf:3:5248', '10097', '10097', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:20:32.473', '2017-06-09 12:20:32.492', 19, '');
INSERT INTO act_hi_actinst VALUES ('10122', 'task-wf:3:5248', '10097', '10097', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:20:32.492', '2017-06-09 12:20:32.527', 35, '');
INSERT INTO act_hi_actinst VALUES ('10123', 'project-wf:2:5252', '10075', '10075', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:20:32.5', '2017-06-09 12:20:32.503', 3, '');
INSERT INTO act_hi_actinst VALUES ('10124', 'project-wf:2:5252', '10075', '10075', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:20:32.503', '2017-06-09 12:20:32.507', 4, '');
INSERT INTO act_hi_actinst VALUES ('10125', 'project-wf:2:5252', '10075', '10075', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:20:32.507', '2017-06-09 12:20:32.507', 0, '');
INSERT INTO act_hi_actinst VALUES ('10103', 'task-wf:3:5248', '10097', '10097', 'estimation', '10104', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:19:50.851', '2017-06-09 12:20:32.473', 41622, '');
INSERT INTO act_hi_actinst VALUES ('10116', 'project-wf:2:5252', '10075', '10114', 'sid-2ACEC5AE-81CB-4B86-A622-889D6F7DDFE2', NULL, NULL, 'Wait for tasks estimation ', 'intermediateSignalCatch', NULL, '2017-06-09 12:20:19.945', '2017-06-09 12:20:32.498', 12553, '');
INSERT INTO act_hi_actinst VALUES ('10149', 'project-wf:2:5252', '10075', '10126', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:21:04.33', '2017-06-09 12:21:04.331', 1, '');
INSERT INTO act_hi_actinst VALUES ('10128', 'project-wf:2:5252', '10075', '10126', 'managerApproval', '10129', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:20:32.508', '2017-06-09 12:21:04.33', 31822, '');
INSERT INTO act_hi_actinst VALUES ('10190', 'project-wf:2:5252', '10075', '10188', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:22:18.847', '2017-06-09 12:22:38.06', 19213, '');
INSERT INTO act_hi_actinst VALUES ('10151', 'project-wf:2:5252', '10075', '10127', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:21:21.436', '2017-06-09 12:21:21.438', 2, '');
INSERT INTO act_hi_actinst VALUES ('10152', 'project-wf:2:5252', '10075', '10075', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 12:21:21.441', '2017-06-09 12:21:21.446', 5, '');
INSERT INTO act_hi_actinst VALUES ('10153', 'project-wf:2:5252', '10075', '10075', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 12:21:21.446', '2017-06-09 12:21:21.476', 30, '');
INSERT INTO act_hi_actinst VALUES ('10119', 'task-wf:3:5248', '10084', '10117', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:20:19.945', '2017-06-09 12:21:21.451', 61506, '');
INSERT INTO act_hi_actinst VALUES ('10147', 'task-wf:3:5248', '10097', '10145', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:20:32.528', '2017-06-09 12:21:21.465', 48937, '');
INSERT INTO act_hi_actinst VALUES ('10135', 'project-wf:2:5252', '10075', '10127', 'projectOfficeApproval', '10136', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:20:32.52', '2017-06-09 12:21:21.436', 48916, '');
INSERT INTO act_hi_actinst VALUES ('10171', 'task-wf:3:5248', '10084', '10084', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:21:39.629', '2017-06-09 12:21:39.634', 5, '');
INSERT INTO act_hi_actinst VALUES ('10154', 'task-wf:3:5248', '10084', '10084', 'planningByManager', '10155', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:21:21.453', '2017-06-09 12:21:39.629', 18176, '');
INSERT INTO act_hi_actinst VALUES ('10178', 'task-wf:3:5248', '10097', '10097', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:21:47.478', '2017-06-09 12:21:47.483', 5, '');
INSERT INTO act_hi_actinst VALUES ('10161', 'task-wf:3:5248', '10097', '10097', 'planningByManager', '10162', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:21:21.467', '2017-06-09 12:21:47.478', 26011, '');
INSERT INTO act_hi_actinst VALUES ('10185', 'task-wf:3:5248', '10084', '10084', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:22:18.827', '2017-06-09 12:22:18.833', 6, '');
INSERT INTO act_hi_actinst VALUES ('10186', 'task-wf:3:5248', '10084', '10084', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:22:18.833', '2017-06-09 12:22:18.847', 14, '');
INSERT INTO act_hi_actinst VALUES ('10187', 'project-wf:2:5252', '10075', '10075', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:22:18.844', '2017-06-09 12:22:18.847', 3, '');
INSERT INTO act_hi_actinst VALUES ('10191', 'task-wf:3:5248', '10084', '10084', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:22:18.847', '2017-06-09 12:22:18.847', 0, '');
INSERT INTO act_hi_actinst VALUES ('10170', 'project-wf:2:5252', '10075', '10168', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:21:21.476', '2017-06-09 12:22:18.84', 57364, '');
INSERT INTO act_hi_actinst VALUES ('10172', 'task-wf:3:5248', '10084', '10084', 'workOnTask', '10173', NULL, 'Work on task', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:21:39.634', '2017-06-09 12:22:18.827', 39193, '');
INSERT INTO act_hi_actinst VALUES ('10192', 'task-wf:3:5248', '10097', '10097', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:22:38.05', '2017-06-09 12:22:38.054', 4, '');
INSERT INTO act_hi_actinst VALUES ('10193', 'task-wf:3:5248', '10097', '10097', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:22:38.054', '2017-06-09 12:22:38.071', 17, '');
INSERT INTO act_hi_actinst VALUES ('10194', 'project-wf:2:5252', '10075', '10075', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:22:38.062', '2017-06-09 12:22:38.064', 2, '');
INSERT INTO act_hi_actinst VALUES ('10195', 'project-wf:2:5252', '10075', '10075', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:22:38.064', '2017-06-09 12:22:38.068', 4, '');
INSERT INTO act_hi_actinst VALUES ('10196', 'project-wf:2:5252', '10075', '10075', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:22:38.068', '2017-06-09 12:22:38.068', 0, '');
INSERT INTO act_hi_actinst VALUES ('10179', 'task-wf:3:5248', '10097', '10097', 'workOnTask', '10180', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:21:47.483', '2017-06-09 12:22:38.05', 50567, '');
INSERT INTO act_hi_actinst VALUES ('10197', 'task-wf:3:5248', '10097', '10097', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:22:38.071', '2017-06-09 12:22:38.071', 0, '');
INSERT INTO act_hi_actinst VALUES ('10198', 'task-wf:3:5248', '5023', '5023', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:22:44.848', '2017-06-09 12:22:44.853', 5, '');
INSERT INTO act_hi_actinst VALUES ('10199', 'task-wf:3:5248', '5023', '5023', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:22:44.853', '2017-06-09 12:22:44.868', 15, '');
INSERT INTO act_hi_actinst VALUES ('10200', 'project-wf:2:5252', '5001', '5001', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:22:44.859', '2017-06-09 12:22:44.862', 3, '');
INSERT INTO act_hi_actinst VALUES ('10201', 'project-wf:2:5252', '5001', '5001', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:22:44.862', '2017-06-09 12:22:44.864', 2, '');
INSERT INTO act_hi_actinst VALUES ('10202', 'project-wf:2:5252', '5001', '5001', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:22:44.864', '2017-06-09 12:22:44.864', 0, '');
INSERT INTO act_hi_actinst VALUES ('10203', 'task-wf:3:5248', '5023', '5023', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:22:44.868', '2017-06-09 12:22:44.868', 0, '');
INSERT INTO act_hi_actinst VALUES ('10205', 'task-wf:3:5248', '7554', '7554', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:22:49.892', '2017-06-09 12:22:49.897', 5, '');
INSERT INTO act_hi_actinst VALUES ('10206', 'task-wf:3:5248', '7554', '7554', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:22:49.897', '2017-06-09 12:22:49.925', 28, '');
INSERT INTO act_hi_actinst VALUES ('10207', 'project-wf:2:5252', '7545', '7545', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:22:49.903', '2017-06-09 12:22:49.906', 3, '');
INSERT INTO act_hi_actinst VALUES ('10208', 'project-wf:2:5252', '7545', '7545', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:22:49.906', '2017-06-09 12:22:49.908', 2, '');
INSERT INTO act_hi_actinst VALUES ('10209', 'project-wf:2:5252', '7545', '7545', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:22:49.908', '2017-06-09 12:22:49.908', 0, '');
INSERT INTO act_hi_actinst VALUES ('10233', 'task-wf:3:5248', '7532', '7532', 'sid-9FBDB78D-8C17-4129-B190-58985D518CD6', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:22:54.652', '2017-06-09 12:22:54.655', 3, '');
INSERT INTO act_hi_actinst VALUES ('10234', 'task-wf:3:5248', '7532', '7532', 'sid-80358D21-6714-4D81-A4E3-6CDF64374244', NULL, NULL, 'Signal Task Estimated', 'serviceTask', NULL, '2017-06-09 12:22:54.655', '2017-06-09 12:22:54.684', 29, '');
INSERT INTO act_hi_actinst VALUES ('10235', 'project-wf:2:5252', '7523', '7523', 'sid-E1F33A26-BC75-42F0-BCB1-BB82714B881D', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:22:54.661', '2017-06-09 12:22:54.664', 3, '');
INSERT INTO act_hi_actinst VALUES ('10236', 'project-wf:2:5252', '7523', '7523', 'sid-7B41B808-A11D-4A44-8576-96E0BF35B030', NULL, NULL, 'Set ESTIMATED', 'serviceTask', NULL, '2017-06-09 12:22:54.664', '2017-06-09 12:22:54.667', 3, '');
INSERT INTO act_hi_actinst VALUES ('10237', 'project-wf:2:5252', '7523', '7523', 'sid-E9422A91-F75B-40B2-9C2E-93850435A359', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:22:54.667', '2017-06-09 12:22:54.667', 0, '');
INSERT INTO act_hi_actinst VALUES ('7538', 'task-wf:3:5248', '7532', '7532', 'estimation', '7539', NULL, 'Estimation', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:04:17.467', '2017-06-09 12:22:54.652', 1117185, '');
INSERT INTO act_hi_actinst VALUES ('10240', 'project-wf:2:5252', '7523', '10238', 'managerApproval', '10241', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:22:54.668', '2017-06-09 12:23:43.508', 48840, '');
INSERT INTO act_hi_actinst VALUES ('10259', 'task-wf:3:5248', '7532', '10257', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:22:54.684', '2017-06-09 12:23:43.52', 48836, '');
INSERT INTO act_hi_actinst VALUES ('10261', 'project-wf:2:5252', '7545', '10211', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:23:11.549', '2017-06-09 12:23:11.549', 0, '');
INSERT INTO act_hi_actinst VALUES ('10219', 'project-wf:2:5252', '7545', '10211', 'projectOfficeApproval', '10220', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:22:49.919', '2017-06-09 12:23:11.549', 21630, '');
INSERT INTO act_hi_actinst VALUES ('10263', 'project-wf:2:5252', '7523', '10239', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:23:14.411', '2017-06-09 12:23:14.412', 1, '');
INSERT INTO act_hi_actinst VALUES ('10247', 'project-wf:2:5252', '7523', '10239', 'projectOfficeApproval', '10248', NULL, 'Project office approval', 'userTask', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:22:54.679', '2017-06-09 12:23:14.411', 19732, '');
INSERT INTO act_hi_actinst VALUES ('10265', 'project-wf:2:5252', '5253', '10007', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:23:25.01', '2017-06-09 12:23:25.011', 1, '');
INSERT INTO act_hi_actinst VALUES ('10266', 'project-wf:2:5252', '5253', '5253', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 12:23:25.013', '2017-06-09 12:23:25.018', 5, '');
INSERT INTO act_hi_actinst VALUES ('10267', 'project-wf:2:5252', '5253', '5253', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 12:23:25.018', '2017-06-09 12:23:25.031', 13, '');
INSERT INTO act_hi_actinst VALUES ('10278', 'task-wf:3:5248', '5262', '5262', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:23:32.89', '2017-06-09 12:23:32.894', 4, '');
INSERT INTO act_hi_actinst VALUES ('10268', 'task-wf:3:5248', '5262', '5262', 'planningByManager', '10269', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:25.023', '2017-06-09 12:23:32.89', 7867, '');
INSERT INTO act_hi_actinst VALUES ('10285', 'task-wf:3:5248', '7510', '7510', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:23:39.486', '2017-06-09 12:23:39.489', 3, '');
INSERT INTO act_hi_actinst VALUES ('10293', 'project-wf:2:5252', '7523', '10238', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:23:43.508', '2017-06-09 12:23:43.509', 1, '');
INSERT INTO act_hi_actinst VALUES ('10294', 'project-wf:2:5252', '7523', '7523', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 12:23:43.511', '2017-06-09 12:23:43.515', 4, '');
INSERT INTO act_hi_actinst VALUES ('10295', 'project-wf:2:5252', '7523', '7523', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 12:23:43.515', '2017-06-09 12:23:43.547', 32, '');
INSERT INTO act_hi_actinst VALUES ('10307', 'project-wf:2:5252', '7545', '10210', 'sid-6CD2E615-56F1-4B52-89ED-F95D8A3C125A', NULL, NULL, NULL, 'parallelGateway', NULL, '2017-06-09 12:23:47.9', '2017-06-09 12:23:47.901', 1, '');
INSERT INTO act_hi_actinst VALUES ('10308', 'project-wf:2:5252', '7545', '7545', 'sid-48616346-A345-4C68-B184-159E7C128DB7', NULL, NULL, 'Set EXECUTION', 'serviceTask', NULL, '2017-06-09 12:23:47.903', '2017-06-09 12:23:47.908', 5, '');
INSERT INTO act_hi_actinst VALUES ('10309', 'project-wf:2:5252', '7545', '7545', 'sid-66618E04-93B4-45DA-968B-93A4D4986A49', NULL, NULL, 'Signal tasks that project approved', 'serviceTask', NULL, '2017-06-09 12:23:47.908', '2017-06-09 12:23:47.922', 14, '');
INSERT INTO act_hi_actinst VALUES ('10231', 'task-wf:3:5248', '7554', '10229', 'sid-640525B7-2198-4BD9-A4D4-05D42759F802', NULL, NULL, 'Wait for project approval', 'intermediateSignalCatch', NULL, '2017-06-09 12:22:49.925', '2017-06-09 12:23:47.911', 57986, '');
INSERT INTO act_hi_actinst VALUES ('10212', 'project-wf:2:5252', '7545', '10210', 'managerApproval', '10213', NULL, 'Manager approval', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:22:49.909', '2017-06-09 12:23:47.9', 57991, '');
INSERT INTO act_hi_actinst VALUES ('10310', 'task-wf:3:5248', '7554', '7554', 'planningByManager', '10311', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:47.913', '2017-06-09 12:23:54.801', 6888, '');
INSERT INTO act_hi_actinst VALUES ('10296', 'task-wf:3:5248', '7532', '7532', 'planningByManager', '10297', NULL, 'Planning by manager', 'userTask', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:43.521', '2017-06-09 12:24:00.382', 16861, '');
INSERT INTO act_hi_actinst VALUES ('10277', 'project-wf:2:5252', '5253', '10275', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:23:25.031', '2017-06-09 12:24:08.291', 43260, '');
INSERT INTO act_hi_actinst VALUES ('10279', 'task-wf:3:5248', '5262', '5262', 'workOnTask', '10280', NULL, 'Work on task', 'userTask', '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:23:32.894', '2017-06-09 12:24:08.266', 35372, '');
INSERT INTO act_hi_actinst VALUES ('10286', 'task-wf:3:5248', '7510', '7510', 'workOnTask', '10287', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:23:39.489', '2017-06-09 12:24:16.428', 36939, '');
INSERT INTO act_hi_actinst VALUES ('10305', 'project-wf:2:5252', '7523', '10303', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:23:43.547', '2017-06-09 12:24:23.649', 40102, '');
INSERT INTO act_hi_actinst VALUES ('10320', 'task-wf:3:5248', '7554', '7554', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:23:54.801', '2017-06-09 12:23:54.806', 5, '');
INSERT INTO act_hi_actinst VALUES ('10327', 'task-wf:3:5248', '7532', '7532', 'sid-C841C8F2-AA23-46C8-A10F-C9A40A99E927', NULL, NULL, 'Set IN_WORK', 'serviceTask', NULL, '2017-06-09 12:24:00.382', '2017-06-09 12:24:00.386', 4, '');
INSERT INTO act_hi_actinst VALUES ('10334', 'task-wf:3:5248', '5262', '5262', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:08.266', '2017-06-09 12:24:08.27', 4, '');
INSERT INTO act_hi_actinst VALUES ('10335', 'task-wf:3:5248', '5262', '5262', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:24:08.27', '2017-06-09 12:24:08.3', 30, '');
INSERT INTO act_hi_actinst VALUES ('10336', 'project-wf:2:5252', '5253', '5253', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:24:08.293', '2017-06-09 12:24:08.295', 2, '');
INSERT INTO act_hi_actinst VALUES ('10337', 'project-wf:2:5252', '5253', '5253', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:08.295', '2017-06-09 12:24:08.297', 2, '');
INSERT INTO act_hi_actinst VALUES ('10338', 'project-wf:2:5252', '5253', '5253', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:08.297', '2017-06-09 12:24:08.297', 0, '');
INSERT INTO act_hi_actinst VALUES ('10339', 'task-wf:3:5248', '5262', '5262', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:08.3', '2017-06-09 12:24:08.3', 0, '');
INSERT INTO act_hi_actinst VALUES ('10340', 'task-wf:3:5248', '7510', '7510', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:16.428', '2017-06-09 12:24:16.432', 4, '');
INSERT INTO act_hi_actinst VALUES ('10341', 'task-wf:3:5248', '7510', '7510', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:24:16.432', '2017-06-09 12:24:16.446', 14, '');
INSERT INTO act_hi_actinst VALUES ('10342', 'project-wf:2:5252', '7501', '7501', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:24:16.437', '2017-06-09 12:24:16.439', 2, '');
INSERT INTO act_hi_actinst VALUES ('10343', 'project-wf:2:5252', '7501', '7501', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:16.439', '2017-06-09 12:24:16.442', 3, '');
INSERT INTO act_hi_actinst VALUES ('10344', 'project-wf:2:5252', '7501', '7501', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:16.442', '2017-06-09 12:24:16.442', 0, '');
INSERT INTO act_hi_actinst VALUES ('10345', 'task-wf:3:5248', '7510', '7510', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:16.446', '2017-06-09 12:24:16.446', 0, '');
INSERT INTO act_hi_actinst VALUES ('10346', 'task-wf:3:5248', '7554', '7554', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:20.745', '2017-06-09 12:24:20.749', 4, '');
INSERT INTO act_hi_actinst VALUES ('10347', 'task-wf:3:5248', '7554', '7554', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:24:20.749', '2017-06-09 12:24:20.765', 16, '');
INSERT INTO act_hi_actinst VALUES ('10348', 'project-wf:2:5252', '7545', '7545', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:24:20.756', '2017-06-09 12:24:20.758', 2, '');
INSERT INTO act_hi_actinst VALUES ('10349', 'project-wf:2:5252', '7545', '7545', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:20.758', '2017-06-09 12:24:20.761', 3, '');
INSERT INTO act_hi_actinst VALUES ('10350', 'project-wf:2:5252', '7545', '7545', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:20.761', '2017-06-09 12:24:20.761', 0, '');
INSERT INTO act_hi_actinst VALUES ('10351', 'task-wf:3:5248', '7554', '7554', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:20.765', '2017-06-09 12:24:20.765', 0, '');
INSERT INTO act_hi_actinst VALUES ('10319', 'project-wf:2:5252', '7545', '10317', 'sid-C192C37F-0541-4469-BB30-21FD6A4F6BA3', NULL, NULL, 'Wait for tasks completion', 'intermediateSignalCatch', NULL, '2017-06-09 12:23:47.922', '2017-06-09 12:24:20.754', 32832, '');
INSERT INTO act_hi_actinst VALUES ('10321', 'task-wf:3:5248', '7554', '7554', 'workOnTask', '10322', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:23:54.806', '2017-06-09 12:24:20.745', 25939, '');
INSERT INTO act_hi_actinst VALUES ('10352', 'task-wf:3:5248', '7532', '7532', 'sid-C15C57B9-A34D-4536-B01F-1D53E0C74C8D', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:23.64', '2017-06-09 12:24:23.645', 5, '');
INSERT INTO act_hi_actinst VALUES ('10353', 'task-wf:3:5248', '7532', '7532', 'sid-63E3F3B4-3CD6-4CB9-B638-BDF515A3CAC0', NULL, NULL, 'Signal Task Completed', 'serviceTask', NULL, '2017-06-09 12:24:23.645', '2017-06-09 12:24:23.657', 12, '');
INSERT INTO act_hi_actinst VALUES ('10354', 'project-wf:2:5252', '7523', '7523', 'sid-AE57E96F-CBFF-4E34-AD72-3D44BDD5C0AE', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2017-06-09 12:24:23.651', '2017-06-09 12:24:23.653', 2, '');
INSERT INTO act_hi_actinst VALUES ('10355', 'project-wf:2:5252', '7523', '7523', 'sid-D9C259E0-0BC5-440A-924A-735A2FFB7AF4', NULL, NULL, 'Set COMPLETED', 'serviceTask', NULL, '2017-06-09 12:24:23.653', '2017-06-09 12:24:23.655', 2, '');
INSERT INTO act_hi_actinst VALUES ('10356', 'project-wf:2:5252', '7523', '7523', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:23.655', '2017-06-09 12:24:23.655', 0, '');
INSERT INTO act_hi_actinst VALUES ('10357', 'task-wf:3:5248', '7532', '7532', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, NULL, 'endEvent', NULL, '2017-06-09 12:24:23.657', '2017-06-09 12:24:23.657', 0, '');
INSERT INTO act_hi_actinst VALUES ('10328', 'task-wf:3:5248', '7532', '7532', 'workOnTask', '10329', NULL, 'Work on task', 'userTask', '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:24:00.387', '2017-06-09 12:24:23.64', 23253, '');


--
-- TOC entry 2945 (class 0 OID 40278)
-- Dependencies: 255
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2944 (class 0 OID 40270)
-- Dependencies: 254
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2943 (class 0 OID 40262)
-- Dependencies: 253
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2946 (class 0 OID 40286)
-- Dependencies: 256
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_hi_identitylink VALUES ('2518', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '2510');
INSERT INTO act_hi_identitylink VALUES ('2531', NULL, 'participant', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, '2523');
INSERT INTO act_hi_identitylink VALUES ('2556', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '2501');
INSERT INTO act_hi_identitylink VALUES ('2563', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '2562', NULL);
INSERT INTO act_hi_identitylink VALUES ('2564', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '2501');
INSERT INTO act_hi_identitylink VALUES ('2565', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '2562', NULL);
INSERT INTO act_hi_identitylink VALUES ('2566', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '2501');
INSERT INTO act_hi_identitylink VALUES ('2582', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '2510');
INSERT INTO act_hi_identitylink VALUES ('2589', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '2523');
INSERT INTO act_hi_identitylink VALUES ('5018', NULL, 'participant', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, '5010');
INSERT INTO act_hi_identitylink VALUES ('5031', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '5023');
INSERT INTO act_hi_identitylink VALUES ('5056', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5001');
INSERT INTO act_hi_identitylink VALUES ('5063', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '5062', NULL);
INSERT INTO act_hi_identitylink VALUES ('5064', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '5001');
INSERT INTO act_hi_identitylink VALUES ('5065', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '5062', NULL);
INSERT INTO act_hi_identitylink VALUES ('5066', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '5001');
INSERT INTO act_hi_identitylink VALUES ('5082', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5010');
INSERT INTO act_hi_identitylink VALUES ('5089', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5023');
INSERT INTO act_hi_identitylink VALUES ('5135', NULL, 'participant', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, '5127');
INSERT INTO act_hi_identitylink VALUES ('5148', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '5140');
INSERT INTO act_hi_identitylink VALUES ('5173', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5118');
INSERT INTO act_hi_identitylink VALUES ('5180', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '5179', NULL);
INSERT INTO act_hi_identitylink VALUES ('5181', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '5118');
INSERT INTO act_hi_identitylink VALUES ('5182', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '5179', NULL);
INSERT INTO act_hi_identitylink VALUES ('5183', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '5118');
INSERT INTO act_hi_identitylink VALUES ('5199', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5127');
INSERT INTO act_hi_identitylink VALUES ('5206', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5140');
INSERT INTO act_hi_identitylink VALUES ('5270', NULL, 'participant', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, '5262');
INSERT INTO act_hi_identitylink VALUES ('7518', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '7510');
INSERT INTO act_hi_identitylink VALUES ('7540', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '7532');
INSERT INTO act_hi_identitylink VALUES ('7562', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '7554');
INSERT INTO act_hi_identitylink VALUES ('10011', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5253');
INSERT INTO act_hi_identitylink VALUES ('10018', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '10017', NULL);
INSERT INTO act_hi_identitylink VALUES ('10019', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '5253');
INSERT INTO act_hi_identitylink VALUES ('10020', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '10017', NULL);
INSERT INTO act_hi_identitylink VALUES ('10021', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '5253');
INSERT INTO act_hi_identitylink VALUES ('10041', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7501');
INSERT INTO act_hi_identitylink VALUES ('10048', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '10047', NULL);
INSERT INTO act_hi_identitylink VALUES ('10049', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '7501');
INSERT INTO act_hi_identitylink VALUES ('10050', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '10047', NULL);
INSERT INTO act_hi_identitylink VALUES ('10051', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '7501');
INSERT INTO act_hi_identitylink VALUES ('10067', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7510');
INSERT INTO act_hi_identitylink VALUES ('10092', NULL, 'participant', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, '10084');
INSERT INTO act_hi_identitylink VALUES ('10105', NULL, 'participant', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, '10097');
INSERT INTO act_hi_identitylink VALUES ('10130', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '10075');
INSERT INTO act_hi_identitylink VALUES ('10137', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '10136', NULL);
INSERT INTO act_hi_identitylink VALUES ('10138', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '10075');
INSERT INTO act_hi_identitylink VALUES ('10139', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '10136', NULL);
INSERT INTO act_hi_identitylink VALUES ('10140', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '10075');
INSERT INTO act_hi_identitylink VALUES ('10156', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '10084');
INSERT INTO act_hi_identitylink VALUES ('10163', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '10097');
INSERT INTO act_hi_identitylink VALUES ('10214', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7545');
INSERT INTO act_hi_identitylink VALUES ('10221', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '10220', NULL);
INSERT INTO act_hi_identitylink VALUES ('10222', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '7545');
INSERT INTO act_hi_identitylink VALUES ('10223', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '10220', NULL);
INSERT INTO act_hi_identitylink VALUES ('10224', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '7545');
INSERT INTO act_hi_identitylink VALUES ('10242', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7523');
INSERT INTO act_hi_identitylink VALUES ('10249', NULL, 'candidate', '3806b9f8-afd7-7a64-477a-393a33a9c729', '10248', NULL);
INSERT INTO act_hi_identitylink VALUES ('10250', NULL, 'participant', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, '7523');
INSERT INTO act_hi_identitylink VALUES ('10251', NULL, 'candidate', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '10248', NULL);
INSERT INTO act_hi_identitylink VALUES ('10252', NULL, 'participant', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, '7523');
INSERT INTO act_hi_identitylink VALUES ('10270', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '5262');
INSERT INTO act_hi_identitylink VALUES ('10298', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7532');
INSERT INTO act_hi_identitylink VALUES ('10312', NULL, 'participant', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, '7554');


--
-- TOC entry 2939 (class 0 OID 40225)
-- Dependencies: 249
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_hi_procinst VALUES ('2523', '2523', NULL, 'task-wf:1:14', '2017-06-08 15:08:28.467', '2017-06-08 15:13:15.559', 287092, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('2501', '2501', NULL, 'project-wf:1:18', '2017-06-08 15:08:28.29', '2017-06-08 15:13:53.689', 325399, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('2510', '2510', NULL, 'task-wf:1:14', '2017-06-08 15:08:28.399', '2017-06-08 15:13:53.693', 325294, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5010', '5010', NULL, 'task-wf:1:14', '2017-06-09 10:41:29.852', '2017-06-09 10:47:02.074', 332222, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5127', '5127', NULL, 'task-wf:1:14', '2017-06-09 10:51:17.45', '2017-06-09 11:00:12.2', 534750, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5140', '5140', NULL, 'task-wf:1:14', '2017-06-09 10:51:17.483', '2017-06-09 11:00:34.377', 556894, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5118', '5118', NULL, 'project-wf:1:18', '2017-06-09 10:51:17.416', '2017-06-09 11:00:34.373', 556957, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('10084', '10084', NULL, 'task-wf:3:5248', '2017-06-09 12:19:50.81', '2017-06-09 12:22:18.848', 148038, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('10075', '10075', NULL, 'project-wf:2:5252', '2017-06-09 12:19:50.727', '2017-06-09 12:22:38.069', 167342, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('10097', '10097', NULL, 'task-wf:3:5248', '2017-06-09 12:19:50.846', '2017-06-09 12:22:38.072', 167226, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5001', '5001', NULL, 'project-wf:2:5252', '2017-06-09 10:41:29.742', '2017-06-09 12:22:44.865', 6075123, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5023', '5023', NULL, 'task-wf:3:5248', '2017-06-09 10:41:29.932', '2017-06-09 12:22:44.868', 6074936, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5262', '5262', NULL, 'task-wf:3:5248', '2017-06-09 11:11:29.766', '2017-06-09 12:24:08.301', 4358535, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('5253', '5253', NULL, 'project-wf:2:5252', '2017-06-09 11:11:29.713', '2017-06-09 12:24:08.298', 4358585, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7510', '7510', NULL, 'task-wf:3:5248', '2017-06-09 12:02:05.943', '2017-06-09 12:24:16.447', 1330504, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7501', '7501', NULL, 'project-wf:2:5252', '2017-06-09 12:02:05.834', '2017-06-09 12:24:16.443', 1330609, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7554', '7554', NULL, 'task-wf:3:5248', '2017-06-09 12:05:00.094', '2017-06-09 12:24:20.765', 1160671, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7545', '7545', NULL, 'project-wf:2:5252', '2017-06-09 12:05:00.054', '2017-06-09 12:24:20.762', 1160708, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7532', '7532', NULL, 'task-wf:3:5248', '2017-06-09 12:04:17.462', '2017-06-09 12:24:23.658', 1206196, NULL, 'sid-4ACFCE1D-0366-47CC-A8EC-CB372D6ED9E6', 'sid-B0737F56-059B-4543-A530-4BEC4610285E', NULL, NULL, '', NULL);
INSERT INTO act_hi_procinst VALUES ('7523', '7523', NULL, 'project-wf:2:5252', '2017-06-09 12:04:17.418', '2017-06-09 12:24:23.655', 1206237, NULL, 'sid-776B0721-0756-4C50-8021-16043CA1BAD0', 'sid-7E09A612-756A-4318-85EB-06C2DB199D46', NULL, NULL, '', NULL);


--
-- TOC entry 2941 (class 0 OID 40245)
-- Dependencies: 251
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_hi_taskinst VALUES ('2530', 'task-wf:1:14', 'estimation', '2523', '2523', 'Estimation', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-08 15:08:28.471', NULL, '2017-06-08 15:08:41.7', 13229, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2517', 'task-wf:1:14', 'estimation', '2510', '2510', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-08 15:08:28.408', NULL, '2017-06-08 15:09:04.317', 35909, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2555', 'project-wf:1:18', 'managerApproval', '2501', '2552', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:09:04.349', NULL, '2017-06-08 15:11:38.262', 153913, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5205', 'task-wf:1:14', 'planningByManager', '5140', '5140', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:54:48.771', NULL, '2017-06-09 10:56:26.706', 97935, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2562', 'project-wf:1:18', 'projectOfficeApproval', '2501', '2553', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-08 15:09:04.371', '2017-06-08 15:11:46.174', '2017-06-08 15:11:49.546', 165175, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2581', 'task-wf:1:14', 'planningByManager', '2510', '2510', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:11:49.574', NULL, '2017-06-08 15:12:05.761', 16187, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2588', 'task-wf:1:14', 'planningByManager', '2523', '2523', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 15:11:49.594', NULL, '2017-06-08 15:12:14.784', 25190, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2606', 'task-wf:1:14', 'workOnTask', '2523', '2523', 'Work on task', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-08 15:12:14.797', NULL, '2017-06-08 15:13:15.539', 60742, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('2599', 'task-wf:1:14', 'workOnTask', '2510', '2510', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-08 15:12:05.782', NULL, '2017-06-08 15:13:53.667', 107885, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5017', 'task-wf:1:14', 'estimation', '5010', '5010', 'Estimation', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:41:29.862', NULL, '2017-06-09 10:42:16.236', 46374, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5030', 'task-wf:1:14', 'estimation', '5023', '5023', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:41:29.937', NULL, '2017-06-09 10:42:30.442', 60505, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5055', 'project-wf:1:18', 'managerApproval', '5001', '5052', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:42:30.475', NULL, '2017-06-09 10:43:58.234', 87759, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5062', 'project-wf:1:18', 'projectOfficeApproval', '5001', '5053', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 10:42:30.493', '2017-06-09 10:44:14.916', '2017-06-09 10:45:25.517', 175024, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5081', 'task-wf:1:14', 'planningByManager', '5010', '5010', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:45:25.54', NULL, '2017-06-09 10:45:43.985', 18445, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5088', 'task-wf:1:14', 'planningByManager', '5023', '5023', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:45:25.562', NULL, '2017-06-09 10:45:53.152', 27590, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5099', 'task-wf:1:14', 'workOnTask', '5010', '5010', 'Work on task', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:45:43.995', NULL, '2017-06-09 10:47:02.053', 78058, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5134', 'task-wf:1:14', 'estimation', '5127', '5127', 'Estimation', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:51:17.454', NULL, '2017-06-09 10:52:18.532', 61078, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5147', 'task-wf:1:14', 'estimation', '5140', '5140', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:51:17.489', NULL, '2017-06-09 10:52:47.122', 89633, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5198', 'task-wf:1:14', 'planningByManager', '5127', '5127', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:54:48.756', NULL, '2017-06-09 10:56:31.753', 102997, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5179', 'project-wf:1:18', 'projectOfficeApproval', '5118', '5170', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 10:52:47.153', '2017-06-09 10:53:58.12', '2017-06-09 10:54:25.955', 98802, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5172', 'project-wf:1:18', 'managerApproval', '5118', '5169', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 10:52:47.144', NULL, '2017-06-09 10:54:48.737', 121593, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5223', 'task-wf:1:14', 'workOnTask', '5127', '5127', 'Work on task', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 10:56:31.758', NULL, '2017-06-09 11:00:12.184', 220426, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5216', 'task-wf:1:14', 'workOnTask', '5140', '5140', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:56:26.712', NULL, '2017-06-09 11:00:34.351', 247639, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5269', 'task-wf:3:5248', 'estimation', '5262', '5262', 'Estimation', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 11:11:29.771', NULL, '2017-06-09 12:09:33.768', 3483997, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10017', 'project-wf:2:5252', 'projectOfficeApproval', '5253', '10008', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:09:33.885', '2017-06-09 12:09:43.12', '2017-06-09 12:09:55.522', 21637, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('7517', 'task-wf:3:5248', 'estimation', '7510', '7510', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:02:05.952', NULL, '2017-06-09 12:11:57.982', 592030, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10040', 'project-wf:2:5252', 'managerApproval', '7501', '10037', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:11:58.013', NULL, '2017-06-09 12:12:26.873', 28860, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10047', 'project-wf:2:5252', 'projectOfficeApproval', '7501', '10038', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:11:58.028', '2017-06-09 12:12:05.616', '2017-06-09 12:12:09.147', 11119, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10091', 'task-wf:3:5248', 'estimation', '10084', '10084', 'Estimation', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:19:50.815', NULL, '2017-06-09 12:20:19.928', 29113, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10104', 'task-wf:3:5248', 'estimation', '10097', '10097', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:19:50.851', NULL, '2017-06-09 12:20:32.472', 41621, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10129', 'project-wf:2:5252', 'managerApproval', '10075', '10126', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:20:32.509', NULL, '2017-06-09 12:21:04.327', 31818, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10136', 'project-wf:2:5252', 'projectOfficeApproval', '10075', '10127', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:20:32.521', '2017-06-09 12:21:12.058', '2017-06-09 12:21:21.435', 48914, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10155', 'task-wf:3:5248', 'planningByManager', '10084', '10084', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:21:21.453', NULL, '2017-06-09 12:21:39.628', 18175, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10162', 'task-wf:3:5248', 'planningByManager', '10097', '10097', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:21:21.467', NULL, '2017-06-09 12:21:47.477', 26010, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10173', 'task-wf:3:5248', 'workOnTask', '10084', '10084', 'Work on task', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:21:39.634', NULL, '2017-06-09 12:22:18.825', 39191, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10180', 'task-wf:3:5248', 'workOnTask', '10097', '10097', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:21:47.483', NULL, '2017-06-09 12:22:38.049', 50566, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('5106', 'task-wf:1:14', 'workOnTask', '5023', '5023', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 10:45:53.173', NULL, '2017-06-09 12:22:44.847', 5811674, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('7539', 'task-wf:3:5248', 'estimation', '7532', '7532', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:04:17.468', NULL, '2017-06-09 12:22:54.65', 1117182, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10066', 'task-wf:3:5248', 'planningByManager', '7510', '7510', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:12:26.895', NULL, '2017-06-09 12:23:39.485', 672590, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10220', 'project-wf:2:5252', 'projectOfficeApproval', '7545', '10211', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:22:49.919', '2017-06-09 12:23:05.528', '2017-06-09 12:23:11.548', 21629, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10213', 'project-wf:2:5252', 'managerApproval', '7545', '10210', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:22:49.91', NULL, '2017-06-09 12:23:47.898', 57988, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('7561', 'task-wf:3:5248', 'estimation', '7554', '7554', 'Estimation', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:05:00.101', NULL, '2017-06-09 12:22:49.891', 1069790, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10248', 'project-wf:2:5252', 'projectOfficeApproval', '7523', '10239', 'Project office approval', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-09 12:22:54.679', '2017-06-09 12:23:08.375', '2017-06-09 12:23:14.41', 19731, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10010', 'project-wf:2:5252', 'managerApproval', '5253', '10007', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:09:33.858', NULL, '2017-06-09 12:23:25.009', 831151, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10269', 'task-wf:3:5248', 'planningByManager', '5262', '5262', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:25.023', NULL, '2017-06-09 12:23:32.889', 7866, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10241', 'project-wf:2:5252', 'managerApproval', '7523', '10238', 'Manager approval', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:22:54.668', NULL, '2017-06-09 12:23:43.506', 48838, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10311', 'task-wf:3:5248', 'planningByManager', '7554', '7554', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:47.913', NULL, '2017-06-09 12:23:54.8', 6887, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10297', 'task-wf:3:5248', 'planningByManager', '7532', '7532', 'Planning by manager', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-09 12:23:43.521', NULL, '2017-06-09 12:24:00.38', 16859, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10280', 'task-wf:3:5248', 'workOnTask', '5262', '5262', 'Work on task', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-09 12:23:32.894', NULL, '2017-06-09 12:24:08.266', 35372, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10287', 'task-wf:3:5248', 'workOnTask', '7510', '7510', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:23:39.489', NULL, '2017-06-09 12:24:16.427', 36938, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10322', 'task-wf:3:5248', 'workOnTask', '7554', '7554', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:23:54.806', NULL, '2017-06-09 12:24:20.744', 25938, 'completed', 50, NULL, NULL, NULL, '');
INSERT INTO act_hi_taskinst VALUES ('10329', 'task-wf:3:5248', 'workOnTask', '7532', '7532', 'Work on task', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-09 12:24:00.387', NULL, '2017-06-09 12:24:23.639', 23252, 'completed', 50, NULL, NULL, NULL, '');


--
-- TOC entry 2942 (class 0 OID 40254)
-- Dependencies: 252
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_hi_varinst VALUES ('2522', '2510', '2510', '2517', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'c6d3a9e4-b533-aee5-da03-3c984c75ee48', NULL, '2017-06-08 15:08:28.444', '2017-06-08 15:08:28.444');
INSERT INTO act_hi_varinst VALUES ('2535', '2523', '2523', '2530', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'd37e81b5-1318-dd9e-7fcb-5db1f288ce4d', NULL, '2017-06-08 15:08:28.484', '2017-06-08 15:08:28.484');
INSERT INTO act_hi_varinst VALUES ('2560', '2501', '2552', '2555', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '4d3bc982-48ef-e37b-2739-a9fac7b34a23', NULL, '2017-06-08 15:09:04.369', '2017-06-08 15:09:04.369');
INSERT INTO act_hi_varinst VALUES ('2570', '2501', '2553', '2562', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'bdf11ebe-a263-87c1-317f-a55d56950dac', NULL, '2017-06-08 15:09:04.38', '2017-06-08 15:09:04.38');
INSERT INTO act_hi_varinst VALUES ('2586', '2510', '2510', '2581', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '7c36933f-d58f-63b7-e700-5838b7dea89e', NULL, '2017-06-08 15:11:49.588', '2017-06-08 15:11:49.588');
INSERT INTO act_hi_varinst VALUES ('2593', '2523', '2523', '2588', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'a717d8b0-e3ce-3a8c-6207-b196d5bed618', NULL, '2017-06-08 15:11:49.607', '2017-06-08 15:11:49.607');
INSERT INTO act_hi_varinst VALUES ('2576', '2501', '2553', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-08 15:11:49.534', '2017-06-08 15:11:49.552');
INSERT INTO act_hi_varinst VALUES ('2574', '2501', '2552', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-08 15:11:38.249', '2017-06-08 15:11:49.555');
INSERT INTO act_hi_varinst VALUES ('2603', '2510', '2510', '2599', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '61553fcf-fe00-4414-6c83-299ac43d643d', NULL, '2017-06-08 15:12:05.791', '2017-06-08 15:12:05.791');
INSERT INTO act_hi_varinst VALUES ('5022', '5010', '5010', '5017', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'e31a40f4-d338-36e1-cadd-5171f7782bc2', NULL, '2017-06-09 10:41:29.907', '2017-06-09 10:41:29.907');
INSERT INTO act_hi_varinst VALUES ('2610', '2523', '2523', '2606', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '860a5618-8811-3365-89e5-ce2c3606ee6b', NULL, '2017-06-08 15:12:14.809', '2017-06-08 15:12:14.809');
INSERT INTO act_hi_varinst VALUES ('2526', '2523', '2523', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'ef405f97-77df-4111-668a-d1ed3c1e565e', NULL, '2017-06-08 15:08:28.467', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2525', '2523', '2523', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-08 15:08:28.467', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2536', '2523', '2523', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-08 15:08:41.68', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2533', '2523', '2523', NULL, 'estimation_result', 'serializable', 2, '2534', NULL, NULL, NULL, NULL, '2017-06-08 15:08:28.484', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2608', '2523', '2523', NULL, 'workOnTask_result', 'serializable', 2, '2609', NULL, NULL, NULL, NULL, '2017-06-08 15:12:14.809', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2591', '2523', '2523', NULL, 'planningByManager_result', 'serializable', 2, '2592', NULL, NULL, NULL, NULL, '2017-06-08 15:11:49.607', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2527', '2523', '2523', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '608f36f3-0f88-7659-2b80-cc20b9c20772', NULL, '2017-06-08 15:08:28.467', '2017-06-08 15:13:15.565');
INSERT INTO act_hi_varinst VALUES ('2504', '2501', '2501', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '90886911-a608-55a9-046b-ed8b4f2f73be', NULL, '2017-06-08 15:08:28.291', '2017-06-08 15:13:53.691');
INSERT INTO act_hi_varinst VALUES ('2503', '2501', '2501', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-08 15:08:28.291', '2017-06-08 15:13:53.691');
INSERT INTO act_hi_varinst VALUES ('2558', '2501', '2501', NULL, 'managerApproval_result', 'serializable', 2, '2559', NULL, NULL, NULL, NULL, '2017-06-08 15:09:04.368', '2017-06-08 15:13:53.691');
INSERT INTO act_hi_varinst VALUES ('2514', '2510', '2510', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', NULL, '2017-06-08 15:08:28.399', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2568', '2501', '2501', NULL, 'projectOfficeApproval_result', 'serializable', 2, '2569', NULL, NULL, NULL, NULL, '2017-06-08 15:09:04.38', '2017-06-08 15:13:53.691');
INSERT INTO act_hi_varinst VALUES ('2513', '2510', '2510', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'df7291b6-44a4-89cd-bb1e-e97647976e34', NULL, '2017-06-08 15:08:28.399', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2601', '2510', '2510', NULL, 'workOnTask_result', 'serializable', 2, '2602', NULL, NULL, NULL, NULL, '2017-06-08 15:12:05.791', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2546', '2510', '2510', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-08 15:09:04.307', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2512', '2510', '2510', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-08 15:08:28.399', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2520', '2510', '2510', NULL, 'estimation_result', 'serializable', 2, '2521', NULL, NULL, NULL, NULL, '2017-06-08 15:08:28.444', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2584', '2510', '2510', NULL, 'planningByManager_result', 'serializable', 2, '2585', NULL, NULL, NULL, NULL, '2017-06-08 15:11:49.588', '2017-06-08 15:13:53.7');
INSERT INTO act_hi_varinst VALUES ('2505', '2501', '2501', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '2dde2d53-1b8a-46cb-b85b-716a66d57189', NULL, '2017-06-08 15:08:28.291', '2017-06-08 15:13:53.691');
INSERT INTO act_hi_varinst VALUES ('5035', '5023', '5023', '5030', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '33333d86-5ee4-a234-5bf2-2076870ae9cf', NULL, '2017-06-09 10:41:29.949', '2017-06-09 10:41:29.949');
INSERT INTO act_hi_varinst VALUES ('5060', '5001', '5052', '5055', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '0ac80639-e384-03b3-4211-1891d3b896c8', NULL, '2017-06-09 10:42:30.492', '2017-06-09 10:42:30.492');
INSERT INTO act_hi_varinst VALUES ('5070', '5001', '5053', '5062', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '48b7e97b-d295-ee39-2d34-db60737a2397', NULL, '2017-06-09 10:42:30.5', '2017-06-09 10:42:30.5');
INSERT INTO act_hi_varinst VALUES ('5086', '5010', '5010', '5081', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '61dcc5ea-ba81-4a48-5fa0-2812368349ab', NULL, '2017-06-09 10:45:25.554', '2017-06-09 10:45:25.554');
INSERT INTO act_hi_varinst VALUES ('5093', '5023', '5023', '5088', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '6a113f67-6ca4-2bad-532a-50bc45bdb453', NULL, '2017-06-09 10:45:25.578', '2017-06-09 10:45:25.578');
INSERT INTO act_hi_varinst VALUES ('5074', '5001', '5052', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 10:43:58.208', '2017-06-09 10:45:25.523');
INSERT INTO act_hi_varinst VALUES ('5076', '5001', '5053', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 10:45:25.505', '2017-06-09 10:45:25.524');
INSERT INTO act_hi_varinst VALUES ('5033', '5023', '5023', NULL, 'estimation_result', 'serializable', 2, '5034', NULL, NULL, NULL, NULL, '2017-06-09 10:41:29.949', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5103', '5010', '5010', '5099', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '7a4780e9-cf75-d266-5e3c-ed0464f42f3c', NULL, '2017-06-09 10:45:44.006', '2017-06-09 10:45:44.006');
INSERT INTO act_hi_varinst VALUES ('5110', '5023', '5023', '5106', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '6b9be4ba-d5a9-b5d0-985a-32f8ec8d8ee0', NULL, '2017-06-09 10:45:53.183', '2017-06-09 10:45:53.183');
INSERT INTO act_hi_varinst VALUES ('5068', '5001', '5001', NULL, 'projectOfficeApproval_result', 'serializable', 2, '5069', NULL, NULL, NULL, NULL, '2017-06-09 10:42:30.5', '2017-06-09 12:22:44.867');
INSERT INTO act_hi_varinst VALUES ('5046', '5023', '5023', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 10:42:30.43', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5020', '5010', '5010', NULL, 'estimation_result', 'serializable', 2, '5021', NULL, NULL, NULL, NULL, '2017-06-09 10:41:29.907', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5012', '5010', '5010', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 10:41:29.852', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5013', '5010', '5010', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '2b879c8b-b29a-8a51-fe28-70abed6b5f76', NULL, '2017-06-09 10:41:29.852', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5101', '5010', '5010', NULL, 'workOnTask_result', 'serializable', 2, '5102', NULL, NULL, NULL, NULL, '2017-06-09 10:45:44.006', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5014', '5010', '5010', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', NULL, '2017-06-09 10:41:29.852', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5003', '5001', '5001', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 10:41:29.742', '2017-06-09 12:22:44.867');
INSERT INTO act_hi_varinst VALUES ('5058', '5001', '5001', NULL, 'managerApproval_result', 'serializable', 2, '5059', NULL, NULL, NULL, NULL, '2017-06-09 10:42:30.492', '2017-06-09 12:22:44.867');
INSERT INTO act_hi_varinst VALUES ('5025', '5023', '5023', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 10:41:29.932', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5004', '5001', '5001', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'c51a9e7f-9600-56ed-143e-f24e8bd0b463', NULL, '2017-06-09 10:41:29.743', '2017-06-09 12:22:44.867');
INSERT INTO act_hi_varinst VALUES ('5036', '5010', '5010', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 10:42:16.219', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5084', '5010', '5010', NULL, 'planningByManager_result', 'serializable', 2, '5085', NULL, NULL, NULL, NULL, '2017-06-09 10:45:25.554', '2017-06-09 10:47:02.079');
INSERT INTO act_hi_varinst VALUES ('5139', '5127', '5127', '5134', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'f22142c9-db7d-397e-c4d3-a8e5c55f3f40', NULL, '2017-06-09 10:51:17.464', '2017-06-09 10:51:17.464');
INSERT INTO act_hi_varinst VALUES ('5152', '5140', '5140', '5147', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '4d48bcc8-4395-5401-d1dc-a00a623a67ad', NULL, '2017-06-09 10:51:17.499', '2017-06-09 10:51:17.499');
INSERT INTO act_hi_varinst VALUES ('5208', '5140', '5140', NULL, 'planningByManager_result', 'serializable', 2, '5209', NULL, NULL, NULL, NULL, '2017-06-09 10:54:48.781', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('7520', '7510', '7510', NULL, 'estimation_result', 'serializable', 2, '7521', NULL, NULL, NULL, NULL, '2017-06-09 12:02:05.988', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('5177', '5118', '5169', '5172', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '4da82787-3031-823b-e756-e47bf4fb9202', NULL, '2017-06-09 10:52:47.152', '2017-06-09 10:52:47.152');
INSERT INTO act_hi_varinst VALUES ('5187', '5118', '5170', '5179', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '1ab486c2-a8d7-5940-4711-ca4beadb86b2', NULL, '2017-06-09 10:52:47.158', '2017-06-09 10:52:47.158');
INSERT INTO act_hi_varinst VALUES ('7534', '7532', '7532', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 12:04:17.462', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('5272', '5262', '5262', NULL, 'estimation_result', 'serializable', 2, '5273', NULL, NULL, NULL, NULL, '2017-06-09 11:11:29.781', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('5203', '5127', '5127', '5198', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'ae33b1b8-9520-dd85-ce29-bb11e37d342e', NULL, '2017-06-09 10:54:48.766', '2017-06-09 10:54:48.766');
INSERT INTO act_hi_varinst VALUES ('5210', '5140', '5140', '5205', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '71932fa1-24fd-3517-a867-aca74423d2a7', NULL, '2017-06-09 10:54:48.782', '2017-06-09 10:54:48.782');
INSERT INTO act_hi_varinst VALUES ('5191', '5118', '5170', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 10:54:25.947', '2017-06-09 10:54:48.74');
INSERT INTO act_hi_varinst VALUES ('5193', '5118', '5169', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 10:54:48.731', '2017-06-09 10:54:48.741');
INSERT INTO act_hi_varinst VALUES ('5264', '5262', '5262', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 11:11:29.766', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('5265', '5262', '5262', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '2cece3a4-837c-12c2-524f-dc3c7dfaf666', NULL, '2017-06-09 11:11:29.766', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('5220', '5140', '5140', '5216', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '0fba54ac-2ab8-8b92-db4f-2256a18c32f8', NULL, '2017-06-09 10:56:26.733', '2017-06-09 10:56:26.733');
INSERT INTO act_hi_varinst VALUES ('5150', '5140', '5140', NULL, 'estimation_result', 'serializable', 2, '5151', NULL, NULL, NULL, NULL, '2017-06-09 10:51:17.499', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5227', '5127', '5127', '5223', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '5ec4983c-e855-7547-557d-be65626a5d8e', NULL, '2017-06-09 10:56:31.766', '2017-06-09 10:56:31.766');
INSERT INTO act_hi_varinst VALUES ('5130', '5127', '5127', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '2301a51a-1c61-e59d-4ecd-4d234253ca8c', NULL, '2017-06-09 10:51:17.45', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5131', '5127', '5127', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '2d884abd-991e-d42e-8f4d-d31c6284bc13', NULL, '2017-06-09 10:51:17.45', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5153', '5127', '5127', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 10:52:18.525', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5201', '5127', '5127', NULL, 'planningByManager_result', 'serializable', 2, '5202', NULL, NULL, NULL, NULL, '2017-06-09 10:54:48.765', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5137', '5127', '5127', NULL, 'estimation_result', 'serializable', 2, '5138', NULL, NULL, NULL, NULL, '2017-06-09 10:51:17.464', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5225', '5127', '5127', NULL, 'workOnTask_result', 'serializable', 2, '5226', NULL, NULL, NULL, NULL, '2017-06-09 10:56:31.766', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5129', '5127', '5127', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 10:51:17.45', '2017-06-09 11:00:12.203');
INSERT INTO act_hi_varinst VALUES ('5255', '5253', '5253', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 11:11:29.713', '2017-06-09 12:24:08.3');
INSERT INTO act_hi_varinst VALUES ('5266', '5262', '5262', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'c60e683c-726f-5103-ee1a-1042eea62182', NULL, '2017-06-09 11:11:29.766', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('5185', '5118', '5118', NULL, 'projectOfficeApproval_result', 'serializable', 2, '5186', NULL, NULL, NULL, NULL, '2017-06-09 10:52:47.158', '2017-06-09 11:00:34.375');
INSERT INTO act_hi_varinst VALUES ('5163', '5140', '5140', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 10:52:47.116', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5120', '5118', '5118', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 10:51:17.416', '2017-06-09 11:00:34.375');
INSERT INTO act_hi_varinst VALUES ('5175', '5118', '5118', NULL, 'managerApproval_result', 'serializable', 2, '5176', NULL, NULL, NULL, NULL, '2017-06-09 10:52:47.152', '2017-06-09 11:00:34.375');
INSERT INTO act_hi_varinst VALUES ('5142', '5140', '5140', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 10:51:17.483', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5121', '5118', '5118', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '809bfead-990d-a6d8-af11-f5fb225e6d5d', NULL, '2017-06-09 10:51:17.416', '2017-06-09 11:00:34.375');
INSERT INTO act_hi_varinst VALUES ('5143', '5140', '5140', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'cf6e1522-efa2-0226-18a1-6b055ac0d2a2', NULL, '2017-06-09 10:51:17.483', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5122', '5118', '5118', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', NULL, '2017-06-09 10:51:17.416', '2017-06-09 11:00:34.375');
INSERT INTO act_hi_varinst VALUES ('5144', '5140', '5140', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '6a80a0aa-515a-2917-d763-0956ee16775e', NULL, '2017-06-09 10:51:17.483', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5218', '5140', '5140', NULL, 'workOnTask_result', 'serializable', 2, '5219', NULL, NULL, NULL, NULL, '2017-06-09 10:56:26.733', '2017-06-09 11:00:34.38');
INSERT INTO act_hi_varinst VALUES ('5274', '5262', '5262', '5269', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '12ee6bbc-1d5d-ddd1-3c14-f704f11f510b', NULL, '2017-06-09 11:11:29.781', '2017-06-09 11:11:29.781');
INSERT INTO act_hi_varinst VALUES ('7522', '7510', '7510', '7517', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '596b25d8-1dd8-fb74-ec5a-d8eb3407bd62', NULL, '2017-06-09 12:02:05.988', '2017-06-09 12:02:05.988');
INSERT INTO act_hi_varinst VALUES ('5256', '5253', '5253', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'b1fdc8db-3a16-c864-4679-8dfe13ac160b', NULL, '2017-06-09 11:11:29.713', '2017-06-09 12:24:08.3');
INSERT INTO act_hi_varinst VALUES ('5257', '5253', '5253', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '185c4228-11b3-3b3a-288e-c3ca90747956', NULL, '2017-06-09 11:11:29.713', '2017-06-09 12:24:08.3');
INSERT INTO act_hi_varinst VALUES ('7512', '7510', '7510', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 12:02:05.943', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('7503', '7501', '7501', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 12:02:05.835', '2017-06-09 12:24:16.445');
INSERT INTO act_hi_varinst VALUES ('7514', '7510', '7510', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', NULL, '2017-06-09 12:02:05.943', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('7513', '7510', '7510', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'f6b2af00-c340-686a-3a1d-1f49296aedca', NULL, '2017-06-09 12:02:05.943', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('7505', '7501', '7501', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '7cc28383-ab4d-7109-6566-7e9dc02b9064', NULL, '2017-06-09 12:02:05.836', '2017-06-09 12:24:16.445');
INSERT INTO act_hi_varinst VALUES ('7504', '7501', '7501', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '46a77952-500a-cf42-7535-840e7894c83b', NULL, '2017-06-09 12:02:05.836', '2017-06-09 12:24:16.445');
INSERT INTO act_hi_varinst VALUES ('7525', '7523', '7523', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 12:04:17.418', '2017-06-09 12:24:23.657');
INSERT INTO act_hi_varinst VALUES ('7535', '7532', '7532', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'fc7dfc2f-698d-ed8f-fc4c-4d3fa71b2e8c', NULL, '2017-06-09 12:04:17.462', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('7527', '7523', '7523', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'f516a36f-2002-269a-817c-dd84c0e1b905', NULL, '2017-06-09 12:04:17.419', '2017-06-09 12:24:23.657');
INSERT INTO act_hi_varinst VALUES ('7526', '7523', '7523', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '82af3f9c-41f4-e1b1-3f77-660e7ed8fb55', NULL, '2017-06-09 12:04:17.419', '2017-06-09 12:24:23.657');
INSERT INTO act_hi_varinst VALUES ('7544', '7532', '7532', '7539', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '79189075-90a3-470e-312f-62ac5b7655ba', NULL, '2017-06-09 12:04:17.482', '2017-06-09 12:04:17.482');
INSERT INTO act_hi_varinst VALUES ('7566', '7554', '7554', '7561', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'd98346b8-084d-c201-723a-aed6cb6ea0a1', NULL, '2017-06-09 12:05:00.116', '2017-06-09 12:05:00.116');
INSERT INTO act_hi_varinst VALUES ('10015', '5253', '10007', '10010', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '8a0ff531-231f-fa65-9f11-13faf2d6a8b8', NULL, '2017-06-09 12:09:33.883', '2017-06-09 12:09:33.883');
INSERT INTO act_hi_varinst VALUES ('10025', '5253', '10008', '10017', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'a9a83a04-3bed-e84b-3714-c4a52456ca21', NULL, '2017-06-09 12:09:33.894', '2017-06-09 12:09:33.894');
INSERT INTO act_hi_varinst VALUES ('7564', '7554', '7554', NULL, 'estimation_result', 'serializable', 2, '7565', NULL, NULL, NULL, NULL, '2017-06-09 12:05:00.116', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10045', '7501', '10037', '10040', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'ede9a97e-70fa-87ab-82ca-b02e385afc0a', NULL, '2017-06-09 12:11:58.027', '2017-06-09 12:11:58.027');
INSERT INTO act_hi_varinst VALUES ('10055', '7501', '10038', '10047', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'b130c7c4-4024-edc0-21d2-fb9b797c110f', NULL, '2017-06-09 12:11:58.035', '2017-06-09 12:11:58.035');
INSERT INTO act_hi_varinst VALUES ('7556', '7554', '7554', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 12:05:00.094', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('7547', '7545', '7545', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 12:05:00.054', '2017-06-09 12:24:20.764');
INSERT INTO act_hi_varinst VALUES ('10071', '7510', '7510', '10066', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '006c04f0-231e-0bda-1e16-742c0afb8ccd', NULL, '2017-06-09 12:12:26.91', '2017-06-09 12:12:26.91');
INSERT INTO act_hi_varinst VALUES ('10061', '7501', '10037', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:12:26.861', '2017-06-09 12:12:26.879');
INSERT INTO act_hi_varinst VALUES ('10059', '7501', '10038', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:12:09.135', '2017-06-09 12:12:26.878');
INSERT INTO act_hi_varinst VALUES ('10096', '10084', '10084', '10091', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '23b076f6-17a7-f5ac-cdad-501e8ee5357f', NULL, '2017-06-09 12:19:50.827', '2017-06-09 12:19:50.827');
INSERT INTO act_hi_varinst VALUES ('10109', '10097', '10097', '10104', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '95ff55db-2a25-893d-11e0-9dd88cb7a242', NULL, '2017-06-09 12:19:50.86', '2017-06-09 12:19:50.86');
INSERT INTO act_hi_varinst VALUES ('7536', '7532', '7532', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '0a86205e-b926-0462-015a-e24ee29c7fa0', NULL, '2017-06-09 12:04:17.462', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('10134', '10075', '10126', '10129', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'b65a1eec-f027-56fa-f7c4-5ef151dc28fe', NULL, '2017-06-09 12:20:32.519', '2017-06-09 12:20:32.519');
INSERT INTO act_hi_varinst VALUES ('10144', '10075', '10127', '10136', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '06a30615-a429-c0b8-cf6c-510ee40425c4', NULL, '2017-06-09 12:20:32.527', '2017-06-09 12:20:32.527');
INSERT INTO act_hi_varinst VALUES ('7558', '7554', '7554', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '88780826-cafd-15d8-59dc-e66d06d4829b', NULL, '2017-06-09 12:05:00.094', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10029', '5253', '10008', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:09:55.508', '2017-06-09 12:23:25.011');
INSERT INTO act_hi_varinst VALUES ('10160', '10084', '10084', '10155', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '1a51a8f5-3e69-b47d-7041-415c78bf3d82', NULL, '2017-06-09 12:21:21.463', '2017-06-09 12:21:21.463');
INSERT INTO act_hi_varinst VALUES ('10167', '10097', '10097', '10162', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '43ce930d-6f87-33f9-6a06-7e964cdd8025', NULL, '2017-06-09 12:21:21.476', '2017-06-09 12:21:21.476');
INSERT INTO act_hi_varinst VALUES ('10150', '10075', '10127', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:21:21.413', '2017-06-09 12:21:21.44');
INSERT INTO act_hi_varinst VALUES ('10148', '10075', '10126', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:21:04.319', '2017-06-09 12:21:21.438');
INSERT INTO act_hi_varinst VALUES ('7557', '7554', '7554', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'bccb71b0-7f61-5a7b-32e6-79dab78c9cdb', NULL, '2017-06-09 12:05:00.094', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10107', '10097', '10097', NULL, 'estimation_result', 'serializable', 2, '10108', NULL, NULL, NULL, NULL, '2017-06-09 12:19:50.86', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('10177', '10084', '10084', '10173', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '38c2d5c6-876c-d098-e7f4-b468eb7730a0', NULL, '2017-06-09 12:21:39.644', '2017-06-09 12:21:39.644');
INSERT INTO act_hi_varinst VALUES ('7549', '7545', '7545', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '67f8c457-f4dc-a0f4-ab4e-caa626f75165', NULL, '2017-06-09 12:05:00.054', '2017-06-09 12:24:20.764');
INSERT INTO act_hi_varinst VALUES ('7548', '7545', '7545', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '7abc2aea-577b-67a1-ecdc-fd33b2e2eaa9', NULL, '2017-06-09 12:05:00.054', '2017-06-09 12:24:20.764');
INSERT INTO act_hi_varinst VALUES ('10184', '10097', '10097', '10180', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '5198c865-68a5-2a87-282d-6f37c7dc9db0', NULL, '2017-06-09 12:21:47.491', '2017-06-09 12:21:47.491');
INSERT INTO act_hi_varinst VALUES ('10182', '10097', '10097', NULL, 'workOnTask_result', 'serializable', 2, '10183', NULL, NULL, NULL, NULL, '2017-06-09 12:21:47.491', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('10077', '10075', '10075', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Project', NULL, '2017-06-09 12:19:50.727', '2017-06-09 12:22:38.071');
INSERT INTO act_hi_varinst VALUES ('10094', '10084', '10084', NULL, 'estimation_result', 'serializable', 2, '10095', NULL, NULL, NULL, NULL, '2017-06-09 12:19:50.827', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10086', '10084', '10084', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 12:19:50.81', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10088', '10084', '10084', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, '3b4747b4-3fb6-eddc-478b-fff34a7b18af', NULL, '2017-06-09 12:19:50.81', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10110', '10084', '10084', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:20:19.919', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10087', '10084', '10084', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, '47965ed0-1f9c-12a3-49e7-f3266a21f0ae', NULL, '2017-06-09 12:19:50.81', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10175', '10084', '10084', NULL, 'workOnTask_result', 'serializable', 2, '10176', NULL, NULL, NULL, NULL, '2017-06-09 12:21:39.644', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10158', '10084', '10084', NULL, 'planningByManager_result', 'serializable', 2, '10159', NULL, NULL, NULL, NULL, '2017-06-09 12:21:21.463', '2017-06-09 12:22:18.853');
INSERT INTO act_hi_varinst VALUES ('10132', '10075', '10075', NULL, 'managerApproval_result', 'serializable', 2, '10133', NULL, NULL, NULL, NULL, '2017-06-09 12:20:32.519', '2017-06-09 12:22:38.071');
INSERT INTO act_hi_varinst VALUES ('10099', '10097', '10097', NULL, 'entityName', 'string', 1, NULL, NULL, NULL, 'pm$Task', NULL, '2017-06-09 12:19:50.846', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('10165', '10097', '10097', NULL, 'planningByManager_result', 'serializable', 2, '10166', NULL, NULL, NULL, NULL, '2017-06-09 12:21:21.476', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('10142', '10075', '10075', NULL, 'projectOfficeApproval_result', 'serializable', 2, '10143', NULL, NULL, NULL, NULL, '2017-06-09 12:20:32.527', '2017-06-09 12:22:38.071');
INSERT INTO act_hi_varinst VALUES ('10120', '10097', '10097', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:20:32.465', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('7542', '7532', '7532', NULL, 'estimation_result', 'serializable', 2, '7543', NULL, NULL, NULL, NULL, '2017-06-09 12:04:17.482', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('10013', '5253', '5253', NULL, 'managerApproval_result', 'serializable', 2, '10014', NULL, NULL, NULL, NULL, '2017-06-09 12:09:33.883', '2017-06-09 12:24:08.3');
INSERT INTO act_hi_varinst VALUES ('10023', '5253', '5253', NULL, 'projectOfficeApproval_result', 'serializable', 2, '10024', NULL, NULL, NULL, NULL, '2017-06-09 12:09:33.894', '2017-06-09 12:24:08.3');
INSERT INTO act_hi_varinst VALUES ('10001', '5262', '5262', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:09:33.743', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('10053', '7501', '7501', NULL, 'projectOfficeApproval_result', 'serializable', 2, '10054', NULL, NULL, NULL, NULL, '2017-06-09 12:11:58.035', '2017-06-09 12:24:16.445');
INSERT INTO act_hi_varinst VALUES ('10031', '7510', '7510', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:11:57.972', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('10043', '7501', '7501', NULL, 'managerApproval_result', 'serializable', 2, '10044', NULL, NULL, NULL, NULL, '2017-06-09 12:11:58.027', '2017-06-09 12:24:16.445');
INSERT INTO act_hi_varinst VALUES ('10069', '7510', '7510', NULL, 'planningByManager_result', 'serializable', 2, '10070', NULL, NULL, NULL, NULL, '2017-06-09 12:12:26.91', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('10079', '10075', '10075', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', NULL, '2017-06-09 12:19:50.727', '2017-06-09 12:22:38.071');
INSERT INTO act_hi_varinst VALUES ('10101', '10097', '10097', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'a2ad2b1e-6640-73c0-e407-5b7745798474', NULL, '2017-06-09 12:19:50.846', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('10078', '10075', '10075', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'd9903c5e-82f1-79f2-1f02-05933bbdf60c', NULL, '2017-06-09 12:19:50.727', '2017-06-09 12:22:38.071');
INSERT INTO act_hi_varinst VALUES ('10100', '10097', '10097', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'a609e3ac-9064-5e53-ba39-2974658cd0ed', NULL, '2017-06-09 12:19:50.846', '2017-06-09 12:22:38.077');
INSERT INTO act_hi_varinst VALUES ('5026', '5023', '5023', NULL, 'entityId', 'uuid', 1, NULL, NULL, NULL, 'bbbf5f42-c185-1e1e-51dc-d0e496809ff1', NULL, '2017-06-09 10:41:29.932', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5005', '5001', '5001', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', NULL, '2017-06-09 10:41:29.743', '2017-06-09 12:22:44.867');
INSERT INTO act_hi_varinst VALUES ('5027', '5023', '5023', NULL, 'bpmProcInstanceId', 'uuid', 1, NULL, NULL, NULL, 'ec84c036-d83c-811c-1579-6f91a876ffd5', NULL, '2017-06-09 10:41:29.932', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5091', '5023', '5023', NULL, 'planningByManager_result', 'serializable', 2, '5092', NULL, NULL, NULL, NULL, '2017-06-09 10:45:25.578', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('5108', '5023', '5023', NULL, 'workOnTask_result', 'serializable', 2, '5109', NULL, NULL, NULL, NULL, '2017-06-09 10:45:53.183', '2017-06-09 12:22:44.871');
INSERT INTO act_hi_varinst VALUES ('10218', '7545', '10210', '10213', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'b569b227-96cc-37cb-2cfc-7151289c0628', NULL, '2017-06-09 12:22:49.919', '2017-06-09 12:22:49.919');
INSERT INTO act_hi_varinst VALUES ('10228', '7545', '10211', '10220', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '2ee1551a-b375-50a8-2b66-3eff7368adf5', NULL, '2017-06-09 12:22:49.924', '2017-06-09 12:22:49.924');
INSERT INTO act_hi_varinst VALUES ('10246', '7523', '10238', '10241', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '6b891cdd-60f3-fe14-d238-449bf45f6cc8', NULL, '2017-06-09 12:22:54.678', '2017-06-09 12:22:54.678');
INSERT INTO act_hi_varinst VALUES ('10256', '7523', '10239', '10248', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '3cd8668b-3a9d-1073-fead-97b7c967c16b', NULL, '2017-06-09 12:22:54.684', '2017-06-09 12:22:54.684');
INSERT INTO act_hi_varinst VALUES ('10274', '5262', '5262', '10269', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '57557480-b428-1069-fdd6-70f194da889f', NULL, '2017-06-09 12:23:25.031', '2017-06-09 12:23:25.031');
INSERT INTO act_hi_varinst VALUES ('10264', '5253', '10007', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:23:25.003', '2017-06-09 12:23:25.012');
INSERT INTO act_hi_varinst VALUES ('10204', '7554', '7554', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:22:49.885', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10284', '5262', '5262', '10280', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'c4f9e46a-e8db-bdaf-2d46-50a41cab9ba2', NULL, '2017-06-09 12:23:32.902', '2017-06-09 12:23:32.902');
INSERT INTO act_hi_varinst VALUES ('10291', '7510', '7510', '10287', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'abf3c77d-ebc1-c753-7041-9d878a81b47e', NULL, '2017-06-09 12:23:39.496', '2017-06-09 12:23:39.496');
INSERT INTO act_hi_varinst VALUES ('10302', '7532', '7532', '10297', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '0eeb0c2e-82b6-badf-53ab-8b591e6934ce', NULL, '2017-06-09 12:23:43.547', '2017-06-09 12:23:43.547');
INSERT INTO act_hi_varinst VALUES ('10292', '7523', '10238', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:23:43.5', '2017-06-09 12:23:43.51');
INSERT INTO act_hi_varinst VALUES ('10262', '7523', '10239', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:23:14.404', '2017-06-09 12:23:43.509');
INSERT INTO act_hi_varinst VALUES ('10316', '7554', '7554', '10311', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'b79ffcf3-b374-e4a4-1c3a-8434a6f78570', NULL, '2017-06-09 12:23:47.922', '2017-06-09 12:23:47.922');
INSERT INTO act_hi_varinst VALUES ('10306', '7545', '10210', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:23:47.891', '2017-06-09 12:23:47.901');
INSERT INTO act_hi_varinst VALUES ('10260', '7545', '10211', NULL, 'outcome', 'string', 1, NULL, NULL, NULL, 'approve', NULL, '2017-06-09 12:23:11.542', '2017-06-09 12:23:47.902');
INSERT INTO act_hi_varinst VALUES ('10326', '7554', '7554', '10322', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, '37a84b39-9eaf-736f-65fb-02fc0e0a4a85', NULL, '2017-06-09 12:23:54.812', '2017-06-09 12:23:54.812');
INSERT INTO act_hi_varinst VALUES ('10333', '7532', '7532', '10329', 'bpmProcTaskId', 'uuid', 0, NULL, NULL, NULL, 'c10670b0-fbca-767b-8585-97fc501cc083', NULL, '2017-06-09 12:24:00.394', '2017-06-09 12:24:00.394');
INSERT INTO act_hi_varinst VALUES ('10314', '7554', '7554', NULL, 'planningByManager_result', 'serializable', 2, '10315', NULL, NULL, NULL, NULL, '2017-06-09 12:23:47.922', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10282', '5262', '5262', NULL, 'workOnTask_result', 'serializable', 2, '10283', NULL, NULL, NULL, NULL, '2017-06-09 12:23:32.902', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('10272', '5262', '5262', NULL, 'planningByManager_result', 'serializable', 2, '10273', NULL, NULL, NULL, NULL, '2017-06-09 12:23:25.031', '2017-06-09 12:24:08.303');
INSERT INTO act_hi_varinst VALUES ('10324', '7554', '7554', NULL, 'workOnTask_result', 'serializable', 2, '10325', NULL, NULL, NULL, NULL, '2017-06-09 12:23:54.812', '2017-06-09 12:24:20.768');
INSERT INTO act_hi_varinst VALUES ('10289', '7510', '7510', NULL, 'workOnTask_result', 'serializable', 2, '10290', NULL, NULL, NULL, NULL, '2017-06-09 12:23:39.496', '2017-06-09 12:24:16.449');
INSERT INTO act_hi_varinst VALUES ('10216', '7545', '7545', NULL, 'managerApproval_result', 'serializable', 2, '10217', NULL, NULL, NULL, NULL, '2017-06-09 12:22:49.919', '2017-06-09 12:24:20.764');
INSERT INTO act_hi_varinst VALUES ('10226', '7545', '7545', NULL, 'projectOfficeApproval_result', 'serializable', 2, '10227', NULL, NULL, NULL, NULL, '2017-06-09 12:22:49.924', '2017-06-09 12:24:20.764');
INSERT INTO act_hi_varinst VALUES ('10244', '7523', '7523', NULL, 'managerApproval_result', 'serializable', 2, '10245', NULL, NULL, NULL, NULL, '2017-06-09 12:22:54.678', '2017-06-09 12:24:23.657');
INSERT INTO act_hi_varinst VALUES ('10254', '7523', '7523', NULL, 'projectOfficeApproval_result', 'serializable', 2, '10255', NULL, NULL, NULL, NULL, '2017-06-09 12:22:54.684', '2017-06-09 12:24:23.657');
INSERT INTO act_hi_varinst VALUES ('10331', '7532', '7532', NULL, 'workOnTask_result', 'serializable', 2, '10332', NULL, NULL, NULL, NULL, '2017-06-09 12:24:00.394', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('10232', '7532', '7532', NULL, 'outcome', 'string', 3, NULL, NULL, NULL, 'completed', NULL, '2017-06-09 12:22:54.644', '2017-06-09 12:24:23.66');
INSERT INTO act_hi_varinst VALUES ('10300', '7532', '7532', NULL, 'planningByManager_result', 'serializable', 2, '10301', NULL, NULL, NULL, NULL, '2017-06-09 12:23:43.547', '2017-06-09 12:24:23.66');


--
-- TOC entry 2947 (class 0 OID 40312)
-- Dependencies: 257
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2950 (class 0 OID 40333)
-- Dependencies: 260
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2948 (class 0 OID 40320)
-- Dependencies: 258
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2949 (class 0 OID 40325)
-- Dependencies: 259
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2938 (class 0 OID 40084)
-- Dependencies: 248
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2927 (class 0 OID 39993)
-- Dependencies: 237
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_re_deployment VALUES ('11', NULL, NULL, '', '2017-06-08 14:58:06.446');
INSERT INTO act_re_deployment VALUES ('15', NULL, NULL, '', '2017-06-08 14:58:15.075');
INSERT INTO act_re_deployment VALUES ('5241', NULL, NULL, '', '2017-06-09 11:03:54.658');
INSERT INTO act_re_deployment VALUES ('5245', NULL, NULL, '', '2017-06-09 11:10:46.695');
INSERT INTO act_re_deployment VALUES ('5249', NULL, NULL, '', '2017-06-09 11:10:49.209');


--
-- TOC entry 2928 (class 0 OID 40002)
-- Dependencies: 238
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_re_model VALUES ('1', 6, 'Исполнение задач', NULL, NULL, '2017-06-08 14:56:52.817', '2017-06-09 11:03:44.082', 1, '{"name":"Исполнение задач","description":"","revision":1}', NULL, '2', NULL, '');
INSERT INTO act_re_model VALUES ('3', 5, 'Исполнение проекта', NULL, NULL, '2017-06-08 14:56:55.516', '2017-06-09 11:04:19.195', 1, '{"name":"Исполнение проекта","description":"","revision":1}', NULL, '4', NULL, '');


--
-- TOC entry 2931 (class 0 OID 40029)
-- Dependencies: 241
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO act_re_procdef VALUES ('task-wf:1:14', 1, 'http://www.activiti.org/processdef', 'Task WF', 'task-wf', 1, '11', 'process.bpmn20.xml', 'process.task-wf.png', NULL, false, true, 1, '');
INSERT INTO act_re_procdef VALUES ('project-wf:1:18', 1, 'http://www.activiti.org/processdef', 'Project WF', 'project-wf', 1, '15', 'process.bpmn20.xml', 'process.project-wf.png', NULL, false, true, 1, '');
INSERT INTO act_re_procdef VALUES ('task-wf:2:5244', 1, 'http://www.activiti.org/processdef', 'Исполнение задач', 'task-wf', 2, '5241', 'process.bpmn20.xml', 'process.task-wf.png', NULL, false, true, 1, '');
INSERT INTO act_re_procdef VALUES ('task-wf:3:5248', 1, 'http://www.activiti.org/processdef', 'Исполнение задач', 'task-wf', 3, '5245', 'process.bpmn20.xml', 'process.task-wf.png', NULL, false, true, 1, '');
INSERT INTO act_re_procdef VALUES ('project-wf:2:5252', 1, 'http://www.activiti.org/processdef', 'Исполнение проекта', 'project-wf', 2, '5249', 'process.bpmn20.xml', 'process.project-wf.png', NULL, false, true, 1, '');


--
-- TOC entry 2935 (class 0 OID 40063)
-- Dependencies: 245
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2929 (class 0 OID 40011)
-- Dependencies: 239
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2933 (class 0 OID 40047)
-- Dependencies: 243
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2930 (class 0 OID 40020)
-- Dependencies: 240
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2932 (class 0 OID 40038)
-- Dependencies: 242
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2934 (class 0 OID 40055)
-- Dependencies: 244
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2918 (class 0 OID 39834)
-- Dependencies: 228
-- Data for Name: bpm_proc_actor; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_actor VALUES ('5dfa52c0-0700-cbb5-9d64-a45f5d4683ba', '2017-06-08 15:08:28.142', 'admin', 1, '2017-06-08 15:08:28.142', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '2dde2d53-1b8a-46cb-b85b-716a66d57189', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('7b83c36e-258a-f7c5-f16a-fcfa22c9ba22', '2017-06-08 15:08:28.142', 'admin', 1, '2017-06-08 15:08:28.142', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '2dde2d53-1b8a-46cb-b85b-716a66d57189', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('1c66a6f1-e527-3f33-5406-3f49413389c6', '2017-06-08 15:08:28.142', 'admin', 1, '2017-06-08 15:08:28.142', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2dde2d53-1b8a-46cb-b85b-716a66d57189', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('9e9f738b-8819-96e8-755f-f58837e166ca', '2017-06-08 15:08:28.373', 'admin', 1, '2017-06-08 15:08:28.373', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '608f36f3-0f88-7659-2b80-cc20b9c20772', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('8f67873f-50e5-d7a9-439b-ec4f2dbbce95', '2017-06-08 15:08:28.374', 'admin', 1, '2017-06-08 15:08:28.374', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('92846f0f-def6-6c33-ccb9-c975030f1e56', '2017-06-08 15:08:28.373', 'admin', 1, '2017-06-08 15:08:28.373', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '608f36f3-0f88-7659-2b80-cc20b9c20772', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('5850b3d0-0eb6-3aa2-66f8-e064851e1251', '2017-06-08 15:08:28.373', 'admin', 1, '2017-06-08 15:08:28.373', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('59cfdc35-0d64-d624-a1a1-9d51c78a3e0e', '2017-06-09 10:41:29.604', 'admin', 1, '2017-06-09 10:41:29.604', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('3690f556-200b-257b-e9da-fed0accad43c', '2017-06-09 10:41:29.604', 'admin', 1, '2017-06-09 10:41:29.604', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('7c885637-ffbb-a53d-2d58-39b16657baed', '2017-06-09 10:41:29.604', 'admin', 1, '2017-06-09 10:41:29.604', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('5678ad8a-49de-4016-7e8d-5cb18ce5134d', '2017-06-09 10:41:29.817', 'admin', 1, '2017-06-09 10:41:29.817', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('0e33ee9b-f2f7-f9f2-b6fb-932484959ac1', '2017-06-09 10:41:29.817', 'admin', 1, '2017-06-09 10:41:29.817', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('2c37a2dd-8992-716a-3eaa-98867523fe7a', '2017-06-09 10:41:29.817', 'admin', 1, '2017-06-09 10:41:29.817', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'ec84c036-d83c-811c-1579-6f91a876ffd5', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('51a0a444-9aa2-57b5-ff22-6e3926d896c3', '2017-06-09 10:41:29.817', 'admin', 1, '2017-06-09 10:41:29.817', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'ec84c036-d83c-811c-1579-6f91a876ffd5', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('5254ad0c-2191-b171-8ee6-4b2f36426778', '2017-06-09 10:51:17.404', 'admin', 1, '2017-06-09 10:51:17.404', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('1ae67d69-2eb9-a039-4550-c2188b2e9ab0', '2017-06-09 10:51:17.403', 'admin', 1, '2017-06-09 10:51:17.403', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('4d3f286f-ec10-295a-5c12-b967df6b244f', '2017-06-09 10:51:17.404', 'admin', 1, '2017-06-09 10:51:17.404', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('5db2cb7d-9c97-ee37-b8f6-15309a1a6417', '2017-06-09 10:51:17.436', 'admin', 1, '2017-06-09 10:51:17.436', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '2d884abd-991e-d42e-8f4d-d31c6284bc13', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('317cf8d4-3eb3-ed2f-dcda-9d57db942de0', '2017-06-09 10:51:17.436', 'admin', 1, '2017-06-09 10:51:17.436', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '6a80a0aa-515a-2917-d763-0956ee16775e', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('747f9b18-a94a-251a-d658-be6c1bae80f9', '2017-06-09 10:51:17.436', 'admin', 1, '2017-06-09 10:51:17.436', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '6a80a0aa-515a-2917-d763-0956ee16775e', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('0d39671e-8903-1281-4e39-f67a03ebd75a', '2017-06-09 10:51:17.436', 'admin', 1, '2017-06-09 10:51:17.436', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '2d884abd-991e-d42e-8f4d-d31c6284bc13', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('8bf107ee-f906-75d9-83c3-04d648ac544c', '2017-06-09 11:11:29.7', 'admin', 1, '2017-06-09 11:11:29.7', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '185c4228-11b3-3b3a-288e-c3ca90747956', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('a3a39fb6-5a24-48dd-4e79-44ae188e66b4', '2017-06-09 11:11:29.7', 'admin', 1, '2017-06-09 11:11:29.7', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '185c4228-11b3-3b3a-288e-c3ca90747956', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('acea3d34-069b-71e5-2c96-acce62346184', '2017-06-09 11:11:29.7', 'admin', 1, '2017-06-09 11:11:29.7', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '185c4228-11b3-3b3a-288e-c3ca90747956', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('43c0ae2f-e5ac-db76-13c1-399ee4873085', '2017-06-09 11:11:29.732', 'admin', 1, '2017-06-09 11:11:29.732', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', 'c60e683c-726f-5103-ee1a-1042eea62182', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('d7f231c7-36e4-7647-1e7d-2bcc6bc1848e', '2017-06-09 11:11:29.732', 'admin', 1, '2017-06-09 11:11:29.732', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'c60e683c-726f-5103-ee1a-1042eea62182', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('09ce27cd-9f34-cdd1-3a82-8809b4c6549a', '2017-06-09 12:02:05.398', 'admin', 1, '2017-06-09 12:02:05.398', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '7cc28383-ab4d-7109-6566-7e9dc02b9064', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('39b2ce99-25e9-9e3d-4d1f-2b249f5c9e67', '2017-06-09 12:02:05.399', 'admin', 1, '2017-06-09 12:02:05.399', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '7cc28383-ab4d-7109-6566-7e9dc02b9064', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('270abf88-3b54-dece-3d49-700f1ddd6242', '2017-06-09 12:02:05.398', 'admin', 1, '2017-06-09 12:02:05.398', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '7cc28383-ab4d-7109-6566-7e9dc02b9064', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('897a2020-957b-253e-4cdc-8dff8d376406', '2017-06-09 12:02:05.917', 'admin', 1, '2017-06-09 12:02:05.917', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('45d85e9b-9e59-1542-bea3-4c141c121968', '2017-06-09 12:02:05.917', 'admin', 1, '2017-06-09 12:02:05.917', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('eca8b0e1-a1a6-1dc6-9afd-f17aa0a8b161', '2017-06-09 12:04:17.399', 'admin', 1, '2017-06-09 12:04:17.399', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'f516a36f-2002-269a-817c-dd84c0e1b905', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('55a2886f-5e56-c0ae-b18e-4c16a514cd71', '2017-06-09 12:04:17.399', 'admin', 1, '2017-06-09 12:04:17.399', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'f516a36f-2002-269a-817c-dd84c0e1b905', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('ed3d8046-ce49-dddb-dcbe-d052c817beb2', '2017-06-09 12:04:17.398', 'admin', 1, '2017-06-09 12:04:17.398', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'f516a36f-2002-269a-817c-dd84c0e1b905', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('0a75b875-3fab-0540-7d90-5959ed910266', '2017-06-09 12:04:17.445', 'admin', 1, '2017-06-09 12:04:17.445', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '0a86205e-b926-0462-015a-e24ee29c7fa0', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('7ac7a2e6-f104-8c17-857c-48028d5d0765', '2017-06-09 12:04:17.445', 'admin', 1, '2017-06-09 12:04:17.445', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '0a86205e-b926-0462-015a-e24ee29c7fa0', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('629951bc-66e4-f002-998e-c886e829346c', '2017-06-09 12:05:00.04', 'admin', 1, '2017-06-09 12:05:00.04', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '67f8c457-f4dc-a0f4-ab4e-caa626f75165', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('9935ecb2-6186-6992-19b8-62c3d8b3edc0', '2017-06-09 12:05:00.04', 'admin', 1, '2017-06-09 12:05:00.04', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '67f8c457-f4dc-a0f4-ab4e-caa626f75165', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('20952a50-dc3b-505c-e950-884e31fb6eb0', '2017-06-09 12:05:00.04', 'admin', 1, '2017-06-09 12:05:00.04', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', '67f8c457-f4dc-a0f4-ab4e-caa626f75165', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('15c2767d-027f-d518-2467-fdd89de11b7b', '2017-06-09 12:05:00.081', 'admin', 1, '2017-06-09 12:05:00.081', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', '88780826-cafd-15d8-59dc-e66d06d4829b', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('309bd9d3-19c4-93fd-df5f-57fd1d5543d0', '2017-06-09 12:05:00.081', 'admin', 1, '2017-06-09 12:05:00.081', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '88780826-cafd-15d8-59dc-e66d06d4829b', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('45c4a0e7-64cb-4265-c371-93dfd39ec487', '2017-06-09 12:19:50.711', 'admin', 1, '2017-06-09 12:19:50.711', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('804d3f5d-43ea-069a-e035-3f0f527e51f3', '2017-06-09 12:19:50.711', 'admin', 1, '2017-06-09 12:19:50.711', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', 'd6b0d8cd-f39d-0c71-a5d7-6868e095916c', 0);
INSERT INTO bpm_proc_actor VALUES ('3736caeb-bc31-458c-3f2f-73da625a25c9', '2017-06-09 12:19:50.711', 'admin', 1, '2017-06-09 12:19:50.711', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', 'e60946ff-f40c-fb0b-6178-c3c3b936da95', 0);
INSERT INTO bpm_proc_actor VALUES ('18f1a9ac-0f6e-20f2-659e-ef1317ac6420', '2017-06-09 12:19:50.791', 'admin', 1, '2017-06-09 12:19:50.791', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'a2ad2b1e-6640-73c0-e407-5b7745798474', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('a9be298e-32a9-85a5-f4b0-f6b892f22140', '2017-06-09 12:19:50.792', 'admin', 1, '2017-06-09 12:19:50.792', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'a2ad2b1e-6640-73c0-e407-5b7745798474', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);
INSERT INTO bpm_proc_actor VALUES ('4145bb58-c5d2-f5da-64e6-0c6e28726618', '2017-06-09 12:19:50.792', 'admin', 1, '2017-06-09 12:19:50.792', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '3b4747b4-3fb6-eddc-478b-fff34a7b18af', '0c2c8db3-1f7a-921f-8512-3ac1ed67791a', 0);
INSERT INTO bpm_proc_actor VALUES ('75eff276-5967-c5e9-19f5-21770ea5c065', '2017-06-09 12:19:50.791', 'admin', 1, '2017-06-09 12:19:50.791', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', '3b4747b4-3fb6-eddc-478b-fff34a7b18af', '1f81c94a-15f2-381b-5213-369e58fc19c3', 0);


--
-- TOC entry 2920 (class 0 OID 39847)
-- Dependencies: 230
-- Data for Name: bpm_proc_attachment; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2919 (class 0 OID 39839)
-- Dependencies: 229
-- Data for Name: bpm_proc_attachment_type; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2915 (class 0 OID 39810)
-- Dependencies: 225
-- Data for Name: bpm_proc_definition; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_definition VALUES ('b032cb0f-4e43-077f-d1da-6ba769aca306', '2017-06-08 14:58:06.897', 'admin', 3, '2017-06-09 11:10:46.867', 'admin', NULL, NULL, 'Исполнение задач', 'task-wf', 'task-wf:3:5248', true, '4c7405ae-470d-65cd-9efe-18beb7fc47e2');
INSERT INTO bpm_proc_definition VALUES ('02c824b8-0a20-a345-96e0-e9df04fbfba0', '2017-06-08 14:58:15.231', 'admin', 2, '2017-06-09 11:10:49.438', 'admin', NULL, NULL, 'Исполнение проекта', 'project-wf', 'project-wf:2:5252', true, 'cdd9ff40-b70b-e6db-b3f3-3590a16a52e3');


--
-- TOC entry 2917 (class 0 OID 39826)
-- Dependencies: 227
-- Data for Name: bpm_proc_instance; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_instance VALUES ('608f36f3-0f88-7659-2b80-cc20b9c20772', '2017-06-08 15:08:28.373', 'admin', 3, '2017-06-08 15:13:15.587', 'admin', NULL, NULL, 'pm$Task', 'ef405f97-77df-4111-668a-d1ed3c1e565e', false, false, '2523', '2017-06-08 15:08:28.499', '2017-06-08 15:13:15.558', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '2017-06-08 15:08:28.373', 'admin', 3, '2017-06-08 15:13:53.729', 'admin', NULL, NULL, 'pm$Task', 'df7291b6-44a4-89cd-bb1e-e97647976e34', false, false, '2510', '2017-06-08 15:08:28.456', '2017-06-08 15:13:53.693', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('2dde2d53-1b8a-46cb-b85b-716a66d57189', '2017-06-08 15:08:28.142', 'admin', 3, '2017-06-08 15:13:53.729', 'admin', NULL, NULL, 'pm$Project', '90886911-a608-55a9-046b-ed8b4f2f73be', false, false, '2501', '2017-06-08 15:08:28.358', '2017-06-08 15:13:53.688', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '2017-06-09 10:41:29.817', 'admin', 3, '2017-06-09 10:47:02.101', 'admin', NULL, NULL, 'pm$Task', '2b879c8b-b29a-8a51-fe28-70abed6b5f76', false, false, '5010', '2017-06-09 10:41:29.92', '2017-06-09 10:47:02.072', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('2d884abd-991e-d42e-8f4d-d31c6284bc13', '2017-06-09 10:51:17.436', 'admin', 3, '2017-06-09 11:00:12.215', 'admin', NULL, NULL, 'pm$Task', '2301a51a-1c61-e59d-4ecd-4d234253ca8c', false, false, '5127', '2017-06-09 10:51:17.474', '2017-06-09 11:00:12.2', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('dcbc3bc8-469a-0d0d-0946-31979f87b3ca', '2017-06-09 10:51:17.404', 'admin', 3, '2017-06-09 11:00:34.394', 'admin', NULL, NULL, 'pm$Project', '809bfead-990d-a6d8-af11-f5fb225e6d5d', false, false, '5118', '2017-06-09 10:51:17.426', '2017-06-09 11:00:34.372', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('6a80a0aa-515a-2917-d763-0956ee16775e', '2017-06-09 10:51:17.436', 'admin', 3, '2017-06-09 11:00:34.394', 'admin', NULL, NULL, 'pm$Task', 'cf6e1522-efa2-0226-18a1-6b055ac0d2a2', false, false, '5140', '2017-06-09 10:51:17.505', '2017-06-09 11:00:34.376', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('3b4747b4-3fb6-eddc-478b-fff34a7b18af', '2017-06-09 12:19:50.791', 'admin', 3, '2017-06-09 12:22:18.869', 'admin', NULL, NULL, 'pm$Task', '47965ed0-1f9c-12a3-49e7-f3266a21f0ae', false, false, '10084', '2017-06-09 12:19:50.837', '2017-06-09 12:22:18.847', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('a2ad2b1e-6640-73c0-e407-5b7745798474', '2017-06-09 12:19:50.792', 'admin', 3, '2017-06-09 12:22:38.093', 'admin', NULL, NULL, 'pm$Task', 'a609e3ac-9064-5e53-ba39-2974658cd0ed', false, false, '10097', '2017-06-09 12:19:50.867', '2017-06-09 12:22:38.071', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('f5d59e87-0c46-f990-1dee-bbcf61e634c3', '2017-06-09 12:19:50.711', 'admin', 3, '2017-06-09 12:22:38.093', 'admin', NULL, NULL, 'pm$Project', 'd9903c5e-82f1-79f2-1f02-05933bbdf60c', false, false, '10075', '2017-06-09 12:19:50.777', '2017-06-09 12:22:38.068', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('ec84c036-d83c-811c-1579-6f91a876ffd5', '2017-06-09 10:41:29.817', 'admin', 3, '2017-06-09 12:22:44.885', 'admin', NULL, NULL, 'pm$Task', 'bbbf5f42-c185-1e1e-51dc-d0e496809ff1', false, false, '5023', '2017-06-09 10:41:29.956', '2017-06-09 12:22:44.868', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('edf7782d-3373-c3cd-0fc2-c9139eac9bb9', '2017-06-09 10:41:29.604', 'admin', 3, '2017-06-09 12:22:44.885', 'admin', NULL, NULL, 'pm$Project', 'c51a9e7f-9600-56ed-143e-f24e8bd0b463', false, false, '5001', '2017-06-09 10:41:29.799', '2017-06-09 12:22:44.864', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('c60e683c-726f-5103-ee1a-1042eea62182', '2017-06-09 11:11:29.732', 'admin', 3, '2017-06-09 12:24:08.322', 'admin', NULL, NULL, 'pm$Task', '2cece3a4-837c-12c2-524f-dc3c7dfaf666', false, false, '5262', '2017-06-09 11:11:29.789', '2017-06-09 12:24:08.3', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('185c4228-11b3-3b3a-288e-c3ca90747956', '2017-06-09 11:11:29.7', 'admin', 3, '2017-06-09 12:24:08.321', 'admin', NULL, NULL, 'pm$Project', 'b1fdc8db-3a16-c864-4679-8dfe13ac160b', false, false, '5253', '2017-06-09 11:11:29.724', '2017-06-09 12:24:08.297', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('c791c654-d58f-8b11-7a5d-effbfed7f2b7', '2017-06-09 12:02:05.917', 'admin', 3, '2017-06-09 12:24:16.464', 'admin', NULL, NULL, 'pm$Task', 'f6b2af00-c340-686a-3a1d-1f49296aedca', false, false, '7510', '2017-06-09 12:02:06.001', '2017-06-09 12:24:16.446', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('7cc28383-ab4d-7109-6566-7e9dc02b9064', '2017-06-09 12:02:05.398', 'admin', 3, '2017-06-09 12:24:16.464', 'admin', NULL, NULL, 'pm$Project', '46a77952-500a-cf42-7535-840e7894c83b', false, false, '7501', '2017-06-09 12:02:05.901', '2017-06-09 12:24:16.442', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('88780826-cafd-15d8-59dc-e66d06d4829b', '2017-06-09 12:05:00.081', 'admin', 3, '2017-06-09 12:24:20.778', 'admin', NULL, NULL, 'pm$Task', 'bccb71b0-7f61-5a7b-32e6-79dab78c9cdb', false, false, '7554', '2017-06-09 12:05:00.128', '2017-06-09 12:24:20.765', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('67f8c457-f4dc-a0f4-ab4e-caa626f75165', '2017-06-09 12:05:00.04', 'admin', 3, '2017-06-09 12:24:20.778', 'admin', NULL, NULL, 'pm$Project', '7abc2aea-577b-67a1-ecdc-fd33b2e2eaa9', false, false, '7545', '2017-06-09 12:05:00.068', '2017-06-09 12:24:20.761', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('f516a36f-2002-269a-817c-dd84c0e1b905', '2017-06-09 12:04:17.399', 'admin', 3, '2017-06-09 12:24:23.685', 'admin', NULL, NULL, 'pm$Project', '82af3f9c-41f4-e1b1-3f77-660e7ed8fb55', false, false, '7523', '2017-06-09 12:04:17.432', '2017-06-09 12:24:23.655', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);
INSERT INTO bpm_proc_instance VALUES ('0a86205e-b926-0462-015a-e24ee29c7fa0', '2017-06-09 12:04:17.445', 'admin', 3, '2017-06-09 12:24:23.685', 'admin', NULL, NULL, 'pm$Task', 'fc7dfc2f-698d-ed8f-fc4c-4d3fa71b2e8c', false, false, '7532', '2017-06-09 12:04:17.494', '2017-06-09 12:24:23.657', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '', NULL, NULL, NULL);


--
-- TOC entry 2923 (class 0 OID 39868)
-- Dependencies: 233
-- Data for Name: bpm_proc_model; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_model VALUES ('4c7405ae-470d-65cd-9efe-18beb7fc47e2', '2017-06-08 14:56:52.901', 'admin', 3, '2017-06-09 11:03:44.093', 'admin', NULL, NULL, 'Исполнение задач', '1', '');
INSERT INTO bpm_proc_model VALUES ('cdd9ff40-b70b-e6db-b3f3-3590a16a52e3', '2017-06-08 14:56:55.555', 'admin', 3, '2017-06-09 11:04:19.202', 'admin', NULL, NULL, 'Исполнение проекта', '3', '');


--
-- TOC entry 2916 (class 0 OID 39818)
-- Dependencies: 226
-- Data for Name: bpm_proc_role; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_role VALUES ('0c2c8db3-1f7a-921f-8512-3ac1ed67791a', '2017-06-08 14:58:06.904', 'admin', 1, '2017-06-08 14:58:06.904', NULL, NULL, NULL, 'manager', 'manager', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 1);
INSERT INTO bpm_proc_role VALUES ('1f81c94a-15f2-381b-5213-369e58fc19c3', '2017-06-08 14:58:06.904', 'admin', 1, '2017-06-08 14:58:06.904', NULL, NULL, NULL, 'executor', 'executor', 'b032cb0f-4e43-077f-d1da-6ba769aca306', 0);
INSERT INTO bpm_proc_role VALUES ('e60946ff-f40c-fb0b-6178-c3c3b936da95', '2017-06-08 14:58:15.235', 'admin', 1, '2017-06-08 14:58:15.235', NULL, NULL, NULL, 'manager', 'manager', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 0);
INSERT INTO bpm_proc_role VALUES ('d6b0d8cd-f39d-0c71-a5d7-6868e095916c', '2017-06-08 14:58:15.235', 'admin', 1, '2017-06-08 14:58:15.235', NULL, NULL, NULL, 'projectOfficeEmployee', 'projectOfficeEmployee', '02c824b8-0a20-a345-96e0-e9df04fbfba0', 1);


--
-- TOC entry 2921 (class 0 OID 39855)
-- Dependencies: 231
-- Data for Name: bpm_proc_task; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_task VALUES ('0fba54ac-2ab8-8b92-db4f-2256a18c32f8', '2017-06-09 10:56:26.733', 'admin', 4, '2017-06-09 11:00:34.394', 'admin', NULL, NULL, '6a80a0aa-515a-2917-d763-0956ee16775e', '2017-06-09 10:56:26.732', '2017-06-09 11:00:34.344', 'completed', '317cf8d4-3eb3-ed2f-dcda-9d57db942de0', '5140', 'Work on task', '5216', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('860a5618-8811-3365-89e5-ce2c3606ee6b', '2017-06-08 15:12:14.808', 'admin', 4, '2017-06-08 15:13:15.587', 'admin', NULL, NULL, '608f36f3-0f88-7659-2b80-cc20b9c20772', '2017-06-08 15:12:14.808', '2017-06-08 15:13:15.529', 'completed', '92846f0f-def6-6c33-ccb9-c975030f1e56', '2523', 'Work on task', '2606', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('d37e81b5-1318-dd9e-7fcb-5db1f288ce4d', '2017-06-08 15:08:28.482', 'admin', 4, '2017-06-08 15:08:41.764', 'admin', NULL, NULL, '608f36f3-0f88-7659-2b80-cc20b9c20772', '2017-06-08 15:08:28.482', '2017-06-08 15:08:41.677', 'estimated', '92846f0f-def6-6c33-ccb9-c975030f1e56', '2523', 'Estimation', '2530', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('7c36933f-d58f-63b7-e700-5838b7dea89e', '2017-06-08 15:11:49.586', 'admin', 4, '2017-06-08 15:12:05.787', 'admin', NULL, NULL, 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '2017-06-08 15:11:49.586', '2017-06-08 15:12:05.75', 'plan', '8f67873f-50e5-d7a9-439b-ec4f2dbbce95', '2510', 'Planning by manager', '2581', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('c6d3a9e4-b533-aee5-da03-3c984c75ee48', '2017-06-08 15:08:28.44', 'admin', 4, '2017-06-08 15:09:04.362', 'admin', NULL, NULL, 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '2017-06-08 15:08:28.44', '2017-06-08 15:09:04.305', 'estimated', '5850b3d0-0eb6-3aa2-66f8-e064851e1251', '2510', 'Estimation', '2517', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('4d48bcc8-4395-5401-d1dc-a00a623a67ad', '2017-06-09 10:51:17.499', 'admin', 4, '2017-06-09 10:52:47.148', 'admin', NULL, NULL, '6a80a0aa-515a-2917-d763-0956ee16775e', '2017-06-09 10:51:17.499', '2017-06-09 10:52:47.115', 'estimated', '317cf8d4-3eb3-ed2f-dcda-9d57db942de0', '5140', 'Estimation', '5147', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('33333d86-5ee4-a234-5bf2-2076870ae9cf', '2017-06-09 10:41:29.947', 'admin', 4, '2017-06-09 10:42:30.485', 'admin', NULL, NULL, 'ec84c036-d83c-811c-1579-6f91a876ffd5', '2017-06-09 10:41:29.947', '2017-06-09 10:42:30.429', 'estimated', '51a0a444-9aa2-57b5-ff22-6e3926d896c3', '5023', 'Estimation', '5030', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('f22142c9-db7d-397e-c4d3-a8e5c55f3f40', '2017-06-09 10:51:17.463', 'admin', 4, '2017-06-09 10:52:18.564', 'admin', NULL, NULL, '2d884abd-991e-d42e-8f4d-d31c6284bc13', '2017-06-09 10:51:17.463', '2017-06-09 10:52:18.523', 'estimated', '5db2cb7d-9c97-ee37-b8f6-15309a1a6417', '5127', 'Estimation', '5134', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('5ec4983c-e855-7547-557d-be65626a5d8e', '2017-06-09 10:56:31.766', 'admin', 4, '2017-06-09 11:00:12.216', 'admin', NULL, NULL, '2d884abd-991e-d42e-8f4d-d31c6284bc13', '2017-06-09 10:56:31.766', '2017-06-09 11:00:12.177', 'completed', '5db2cb7d-9c97-ee37-b8f6-15309a1a6417', '5127', 'Work on task', '5223', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('6a113f67-6ca4-2bad-532a-50bc45bdb453', '2017-06-09 10:45:25.577', 'admin', 4, '2017-06-09 10:45:53.179', 'admin', NULL, NULL, 'ec84c036-d83c-811c-1579-6f91a876ffd5', '2017-06-09 10:45:25.577', '2017-06-09 10:45:53.131', 'plan', '2c37a2dd-8992-716a-3eaa-98867523fe7a', '5023', 'Planning by manager', '5088', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('61553fcf-fe00-4414-6c83-299ac43d643d', '2017-06-08 15:12:05.79', 'admin', 4, '2017-06-08 15:13:53.729', 'admin', NULL, NULL, 'bdd1221d-fc1b-86f7-62a0-163a7f3d9c54', '2017-06-08 15:12:05.79', '2017-06-08 15:13:53.657', 'completed', '5850b3d0-0eb6-3aa2-66f8-e064851e1251', '2510', 'Work on task', '2599', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('71932fa1-24fd-3517-a867-aca74423d2a7', '2017-06-09 10:54:48.781', 'admin', 4, '2017-06-09 10:56:26.716', 'admin', NULL, NULL, '6a80a0aa-515a-2917-d763-0956ee16775e', '2017-06-09 10:54:48.781', '2017-06-09 10:56:26.699', 'plan', '747f9b18-a94a-251a-d658-be6c1bae80f9', '5140', 'Planning by manager', '5205', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('a717d8b0-e3ce-3a8c-6207-b196d5bed618', '2017-06-08 15:11:49.606', 'admin', 4, '2017-06-08 15:12:14.804', 'admin', NULL, NULL, '608f36f3-0f88-7659-2b80-cc20b9c20772', '2017-06-08 15:11:49.606', '2017-06-08 15:12:14.773', 'plan', '9e9f738b-8819-96e8-755f-f58837e166ca', '2523', 'Planning by manager', '2588', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('61dcc5ea-ba81-4a48-5fa0-2812368349ab', '2017-06-09 10:45:25.554', 'admin', 4, '2017-06-09 10:45:44.001', 'admin', NULL, NULL, 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '2017-06-09 10:45:25.553', '2017-06-09 10:45:43.972', 'plan', '0e33ee9b-f2f7-f9f2-b6fb-932484959ac1', '5010', 'Planning by manager', '5081', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('48b7e97b-d295-ee39-2d34-db60737a2397', '2017-06-09 10:42:30.5', 'admin', 4, '2017-06-09 10:45:25.547', 'admin', NULL, NULL, 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', '2017-06-09 10:42:30.5', '2017-06-09 10:45:25.503', 'approve', '7c885637-ffbb-a53d-2d58-39b16657baed', '5053', 'Project office approval', '5062', NULL, NULL, '2017-06-09 10:44:14.916', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('1ab486c2-a8d7-5940-4711-ca4beadb86b2', '2017-06-09 10:52:47.158', 'admin', 4, '2017-06-09 10:54:25.962', 'admin', NULL, NULL, 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', '2017-06-09 10:52:47.158', '2017-06-09 10:54:25.946', 'approve', '4d3f286f-ec10-295a-5c12-b967df6b244f', '5170', 'Project office approval', '5179', NULL, NULL, '2017-06-09 10:53:58.12', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('4da82787-3031-823b-e756-e47bf4fb9202', '2017-06-09 10:52:47.151', 'admin', 3, '2017-06-09 10:54:48.761', 'admin', NULL, NULL, 'dcbc3bc8-469a-0d0d-0946-31979f87b3ca', '2017-06-09 10:52:47.151', '2017-06-09 10:54:48.73', 'approve', '1ae67d69-2eb9-a039-4550-c2188b2e9ab0', '5169', 'Manager approval', '5172', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('4d3bc982-48ef-e37b-2739-a9fac7b34a23', '2017-06-08 15:09:04.367', 'admin', 3, '2017-06-08 15:11:38.271', 'admin', NULL, NULL, '2dde2d53-1b8a-46cb-b85b-716a66d57189', '2017-06-08 15:09:04.367', '2017-06-08 15:11:38.248', 'approve', '1c66a6f1-e527-3f33-5406-3f49413389c6', '2552', 'Manager approval', '2555', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('bdf11ebe-a263-87c1-317f-a55d56950dac', '2017-06-08 15:09:04.379', 'admin', 4, '2017-06-08 15:11:49.582', 'admin', NULL, NULL, '2dde2d53-1b8a-46cb-b85b-716a66d57189', '2017-06-08 15:09:04.379', '2017-06-08 15:11:49.531', 'approve', '7b83c36e-258a-f7c5-f16a-fcfa22c9ba22', '2553', 'Project office approval', '2562', NULL, NULL, '2017-06-08 15:11:46.174', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('0ac80639-e384-03b3-4211-1891d3b896c8', '2017-06-09 10:42:30.49', 'admin', 3, '2017-06-09 10:43:58.241', 'admin', NULL, NULL, 'edf7782d-3373-c3cd-0fc2-c9139eac9bb9', '2017-06-09 10:42:30.49', '2017-06-09 10:43:58.207', 'approve', '3690f556-200b-257b-e9da-fed0accad43c', '5052', 'Manager approval', '5055', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('6b9be4ba-d5a9-b5d0-985a-32f8ec8d8ee0', '2017-06-09 10:45:53.183', 'admin', 4, '2017-06-09 12:22:44.885', 'admin', NULL, NULL, 'ec84c036-d83c-811c-1579-6f91a876ffd5', '2017-06-09 10:45:53.183', '2017-06-09 12:22:44.838', 'completed', '51a0a444-9aa2-57b5-ff22-6e3926d896c3', '5023', 'Work on task', '5106', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('7a4780e9-cf75-d266-5e3c-ed0464f42f3c', '2017-06-09 10:45:44.005', 'admin', 4, '2017-06-09 10:47:02.101', 'admin', NULL, NULL, 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '2017-06-09 10:45:44.005', '2017-06-09 10:47:02.044', 'completed', '5678ad8a-49de-4016-7e8d-5cb18ce5134d', '5010', 'Work on task', '5099', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('ae33b1b8-9520-dd85-ce29-bb11e37d342e', '2017-06-09 10:54:48.765', 'admin', 4, '2017-06-09 10:56:31.762', 'admin', NULL, NULL, '2d884abd-991e-d42e-8f4d-d31c6284bc13', '2017-06-09 10:54:48.765', '2017-06-09 10:56:31.746', 'plan', '0d39671e-8903-1281-4e39-f67a03ebd75a', '5127', 'Planning by manager', '5198', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('e31a40f4-d338-36e1-cadd-5171f7782bc2', '2017-06-09 10:41:29.901', 'admin', 4, '2017-06-09 10:42:16.295', 'admin', NULL, NULL, 'f663a4ee-b21f-73f8-b9a1-aca328a8ea18', '2017-06-09 10:41:29.901', '2017-06-09 10:42:16.217', 'estimated', '5678ad8a-49de-4016-7e8d-5cb18ce5134d', '5010', 'Estimation', '5017', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('12ee6bbc-1d5d-ddd1-3c14-f704f11f510b', '2017-06-09 11:11:29.78', 'admin', 2, '2017-06-09 12:09:33.875', 'admin', NULL, NULL, 'c60e683c-726f-5103-ee1a-1042eea62182', '2017-06-09 11:11:29.78', '2017-06-09 12:09:33.724', 'estimated', '43c0ae2f-e5ac-db76-13c1-399ee4873085', '5262', 'Estimation', '5269', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('a9a83a04-3bed-e84b-3714-c4a52456ca21', '2017-06-09 12:09:33.893', 'admin', 3, '2017-06-09 12:09:55.534', 'admin', NULL, NULL, '185c4228-11b3-3b3a-288e-c3ca90747956', '2017-06-09 12:09:33.893', '2017-06-09 12:09:55.506', 'approve', 'acea3d34-069b-71e5-2c96-acce62346184', '10008', 'Project office approval', '10017', NULL, NULL, '2017-06-09 12:09:43.12', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('596b25d8-1dd8-fb74-ec5a-d8eb3407bd62', '2017-06-09 12:02:05.983', 'admin', 2, '2017-06-09 12:11:58.02', 'admin', NULL, NULL, 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', '2017-06-09 12:02:05.983', '2017-06-09 12:11:57.97', 'estimated', '897a2020-957b-253e-4cdc-8dff8d376406', '7510', 'Estimation', '7517', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('b130c7c4-4024-edc0-21d2-fb9b797c110f', '2017-06-09 12:11:58.034', 'admin', 3, '2017-06-09 12:12:09.156', 'admin', NULL, NULL, '7cc28383-ab4d-7109-6566-7e9dc02b9064', '2017-06-09 12:11:58.034', '2017-06-09 12:12:09.134', 'approve', '270abf88-3b54-dece-3d49-700f1ddd6242', '10038', 'Project office approval', '10047', NULL, NULL, '2017-06-09 12:12:05.616', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('ede9a97e-70fa-87ab-82ca-b02e385afc0a', '2017-06-09 12:11:58.026', 'admin', 2, '2017-06-09 12:12:26.902', 'admin', NULL, NULL, '7cc28383-ab4d-7109-6566-7e9dc02b9064', '2017-06-09 12:11:58.026', '2017-06-09 12:12:26.86', 'approve', '09ce27cd-9f34-cdd1-3a82-8809b4c6549a', '10037', 'Manager approval', '10040', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('23b076f6-17a7-f5ac-cdad-501e8ee5357f', '2017-06-09 12:19:50.827', 'admin', 2, '2017-06-09 12:20:19.953', 'admin', NULL, NULL, '3b4747b4-3fb6-eddc-478b-fff34a7b18af', '2017-06-09 12:19:50.826', '2017-06-09 12:20:19.918', 'estimated', '75eff276-5967-c5e9-19f5-21770ea5c065', '10084', 'Estimation', '10091', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('95ff55db-2a25-893d-11e0-9dd88cb7a242', '2017-06-09 12:19:50.86', 'admin', 2, '2017-06-09 12:20:32.514', 'admin', NULL, NULL, 'a2ad2b1e-6640-73c0-e407-5b7745798474', '2017-06-09 12:19:50.86', '2017-06-09 12:20:32.464', 'estimated', 'a9be298e-32a9-85a5-f4b0-f6b892f22140', '10097', 'Estimation', '10104', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('b65a1eec-f027-56fa-f7c4-5ef151dc28fe', '2017-06-09 12:20:32.518', 'admin', 2, '2017-06-09 12:21:04.334', 'admin', NULL, NULL, 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', '2017-06-09 12:20:32.518', '2017-06-09 12:21:04.317', 'approve', '3736caeb-bc31-458c-3f2f-73da625a25c9', '10126', 'Manager approval', '10129', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('06a30615-a429-c0b8-cf6c-510ee40425c4', '2017-06-09 12:20:32.527', 'admin', 3, '2017-06-09 12:21:21.458', 'admin', NULL, NULL, 'f5d59e87-0c46-f990-1dee-bbcf61e634c3', '2017-06-09 12:20:32.527', '2017-06-09 12:21:21.412', 'approve', '804d3f5d-43ea-069a-e035-3f0f527e51f3', '10127', 'Project office approval', '10136', NULL, NULL, '2017-06-09 12:21:12.058', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('1a51a8f5-3e69-b47d-7041-415c78bf3d82', '2017-06-09 12:21:21.462', 'admin', 2, '2017-06-09 12:21:39.638', 'admin', NULL, NULL, '3b4747b4-3fb6-eddc-478b-fff34a7b18af', '2017-06-09 12:21:21.462', '2017-06-09 12:21:39.62', 'plan', '4145bb58-c5d2-f5da-64e6-0c6e28726618', '10084', 'Planning by manager', '10155', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('43ce930d-6f87-33f9-6a06-7e964cdd8025', '2017-06-09 12:21:21.475', 'admin', 2, '2017-06-09 12:21:47.487', 'admin', NULL, NULL, 'a2ad2b1e-6640-73c0-e407-5b7745798474', '2017-06-09 12:21:21.475', '2017-06-09 12:21:47.468', 'plan', '18f1a9ac-0f6e-20f2-659e-ef1317ac6420', '10097', 'Planning by manager', '10162', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('38c2d5c6-876c-d098-e7f4-b468eb7730a0', '2017-06-09 12:21:39.643', 'admin', 2, '2017-06-09 12:22:18.869', 'admin', NULL, NULL, '3b4747b4-3fb6-eddc-478b-fff34a7b18af', '2017-06-09 12:21:39.643', '2017-06-09 12:22:18.812', 'completed', '75eff276-5967-c5e9-19f5-21770ea5c065', '10084', 'Work on task', '10173', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('5198c865-68a5-2a87-282d-6f37c7dc9db0', '2017-06-09 12:21:47.491', 'admin', 2, '2017-06-09 12:22:38.093', 'admin', NULL, NULL, 'a2ad2b1e-6640-73c0-e407-5b7745798474', '2017-06-09 12:21:47.49', '2017-06-09 12:22:38.04', 'completed', 'a9be298e-32a9-85a5-f4b0-f6b892f22140', '10097', 'Work on task', '10180', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('d98346b8-084d-c201-723a-aed6cb6ea0a1', '2017-06-09 12:05:00.115', 'admin', 2, '2017-06-09 12:22:49.915', 'admin', NULL, NULL, '88780826-cafd-15d8-59dc-e66d06d4829b', '2017-06-09 12:05:00.115', '2017-06-09 12:22:49.884', 'estimated', '15c2767d-027f-d518-2467-fdd89de11b7b', '7554', 'Estimation', '7561', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('79189075-90a3-470e-312f-62ac5b7655ba', '2017-06-09 12:04:17.481', 'admin', 2, '2017-06-09 12:22:54.674', 'admin', NULL, NULL, '0a86205e-b926-0462-015a-e24ee29c7fa0', '2017-06-09 12:04:17.481', '2017-06-09 12:22:54.643', 'estimated', '0a75b875-3fab-0540-7d90-5959ed910266', '7532', 'Estimation', '7539', NULL, NULL, NULL, 'task-wf:3:5248', 'estimation');
INSERT INTO bpm_proc_task VALUES ('2ee1551a-b375-50a8-2b66-3eff7368adf5', '2017-06-09 12:22:49.924', 'admin', 3, '2017-06-09 12:23:11.553', 'admin', NULL, NULL, '67f8c457-f4dc-a0f4-ab4e-caa626f75165', '2017-06-09 12:22:49.924', '2017-06-09 12:23:11.541', 'approve', '20952a50-dc3b-505c-e950-884e31fb6eb0', '10211', 'Project office approval', '10220', NULL, NULL, '2017-06-09 12:23:05.527', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('3cd8668b-3a9d-1073-fead-97b7c967c16b', '2017-06-09 12:22:54.683', 'admin', 3, '2017-06-09 12:23:14.414', 'admin', NULL, NULL, 'f516a36f-2002-269a-817c-dd84c0e1b905', '2017-06-09 12:22:54.683', '2017-06-09 12:23:14.403', 'approve', 'eca8b0e1-a1a6-1dc6-9afd-f17aa0a8b161', '10239', 'Project office approval', '10248', NULL, NULL, '2017-06-09 12:23:08.375', 'project-wf:2:5252', 'projectOfficeApproval');
INSERT INTO bpm_proc_task VALUES ('8a0ff531-231f-fa65-9f11-13faf2d6a8b8', '2017-06-09 12:09:33.881', 'admin', 2, '2017-06-09 12:23:25.028', 'admin', NULL, NULL, '185c4228-11b3-3b3a-288e-c3ca90747956', '2017-06-09 12:09:33.881', '2017-06-09 12:23:25.002', 'approve', '8bf107ee-f906-75d9-83c3-04d648ac544c', '10007', 'Manager approval', '10010', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('57557480-b428-1069-fdd6-70f194da889f', '2017-06-09 12:23:25.031', 'admin', 2, '2017-06-09 12:23:32.898', 'admin', NULL, NULL, 'c60e683c-726f-5103-ee1a-1042eea62182', '2017-06-09 12:23:25.031', '2017-06-09 12:23:32.883', 'plan', 'd7f231c7-36e4-7647-1e7d-2bcc6bc1848e', '5262', 'Planning by manager', '10269', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('006c04f0-231e-0bda-1e16-742c0afb8ccd', '2017-06-09 12:12:26.909', 'admin', 2, '2017-06-09 12:23:39.493', 'admin', NULL, NULL, 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', '2017-06-09 12:12:26.909', '2017-06-09 12:23:39.476', 'plan', '45d85e9b-9e59-1542-bea3-4c141c121968', '7510', 'Planning by manager', '10066', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('6b891cdd-60f3-fe14-d238-449bf45f6cc8', '2017-06-09 12:22:54.677', 'admin', 2, '2017-06-09 12:23:43.543', 'admin', NULL, NULL, 'f516a36f-2002-269a-817c-dd84c0e1b905', '2017-06-09 12:22:54.677', '2017-06-09 12:23:43.499', 'approve', '55a2886f-5e56-c0ae-b18e-4c16a514cd71', '10238', 'Manager approval', '10241', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('b569b227-96cc-37cb-2cfc-7151289c0628', '2017-06-09 12:22:49.918', 'admin', 2, '2017-06-09 12:23:47.918', 'admin', NULL, NULL, '67f8c457-f4dc-a0f4-ab4e-caa626f75165', '2017-06-09 12:22:49.918', '2017-06-09 12:23:47.89', 'approve', '629951bc-66e4-f002-998e-c886e829346c', '10210', 'Manager approval', '10213', NULL, NULL, NULL, 'project-wf:2:5252', 'managerApproval');
INSERT INTO bpm_proc_task VALUES ('b79ffcf3-b374-e4a4-1c3a-8434a6f78570', '2017-06-09 12:23:47.921', 'admin', 2, '2017-06-09 12:23:54.809', 'admin', NULL, NULL, '88780826-cafd-15d8-59dc-e66d06d4829b', '2017-06-09 12:23:47.921', '2017-06-09 12:23:54.793', 'plan', '309bd9d3-19c4-93fd-df5f-57fd1d5543d0', '7554', 'Planning by manager', '10311', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('0eeb0c2e-82b6-badf-53ab-8b591e6934ce', '2017-06-09 12:23:43.546', 'admin', 2, '2017-06-09 12:24:00.391', 'admin', NULL, NULL, '0a86205e-b926-0462-015a-e24ee29c7fa0', '2017-06-09 12:23:43.546', '2017-06-09 12:24:00.371', 'plan', '7ac7a2e6-f104-8c17-857c-48028d5d0765', '7532', 'Planning by manager', '10297', NULL, NULL, NULL, 'task-wf:3:5248', 'planningByManager');
INSERT INTO bpm_proc_task VALUES ('c4f9e46a-e8db-bdaf-2d46-50a41cab9ba2', '2017-06-09 12:23:32.901', 'admin', 2, '2017-06-09 12:24:08.322', 'admin', NULL, NULL, 'c60e683c-726f-5103-ee1a-1042eea62182', '2017-06-09 12:23:32.901', '2017-06-09 12:24:08.261', 'completed', '43c0ae2f-e5ac-db76-13c1-399ee4873085', '5262', 'Work on task', '10280', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('abf3c77d-ebc1-c753-7041-9d878a81b47e', '2017-06-09 12:23:39.496', 'admin', 2, '2017-06-09 12:24:16.464', 'admin', NULL, NULL, 'c791c654-d58f-8b11-7a5d-effbfed7f2b7', '2017-06-09 12:23:39.496', '2017-06-09 12:24:16.42', 'completed', '897a2020-957b-253e-4cdc-8dff8d376406', '7510', 'Work on task', '10287', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('37a84b39-9eaf-736f-65fb-02fc0e0a4a85', '2017-06-09 12:23:54.812', 'admin', 2, '2017-06-09 12:24:20.778', 'admin', NULL, NULL, '88780826-cafd-15d8-59dc-e66d06d4829b', '2017-06-09 12:23:54.812', '2017-06-09 12:24:20.735', 'completed', '15c2767d-027f-d518-2467-fdd89de11b7b', '7554', 'Work on task', '10322', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');
INSERT INTO bpm_proc_task VALUES ('c10670b0-fbca-767b-8585-97fc501cc083', '2017-06-09 12:24:00.394', 'admin', 2, '2017-06-09 12:24:23.685', 'admin', NULL, NULL, '0a86205e-b926-0462-015a-e24ee29c7fa0', '2017-06-09 12:24:00.394', '2017-06-09 12:24:23.615', 'completed', '0a75b875-3fab-0540-7d90-5959ed910266', '7532', 'Work on task', '10329', NULL, NULL, NULL, 'task-wf:3:5248', 'workOnTask');


--
-- TOC entry 2922 (class 0 OID 39863)
-- Dependencies: 232
-- Data for Name: bpm_proc_task_user_link; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_proc_task_user_link VALUES ('bdf11ebe-a263-87c1-317f-a55d56950dac', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('bdf11ebe-a263-87c1-317f-a55d56950dac', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('48b7e97b-d295-ee39-2d34-db60737a2397', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('48b7e97b-d295-ee39-2d34-db60737a2397', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('1ab486c2-a8d7-5940-4711-ca4beadb86b2', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('1ab486c2-a8d7-5940-4711-ca4beadb86b2', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('a9a83a04-3bed-e84b-3714-c4a52456ca21', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('a9a83a04-3bed-e84b-3714-c4a52456ca21', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('b130c7c4-4024-edc0-21d2-fb9b797c110f', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('b130c7c4-4024-edc0-21d2-fb9b797c110f', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('06a30615-a429-c0b8-cf6c-510ee40425c4', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('06a30615-a429-c0b8-cf6c-510ee40425c4', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('2ee1551a-b375-50a8-2b66-3eff7368adf5', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('2ee1551a-b375-50a8-2b66-3eff7368adf5', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO bpm_proc_task_user_link VALUES ('3cd8668b-3a9d-1073-fead-97b7c967c16b', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO bpm_proc_task_user_link VALUES ('3cd8668b-3a9d-1073-fead-97b7c967c16b', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');


--
-- TOC entry 2924 (class 0 OID 39876)
-- Dependencies: 234
-- Data for Name: bpm_stencil_set; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO bpm_stencil_set VALUES ('98e1a8ef-f84f-9b50-40c6-ae8bec92ef4f', '2017-06-08 14:56:45.189', 'admin', 1, '2017-06-08 14:56:45.189', NULL, NULL, NULL, 'default', '{"propertyPackages":[{"name":"taskstate-taskidpackage","properties":[{"id":"taskstate-taskid","type":"String","title":"TaskId","value":"entityId","popular":true}],"custom":{"type":"serviceTask"}},{"name":"taskstate-enumvaluepackage","properties":[{"id":"taskstate-enumvalue","type":"String","title":"EnumValue","popular":true}],"custom":{"type":"serviceTask"}},{"name":"projectstate-entityidpackage","properties":[{"id":"projectstate-entityid","type":"String","title":"EntityId","popular":true}],"custom":{"type":"serviceTask"}},{"name":"projectstate-enumvaluepackage","properties":[{"id":"projectstate-enumvalue","type":"String","title":"EnumValue","popular":true}],"custom":{"type":"serviceTask"}}],"stencils":[{"type":"node","id":"taskState","title":"Task state","view":"\u003c?xml version\u003d\"1.0\" encoding\u003d\"UTF-8\" standalone\u003d\"no\"?\u003e\n\u003csvg\n   xmlns\u003d\"http://www.w3.org/2000/svg\"\n   xmlns:svg\u003d\"http://www.w3.org/2000/svg\"\n   xmlns:oryx\u003d\"http://www.b3mn.org/oryx\"\n   xmlns:xlink\u003d\"http://www.w3.org/1999/xlink\"\n\n   width\u003d\"102\"\n   height\u003d\"82\"\n   version\u003d\"1.0\"\u003e\n  \u003cdefs\u003e\u003c/defs\u003e\n  \u003coryx:magnets\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"20\" oryx:anchors\u003d\"left\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"40\" oryx:anchors\u003d\"left\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"60\" oryx:anchors\u003d\"left\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"25\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"75\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"20\" oryx:anchors\u003d\"right\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"40\" oryx:anchors\u003d\"right\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"60\" oryx:anchors\u003d\"right\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"25\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"75\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"40\" oryx:default\u003d\"yes\" /\u003e\n  \u003c/oryx:magnets\u003e\n  \u003cg pointer-events\u003d\"fill\" oryx:minimumSize\u003d\"50 40\"\u003e\n\t\u003crect id\u003d\"text_frame\" oryx:anchors\u003d\"bottom top right left\" x\u003d\"1\" y\u003d\"1\" width\u003d\"94\" height\u003d\"79\" rx\u003d\"10\" ry\u003d\"10\" stroke\u003d\"none\" stroke-width\u003d\"0\" fill\u003d\"none\" /\u003e\n\t\u003crect id\u003d\"bg_frame\" oryx:resize\u003d\"vertical horizontal\" x\u003d\"0\" y\u003d\"0\" width\u003d\"100\" height\u003d\"80\" rx\u003d\"10\" ry\u003d\"10\" stroke\u003d\"#bbbbbb\" stroke-width\u003d\"1\" fill\u003d\"#f9f9f9\" /\u003e\n\t\t\u003ctext \n\t\t\tfont-size\u003d\"12\" \n\t\t\tid\u003d\"text_name\" \n\t\t\tx\u003d\"50\" \n\t\t\ty\u003d\"40\" \n\t\t\toryx:align\u003d\"middle center\"\n\t\t\toryx:fittoelem\u003d\"text_frame\"\n\t\t\tstroke\u003d\"#373e48\"\u003e\n\t\t\u003c/text\u003e\n\t\n\t\u003cg transform\u003d\"translate(3,3)\"\u003e\n\t\u003cimage x\u003d\"0\" y\u003d\"0\" width\u003d\"20\" height\u003d\"20\" xmlns:xlink\u003d\"http://www.w3.org/1999/xlink\" xlink:href\u003d\"icon?f\u003dc94a97c7-6781-34ce-7d9d-9a1788649bde\" image-rendering\u003d\"optimizeQuality\" id\u003d\"c94a97c7-6781-34ce-7d9d-9a1788649bde\"\u003e\u003c/image\u003e\n\t\u003c/g\u003e\n  \n\t\n\t\n\t\n\t\n\t\n  \u003c/g\u003e\n\u003c/svg\u003e","customIconId":"c94a97c7-6781-34ce-7d9d-9a1788649bde","groups":["PM"],"propertyPackages":["overrideidpackage","namepackage","servicetaskresultvariablepackage","taskstate-taskidpackage","taskstate-enumvaluepackage"],"mainPropertyPackages":["taskstate-taskidpackage","taskstate-enumvaluepackage"],"roles":["Activity","sequence_start","sequence_end","ActivitiesMorph","all"],"custom":{"type":"serviceTask","beanName":"pm_Projects","methodName":"updateTaskState","methodArgs":[{"propertyPackageName":"taskstate-taskidpackage","type":"java.util.UUID"},{"propertyPackageName":"taskstate-enumvaluepackage","type":"java.lang.String"}]}},{"type":"node","id":"projectState","title":"Project state","view":"\u003c?xml version\u003d\"1.0\" encoding\u003d\"UTF-8\" standalone\u003d\"no\"?\u003e\n\u003csvg\n   xmlns\u003d\"http://www.w3.org/2000/svg\"\n   xmlns:svg\u003d\"http://www.w3.org/2000/svg\"\n   xmlns:oryx\u003d\"http://www.b3mn.org/oryx\"\n   xmlns:xlink\u003d\"http://www.w3.org/1999/xlink\"\n\n   width\u003d\"102\"\n   height\u003d\"82\"\n   version\u003d\"1.0\"\u003e\n  \u003cdefs\u003e\u003c/defs\u003e\n  \u003coryx:magnets\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"20\" oryx:anchors\u003d\"left\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"40\" oryx:anchors\u003d\"left\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"1\" oryx:cy\u003d\"60\" oryx:anchors\u003d\"left\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"25\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"75\" oryx:cy\u003d\"79\" oryx:anchors\u003d\"bottom\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"20\" oryx:anchors\u003d\"right\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"40\" oryx:anchors\u003d\"right\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"99\" oryx:cy\u003d\"60\" oryx:anchors\u003d\"right\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"25\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\u003coryx:magnet oryx:cx\u003d\"75\" oryx:cy\u003d\"1\" oryx:anchors\u003d\"top\" /\u003e\n  \t\n  \t\u003coryx:magnet oryx:cx\u003d\"50\" oryx:cy\u003d\"40\" oryx:default\u003d\"yes\" /\u003e\n  \u003c/oryx:magnets\u003e\n  \u003cg pointer-events\u003d\"fill\" oryx:minimumSize\u003d\"50 40\"\u003e\n\t\u003crect id\u003d\"text_frame\" oryx:anchors\u003d\"bottom top right left\" x\u003d\"1\" y\u003d\"1\" width\u003d\"94\" height\u003d\"79\" rx\u003d\"10\" ry\u003d\"10\" stroke\u003d\"none\" stroke-width\u003d\"0\" fill\u003d\"none\" /\u003e\n\t\u003crect id\u003d\"bg_frame\" oryx:resize\u003d\"vertical horizontal\" x\u003d\"0\" y\u003d\"0\" width\u003d\"100\" height\u003d\"80\" rx\u003d\"10\" ry\u003d\"10\" stroke\u003d\"#bbbbbb\" stroke-width\u003d\"1\" fill\u003d\"#f9f9f9\" /\u003e\n\t\t\u003ctext \n\t\t\tfont-size\u003d\"12\" \n\t\t\tid\u003d\"text_name\" \n\t\t\tx\u003d\"50\" \n\t\t\ty\u003d\"40\" \n\t\t\toryx:align\u003d\"middle center\"\n\t\t\toryx:fittoelem\u003d\"text_frame\"\n\t\t\tstroke\u003d\"#373e48\"\u003e\n\t\t\u003c/text\u003e\n\t\n\t\u003cg transform\u003d\"translate(3,3)\"\u003e\n\t\u003cimage x\u003d\"0\" y\u003d\"0\" width\u003d\"20\" height\u003d\"20\" xmlns:xlink\u003d\"http://www.w3.org/1999/xlink\" xlink:href\u003d\"icon?f\u003d3d899e02-5c37-9c3e-f7f7-83c2cb79413a\" image-rendering\u003d\"optimizeQuality\" id\u003d\"3d899e02-5c37-9c3e-f7f7-83c2cb79413a\"\u003e\u003c/image\u003e\n\t\u003c/g\u003e\n  \n\t\n\t\n\t\n\t\n\t\n  \u003c/g\u003e\n\u003c/svg\u003e","customIconId":"3d899e02-5c37-9c3e-f7f7-83c2cb79413a","groups":["PM"],"propertyPackages":["overrideidpackage","namepackage","servicetaskresultvariablepackage","projectstate-entityidpackage","projectstate-enumvaluepackage"],"mainPropertyPackages":["projectstate-entityidpackage","projectstate-enumvaluepackage"],"roles":["Activity","sequence_start","sequence_end","ActivitiesMorph","all"],"custom":{"type":"serviceTask","beanName":"pm_Projects","methodName":"updateProjectState","methodArgs":[{"propertyPackageName":"projectstate-entityidpackage","type":"java.util.UUID"},{"propertyPackageName":"projectstate-enumvaluepackage","type":"java.lang.String"}]}}]}');


--
-- TOC entry 2952 (class 0 OID 40361)
-- Dependencies: 262
-- Data for Name: pm_company_goal; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO pm_company_goal VALUES ('0480149c-90be-36d8-bf15-86367400c42a', 1, '2017-06-08 14:59:46.636', 'admin', '2017-06-08 14:59:46.636', NULL, NULL, NULL, 'Улучшение качества производства');
INSERT INTO pm_company_goal VALUES ('d9a66c08-d893-e036-2c15-df6e2c1591da', 1, '2017-06-08 15:00:28.47', 'admin', '2017-06-08 15:00:28.47', NULL, NULL, NULL, 'Снижение издержек производства');
INSERT INTO pm_company_goal VALUES ('7809f2f3-bbf7-188f-143f-1ae41a7d85dd', 1, '2017-06-08 15:00:46.37', 'admin', '2017-06-08 15:00:46.37', NULL, NULL, NULL, 'Своевременная доставка до клиентов');


--
-- TOC entry 2951 (class 0 OID 40353)
-- Dependencies: 261
-- Data for Name: pm_project; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO pm_project VALUES ('90886911-a608-55a9-046b-ed8b4f2f73be', 7, '2017-06-08 15:06:53.426', 'admin', '2017-06-09 10:21:50.068', 'admin', '2017-06-09 10:51:13.118', 'admin', 'Проект-1', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '<i>Тестовая </i><b>задача</b>', 'CMPL');
INSERT INTO pm_project VALUES ('809bfead-990d-a6d8-af11-f5fb225e6d5d', 6, '2017-06-09 10:51:07.815', 'admin', '2017-06-09 11:00:34.368', 'admin', '2017-06-09 12:24:50.78', 'admin', 'Проект 1', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'Проект демо<span class="Apple-tab-span" style="white-space:pre">	</span>', 'CMPL');
INSERT INTO pm_project VALUES ('82af3f9c-41f4-e1b1-3f77-660e7ed8fb55', 6, '2017-06-09 12:04:14.395', 'admin', '2017-06-09 12:24:23.654', 'admin', '2017-06-09 12:24:50.776', 'admin', 'Проект-5', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, 'CMPL');
INSERT INTO pm_project VALUES ('b1fdc8db-3a16-c864-4679-8dfe13ac160b', 6, '2017-06-09 11:11:29.684', 'admin', '2017-06-09 12:24:08.296', 'admin', '2017-06-09 12:24:50.777', 'admin', 'Проект Года', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, 'CMPL');
INSERT INTO pm_project VALUES ('c51a9e7f-9600-56ed-143e-f24e8bd0b463', 6, '2017-06-09 10:41:29.551', 'admin', '2017-06-09 12:22:44.863', 'admin', '2017-06-09 12:24:50.781', 'admin', 'Проект 2', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'Описание 2', 'CMPL');
INSERT INTO pm_project VALUES ('d9903c5e-82f1-79f2-1f02-05933bbdf60c', 6, '2017-06-09 12:19:38.986', 'admin', '2017-06-09 12:22:38.066', 'admin', '2017-06-09 12:24:50.782', 'admin', 'ПП', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, 'CMPL');
INSERT INTO pm_project VALUES ('46a77952-500a-cf42-7535-840e7894c83b', 6, '2017-06-09 12:01:50.883', 'admin', '2017-06-09 12:24:16.441', 'admin', '2017-06-09 12:24:50.779', 'admin', 'Проект-4', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, 'CMPL');
INSERT INTO pm_project VALUES ('7abc2aea-577b-67a1-ecdc-fd33b2e2eaa9', 6, '2017-06-09 12:05:00.018', 'admin', '2017-06-09 12:24:20.759', 'admin', '2017-06-09 12:24:50.778', 'admin', 'Проект-6', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, 'CMPL');


--
-- TOC entry 2954 (class 0 OID 40374)
-- Dependencies: 264
-- Data for Name: pm_project_goal; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO pm_project_goal VALUES ('bb907320-e2bd-5591-86fe-4451a9f5eaf2', 2, '2017-06-08 15:06:53.426', 'admin', '2017-06-08 15:06:53.426', NULL, '2017-06-09 10:51:13.15', 'admin', 'Цель 2', 'd9a66c08-d893-e036-2c15-df6e2c1591da', '90886911-a608-55a9-046b-ed8b4f2f73be');
INSERT INTO pm_project_goal VALUES ('194ca8d2-80a0-506e-616a-37301746b1cc', 2, '2017-06-08 15:06:53.426', 'admin', '2017-06-08 15:06:53.426', NULL, '2017-06-09 10:51:13.15', 'admin', 'Цель 1', '7809f2f3-bbf7-188f-143f-1ae41a7d85dd', '90886911-a608-55a9-046b-ed8b4f2f73be');
INSERT INTO pm_project_goal VALUES ('aceb3874-f389-ffe4-81b6-00a00da1a848', 3, '2017-06-09 12:19:38.987', 'admin', '2017-06-09 12:20:01.789', 'admin', '2017-06-09 12:24:50.788', 'admin', '1', 'd9a66c08-d893-e036-2c15-df6e2c1591da', 'd9903c5e-82f1-79f2-1f02-05933bbdf60c');
INSERT INTO pm_project_goal VALUES ('e89cfe3e-8659-2c1e-5d50-137b96046e1b', 2, '2017-06-09 12:19:50.687', 'admin', '2017-06-09 12:19:50.687', NULL, '2017-06-09 12:24:50.788', 'admin', '2', '0480149c-90be-36d8-bf15-86367400c42a', 'd9903c5e-82f1-79f2-1f02-05933bbdf60c');
INSERT INTO pm_project_goal VALUES ('09b4a280-eb4f-79f9-c466-06af81fc3422', 2, '2017-06-09 10:41:29.551', 'admin', '2017-06-09 10:41:29.551', NULL, '2017-06-09 12:24:50.799', 'admin', 'БББ', '0480149c-90be-36d8-bf15-86367400c42a', 'c51a9e7f-9600-56ed-143e-f24e8bd0b463');
INSERT INTO pm_project_goal VALUES ('2705ebcd-d557-85cf-7438-e3dd50fec601', 2, '2017-06-09 10:51:07.815', 'admin', '2017-06-09 10:51:07.815', NULL, '2017-06-09 12:24:50.801', 'admin', 'Создать приложение', '7809f2f3-bbf7-188f-143f-1ae41a7d85dd', '809bfead-990d-a6d8-af11-f5fb225e6d5d');
INSERT INTO pm_project_goal VALUES ('453e1359-457f-7ee0-db04-3bc48a59dce5', 2, '2017-06-09 10:41:29.551', 'admin', '2017-06-09 10:41:29.551', NULL, '2017-06-09 12:24:50.799', 'admin', 'AAA', '7809f2f3-bbf7-188f-143f-1ae41a7d85dd', 'c51a9e7f-9600-56ed-143e-f24e8bd0b463');
INSERT INTO pm_project_goal VALUES ('48dc6e02-ed09-edab-c93a-70e5029f7061', 2, '2017-06-09 10:51:07.815', 'admin', '2017-06-09 10:51:07.815', NULL, '2017-06-09 12:24:50.801', 'admin', 'Продемонстрировать функции', '0480149c-90be-36d8-bf15-86367400c42a', '809bfead-990d-a6d8-af11-f5fb225e6d5d');


--
-- TOC entry 2955 (class 0 OID 40379)
-- Dependencies: 265
-- Data for Name: pm_project_user_link; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO pm_project_user_link VALUES ('90886911-a608-55a9-046b-ed8b4f2f73be', '3806b9f8-afd7-7a64-477a-393a33a9c729');
INSERT INTO pm_project_user_link VALUES ('90886911-a608-55a9-046b-ed8b4f2f73be', '11429a66-614c-c48f-31cd-44b14b0f95ec');
INSERT INTO pm_project_user_link VALUES ('c51a9e7f-9600-56ed-143e-f24e8bd0b463', '8505414d-8b6b-1a71-93d9-45e5b6386d38');
INSERT INTO pm_project_user_link VALUES ('c51a9e7f-9600-56ed-143e-f24e8bd0b463', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3');
INSERT INTO pm_project_user_link VALUES ('809bfead-990d-a6d8-af11-f5fb225e6d5d', '11429a66-614c-c48f-31cd-44b14b0f95ec');
INSERT INTO pm_project_user_link VALUES ('809bfead-990d-a6d8-af11-f5fb225e6d5d', '8505414d-8b6b-1a71-93d9-45e5b6386d38');


--
-- TOC entry 2953 (class 0 OID 40366)
-- Dependencies: 263
-- Data for Name: pm_task; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO pm_task VALUES ('f6b2af00-c340-686a-3a1d-1f49296aedca', 8, '2017-06-09 12:02:01.791', 'admin', '2017-06-09 12:24:16.43', 'admin', '2017-06-09 12:24:44.909', 'admin', 'Ф', '46a77952-500a-cf42-7535-840e7894c83b', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 1, NULL, '2017-06-07', '2017-06-06', 'CMPL');
INSERT INTO pm_task VALUES ('fc7dfc2f-698d-ed8f-fc4c-4d3fa71b2e8c', 8, '2017-06-09 12:04:14.395', 'admin', '2017-06-09 12:24:23.643', 'admin', '2017-06-09 12:24:44.899', 'admin', 'ффф', '82af3f9c-41f4-e1b1-3f77-660e7ed8fb55', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 10, NULL, '2017-06-14', '2017-06-25', 'CMPL');
INSERT INTO pm_task VALUES ('2301a51a-1c61-e59d-4ecd-4d234253ca8c', 8, '2017-06-09 10:51:07.815', 'admin', '2017-06-09 11:00:12.189', 'admin', '2017-06-09 12:24:44.9', 'admin', 'Задача 1', '809bfead-990d-a6d8-af11-f5fb225e6d5d', '11429a66-614c-c48f-31cd-44b14b0f95ec', 300, 'оценка сверху', '2017-06-09', '2017-06-16', 'CMPL');
INSERT INTO pm_task VALUES ('2b879c8b-b29a-8a51-fe28-70abed6b5f76', 8, '2017-06-09 10:41:29.551', 'admin', '2017-06-09 10:47:02.057', 'admin', '2017-06-09 12:24:44.903', 'admin', 'Задача 2-2', 'c51a9e7f-9600-56ed-143e-f24e8bd0b463', '11429a66-614c-c48f-31cd-44b14b0f95ec', 111, 'ФФФФ', '2017-06-07', '2017-06-30', 'CMPL');
INSERT INTO pm_task VALUES ('2cece3a4-837c-12c2-524f-dc3c7dfaf666', 8, '2017-06-09 11:11:29.684', 'admin', '2017-06-09 12:24:08.268', 'admin', '2017-06-09 12:24:44.905', 'admin', '1', 'b1fdc8db-3a16-c864-4679-8dfe13ac160b', '11429a66-614c-c48f-31cd-44b14b0f95ec', 12, NULL, '2017-06-15', '2017-06-16', 'CMPL');
INSERT INTO pm_task VALUES ('47965ed0-1f9c-12a3-49e7-f3266a21f0ae', 7, '2017-06-09 12:19:38.986', 'admin', '2017-06-09 12:22:18.831', 'admin', '2017-06-09 12:24:44.902', 'admin', 't1', 'd9903c5e-82f1-79f2-1f02-05933bbdf60c', '11429a66-614c-c48f-31cd-44b14b0f95ec', 10, NULL, NULL, NULL, 'CMPL');
INSERT INTO pm_task VALUES ('df7291b6-44a4-89cd-bb1e-e97647976e34', 8, '2017-06-08 15:08:28.113', 'admin', '2017-06-08 15:13:53.671', 'admin', '2017-06-09 10:51:13.145', 'admin', 'Задача 2', '90886911-a608-55a9-046b-ed8b4f2f73be', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 150, 'Задача 2', '2017-06-07', '2017-06-30', 'CMPL');
INSERT INTO pm_task VALUES ('ef405f97-77df-4111-668a-d1ed3c1e565e', 8, '2017-06-08 15:08:28.113', 'admin', '2017-06-08 15:13:15.543', 'admin', '2017-06-09 10:51:13.145', 'admin', 'Задача 1-1', '90886911-a608-55a9-046b-ed8b4f2f73be', '11429a66-614c-c48f-31cd-44b14b0f95ec', 50, 'Задача 1', '2017-06-18', '2017-06-19', 'CMPL');
INSERT INTO pm_task VALUES ('a609e3ac-9064-5e53-ba39-2974658cd0ed', 7, '2017-06-09 12:19:38.987', 'admin', '2017-06-09 12:22:38.053', 'admin', '2017-06-09 12:24:44.911', 'admin', 't2', 'd9903c5e-82f1-79f2-1f02-05933bbdf60c', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 50, NULL, NULL, NULL, 'CMPL');
INSERT INTO pm_task VALUES ('bbbf5f42-c185-1e1e-51dc-d0e496809ff1', 8, '2017-06-09 10:41:29.551', 'admin', '2017-06-09 12:22:44.851', 'admin', '2017-06-09 12:24:44.912', 'admin', 'З22', 'c51a9e7f-9600-56ed-143e-f24e8bd0b463', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 300, 'ффффф', '2017-06-15', '2017-06-24', 'CMPL');
INSERT INTO pm_task VALUES ('bccb71b0-7f61-5a7b-32e6-79dab78c9cdb', 8, '2017-06-09 12:05:00.019', 'admin', '2017-06-09 12:24:20.747', 'admin', '2017-06-09 12:24:44.907', 'admin', 'ЙЙЙ', '7abc2aea-577b-67a1-ecdc-fd33b2e2eaa9', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 10, NULL, '2017-06-07', '2017-06-18', 'CMPL');
INSERT INTO pm_task VALUES ('cf6e1522-efa2-0226-18a1-6b055ac0d2a2', 8, '2017-06-09 10:51:07.815', 'admin', '2017-06-09 11:00:34.356', 'admin', '2017-06-09 12:24:44.91', 'admin', 'Задача 2', '809bfead-990d-a6d8-af11-f5fb225e6d5d', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 82, NULL, '2017-06-09', '2017-06-29', 'CMPL');


--
-- TOC entry 2889 (class 0 OID 39453)
-- Dependencies: 199
-- Data for Name: sec_constraint; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2895 (class 0 OID 39535)
-- Dependencies: 205
-- Data for Name: sec_entity_log; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2896 (class 0 OID 39552)
-- Dependencies: 206
-- Data for Name: sec_entity_log_attr; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2897 (class 0 OID 39566)
-- Dependencies: 207
-- Data for Name: sec_filter; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_filter VALUES ('b61d18cb-e79a-46f3-b16d-eaf4aebb10dd', '2017-06-08 14:55:02.073287', 'admin', 0, NULL, NULL, NULL, NULL, '[sec$User.browse].genericFilter', 'Search by role', NULL, '<?xml version="1.0" encoding="UTF-8"?><filter><and><c name="UrMxpkfMGn" class="com.haulmont.cuba.security.entity.Role" type="CUSTOM" locCaption="Role" entityAlias="u" join="join u.userRoles ur">ur.role.id = :component$genericFilter.UrMxpkfMGn32565<param name="component$genericFilter.UrMxpkfMGn32565">NULL</param></c></and></filter>', '60885987-1b61-4247-94c7-dff348347f93');


--
-- TOC entry 2884 (class 0 OID 39386)
-- Dependencies: 194
-- Data for Name: sec_group; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_group VALUES ('0fa2b1a5-1d68-4d69-9fbd-dff348347f93', '2017-06-08 14:55:02.051363', NULL, 0, NULL, NULL, NULL, NULL, 'Company', NULL);


--
-- TOC entry 2885 (class 0 OID 39397)
-- Dependencies: 195
-- Data for Name: sec_group_hierarchy; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2894 (class 0 OID 39522)
-- Dependencies: 204
-- Data for Name: sec_logged_attr; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2893 (class 0 OID 39515)
-- Dependencies: 203
-- Data for Name: sec_logged_entity; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2888 (class 0 OID 39442)
-- Dependencies: 198
-- Data for Name: sec_permission; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_permission VALUES ('3920d13d-03fd-1803-5a00-387bcff30a45', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'bpm$ProcTask:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('e6b1c3a5-b7fd-9044-72e1-107c50467bf7', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$ProjectGoal:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('7fb64d21-de93-b9d4-b31b-d621ca9163e5', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 10, 'administration', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('0084ef47-bd9a-da53-aa5f-c6e5626a2f96', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcTask:delete', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('3199347f-3f0d-9d6f-0150-6ec88058137a', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'bpm$ProcTask:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('4fa77761-2c2a-b39a-a7b1-b2483fc9536f', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'pm$Task:delete', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('f98fcce6-72ea-f0fd-a8e3-4b963f9868bc', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'bpm$ProcInstance:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('a96bf4f3-0952-cbfb-b01b-410861debb40', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'pm$Task:read', 1, 'f215b536-14fe-eea5-13a2-29e827cd3481');
INSERT INTO sec_permission VALUES ('05b1e50a-eb0d-d147-d097-3f2fc0cc8250', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcInstance:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('3375e753-4c38-6bf0-49ac-110f699e8c42', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Project:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('8144ba10-d72b-5810-5cef-02852030a7ac', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcActor:delete', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('30ae386e-d3c8-cefd-37f2-f49b98ed20d9', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 20, 'pm$ProjectGoal:delete', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('0e5fdafb-6f9c-d6af-de19-6464219d662d', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 20, 'bpm$ProcActor:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('d68552ef-0be0-8fcc-096d-b6db8b5cd634', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Project:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('aa46017e-f5da-a2d6-4bae-25a295212f15', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcInstance:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('a8cdef2c-1e7f-db74-52f5-135a113847ac', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcActor:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('4ce4822e-3695-0d85-fe5f-a84b7fe1c7e4', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'bpm$ProcTask:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('525495c9-caf3-10ea-ba4c-2ea192d36c31', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Task:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('b8c37f6b-9d7b-d86b-7581-7c6edb7368a7', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Task:update', 1, 'f215b536-14fe-eea5-13a2-29e827cd3481');
INSERT INTO sec_permission VALUES ('46c57bd7-543b-cac6-b2cd-92a0237ed5d5', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'pm$ProjectGoal:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('b87bcc53-668f-ad9c-cc3a-1033e930283f', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'pm$Task:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('f4b46c81-872d-8265-ad1e-1d3aa2efcda7', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Project:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('14219315-9c88-12f5-9b68-ef8a221fb5c5', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 20, 'pm$ProjectGoal:update', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('974487bd-a19b-434c-9f4a-0183857b9d74', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 20, 'pm$Task:read', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('e88f34b3-2a22-9ef7-ced0-33188409774d', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 20, 'bpm$ProcActor:create', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('f232e016-6cba-44eb-0fd8-9613b9019dc3', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 10, 'pmdashboard', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('e9010caf-327e-d0e3-be9a-5304ac45972a', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 20, 'pm$Project:delete', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('f5d8eec9-0860-d1a1-2916-ecca4284e4b6', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 10, 'pmdashboard', 1, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('8243be34-e8e5-c67e-132a-e1918ee54f3f', '2017-06-09 10:58:42.797', 'admin', 2, '2017-06-09 10:58:42.797', NULL, '2017-06-09 11:17:30.387', 'admin', 10, 'bpm$ProcDefinition.lookup', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('84ead517-caa6-c2ec-ea72-c96650291825', '2017-06-08 14:56:09.247', 'admin', 3, '2017-06-09 11:17:30.388', 'admin', NULL, NULL, 10, 'bpm', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('dce57a77-639a-2e85-2b82-31b36676e1f8', '2017-06-09 10:58:42.797', 'admin', 2, '2017-06-09 10:58:42.797', NULL, '2017-06-09 11:17:30.382', 'admin', 10, 'bpm$ProcInstance.lookup', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('f80bea4e-cc3e-b2af-50bd-c7056b1e2601', '2017-06-09 10:58:42.797', 'admin', 2, '2017-06-09 10:58:42.797', NULL, '2017-06-09 11:17:30.383', 'admin', 10, 'bpm$ProcAttachmentType.lookup', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('5b957ee5-b5ea-179f-d33a-f481e5c9a33d', '2017-06-09 10:58:15.381', 'admin', 2, '2017-06-09 10:58:15.381', NULL, '2017-06-09 11:17:30.385', 'admin', 10, 'bpm$ProcTask.lookup', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('5ee6cfae-8eeb-10ad-d2c2-9e11612b79ce', '2017-06-09 10:58:42.797', 'admin', 2, '2017-06-09 10:58:42.797', NULL, '2017-06-09 11:17:30.385', 'admin', 10, 'stencilSetEditor', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('66b70d0b-3b2a-5804-f394-69f4ca0fab51', '2017-06-09 10:58:42.797', 'admin', 2, '2017-06-09 10:58:42.797', NULL, '2017-06-09 11:17:30.386', 'admin', 10, 'bpm$ProcModel.lookup', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('5233a616-e768-f116-1e4d-88fc5d410475', '2017-06-09 11:19:00.349', 'admin', 1, '2017-06-09 11:19:00.349', NULL, NULL, NULL, 10, 'pmProcTasks', 0, 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_permission VALUES ('75bb5cf1-17b8-33ab-ae32-8a46950d342f', '2017-06-09 11:19:05.076', 'admin', 1, '2017-06-09 11:19:05.076', NULL, NULL, NULL, 10, 'pmProcTasks', 1, 'b43774b7-fadb-2163-c769-9b4b0a5aac81');
INSERT INTO sec_permission VALUES ('add70170-3c40-3b3c-600f-83883a532fa1', '2017-06-09 11:20:09.493', 'admin', 1, '2017-06-09 11:20:09.493', NULL, NULL, NULL, 10, 'pm$MyTasks.browse', 0, 'b43774b7-fadb-2163-c769-9b4b0a5aac81');
INSERT INTO sec_permission VALUES ('af4598a3-421d-1a7a-5858-1a9e34a69619', '2017-06-09 12:11:34.599', 'admin', 2, '2017-06-09 12:11:34.599', NULL, '2017-06-09 12:37:07.467', 'admin', 10, 'pmProcTasks', 0, '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_permission VALUES ('c14bb69a-8203-7702-e89d-c33ea487c335', '2017-06-09 12:11:34.599', 'admin', 2, '2017-06-09 12:11:34.599', NULL, '2017-06-09 12:37:07.467', 'admin', 10, 'pm$MyTasks.browse', 0, '803d6a05-9eaf-1377-33ad-a6bcb765df72');


--
-- TOC entry 2900 (class 0 OID 39603)
-- Dependencies: 210
-- Data for Name: sec_presentation; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2913 (class 0 OID 39789)
-- Dependencies: 223
-- Data for Name: sec_remember_me; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2883 (class 0 OID 39377)
-- Dependencies: 193
-- Data for Name: sec_role; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_role VALUES ('0c018061-b26f-4de2-a5be-dff348347f93', '2017-06-08 14:55:02.063753', NULL, 0, NULL, NULL, NULL, NULL, 'Administrators', NULL, NULL, NULL, 10);
INSERT INTO sec_role VALUES ('f215b536-14fe-eea5-13a2-29e827cd3481', '2017-06-08 14:56:09.247', 'admin', 1, '2017-06-08 14:56:09.247', NULL, NULL, NULL, 'Executor', 'Исполнитель', NULL, NULL, NULL);
INSERT INTO sec_role VALUES ('803d6a05-9eaf-1377-33ad-a6bcb765df72', '2017-06-08 14:56:09.246', 'admin', 1, '2017-06-08 14:56:09.246', NULL, NULL, NULL, 'Manager', 'Руководитель', NULL, NULL, NULL);
INSERT INTO sec_role VALUES ('a64a37e2-0d5d-3ec4-4075-854f541a51df', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 'Default', 'Роль по умолчаню', NULL, true, 20);
INSERT INTO sec_role VALUES ('b43774b7-fadb-2163-c769-9b4b0a5aac81', '2017-06-08 14:56:09.245', 'admin', 1, '2017-06-08 14:56:09.245', NULL, NULL, NULL, 'Project office employee', 'Сотрудник проектного офиса', NULL, NULL, NULL);


--
-- TOC entry 2903 (class 0 OID 39650)
-- Dependencies: 213
-- Data for Name: sec_screen_history; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_screen_history VALUES ('97873409-de16-d621-51d9-d6bd416955c1', '2017-06-08 15:01:12.71', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'User ''admin''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-60885987-1b61-4247-94c7-dff348347f93&params=item:sec$User-60885987-1b61-4247-94c7-dff348347f93', '60885987-1b61-4247-94c7-dff348347f93', NULL);
INSERT INTO sec_screen_history VALUES ('9f4286b7-6fc3-02a1-ce91-9283a68275a2', '2017-06-08 15:07:04.156', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''executor1''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-11429a66-614c-c48f-31cd-44b14b0f95ec&params=item:sec$User-11429a66-614c-c48f-31cd-44b14b0f95ec', '11429a66-614c-c48f-31cd-44b14b0f95ec', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('c997f135-0522-ba0c-6dcb-100f5d54c680', '2017-06-08 15:07:15.736', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''executor1''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-11429a66-614c-c48f-31cd-44b14b0f95ec&params=item:sec$User-11429a66-614c-c48f-31cd-44b14b0f95ec', '11429a66-614c-c48f-31cd-44b14b0f95ec', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('0a449c3d-6128-e4cc-6e94-75d5be8075d8', '2017-06-08 15:07:22.353', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''executor2''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-8505414d-8b6b-1a71-93d9-45e5b6386d38&params=item:sec$User-8505414d-8b6b-1a71-93d9-45e5b6386d38', '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('88cea52f-f081-7730-5762-58e91bb18f70', '2017-06-08 15:07:29.397', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''manager1''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-d62e8e6c-d274-09f4-62ca-db68efac8af0&params=item:sec$User-d62e8e6c-d274-09f4-62ca-db68efac8af0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('3cd9d8e6-5f8b-8a62-15a5-e8e3e5d483a2', '2017-06-08 15:07:36.666', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''officeEmployee1''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-3806b9f8-afd7-7a64-477a-393a33a9c729&params=item:sec$User-3806b9f8-afd7-7a64-477a-393a33a9c729', '3806b9f8-afd7-7a64-477a-393a33a9c729', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('1cd7adc1-2e0d-9e88-2782-1b15582c19e1', '2017-06-08 15:07:45.772', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Пользователь ''officeEmployee2''', 'http://localhost:8080/app/open?screen=sec$User.edit&item=sec$User-1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3&params=item:sec$User-1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'd62e8e6c-d274-09f4-62ca-db68efac8af0');
INSERT INTO sec_screen_history VALUES ('c42e3fd0-2232-5b56-3909-44fc47db666a', '2017-06-09 10:58:15.393', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Default''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df&params=item:sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df', 'a64a37e2-0d5d-3ec4-4075-854f541a51df', NULL);
INSERT INTO sec_screen_history VALUES ('86fbd81b-5e68-59d1-a920-9e73fc84b03f', '2017-06-09 10:58:42.813', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Default''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df&params=item:sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df', 'a64a37e2-0d5d-3ec4-4075-854f541a51df', NULL);
INSERT INTO sec_screen_history VALUES ('f7ceea9a-125a-24a3-2f6b-7e65f60be66e', '2017-06-09 11:17:30.397', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Default''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df&params=item:sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df', 'a64a37e2-0d5d-3ec4-4075-854f541a51df', NULL);
INSERT INTO sec_screen_history VALUES ('0f6e0d75-e050-8fc2-da42-25b256862f2d', '2017-06-09 11:19:00.385', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Default''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df&params=item:sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df', 'a64a37e2-0d5d-3ec4-4075-854f541a51df', NULL);
INSERT INTO sec_screen_history VALUES ('75315c5e-ba79-9a00-d219-5345cc87044f', '2017-06-09 11:19:05.093', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Project office employee''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81&params=item:sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81', 'b43774b7-fadb-2163-c769-9b4b0a5aac81', NULL);
INSERT INTO sec_screen_history VALUES ('c2d9bf88-e992-9d47-9e03-a6aeb7fa8c63', '2017-06-09 11:20:09.52', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Project office employee''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81&params=item:sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81', 'b43774b7-fadb-2163-c769-9b4b0a5aac81', NULL);
INSERT INTO sec_screen_history VALUES ('cf2d9274-f4b5-2035-22ce-46b8f19b927f', '2017-06-09 12:07:59.537', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Project office employee''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81&params=item:sec$Role-b43774b7-fadb-2163-c769-9b4b0a5aac81', 'b43774b7-fadb-2163-c769-9b4b0a5aac81', NULL);
INSERT INTO sec_screen_history VALUES ('f73e3832-dd89-5c75-8ff1-5fabe315d3db', '2017-06-09 12:11:34.609', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Manager''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-803d6a05-9eaf-1377-33ad-a6bcb765df72&params=item:sec$Role-803d6a05-9eaf-1377-33ad-a6bcb765df72', '803d6a05-9eaf-1377-33ad-a6bcb765df72', NULL);
INSERT INTO sec_screen_history VALUES ('baf31ac3-88e3-f093-56ab-01301b2b64c9', '2017-06-09 12:37:07.519', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Manager''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-803d6a05-9eaf-1377-33ad-a6bcb765df72&params=item:sec$Role-803d6a05-9eaf-1377-33ad-a6bcb765df72', '803d6a05-9eaf-1377-33ad-a6bcb765df72', NULL);
INSERT INTO sec_screen_history VALUES ('f9546b53-ad17-5af9-cd6e-048243fd7ac1', '2017-06-09 12:37:12.399', 'admin', '60885987-1b61-4247-94c7-dff348347f93', 'Роль ''Default''', 'http://localhost:8080/app/open?screen=sec$Role.edit&item=sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df&params=item:sec$Role-a64a37e2-0d5d-3ec4-4075-854f541a51df', 'a64a37e2-0d5d-3ec4-4075-854f541a51df', NULL);


--
-- TOC entry 2901 (class 0 OID 39617)
-- Dependencies: 211
-- Data for Name: sec_search_folder; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2890 (class 0 OID 39470)
-- Dependencies: 200
-- Data for Name: sec_session_attr; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2886 (class 0 OID 39412)
-- Dependencies: 196
-- Data for Name: sec_user; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_user VALUES ('a405db59-e674-4f63-8afe-269dda788fe8', '2017-06-06 15:44:35.249', NULL, 1, '2017-06-08 14:56:33.593', 'admin', NULL, NULL, 'anonymous', 'anonymous', NULL, 'Anonymous', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, NULL);
INSERT INTO sec_user VALUES ('60885987-1b61-4247-94c7-dff348347f93', '2017-06-06 15:44:35.247', NULL, 1, '2017-06-08 14:56:33.593', 'admin', NULL, NULL, 'admin', 'admin', 'cc2229d1b8a052423d9e1c9ef0113b850086586a', 'Administrator', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, NULL);
INSERT INTO sec_user VALUES ('1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', '2017-06-08 14:56:33.578', 'admin', 1, '2017-06-08 14:56:33.578', NULL, NULL, NULL, 'officeEmployee2', 'officeemployee2', '16aaf54946944c877394a382eb6d6ed93dcae630', 'Сотрудник офиса 2 ', 'Сотрудник офиса 2', NULL, NULL, NULL, NULL, 'en', NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, false);
INSERT INTO sec_user VALUES ('8505414d-8b6b-1a71-93d9-45e5b6386d38', '2017-06-08 14:56:33.578', 'admin', 1, '2017-06-08 14:56:33.578', NULL, NULL, NULL, 'executor2', 'executor2', '77392a410deb2fa0697942c2a3998186d78288d8', 'Исполнитель 2 ', 'Исполнитель 2', NULL, NULL, NULL, NULL, 'en', NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, false);
INSERT INTO sec_user VALUES ('11429a66-614c-c48f-31cd-44b14b0f95ec', '2017-06-08 14:56:33.578', 'admin', 1, '2017-06-08 14:56:33.578', NULL, NULL, NULL, 'executor1', 'executor1', '5036d5650215d404c75eeac47f52f664ce1f30ff', 'Исполнитель 1 ', 'Исполнитель 1', NULL, NULL, NULL, NULL, 'en', NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, false);
INSERT INTO sec_user VALUES ('d62e8e6c-d274-09f4-62ca-db68efac8af0', '2017-06-08 14:56:33.578', 'admin', 1, '2017-06-08 14:56:33.578', NULL, NULL, NULL, 'manager1', 'manager1', 'b6baa45a1ba54b3f2070a5b75c3391ec6b4f9ccd', 'Руководитель 1 ', 'Руководитель 1', NULL, NULL, NULL, NULL, 'en', NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, false);
INSERT INTO sec_user VALUES ('3806b9f8-afd7-7a64-477a-393a33a9c729', '2017-06-08 14:56:33.578', 'admin', 1, '2017-06-08 14:56:33.578', NULL, NULL, NULL, 'officeEmployee1', 'officeemployee1', '7f533d5bbd4679168133ad3c0c6c5114230db033', 'Сотрудник офиса 1 ', 'Сотрудник офиса 1', NULL, NULL, NULL, NULL, 'en', NULL, NULL, true, '0fa2b1a5-1d68-4d69-9fbd-dff348347f93', NULL, false);


--
-- TOC entry 2887 (class 0 OID 39426)
-- Dependencies: 197
-- Data for Name: sec_user_role; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_user_role VALUES ('c838be0a-96d0-4ef4-a7c0-dff348347f93', '2017-06-08 14:55:02.06764', NULL, 0, NULL, NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', '0c018061-b26f-4de2-a5be-dff348347f93');
INSERT INTO sec_user_role VALUES ('867e539e-f75c-9aeb-4e1f-ab070e2add8c', '2017-06-08 15:07:15.722', 'admin', 1, '2017-06-08 15:07:15.722', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', 'f215b536-14fe-eea5-13a2-29e827cd3481');
INSERT INTO sec_user_role VALUES ('99f820f5-c9fb-fdc3-f884-2907c04a7d7a', '2017-06-08 15:07:15.722', 'admin', 1, '2017-06-08 15:07:15.722', NULL, NULL, NULL, '11429a66-614c-c48f-31cd-44b14b0f95ec', 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_user_role VALUES ('400031b6-daf9-8de2-5a39-efde33e39c52', '2017-06-08 15:07:22.338', 'admin', 1, '2017-06-08 15:07:22.338', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_user_role VALUES ('4b2d4796-a51f-71d9-cc86-c500a1f7c238', '2017-06-08 15:07:22.338', 'admin', 1, '2017-06-08 15:07:22.338', NULL, NULL, NULL, '8505414d-8b6b-1a71-93d9-45e5b6386d38', 'f215b536-14fe-eea5-13a2-29e827cd3481');
INSERT INTO sec_user_role VALUES ('43846b9c-c67a-f956-99e0-ee19b916406d', '2017-06-08 15:07:29.378', 'admin', 1, '2017-06-08 15:07:29.378', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', '803d6a05-9eaf-1377-33ad-a6bcb765df72');
INSERT INTO sec_user_role VALUES ('5dd62ccb-5222-10c5-0a47-2d025e64bcc0', '2017-06-08 15:07:29.379', 'admin', 1, '2017-06-08 15:07:29.379', NULL, NULL, NULL, 'd62e8e6c-d274-09f4-62ca-db68efac8af0', 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_user_role VALUES ('8e5bebaf-f942-0af4-17a2-d8bfe5e98149', '2017-06-08 15:07:36.655', 'admin', 1, '2017-06-08 15:07:36.655', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'b43774b7-fadb-2163-c769-9b4b0a5aac81');
INSERT INTO sec_user_role VALUES ('335c90ee-f256-7c99-98d9-473bbce1e41f', '2017-06-08 15:07:36.655', 'admin', 1, '2017-06-08 15:07:36.655', NULL, NULL, NULL, '3806b9f8-afd7-7a64-477a-393a33a9c729', 'a64a37e2-0d5d-3ec4-4075-854f541a51df');
INSERT INTO sec_user_role VALUES ('7827cc50-681a-a58a-7f2e-090733e7db0f', '2017-06-08 15:07:45.76', 'admin', 1, '2017-06-08 15:07:45.76', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'b43774b7-fadb-2163-c769-9b4b0a5aac81');
INSERT INTO sec_user_role VALUES ('2cf6fd22-bd24-d229-a7c7-6b7bf086ad86', '2017-06-08 15:07:45.76', 'admin', 1, '2017-06-08 15:07:45.76', NULL, NULL, NULL, '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', 'a64a37e2-0d5d-3ec4-4075-854f541a51df');


--
-- TOC entry 2891 (class 0 OID 39484)
-- Dependencies: 201
-- Data for Name: sec_user_setting; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_user_setting VALUES ('965f213a-e86c-eb0c-29d2-28e82700157d', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$User.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="genericFilter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="usersTable" textSelection="false" presentation=""> 
      <columns>
        <columns id="login" visible="true"/>
        <columns id="name" visible="true"/>
        <columns id="position" visible="true"/>
        <columns id="group" visible="true"/>
        <columns id="email" visible="true"/>
        <columns id="timeZone" visible="true"/>
        <columns id="active" visible="true"/>
        <columns id="changePasswordAtNextLogon" visible="true"/>
      </columns>
      <groupProperties/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('0e0caf1d-753d-ab5c-88e9-bf88fb4b205b', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'entityInspector.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings>
  <components>
    <component name="filter">
      <defaultFilter/>
      <groupBoxExpanded>true</groupBoxExpanded>
    </component>
    <component name="WebTable">
      <columns>
        <columns id="lastName" visible="true"/>
        <columns id="loginLowerCase" visible="true"/>
        <columns id="ipMask" visible="true"/>
        <columns id="language" visible="true"/>
        <columns id="login" visible="true"/>
        <columns id="password" visible="true"/>
        <columns id="changePasswordAtNextLogon" visible="true"/>
        <columns id="timeZoneAuto" visible="true"/>
        <columns id="email" visible="true"/>
        <columns id="group" visible="true"/>
        <columns id="timeZone" visible="true"/>
        <columns id="active" visible="true"/>
        <columns id="firstName" visible="true"/>
        <columns id="name" visible="true"/>
        <columns id="middleName" visible="true"/>
        <columns id="position" visible="true"/>
        <columns id="deletedBy" visible="true"/>
        <columns id="deleteTs" visible="true"/>
        <columns id="createTs" visible="true"/>
        <columns id="id" visible="true"/>
        <columns id="updatedBy" visible="true"/>
        <columns id="version" visible="true"/>
        <columns id="createdBy" visible="true"/>
        <columns id="updateTs" visible="true"/>
      </columns>
    </component>
  </components>
</settings>
');
INSERT INTO sec_user_setting VALUES ('6ea8f0b9-3d93-a102-4854-9d144dcab7c5', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'stencilSetEditor', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="split"> 
      <position value="50.0" unit="%"/> 
    </component>  
    <component name="stencilsTable"> 
      <columns>
        <columns id="title" visible="true"/>
      </columns>
    </component>  
    <component name="serviceTaskStencilFrame.stencilParamsTable"> 
      <columns>
        <columns id="propertyPackageTitle" visible="true"/>
        <columns id="simpleTypeName" visible="true"/>
        <columns id="defaultValue" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('2b2f0179-4f6c-a71b-f408-9f502bd2333f', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$CompanyGoal.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="companyGoalsTable"> 
      <columns>
        <columns id="name" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('8389eb1e-c4b2-3b96-f5ae-f5b1c82d02b8', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$User.edit', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="propertiesBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="split"> 
      <position value="50.0" unit="%"/> 
    </component>  
    <component name="rolesTable"> 
      <columns>
        <columns id="role.name" visible="true"/>
        <columns id="role.locName" visible="true"/>
      </columns>
    </component>  
    <component name="substTable"> 
      <columns>
        <columns id="substitutedUser.login" visible="true"/>
        <columns id="substitutedUser.name" visible="true"/>
        <columns id="startDate" visible="true"/>
        <columns id="endDate" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('a8b44fc7-ec46-7096-c097-889d016f4acd', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$Project.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="projectsTable" textSelection="false" presentation=""> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="manager" visible="true"/>
        <columns id="state" visible="true"/>
      </columns>
      <groupProperties/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('08f3151e-ec98-2f29-9c92-16b3dc92975e', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'bpm$ProcModel.lookup', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="procModelsTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="description" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('40f92707-14bf-d595-82d0-b46c6e3d613e', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$Role.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="rolesTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="locName" visible="true"/>
        <columns id="description" visible="true"/>
        <columns id="defaultRole" visible="true"/>
        <columns id="type" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('3c6dd758-d17b-52ac-55b8-75e5ef3a27c3', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$Project.edit', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="procActionsGroupBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="goalsBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="goalsTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="companyGoal" visible="true"/>
      </columns>
    </component>  
    <component name="tasksBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="tasksTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="executor" visible="true"/>
        <columns id="state" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('423d96cf-7eea-fd7a-349a-f19c41fc21c2', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$Role.lookup', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="rolesTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="locName" visible="true"/>
        <columns id="description" visible="true"/>
        <columns id="defaultRole" visible="true"/>
        <columns id="type" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('1c9db0d4-771a-d15e-fa9a-6adf7d8089b8', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$Task.edit', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="procActionsGroupBox"> 
      <groupBox expanded="true"/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('0e0b8403-388b-a7a5-b3f5-09ce3903411c', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'standardProcForm', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="comment"/>  
    <component name="procActorsFrame.procActorsTable"> 
      <columns>
        <columns id="procRole" visible="true"/>
        <columns id="user" visible="true"/>
      </columns>
    </component>  
    <component name="procAttachmentsFrame.procAttachmentsTable"> 
      <columns>
        <columns id="file.name" visible="true"/>
        <columns id="author" visible="true"/>
        <columns id="type" visible="true"/>
        <columns id="comment" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('2a59305c-31af-a9a4-e5c0-b953fccd6ba6', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$MyTasks.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="tasksTable"> 
      <columns>
        <columns id="state" width="161" visible="true"/>
        <columns id="project" width="143" visible="true"/>
        <columns id="executor" width="358" visible="true"/>
        <columns id="name" width="216" visible="true"/>
        <columns id="estimation" width="275" visible="true"/>
        <columns id="startDate" width="247" visible="true"/>
        <columns id="endDate" width="291" visible="true"/>
      </columns>
      <groupProperties>
        <property id="state"/>
      </groupProperties>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('15a08be2-a9c6-83df-02c8-d49bb874b724', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pmdashboard', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="projectsGroupBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="projectsTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="state" visible="true"/>
        <columns id="progress" visible="true"/>
        <columns id="tasksNumber" visible="true"/>
      </columns>
    </component>  
    <component name="goalsGroupBox"> 
      <groupBox expanded="true"/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('ed51900f-7cc6-f37b-8963-40d89a19d0ac', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'pm$Task.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="tasksTable" textSelection="false" presentation=""> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="project" visible="true"/>
        <columns id="executor" visible="true"/>
        <columns id="estimation" visible="true"/>
        <columns id="startDate" visible="true"/>
        <columns id="endDate" visible="true"/>
        <columns id="state" visible="true"/>
      </columns>
      <groupProperties/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('00ed3470-64bc-6490-bc94-e4cde6248696', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$Group.browse', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="split"> 
      <position value="30.0" unit="%"/> 
    </component>  
    <component name="filterWithoutId"> 
      <defaultFilter/>  
      <groupBoxExpanded/> 
    </component>  
    <component name="usersTable"> 
      <columns>
        <columns id="name" visible="true"/>
        <columns id="login" visible="true"/>
      </columns>
    </component>  
    <component name="constraintsTable"> 
      <columns> 
        <columns id="entityName" visible="true"/>  
        <columns id="isActive" visible="true"/>  
        <columns id="operationType" visible="true"/>  
        <columns id="joinClause" width="200" visible="true"/>  
        <columns id="whereClause" width="200" visible="true"/>  
        <columns id="groovyScript" width="200" visible="true"/> 
      </columns> 
    </component>  
    <component name="attributesTable"> 
      <columns> 
        <columns id="name" visible="true"/>  
        <columns id="datatypeCaption" visible="true"/>  
        <columns id="stringValue" visible="true"/> 
      </columns> 
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('a0473411-e4aa-db0d-79d4-aacd974430cc', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'bpm$ProcTask.lookup', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="filter"> 
      <defaultFilter/>  
      <groupBoxExpanded>true</groupBoxExpanded> 
    </component>  
    <component name="procTasksTable"> 
      <columns>
        <columns id="procInstance.procDefinition" visible="true"/>
        <columns id="locName" visible="true"/>
        <columns id="startDate" visible="true"/>
        <columns id="assigned" visible="true"/>
      </columns>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('ddca631a-dedc-4029-9433-28f302275568', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'sec$Role.edit', '<?xml version="1.0" encoding="UTF-8"?>

<settings> 
  <components> 
    <component name="roleGroupBox"> 
      <groupBox expanded="true"/>
    </component>  
    <component name="description"/>  
    <component name="screensTabFrame.WebSplitPanel"> 
      <position value="80.0" unit="%"/> 
    </component>  
    <component name="screensTabFrame.screenPermissionsTree"> 
      <columns>
        <columns id="caption" visible="true"/>
        <columns id="permissionVariant" visible="true"/>
      </columns>
    </component>  
    <component name="screensTabFrame.screensEditPane"> 
      <groupBox expanded="true"/>
    </component> 
  </components> 
</settings>
');
INSERT INTO sec_user_setting VALUES ('450e1b70-ffd7-de62-0a5d-5de51e5b2329', NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'W', 'bpm$ProcInstance.lookup', '<?xml version="1.0" encoding="UTF-8"?>

<settings>
  <components>
    <component name="filter">
      <defaultFilter/>
      <groupBoxExpanded>true</groupBoxExpanded>
    </component>
    <component name="procInstancesTable">
      <columns>
        <columns id="procDefinition" visible="true"/>
        <columns id="description" visible="true"/>
        <columns id="startDate" visible="true"/>
        <columns id="endDate" visible="true"/>
        <columns id="active" visible="true"/>
        <columns id="startedBy" visible="true"/>
        <columns id="entityName" visible="true"/>
        <columns id="cancelled" visible="true"/>
        <columns id="startComment" visible="true"/>
      </columns>
    </component>
  </components>
</settings>
');


--
-- TOC entry 2892 (class 0 OID 39499)
-- Dependencies: 202
-- Data for Name: sec_user_substitution; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sec_user_substitution VALUES ('c31b524e-5a6c-da0d-8008-9e453c67136a', '2017-06-08 15:01:12.671', 'admin', 1, '2017-06-08 15:01:12.671', NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', '8505414d-8b6b-1a71-93d9-45e5b6386d38', NULL, NULL);
INSERT INTO sec_user_substitution VALUES ('90eea0ae-8fa9-815d-50b1-bb858a719293', '2017-06-08 15:01:12.671', 'admin', 1, '2017-06-08 15:01:12.671', NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', '1ff3c352-9d0a-fdc2-f27a-05ff78b07bd3', NULL, NULL);
INSERT INTO sec_user_substitution VALUES ('768783bf-fa50-4e86-b293-4ff4e666389f', '2017-06-08 15:01:12.671', 'admin', 1, '2017-06-08 15:01:12.671', NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', 'd62e8e6c-d274-09f4-62ca-db68efac8af0', NULL, NULL);
INSERT INTO sec_user_substitution VALUES ('0c810ae2-9b82-23dd-a004-11b000c47f10', '2017-06-08 15:01:12.671', 'admin', 1, '2017-06-08 15:01:12.671', NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', '3806b9f8-afd7-7a64-477a-393a33a9c729', NULL, NULL);
INSERT INTO sec_user_substitution VALUES ('accc6088-a4fc-3016-068d-b80459559850', '2017-06-08 15:01:12.671', 'admin', 1, '2017-06-08 15:01:12.671', NULL, NULL, NULL, '60885987-1b61-4247-94c7-dff348347f93', '11429a66-614c-c48f-31cd-44b14b0f95ec', NULL, NULL);


--
-- TOC entry 2899 (class 0 OID 39590)
-- Dependencies: 209
-- Data for Name: sys_app_folder; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2909 (class 0 OID 39746)
-- Dependencies: 219
-- Data for Name: sys_attr_value; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2907 (class 0 OID 39722)
-- Dependencies: 217
-- Data for Name: sys_category; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2908 (class 0 OID 39731)
-- Dependencies: 218
-- Data for Name: sys_category_attr; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2877 (class 0 OID 39324)
-- Dependencies: 187
-- Data for Name: sys_config; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2875 (class 0 OID 39308)
-- Dependencies: 185
-- Data for Name: sys_db_changelog; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sys_db_changelog VALUES ('10-cuba/init/postgres/create-db.sql', '2017-06-08 14:55:02.109107', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/10.create-db.sql', '2017-06-08 14:55:02.57876', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/20.create-db.sql', '2017-06-08 14:55:02.947217', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/30.create-db.sql', '2017-06-08 14:55:02.94864', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/activiti.engine.create-db.sql', '2017-06-08 14:55:04.304559', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/activiti.history.create-db.sql', '2017-06-08 14:55:04.871768', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/init/postgres/activiti.identity.create-db.sql', '2017-06-08 14:55:05.003438', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/init/postgres/10.create-db.sql', '2017-06-08 14:55:05.113574', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/init/postgres/20.create-db.sql', '2017-06-08 14:55:05.213993', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/init/postgres/30.create-db.sql', '2017-06-08 14:55:05.216247', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-010-addValueIdToEntityLog.sql', '2017-06-08 14:55:05.24774', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-020-dropDbUpdatePKey.sql', '2017-06-08 14:55:05.248736', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-030-add_EntityLogAttr_messagesPack.sql', '2017-06-08 14:55:05.249607', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-040-renameUserPosition.sql', '2017-06-08 14:55:05.250464', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-050-addUserLanguage.sql', '2017-06-08 14:55:05.251297', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-050-sysFtsQueue.sql', '2017-06-08 14:55:05.252999', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-055-createReportTables.sql', '2017-06-08 14:55:05.253807', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-060-addReportParameterPosition.sql', '2017-06-08 14:55:05.254525', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-070-addCodeInFolder.sql', '2017-06-08 14:55:05.255151', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-080-SessionAttributes.sql', '2017-06-08 14:55:05.255801', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-090-ChangeReportKeys.sql', '2017-06-08 14:55:05.256456', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-100-EntityStatistics.sql', '2017-06-08 14:55:05.257138', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-100-addPresentations.sql', '2017-06-08 14:55:05.257781', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-110-AddFieldInSysFolder.sql', '2017-06-08 14:55:05.258439', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-120-AddCodeFieldInSecFilter.sql', '2017-06-08 14:55:05.259059', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-130-createReportValueFormatTable.sql', '2017-06-08 14:55:05.260069', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-140-AddTabHistory.sql', '2017-06-08 14:55:05.260695', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-150-CreateIndexes.sql', '2017-06-08 14:55:05.261294', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-160-screenHistory.sql', '2017-06-08 14:55:05.261904', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-170-entityStatisticsFetchUI.sql', '2017-06-08 14:55:05.262574', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-180-changeAppFoldersScriptsLength.sql', '2017-06-08 14:55:05.263162', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-190-renameDoubleNameInSysFolder.sql', '2017-06-08 14:55:05.263785', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-200-deleteCodeInSysFolders.sql', '2017-06-08 14:55:05.26441', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-210-updateTabNameInSysFolder.sql', '2017-06-08 14:55:05.265105', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-220-reportTablesChangeColumns.sql', '2017-06-08 14:55:05.265716', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-230-reportParameterAddEnumClass.sql', '2017-06-08 14:55:05.266913', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-240-userIpMask.sql', '2017-06-08 14:55:05.267573', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-250-entityStatLookupScreenThreshold.sql', '2017-06-08 14:55:05.268239', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-260-reportTemplatesTable.sql', '2017-06-08 14:55:05.269', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-270-sendingMessagesHistory.sql', '2017-06-08 14:55:05.270171', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-280-addApplyDefault.sql', '2017-06-08 14:55:05.270749', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-290-addIsSetToSearchFolder.sql', '2017-06-08 14:55:05.271407', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-300-addEntitySnapshotTable.sql', '2017-06-08 14:55:05.271993', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-310-RuntimePropertiesTables.sql', '2017-06-08 14:55:05.27263', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-320-RuntimePropertiesRework.sql', '2017-06-08 14:55:05.273169', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-330-CategoryAttrAlterType.sql', '2017-06-08 14:55:05.273713', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-340-CategoryDiscriminator.sql', '2017-06-08 14:55:05.274202', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-350-categoryAttrOrderNo.sql', '2017-06-08 14:55:05.27472', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-360-CategoryAttrScreen.sql', '2017-06-08 14:55:05.275241', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-370-CategoryAttrRequired.sql', '2017-06-08 14:55:05.275788', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-380-AlterTypeColumnUrlInScreenHistory.sql', '2017-06-08 14:55:05.276302', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-390-AlterTableSysCategoryAttr.sql', '2017-06-08 14:55:05.276819', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-400-AlterTableSysAttrValue.sql', '2017-06-08 14:55:05.27735', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-410-addDataSetParams.sql', '2017-06-08 14:55:05.277872', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-410-addStartDateToUserSubstitution.sql', '2017-06-08 14:55:05.278384', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-420-addEntityIdToScreenHistory.sql', '2017-06-08 14:55:05.278894', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-440-addDropdownToCategoryAttribute.sql', '2017-06-08 14:55:05.279404', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/01/01-450-alterSecConstraint.sql', '2017-06-08 14:55:05.279907', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-010-addScheduledTasks.sql', '2017-06-08 14:55:05.280711', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-020-alterDoubleValueColumnInSysAttrValueTable.sql', '2017-06-08 14:55:05.281259', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-030-addReportGroup.sql', '2017-06-08 14:55:05.281971', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-040-addReportRefToBand.sql', '2017-06-08 14:55:05.282637', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-050-reportLocales.sql', '2017-06-08 14:55:05.283215', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-060-reportCode.sql', '2017-06-08 14:55:05.283827', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-070-addRoleType.sql', '2017-06-08 14:55:05.284391', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-080-addSnapshotDate.sql', '2017-06-08 14:55:05.284983', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-090-schedulingDaylightSaving.sql', '2017-06-08 14:55:05.28607', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-100-entitySnapshotAuthor.sql', '2017-06-08 14:55:05.286641', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-110-addDefaultDateIsCurrent.sql', '2017-06-08 14:55:05.2872', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-120-addUserDescriminator.sql', '2017-06-08 14:55:05.287739', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-130-alterSecConstraint.sql', '2017-06-08 14:55:05.288272', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-130-queryResults.sql', '2017-06-08 14:55:05.288789', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-140-entityLogChanges.sql', '2017-06-08 14:55:05.289302', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/02/02-150-alterSysScheduledTask.sql', '2017-06-08 14:55:05.28986', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121002-updateScreenPermissions.sql', '2017-06-08 14:55:05.290658', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121003-addCodeToCategoryAttribute.sql', '2017-06-08 14:55:05.291234', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121004-addFieldsToScheduledTasks.sql', '2017-06-08 14:55:05.291782', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121020-addLoginConstraintsForUser.sql', '2017-06-08 14:55:05.292313', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121024-addEncryptionParamsToUser.sql', '2017-06-08 14:55:05.293544', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121031-dropPasswordColumnFromScheduledTask.sql', '2017-06-08 14:55:05.294583', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121102-dropSaltColumn.sql', '2017-06-08 14:55:05.29516', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121114-addDescriptionToScheduledTask.sql', '2017-06-08 14:55:05.295719', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/12/121228-addJmxInstance.sql', '2017-06-08 14:55:05.296294', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130110-removeJmxInstanceDescription.sql', '2017-06-08 14:55:05.297061', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130311-renameColumnsForOracle.sql', '2017-06-08 14:55:05.297644', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130731-changeServerEntity.sql', '2017-06-08 14:55:05.298272', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130918-email-attachment-options.sql', '2017-06-08 14:55:05.298907', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130920-email-file-storage.sql', '2017-06-08 14:55:05.299466', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/130923-permissionsToRenamedScreens.sql', '2017-06-08 14:55:05.300002', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/131108-sending-message-timeshift.sql', '2017-06-08 14:55:05.300593', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/13/131112-scheduled-task-cron.sql', '2017-06-08 14:55:05.301179', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/14/140313-ftsQueueIndexingHost.sql', '2017-06-08 14:55:05.302082', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/14/140405-changeTypeForSysConfigValue.sql', '2017-06-08 14:55:05.30289', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/14/140708-addRememberMeTable.sql', '2017-06-08 14:55:05.303422', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/14/140716-changeSysFileSizeType.sql', '2017-06-08 14:55:05.303938', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/14/141203-setNotNullSysFileName.sql', '2017-06-08 14:55:05.304474', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150203-sendingMessageEmailHeaders.sql', '2017-06-08 14:55:05.30528', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150203-userTimeZone.sql', '2017-06-08 14:55:05.305837', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150205-addSubstituteUserInScreenHistory.sql', '2017-06-08 14:55:05.306395', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150226-addIndexInScreenHistory.sql', '2017-06-08 14:55:05.30698', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150310-alterFilterXml.sql', '2017-06-08 14:55:05.307626', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150417-runtimePropertiesChanges.sql', '2017-06-08 14:55:05.308216', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150514-categoryEntityTypeInAttribute.sql', '2017-06-08 14:55:05.308781', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150630-entityClassToCategoryAttribute.sql', '2017-06-08 14:55:05.309362', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/150805-fakeFtsQueue.sql', '2017-06-08 14:55:05.309962', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/151106-extendScheduledTaskFields.sql', '2017-06-08 14:55:05.311072', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/151116-rowLevelSecurity.sql', '2017-06-08 14:55:05.311655', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/151228-sendingMessagesExtendFields.sql', '2017-06-08 14:55:05.312231', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/15/1512282-addIsActiveToConstraint.sql', '2017-06-08 14:55:05.312801', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160322-dropUniqSysScheduledTaskBeanMethodConstraint.sql', '2017-06-08 14:55:05.313607', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160405-createUniqSysCategory.sql', '2017-06-08 14:55:05.314381', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160420-createUpdateTsIndexOnSysSendingMessage.sql', '2017-06-08 14:55:05.314939', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160616-addSizeCategoryAttribute.sql', '2017-06-08 14:55:05.31549', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160626-createIndexOnFinishTimeScheduledExecution.sql', '2017-06-08 14:55:05.316035', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160725-anonymousLogin.sql', '2017-06-08 14:55:05.316576', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/160916-addEntityIdToFtsQueue.sql', '2017-06-08 14:55:05.317105', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/161024-collectionDynamicAttributes.sql', '2017-06-08 14:55:05.317646', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/161025-sysAttrValueParentConstraint.sql', '2017-06-08 14:55:05.318247', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/161102-setIsCollectionForExistingCategoryAttrs.sql', '2017-06-08 14:55:05.319504', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/161124-FilterXmlInCategoryAttr.sql', '2017-06-08 14:55:05.320146', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/161124-joinAndWhereInCategoryAttr.sql', '2017-06-08 14:55:05.320754', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/16/270916-addEntityIdToQueryResult.sql', '2017-06-08 14:55:05.321393', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/17/170214-addEntityIdToSnapshot.sql', '2017-06-08 14:55:05.322252', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/17/170215-addEntityIdToEntityLog.sql', '2017-06-08 14:55:05.322903', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/17/170221-addEntityIdToAttributeValue.sql', '2017-06-08 14:55:05.323554', 1);
INSERT INTO sys_db_changelog VALUES ('10-cuba/update/postgres/17/280217-createRestApiTokenTable.sql', '2017-06-08 14:55:05.324183', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/150319-0855-2-updateProcDefinition.sql', '2017-06-08 14:55:05.325047', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160428-createStencilSetTable.sql', '2017-06-08 14:55:05.326053', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160429-createStencilSetIndexes.sql', '2017-06-08 14:55:05.326797', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.51702.to.51800.engine.sql', '2017-06-08 14:55:05.327583', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.51702.to.51800.history.sql', '2017-06-08 14:55:05.328292', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.51800.to.51801.engine.sql', '2017-06-08 14:55:05.328994', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.51801.to.52000.engine.sql', '2017-06-08 14:55:05.329672', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.52000.to.52001.engine.sql', '2017-06-08 14:55:05.330321', 1);
INSERT INTO sys_db_changelog VALUES ('20-bpm/update/postgres/16/160430-activiti.postgres.upgradestep.52001.to.52002.engine.sql', '2017-06-08 14:55:05.330973', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170606-0-dropTaskUserLink.sql', '2017-06-08 14:55:05.331896', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170606-1-createProjectGoal.sql', '2017-06-08 14:55:05.332539', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170606-2-createProjectGoal.sql', '2017-06-08 14:55:05.333239', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170607-2-updateProject.sql', '2017-06-08 14:55:05.333966', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170607-2-updateTask.sql', '2017-06-08 14:55:05.334626', 1);
INSERT INTO sys_db_changelog VALUES ('50-pm/update/postgres/17/170609-2-updateProjectGoal.sql', '2017-06-09 11:17:46.565632', 0);


--
-- TOC entry 2906 (class 0 OID 39705)
-- Dependencies: 216
-- Data for Name: sys_entity_snapshot; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2880 (class 0 OID 39346)
-- Dependencies: 190
-- Data for Name: sys_entity_statistics; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2878 (class 0 OID 39333)
-- Dependencies: 188
-- Data for Name: sys_file; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sys_file VALUES ('c94a97c7-6781-34ce-7d9d-9a1788649bde', '2017-06-08 14:56:45.197', 'admin', 1, '2017-06-08 14:56:45.197', NULL, NULL, NULL, '683513825289489103.png', 'png', 710, '2017-06-08 14:56:45.197');
INSERT INTO sys_file VALUES ('3d899e02-5c37-9c3e-f7f7-83c2cb79413a', '2017-06-08 14:56:45.223', 'admin', 1, '2017-06-08 14:56:45.223', NULL, NULL, NULL, '683513825289489103.png', 'png', 710, '2017-06-08 14:56:45.223');


--
-- TOC entry 2898 (class 0 OID 39580)
-- Dependencies: 208
-- Data for Name: sys_folder; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2902 (class 0 OID 39641)
-- Dependencies: 212
-- Data for Name: sys_fts_queue; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2910 (class 0 OID 39768)
-- Dependencies: 220
-- Data for Name: sys_jmx_instance; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2879 (class 0 OID 39341)
-- Dependencies: 189
-- Data for Name: sys_lock_config; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2912 (class 0 OID 39778)
-- Dependencies: 222
-- Data for Name: sys_query_result; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 221
-- Name: sys_query_result_seq; Type: SEQUENCE SET; Schema: public; Owner: cuba
--

SELECT pg_catalog.setval('sys_query_result_seq', 1, false);


--
-- TOC entry 2914 (class 0 OID 39801)
-- Dependencies: 224
-- Data for Name: sys_rest_api_token; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2882 (class 0 OID 39362)
-- Dependencies: 192
-- Data for Name: sys_scheduled_execution; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2881 (class 0 OID 39352)
-- Dependencies: 191
-- Data for Name: sys_scheduled_task; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2905 (class 0 OID 39686)
-- Dependencies: 215
-- Data for Name: sys_sending_attachment; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2904 (class 0 OID 39670)
-- Dependencies: 214
-- Data for Name: sys_sending_message; Type: TABLE DATA; Schema: public; Owner: cuba
--



--
-- TOC entry 2876 (class 0 OID 39315)
-- Dependencies: 186
-- Data for Name: sys_server; Type: TABLE DATA; Schema: public; Owner: cuba
--

INSERT INTO sys_server VALUES ('cb7bcb1c-06ee-9ea8-10a1-3c287feb646c', '2017-06-08 14:56:00.655', NULL, '2017-06-09 12:37:01.095', NULL, 'localhost:8080/app-core', true, NULL);


--
-- TOC entry 2611 (class 2606 OID 40083)
-- Name: act_evt_log act_evt_log_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- TOC entry 2564 (class 2606 OID 39992)
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- TOC entry 2562 (class 2606 OID 39984)
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- TOC entry 2625 (class 2606 OID 40244)
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 2648 (class 2606 OID 40285)
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- TOC entry 2646 (class 2606 OID 40277)
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- TOC entry 2639 (class 2606 OID 40269)
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- TOC entry 2650 (class 2606 OID 40293)
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 2619 (class 2606 OID 40233)
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 2621 (class 2606 OID 40235)
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- TOC entry 2631 (class 2606 OID 40253)
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 2634 (class 2606 OID 40261)
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- TOC entry 2655 (class 2606 OID 40319)
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- TOC entry 2663 (class 2606 OID 40340)
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- TOC entry 2657 (class 2606 OID 40324)
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- TOC entry 2661 (class 2606 OID 40332)
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- TOC entry 2615 (class 2606 OID 40088)
-- Name: act_procdef_info act_procdef_info_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- TOC entry 2567 (class 2606 OID 40001)
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- TOC entry 2572 (class 2606 OID 40010)
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- TOC entry 2584 (class 2606 OID 40037)
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- TOC entry 2609 (class 2606 OID 40071)
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- TOC entry 2579 (class 2606 OID 40019)
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- TOC entry 2599 (class 2606 OID 40054)
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- TOC entry 2582 (class 2606 OID 40028)
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- TOC entry 2592 (class 2606 OID 40046)
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- TOC entry 2605 (class 2606 OID 40062)
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- TOC entry 2617 (class 2606 OID 40224)
-- Name: act_procdef_info act_uniq_info_procdef; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- TOC entry 2586 (class 2606 OID 40102)
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, tenant_id_);


--
-- TOC entry 2536 (class 2606 OID 39838)
-- Name: bpm_proc_actor bpm_proc_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_actor
    ADD CONSTRAINT bpm_proc_actor_pkey PRIMARY KEY (id);


--
-- TOC entry 2543 (class 2606 OID 39854)
-- Name: bpm_proc_attachment bpm_proc_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT bpm_proc_attachment_pkey PRIMARY KEY (id);


--
-- TOC entry 2541 (class 2606 OID 39846)
-- Name: bpm_proc_attachment_type bpm_proc_attachment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment_type
    ADD CONSTRAINT bpm_proc_attachment_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2526 (class 2606 OID 39817)
-- Name: bpm_proc_definition bpm_proc_definition_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_definition
    ADD CONSTRAINT bpm_proc_definition_pkey PRIMARY KEY (id);


--
-- TOC entry 2532 (class 2606 OID 39833)
-- Name: bpm_proc_instance bpm_proc_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_instance
    ADD CONSTRAINT bpm_proc_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 2556 (class 2606 OID 39875)
-- Name: bpm_proc_model bpm_proc_model_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_model
    ADD CONSTRAINT bpm_proc_model_pkey PRIMARY KEY (id);


--
-- TOC entry 2529 (class 2606 OID 39825)
-- Name: bpm_proc_role bpm_proc_role_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_role
    ADD CONSTRAINT bpm_proc_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2550 (class 2606 OID 39862)
-- Name: bpm_proc_task bpm_proc_task_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task
    ADD CONSTRAINT bpm_proc_task_pkey PRIMARY KEY (id);


--
-- TOC entry 2554 (class 2606 OID 39867)
-- Name: bpm_proc_task_user_link bpm_proc_task_user_link_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task_user_link
    ADD CONSTRAINT bpm_proc_task_user_link_pkey PRIMARY KEY (proc_task_id, user_id);


--
-- TOC entry 2559 (class 2606 OID 39883)
-- Name: bpm_stencil_set bpm_stencil_set_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_stencil_set
    ADD CONSTRAINT bpm_stencil_set_pkey PRIMARY KEY (id);


--
-- TOC entry 2668 (class 2606 OID 40365)
-- Name: pm_company_goal pm_company_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_company_goal
    ADD CONSTRAINT pm_company_goal_pkey PRIMARY KEY (id);


--
-- TOC entry 2676 (class 2606 OID 40378)
-- Name: pm_project_goal pm_project_goal_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_goal
    ADD CONSTRAINT pm_project_goal_pkey PRIMARY KEY (id);


--
-- TOC entry 2666 (class 2606 OID 40360)
-- Name: pm_project pm_project_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project
    ADD CONSTRAINT pm_project_pkey PRIMARY KEY (id);


--
-- TOC entry 2678 (class 2606 OID 40383)
-- Name: pm_project_user_link pm_project_user_link_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_user_link
    ADD CONSTRAINT pm_project_user_link_pkey PRIMARY KEY (project_id, user_id);


--
-- TOC entry 2672 (class 2606 OID 40373)
-- Name: pm_task pm_task_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_task
    ADD CONSTRAINT pm_task_pkey PRIMARY KEY (id);


--
-- TOC entry 2434 (class 2606 OID 39463)
-- Name: sec_constraint sec_constraint_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_constraint
    ADD CONSTRAINT sec_constraint_pkey PRIMARY KEY (id);


--
-- TOC entry 2462 (class 2606 OID 39559)
-- Name: sec_entity_log_attr sec_entity_log_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_entity_log_attr
    ADD CONSTRAINT sec_entity_log_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 2459 (class 2606 OID 39542)
-- Name: sec_entity_log sec_entity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_entity_log
    ADD CONSTRAINT sec_entity_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2465 (class 2606 OID 39573)
-- Name: sec_filter sec_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_filter
    ADD CONSTRAINT sec_filter_pkey PRIMARY KEY (id);


--
-- TOC entry 2422 (class 2606 OID 39401)
-- Name: sec_group_hierarchy sec_group_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_group_hierarchy
    ADD CONSTRAINT sec_group_hierarchy_pkey PRIMARY KEY (id);


--
-- TOC entry 2420 (class 2606 OID 39390)
-- Name: sec_group sec_group_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_group
    ADD CONSTRAINT sec_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2451 (class 2606 OID 39526)
-- Name: sec_logged_attr sec_logged_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_logged_attr
    ADD CONSTRAINT sec_logged_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 2453 (class 2606 OID 39528)
-- Name: sec_logged_attr sec_logged_attr_uniq_name; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_logged_attr
    ADD CONSTRAINT sec_logged_attr_uniq_name UNIQUE (entity_id, name);


--
-- TOC entry 2446 (class 2606 OID 39519)
-- Name: sec_logged_entity sec_logged_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_logged_entity
    ADD CONSTRAINT sec_logged_entity_pkey PRIMARY KEY (id);


--
-- TOC entry 2448 (class 2606 OID 39521)
-- Name: sec_logged_entity sec_logged_entity_uniq_name; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_logged_entity
    ADD CONSTRAINT sec_logged_entity_uniq_name UNIQUE (name);


--
-- TOC entry 2431 (class 2606 OID 39446)
-- Name: sec_permission sec_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_permission
    ADD CONSTRAINT sec_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2472 (class 2606 OID 39610)
-- Name: sec_presentation sec_presentation_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_presentation
    ADD CONSTRAINT sec_presentation_pkey PRIMARY KEY (id);


--
-- TOC entry 2522 (class 2606 OID 39793)
-- Name: sec_remember_me sec_remember_me_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_remember_me
    ADD CONSTRAINT sec_remember_me_pkey PRIMARY KEY (id);


--
-- TOC entry 2417 (class 2606 OID 39384)
-- Name: sec_role sec_role_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_role
    ADD CONSTRAINT sec_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2482 (class 2606 OID 39657)
-- Name: sec_screen_history sec_screen_history_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_screen_history
    ADD CONSTRAINT sec_screen_history_pkey PRIMARY KEY (id);


--
-- TOC entry 2475 (class 2606 OID 39624)
-- Name: sec_search_folder sec_search_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_search_folder
    ADD CONSTRAINT sec_search_folder_pkey PRIMARY KEY (folder_id);


--
-- TOC entry 2437 (class 2606 OID 39477)
-- Name: sec_session_attr sec_session_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_session_attr
    ADD CONSTRAINT sec_session_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 2425 (class 2606 OID 39419)
-- Name: sec_user sec_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user
    ADD CONSTRAINT sec_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2428 (class 2606 OID 39430)
-- Name: sec_user_role sec_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 2439 (class 2606 OID 39491)
-- Name: sec_user_setting sec_user_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_setting
    ADD CONSTRAINT sec_user_setting_pkey PRIMARY KEY (id);


--
-- TOC entry 2441 (class 2606 OID 39493)
-- Name: sec_user_setting sec_user_setting_uniq; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_setting
    ADD CONSTRAINT sec_user_setting_uniq UNIQUE (user_id, name, client_type);


--
-- TOC entry 2444 (class 2606 OID 39503)
-- Name: sec_user_substitution sec_user_substitution_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_substitution
    ADD CONSTRAINT sec_user_substitution_pkey PRIMARY KEY (id);


--
-- TOC entry 2469 (class 2606 OID 39597)
-- Name: sys_app_folder sys_app_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_app_folder
    ADD CONSTRAINT sys_app_folder_pkey PRIMARY KEY (folder_id);


--
-- TOC entry 2509 (class 2606 OID 39753)
-- Name: sys_attr_value sys_attr_value_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_attr_value
    ADD CONSTRAINT sys_attr_value_pkey PRIMARY KEY (id);


--
-- TOC entry 2503 (class 2606 OID 39738)
-- Name: sys_category_attr sys_category_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_category_attr
    ADD CONSTRAINT sys_category_attr_pkey PRIMARY KEY (id);


--
-- TOC entry 2499 (class 2606 OID 39729)
-- Name: sys_category sys_category_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_category
    ADD CONSTRAINT sys_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2401 (class 2606 OID 39331)
-- Name: sys_config sys_config_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_config
    ADD CONSTRAINT sys_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2395 (class 2606 OID 39314)
-- Name: sys_db_changelog sys_db_changelog_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_db_changelog
    ADD CONSTRAINT sys_db_changelog_pkey PRIMARY KEY (script_name);


--
-- TOC entry 2496 (class 2606 OID 39712)
-- Name: sys_entity_snapshot sys_entity_snapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_entity_snapshot
    ADD CONSTRAINT sys_entity_snapshot_pkey PRIMARY KEY (id);


--
-- TOC entry 2408 (class 2606 OID 39350)
-- Name: sys_entity_statistics sys_entity_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_entity_statistics
    ADD CONSTRAINT sys_entity_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 2403 (class 2606 OID 39340)
-- Name: sys_file sys_file_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_file
    ADD CONSTRAINT sys_file_pkey PRIMARY KEY (id);


--
-- TOC entry 2467 (class 2606 OID 39584)
-- Name: sys_folder sys_folder_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_folder
    ADD CONSTRAINT sys_folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2478 (class 2606 OID 39648)
-- Name: sys_fts_queue sys_fts_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_fts_queue
    ADD CONSTRAINT sys_fts_queue_pkey PRIMARY KEY (id);


--
-- TOC entry 2511 (class 2606 OID 39775)
-- Name: sys_jmx_instance sys_jmx_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_jmx_instance
    ADD CONSTRAINT sys_jmx_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 2405 (class 2606 OID 39345)
-- Name: sys_lock_config sys_lock_config_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_lock_config
    ADD CONSTRAINT sys_lock_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2518 (class 2606 OID 39783)
-- Name: sys_query_result sys_query_result_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_query_result
    ADD CONSTRAINT sys_query_result_pkey PRIMARY KEY (id);


--
-- TOC entry 2524 (class 2606 OID 39808)
-- Name: sys_rest_api_token sys_rest_api_token_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_rest_api_token
    ADD CONSTRAINT sys_rest_api_token_pkey PRIMARY KEY (id);


--
-- TOC entry 2414 (class 2606 OID 39369)
-- Name: sys_scheduled_execution sys_scheduled_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_scheduled_execution
    ADD CONSTRAINT sys_scheduled_execution_pkey PRIMARY KEY (id);


--
-- TOC entry 2410 (class 2606 OID 39361)
-- Name: sys_scheduled_task sys_scheduled_task_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_scheduled_task
    ADD CONSTRAINT sys_scheduled_task_pkey PRIMARY KEY (id);


--
-- TOC entry 2490 (class 2606 OID 39693)
-- Name: sys_sending_attachment sys_sending_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_sending_attachment
    ADD CONSTRAINT sys_sending_attachment_pkey PRIMARY KEY (id);


--
-- TOC entry 2487 (class 2606 OID 39677)
-- Name: sys_sending_message sys_sending_message_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_sending_message
    ADD CONSTRAINT sys_sending_message_pkey PRIMARY KEY (id);


--
-- TOC entry 2398 (class 2606 OID 39322)
-- Name: sys_server sys_server_pkey; Type: CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_server
    ADD CONSTRAINT sys_server_pkey PRIMARY KEY (id);


--
-- TOC entry 2593 (class 1259 OID 40133)
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_athrz_procedef ON act_ru_identitylink USING btree (proc_def_id_);


--
-- TOC entry 2565 (class 1259 OID 40095)
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_bytear_depl ON act_ge_bytearray USING btree (deployment_id_);


--
-- TOC entry 2606 (class 1259 OID 40187)
-- Name: act_idx_event_subscr; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_event_subscr ON act_ru_event_subscr USING btree (execution_id_);


--
-- TOC entry 2607 (class 1259 OID 40093)
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_event_subscr_config_ ON act_ru_event_subscr USING btree (configuration_);


--
-- TOC entry 2573 (class 1259 OID 40109)
-- Name: act_idx_exe_parent; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_exe_parent ON act_ru_execution USING btree (parent_id_);


--
-- TOC entry 2574 (class 1259 OID 40121)
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_exe_procdef ON act_ru_execution USING btree (proc_def_id_);


--
-- TOC entry 2575 (class 1259 OID 40103)
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_exe_procinst ON act_ru_execution USING btree (proc_inst_id_);


--
-- TOC entry 2576 (class 1259 OID 40115)
-- Name: act_idx_exe_super; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_exe_super ON act_ru_execution USING btree (super_exec_);


--
-- TOC entry 2577 (class 1259 OID 40089)
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_exec_buskey ON act_ru_execution USING btree (business_key_);


--
-- TOC entry 2626 (class 1259 OID 40297)
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_act_inst_end ON act_hi_actinst USING btree (end_time_);


--
-- TOC entry 2627 (class 1259 OID 40307)
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_act_inst_exec ON act_hi_actinst USING btree (execution_id_, act_id_);


--
-- TOC entry 2628 (class 1259 OID 40306)
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_act_inst_procinst ON act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- TOC entry 2629 (class 1259 OID 40296)
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_act_inst_start ON act_hi_actinst USING btree (start_time_);


--
-- TOC entry 2640 (class 1259 OID 40299)
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_detail_act_inst ON act_hi_detail USING btree (act_inst_id_);


--
-- TOC entry 2641 (class 1259 OID 40301)
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_detail_name ON act_hi_detail USING btree (name_);


--
-- TOC entry 2642 (class 1259 OID 40298)
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_detail_proc_inst ON act_hi_detail USING btree (proc_inst_id_);


--
-- TOC entry 2643 (class 1259 OID 40302)
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_detail_task_id ON act_hi_detail USING btree (task_id_);


--
-- TOC entry 2644 (class 1259 OID 40300)
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_detail_time ON act_hi_detail USING btree (time_);


--
-- TOC entry 2651 (class 1259 OID 40310)
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON act_hi_identitylink USING btree (proc_inst_id_);


--
-- TOC entry 2652 (class 1259 OID 40309)
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_ident_lnk_task ON act_hi_identitylink USING btree (task_id_);


--
-- TOC entry 2653 (class 1259 OID 40308)
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_ident_lnk_user ON act_hi_identitylink USING btree (user_id_);


--
-- TOC entry 2622 (class 1259 OID 40295)
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_pro_i_buskey ON act_hi_procinst USING btree (business_key_);


--
-- TOC entry 2623 (class 1259 OID 40294)
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_pro_inst_end ON act_hi_procinst USING btree (end_time_);


--
-- TOC entry 2635 (class 1259 OID 40304)
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_procvar_name_type ON act_hi_varinst USING btree (name_, var_type_);


--
-- TOC entry 2636 (class 1259 OID 40303)
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON act_hi_varinst USING btree (proc_inst_id_);


--
-- TOC entry 2637 (class 1259 OID 40305)
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_procvar_task_id ON act_hi_varinst USING btree (task_id_);


--
-- TOC entry 2632 (class 1259 OID 40311)
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_hi_task_inst_procinst ON act_hi_taskinst USING btree (proc_inst_id_);


--
-- TOC entry 2594 (class 1259 OID 40092)
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_ident_lnk_group ON act_ru_identitylink USING btree (group_id_);


--
-- TOC entry 2595 (class 1259 OID 40091)
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_ident_lnk_user ON act_ru_identitylink USING btree (user_id_);


--
-- TOC entry 2596 (class 1259 OID 40139)
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_idl_procinst ON act_ru_identitylink USING btree (proc_inst_id_);


--
-- TOC entry 2580 (class 1259 OID 40181)
-- Name: act_idx_job_exception; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_job_exception ON act_ru_job USING btree (exception_stack_id_);


--
-- TOC entry 2658 (class 1259 OID 40341)
-- Name: act_idx_memb_group; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_memb_group ON act_id_membership USING btree (group_id_);


--
-- TOC entry 2659 (class 1259 OID 40347)
-- Name: act_idx_memb_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_memb_user ON act_id_membership USING btree (user_id_);


--
-- TOC entry 2568 (class 1259 OID 40205)
-- Name: act_idx_model_deployment; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_model_deployment ON act_re_model USING btree (deployment_id_);


--
-- TOC entry 2569 (class 1259 OID 40193)
-- Name: act_idx_model_source; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_model_source ON act_re_model USING btree (editor_source_value_id_);


--
-- TOC entry 2570 (class 1259 OID 40199)
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_model_source_extra ON act_re_model USING btree (editor_source_extra_value_id_);


--
-- TOC entry 2612 (class 1259 OID 40211)
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_procdef_info_json ON act_procdef_info USING btree (info_json_id_);


--
-- TOC entry 2613 (class 1259 OID 40217)
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_procdef_info_proc ON act_procdef_info USING btree (proc_def_id_);


--
-- TOC entry 2587 (class 1259 OID 40090)
-- Name: act_idx_task_create; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_task_create ON act_ru_task USING btree (create_time_);


--
-- TOC entry 2588 (class 1259 OID 40145)
-- Name: act_idx_task_exec; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_task_exec ON act_ru_task USING btree (execution_id_);


--
-- TOC entry 2589 (class 1259 OID 40157)
-- Name: act_idx_task_procdef; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_task_procdef ON act_ru_task USING btree (proc_def_id_);


--
-- TOC entry 2590 (class 1259 OID 40151)
-- Name: act_idx_task_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_task_procinst ON act_ru_task USING btree (proc_inst_id_);


--
-- TOC entry 2597 (class 1259 OID 40127)
-- Name: act_idx_tskass_task; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_tskass_task ON act_ru_identitylink USING btree (task_id_);


--
-- TOC entry 2600 (class 1259 OID 40175)
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_var_bytearray ON act_ru_variable USING btree (bytearray_id_);


--
-- TOC entry 2601 (class 1259 OID 40163)
-- Name: act_idx_var_exe; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_var_exe ON act_ru_variable USING btree (execution_id_);


--
-- TOC entry 2602 (class 1259 OID 40169)
-- Name: act_idx_var_procinst; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_var_procinst ON act_ru_variable USING btree (proc_inst_id_);


--
-- TOC entry 2603 (class 1259 OID 40094)
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX act_idx_variable_task_id ON act_ru_variable USING btree (task_id_);


--
-- TOC entry 2537 (class 1259 OID 39919)
-- Name: idx_bpm_proc_actor_proc_instance; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_actor_proc_instance ON bpm_proc_actor USING btree (proc_instance_id);


--
-- TOC entry 2538 (class 1259 OID 39917)
-- Name: idx_bpm_proc_actor_proc_role; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_actor_proc_role ON bpm_proc_actor USING btree (proc_role_id);


--
-- TOC entry 2539 (class 1259 OID 39918)
-- Name: idx_bpm_proc_actor_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_actor_user ON bpm_proc_actor USING btree (user_id);


--
-- TOC entry 2544 (class 1259 OID 39945)
-- Name: idx_bpm_proc_attachment_author; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_attachment_author ON bpm_proc_attachment USING btree (author_id);


--
-- TOC entry 2545 (class 1259 OID 39947)
-- Name: idx_bpm_proc_attachment_file; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_attachment_file ON bpm_proc_attachment USING btree (file_id);


--
-- TOC entry 2546 (class 1259 OID 39949)
-- Name: idx_bpm_proc_attachment_proc_instance; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_attachment_proc_instance ON bpm_proc_attachment USING btree (proc_instance_id);


--
-- TOC entry 2547 (class 1259 OID 39948)
-- Name: idx_bpm_proc_attachment_proc_task; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_attachment_proc_task ON bpm_proc_attachment USING btree (proc_task_id);


--
-- TOC entry 2548 (class 1259 OID 39946)
-- Name: idx_bpm_proc_attachment_type; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_attachment_type ON bpm_proc_attachment USING btree (type_id);


--
-- TOC entry 2527 (class 1259 OID 39977)
-- Name: idx_bpm_proc_definition_model; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_definition_model ON bpm_proc_definition USING btree (model_id);


--
-- TOC entry 2533 (class 1259 OID 39900)
-- Name: idx_bpm_proc_instance_proc_definition; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_instance_proc_definition ON bpm_proc_instance USING btree (proc_definition_id);


--
-- TOC entry 2534 (class 1259 OID 39901)
-- Name: idx_bpm_proc_instance_started_by; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_instance_started_by ON bpm_proc_instance USING btree (started_by_id);


--
-- TOC entry 2557 (class 1259 OID 39978)
-- Name: idx_bpm_proc_model_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_bpm_proc_model_uniq_name ON bpm_proc_model USING btree (name) WHERE (delete_ts IS NULL);


--
-- TOC entry 2530 (class 1259 OID 39889)
-- Name: idx_bpm_proc_role_proc_definition; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_role_proc_definition ON bpm_proc_role USING btree (proc_definition_id);


--
-- TOC entry 2551 (class 1259 OID 39960)
-- Name: idx_bpm_proc_task_proc_actor; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_task_proc_actor ON bpm_proc_task USING btree (proc_actor_id);


--
-- TOC entry 2552 (class 1259 OID 39961)
-- Name: idx_bpm_proc_task_proc_instance; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_bpm_proc_task_proc_instance ON bpm_proc_task USING btree (proc_instance_id);


--
-- TOC entry 2560 (class 1259 OID 39979)
-- Name: idx_bpm_stencil_set_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_bpm_stencil_set_uniq_name ON bpm_stencil_set USING btree (name) WHERE (delete_ts IS NULL);


--
-- TOC entry 2500 (class 1259 OID 39745)
-- Name: idx_cat_attr_ent_type_and_code; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_cat_attr_ent_type_and_code ON sys_category_attr USING btree (category_entity_type, code) WHERE (delete_ts IS NULL);


--
-- TOC entry 2673 (class 1259 OID 40412)
-- Name: idx_pm_project_goal_company_goal; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_pm_project_goal_company_goal ON pm_project_goal USING btree (company_goal_id);


--
-- TOC entry 2674 (class 1259 OID 40413)
-- Name: idx_pm_project_goal_project; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_pm_project_goal_project ON pm_project_goal USING btree (project_id);


--
-- TOC entry 2664 (class 1259 OID 40389)
-- Name: idx_pm_project_manager; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_pm_project_manager ON pm_project USING btree (manager_id);


--
-- TOC entry 2669 (class 1259 OID 40401)
-- Name: idx_pm_task_executor; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_pm_task_executor ON pm_task USING btree (executor_id);


--
-- TOC entry 2670 (class 1259 OID 40400)
-- Name: idx_pm_task_project; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_pm_task_project ON pm_task USING btree (project_id);


--
-- TOC entry 2432 (class 1259 OID 39469)
-- Name: idx_sec_constraint_group; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_constraint_group ON sec_constraint USING btree (group_id);


--
-- TOC entry 2460 (class 1259 OID 39565)
-- Name: idx_sec_entity_log_attr_item; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_entity_log_attr_item ON sec_entity_log_attr USING btree (item_id);


--
-- TOC entry 2454 (class 1259 OID 39548)
-- Name: idx_sec_entity_log_entity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_entity_log_entity_id ON sec_entity_log USING btree (entity_id);


--
-- TOC entry 2455 (class 1259 OID 39550)
-- Name: idx_sec_entity_log_ientity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_entity_log_ientity_id ON sec_entity_log USING btree (int_entity_id);


--
-- TOC entry 2456 (class 1259 OID 39551)
-- Name: idx_sec_entity_log_lentity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_entity_log_lentity_id ON sec_entity_log USING btree (long_entity_id);


--
-- TOC entry 2457 (class 1259 OID 39549)
-- Name: idx_sec_entity_log_sentity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_entity_log_sentity_id ON sec_entity_log USING btree (string_entity_id);


--
-- TOC entry 2463 (class 1259 OID 39579)
-- Name: idx_sec_filter_component_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_filter_component_user ON sec_filter USING btree (component, user_id);


--
-- TOC entry 2418 (class 1259 OID 39396)
-- Name: idx_sec_group_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sec_group_uniq_name ON sec_group USING btree (name) WHERE (delete_ts IS NULL);


--
-- TOC entry 2449 (class 1259 OID 39534)
-- Name: idx_sec_logged_attr_entity; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_logged_attr_entity ON sec_logged_attr USING btree (entity_id);


--
-- TOC entry 2429 (class 1259 OID 39452)
-- Name: idx_sec_permission_unique; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sec_permission_unique ON sec_permission USING btree (role_id, permission_type, target) WHERE (delete_ts IS NULL);


--
-- TOC entry 2470 (class 1259 OID 39616)
-- Name: idx_sec_presentation_component_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_presentation_component_user ON sec_presentation USING btree (component, user_id);


--
-- TOC entry 2519 (class 1259 OID 39800)
-- Name: idx_sec_remember_me_token; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_remember_me_token ON sec_remember_me USING btree (token);


--
-- TOC entry 2520 (class 1259 OID 39799)
-- Name: idx_sec_remember_me_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_remember_me_user ON sec_remember_me USING btree (user_id);


--
-- TOC entry 2415 (class 1259 OID 39385)
-- Name: idx_sec_role_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sec_role_uniq_name ON sec_role USING btree (name) WHERE (delete_ts IS NULL);


--
-- TOC entry 2479 (class 1259 OID 39669)
-- Name: idx_sec_screen_hist_sub_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_screen_hist_sub_user ON sec_screen_history USING btree (substituted_user_id);


--
-- TOC entry 2480 (class 1259 OID 39668)
-- Name: idx_sec_screen_history_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_screen_history_user ON sec_screen_history USING btree (user_id);


--
-- TOC entry 2473 (class 1259 OID 39640)
-- Name: idx_sec_search_folder_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_search_folder_user ON sec_search_folder USING btree (user_id);


--
-- TOC entry 2435 (class 1259 OID 39483)
-- Name: idx_sec_session_attr_group; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_session_attr_group ON sec_session_attr USING btree (group_id);


--
-- TOC entry 2426 (class 1259 OID 39441)
-- Name: idx_sec_user_role_uniq_role; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sec_user_role_uniq_role ON sec_user_role USING btree (user_id, role_id) WHERE (delete_ts IS NULL);


--
-- TOC entry 2442 (class 1259 OID 39514)
-- Name: idx_sec_user_substitution_user; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sec_user_substitution_user ON sec_user_substitution USING btree (user_id);


--
-- TOC entry 2423 (class 1259 OID 39425)
-- Name: idx_sec_user_uniq_login; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sec_user_uniq_login ON sec_user USING btree (login_lc) WHERE (delete_ts IS NULL);


--
-- TOC entry 2504 (class 1259 OID 39764)
-- Name: idx_sys_attr_value_entity; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_attr_value_entity ON sys_attr_value USING btree (entity_id);


--
-- TOC entry 2505 (class 1259 OID 39766)
-- Name: idx_sys_attr_value_ientity; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_attr_value_ientity ON sys_attr_value USING btree (int_entity_id);


--
-- TOC entry 2506 (class 1259 OID 39767)
-- Name: idx_sys_attr_value_lentity; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_attr_value_lentity ON sys_attr_value USING btree (long_entity_id);


--
-- TOC entry 2507 (class 1259 OID 39765)
-- Name: idx_sys_attr_value_sentity; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_attr_value_sentity ON sys_attr_value USING btree (string_entity_id);


--
-- TOC entry 2501 (class 1259 OID 39744)
-- Name: idx_sys_category_attr_category; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_category_attr_category ON sys_category_attr USING btree (category_id);


--
-- TOC entry 2497 (class 1259 OID 39730)
-- Name: idx_sys_category_uniq_name_entity_type; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sys_category_uniq_name_entity_type ON sys_category USING btree (name, entity_type) WHERE (delete_ts IS NULL);


--
-- TOC entry 2399 (class 1259 OID 39332)
-- Name: idx_sys_config_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sys_config_uniq_name ON sys_config USING btree (name);


--
-- TOC entry 2491 (class 1259 OID 39718)
-- Name: idx_sys_entity_snapshot_entity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_entity_snapshot_entity_id ON sys_entity_snapshot USING btree (entity_id);


--
-- TOC entry 2492 (class 1259 OID 39720)
-- Name: idx_sys_entity_snapshot_ientity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_entity_snapshot_ientity_id ON sys_entity_snapshot USING btree (int_entity_id);


--
-- TOC entry 2493 (class 1259 OID 39721)
-- Name: idx_sys_entity_snapshot_lentity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_entity_snapshot_lentity_id ON sys_entity_snapshot USING btree (long_entity_id);


--
-- TOC entry 2494 (class 1259 OID 39719)
-- Name: idx_sys_entity_snapshot_sentity_id; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_entity_snapshot_sentity_id ON sys_entity_snapshot USING btree (string_entity_id);


--
-- TOC entry 2406 (class 1259 OID 39351)
-- Name: idx_sys_entity_statistics_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sys_entity_statistics_uniq_name ON sys_entity_statistics USING btree (name);


--
-- TOC entry 2476 (class 1259 OID 39649)
-- Name: idx_sys_fts_queue_idxhost_crts; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_fts_queue_idxhost_crts ON sys_fts_queue USING btree (indexing_host, create_ts);


--
-- TOC entry 2512 (class 1259 OID 39784)
-- Name: idx_sys_query_result_entity_session_key; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_query_result_entity_session_key ON sys_query_result USING btree (entity_id, session_id, query_key);


--
-- TOC entry 2513 (class 1259 OID 39786)
-- Name: idx_sys_query_result_ientity_session_key; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_query_result_ientity_session_key ON sys_query_result USING btree (int_entity_id, session_id, query_key);


--
-- TOC entry 2514 (class 1259 OID 39787)
-- Name: idx_sys_query_result_lentity_session_key; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_query_result_lentity_session_key ON sys_query_result USING btree (long_entity_id, session_id, query_key);


--
-- TOC entry 2515 (class 1259 OID 39785)
-- Name: idx_sys_query_result_sentity_session_key; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_query_result_sentity_session_key ON sys_query_result USING btree (string_entity_id, session_id, query_key);


--
-- TOC entry 2516 (class 1259 OID 39788)
-- Name: idx_sys_query_result_session_key; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_query_result_session_key ON sys_query_result USING btree (session_id, query_key);


--
-- TOC entry 2411 (class 1259 OID 39376)
-- Name: idx_sys_scheduled_execution_task_finish_time; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_scheduled_execution_task_finish_time ON sys_scheduled_execution USING btree (task_id, finish_time);


--
-- TOC entry 2412 (class 1259 OID 39375)
-- Name: idx_sys_scheduled_execution_task_start_time; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_scheduled_execution_task_start_time ON sys_scheduled_execution USING btree (task_id, start_time);


--
-- TOC entry 2483 (class 1259 OID 39684)
-- Name: idx_sys_sending_message_date_sent; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_sending_message_date_sent ON sys_sending_message USING btree (date_sent);


--
-- TOC entry 2484 (class 1259 OID 39683)
-- Name: idx_sys_sending_message_status; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_sending_message_status ON sys_sending_message USING btree (status);


--
-- TOC entry 2485 (class 1259 OID 39685)
-- Name: idx_sys_sending_message_update_ts; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX idx_sys_sending_message_update_ts ON sys_sending_message USING btree (update_ts);


--
-- TOC entry 2396 (class 1259 OID 39323)
-- Name: idx_sys_server_uniq_name; Type: INDEX; Schema: public; Owner: cuba
--

CREATE UNIQUE INDEX idx_sys_server_uniq_name ON sys_server USING btree (name);


--
-- TOC entry 2488 (class 1259 OID 39704)
-- Name: sys_sending_attachment_message_idx; Type: INDEX; Schema: public; Owner: cuba
--

CREATE INDEX sys_sending_attachment_message_idx ON sys_sending_attachment USING btree (message_id);


--
-- TOC entry 2741 (class 2606 OID 40134)
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 2728 (class 2606 OID 40096)
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- TOC entry 2746 (class 2606 OID 40188)
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2733 (class 2606 OID 40110)
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2735 (class 2606 OID 40122)
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 2732 (class 2606 OID 40104)
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2734 (class 2606 OID 40116)
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2742 (class 2606 OID 40140)
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2747 (class 2606 OID 40212)
-- Name: act_procdef_info act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 2748 (class 2606 OID 40218)
-- Name: act_procdef_info act_fk_info_procdef; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 2736 (class 2606 OID 40182)
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 2749 (class 2606 OID 40342)
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES act_id_group(id_);


--
-- TOC entry 2750 (class 2606 OID 40348)
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES act_id_user(id_);


--
-- TOC entry 2731 (class 2606 OID 40206)
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- TOC entry 2729 (class 2606 OID 40194)
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 2730 (class 2606 OID 40200)
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 2737 (class 2606 OID 40146)
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2739 (class 2606 OID 40158)
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- TOC entry 2738 (class 2606 OID 40152)
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2740 (class 2606 OID 40128)
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES act_ru_task(id_);


--
-- TOC entry 2745 (class 2606 OID 40176)
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES act_ge_bytearray(id_);


--
-- TOC entry 2743 (class 2606 OID 40164)
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2744 (class 2606 OID 40170)
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- TOC entry 2717 (class 2606 OID 39907)
-- Name: bpm_proc_actor fk_bpm_proc_actor_proc_instance_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_actor
    ADD CONSTRAINT fk_bpm_proc_actor_proc_instance_id FOREIGN KEY (proc_instance_id) REFERENCES bpm_proc_instance(id);


--
-- TOC entry 2718 (class 2606 OID 39912)
-- Name: bpm_proc_actor fk_bpm_proc_actor_proc_role_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_actor
    ADD CONSTRAINT fk_bpm_proc_actor_proc_role_id FOREIGN KEY (proc_role_id) REFERENCES bpm_proc_role(id);


--
-- TOC entry 2716 (class 2606 OID 39902)
-- Name: bpm_proc_actor fk_bpm_proc_actor_user_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_actor
    ADD CONSTRAINT fk_bpm_proc_actor_user_id FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2723 (class 2606 OID 39940)
-- Name: bpm_proc_attachment fk_bpm_proc_attachment_author_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT fk_bpm_proc_attachment_author_id FOREIGN KEY (author_id) REFERENCES sec_user(id);


--
-- TOC entry 2719 (class 2606 OID 39920)
-- Name: bpm_proc_attachment fk_bpm_proc_attachment_file_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT fk_bpm_proc_attachment_file_id FOREIGN KEY (file_id) REFERENCES sys_file(id);


--
-- TOC entry 2721 (class 2606 OID 39930)
-- Name: bpm_proc_attachment fk_bpm_proc_attachment_proc_instance_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT fk_bpm_proc_attachment_proc_instance_id FOREIGN KEY (proc_instance_id) REFERENCES bpm_proc_instance(id);


--
-- TOC entry 2722 (class 2606 OID 39935)
-- Name: bpm_proc_attachment fk_bpm_proc_attachment_proc_task_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT fk_bpm_proc_attachment_proc_task_id FOREIGN KEY (proc_task_id) REFERENCES bpm_proc_task(id);


--
-- TOC entry 2720 (class 2606 OID 39925)
-- Name: bpm_proc_attachment fk_bpm_proc_attachment_type_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_attachment
    ADD CONSTRAINT fk_bpm_proc_attachment_type_id FOREIGN KEY (type_id) REFERENCES bpm_proc_attachment_type(id);


--
-- TOC entry 2712 (class 2606 OID 39972)
-- Name: bpm_proc_definition fk_bpm_proc_definition_model_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_definition
    ADD CONSTRAINT fk_bpm_proc_definition_model_id FOREIGN KEY (model_id) REFERENCES bpm_proc_model(id);


--
-- TOC entry 2714 (class 2606 OID 39890)
-- Name: bpm_proc_instance fk_bpm_proc_instance_proc_definition_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_instance
    ADD CONSTRAINT fk_bpm_proc_instance_proc_definition_id FOREIGN KEY (proc_definition_id) REFERENCES bpm_proc_definition(id);


--
-- TOC entry 2715 (class 2606 OID 39895)
-- Name: bpm_proc_instance fk_bpm_proc_instance_started_by_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_instance
    ADD CONSTRAINT fk_bpm_proc_instance_started_by_id FOREIGN KEY (started_by_id) REFERENCES sec_user(id);


--
-- TOC entry 2713 (class 2606 OID 39884)
-- Name: bpm_proc_role fk_bpm_proc_role_proc_definition_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_role
    ADD CONSTRAINT fk_bpm_proc_role_proc_definition_id FOREIGN KEY (proc_definition_id) REFERENCES bpm_proc_definition(id);


--
-- TOC entry 2725 (class 2606 OID 39955)
-- Name: bpm_proc_task fk_bpm_proc_task_proc_actor_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task
    ADD CONSTRAINT fk_bpm_proc_task_proc_actor_id FOREIGN KEY (proc_actor_id) REFERENCES bpm_proc_actor(id);


--
-- TOC entry 2724 (class 2606 OID 39950)
-- Name: bpm_proc_task fk_bpm_proc_task_proc_instance_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task
    ADD CONSTRAINT fk_bpm_proc_task_proc_instance_id FOREIGN KEY (proc_instance_id) REFERENCES bpm_proc_instance(id);


--
-- TOC entry 2726 (class 2606 OID 39962)
-- Name: bpm_proc_task_user_link fk_bptul_proc_task; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task_user_link
    ADD CONSTRAINT fk_bptul_proc_task FOREIGN KEY (proc_task_id) REFERENCES bpm_proc_task(id);


--
-- TOC entry 2727 (class 2606 OID 39967)
-- Name: bpm_proc_task_user_link fk_bptul_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY bpm_proc_task_user_link
    ADD CONSTRAINT fk_bptul_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2754 (class 2606 OID 40402)
-- Name: pm_project_goal fk_pm_project_goal_company_goal; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_goal
    ADD CONSTRAINT fk_pm_project_goal_company_goal FOREIGN KEY (company_goal_id) REFERENCES pm_company_goal(id);


--
-- TOC entry 2755 (class 2606 OID 40407)
-- Name: pm_project_goal fk_pm_project_goal_project; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_goal
    ADD CONSTRAINT fk_pm_project_goal_project FOREIGN KEY (project_id) REFERENCES pm_project(id);


--
-- TOC entry 2751 (class 2606 OID 40384)
-- Name: pm_project fk_pm_project_manager; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project
    ADD CONSTRAINT fk_pm_project_manager FOREIGN KEY (manager_id) REFERENCES sec_user(id);


--
-- TOC entry 2753 (class 2606 OID 40395)
-- Name: pm_task fk_pm_task_executor; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_task
    ADD CONSTRAINT fk_pm_task_executor FOREIGN KEY (executor_id) REFERENCES sec_user(id);


--
-- TOC entry 2752 (class 2606 OID 40390)
-- Name: pm_task fk_pm_task_project; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_task
    ADD CONSTRAINT fk_pm_task_project FOREIGN KEY (project_id) REFERENCES pm_project(id);


--
-- TOC entry 2756 (class 2606 OID 40414)
-- Name: pm_project_user_link fk_ppul_project; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_user_link
    ADD CONSTRAINT fk_ppul_project FOREIGN KEY (project_id) REFERENCES pm_project(id);


--
-- TOC entry 2757 (class 2606 OID 40419)
-- Name: pm_project_user_link fk_ppul_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY pm_project_user_link
    ADD CONSTRAINT fk_ppul_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2694 (class 2606 OID 39560)
-- Name: sec_entity_log_attr fk_sec_entity_log_attr_item; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_entity_log_attr
    ADD CONSTRAINT fk_sec_entity_log_attr_item FOREIGN KEY (item_id) REFERENCES sec_entity_log(id);


--
-- TOC entry 2693 (class 2606 OID 39543)
-- Name: sec_entity_log fk_sec_entity_log_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_entity_log
    ADD CONSTRAINT fk_sec_entity_log_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2695 (class 2606 OID 39574)
-- Name: sec_filter fk_sec_filter_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_filter
    ADD CONSTRAINT fk_sec_filter_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2703 (class 2606 OID 39663)
-- Name: sec_screen_history fk_sec_history_substituted_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_screen_history
    ADD CONSTRAINT fk_sec_history_substituted_user FOREIGN KEY (substituted_user_id) REFERENCES sec_user(id);


--
-- TOC entry 2702 (class 2606 OID 39658)
-- Name: sec_screen_history fk_sec_history_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_screen_history
    ADD CONSTRAINT fk_sec_history_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2692 (class 2606 OID 39529)
-- Name: sec_logged_attr fk_sec_logged_attr_entity; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_logged_attr
    ADD CONSTRAINT fk_sec_logged_attr_entity FOREIGN KEY (entity_id) REFERENCES sec_logged_entity(id);


--
-- TOC entry 2711 (class 2606 OID 39794)
-- Name: sec_remember_me fk_sec_remember_me_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_remember_me
    ADD CONSTRAINT fk_sec_remember_me_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2699 (class 2606 OID 39625)
-- Name: sec_search_folder fk_sec_search_folder_folder; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_search_folder
    ADD CONSTRAINT fk_sec_search_folder_folder FOREIGN KEY (folder_id) REFERENCES sys_folder(id);


--
-- TOC entry 2701 (class 2606 OID 39635)
-- Name: sec_search_folder fk_sec_search_folder_presentation; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_search_folder
    ADD CONSTRAINT fk_sec_search_folder_presentation FOREIGN KEY (presentation_id) REFERENCES sec_presentation(id) ON DELETE SET NULL;


--
-- TOC entry 2700 (class 2606 OID 39630)
-- Name: sec_search_folder fk_sec_search_folder_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_search_folder
    ADD CONSTRAINT fk_sec_search_folder_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2691 (class 2606 OID 39509)
-- Name: sec_user_substitution fk_sec_user_substitution_substituted_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_substitution
    ADD CONSTRAINT fk_sec_user_substitution_substituted_user FOREIGN KEY (substituted_user_id) REFERENCES sec_user(id);


--
-- TOC entry 2690 (class 2606 OID 39504)
-- Name: sec_user_substitution fk_sec_user_substitution_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_substitution
    ADD CONSTRAINT fk_sec_user_substitution_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2697 (class 2606 OID 39598)
-- Name: sys_app_folder fk_sys_app_folder_folder; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_app_folder
    ADD CONSTRAINT fk_sys_app_folder_folder FOREIGN KEY (folder_id) REFERENCES sys_folder(id);


--
-- TOC entry 2707 (class 2606 OID 39713)
-- Name: sys_entity_snapshot fk_sys_entity_snapshot_author_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_entity_snapshot
    ADD CONSTRAINT fk_sys_entity_snapshot_author_id FOREIGN KEY (author_id) REFERENCES sec_user(id);


--
-- TOC entry 2696 (class 2606 OID 39585)
-- Name: sys_folder fk_sys_folder_parent; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_folder
    ADD CONSTRAINT fk_sys_folder_parent FOREIGN KEY (parent_id) REFERENCES sys_folder(id);


--
-- TOC entry 2706 (class 2606 OID 39699)
-- Name: sys_sending_attachment fk_sys_sending_attachment_content_file; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_sending_attachment
    ADD CONSTRAINT fk_sys_sending_attachment_content_file FOREIGN KEY (content_file_id) REFERENCES sys_file(id);


--
-- TOC entry 2705 (class 2606 OID 39694)
-- Name: sys_sending_attachment fk_sys_sending_attachment_sending_message; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_sending_attachment
    ADD CONSTRAINT fk_sys_sending_attachment_sending_message FOREIGN KEY (message_id) REFERENCES sys_sending_message(id);


--
-- TOC entry 2704 (class 2606 OID 39678)
-- Name: sys_sending_message fk_sys_sending_message_content_file; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_sending_message
    ADD CONSTRAINT fk_sys_sending_message_content_file FOREIGN KEY (content_text_file_id) REFERENCES sys_file(id);


--
-- TOC entry 2687 (class 2606 OID 39464)
-- Name: sec_constraint sec_constraint_group; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_constraint
    ADD CONSTRAINT sec_constraint_group FOREIGN KEY (group_id) REFERENCES sec_group(id);


--
-- TOC entry 2681 (class 2606 OID 39402)
-- Name: sec_group_hierarchy sec_group_hierarchy_group; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_group_hierarchy
    ADD CONSTRAINT sec_group_hierarchy_group FOREIGN KEY (group_id) REFERENCES sec_group(id);


--
-- TOC entry 2682 (class 2606 OID 39407)
-- Name: sec_group_hierarchy sec_group_hierarchy_parent; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_group_hierarchy
    ADD CONSTRAINT sec_group_hierarchy_parent FOREIGN KEY (parent_id) REFERENCES sec_group(id);


--
-- TOC entry 2680 (class 2606 OID 39391)
-- Name: sec_group sec_group_parent; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_group
    ADD CONSTRAINT sec_group_parent FOREIGN KEY (parent_id) REFERENCES sec_group(id);


--
-- TOC entry 2686 (class 2606 OID 39447)
-- Name: sec_permission sec_permission_role; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_permission
    ADD CONSTRAINT sec_permission_role FOREIGN KEY (role_id) REFERENCES sec_role(id);


--
-- TOC entry 2698 (class 2606 OID 39611)
-- Name: sec_presentation sec_presentation_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_presentation
    ADD CONSTRAINT sec_presentation_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2688 (class 2606 OID 39478)
-- Name: sec_session_attr sec_session_attr_group; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_session_attr
    ADD CONSTRAINT sec_session_attr_group FOREIGN KEY (group_id) REFERENCES sec_group(id);


--
-- TOC entry 2683 (class 2606 OID 39420)
-- Name: sec_user sec_user_group; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user
    ADD CONSTRAINT sec_user_group FOREIGN KEY (group_id) REFERENCES sec_group(id);


--
-- TOC entry 2684 (class 2606 OID 39431)
-- Name: sec_user_role sec_user_role_profile; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_profile FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2685 (class 2606 OID 39436)
-- Name: sec_user_role sec_user_role_role; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_role
    ADD CONSTRAINT sec_user_role_role FOREIGN KEY (role_id) REFERENCES sec_role(id);


--
-- TOC entry 2689 (class 2606 OID 39494)
-- Name: sec_user_setting sec_user_setting_user; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sec_user_setting
    ADD CONSTRAINT sec_user_setting_user FOREIGN KEY (user_id) REFERENCES sec_user(id);


--
-- TOC entry 2710 (class 2606 OID 39759)
-- Name: sys_attr_value sys_attr_value_attr_value_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_attr_value
    ADD CONSTRAINT sys_attr_value_attr_value_parent_id FOREIGN KEY (parent_id) REFERENCES sys_attr_value(id);


--
-- TOC entry 2709 (class 2606 OID 39754)
-- Name: sys_attr_value sys_attr_value_category_attr_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_attr_value
    ADD CONSTRAINT sys_attr_value_category_attr_id FOREIGN KEY (category_attr_id) REFERENCES sys_category_attr(id);


--
-- TOC entry 2708 (class 2606 OID 39739)
-- Name: sys_category_attr sys_category_attr_category_id; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_category_attr
    ADD CONSTRAINT sys_category_attr_category_id FOREIGN KEY (category_id) REFERENCES sys_category(id);


--
-- TOC entry 2679 (class 2606 OID 39370)
-- Name: sys_scheduled_execution sys_scheduled_execution_task; Type: FK CONSTRAINT; Schema: public; Owner: cuba
--

ALTER TABLE ONLY sys_scheduled_execution
    ADD CONSTRAINT sys_scheduled_execution_task FOREIGN KEY (task_id) REFERENCES sys_scheduled_task(id);


-- Completed on 2017-06-09 14:04:49

--
-- PostgreSQL database dump complete
--

