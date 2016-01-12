--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: substring_for_date(timestamp without time zone, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION substring_for_date(timestamp without time zone, integer, integer) RETURNS text
    LANGUAGE sql
    AS $_$SELECT SUBSTRING(CAST($1 AS text), $2, $3)$_$;


ALTER FUNCTION public.substring_for_date(timestamp without time zone, integer, integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ttrss_access_keys; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_access_keys (
    id integer NOT NULL,
    access_key character varying(250) NOT NULL,
    feed_id character varying(250) NOT NULL,
    is_cat boolean DEFAULT false NOT NULL,
    owner_uid integer NOT NULL
);


ALTER TABLE ttrss_access_keys OWNER TO postgres;

--
-- Name: ttrss_access_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_access_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_access_keys_id_seq OWNER TO postgres;

--
-- Name: ttrss_access_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_access_keys_id_seq OWNED BY ttrss_access_keys.id;


--
-- Name: ttrss_archived_feeds; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_archived_feeds (
    id integer NOT NULL,
    owner_uid integer NOT NULL,
    title character varying(200) NOT NULL,
    feed_url text NOT NULL,
    site_url character varying(250) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE ttrss_archived_feeds OWNER TO postgres;

--
-- Name: ttrss_cat_counters_cache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_cat_counters_cache (
    feed_id integer NOT NULL,
    owner_uid integer NOT NULL,
    updated timestamp without time zone NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


ALTER TABLE ttrss_cat_counters_cache OWNER TO postgres;

--
-- Name: ttrss_counters_cache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_counters_cache (
    feed_id integer NOT NULL,
    owner_uid integer NOT NULL,
    updated timestamp without time zone NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


ALTER TABLE ttrss_counters_cache OWNER TO postgres;

--
-- Name: ttrss_enclosures; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_enclosures (
    id integer NOT NULL,
    content_url text NOT NULL,
    content_type character varying(250) NOT NULL,
    title text NOT NULL,
    duration text NOT NULL,
    width integer DEFAULT 0 NOT NULL,
    height integer DEFAULT 0 NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE ttrss_enclosures OWNER TO postgres;

--
-- Name: ttrss_enclosures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_enclosures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_enclosures_id_seq OWNER TO postgres;

--
-- Name: ttrss_enclosures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_enclosures_id_seq OWNED BY ttrss_enclosures.id;


--
-- Name: ttrss_entries; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_entries (
    id integer NOT NULL,
    title text NOT NULL,
    guid text NOT NULL,
    link text NOT NULL,
    updated timestamp without time zone NOT NULL,
    content text NOT NULL,
    content_hash character varying(250) NOT NULL,
    cached_content text,
    no_orig_date boolean DEFAULT false NOT NULL,
    date_entered timestamp without time zone NOT NULL,
    date_updated timestamp without time zone NOT NULL,
    num_comments integer DEFAULT 0 NOT NULL,
    comments character varying(250) DEFAULT ''::character varying NOT NULL,
    plugin_data text,
    tsvector_combined tsvector,
    lang character varying(2),
    author character varying(250) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE ttrss_entries OWNER TO postgres;

--
-- Name: ttrss_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_entries_id_seq OWNER TO postgres;

--
-- Name: ttrss_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_entries_id_seq OWNED BY ttrss_entries.id;


--
-- Name: ttrss_entry_comments; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_entry_comments (
    id integer NOT NULL,
    ref_id integer NOT NULL,
    owner_uid integer NOT NULL,
    private boolean DEFAULT false NOT NULL,
    date_entered timestamp without time zone NOT NULL
);


ALTER TABLE ttrss_entry_comments OWNER TO postgres;

--
-- Name: ttrss_entry_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_entry_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_entry_comments_id_seq OWNER TO postgres;

--
-- Name: ttrss_entry_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_entry_comments_id_seq OWNED BY ttrss_entry_comments.id;


--
-- Name: ttrss_error_log; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_error_log (
    id integer NOT NULL,
    owner_uid integer,
    errno integer NOT NULL,
    errstr text NOT NULL,
    filename text NOT NULL,
    lineno integer NOT NULL,
    context text NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE ttrss_error_log OWNER TO postgres;

--
-- Name: ttrss_error_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_error_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_error_log_id_seq OWNER TO postgres;

--
-- Name: ttrss_error_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_error_log_id_seq OWNED BY ttrss_error_log.id;


--
-- Name: ttrss_feed_categories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_feed_categories (
    id integer NOT NULL,
    owner_uid integer NOT NULL,
    collapsed boolean DEFAULT false NOT NULL,
    order_id integer DEFAULT 0 NOT NULL,
    view_settings character varying(250) DEFAULT ''::character varying NOT NULL,
    parent_cat integer,
    title character varying(200) NOT NULL
);


ALTER TABLE ttrss_feed_categories OWNER TO postgres;

--
-- Name: ttrss_feed_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_feed_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_feed_categories_id_seq OWNER TO postgres;

--
-- Name: ttrss_feed_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_feed_categories_id_seq OWNED BY ttrss_feed_categories.id;


--
-- Name: ttrss_feedbrowser_cache; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_feedbrowser_cache (
    feed_url text NOT NULL,
    title text NOT NULL,
    site_url text NOT NULL,
    subscribers integer NOT NULL
);


ALTER TABLE ttrss_feedbrowser_cache OWNER TO postgres;

--
-- Name: ttrss_feeds; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_feeds (
    id integer NOT NULL,
    owner_uid integer NOT NULL,
    title character varying(200) NOT NULL,
    cat_id integer,
    feed_url text NOT NULL,
    icon_url character varying(250) DEFAULT ''::character varying NOT NULL,
    update_interval integer DEFAULT 0 NOT NULL,
    purge_interval integer DEFAULT 0 NOT NULL,
    last_updated timestamp without time zone,
    last_error text DEFAULT ''::text NOT NULL,
    favicon_avg_color character varying(11) DEFAULT NULL::character varying,
    site_url character varying(250) DEFAULT ''::character varying NOT NULL,
    auth_login character varying(250) DEFAULT ''::character varying NOT NULL,
    parent_feed integer,
    private boolean DEFAULT false NOT NULL,
    auth_pass character varying(250) DEFAULT ''::character varying NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    include_in_digest boolean DEFAULT true NOT NULL,
    rtl_content boolean DEFAULT false NOT NULL,
    cache_images boolean DEFAULT false NOT NULL,
    hide_images boolean DEFAULT false NOT NULL,
    cache_content boolean DEFAULT false NOT NULL,
    last_viewed timestamp without time zone,
    last_update_started timestamp without time zone,
    update_method integer DEFAULT 0 NOT NULL,
    always_display_enclosures boolean DEFAULT false NOT NULL,
    order_id integer DEFAULT 0 NOT NULL,
    mark_unread_on_update boolean DEFAULT false NOT NULL,
    update_on_checksum_change boolean DEFAULT false NOT NULL,
    strip_images boolean DEFAULT false NOT NULL,
    view_settings character varying(250) DEFAULT ''::character varying NOT NULL,
    pubsub_state integer DEFAULT 0 NOT NULL,
    favicon_last_checked timestamp without time zone,
    feed_language character varying(100) DEFAULT ''::character varying NOT NULL,
    auth_pass_encrypted boolean DEFAULT false NOT NULL
);


ALTER TABLE ttrss_feeds OWNER TO postgres;

--
-- Name: ttrss_feeds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_feeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_feeds_id_seq OWNER TO postgres;

--
-- Name: ttrss_feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_feeds_id_seq OWNED BY ttrss_feeds.id;


--
-- Name: ttrss_filter_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_filter_actions (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    description character varying(250) NOT NULL
);


ALTER TABLE ttrss_filter_actions OWNER TO postgres;

--
-- Name: ttrss_filter_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_filter_types (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    description character varying(250) NOT NULL
);


ALTER TABLE ttrss_filter_types OWNER TO postgres;

--
-- Name: ttrss_filters2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_filters2 (
    id integer NOT NULL,
    owner_uid integer NOT NULL,
    match_any_rule boolean DEFAULT false NOT NULL,
    inverse boolean DEFAULT false NOT NULL,
    title character varying(250) DEFAULT ''::character varying NOT NULL,
    order_id integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE ttrss_filters2 OWNER TO postgres;

--
-- Name: ttrss_filters2_actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_filters2_actions (
    id integer NOT NULL,
    filter_id integer NOT NULL,
    action_id integer DEFAULT 1 NOT NULL,
    action_param character varying(250) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE ttrss_filters2_actions OWNER TO postgres;

--
-- Name: ttrss_filters2_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_filters2_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_filters2_actions_id_seq OWNER TO postgres;

--
-- Name: ttrss_filters2_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_filters2_actions_id_seq OWNED BY ttrss_filters2_actions.id;


--
-- Name: ttrss_filters2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_filters2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_filters2_id_seq OWNER TO postgres;

--
-- Name: ttrss_filters2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_filters2_id_seq OWNED BY ttrss_filters2.id;


--
-- Name: ttrss_filters2_rules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_filters2_rules (
    id integer NOT NULL,
    filter_id integer NOT NULL,
    reg_exp character varying(250) NOT NULL,
    inverse boolean DEFAULT false NOT NULL,
    filter_type integer NOT NULL,
    feed_id integer,
    cat_id integer,
    cat_filter boolean DEFAULT false NOT NULL
);


ALTER TABLE ttrss_filters2_rules OWNER TO postgres;

--
-- Name: ttrss_filters2_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_filters2_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_filters2_rules_id_seq OWNER TO postgres;

--
-- Name: ttrss_filters2_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_filters2_rules_id_seq OWNED BY ttrss_filters2_rules.id;


--
-- Name: ttrss_labels2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_labels2 (
    id integer NOT NULL,
    owner_uid integer NOT NULL,
    fg_color character varying(15) DEFAULT ''::character varying NOT NULL,
    bg_color character varying(15) DEFAULT ''::character varying NOT NULL,
    caption character varying(250) NOT NULL
);


ALTER TABLE ttrss_labels2 OWNER TO postgres;

--
-- Name: ttrss_labels2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_labels2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_labels2_id_seq OWNER TO postgres;

--
-- Name: ttrss_labels2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_labels2_id_seq OWNED BY ttrss_labels2.id;


--
-- Name: ttrss_linked_feeds; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_linked_feeds (
    feed_url text NOT NULL,
    site_url text NOT NULL,
    title text NOT NULL,
    created timestamp without time zone NOT NULL,
    updated timestamp without time zone NOT NULL,
    instance_id integer NOT NULL,
    subscribers integer NOT NULL
);


ALTER TABLE ttrss_linked_feeds OWNER TO postgres;

--
-- Name: ttrss_linked_instances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_linked_instances (
    id integer NOT NULL,
    last_connected timestamp without time zone NOT NULL,
    last_status_in integer NOT NULL,
    last_status_out integer NOT NULL,
    access_key character varying(250) NOT NULL,
    access_url text NOT NULL
);


ALTER TABLE ttrss_linked_instances OWNER TO postgres;

--
-- Name: ttrss_linked_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_linked_instances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_linked_instances_id_seq OWNER TO postgres;

--
-- Name: ttrss_linked_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_linked_instances_id_seq OWNED BY ttrss_linked_instances.id;


--
-- Name: ttrss_plugin_storage; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_plugin_storage (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    owner_uid integer NOT NULL,
    content text NOT NULL
);


ALTER TABLE ttrss_plugin_storage OWNER TO postgres;

--
-- Name: ttrss_plugin_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_plugin_storage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_plugin_storage_id_seq OWNER TO postgres;

--
-- Name: ttrss_plugin_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_plugin_storage_id_seq OWNED BY ttrss_plugin_storage.id;


--
-- Name: ttrss_prefs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_prefs (
    pref_name character varying(250) NOT NULL,
    type_id integer NOT NULL,
    section_id integer DEFAULT 1 NOT NULL,
    access_level integer DEFAULT 0 NOT NULL,
    def_value text NOT NULL
);


ALTER TABLE ttrss_prefs OWNER TO postgres;

--
-- Name: ttrss_prefs_sections; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_prefs_sections (
    id integer NOT NULL,
    order_id integer NOT NULL,
    section_name character varying(100) NOT NULL
);


ALTER TABLE ttrss_prefs_sections OWNER TO postgres;

--
-- Name: ttrss_prefs_types; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_prefs_types (
    id integer NOT NULL,
    type_name character varying(100) NOT NULL
);


ALTER TABLE ttrss_prefs_types OWNER TO postgres;

--
-- Name: ttrss_sessions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_sessions (
    id character varying(250) NOT NULL,
    data text,
    expire integer NOT NULL
);


ALTER TABLE ttrss_sessions OWNER TO postgres;

--
-- Name: ttrss_settings_profiles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_settings_profiles (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    owner_uid integer NOT NULL
);


ALTER TABLE ttrss_settings_profiles OWNER TO postgres;

--
-- Name: ttrss_settings_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_settings_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_settings_profiles_id_seq OWNER TO postgres;

--
-- Name: ttrss_settings_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_settings_profiles_id_seq OWNED BY ttrss_settings_profiles.id;


--
-- Name: ttrss_tags; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_tags (
    id integer NOT NULL,
    tag_name character varying(250) NOT NULL,
    owner_uid integer NOT NULL,
    post_int_id integer NOT NULL
);


ALTER TABLE ttrss_tags OWNER TO postgres;

--
-- Name: ttrss_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_tags_id_seq OWNER TO postgres;

--
-- Name: ttrss_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_tags_id_seq OWNED BY ttrss_tags.id;


--
-- Name: ttrss_user_entries; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_user_entries (
    int_id integer NOT NULL,
    ref_id integer NOT NULL,
    uuid character varying(200) NOT NULL,
    feed_id integer,
    orig_feed_id integer,
    owner_uid integer NOT NULL,
    marked boolean DEFAULT false NOT NULL,
    published boolean DEFAULT false NOT NULL,
    tag_cache text NOT NULL,
    label_cache text NOT NULL,
    last_read timestamp without time zone,
    score integer DEFAULT 0 NOT NULL,
    last_marked timestamp without time zone,
    last_published timestamp without time zone,
    note text,
    unread boolean DEFAULT true NOT NULL
);


ALTER TABLE ttrss_user_entries OWNER TO postgres;

--
-- Name: ttrss_user_entries_int_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_user_entries_int_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_user_entries_int_id_seq OWNER TO postgres;

--
-- Name: ttrss_user_entries_int_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_user_entries_int_id_seq OWNED BY ttrss_user_entries.int_id;


--
-- Name: ttrss_user_labels2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_user_labels2 (
    label_id integer NOT NULL,
    article_id integer NOT NULL
);


ALTER TABLE ttrss_user_labels2 OWNER TO postgres;

--
-- Name: ttrss_user_prefs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_user_prefs (
    owner_uid integer NOT NULL,
    pref_name character varying(250) NOT NULL,
    profile integer,
    value text NOT NULL
);


ALTER TABLE ttrss_user_prefs OWNER TO postgres;

--
-- Name: ttrss_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_users (
    id integer NOT NULL,
    login character varying(120) NOT NULL,
    pwd_hash character varying(250) NOT NULL,
    last_login timestamp without time zone,
    access_level integer DEFAULT 0 NOT NULL,
    email character varying(250) DEFAULT ''::character varying NOT NULL,
    full_name character varying(250) DEFAULT ''::character varying NOT NULL,
    email_digest boolean DEFAULT false NOT NULL,
    last_digest_sent timestamp without time zone,
    salt character varying(250) DEFAULT ''::character varying NOT NULL,
    twitter_oauth text,
    otp_enabled boolean DEFAULT false NOT NULL,
    resetpass_token character varying(250) DEFAULT NULL::character varying,
    created timestamp without time zone
);


ALTER TABLE ttrss_users OWNER TO postgres;

--
-- Name: ttrss_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ttrss_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ttrss_users_id_seq OWNER TO postgres;

--
-- Name: ttrss_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ttrss_users_id_seq OWNED BY ttrss_users.id;


--
-- Name: ttrss_version; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ttrss_version (
    schema_version integer NOT NULL
);


ALTER TABLE ttrss_version OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_access_keys ALTER COLUMN id SET DEFAULT nextval('ttrss_access_keys_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_enclosures ALTER COLUMN id SET DEFAULT nextval('ttrss_enclosures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_entries ALTER COLUMN id SET DEFAULT nextval('ttrss_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_entry_comments ALTER COLUMN id SET DEFAULT nextval('ttrss_entry_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_error_log ALTER COLUMN id SET DEFAULT nextval('ttrss_error_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feed_categories ALTER COLUMN id SET DEFAULT nextval('ttrss_feed_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feeds ALTER COLUMN id SET DEFAULT nextval('ttrss_feeds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2 ALTER COLUMN id SET DEFAULT nextval('ttrss_filters2_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_actions ALTER COLUMN id SET DEFAULT nextval('ttrss_filters2_actions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_rules ALTER COLUMN id SET DEFAULT nextval('ttrss_filters2_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_labels2 ALTER COLUMN id SET DEFAULT nextval('ttrss_labels2_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_linked_instances ALTER COLUMN id SET DEFAULT nextval('ttrss_linked_instances_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_plugin_storage ALTER COLUMN id SET DEFAULT nextval('ttrss_plugin_storage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_settings_profiles ALTER COLUMN id SET DEFAULT nextval('ttrss_settings_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_tags ALTER COLUMN id SET DEFAULT nextval('ttrss_tags_id_seq'::regclass);


--
-- Name: int_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_entries ALTER COLUMN int_id SET DEFAULT nextval('ttrss_user_entries_int_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_users ALTER COLUMN id SET DEFAULT nextval('ttrss_users_id_seq'::regclass);


--
-- Data for Name: ttrss_access_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Name: ttrss_access_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_access_keys_id_seq', 1, false);


--
-- Data for Name: ttrss_archived_feeds; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_cat_counters_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_counters_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_enclosures; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_enclosures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_enclosures_id_seq', 1, false);

--
-- Data for Name: ttrss_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_entries_id_seq', 1, false);

--
-- Data for Name: ttrss_entry_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Name: ttrss_entry_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_entry_comments_id_seq', 1, false);


--
-- Data for Name: ttrss_error_log; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Name: ttrss_error_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_error_log_id_seq', 1, false);


--
-- Data for Name: ttrss_feed_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_feed_categories VALUES (205, 1, false, 89, '', 62, 'Lubbock, TX');
INSERT INTO ttrss_feed_categories VALUES (212, 1, false, 1, '', NULL, 'States');
INSERT INTO ttrss_feed_categories VALUES (204, 1, false, 0, '', 62, 'Winston-Salem, NC');
INSERT INTO ttrss_feed_categories VALUES (200, 1, false, 2, '', 62, 'Glendale, AZ');
INSERT INTO ttrss_feed_categories VALUES (202, 1, false, 3, '', 62, 'Garland, TX');
INSERT INTO ttrss_feed_categories VALUES (192, 1, false, 4, '', 62, 'Irving, TX');
INSERT INTO ttrss_feed_categories VALUES (193, 1, false, 5, '', 62, 'Chesapeake, VA');
INSERT INTO ttrss_feed_categories VALUES (195, 1, false, 6, '', 62, 'Baton Rouge, LA');
INSERT INTO ttrss_feed_categories VALUES (196, 1, false, 7, '', 62, 'Reno, NV');
INSERT INTO ttrss_feed_categories VALUES (194, 1, false, 9, '', 62, 'Irvine, CA');
INSERT INTO ttrss_feed_categories VALUES (187, 1, false, 10, '', 62, 'Gilbert, AZ');
INSERT INTO ttrss_feed_categories VALUES (190, 1, false, 11, '', 62, 'Scottsdale, AZ');
INSERT INTO ttrss_feed_categories VALUES (189, 1, false, 12, '', 62, 'Fremont, CA');
INSERT INTO ttrss_feed_categories VALUES (179, 1, false, 13, '', 62, 'Aurora, CO');
INSERT INTO ttrss_feed_categories VALUES (176, 1, false, 15, '', 62, 'Honolulu, HI');
INSERT INTO ttrss_feed_categories VALUES (180, 1, false, 17, '', 62, 'Santa Ana, CA');
INSERT INTO ttrss_feed_categories VALUES (178, 1, false, 18, '', 62, 'Anaheim, CA');
INSERT INTO ttrss_feed_categories VALUES (183, 1, false, 19, '', 62, 'Riverside, CA');
INSERT INTO ttrss_feed_categories VALUES (171, 1, false, 25, '', 62, 'Indianapolis, IN');
INSERT INTO ttrss_feed_categories VALUES (146, 1, false, 26, '', 62, 'San Jose, CA');
INSERT INTO ttrss_feed_categories VALUES (148, 1, false, 28, '', 62, 'Jacksonville, FL');
INSERT INTO ttrss_feed_categories VALUES (168, 1, false, 41, '', 62, 'Pittsburgh, PA');
INSERT INTO ttrss_feed_categories VALUES (164, 1, false, 42, '', 62, 'New Orleans, LA');
INSERT INTO ttrss_feed_categories VALUES (166, 1, false, 43, '', 62, 'Anchorage, AK');
INSERT INTO ttrss_feed_categories VALUES (161, 1, false, 44, '', 62, 'St. Paul, MN');
INSERT INTO ttrss_feed_categories VALUES (162, 1, false, 45, '', 62, 'Cincinnati, OH');
INSERT INTO ttrss_feed_categories VALUES (154, 1, false, 46, '', 62, 'Tulsa, OK');
INSERT INTO ttrss_feed_categories VALUES (163, 1, false, 47, '', 62, 'Arlington, TX');
INSERT INTO ttrss_feed_categories VALUES (159, 1, false, 48, '', 62, 'Newark, NJ');
INSERT INTO ttrss_feed_categories VALUES (155, 1, false, 49, '', 62, 'Greensboro, NC');
INSERT INTO ttrss_feed_categories VALUES (149, 1, false, 50, '', 62, 'Omaha, NE');
INSERT INTO ttrss_feed_categories VALUES (157, 1, false, 51, '', 62, 'Cleveland, OH');
INSERT INTO ttrss_feed_categories VALUES (143, 1, false, 52, '', 62, 'Henderson, NV');
INSERT INTO ttrss_feed_categories VALUES (169, 1, false, 53, '', 62, 'Bakersfield, CA');
INSERT INTO ttrss_feed_categories VALUES (203, 1, false, 88, '', 62, 'Madison, WI');
INSERT INTO ttrss_feed_categories VALUES (34, 1, false, 3, '', 2, 'Soccer');
INSERT INTO ttrss_feed_categories VALUES (136, 1, false, 20, '', 62, 'Philadelphia, PA');
INSERT INTO ttrss_feed_categories VALUES (30, 1, false, 4, '', 2, 'Hockey');
INSERT INTO ttrss_feed_categories VALUES (137, 1, false, 21, '', 62, 'Phoenix, AZ');
INSERT INTO ttrss_feed_categories VALUES (32, 1, false, 6, '', 2, 'Golf');
INSERT INTO ttrss_feed_categories VALUES (138, 1, false, 22, '', 62, 'San Antonio, TX');
INSERT INTO ttrss_feed_categories VALUES (33, 1, false, 7, '', 2, 'Winter Sports');
INSERT INTO ttrss_feed_categories VALUES (144, 1, false, 27, '', 62, 'Austin, TX');
INSERT INTO ttrss_feed_categories VALUES (60, 1, false, 8, '', 2, 'Extreme Sports');
INSERT INTO ttrss_feed_categories VALUES (150, 1, false, 30, '', 62, 'Columbus, OH');
INSERT INTO ttrss_feed_categories VALUES (59, 1, false, 9, '', 2, 'More Sports');
INSERT INTO ttrss_feed_categories VALUES (173, 1, false, 31, '', 62, 'Fort Worth, TX');
INSERT INTO ttrss_feed_categories VALUES (7, 1, false, 0, '', 5, 'US');
INSERT INTO ttrss_feed_categories VALUES (174, 1, false, 32, '', 62, 'Charlotte, NC');
INSERT INTO ttrss_feed_categories VALUES (36, 1, false, 1, '', 5, 'World');
INSERT INTO ttrss_feed_categories VALUES (175, 1, false, 33, '', 62, 'Detroit, MI');
INSERT INTO ttrss_feed_categories VALUES (37, 1, false, 2, '', 5, 'Politics');
INSERT INTO ttrss_feed_categories VALUES (142, 1, false, 34, '', 62, 'El Paso, TX');
INSERT INTO ttrss_feed_categories VALUES (38, 1, false, 3, '', 5, 'Business');
INSERT INTO ttrss_feed_categories VALUES (123, 1, false, 35, '', 62, 'Memphis, TN');
INSERT INTO ttrss_feed_categories VALUES (141, 1, false, 36, '', 62, 'Boston, MA');
INSERT INTO ttrss_feed_categories VALUES (39, 1, false, 4, '', 5, 'Tech');
INSERT INTO ttrss_feed_categories VALUES (160, 1, false, 37, '', 62, 'Toledo, OH');
INSERT INTO ttrss_feed_categories VALUES (167, 1, false, 38, '', 62, 'Lexington-Fayette, KY');
INSERT INTO ttrss_feed_categories VALUES (170, 1, false, 39, '', 62, 'Corpus Christi, TX');
INSERT INTO ttrss_feed_categories VALUES (165, 1, false, 40, '', 62, 'Stockton, CA');
INSERT INTO ttrss_feed_categories VALUES (156, 1, false, 54, '', 62, 'Minneapolis, MN');
INSERT INTO ttrss_feed_categories VALUES (130, 1, false, 75, '', 62, 'Seattle, WA');
INSERT INTO ttrss_feed_categories VALUES (129, 1, false, 76, '', 62, 'Colorado Springs, CO');
INSERT INTO ttrss_feed_categories VALUES (121, 1, false, 77, '', 62, 'Norfolk, VA');
INSERT INTO ttrss_feed_categories VALUES (177, 1, false, 78, '', 62, 'Birmingham, AL');
INSERT INTO ttrss_feed_categories VALUES (181, 1, false, 79, '', 62, 'Boise, ID');
INSERT INTO ttrss_feed_categories VALUES (206, 1, false, 90, '', 62, 'Providence, RI');
INSERT INTO ttrss_feed_categories VALUES (207, 1, false, 91, '', 62, 'Tucson, AZ');
INSERT INTO ttrss_feed_categories VALUES (208, 1, false, 92, '', 62, 'Fresno, CA');
INSERT INTO ttrss_feed_categories VALUES (209, 1, false, 93, '', 62, 'Long Beach, CA');
INSERT INTO ttrss_feed_categories VALUES (210, 1, false, 94, '', 62, 'Mesa, AZ');
INSERT INTO ttrss_feed_categories VALUES (211, 1, false, 95, '', 62, 'Virginia Beach, VA');
INSERT INTO ttrss_feed_categories VALUES (213, 1, false, 0, '', 45, 'Horoscope');
INSERT INTO ttrss_feed_categories VALUES (215, 1, false, 1, '', 45, 'TodayHistory');
INSERT INTO ttrss_feed_categories VALUES (214, 1, false, 2, '', 45, 'Quote');
INSERT INTO ttrss_feed_categories VALUES (29, 1, false, 2, '', 2, 'Basketball');
INSERT INTO ttrss_feed_categories VALUES (27, 1, false, 0, '', 2, 'Football');
INSERT INTO ttrss_feed_categories VALUES (28, 1, false, 1, '', 2, 'Baseball');
INSERT INTO ttrss_feed_categories VALUES (8, 1, false, 0, '', 4, 'Celebrity');
INSERT INTO ttrss_feed_categories VALUES (9, 1, false, 1, '', 4, 'Movies');
INSERT INTO ttrss_feed_categories VALUES (63, 1, false, 0, '', 212, 'California');
INSERT INTO ttrss_feed_categories VALUES (64, 1, false, 1, '', 212, 'Wisconsin');
INSERT INTO ttrss_feed_categories VALUES (67, 1, false, 2, '', 212, 'Texas');
INSERT INTO ttrss_feed_categories VALUES (68, 1, false, 3, '', 212, 'Florida');
INSERT INTO ttrss_feed_categories VALUES (66, 1, false, 1, '', 62, 'New York City, NY');
INSERT INTO ttrss_feed_categories VALUES (115, 1, false, 8, '', 62, 'Los Angeles, CA');
INSERT INTO ttrss_feed_categories VALUES (120, 1, false, 14, '', 62, 'Chicago, IL');
INSERT INTO ttrss_feed_categories VALUES (131, 1, false, 16, '', 62, 'Houston, TX');
INSERT INTO ttrss_feed_categories VALUES (125, 1, false, 23, '', 62, 'San Diego, CA');
INSERT INTO ttrss_feed_categories VALUES (134, 1, false, 24, '', 62, 'Dallas, TX');
INSERT INTO ttrss_feed_categories VALUES (118, 1, false, 29, '', 62, 'San Francisco, CA');
INSERT INTO ttrss_feed_categories VALUES (153, 1, false, 55, '', 62, 'Oakland, CA');
INSERT INTO ttrss_feed_categories VALUES (147, 1, false, 56, '', 62, 'Plano, TX');
INSERT INTO ttrss_feed_categories VALUES (145, 1, false, 59, '', 62, 'Raleigh, NC');
INSERT INTO ttrss_feed_categories VALUES (135, 1, false, 60, '', 62, 'Buffalo, NY');
INSERT INTO ttrss_feed_categories VALUES (172, 1, false, 61, '', 62, 'Tampa, FL');
INSERT INTO ttrss_feed_categories VALUES (140, 1, false, 62, '', 62, 'Lincoln, NE');
INSERT INTO ttrss_feed_categories VALUES (127, 1, false, 64, '', 62, 'Chula Vista, CA');
INSERT INTO ttrss_feed_categories VALUES (124, 1, false, 65, '', 62, 'St. Petersburg, FL');
INSERT INTO ttrss_feed_categories VALUES (119, 1, false, 66, '', 62, 'Sacramento, CA');
INSERT INTO ttrss_feed_categories VALUES (126, 1, false, 67, '', 62, 'Orlando, FL');
INSERT INTO ttrss_feed_categories VALUES (201, 1, false, 87, '', 62, 'Laredo, TX');
INSERT INTO ttrss_feed_categories VALUES (45, 1, false, 0, '', 3, 'Today');
INSERT INTO ttrss_feed_categories VALUES (19, 1, false, 2, '', 1, 'Fitness');
INSERT INTO ttrss_feed_categories VALUES (20, 1, false, 3, '', 1, 'Food & Drink');
INSERT INTO ttrss_feed_categories VALUES (21, 1, false, 4, '', 1, 'Home & Garden');
INSERT INTO ttrss_feed_categories VALUES (22, 1, false, 5, '', 1, 'Auto');
INSERT INTO ttrss_feed_categories VALUES (23, 1, false, 6, '', 1, 'Travel');
INSERT INTO ttrss_feed_categories VALUES (24, 1, false, 7, '', 1, 'Games');
INSERT INTO ttrss_feed_categories VALUES (25, 1, false, 8, '', 1, 'Books');
INSERT INTO ttrss_feed_categories VALUES (26, 1, false, 9, '', 1, 'Personal Finance');
INSERT INTO ttrss_feed_categories VALUES (1, 1, false, 4, '', NULL, 'products');
INSERT INTO ttrss_feed_categories VALUES (10, 1, false, 2, '', 4, 'TV');
INSERT INTO ttrss_feed_categories VALUES (16, 1, false, 3, '', 4, 'Music');
INSERT INTO ttrss_feed_categories VALUES (55, 1, false, 4, '', 4, 'Arts');
INSERT INTO ttrss_feed_categories VALUES (11, 1, false, 5, '', 4, 'Humor');
INSERT INTO ttrss_feed_categories VALUES (12, 1, false, 6, '', 4, 'Gaming');
INSERT INTO ttrss_feed_categories VALUES (13, 1, false, 7, '', 4, 'Viral');
INSERT INTO ttrss_feed_categories VALUES (58, 1, false, 8, '', 4, 'Trailers');
INSERT INTO ttrss_feed_categories VALUES (14, 1, false, 9, '', 4, 'Cool Ads');
INSERT INTO ttrss_feed_categories VALUES (4, 1, false, 0, '', NULL, 'entertainment');
INSERT INTO ttrss_feed_categories VALUES (74, 1, false, 4, '', 212, 'Arizona');
INSERT INTO ttrss_feed_categories VALUES (76, 1, false, 6, '', 212, 'Idaho');
INSERT INTO ttrss_feed_categories VALUES (100, 1, false, 9, '', 212, 'Pennsylvania');
INSERT INTO ttrss_feed_categories VALUES (98, 1, false, 10, '', 212, 'North Carolina');
INSERT INTO ttrss_feed_categories VALUES (71, 1, false, 12, '', 212, 'Utah');
INSERT INTO ttrss_feed_categories VALUES (77, 1, false, 13, '', 212, 'North Dakota');
INSERT INTO ttrss_feed_categories VALUES (122, 1, false, 57, '', 62, 'Atlanta, GA');
INSERT INTO ttrss_feed_categories VALUES (133, 1, false, 58, '', 62, 'Fort Wayne, IN');
INSERT INTO ttrss_feed_categories VALUES (128, 1, false, 63, '', 62, 'Jersey, NJ');
INSERT INTO ttrss_feed_categories VALUES (72, 1, false, 68, '', 62, 'Portland, OR');
INSERT INTO ttrss_feed_categories VALUES (70, 1, false, 69, '', 62, 'Las Vegas, NV');
INSERT INTO ttrss_feed_categories VALUES (114, 1, false, 74, '', 62, 'Washington D.C.');
INSERT INTO ttrss_feed_categories VALUES (31, 1, false, 5, '', 2, 'Tennis');
INSERT INTO ttrss_feed_categories VALUES (2, 1, false, 5, '', NULL, 'sports');
INSERT INTO ttrss_feed_categories VALUES (40, 1, false, 5, '', 5, 'Health');
INSERT INTO ttrss_feed_categories VALUES (41, 1, false, 6, '', 5, 'Science & Environment');
INSERT INTO ttrss_feed_categories VALUES (42, 1, false, 7, '', 5, 'Environment');
INSERT INTO ttrss_feed_categories VALUES (69, 1, false, 5, '', 212, 'Washington');
INSERT INTO ttrss_feed_categories VALUES (85, 1, false, 7, '', 212, 'Wyoming');
INSERT INTO ttrss_feed_categories VALUES (73, 1, false, 8, '', 212, 'Ohio');
INSERT INTO ttrss_feed_categories VALUES (93, 1, false, 11, '', 212, 'Michigan');
INSERT INTO ttrss_feed_categories VALUES (79, 1, false, 14, '', 212, 'Oklahoma');
INSERT INTO ttrss_feed_categories VALUES (80, 1, false, 15, '', 212, 'New Mexico');
INSERT INTO ttrss_feed_categories VALUES (92, 1, false, 16, '', 212, 'Indiana');
INSERT INTO ttrss_feed_categories VALUES (110, 1, false, 17, '', 212, 'Massachusetts');
INSERT INTO ttrss_feed_categories VALUES (83, 1, false, 70, '', 62, 'Kansas City, MO');
INSERT INTO ttrss_feed_categories VALUES (82, 1, false, 71, '', 62, 'Denver, CO');
INSERT INTO ttrss_feed_categories VALUES (95, 1, false, 72, '', 62, 'Louisville, KY');
INSERT INTO ttrss_feed_categories VALUES (106, 1, false, 73, '', 62, 'Baltimore, MD');
INSERT INTO ttrss_feed_categories VALUES (182, 1, false, 80, '', 62, 'St Louis, MO');
INSERT INTO ttrss_feed_categories VALUES (152, 1, false, 81, '', 62, 'Miami, FL');
INSERT INTO ttrss_feed_categories VALUES (185, 1, false, 82, '', 62, 'San Bernadino, CA');
INSERT INTO ttrss_feed_categories VALUES (186, 1, false, 83, '', 62, 'Nashville-Davidson, TN');
INSERT INTO ttrss_feed_categories VALUES (188, 1, false, 84, '', 62, 'Oklahoma City, OK');
INSERT INTO ttrss_feed_categories VALUES (191, 1, false, 85, '', 62, 'Milwaukee, WI');
INSERT INTO ttrss_feed_categories VALUES (198, 1, false, 86, '', 62, 'Albuquerque, NM');
INSERT INTO ttrss_feed_categories VALUES (62, 1, false, 2, '', NULL, 'MyLocal');
INSERT INTO ttrss_feed_categories VALUES (48, 1, false, 1, '', 3, 'Feel Good');
INSERT INTO ttrss_feed_categories VALUES (49, 1, false, 2, '', 3, 'Spirituality');
INSERT INTO ttrss_feed_categories VALUES (50, 1, false, 3, '', 3, 'Rumor/Scandal');
INSERT INTO ttrss_feed_categories VALUES (51, 1, false, 4, '', 3, 'Hobbies');
INSERT INTO ttrss_feed_categories VALUES (116, 1, false, 5, '', 3, 'Pets');
INSERT INTO ttrss_feed_categories VALUES (52, 1, false, 6, '', 3, 'Weird');
INSERT INTO ttrss_feed_categories VALUES (53, 1, false, 7, '', 3, 'Discovery');
INSERT INTO ttrss_feed_categories VALUES (3, 1, false, 3, '', NULL, 'extra');
INSERT INTO ttrss_feed_categories VALUES (17, 1, false, 0, '', 1, 'Electronics');
INSERT INTO ttrss_feed_categories VALUES (18, 1, false, 1, '', 1, 'Fashion');
INSERT INTO ttrss_feed_categories VALUES (43, 1, false, 8, '', 5, 'Media');
INSERT INTO ttrss_feed_categories VALUES (44, 1, false, 9, '', 5, 'Polls');
INSERT INTO ttrss_feed_categories VALUES (5, 1, false, 6, '', NULL, 'topstories');


--
-- Name: ttrss_feed_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_feed_categories_id_seq', 54, true);


--
-- Data for Name: ttrss_feedbrowser_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: ttrss_feeds; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_feeds VALUES (1240, 1, 'PGA.com', 32, 'http://www.pga.com/pgachampionship/rss', '', 0, 0, NULL, '', NULL, 'http://www.pga.com/pgachampionship/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (653, 1, 'Deadline', 9, 'http://deadline.com/feed/', '', 0, 0, NULL, '', NULL, 'http://deadline.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (130, 1, 'FOX', 41, 'http://feeds.foxnews.com/FOXNEWS/SCIENCE', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1103, 1, 'WTAE', 168, 'http://www.wtae.com/9682036?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.wtae.com/9682036', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (499, 1, 'WMAR Baltimore City', 106, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=30450', '', -1, 0, NULL, '', NULL, 'http://www.abc2news.com/baltimore-city', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (599, 1, 'Optimist World', 48, 'http://optimistworld.com/RssFeed.aspx?SectionId=1C848EEB-3E15-4C39-A4AA-F71880EFCD64&title=Optimist%20World%20|%20Good%20News&link=News.aspx', '', 0, 0, NULL, '', NULL, 'http://optimistworld.com/News.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (757, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/464881/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/sport/general/sailing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 57, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1267, 1, 'Yahoo Sports', 32, 'https://sports.yahoo.com/golf/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/golf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (639, 1, 'Release Music', 16, 'http://www.releasemagazine.net/category/news/feed/', '', 0, 0, NULL, '', NULL, 'http://www.releasemagazine.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1014, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/fish', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/fish/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 35, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1206, 1, 'Kansas City infoZine', 83, 'http://rss.infozine.com/kc/headlines.xml', '', 0, 0, NULL, '', NULL, 'http://www.infozine.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (115, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7014.xml', '', 0, 0, NULL, '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (170, 1, 'USA TODAY', 29, 'http://rssfeeds.usatoday.com/UsatodaycomNba-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (4, 1, 'CNN', 7, 'http://rss.cnn.com/rss/cnn_us.rss', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/US/index.html?eref=rss_us', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1165, 1, 'Reno Gazette-Journal', 196, 'http://rssfeeds.rgj.com/reno/news', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (768, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/cross-country-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 27, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (950, 1, 'Fashion - Los Angeles Times', 18, 'http://www.latimes.com/fashion/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/fashion/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (716, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/51', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/motocross', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 23, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (974, 1, 'Horoscope.com', 213, 'http://my.horoscope.com/astrology/daily-horoscopes-rss.html', '', 0, 0, NULL, '', NULL, 'http://www.horoscope.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (972, 1, 'Think Progress', 36, 'http://thinkprogress.org/world/issue/feed/', '', 0, 0, NULL, '', NULL, 'http://thinkprogress.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (242, 1, 'CBS Chicago Sports', 120, 'http://chicago.cbslocal.com/category/sports/feed/', '', 0, 0, NULL, '', NULL, 'http://chicago.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1256, 1, 'New York Times', 27, 'http://rss.nytimes.com/services/xml/rss/nyt/CollegeFootball.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/ncaafootball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (85, 1, 'CNN', 23, 'http://rss.cnn.com/RSS/CNN_TRAVEL.RSS', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/TRAVEL/index.html?eref=rss_travel', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (431, 1, 'ABC El Paso', 142, 'http://www.kvia.com/15160496?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kvia.com/15160496', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1032, 1, 'WESH', 126, 'http://www.wesh.com/11789118?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.wesh.com/11789118', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (405, 1, 'WCCB Sports', NULL, 'http://www.wccbcharlotte.com/sports/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.wccbcharlotte.com/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 37, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (888, 1, 'ABC News', 36, 'http://feeds.abcnews.com/abcnews/worldnewsheadlines', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/WN/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (239, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, NULL, '', NULL, 'http://www.nbcchicago.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (754, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/3795/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/sport/general/rugby-league/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 53, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1180, 1, 'Isthmus', 203, 'http://isthmus.com/api/rss/content.rss', '', 0, 0, NULL, '', NULL, 'http://isthmus.com/api/rss/content.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (680, 1, 'HuffPost', 51, 'http://www.huffingtonpost.com/news/gardening/feed//', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tag/gardening', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1091, 1, 'WLWT', 162, 'http://www.wlwt.com/9838828?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.wlwt.com/9838828', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (496, 1, 'WBAL TV', 106, 'http://www.wbaltv.com/video/topstory.rss', '', -1, 0, NULL, '', NULL, 'http://www.wbaltv.com/9380288', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1247, 1, 'Yahoo Sports', 27, 'https://sports.yahoo.com/ncaaf/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/ncaaf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1286, 1, 'Associated Press', 41, 'http://hosted2.ap.org/atom/APDEFAULT/b2f0ca3a594644ee9e50a8ec4ce2d6de', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1076, 1, 'Fox 23', 154, 'http://www.fox23.com/list/rss/news/local/local-news/aKzh/', '', 0, 0, NULL, '', NULL, 'http://www.fox23.com/list/news/local/local-news/aKzh/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (675, 1, 'FIVB', 59, 'http://www.fivb.org/vis/rss/press.aspx', '', 0, 0, NULL, '', NULL, 'http://www.fivb.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (294, 1, 'Dallas Morning News', 134, 'http://www.dallasnews.com/newskiosk/rss/dallasnewslifetravel.xml', '', -1, 0, NULL, '', NULL, 'http://www.dallasnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (586, 1, 'Food and Drink', 20, 'http://rss.feedsportal.com/c/266/f/3806/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/life-style/food-and-drink/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (18, 1, 'The Wrap', 8, 'http://www.thewrap.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.thewrap.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (877, 1, 'NYT', 36, 'http://rss.nytimes.com/services/xml/rss/nyt/World.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/world/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1173, 1, 'FOX 39 Laredo', 201, 'http://www.mylaredofox.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.mylaredofox.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (200, 1, 'New York Times', 66, 'http://rss.nytimes.com/services/xml/rss/nyt/NYRegion.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/nyregion/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (87, 1, 'Intelligent Travel', 23, 'http://feeds.feedburner.com/INTELLIGENTTRAVEL', '', 0, 0, NULL, '', NULL, 'http://intelligenttravel.nationalgeographic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1125, 1, 'Orange County News', 178, 'http://cdn.abclocal.go.com/kabc/xml?id=7095562', '', 0, 0, NULL, '', NULL, 'http://abclocal.go.com/kabc/channel?section=news/local/orange_county&id=7095562', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1031, 1, 'My News 13', 126, 'http://mynews13.com/content/news/cfnews13/feeds/rss.html/local-headlines.html', '', 0, 0, NULL, '', NULL, 'http://www.mynews13.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1224, 1, 'The Conscious Cat', 116, 'http://consciouscat.net/feed', '', 0, 0, NULL, '', NULL, 'http://consciouscat.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (839, 1, 'NPR', 36, 'http://www.npr.org/rss/rss.php?id=1004', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1004', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1044, 1, 'The Buffalo News', 135, 'http://www.buffalonews.com/section/rssGen?profileID=1016&profileName=City%20of%20Buffalo', '', 0, 0, NULL, '', NULL, 'http://www.buffalonews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (479, 1, 'ABC Boston', 141, 'http://www.wcvb.com/9849848?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.wcvb.com/9849848', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1234, 1, 'ProFootballTalk', 27, 'http://profootballtalk.nbcsports.com/category/rumor-mill/feed/atom/', '', 0, 0, NULL, '', NULL, 'http://profootballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (113, 1, 'CNN Money', 38, 'http://rss.cnn.com/rss/money_latest.rss', '', 0, 0, NULL, '', NULL, 'http://money.cnn.com/?section=money_latest', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1115, 1, 'Local News | MCA', 123, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=20000', '', 0, 0, NULL, '', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (373, 1, 'FT', 55, 'http://www.ft.com/rss/arts', '', 0, 0, NULL, '', NULL, 'http://www.ft.com/arts', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (497, 1, 'WBAL', 106, 'http://www.wbaltv.com/entertainment/topstory.rss', '', 0, 0, NULL, '', NULL, 'http://www.wbaltv.com/9380350', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (126, 1, 'NYT', 40, 'http://rss.nytimes.com/services/xml/rss/nyt/Health.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/health/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (222, 1, 'LA Daily News Sports', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000070&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (681, 1, 'Daily Mail', 51, 'http://www.dailymail.co.uk/home/gardening/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailymail.co.uk/home/gardening/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (535, 1, 'Las Vegas Sun', 70, 'http://www.lasvegassun.com/feeds/headlines/sports/', '', 0, 0, NULL, '', NULL, 'http://lasvegassun.com/news/sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (559, 1, 'Celeb Dirty Laundry', 50, 'http://feeds.feedburner.com/celebritydirtylaundry', '', 0, 0, NULL, '', NULL, 'http://www.celebdirtylaundry.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1110, 1, 'ABC 23', 169, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100001&categoryId=20000', '', 0, 0, NULL, '', NULL, 'http://www.turnto23.com/kelso-valley-manhunt', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1255, 1, 'New York Times', 27, 'http://rss.nytimes.com/services/xml/rss/nyt/ProFootball.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/football/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1161, 1, 'Irvine Community News', 194, 'https://www.irvinecommunitynewsandviews.org/feed/', '', 0, 0, NULL, '', NULL, 'https://www.irvinecommunitynewsandviews.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1287, 1, 'Associated Press', 52, 'http://hosted2.ap.org/atom/APDEFAULT/aa9398e6757a46fa93ed5dea7bd3729e', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (770, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/golf-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 31, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (573, 1, 'LA Times', 10, 'http://www.latimes.com/entertainment/tv/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/entertainment/tv/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (857, 1, 'House & Home', 21, 'http://houseandhome.com/rss/feeds', '', 0, 0, NULL, '', NULL, 'http://houseandhome.com/rss/feeds', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (811, 1, 'Bizjournals', 40, 'http://feeds.bizjournals.com/industry_6', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (843, 1, 'BBC', 37, 'http://feeds.bbci.co.uk/news/politics/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/news/politics/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (117, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7148.xml', '', 0, 0, NULL, '', NULL, 'http://online.wsj.com/article/business.html', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (774, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 34, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (966, 1, 'ABQJournal', 198, 'http://www.abqjournal.com/feed', '', 0, 0, NULL, '', NULL, 'http://www.abqjournal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (298, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/202495/sports-tsr?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.fox4news.com/category/202495/sports-tsr', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 43, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1171, 1, 'AZ Central', 137, 'http://rssfeeds.azcentral.com/phoenix/local', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (495, 1, 'Nashville Post', 186, 'https://www.nashvillepost.com/feed', '', 0, 0, NULL, '', NULL, 'https://www.nashvillepost.com/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (103, 1, 'Al Jazeera', 36, 'http://www.aljazeera.com/xml/rss/all.xml', '', 0, 0, NULL, '', NULL, 'http://www.aljazeera.com/default.html', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (982, 1, 'ABC', 71, 'http://abcnews.go.com/topics/urss?pageid=1085245', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (27, 1, 'Extra TV', 9, 'http://www.extratv.com/feeds/category/movie-trailers/rss.xml', '', 0, 0, NULL, '', NULL, 'http://extratv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (406, 1, 'Charlotte Observer', 174, 'http://www.charlotteobserver.com/sports/spt-columns-blogs/scott-fowler/?widgetName=rssfeed&widgetContentId=8167599&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.charlotteobserver.com/sports/spt-columns-blogs/scott-fowler/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (634, 1, 'NPR', 52, 'http://www.npr.org/rss/rss.php?id=1146', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1146', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1043, 1, 'Journal Gazette', 133, 'http://www.journalgazette.net/rss/', '', 0, 0, NULL, '', NULL, 'http://www.journalgazette.net/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (366, 1, 'ArtForum', 55, 'http://artforum.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://artforum.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (417, 1, 'WXYZ Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10004', '', 0, 0, NULL, '', NULL, 'http://www.wxyz.com/sports/live', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 34, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (597, 1, 'Los Angeles Business Journal', 63, 'http://labusinessjournal.com/rss/headlines/la-finance/', '', 0, 0, NULL, '', NULL, 'http://labusinessjournal.com/news/la-finance/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (558, 1, 'Honest Cooking', 51, 'http://honestcooking.com/feed/', '', 0, 0, NULL, '', NULL, 'http://honestcooking.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (167, 1, 'ESPN', 29, 'http://sports.espn.go.com/espn/rss/ncb/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (771, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/golf-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 38, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (547, 1, 'Perez Hilton', 50, 'http://img.perezhilton.com/?feed=rss2-featured', '', 0, 0, NULL, '', NULL, 'http://img.perezhilton.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (166, 1, 'ESPN', 29, 'http://sports.espn.go.com/espn/rss/nba/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (124, 1, 'BBC News', 39, 'http://feeds.bbci.co.uk/news/technology/rss.xml?edition=uk', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/news/technology/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1101, 1, 'WKYT', 167, 'http://www.wkyt.com/home/headlines/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.wkyt.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (553, 1, 'Hollywood Life', 50, 'http://www.hollywoodlife.net/feed', '', 0, 0, NULL, '', NULL, 'http://hollywoodlife.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1035, 1, 'NBC 7', 127, 'http://www.nbcsandiego.com/news/local/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcsandiego.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (878, 1, 'Slate Articles', 41, 'http://feeds.slate.com/slate-2093565', '', 0, 0, NULL, '', NULL, 'http://www.slate.com/articles/science/science.teaser.all.10.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1047, 1, 'Journal Star', 140, 'http://journalstar.com/search/?f=rss&t=article&c=news/local&l=25&s=start_time&sd=desc', '', 0, 0, NULL, '', NULL, 'http://journalstar.com/search/?f=rss&t=article&c=news/local&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1060, 1, 'News 4 Jax', 148, 'http://www.news4jax.com/4908618?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.news4jax.com/4908618', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1051, 1, 'Las Vegas Sun', 143, 'http://lasvegassun.com/feeds/headlines/henderson/', '', 0, 0, NULL, '', NULL, 'http://lasvegassun.com/news/henderson/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1083, 1, 'TWC News', 155, 'http://www.twcnews.com/services/contentfeed.nc.triad.news.top-stories.full.rss', '', 0, 0, NULL, '', NULL, 'http://www.twcnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1100, 1, 'CBS 11', 166, 'http://www.ktva.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.ktva.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1096, 1, 'Stockton News', 165, 'http://www.kcra.com/12970050?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kcra.com/12970050', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (111, 1, 'FOX News', 37, 'http://feeds.foxnews.com/foxnews/politics', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1036, 1, 'San Diego 6', 127, 'http://www.sandiego6.com/news/local/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.sandiego6.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (439, 1, 'MyFox Memphis Sports', 123, 'http://www.myfoxmemphis.com/category/230022/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxmemphis.com/category/230022/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (262, 1, 'SB Nation Philly', 100, 'http://philly.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://philly.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1214, 1, 'Daily Press', 211, 'http://dailypress.feedsportal.com/c/34257/f/623179/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailypress.com/news/hampton/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (978, 1, 'The Salt Lake Tribune', 71, 'http://www.sltrib.com/rss/feed/?sec=/News/&level=0', '', 0, 0, NULL, '', NULL, 'http://www.sltrib.com/News/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1098, 1, 'KTUU', 166, 'http://www.ktuu.com/news/news/21043664?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.ktuu.com/news/news/21043664', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (173, 1, 'FOX Sports', 30, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (276, 1, 'My SA', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Sports-921.php', '', 0, 0, NULL, '', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Sports-921.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 46, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1128, 1, 'Aurora Sentinel', 179, 'http://www.aurorasentinel.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.aurorasentinel.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (750, 1, 'The Independent', 33, 'http://rss.feedsportal.com/c/266/f/3861/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/travel/skiing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (62, 1, 'Tech2', 17, 'http://tech2.in.com/rssfeed/news.xml', '', 0, 0, NULL, '', NULL, 'http://tech.firstpost.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (863, 1, 'Extreme Tech', 24, 'http://www.extremetech.com/category/Gaming/feed', '', 0, 0, NULL, '', NULL, 'http://www.extremetech.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (738, 1, 'The Independent', 59, 'http://www.independent.co.uk/sport/rugby/rugby-union/rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/sport/rugby/rugby-union/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 54, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (243, 1, 'SB Nation Chicago', 120, 'http://chicago.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://chicago.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (536, 1, 'Vegas Sports Gab', 70, 'http://feeds.feedburner.com/VegasSportsGab?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.vegassportsgab.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (941, 1, 'Fandango', 58, 'http://www.fandango.com/rss/comingsoonmovies.rss', '', 0, 0, NULL, '', NULL, 'http://www.fandango.com/default.aspx?wssaffid=11839&wssac=123', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (13, 1, 'Cele|bitchy', 8, 'http://feeds.feedburner.com/Celebitchy', '', 0, 0, NULL, '', NULL, 'http://www.celebitchy.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1105, 1, 'CBS Pittsburgh', 168, 'http://pittsburgh.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://pittsburgh.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (442, 1, 'Local Memphis', 123, 'http://www2.localmemphis.com/rss/65.rss', '', 0, 0, NULL, '', NULL, 'http://www.localmemphis.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (475, 1, 'Boston Herald', 141, 'http://feeds.feedburner.com/bostonherald/', '', -1, 0, NULL, '', NULL, 'http://www.bostonherald.com/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1146, 1, 'Region Phoenix Metro | KNXV', 187, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10008&categoryId=20412', '', 0, 0, NULL, '', NULL, 'http://www.abc15.com/phoenixmetro', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (664, 1, 'Charlotte Area Sports Blog', 98, 'http://feeds.feedburner.com/CharlotteAreaSportsBlog?format=xml', '', 0, 0, NULL, '', NULL, 'http://charlotteprosports.blogspot.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1153, 1, 'Milwaukee Business Journal', 191, 'http://feeds.bizjournals.com/bizj_milwaukee', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1151, 1, 'JSOnline.com', 191, 'http://www.jsonline.com/rss/?c=y&path=%2Fnewswatch', '', 0, 0, NULL, '', NULL, 'http://www.jsonline.com/newswatch', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1149, 1, 'Channel 9 News', 188, 'http://www.news9.com/category/211667/news9com-news-rss?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.news9.com/category/211667/news9com-news-rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (657, 1, 'Good News Network', 48, 'http://www.goodnewsnetwork.org/feed/', '', 0, 0, NULL, '', NULL, 'http://www.goodnewsnetwork.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (476, 1, 'Boston Herald', 141, 'http://feeds.feedburner.com/bostonherald/entertainment/fashion/', '', 0, 0, NULL, '', NULL, 'http://www.bostonherald.com/feed/34', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (296, 1, 'Dallas Voice', 134, 'http://www.dallasvoice.com/feed', '', -1, 0, NULL, '', NULL, 'http://www.dallasvoice.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (57, 1, 'The GQ Eye', 18, 'http://www.gq.com/style/blogs/the-gq-eye/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.gq.com/style/blogs/the-gq-eye/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (930, 1, 'EDM Sauce', 16, 'http://www.edmsauce.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.edmsauce.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (544, 1, 'Religion Compass', 49, 'http://feeds.feedburner.com/ReligionCompassExchanges?format=xml', '', 0, 0, NULL, '', NULL, 'http://religion-compass.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (840, 1, 'Frieze Blog', 55, 'http://feeds.feedburner.com/FriezeBlog', '', 0, 0, NULL, '', NULL, 'http://blog.frieze.com/archive/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (458, 1, 'SB Nation Denver', 82, 'http://denver.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://denver.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (86, 1, 'BudgetTravel.com', 23, 'http://www.budgettravel.com/latest/features/feed/', '', 0, 0, NULL, '', NULL, 'http://www.budgettravel.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (335, 1, 'The Florida Times-Union', 68, 'http://feeds.jacksonville.com/JacksonvillecomSports?format=xml', '', 0, 0, NULL, '', NULL, 'http://jacksonville.com/taxonomy/term/1893/2', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (737, 1, 'The Independent', 39, 'http://rss.feedsportal.com/c/266/f/3821/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/life-style/gadgets-and-tech/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (308, 1, 'Mercury News', NULL, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200733.xml', '', 0, 0, NULL, '', NULL, 'http://www.mercurynews.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 23, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (849, 1, 'Food & Wine', 20, 'http://www.foodandwine.com/feeds/latest_articles', '', 0, 0, NULL, '', NULL, 'http://www.foodandwine.com/articles_feeds', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (600, 1, 'Positive News', 48, 'http://positivenews.org.uk/feed/', '', 0, 0, NULL, '', NULL, 'http://positivenews.org.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (118, 1, 'NBC', 38, 'http://feeds.nbcnews.com/feeds/business', '', 0, 0, NULL, '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (986, 1, 'KXLY.com', 76, 'http://www.kxly.com/?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kxly.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (428, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200808.xml', '', 0, 0, NULL, '', NULL, 'http://www.elpasotimes.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (937, 1, 'BuzzFeed', 37, 'http://www.buzzfeed.com/politics.xml', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com/politics', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (265, 1, 'Complete Philly Coverage', 100, 'http://completephillycoverage.com/feed', '', 0, 0, NULL, '', NULL, 'http://completephillycoverage.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (30, 1, 'TVGuide.com', 10, 'http://rss.tvguide.com/BREAKINGNEWS', '', 0, 0, NULL, '', NULL, 'http://www.tvguide.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (441, 1, 'Local Memphis Sports', 123, 'http://www2.localmemphis.com/rss/64.rss', '', 0, 0, NULL, '', NULL, 'http://www.localmemphis.com/sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1141, 1, 'Desert Star Weekly', 183, 'http://desertstarweekly.com/feed/', '', 0, 0, NULL, '', NULL, 'http://desertstarweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (20, 1, 'Hollywood Reporter', 9, 'http://feeds.feedburner.com/THR/NEWS', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1126, 1, 'Click On Detroit News', 175, 'http://www.clickondetroit.com/4905432?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.clickondetroit.com/4905432', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (392, 1, 'The Buckeye Battle Cry', NULL, 'http://thebuckeyebattlecry.com/feed', '', 0, 0, NULL, '', NULL, 'http://thebuckeyebattlecry.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 35, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (248, 1, 'Click 2 Houston', 131, 'http://www.click2houston.com/5695744?format=rss_2.0&view=feed', '', -1, 0, NULL, '', NULL, 'http://www.click2houston.com/5695744', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1250, 1, 'CollegeBasketballTalk', 29, 'http://collegebasketballtalk.nbcsports.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://collegebasketball.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (825, 1, 'The Roar', 59, 'http://feeds.theroar.com.au/theroar/rugby-union', '', 0, 0, NULL, '', NULL, 'http://www.theroar.com.au', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 59, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (247, 1, 'Your Houston', 131, 'http://www.yourhoustonnews.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=101houston*&f=rss', '', -1, 0, NULL, '', NULL, 'http://www.yourhoustonnews.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=101houston*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1029, 1, 'TampaBay.com', 124, 'http://www.tampabay.com/feeds/rss.page?collatedTag=news,pinellas,neigh-south&section=staffArticle&feedType=rss', '', 0, 0, NULL, '', NULL, 'http://www.tampabay.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (767, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/cross-country-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 32, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (316, 1, 'The Austin Chronicle', 144, 'http://www.austinchronicle.com/gyrobase/rss/issue.xml', '', -1, 0, NULL, '', NULL, 'http://www.austinchronicle.com/rss/issue.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (67, 1, 'Telegraph', 25, 'http://www.telegraph.co.uk/CULTURE/BOOKS/RSS', '', 0, 0, NULL, '', NULL, 'http://www.telegraph.co.uk/culture/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1026, 1, 'Atlanta Journal Constitution', 122, 'http://www.ajc.com/list/rss/news/breaking-news-center/aFSL/', '', 0, 0, NULL, '', NULL, 'http://www.ajc.com/list/news/breaking-news-center/aFSL/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (654, 1, 'L.A Times', 25, 'http://www.latimes.com/books/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/books/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (601, 1, 'UPI', 52, 'http://rss.upi.com/news/odd_news.rss', '', 0, 0, NULL, '', NULL, 'http://www.upi.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (981, 1, 'Daily Herald Provo', 71, 'http://www.heraldextra.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', 0, 0, NULL, '', NULL, 'http://www.heraldextra.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1106, 1, 'Post-Gazette', 168, 'http://www.post-gazette.com/rss/local', '', 0, 0, NULL, '', NULL, 'http://www.post-gazette.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (776, 1, 'NCAA', 59, 'http://www.ncaa.com/news/volleyball-men/nc/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/volleyball-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 26, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1099, 1, 'AlaskaDispatch', 166, 'http://www.adn.com/rss-feeds/feed/all', '', 0, 0, NULL, '', NULL, 'http://www.adn.com/rss-feeds/feed/all', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (426, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200816.xml', '', -1, 0, NULL, '', NULL, 'http://www.elpasotimes.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (125, 1, 'CNN', 40, 'http://rss.cnn.com/rss/cnn_health.rss', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/HEALTH/index.html?eref=rss_health', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (97, 1, 'CNN', 36, 'http://rss.cnn.com/rss/cnn_world.rss', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/WORLD/index.html?eref=rss_world', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (534, 1, 'Las Vegas Review Journal - Sports', 70, 'http://www.lvrj.com/sports.rss', '', 0, 0, NULL, '', NULL, 'http://www.reviewjournal.com/rss.xml/31', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (233, 1, 'Chicago Tribune', 120, 'http://chicagotribune.com/services/chi-latestnews-rss,0,7516175.hyperlink', '', 0, 0, NULL, '', NULL, 'http://www.chicagotribune.com/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (845, 1, 'NPR', 37, 'http://www.npr.org/rss/rss.php?id=1014', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1014', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1260, 1, 'New York Times', 34, 'http://rss.nytimes.com/services/xml/rss/nyt/Soccer.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/soccer/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1248, 1, 'CollegeFootballTalk', 27, 'http://collegefootballtalk.nbcsports.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://collegefootballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (734, 1, 'Forbes', 39, 'http://www.forbes.com/technology/feed2/', '', 0, 0, NULL, '', NULL, 'http://www.forbes.com/technology/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (238, 1, 'CBS Chicago', 120, 'http://chicago.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://chicago.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (641, 1, 'Reuters', 55, 'http://feeds.reuters.com/news/artsculture', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (403, 1, 'WSOC TV', 98, 'http://www.wsoctv.com/feeds/categories/sports/', '', 0, 0, NULL, '', NULL, 'http://www.wsoctv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1243, 1, 'Bleacher Report', 27, 'http://bleacherreport.com/articles/feed?tag_id=16', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (629, 1, 'HuffPost', 52, 'http://www.huffingtonpost.com/feeds/verticals/weird-news/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/weird-news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1281, 1, 'Associated Press', 37, 'http://hosted2.ap.org/atom/APDEFAULT/89ae8247abe8493fae24405546e9a1aa', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (947, 1, 'Daily Mail', 40, 'http://www.dailymail.co.uk/health/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailymail.co.uk/health/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (572, 1, 'HitFix', 10, 'http://www.hitfix.com/channels/tv.rss', '', 0, 0, NULL, '', NULL, 'http://www.hitfix.com/tv.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (864, 1, 'Destructoid', 24, 'http://www.destructoid.com/?mode=atom', '', 0, 0, NULL, '', NULL, 'http://www.destructoid.com/?mode=atom', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (773, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 30, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (512, 1, 'OklahomaSports.Net', 79, 'http://oklahomasports.net/feed/', '', 0, 0, NULL, '', NULL, 'http://oklahomasports.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1057, 1, 'WRAL', 145, 'http://www.wral.com/news/rss/142/', '', 0, 0, NULL, '', NULL, 'http://www.wral.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (669, 1, 'Los Angeles Business Journal', 115, 'http://labusinessjournal.com/rss/headlines/la-government/', '', 0, 0, NULL, '', NULL, 'http://labusinessjournal.com/news/la-government/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1088, 1, 'Toledo Free Press', 160, 'http://www.toledofreepress.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.toledofreepress.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (78, 1, 'Edmunds.com', 22, 'http://www.edmunds.com/feeds/rss/articles.xml', '', 0, 0, NULL, '', NULL, 'http://www.edmunds.com/feeds/rss/articles.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1033, 1, 'My Fox Orlando', 126, 'http://www.myfoxorlando.com/category/235345/central-florida-news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxorlando.com/category/235345/central-florida-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1062, 1, 'CBS Dallas / Fort Worth', 147, 'http://dfw.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1245, 1, 'Bleacher Report', 30, 'http://bleacherreport.com/articles/feed?tag_id=17', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1252, 1, 'FOX Sports', 29, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cbk', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cbk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (852, 1, 'DailyFinance.com', 26, 'http://www.dailyfinance.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.dailyfinance.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (220, 1, 'LA Times Sports', 115, 'http://www.latimes.com/sports/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/sports/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1273, 1, 'Sports Illustrated', 27, 'http://www.si.com/rss/si_ncaaf.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_ncaaf.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (28, 1, 'Roger Bert', 9, 'http://www.rogerebert.com/feed', '', 0, 0, NULL, '', NULL, 'http://www.rogerebert.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (325, 1, 'Indianapolis Business Journal', 171, 'http://www.ibj.com/rss/9', '', 0, 0, NULL, '', NULL, 'http://www.ibj.com/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (236, 1, 'Chicago Daily Herald', 120, 'http://chicago.dailyherald.il-foreclosure.com/rss', '', -1, 0, NULL, '', NULL, 'http://chicago.dailyherald.il-foreclosure.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1272, 1, 'Sports Illustrated', 29, 'http://www.si.com/rss/si_ncaab.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_ncaab.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (604, 1, 'Mediaite', 37, 'http://www.mediaite.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.mediaite.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1233, 1, 'Yahoo Sports', 27, 'https://sports.yahoo.com/nfl/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/nfl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (807, 1, 'NCAA', 59, 'http://www.ncaa.com/news/icehockey-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/icehockey-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 46, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1093, 1, 'All Arlington Voice Reports', 163, 'http://www.arlingtonvoice.com/rss', '', 0, 0, NULL, '', NULL, 'http://www.arlingtonvoice.com/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1046, 1, 'KRDO', 129, 'http://www.krdo.com/14776464?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.krdo.com/14776464', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (384, 1, 'The Columbus Dispatch', 150, 'http://www.dispatch.com/content/syndication/lae_events.xml', '', 0, 0, NULL, '', NULL, 'http://www.dispatch.com/content/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (633, 1, 'FACT Magazine', 16, 'http://feeds.feedburner.com/factmag', '', 0, 0, NULL, '', NULL, 'http://www.factmag.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1160, 1, 'The Orange County Register', 194, 'http://www.ocregister.com/common/rss/rss.php?catID=18883', '', 0, 0, NULL, '', NULL, 'http://www.ocregister.com/common/archives/?catID=18883', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (437, 1, 'WMC Action News 5 Sports', NULL, 'http://www.wmcactionnews5.com/category/4195/news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.wmcactionnews5.com/category/4195/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 39, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (984, 1, 'Idaho Statesman', 76, 'http://www.idahostatesman.com/102/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.idahostatesman.com/102/index.html', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (576, 1, 'Health.com', 19, 'http://www.health.com/health/diet-fitness/feed', '', 0, 0, NULL, '', NULL, 'http://www.health.com/health/diet-fitness', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1038, 1, 'NJ.com', 128, 'http://blog.nj.com/hudsoncountynow_impact/atom.xml', '', 0, 0, NULL, '', NULL, 'http://www.nj.com/hudson/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (744, 1, 'Velo News', 60, 'http://velonews.competitor.com/feed', '', 0, 0, NULL, '', NULL, 'http://velonews.competitor.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1007, 1, '| INFORUM', NULL, 'http://www.inforum.com/latest/rss/', '', 0, 0, NULL, '', NULL, 'http://www.inforum.com/latest', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (318, 1, 'The Daily Texan', 67, 'http://dailytexanonline.com/rss.xml', '', -1, 0, NULL, '', NULL, 'http://www.dailytexanonline.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1251, 1, 'Bleacher Report', 29, 'http://bleacherreport.com/articles/feed?tag_id=22', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (278, 1, 'KSAT', 67, 'http://www.ksat.com/content/pns/ksat.topstories.news.rss', '', -1, 0, NULL, '', NULL, 'http://www.ksat.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (567, 1, 'Metacritic', 10, 'http://www.metacritic.com/rss/features', '', 0, 0, NULL, '', NULL, 'http://www.metacritic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (883, 1, 'Chicago Tribune', 7, 'http://chicagotribune.feedsportal.com/c/34253/f/622809/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.chicagotribune.com/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (793, 1, 'MRN', 59, 'http://www.mrn.com/Race-Series/NASCAR-Sprint-Cup/News.aspx?rss=true', '', 0, 0, NULL, '', NULL, 'http://www.mrn.com/Race-Series/NASCAR-Sprint-Cup/News.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1085, 1, 'Toledo News Now', 160, 'http://www.toledonewsnow.com/Global/category.asp?C=160943&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.wtol.com/category/160943/top-local-news-from-wtol', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (367, 1, 'Art in America', 55, 'http://www.artinamericamagazine.com/rss/', '', 0, 0, NULL, '', NULL, 'http://www.artinamericamagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (177, 1, 'ESPN', 31, 'http://sports.espn.go.com/espn/rss/tennis/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (429, 1, 'ABC 7', 142, 'http://www.kvia.com/15161272?format=rss_2.0&view=feed', '', -1, 0, NULL, '', NULL, 'http://www.kvia.com/15161272', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (302, 1, 'NBC Dallas-Fort Worth', 173, 'http://www.nbcdfw.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcdfw.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1028, 1, 'Bay News 9', 124, 'http://www.baynews9.com/content/news/baynews9/feeds/rss.html/local-news.html', '', 0, 0, NULL, '', NULL, 'http://www.baynews9.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (147, 1, 'Politico', 44, 'http://www.politico.com/rss/polls.xml', '', 0, 0, NULL, '', NULL, 'http://www.politico.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1078, 1, 'KARE 11', 156, 'http://rssfeeds.kare11.com/kare/local&x=1', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1147, 1, 'Alameda Times-Star', 189, 'http://feeds.insidebayarea.com/mngi/rss/CustomRssServlet/181/201303.xml', '', 0, 0, NULL, '', NULL, 'http://www.insidebayarea.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (54, 1, 'NYT', 18, 'http://rss.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/section/fashion?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (742, 1, 'The Independent', 38, 'http://rss.feedsportal.com/c/266/f/3510/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/news/business/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (832, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/boxing/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/boxing/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (920, 1, 'WKRC', 73, 'http://www.local12.com/news/features/top-stories/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.local12.com/news/features/top-stories/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (237, 1, 'RedEye Chicago', 120, 'http://neighborhoods.redeyechicago.com/feed/', '', -1, 0, NULL, '', NULL, 'http://neighborhoods.redeyechicago.com/feed/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (257, 1, 'CBS Philly', 136, 'http://philadelphia.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://philadelphia.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1008, 1, '| The Dickinson Press', 77, 'http://www.thedickinsonpress.com/latest/rss/', '', 0, 0, NULL, '', NULL, 'http://www.thedickinsonpress.com/latest', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (529, 1, 'KOIN', 72, 'http://koin.com/feed/', '', -1, 0, NULL, '', NULL, 'http://koin.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1172, 1, 'AZ Central', 200, 'http://rssfeeds.azcentral.com/phoenix/glendaleandpeoria', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (575, 1, 'ScienceDaily', 19, 'http://feeds.sciencedaily.com/sciencedaily/health_medicine/fitness', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/health_medicine/fitness/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (889, 1, 'HuffPost', 36, 'http://www.huffingtonpost.com/feeds/verticals/world/news.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/world/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1242, 1, 'Kansas City Star', 83, 'http://www.kansascity.com/?widgetName=rssfeed&widgetContentId=6199&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.kansascity.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (349, 1, 'SFGate Sports', 118, 'http://www.sfgate.com/rss/feed/Top-Sports-Stories-RSS-Feed-487.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/rss/feed/Top-Sports-Stories-RSS-Feed-487.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (565, 1, 'NPR', 41, 'http://www.npr.org/rss/rss.php?id=1025', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1025', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (385, 1, '10 TV Central Ohio', 73, 'http://www.10tv.com/content/syndication/news_central-ohio.xml', '', -1, 0, NULL, '', NULL, 'http://www.10tv.com/content/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (946, 1, 'Daily Mail', 7, 'http://www.dailymail.co.uk/ushome/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailymail.co.uk/ushome/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (509, 1, 'FOX25 - KOKH-TV', NULL, 'http://www.okcfox.com/category/244798/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.okcfox.com/category/244798/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 22, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1023, 1, 'American Humane Association', 116, 'http://feeds.feedburner.com/AmericanHumaneAssociation', '', 0, 0, NULL, '', NULL, 'http://americanhumaneblog.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1040, 1, 'The Jersey City Independent', 128, 'http://www.jerseycityindependent.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.jerseycityindependent.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (715, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/33', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/skateboarding', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 22, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1225, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_science?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/top/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1019, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/rodents', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/rodents/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 32, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (711, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/58', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/gymnastics', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 62, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (440, 1, 'Local Memphis', 123, 'http://www2.localmemphis.com/rss/59.rss', '', -1, 0, NULL, '', NULL, 'http://www.localmemphis.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (427, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200229.xml', '', 0, 0, NULL, '', NULL, 'http://www.elpasotimes.com/sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (726, 1, 'Reuters', 38, 'http://feeds.reuters.com/reuters/businessNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1181, 1, 'The Herald-Sun', 145, 'http://www.heraldsun.com/atom', '', 0, 0, NULL, '', NULL, 'http://www.heraldsun.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (954, 1, 'SAVEUR', 20, 'http://www.saveur.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.saveur.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1143, 1, 'San Bernadino Sun', 185, 'http://www.sbsun.com/section?template=RSS&profile=4000690&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.sbsun.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1111, 1, 'Kern Golden Empire', 169, 'http://www.kerngoldenempire.com/rss/91.rss', '', 0, 0, NULL, '', NULL, 'http://www.kerngoldenempire.com/rss/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (808, 1, 'NCAA', 59, 'http://www.ncaa.com/news/gymnastics-men/nc/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/gymnastics-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 23, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (741, 1, 'Mountain Bike Action Magazine', 60, 'http://feeds.feedburner.com/MbaNewsFeed?format=xml', '', 0, 0, NULL, '', NULL, 'http://mbaction.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (823, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/horse-racing/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/horse-racing/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (175, 1, 'CBS Sports', 31, 'http://www.cbssports.com/partners/feeds/rss/tennis_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/tennis', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (911, 1, 'Cruising World', 51, 'http://www.cruisingworld.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.cruisingworld.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (448, 1, 'Seattle Pi', 130, 'http://www.seattlepi.com/ae/collectionRss/A-E-Heds-9147.php', '', 0, 0, NULL, '', NULL, 'http://www.seattlepi.com/entertainment/collectionRss/A-E-Heds-9147.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1048, 1, 'KLKN', 140, 'http://www.klkntv.com/Global/category.asp?C=148537&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.klkntv.com/category/148537/news-home-page', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (724, 1, 'Transworld Motocross', 60, 'http://motocross.transworld.net/feed/', '', 0, 0, NULL, '', NULL, 'http://motocross.transworld.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (92, 1, 'Kiplinger', 26, 'http://www.kiplinger.com/about/rss/kiplinger.rss', '', 0, 0, NULL, '', NULL, 'http://www.kiplinger.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (938, 1, 'BuzzFeed', 16, 'http://www.buzzfeed.com/music.xml', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com/music', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (361, 1, 'BET', 37, 'http://feeds.bet.com/BETcom-Politics', '', 0, 0, NULL, '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1087, 1, 'NBC 24', 160, 'http://www.nbc24.com/rss.aspx?stories=194900&path=news', '', 0, 0, NULL, '', NULL, 'http://www.nbc24.com/news/contents.aspx?id=194900', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (904, 1, 'WWD', 18, 'http://wwd.com/custom-feed/markets/', '', 0, 0, NULL, '', NULL, 'http://wwd.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (784, 1, 'Cycling News', 60, 'http://feeds.feedburner.com/cyclingnews/news?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.cyclingnews.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1169, 1, 'Pasadena Star News', 185, 'http://www.pasadenastarnews.com/section?template=RSS&profile=4000511&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.pasadenastarnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (644, 1, 'SF Gate', 52, 'http://www.sfgate.com/weird/feed/Weird-News-RSS-Feed-433.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/weird/feed/Weird-News-RSS-Feed-433.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (896, 1, 'Mother Jones', 37, 'http://feeds.feedburner.com/motherjones/Politics', '', 0, 0, NULL, '', NULL, 'http://www.motherjones.com/politics/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (740, 1, 'The Independent', 55, 'http://www.independent.co.uk/arts-entertainment/architecture/?service=rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/arts-entertainment/architecture/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1104, 1, 'New Orleans Community News', 164, 'http://blog.nola.com/new_orleans/atom.xml', '', 0, 0, NULL, '', NULL, 'http://blog.nola.com/new_orleans/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (228, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/entertainment/top-stories/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbclosangeles.com/entertainment/top-stories', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (108, 1, 'WashPost', NULL, 'http://feeds.washingtonpost.com/rss/politics/whitehouse', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/politics/white-house/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1140, 1, 'Press Enterprise', 183, 'http://www.pe.com/common/rss/rss.php?catID=24122', '', 0, 0, NULL, '', NULL, 'http://www.pe.com/common/archives/?catID=24122', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (980, 1, 'Deseret News', 71, 'http://www.deseretnews.com/utah/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.deseretnews.com/home/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (246, 1, 'Houston Business Journal', 131, 'http://feeds.bizjournals.com/bizj_houston?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1037, 1, '11 Alive', 122, 'http://archive.11alive.com/rss/local/3/10.xml', '', 0, 0, NULL, '', NULL, 'http://www.11alive.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (637, 1, 'Music Connection', 16, 'http://musicconnection.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.musicconnection.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (780, 1, 'USA BMX', 60, 'https://www.usabmx.com/site/sections/27.rss', '', 0, 0, NULL, '', NULL, 'https://www.usabmx.com/site/sections/27', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1114, 1, 'WTSP', 172, 'http://rssfeeds.wtsp.com/wtsp/localnews&x=1', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1050, 1, 'FOX 21', 129, 'http://fox21news.com/feed/', '', 0, 0, NULL, '', NULL, 'http://fox21news.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (861, 1, 'Bodybuilding', 19, 'http://www.bodybuilding.com/rss/articles/training', '', 0, 0, NULL, '', NULL, 'http://www.bodybuilding.com/fun/bbmaintrain.htm', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (854, 1, 'TheBlaze', 37, 'http://www.theblaze.com/stories/feed/', '', 0, 0, NULL, '', NULL, 'http://www.theblaze.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (679, 1, 'CS Monitor', 25, 'http://rss.csmonitor.com/feeds/books', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1176, 1, 'KRQE 13', 198, 'http://krqe.com/feed/', '', 0, 0, NULL, '', NULL, 'http://krqe.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (858, 1, 'Slate', 37, 'http://feeds.slate.com/slate-101526', '', 0, 0, NULL, '', NULL, 'http://www.slate.com/articles/news_and_politics/politics.teaser.all.10.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (438, 1, 'Fox Memphis', 123, 'http://www.myfoxmemphis.com/category/50813/tennessee-headlines?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.myfoxmemphis.com/category/50813/tennessee-headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1039, 1, 'NJ News 12', 128, 'http://newjersey.news12.com/cmlink/1.4124770#', '', 0, 0, NULL, '', NULL, 'http://newjersey.news12.com/cmlink/1.4124770', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (721, 1, 'Racer X', 60, 'http://racerxonline.com/feeds/rss/category/breaking-news', '', 0, 0, NULL, '', NULL, 'http://racerxonline.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1045, 1, 'WIVB', 135, 'http://wivb.com/feed', '', 0, 0, NULL, '', NULL, 'http://wivb.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1218, 1, 'Cute Overload', 116, 'http://cuteoverload.com/feed/', '', 0, 0, NULL, '', NULL, 'http://cuteoverload.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (315, 1, 'Mashable', 51, 'http://feeds.mashable.com/mashable/lifestyle', '', 0, 0, NULL, '', NULL, 'http://mashable.com/category/lifestyle/?utm_campaign=Mash-Prod-RSS-Feedburner-Lifestyle-Partial&utm_cid=Mash-Prod-RSS-Feedburner-Lifestyle-Partial', '', NULL, false, '', false, false, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (342, 1, 'SFGate', 63, 'http://www.sfgate.com/bayarea/feed/Bay-Area-News-429.php', '', -1, 0, NULL, '', NULL, 'http://www.sfgate.com/bayarea/feed/Bay-Area-News-429.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (351, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124642', '', 0, 0, NULL, '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (306, 1, 'Mercury News', 63, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200735.xml', '', -1, 0, NULL, '', NULL, 'http://www.mercurynews.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (165, 1, 'Bleacher Report', 29, 'http://bleacherreport.com/articles/feed?tag_id=19', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (404, 1, 'WSCO TV Charlotte', 98, 'http://www.wsoctv.com/feeds/categories/entertainment/', '', 0, 0, NULL, '', NULL, 'http://www.wsoctv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (693, 1, 'BBC', 40, 'http://feeds.bbci.co.uk/news/health/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/news/health/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (860, 1, 'N4G:  news feed', NULL, 'http://n4g.com/rss/news?channel=&sort=latest', '', 0, 0, NULL, '', NULL, 'http://contoso/testfeed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (722, 1, 'Reuters', 40, 'http://feeds.reuters.com/reuters/healthNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (645, 1, 'ComingSoon.net', 9, 'http://www.comingsoon.net/feed', '', 0, 0, NULL, '', NULL, 'http://www.comingsoon.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (135, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Science.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/section/science?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (593, 1, 'BBC Sport - Cricket', 59, 'http://feeds.bbci.co.uk/sport/0/cricket/rss.xml#', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/cricket/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (520, 1, 'WLKY', 95, 'http://www.wlky.com/9366964?format=rss_2.0&view=feed', '', -1, 0, NULL, '', NULL, 'http://www.wlky.com/9366964', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1021, 1, 'Huffington Post – Dogs', 116, 'http://www.huffingtonpost.com/news/dogs/feed//', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tag/dogs', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (743, 1, 'The Independent', 26, 'http://www.independent.co.uk/money/spend-save/?service=rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/money/spend-save/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (913, 1, 'Nat Geo', 41, 'http://feeds.nationalgeographic.com/ng/news/news_environment', '', 0, 0, NULL, '', NULL, 'http://news.nationalgeographic.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (11, 1, 'EW', 8, 'http://rss.ew.com/web/ew/rss/media/movies/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.ew.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (35, 1, 'BuzzFeed', 11, 'http://www.buzzfeed.com/comedy.xml', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com/comedy', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1142, 1, 'KIII TV3', 170, 'http://www.kiiitv.com/category/194865/news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.kiiitv.com/category/194865/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (519, 1, 'WHAS 11', 95, 'http://rssfeeds.whas11.com/whas/local', '', -1, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (457, 1, 'CBS Denver', 82, 'http://cbs4denver.com/local/resources_rss.xmlhttp://cbs4denver.com/local/resources_rss.xml', '', -1, 0, NULL, '', NULL, 'http://denver.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (517, 1, 'WAVE 3', 95, 'http://www.wave3.com/category/1178/home?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.wave3.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1072, 1, 'ABC East Bay', 153, 'http://cdn.abclocal.go.com/kgo/xml?id=7102525', '', 0, 0, NULL, '', NULL, 'http://abclocal.go.com/kgo/channel?section=news/local/east_bay&id=7102525', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (9, 1, 'US Magazine', 8, 'http://www.usmagazine.com/celebrity_news/rss', '', 0, 0, NULL, '', NULL, 'http://www.usmagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (700, 1, 'USA Track & Field', 59, 'http://www.usatf.org/News.aspx?rss=news', '', 0, 0, NULL, '', NULL, 'http://www.usatf.org/News/2015.aspx?rss=news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 60, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (526, 1, 'Portland Tribune', 72, 'http://pamplinmedia.com/component/obrss/portland-tribune', '', -1, 0, NULL, '', NULL, 'http://pamplinmedia.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1204, 1, 'KSHB', 83, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10014&categoryId=20000', '', 0, 0, NULL, '', NULL, 'http://www.kshb.com/news/local/union-station-centennial', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1202, 1, 'The Orange County Register', 209, 'http://www.ocregister.com/common/rss/rss.php?catID=23541', '', 0, 0, NULL, '', NULL, 'http://www.ocregister.com/common/archives/?catID=23541', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (176, 1, 'FOX Sports', 31, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (419, 1, 'Fox Detroit', 93, 'http://www.myfoxdetroit.com/category/233687/local-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.myfoxdetroit.com/category/233687/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (837, 1, 'NPR', 55, 'http://www.npr.org/rss/rss.php?id=1047', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1047', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (232, 1, 'Mayors Manor', 30, 'http://mayorsmanor.com/feed/', '', 0, 0, NULL, '', NULL, 'http://mayorsmanor.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1123, 1, 'AL.com', 177, 'http://blog.al.com/news_birmingham_impact/atom.xml', '', 0, 0, NULL, '', NULL, 'http://www.al.com/news/birmingham/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (685, 1, 'Volleyball Magazine', 59, 'http://www.volleyballmag.com/feeds/all', '', 0, 0, NULL, '', NULL, 'http://www.volleyballmag.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 61, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (452, 1, 'SB Nation Seattle', 130, 'http://seattle.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://seattle.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (446, 1, 'Seattle Pi', 130, 'http://www.seattlepi.com/local/feed/seattlepi-com-Local-News-218.php', '', -1, 0, NULL, '', NULL, 'http://www.seattlepi.com/local/feed/seattlepi-com-Local-News-218.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (337, 1, 'AllMusic Blog', 16, 'http://www.allmusic.com/rss', '', 0, 0, NULL, '', NULL, 'http://www.allmusic.com/blog', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (314, 1, 'SF Gate', 30, 'http://www.sfgate.com/sharks/feed/San-Jose-Sharks-RSS-Feed-492.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/sharks/feed/San-Jose-Sharks-RSS-Feed-492.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (323, 1, 'Indystar', 92, 'http://rssfeeds.indystar.com/indystar/todaystopstories&x=1', '', -1, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (327, 1, 'RTV6', 92, 'http://www.theindychannel.com/news/topstory.rss', '', -1, 0, NULL, '', NULL, 'http://www.theindychannel.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (326, 1, 'WTHR', 92, 'http://www.wthr.com/category/23903/local-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.wthr.com/category/23903/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (477, 1, 'WCVB', 110, 'http://www.wcvb.com/9849828?format=rss_2.0&view=feed', '', -1, 0, NULL, '', NULL, 'http://www.wcvb.com/9849828?absolute=true', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (890, 1, 'Huff Post', 38, 'http://www.huffingtonpost.com/feeds/verticals/money/news.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/money/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (53, 1, 'Fads & Ads', 14, 'http://blog.tartanlabs.com/rss', '', 0, 0, NULL, '', NULL, 'http://blog.tartanlabs.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1086, 1, 'Toledo Blade', 160, 'http://www.toledoblade.com/rss/local', '', 0, 0, NULL, '', NULL, 'http://www.toledoblade.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (482, 1, 'WBUR', 110, 'http://www.wbur.org/feed', '', -1, 0, NULL, '', NULL, 'http://www.wbur.org/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (618, 1, 'The Business Journal', 83, 'http://feeds.bizjournals.com/bizj_kansascity', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (121, 1, 'WIRED', 38, 'http://www.wired.com/category/business/feed/', '', 0, 0, NULL, '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1177, 1, 'KASA.com', 198, 'http://kasa.com/feed/', '', 0, 0, NULL, '', NULL, 'http://kasa.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (171, 1, 'ESPN', 30, 'http://sports.espn.go.com/espn/rss/nhl/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (89, 1, 'GamesRadar', 24, 'http://www.gamesradar.com/all-platforms/news/feed/', '', 0, 0, NULL, '', NULL, 'http://www.gamesradar.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (224, 1, 'IB Daily', 38, 'http://www.investors.com/Rss.axd?path=InvestingRSS.xml', '', 0, 0, NULL, '', NULL, 'http://www.investors.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (865, 1, 'NYT', 38, 'http://rss.nytimes.com/services/xml/rss/nyt/Business.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/business/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (851, 1, 'The Guardian', 21, 'http://www.theguardian.com/lifeandstyle/home-and-garden/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/lifeandstyle/home-and-garden', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (723, 1, 'Cycle News', 60, 'http://www.cyclenews.com/1/Racing-Article-Group-Headlines/Article-Headlines.aspx', '', 0, 0, NULL, '', NULL, 'http://www.cyclenews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1211, 1, 'City of Virginia Beach', 211, 'http://www.vbgov.com/feed/rss/news', '', 0, 0, NULL, '', NULL, 'http://www.vbgov.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1069, 1, 'Inside Bay Area', 153, 'http://feeds.insidebayarea.com/mngi/rss/CustomRssServlet/181/201302.xml', '', 0, 0, NULL, '', NULL, 'http://www.insidebayarea.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (539, 1, 'Religion News Service', 49, 'http://feeds.feedburner.com/religion-news-service?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.religionnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (506, 1, 'KOCO', 188, 'http://www.koco.com/11777728?format=rss_2.0&view=feed', '', -1, 0, NULL, '', NULL, 'http://www.koco.com/11777728', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (746, 1, 'The Independent', 18, 'http://rss.feedsportal.com/c/266/f/3803/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/life-style/fashion/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (953, 1, 'BuzzFeed', 52, 'http://www.buzzfeed.com/wtf.xml', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com/wtf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (172, 1, 'CBS Sports', 30, 'http://www.cbssports.com/partners/feeds/rss/nhl_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1179, 1, 'Winston-Salem Journal', 204, 'http://www.journalnow.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/local/more_headlines*&f=rss', '', 0, 0, NULL, '', NULL, 'http://www.journalnow.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news/local/more_headlines*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1075, 1, 'KTUL', 154, 'http://www.ktul.com/global/category.asp?C=189710&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.ktul.com/category/189710/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (471, 1, 'WTOP', 114, 'http://wtop.com/section/entertainment/feed', '', 0, 0, NULL, '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (493, 1, 'Nashville Public Radio', 186, 'http://nashvillepublicradio.org/rss.xml', '', -1, 0, NULL, '', NULL, 'http://nashvillepublicradio.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (507, 1, 'Fox 25', 188, 'http://www.okcfox.com/category/244797/news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.okcfox.com/category/244797/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (689, 1, 'CS Monitor', 41, 'http://rss.csmonitor.com/feeds/environment', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (107, 1, 'WashPost', NULL, 'http://feeds.washingtonpost.com/rss/politics/campaigns', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/politics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1080, 1, 'Cleveland.com', 157, 'http://blog.cleveland.com/metro/atom.xml', '', 0, 0, NULL, '', NULL, 'http://blog.cleveland.com/metro/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (566, 1, 'The Earth Times', 41, 'http://feeds.earthtimes.org/earthtimes?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.earthtimes.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1016, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/horses', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/horses/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 38, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (106, 1, 'WashPost', 37, 'http://feeds.washingtonpost.com/rss/politics', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/politics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (6, 1, 'NYT', 7, 'http://www.nytimes.com/services/xml/rss/nyt/US.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/national/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (168, 1, 'CBS Sports', 29, 'http://www.cbssports.com/partners/feeds/rss/nba_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/nba', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (830, 1, 'Bleacher Report', 59, 'http://bleacherreport.com/articles/feed?tag_id=2318', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (801, 1, 'NCAA', 59, 'http://www.ncaa.com/news/skiing/nc/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/skiing/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 39, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1145, 1, 'AZ Central', 187, 'http://rssfeeds.azcentral.com/phoenix/gilbert', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1221, 1, 'BlogPaws', 116, 'http://feeds.feedburner.com/BlogPaws?format=xml', '', 0, 0, NULL, '', NULL, 'http://blogpaws.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1020, 1, 'ScienceDaily', 116, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/veterinary_medicine', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/veterinary_medicine/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (955, 1, 'Discovery', 40, 'http://feeds.feedburner.com/DiscoverHealthMedicine', '', 0, 0, NULL, '', NULL, 'http://discovermagazine.com/rss/topic-feeds/health-medicine', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (824, 1, 'Bleacher Report', 59, 'http://bleacherreport.com/articles/feed?tag_id=2474', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (409, 1, 'CBS 11', 173, 'http://cbs11tv.com/gasprices/resources_rss.xml', '', -1, 0, NULL, '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (798, 1, 'American Craft Beer', 51, 'http://americancraftbeer.com/feed/rss/the-biz/the-biz.html?format=feed', '', 0, 0, NULL, '', NULL, 'http://americancraftbeer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (687, 1, 'CS Monitor', 38, 'http://rss.csmonitor.com/feeds/wam', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (571, 1, 'HuffPost', 10, 'http://www.huffingtonpost.com/feeds/verticals/tv/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tv/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (661, 1, 'HuffPost', 48, 'http://www.huffingtonpost.com/feeds/verticals/good-news/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/good-news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (90, 1, 'gamesTM', 24, 'http://www.gamestm.co.uk/category/news/feed/', '', 0, 0, NULL, '', NULL, 'http://www.gamestm.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (621, 1, 'KCTV Kansas City', 83, 'http://www.kctv5.com/category/208603/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.kctv5.com/category/208603/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1077, 1, 'FOX 9 News', 161, 'http://www.myfoxtwincities.com/category/230083/news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxtwincities.com/category/230083/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (960, 1, 'Patheos', 49, 'http://feeds.feedburner.com/PatheosArticles-Atheism', '', 0, 0, NULL, '', NULL, 'http://www.patheos.com/Resources/Additional-Resources.html', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (317, 1, 'Austin Business Journal', 144, 'http://feeds.bizjournals.com/bizj_austin', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (934, 1, 'Magnetic Magazine', 16, 'http://feeds.feedburner.com/magneticmag', '', 0, 0, NULL, '', NULL, 'http://www.magneticmag.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (192, 1, 'BBC Sport', 34, 'http://feeds.bbci.co.uk/sport/0/football/rss.xml?edition=uk', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/football/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (43, 1, 'VideoGamer.com', 24, 'http://feeds.videogamer.com/rss/news.xml', '', 0, 0, NULL, '', NULL, 'http://www.videogamer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (622, 1, 'Sports News', NULL, 'http://www.kmbc.com/11665168?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kmbc.com/11665168', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (822, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/formula1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/formula1/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1002, 1, 'StarTribune.com', 161, 'http://www.startribune.com/local/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.startribune.com/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (370, 1, 'Art Asia Pacific', 55, 'http://artasiapacific.com/rss/pages', '', 0, 0, NULL, '', NULL, 'http://artasiapacific.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (380, 1, 'LA Times', 55, 'http://www.latimes.com/entertainment/arts/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/entertainment/arts/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (435, 1, 'MCA Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=10004', '', 0, 0, NULL, '', NULL, 'http://www.commercialappeal.com/ncaa-bracket-contest', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 29, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1278, 1, 'The Onion', 11, 'http://www.theonion.com/feeds/rss', '', 0, 0, NULL, '', NULL, 'http://www.theonion.com/search', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (424, 1, 'Detroit Sport Radio - Podcast', 93, 'http://www.blogtalkradio.com/detroitsportsrag/podcast', '', 0, 0, NULL, '', NULL, 'http://www.blogtalkradio.com/detroitsportsrag', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (898, 1, 'Men''s Health', 19, 'http://www.mensfitness.co.uk/news/feed', '', 0, 0, NULL, '', NULL, 'http://www.coachmag.co.uk/taxonomy/term/3/all/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (44, 1, 'Vimeo', 13, 'http://vimeo.com/CHANNELS/53200/VIDEOS/RSS', '', 0, 0, NULL, '', NULL, 'https://vimeo.com/channels/53200/videos', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1012, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/cows_sheep_pigs', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/cows,_sheep,_pigs/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 33, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (356, 1, 'SB Nation Bay Area', 118, 'http://bayarea.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://bayarea.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (527, 1, 'Portland Business Journal', 72, 'http://feeds.bizjournals.com/bizj_portland', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1266, 1, 'Yahoo Sports', 30, 'https://sports.yahoo.com/nhl/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1182, 1, 'The Chronicle of Winston-Salem', 204, 'http://www.wschronicle.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.wschronicle.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (985, 1, 'Times News', 76, 'http://magicvalley.com/search/?f=rss&c=news/local&l=25&s=start_time&sd=desc', '', 0, 0, NULL, '', NULL, 'http://magicvalley.com/search/?f=rss&c=news/local&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1113, 1, 'The Monitor', 170, 'http://www.themonitor.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/local*&f=rss', '', 0, 0, NULL, '', NULL, 'http://www.themonitor.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news/local*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1102, 1, 'WTVQ', 167, 'http://www.wtvq.com/rss/3441.rss', '', 0, 0, NULL, '', NULL, 'http://www.wtvq.com/rss/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (899, 1, 'The Guardian', 25, 'http://www.theguardian.com/books/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/books', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (48, 1, 'Upworthy', NULL, 'http://feeds.feedburner.com/UPWORTHY', '', 0, 0, NULL, '', NULL, 'http://www.upworthy.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1139, 1, 'KSDK', 182, 'http://rssfeeds.ksdk.com/ksdk-localnews&x=1', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (379, 1, 'Anthem Magazine', 55, 'http://anthemmagazine.com/feed/', '', 0, 0, NULL, '', NULL, 'http://anthemmagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (635, 1, 'Daily Express', 52, 'http://feeds.feedburner.com/daily-express-weird-news', '', 0, 0, NULL, '', NULL, 'http://www.express.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (45, 1, 'BuzzFeed', 13, 'http://www.buzzfeed.com/VIDEOS.XML', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1168, 1, 'KOB 4', 198, 'http://www.kob.com/rssFeeds/rss500.xml', '', 0, 0, NULL, '', NULL, 'http://www.kob.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (735, 1, 'The Independent', 40, 'http://www.independent.co.uk/life-style/health-and-wellbeing/rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/life-style/health-and-families/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1117, 1, 'WIAT 42', 177, 'http://wiat.com/feed/', '', 0, 0, NULL, '', NULL, 'http://wiat.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (948, 1, 'Daily Mail', 55, 'http://www.dailymail.co.uk/news/arts/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailymail.co.uk/news/arts/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (212, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcnewyork.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1131, 1, 'The Orange County Register', 180, 'http://www.ocregister.com/common/rss/rss.php?catID=18895', '', 0, 0, NULL, '', NULL, 'http://www.ocregister.com/common/archives/?catID=18895', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (712, 1, 'Reuters', 36, 'http://feeds.reuters.com/Reuters/worldNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (473, 1, 'DC Pro Sports Report', 114, 'http://dcprosportsreport.com/feed/', '', 0, 0, NULL, '', NULL, 'http://dcprosportsreport.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (372, 1, 'Aesthetica Magazine', 55, 'http://www.aestheticamagazine.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.aestheticamagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1097, 1, 'Recordnet.com', 165, 'http://www.recordnet.com/news?template=rss&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.recordnet.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (324, 1, 'Indystar', 92, 'http://rssfeeds.indystar.com/indystar/allsports&x=1', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (952, 1, 'Forbes', 26, 'http://www.forbes.com/finance/feed/', '', 0, 0, NULL, '', NULL, 'http://www.forbes.com/finance/feed2/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (132, 1, 'Science mag', 41, 'http://news.sciencemag.org/RSS/CURRENT.XML', '', 0, 0, NULL, '', NULL, 'http://news.sciencemag.org/rss/current.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (313, 1, 'Fear The Fin', 30, 'http://www.fearthefin.com/rss/', '', 0, 0, NULL, '', NULL, 'http://www.fearthefin.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (293, 1, 'Dallas Business Journal', 134, 'http://feeds.bizjournals.com/bizj_dallas', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1235, 1, 'ProBasketballTalk', 29, 'http://probasketballtalk.nbcsports.com/feed/', '', 0, 0, NULL, '', NULL, 'http://nba.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1261, 1, 'New York Times', 31, 'http://rss.nytimes.com/services/xml/rss/nyt/Tennis.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/tennis/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (179, 1, 'TENNIS.com', 31, 'http://feeds.feedburner.com/tenniscom-news', '', 0, 0, NULL, '', NULL, 'http://www.tennis.com/pro-game/list/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1274, 1, 'Sports Illustrated', 30, 'http://www.si.com/rss/si_hockey.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_nhl.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (189, 1, 'ESPN', 34, 'http://soccernet.espn.go.com/rss/news', '', 0, 0, NULL, '', NULL, 'http://www.espnfc.com/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (182, 1, 'USA TODAY', 32, 'http://rssfeeds.usatoday.com/UsatodaycomGolf-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (603, 1, 'Adage', 43, 'http://adage.com/rss-channel.php?section_id=1', '', 0, 0, NULL, '', NULL, 'http://adage.com/rss-channel.php?section_id=1&xml=RSS2', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (134, 1, 'WashPost', 41, 'http://feeds.washingtonpost.com/rss/rss_speaking-of-science', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/news/speaking-of-science', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 27, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1108, 1, 'WWL', 164, 'http://rssfeeds.wwltv.com/wwl/local', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (183, 1, 'FOX Sports', 32, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (398, 1, 'Charlotte Business Journal', 174, 'http://feeds.bizjournals.com/bizj_charlotte?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (40, 1, 'GameSpot', 24, 'http://gamespot.com/rss/game_updates.php?', '', 0, 0, NULL, '', NULL, 'http://www.gamespot.com/feeds/mashup/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1027, 1, 'Atlanta Daily World', 122, 'http://atlantadailyworld.com/category/adw-news/feed/', '', 0, 0, NULL, '', NULL, 'http://atlantadailyworld.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (350, 1, 'SF Gate', 118, 'http://www.sfgate.com/rss/feed/Entertainment-530.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/rss/feed/Entertainment-530.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (701, 1, 'NYT', 23, 'http://www.nytimes.com/services/xml/rss/nyt/BusinessSpecial.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/business/businessspecial/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (353, 1, 'BET.com', 16, 'http://feeds.bet.com/BETcom-Music', '', 0, 0, NULL, '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (260, 1, 'NBC 10 Philadelphia', 100, 'http://www.nbcphiladelphia.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcphiladelphia.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (235, 1, 'Chicago Tribune', 120, 'http://feeds.feedburner.com/ChicagoBreakingSports/', '', 0, 0, NULL, '', NULL, 'http://www.chicagotribune.com/sports/breaking/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1200, 1, 'Long Beach Post', 209, 'http://www.lbpost.com/?format=feed', '', 0, 0, NULL, '', NULL, 'http://lbpost.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (967, 1, 'On the Runway', 18, 'http://runway.blogs.nytimes.com/feed/', '', 0, 0, NULL, '', NULL, 'http://runway.blogs.nytimes.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1054, 1, 'NBC 10 Philadelphia', 136, 'http://www.nbcphiladelphia.com/news/local/?rss=y&embedThumb=y&summary=', '', 0, 0, NULL, '', NULL, 'http://www.nbcphiladelphia.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (747, 1, 'BBC Sport', 33, 'http://feeds.bbci.co.uk/sport/0/winter-sports/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/winter-sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (420, 1, 'MyFox Detroit Sports', 93, 'http://www.myfoxdetroit.com/category/230149/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxdetroit.com/category/230149/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (605, 1, 'NPR', 43, 'http://www.npr.org/rss/rss.php?id=1020', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1020', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (472, 1, 'Washington Post', 114, 'http://feeds.washingtonpost.com/rss/rss_dc-sports-bog', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/blogs/dc-sports-bog', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (454, 1, 'Seattle Sports Insider', 69, 'http://seattlesportsinsider.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://seattlesportsinsider.com/frontpage/76', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (814, 1, 'Bizjournals', 39, 'http://feeds.bizjournals.com/industry_7', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (630, 1, 'Q Magazine', 16, 'http://www.qthemusic.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.qthemusic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (873, 1, 'The Independent', 36, 'http://rss.feedsportal.com/c/266/f/3503/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/news/world/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (430, 1, 'KVIA Sports', NULL, 'http://www.kvia.com/15160498?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kvia.com/15160498', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 28, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1213, 1, 'Daily Press', 211, 'http://dailypress.feedsportal.com/c/34257/f/656252/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailypress.com/news/?track=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (581, 1, 'SF Gate', 20, 'http://www.sfgate.com/rss/feed/Food-Dining-550.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/rss/feed/Food-Dining-550.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (909, 1, 'CNET', 22, 'http://www.cnet.com/rss/car-tech/', '', 0, 0, NULL, '', NULL, 'http://www.cnet.com/roadshow/#ftag=CADae39d16', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (574, 1, 'History.com', 215, 'http://www.history.com/this-day-in-history/rss', '', 0, 0, NULL, '', NULL, 'http://css.history.com/this-day-in-history', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (995, 1, 'NHL.com', 30, 'http://www.nhl.com/rss/news.xml', '', 0, 0, NULL, '', NULL, 'http://www.nhl.com/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (537, 1, 'Las Vegas Sun', 70, 'http://lasvegassun.com/feeds/headlines/blogs/talking-points/', '', 0, 0, NULL, '', NULL, 'http://lasvegassun.com/news/blogs/talking-points/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1055, 1, 'News 3 LV', 143, 'http://www.news3lv.com/rss/3269.rss', '', 0, 0, NULL, '', NULL, 'http://www.mynews3.com/content/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (381, 1, 'Juxtapoz Magazine', 55, 'http://www.juxtapoz.com/current/feed/rss', '', 0, 0, NULL, '', NULL, 'http://www.juxtapoz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (998, 1, 'New York Times', 32, 'http://www.nytimes.com/services/xml/rss/nyt/Golf.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/golf/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (880, 1, 'Science : NPR', 40, 'http://www.npr.org/rss/rss.php?id=1007', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1007', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (312, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcbayarea.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (184, 1, 'CBS Sports', 32, 'http://www.cbssports.com/partners/feeds/rss/golf_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/golf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (799, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/swimming-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 45, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1065, 1, 'Miami Herald', 152, 'http://www.miamiherald.com/news/local/?widgetName=rssfeed&widgetContentId=712015&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.miamiherald.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (683, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/57', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/beach_volleyball', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 65, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1259, 1, 'New York Times', 30, 'http://rss.nytimes.com/services/xml/rss/nyt/Hockey.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/hockey/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (714, 1, 'Reuters', 7, 'http://feeds.reuters.com/Reuters/domesticNews', '', -1, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (614, 1, 'News 10', 119, 'http://www.news10.net/rss/local.aspx', '', -1, 0, NULL, '', NULL, 'http://www.news10.net/news/default.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1222, 1, 'Love That Pet', 116, 'https://www.lovethatpet.com/feed/', '', 0, 0, NULL, '', NULL, 'https://www.lovethatpet.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (521, 1, 'WAVE 3 Sports', NULL, 'http://www.wave3.com/category/1181/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.wave3.com/category/1181/louisville-sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 36, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (686, 1, 'CS Monitor', 7, 'http://rss.csmonitor.com/feeds/usa', '', -1, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1155, 1, 'WTMJ', 191, 'http://www.620wtmj.com/news/local/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.620wtmj.com/templates/Lib.Feed.xml?path=/news/local&format=RSS&limit=100', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (956, 1, 'Discovery', 39, 'http://feeds.feedburner.com/DiscoverTechnology', '', 0, 0, NULL, '', NULL, 'http://discovermagazine.com/rss/topic-feeds/technology', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (146, 1, 'Pew Research Center', 44, 'http://www.pewresearch.org/feed/', '', 0, 0, NULL, '', NULL, 'http://www.pewresearch.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1090, 1, 'TwinCities.com', 161, 'http://feeds.twincities.com/mngi/rss/CustomRssServlet/569/200315.xml', '', 0, 0, NULL, '', NULL, 'http://www.twincities.com/localnews/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (895, 1, 'POPSUGAR', 19, 'http://www.popsugar.com/fitness/feed', '', 0, 0, NULL, '', NULL, 'http://www.popsugar.com/fitness', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (215, 1, 'FOX New York', 66, 'http://www.myfoxny.com/category/230819/sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxny.com/category/230819/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (705, 1, 'SURFER Magazine', 60, 'http://surfermag.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.surfermag.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1254, 1, 'HardballTalk', 28, 'http://hardballtalk.nbcsports.com/rss/entries.xml', '', 0, 0, NULL, '', NULL, 'http://hardballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (467, 1, 'ABC', 7, 'http://feeds.abcnews.com/abcnews/usheadlines', '', -1, 0, NULL, '', NULL, 'http://www.wjla.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (973, 1, 'ABC News', 70, 'http://abcnews.go.com/topics/urss?pageid=1085222', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (217, 1, 'SB Nation New York', 66, 'http://newyork.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://newyork.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (786, 1, 'Skate Daily', 60, 'http://skatedaily.net/feed/', '', 0, 0, NULL, '', NULL, 'http://skatedaily.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (762, 1, 'NCAA', NULL, 'http://www.ncaa.com/news/baseball/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/baseball/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (870, 1, 'New York Times', 43, 'http://rss.nytimes.com/services/xml/rss/nyt/MediaandAdvertising.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/business/media/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (991, 1, 'ITF Pro Circuit News', 31, 'http://www.itftennis.com/data/rss/itfprocircuitnews.xml', '', 0, 0, NULL, '', NULL, 'http://www.itftennis.com/procircuit/news.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1107, 1, 'WDSU', 164, 'http://www.wdsu.com/9854386?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.wdsu.com/9854386', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1189, 1, 'Tucson News Now', 207, 'http://www.tucsonnewsnow.com/Global/category.asp?C=5168&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.TucsonNewsNow.com/category/5168/tucson-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (835, 1, 'NPR', 55, 'http://www.npr.org/rss/rss.php?id=1008', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1008', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (49, 1, 'Ads of the World™', 14, 'http://adsoftheworld.com/NODE/FEED', '', 0, 0, NULL, '', NULL, 'http://adsoftheworld.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (501, 1, 'ABC Baltimore', 106, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=10008', '', 0, 0, NULL, '', NULL, 'http://www.abc2news.com/comiccon', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1120, 1, 'KITV', 176, 'http://www.kitv.com/8906310?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.kitv.com/8906310', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1156, 1, 'Scottsdale Independent', 190, 'http://feeds.feedblitz.com/ScottsdaleIndependent', '', 0, 0, NULL, '', NULL, 'http://www.scottsdaleindependent.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1152, 1, 'WISN', 191, 'http://www.wisn.com/9374280?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.wisn.com/9374280', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (739, 1, 'The Independent', 55, 'http://www.independent.co.uk/arts-entertainment/theatre-dance/?service=rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/arts-entertainment/theatre-dance/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1073, 1, 'KTVU San Francisco', 153, 'http://www.ktvu.com/category/289821/east-bay-news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://wn.ktvu.com/category/289821/east-bay-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (987, 1, 'NFL.com', 27, 'http://search.nfl.com/urss?q=news', '', 0, 0, NULL, '', NULL, 'http://search.nfl.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (748, 1, 'NCAA', 27, 'http://www.ncaa.com/news/football/fbs/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/football/fbs/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (345, 1, 'KTVU San Francisco', 118, 'http://www.ktvu.com/category/289753/san-francisco-penninsula?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://wn.ktvu.com/category/289753/san-francisco-penninsula', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (732, 1, 'Forbes', 38, 'http://www.forbes.com/business/feed2/', '', 0, 0, NULL, '', NULL, 'http://www.forbes.com/business/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (951, 1, 'NYT', 25, 'http://rss.nytimes.com/services/xml/rss/nyt/Books.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/books/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1089, 1, 'CBS Minnesota', 161, 'http://minnesota.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://minnesota.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (611, 1, 'The Sacramento Observer', 119, 'http://feeds.feedburner.com/Sacobserver?format=xml', '', -1, 0, NULL, '', NULL, 'http://sacobserver.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (725, 1, 'Reuters', 41, 'http://feeds.reuters.com/reuters/environment', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (347, 1, 'CBS 5', 118, 'http://cbs5.com/moviereviews/resources_rss.xml', '', -1, 0, NULL, '', NULL, 'http://sanfrancisco.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (64, 1, 'Electronics weekly', 17, 'http://www.electronicsweekly.com/news/feed/', '', 0, 0, NULL, '', NULL, 'http://www.electronicsweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (8, 1, 'People', 8, 'http://feeds.people.com/people/headlines', '', 0, 0, NULL, '', NULL, 'http://www.people.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (805, 1, 'AUTOSPORT.com', 59, 'http://www.autosport.com/rss/nascarnews.xml', '', 0, 0, NULL, '', NULL, 'http://www.autosport.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (343, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124648', '', -1, 0, NULL, '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1174, 1, 'Dallas Morning News', 202, 'http://www.dallasnews.com/news/community-news/garland-mesquite/?rss', '', 0, 0, NULL, '', NULL, 'http://www.dallasnews.com/news/community-news/garland-mesquite/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (450, 1, 'My North West - Sports', NULL, 'http://www.mynorthwest.com/resources/podcasts/podcast.php?c=27', '', 0, 0, NULL, '', NULL, 'http://kiroradio.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 27, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (556, 1, 'People', NULL, 'http://rss.people.com/web/people/rss/topheadlines/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.people.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (156, 1, 'CBS Sports', 27, 'http://www.cbssports.com/partners/feeds/rss/cfb_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/collegefootball', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1092, 1, 'Arlington News', 163, 'http://www.star-telegram.com/news/local/community/arlington/?widgetName=rssfeed&widgetContentId=714290&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.star-telegram.com/news/local/community/arlington/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (309, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, NULL, '', NULL, 'http://www.nbcbayarea.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (159, 1, 'USA TODAY', 27, 'http://rssfeeds.usatoday.com/UsatodaycomNfl-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 24, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (285, 1, 'UT San Diego', 125, 'http://www.signonsandiego.com/rss/headlines/', '', -1, 0, NULL, '', NULL, 'http://www.sandiegouniontribune.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (286, 1, 'CBS 8', 125, 'http://www.cbs8.com/Global/category.asp?clienttype=rss_img&C=154671', '', -1, 0, NULL, '', NULL, 'http://www.cbs8.com/category/154671/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (253, 1, 'KPRC Radio', 67, 'http://www.kprcradio.com/rss/onair-36776/', '', -1, 0, NULL, '', NULL, 'http://www.kprcradio.com/onair/houston-public-affairs-36776/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (303, 1, 'KERA', 67, 'http://www.kera.org/feed/', '', -1, 0, NULL, '', NULL, 'http://www.kera.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (319, 1, 'KXAN', 67, 'http://kxan.com/feed/', '', -1, 0, NULL, '', NULL, 'http://kxan.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (730, 1, 'Pink Bike', 60, 'http://www.pinkbike.com/pinkbike_xml_feed.php', '', 0, 0, NULL, '', NULL, 'http://www.pinkbike.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (884, 1, 'U.S. News', 40, 'http://www.usnews.com/rss/health', '', 0, 0, NULL, '', NULL, 'http://health.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (532, 1, 'Las Vegas Review Journal', 70, 'http://www.lvrj.com/news.rss', '', -1, 0, NULL, '', NULL, 'http://www.reviewjournal.com/rss.xml/1', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (719, 1, 'Reuters', 37, 'http://feeds.reuters.com/Reuters/PoliticsNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (340, 1, 'WOKV', 68, 'http://www.wokv.com/feeds/categories/news/', '', -1, 0, NULL, '', NULL, 'http://www.wokv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1190, 1, 'Tucson City News', 207, 'http://www.tucsonaz.gov/news.xml', '', 0, 0, NULL, '', NULL, 'https://www.tucsonaz.gov/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (336, 1, 'Jacksonville News', 68, 'http://www.news4jax.com/news/topstory.rss', '', -1, 0, NULL, '', NULL, 'http://www.news4jax.com/4908618', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (334, 1, 'The Florida Times-Union', 68, 'http://feeds.jacksonville.com/JacksonvillecomMostPopularStories?format=xml', '', -1, 0, NULL, '', NULL, 'http://jacksonville.com/feeds/mostpopularstories', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (528, 1, 'KATU', 72, 'http://www.katu.com/news/?fin=xml&type=default&c=y', '', -1, 0, NULL, '', NULL, 'http://www.katu.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (445, 1, 'The Seattle Times', 69, 'http://seattletimes.nwsource.com/rss/seattletimes.xml', '', -1, 0, NULL, '', NULL, 'http://www.seattletimes.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (249, 1, 'Houston Sports', 67, 'http://www.click2houston.com/mobile/4735518?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.click2houston.com/mobile/4735518', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (268, 1, 'Arizona Capitol Times', 74, 'http://azcapitoltimes.com/feed/', '', -1, 0, NULL, '', NULL, 'http://azcapitoltimes.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (272, 1, 'ei8ht', 74, 'http://www.azpbs.org/horizon/rss/headlines/', '', -1, 0, NULL, '', NULL, 'http://www.azpbs.org/horizon', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (266, 1, 'The Arizona Republic', 74, 'http://www.azcentral.com/rss/feeds/republicfront.xml', '', -1, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1082, 1, 'WXII 12', 155, 'http://www.wxii12.com/9678710?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.wxii12.com/9678710', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (245, 1, 'Houston Chronicle', 131, 'http://www.chron.com/rss/feed/News-270.php', '', -1, 0, NULL, '', NULL, 'http://www.chron.com/rss/feed/News-270.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (504, 1, 'NewsOK.com', 79, 'http://www.newsok.com/rss/news', '', -1, 0, NULL, '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (252, 1, 'CBS Houston', 131, 'http://houston.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://houston.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1203, 1, 'breakingnews.com', 209, 'http://www.breakingnews.com/feeds/rss/long-beach-ca-us', '', 0, 0, NULL, '', NULL, 'http://www.breakingnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (16, 1, 'POP SUGAR', 8, 'http://feeds.feedburner.com/popsugar', '', 0, 0, NULL, '', NULL, 'http://www.popsugar.com/celebrity', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (912, 1, 'Nature.com', 41, 'http://feeds.nature.com/nature/rss/current', '', 0, 0, NULL, '', NULL, 'http://www.nature.com/nature/current_issue/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (300, 1, 'NBC 5', 173, 'http://www.nbcdfw.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, NULL, '', NULL, 'http://www.nbcdfw.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (17, 1, 'Hello', 8, 'http://www.hellomagazine.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.hellomagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1067, 1, 'Miami Beach 411', 152, 'http://www.miamibeach411.com/news/rss_2.0', '', 0, 0, NULL, '', NULL, 'http://www.miamibeach411.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (533, 1, 'Las Vegas Sun', 70, 'http://lasvegassun.com/feeds/headlines/news/', '', -1, 0, NULL, '', NULL, 'http://lasvegassun.com/news/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (383, 1, 'The Columbus Dispatch', 150, 'http://www.dispatch.com/content/syndication/news_local-state.xml', '', -1, 0, NULL, '', NULL, 'http://www.dispatch.com/content/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1263, 1, 'Yahoo Sports', 28, 'https://sports.yahoo.com/mlb/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/mlb', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (455, 1, 'Denver Post', 82, 'http://feeds.denverpost.com/dp-news-breaking-local', '', -1, 0, NULL, '', NULL, 'http://www.denverpost.com/breakingnews/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (51, 1, 'Best ads son TV', 14, 'http://www.bestadsontv.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.bestadsontv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (436, 1, 'WMC Action News 5', 123, 'http://www.wmcactionnews5.com/category/4728/news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.wmcactionnews5.com/category/4728/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (491, 1, 'News Channel 5', 186, 'http://www.scrippsmedia.com/newschannel5/news/index.rss', '', -1, 0, NULL, '', NULL, 'http://www.scrippsmedia.com/templates/Lib.Feed.xml?path=/newschannel5/news&format=RSSFull&limit=50', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (867, 1, 'Nieman Lab', 43, 'http://www.niemanlab.org/reading/feed/', '', 0, 0, NULL, '', NULL, 'http://www.niemanlab.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1241, 1, 'MLB.com', 28, 'http://mlb.mlb.com/partnerxml/gen/news/rss/mlb.xml', '', 0, 0, NULL, '', NULL, 'http://mlb.mlb.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (258, 1, 'Fox Philadelphia', 100, 'http://www.myfoxphilly.com/category/233386/local-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.myfoxphilly.com/category/233386/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (259, 1, 'NBC 10 Philadelphia', 100, 'http://www.nbcphiladelphia.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, NULL, '', NULL, 'http://www.nbcphiladelphia.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (456, 1, 'FOX 31', 82, 'http://www.kdvr.com/news/rss2.0.xml', '', -1, 0, NULL, '', NULL, 'http://kdvr.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (219, 1, 'L.A Times', 115, 'http://www.latimes.com/local/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/local/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (971, 1, 'Colorado Springs Gazette RSS - news >> local', 129, 'http://gazette.com/rss/news/local', '', 0, 0, NULL, '', NULL, 'http://gazette.com/rss/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (434, 1, 'Common Appeal', 123, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=10001', '', -1, 0, NULL, '', NULL, 'http://www.commercialappeal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1063, 1, 'Fox 30', 148, 'http://www.fox30jax.com/list/rss/ap/florida/florida-news/aHG/', '', 0, 0, NULL, '', NULL, 'http://www.fox30jax.com/list/ap/florida/florida-news/aHG/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (925, 1, 'The A.V. Club', 16, 'http://www.avclub.com/feed/rss/?tags=music', '', 0, 0, NULL, '', NULL, 'http://www.avclub.com/search?tags=music', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (631, 1, 'Oddee.com', 52, 'http://www.oddee.com/rss.aspx', '', 0, 0, NULL, '', NULL, 'http://www.oddee.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (269, 1, 'FOX 10 News Phoenix', 137, 'http://www.fox10phoenix.com/category/233272/local-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.fox10phoenix.com/category/233272/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (401, 1, 'FOX Charlotte', 174, 'http://www.wccbcharlotte.com/news/local/index.rss2', '', -1, 0, NULL, '', NULL, 'http://www.wccbcharlotte.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (270, 1, 'KPHO Phoenix', 137, 'http://www.kpho.com/category/216452/kpho-newstream?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.kpho.com/category/216452/cbs5-newstream', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (19, 1, 'L.A. Times', 9, 'http://feeds.latimes.com/LATIMES/ENTERTAINMENT/NEWS/MOVIES/', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/entertainment/movies/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (914, 1, 'NBC Miami', 152, 'http://www.nbcmiami.com/news/top-stories/?rss=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcmiami.com/news/top-stories', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (397, 1, 'The Charlotte Observer', 98, 'http://www.charlotteobserver.com/local/index.rss', '', -1, 0, NULL, '', NULL, 'http://www.charlotteobserver.com/141/index.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (831, 1, 'The Guardian', 59, 'http://www.theguardian.com/sport/boxing/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/sport/boxing', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 52, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (416, 1, 'WXYZ', 93, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10001', '', -1, 0, NULL, '', NULL, 'http://www.wxyz.com/working', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1034, 1, 'MyFox Atlanta', 122, 'http://www.myfoxatlanta.com/category/233685/local-news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxatlanta.com/category/233685/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (422, 1, 'CBS Detroit', 93, 'http://detroit.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://detroit.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1164, 1, 'WBRZ', 195, 'http://www.wbrz.com/feeds/rssfeed.cfm?category=281&cat_name=Community', '', 0, 0, NULL, '', NULL, 'http://www.wbrz.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1191, 1, '1030 KVOI AM', 207, 'http://www.kvoi.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.kvoi.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (307, 1, 'Mercury News Sports', NULL, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200223.xml', '', 0, 0, NULL, '', NULL, 'http://www.mercurynews.com/sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 49, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1017, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/insects_and_butterflies', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/insects_and_butterflies/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 36, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (498, 1, 'CBS Baltimore', 106, 'http://baltimore.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://baltimore.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (481, 1, 'CBS Boston', 110, 'http://boston.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://boston.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (451, 1, 'KOMO News', 130, 'http://www.komonews.com/news/local/index.rss', '', -1, 0, NULL, '', NULL, 'http://www.komonews.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (21, 1, 'Box Office', 9, 'http://feeds.feedburner.com/THR/BOXOFFICE', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/3495/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (22, 1, 'Awards', 9, 'http://feeds.feedburner.com/THR/AWARDS', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/7739/all/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (41, 1, 'GamesRadar', 24, 'http://www.gamesradar.com/all-platforms/news/rss', '', 0, 0, NULL, '', NULL, 'http://www.gamesradar.com/all-platforms/news/rss/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (24, 1, 'The Guardian', 9, 'http://www.theguardian.com/film/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/us/film', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1275, 1, 'Sports Illustrated', 34, 'http://www.si.com/rss/si_soccer.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_soccer.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (297, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/233338/local-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.fox4news.com/category/233338/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 44, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (180, 1, 'BBC Sport', 31, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/tennis/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/tennis/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (560, 1, 'Live Science', 41, 'http://www.livescience.com/home/feed/site.xml', '', 0, 0, NULL, '', NULL, 'http://www.livescience.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (94, 1, 'FOX News', 7, 'http://feeds.foxnews.com/foxnews/national', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1001, 1, 'Astrology and Horoscope 2015 by www.findyourfate.com', NULL, 'http://www.findyourfate.com/rss/horoscope-astrology.asp', '', 0, 0, NULL, '', NULL, 'http://www.findyourfate.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1183, 1, 'Fox 34', 205, 'http://www.fox34.com/category/301948/local-news', '', 0, 0, NULL, '', NULL, 'http://www.myfoxlubbock.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1015, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/frogs_and_reptiles', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/frogs_and_reptiles/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 37, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (33, 1, 'Rolling Stone', 16, 'http://www.rollingstone.com/music.rss', '', 0, 0, NULL, '', NULL, 'http://www.rollingstone.com/music', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (838, 1, 'NPR', 38, 'http://www.npr.org/rss/rss.php?id=1006', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1006', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (162, 1, 'CBS Sports', 28, 'http://www.cbssports.com/partners/feeds/rss/mlb_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/mlb', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1157, 1, 'Dallas Morning News', 192, 'http://www.dallasnews.com/news/community-news/irving/?rss', '', 0, 0, NULL, '', NULL, 'http://www.dallasnews.com/news/community-news/irving/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1253, 1, 'CBS Sports', 29, 'http://www.cbssports.com/partners/feeds/rss/cb_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/collegebasketball', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1058, 1, 'Star Local', 147, 'http://starlocalmedia.com/search/?q=&t=article&l=10&d=&d1=&d2=&s=start_time&sd=desc&c[]=live_and_local,live_and_local/*&f=rss', '', 0, 0, NULL, '', NULL, 'http://starlocalmedia.com/search/?q=&t=article&l=10&d=&d1=&d2=&s=start_time&sd=desc&c[]=live_and_local,live_and_local/*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1219, 1, 'Puppy In Training', 116, 'http://feeds2.feedburner.com/puppyintraining', '', 0, 0, NULL, '', NULL, 'http://puppyintraining.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1094, 1, 'Local 12', 162, 'http://www.local12.com/news/features/top-stories//rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.local12.com/news/features/top-stories/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1195, 1, 'The Collegian', 208, 'http://collegian.csufresno.edu/feed/', '', 0, 0, NULL, '', NULL, 'http://collegian.csufresno.edu', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (682, 1, 'CS Monitor', 41, 'http://rss.csmonitor.com/feeds/science', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1066, 1, 'Local 10', 152, 'http://www.local10.com/Local-10-Mobile/3972514?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.local10.com/Local-10-Mobile/3972514', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (505, 1, 'News OK', 79, 'http://newsok.com/rss/sports', '', 0, 0, NULL, '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (211, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/news/politics/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcnewyork.com/news/politics', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (910, 1, 'New Electronics News', 17, 'http://www.newelectronics.co.uk/rss/news/4#', '', 0, 0, NULL, '', NULL, 'http://www.newelectronics.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (486, 1, 'Boston Sports Media Watch', 110, 'http://feeds2.feedburner.com/BostonSportsMediaWatch', '', 0, 0, NULL, '', NULL, 'http://www.bostonsportsmedia.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (174, 1, 'USA TODAY', 30, 'http://rssfeeds.usatoday.com/UsatodaycomNhl-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (713, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/55', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/hunting_fishing', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 66, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1136, 1, 'Detroit | WXYZ', 175, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=30466', '', 0, 0, NULL, '', NULL, 'http://www.wxyz.com/detroit', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (164, 1, 'USA TODAY', 28, 'http://rssfeeds.usatoday.com/UsatodaycomMlb-TopStories', '', 0, 0, NULL, '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (348, 1, 'KRON 4', 125, 'http://kron4.com/feed/', '', -1, 0, NULL, '', NULL, 'http://kron4.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (994, 1, 'The Hockey News', 30, 'http://thehockeynews.com.feedsportal.com/c/34166/f/621201/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.thehockeynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (52, 1, 'AdWeek', 14, 'http://feeds.adweek.com/adweek/adfreak?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.adweek.com/adfreak', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1024, 1, 'Hampton Roads', 121, 'http://hamptonroads.com/taxterm/3', '', 0, 0, NULL, '', NULL, 'http://hamptonroads.com/taxonomy/term/3', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (65, 1, 'NPR', 25, 'http://www.npr.org/rss/rss.php?id=1032', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1032', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (68, 1, 'Publishers Weekly', 25, 'http://www.publishersweekly.com/pw/feeds/recent/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.publishersweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (70, 1, 'FN Dish', 20, 'http://blog.foodnetwork.com/fn-dish/feed/', '', 0, 0, NULL, '', NULL, 'http://blog.foodnetwork.com/fn-dish', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (71, 1, 'Bon Appétit', 20, 'http://www.bonappetit.com/rss2', '', 0, 0, NULL, '', NULL, 'http://www.bonappetit.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (612, 1, 'CBS Sacramento', 119, 'http://sacramento.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://sacramento.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (91, 1, 'CNN Money', 26, 'http://rss.cnn.com/RSS/MONEY_PF.RSS', '', 0, 0, NULL, '', NULL, 'http://money.cnn.com/pf/?section=money_pf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (101, 1, 'BBC', 36, 'http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/news/world/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (613, 1, 'FOX 40', 119, 'http://feeds.feedburner.com/Ktxl-Fox40NewsAtTen', '', -1, 0, NULL, '', NULL, 'http://fox40.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (129, 1, 'NASA', 41, 'http://www.nasa.gov/rss/universe.rss', '', 0, 0, NULL, '', NULL, 'http://www.nasa.gov/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 28, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (802, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 42, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (752, 1, 'Off Road Xtreme', 60, 'http://www.offroadxtreme.com/rss/', '', 0, 0, NULL, '', NULL, 'http://www.offroadxtreme.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (619, 1, 'KCTV Kansas City', 83, 'http://www.kctv5.com/category/210833/app-news?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.kctv5.com/category/210833/app-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (280, 1, 'Fox San Antonio', 138, 'http://www.foxsanantonio.com/news/features/top-stories/rss.xml', '', -1, 0, NULL, '', NULL, 'http://www.foxsanantonio.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (255, 1, 'Philly.com', 136, 'http://www.philly.com/philly_news.rss', '', -1, 0, NULL, '', NULL, 'http://www.philly.com/r?19=960&32=3796&7=195202&40=http%3A%2F%2Fwww.philly.com%2Fphilly%2Fnews%2F', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (37, 1, 'British Comedy Guide', 11, 'http://feeds.feedburner.com/BRITISHCOMEDYNEWS', '', 0, 0, NULL, '', NULL, 'http://www.comedy.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (289, 1, 'KPBS News', 125, 'http://feeds.kpbs.org/kpbs/local?format=xml', '', -1, 0, NULL, '', NULL, 'http://www.kpbs.org/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (38, 1, 'College Humor', 11, 'http://www.collegehumor.com/ORIGINALS/RSS', '', 0, 0, NULL, '', NULL, 'http://www.collegehumor.comhttp://www.collegehumor.com/originals', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1212, 1, 'WAVY-TV', 211, 'http://wavy.com/feed/', '', 0, 0, NULL, '', NULL, 'http://wavy.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1258, 1, 'New York Times', 29, 'http://rss.nytimes.com/services/xml/rss/nyt/ProBasketball.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/basketball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (39, 1, 'IGN', 24, 'http://feeds.ign.com/IGN/ALL', '', 0, 0, NULL, '', NULL, 'http://www.ign.com/articles', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (402, 1, 'WCNC', 98, 'http://www.wcnc.com/news/local/index.rss2', '', -1, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (400, 1, 'WSOC', 174, 'http://www.wsoctv.com/list/rss/news/local/latest-news/mxc/', '', -1, 0, NULL, '', NULL, 'http://www.wsoctv.com/list/news/latest-news/mxc/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (221, 1, 'LA Daily News', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000019&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (341, 1, 'Pro Sports Blogging', NULL, 'http://www.prosportsblogging.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.prosportsblogging.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 47, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1264, 1, 'Yahoo Sports', 29, 'https://sports.yahoo.com/nba/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/nba', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (636, 1, 'Unexplained Mysteries', 52, 'http://www.unexplained-mysteries.com/news/umnews.xml', '', 0, 0, NULL, '', NULL, 'http://www.unexplained-mysteries.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (695, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/24', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/track_and_field', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 67, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (468, 1, 'CBS DC', 114, 'http://washington.cbslocal.com/feed/', '', -1, 0, NULL, '', NULL, 'http://washington.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (480, 1, 'WHDH-TV', 110, 'http://www.whdh.com/?clienttype=rss', '', -1, 0, NULL, '', NULL, 'http://www.whdh.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (464, 1, 'WashTimes', 114, 'http://washingtontimes.com/rss/headlines/news/local/', '', -1, 0, NULL, '', NULL, 'http://www.washingtontimes.com/news/local/?utm_medium=RSS', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (254, 1, 'SB Nation Houston', 131, 'http://houston.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://houston.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1265, 1, 'Yahoo Sports', 29, 'https://sports.yahoo.com/ncaab/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/ncaab', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (524, 1, 'Louisville Sports Live', 95, 'http://louisvillesportslive.net/feed/', '', 0, 0, NULL, '', NULL, 'http://louisvillesportslive.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (271, 1, 'KPHO Phoenix', 137, 'http://www.kpho.com/category/13566/national-sports?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.cbs5az.com/category/13566/national-sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (901, 1, 'IGN Articles', 24, 'http://feeds.ign.com/ign/articles', '', 0, 0, NULL, '', NULL, 'http://www.ign.com/articles', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (598, 1, 'Ripley''s Nature & Places', 53, 'http://www.ripleys.com/bions/planet/feed/', '', 0, 0, NULL, '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1119, 1, 'Hawaii News Now', 176, 'http://www.hawaiinewsnow.com/Global/category.asp?C=3497&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.hawaiinewsnow.com/category/3497/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (916, 1, 'NBC 4i', 150, 'http://nbc4i.com/feed/', '', 0, 0, NULL, '', NULL, 'http://nbc4i.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (320, 1, 'The Austin Chronicle', 144, 'http://www.austinchronicle.com/gyrobase/rss/sports.xml', '', 0, 0, NULL, '', NULL, 'http://www.austinchronicle.com/rss/sports.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1022, 1, 'Huffington Post – Pets', 116, 'http://www.huffingtonpost.com/news/pet/feed//', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tag/pet', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (846, 1, 'Teen Vogue Fashion', 18, 'http://www.teenvogue.com/services/rss/feeds/fashion.xml', '', 0, 0, NULL, '', NULL, 'http://www.teenvogue.com/fashion', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (95, 1, 'WashPost', 7, 'http://feeds.washingtonpost.com/rss/national', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/national/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1122, 1, 'MyFox Austin', 144, 'http://www.myfoxaustin.com/category/234942/local?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxaustin.com/category/234942/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (850, 1, 'Media Matters', 37, 'http://feeds.mediamatters.org/mediamatters/latest?format=xml', '', 0, 0, NULL, '', NULL, 'http://mediamatters.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (12, 1, 'Perez Hilton', 8, 'http://i.perezhilton.com/?feed=rss2', '', 0, 0, NULL, '', NULL, 'http://perezhilton.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (26, 1, 'Screen Rant', 9, 'http://screenrant.com/feed/', '', 0, 0, NULL, '', NULL, 'http://screenrant.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (469, 1, 'WTOP', 114, 'http://wtop.com/region/local/feed/', '', -1, 0, NULL, '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (264, 1, 'CSN Philly Sports', 100, 'http://www.csnphilly.com/rss-top-headlines.xml', '', 0, 0, NULL, '', NULL, 'http://www.csnphilly.com/rss-top-headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (584, 1, 'LA Times', 20, 'http://www.latimes.com/food/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/food/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (626, 1, 'Sunny Skyz', 48, 'http://feeds.feedburner.com/SunnySkyz', '', 0, 0, NULL, '', NULL, 'http://www.sunnyskyz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (203, 1, 'New York Post Sports', 66, 'http://nypost.com/sports/feed/', '', 0, 0, NULL, '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (352, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124643', '', 0, 0, NULL, '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1226, 1, 'ScienceDaily', 40, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_health?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/top/health/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (696, 1, 'U.S. News', 40, 'http://www.usnews.com/rss/health?int=a7fe09', '', 0, 0, NULL, '', NULL, 'http://health.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (93, 1, 'U.S. News', 26, 'http://www.usnews.com/rss/money?int=a48e09', '', 0, 0, NULL, '', NULL, 'http://money.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (643, 1, 'TheMovieBox.Net', 58, 'http://feeds.feedburner.com/themovieboxnet/', '', 0, 0, NULL, '', NULL, 'http://themoviebox.net/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1004, 1, 'Milwaukee County News', NULL, 'http://www.wisn.com/10149330?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.wisn.com/10149330', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (848, 1, 'B of F', 18, 'http://www.businessoffashion.com/syndication/feed', '', 0, 0, NULL, '', NULL, 'http://www.businessoffashion.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (225, 1, 'CBS Los Angeles', 115, 'http://losangeles.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://losangeles.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1249, 1, 'USA TODAY', 29, 'http://rssfeeds.usatoday.com/UsatodaycomCollegeMensBasketball-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1196, 1, 'North Fresno News', 208, 'http://northfresno.kmph.com/feed/rss.xml', '', 0, 0, NULL, '', NULL, 'http://northfresno.kmph.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (240, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcchicago.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1081, 1, 'News Net 5', 157, 'http://scrippsobfeeds2.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10003&categoryId=20000', '', 0, 0, NULL, '', NULL, 'http://www.newsnet5.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (466, 1, 'Roll Call', 37, 'http://www.rollcall.com/politics/archives/?zkDo=showRSS', '', -1, 0, NULL, '', NULL, 'http://www.rollcall.com/rss/all_news.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (929, 1, 'EDM.com', 16, 'http://feeds.edm.com/edm/news', '', 0, 0, NULL, '', NULL, 'http://edm.com/articles?type=1', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (926, 1, 'KOTATV', 85, 'http://www.kotatv.com/news/south-dakota-news/27244182?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.kotatv.com/news/south-dakota-news/27244182', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (940, 1, 'VH1', 16, 'http://www.vh1.com/rss/news/today_on_vh1.jhtml', '', 0, 0, NULL, '', NULL, 'http://www.vh1.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (104, 1, 'CNN', 37, 'http://rss.cnn.com/rss/cnn_allpolitics.rss', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/POLITICS/index.html?eref=rss_politics', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (606, 1, 'Quote of the Day', 214, 'http://feeds.feedburner.com/brainyquote/QUOTEBR', '', 15, 5, NULL, '', NULL, 'http://www.brainyquote.com/link/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (79, 1, 'Motor Trend', 22, 'http://www.motortrend.com/widgetrss/motortrend-roadtests.xml', '', 0, 0, NULL, '', NULL, 'http://www.motortrend.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1201, 1, 'Grunion Gazette - Long Beach', 209, 'http://www.gazettes.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=longbeach*&f=rss', '', 0, 0, NULL, '', NULL, 'http://www.gazettes.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=longbeach*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (702, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/35', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/surfing', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (708, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/22', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/horse_racing', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 64, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (193, 1, 'Major League Soccer', 34, 'http://www.mlssoccer.com/rss/en.xml', '', 0, 0, NULL, '', NULL, 'http://www.mlssoccer.com/rss-feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1230, 1, 'Cosmopolitan', 18, 'http://cosmo.intoday.in.feedsportal.com/c/34156/f/618495/index.rss?http://cosmo.intoday.in/cosmo_rss.jsp?stId=264', '', 0, 0, NULL, '', NULL, 'http://www.cosmo.intoday.in', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (663, 1, 'NDTV', 59, 'http://feeds.feedburner.com/ndtv/qJNd', '', 0, 0, NULL, '', NULL, 'http://sports.ndtv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 69, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (975, 1, 'Quartz', 38, 'http://qz.com/feed/', '', 0, 0, NULL, '', NULL, 'http://qz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (275, 1, 'My SA', NULL, 'http://www.mysanantonio.com/default/feed/local-news-176.php', '', -1, 0, NULL, '', NULL, 'http://www.mysanantonio.com/default/feed/local-news-176.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 48, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (800, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/swimming-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 44, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1053, 1, 'Review Journal', 143, 'http://www.reviewjournal.com/news/feed', '', 0, 0, NULL, '', NULL, 'http://www.reviewjournal.com/rss.xml/1', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (207, 1, 'Metro Sports', NULL, 'http://www.metro.us/rss.xml?c=1410180502-1', '', 0, 0, NULL, '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 45, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (250, 1, 'KPRC Houston', 131, 'http://www.click2houston.com/5536186?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.click2houston.com/5536186', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (518, 1, 'Jayski''s NASCAR Silly Season Site', NULL, 'http://www.jayski.com/jayski.rss', '', 0, 0, NULL, '', NULL, 'http://www.jayski.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (10, 1, 'E!', 8, 'http://feeds.eonline.com/eonline/topstories', '', 0, 0, NULL, '', NULL, 'http://www.eonline.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1167, 1, 'My News 4', 196, 'http://www.mynews4.com/rss/3298.rss', '', 0, 0, NULL, '', NULL, 'http://www.mynews4.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (148, 1, 'Five Thirty Eight', 44, 'http://fivethirtyeight.com/contributors/nate-silver/feed/', '', 0, 0, NULL, '', NULL, 'http://fivethirtyeight.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1129, 1, 'Denver Post', 179, 'http://feeds.denverpost.com/dp-news-local-aurora', '', 0, 0, NULL, '', NULL, 'http://www.denverpost.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (671, 1, 'LA Business Journal', 39, 'http://labusinessjournal.com/rss/headlines/la-technology/', '', 0, 0, NULL, '', NULL, 'http://labusinessjournal.com/news/la-technology/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (905, 1, 'This Old House', 21, 'http://feeds.thisoldhouse.com/ThisOldHouseLatest', '', 0, 0, NULL, '', NULL, 'http://www.thisoldhouse.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (204, 1, 'New York Post', 66, 'http://nypost.com/entertainment/feed/', '', 0, 0, NULL, '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (691, 1, 'MMA Fighting', 59, 'http://www.mmafighting.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://www.mmafighting.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (964, 1, 'ABC News', 80, 'http://abcnews.go.com/topics/urss?pageid=1085236', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (105, 1, 'CNN', NULL, 'http://rss.cnn.com/RSS/CNN_TOPSTORIES.RSS', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/index.html?eref=rss_topstories', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (23, 1, 'Variety', 9, 'http://feeds.feedburner.com/variety/news/frontpage', '', 0, 0, NULL, '', NULL, 'http://variety.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (717, 1, 'Reuters', 39, 'http://feeds.reuters.com/reuters/technologyNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (88, 1, 'GameSpot', 24, 'http://www.gamespot.com/feeds/new-games/', '', 0, 0, NULL, '', NULL, 'http://www.gamespot.com/feeds/new-games/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (902, 1, 'Mother Jones', 41, 'http://www.motherjones.com/rss/sections/Environment/feed', '', 0, 0, NULL, '', NULL, 'http://www.motherjones.com/politics/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1074, 1, 'News On 6', 154, 'http://www.newson6.com/category/208401/newson6com-news-rss?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.newson6.com/category/208401/newson6com-news-rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1059, 1, 'ABC 11', 145, 'http://cdn.abclocal.go.com/wtvd/xml?id=7095536', '', 0, 0, NULL, '', NULL, 'http://abclocal.go.com/wtvd/index', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (731, 1, 'HuffPost', 25, 'http://www.huffingtonpost.com/feeds/verticals/books/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (674, 1, 'CS Monitor', 39, 'http://rss.csmonitor.com/feeds/scitech', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (688, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/25', '', 0, 0, NULL, '', NULL, 'http://www.yardbarker.com/mma', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 63, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (369, 1, 'The Guardian', 55, 'http://www.theguardian.com/artanddesign/art/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/artanddesign/art', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1011, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/cats', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/cats/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 39, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1178, 1, 'Local Channel 3000', 203, 'http://www.channel3000.com/16042556?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.channel3000.com/16042556', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (216, 1, 'Sports Blog New York', 66, 'http://sportsblognewyork.com/feed/', '', 0, 0, NULL, '', NULL, 'http://sportsblognewyork.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1269, 1, 'Sports Illustrated', 27, 'http://www.si.com/rss/si_nfl.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_nfl.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (230, 1, 'SB Nation Los Angeles', 63, 'http://losangeles.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://losangeles.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1185, 1, 'WPRI 12', 206, 'http://wpri.com/feed/', '', 0, 0, NULL, '', NULL, 'http://wpri.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1244, 1, 'Bleacher Report', 28, 'http://bleacherreport.com/articles/feed?tag_id=18', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1280, 1, 'Associated Press', 36, 'http://hosted2.ap.org/atom/APDEFAULT/cae69a7523db45408eeb2b3a98c0c9c5', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (226, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/news/local/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbclosangeles.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1282, 1, 'Associated Press', 38, 'http://hosted2.ap.org/atom/APDEFAULT/f70471f764144b2fab526d39972d37b3', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (77, 1, 'Automotive News', 22, 'http://feeds.feedburner.com/autonews/BreakingNews', '', 0, 0, NULL, '', NULL, 'http://www.autonews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (120, 1, 'WIRED', 39, 'http://feeds.wired.com/wired/index', '', 0, 0, NULL, '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (733, 1, 'The Independent', 25, 'http://rss.feedsportal.com/c/266/f/3847/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/arts-entertainment/books/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1194, 1, 'FresnoStateNews.com', 208, 'http://feeds.feedburner.com/fresnostatenews?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.fresnostatenews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (123, 1, 'CIO UK', 39, 'http://rss.feedsportal.com/c/663/f/8422/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.cio.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (869, 1, 'Columbia Journalism Review', 43, 'http://cjr.org/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.cjr.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1232, 1, 'Future Music', 16, 'http://futuremusic.com/feed/', '', 0, 0, NULL, '', NULL, 'http://futuremusic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1013, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/dogs', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/dogs/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 34, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1084, 1, 'Essex County', 159, 'http://blog.nj.com/essex_impact/atom.xml', '', 0, 0, NULL, '', NULL, 'http://www.nj.com/essex/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (976, 1, 'Local News | BellinghamHerald.com &', 69, 'http://www.bellinghamherald.com/news/local/?widgetName=rssfeed&widgetContentId=21615405&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.bellinghamherald.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1006, 1, 'Quinnipiac Polls', 44, 'http://www.quinnipiac.edu/news-and-events/quinnipiac-university-poll/rss-polling-aggregate/', '', 0, 0, NULL, '', NULL, 'http://www.quinnipiac.edu', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1277, 1, 'Sports Illustrated', 60, 'http://www.si.com/rss/si_motorsports.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_motorsports.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (99, 1, 'CNN', NULL, 'http://rss.cnn.com/rss/cnn_latest.rss', '', 0, 0, NULL, '', NULL, 'http://www.cnn.com/?eref=rss_latest', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (812, 1, 'Travel Business News', 23, 'http://feeds.bizjournals.com/industry_12', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (157, 1, 'FOX Sports', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (806, 1, 'NCAA', 59, 'http://www.ncaa.com/news/icehockey-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/icehockey-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 25, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1137, 1, 'KMOV', 182, 'http://www.kmov.com/category/216452/kpho-newstream?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.kmov.com/category/216452/cbs5-newstream', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (828, 1, 'The Guardian', 59, 'http://www.theguardian.com/sport/rugby-union/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/sport/rugby-union', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 51, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (782, 1, 'Climbing', 60, 'http://www.climbing.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.climbing.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (777, 1, 'NCAA', 59, 'http://www.ncaa.com/news/volleyball-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/volleyball-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 40, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (304, 1, 'SB Nation Dallas', 134, 'http://dallas.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://dallas.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (662, 1, 'Cricbuzz', 59, 'http://live-feeds.cricbuzz.com/CricbuzzFeed', '', 0, 0, NULL, '', NULL, 'http://www.cricbuzz.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 68, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (778, 1, 'NCAA', 59, 'http://www.ncaa.com/news/waterpolo-men/nc/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/waterpolo-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 48, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1166, 1, 'KOLO', 196, 'http://www.kolotv.com/home/headlines/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.kolotv.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (775, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 29, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (794, 1, 'The full pint', 51, 'http://thefullpint.com/feed/', '', 0, 0, NULL, '', NULL, 'http://thefullpint.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (301, 1, 'NBC 5 Dallas', 134, 'http://www.nbcdfw.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcdfw.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1283, 1, 'Associated Press', 7, 'http://hosted2.ap.org/atom/APDEFAULT/386c25518f464186bf7a2ac026580ce7', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1163, 1, 'The Advocate', 195, 'http://theadvocate.com/feed?feedName=News&feedURL=http://theadvocate.com/news/&publication=Advocate&sections=/news/&areas=Stories&counts=20&feedContentPage=/shared/templates/feeds/rss2.csp', '', 0, 0, NULL, '', NULL, 'http://theadvocate.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (418, 1, 'ABC Detroit', 93, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10008', '', 0, 0, NULL, '', NULL, 'http://www.wxyz.com/cma', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1079, 1, 'KSTP', 156, 'http://kstp.com/rssFeeds/rss1.xml', '', 0, 0, NULL, '', NULL, 'http://kstp.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (959, 1, 'Muslim Voices', 49, 'http://feeds.feedburner.com/MuslimVoicesBlog', '', 0, 0, NULL, '', NULL, 'http://muslimvoices.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (842, 1, 'Mental Floss', 11, 'http://mentalfloss.com/feeds/all', '', 0, 0, NULL, '', NULL, 'http://mentalfloss.com/feeds/all', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (833, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/rugby-union/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/rugby-union/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1132, 1, 'KBOI 2 News', 181, 'http://www.kboi2.com/news/?fin=xml&type=default&c=y', '', 0, 0, NULL, '', NULL, 'http://www.kboi2.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (673, 1, 'LA Business Journal', 40, 'http://labusinessjournal.com/rss/headlines/la-healthcare/', '', 0, 0, NULL, '', NULL, 'http://labusinessjournal.com/news/la-healthcare/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (47, 1, 'Viral Viral Videos', 13, 'http://feeds.feedburner.com/viralviralvideos', '', 0, 0, NULL, '', NULL, 'http://www.viralviralvideos.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1052, 1, 'Colorado Springs Independent', 129, 'http://www.csindy.com/coloradosprings/Rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.csindy.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (231, 1, 'KABC-TV', 115, 'http://cdn.abclocal.go.com/kabc/xml?id=7075946', '', 0, 0, NULL, '', NULL, 'http://abclocal.go.com/kabc/index', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (502, 1, 'Baltimore Sun', 106, 'http://www.baltimoresun.com/sports/baltimore-sports-blog/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.baltimoresun.com/sports/baltimore-sports-blog/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (543, 1, 'Religion In Africa', NULL, 'http://religioninafrica.com/feed/', '', 0, 0, NULL, '', NULL, 'http://religioninafrica.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (718, 1, 'Reuters', 41, 'http://feeds.reuters.com/reuters/scienceNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (478, 1, 'WCVB Sports', NULL, 'http://www.wcvb.com/9849852?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.wcvb.com/9849852', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 31, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (921, 1, 'fox8.com', 73, 'http://fox8.com/feed/', '', 0, 0, NULL, '', NULL, 'http://fox8.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (922, 1, 'KGWN', 85, 'http://www.kgwn.tv/home/headlines/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.kgwn.tv/home/headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (779, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/wrestling/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 47, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1042, 1, 'NBC 33', 133, 'http://www.21alive.com/news/local/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.21alive.com/news/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (783, 1, 'DPM Climbing', 60, 'http://feeds.feedburner.com/deadpoint?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.dpmclimbing.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (210, 1, 'CBS New York', 66, 'http://newyork.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://newyork.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (787, 1, 'Transworld Skateboarding', 60, 'http://skateboarding.transworld.net/feed/', '', 0, 0, NULL, '', NULL, 'http://skateboarding.transworld.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (152, 1, 'Bleacher Report', 27, 'http://bleacherreport.com/articles/feed?tag_id=23', '', 0, 0, NULL, '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1041, 1, 'WANE', 133, 'http://wane.com/feed/', '', 0, 0, NULL, '', NULL, 'http://wane.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1205, 1, 'Kansas City Local News', 70, 'http://kcmetro.com/local-news/kansas-city/feed/rss.html', '', 0, 0, NULL, '', NULL, 'http://kcmetro.com/local-news/kansas-city/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (181, 1, 'BBC Sport', 32, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/golf/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/golf/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (704, 1, 'ABC News', 23, 'http://feeds.abcnews.com/abcnews/travelheadlines', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/Travel/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (958, 1, 'Discovery', 53, 'http://feeds.feedburner.com/20ThingsYouDidntKnowAbout', '', 0, 0, NULL, '', NULL, 'http://discovermagazine.com/rss/department-feeds/20-things', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (592, 1, 'HowStuffWorks', 41, 'http://syndication.howstuffworks.com/rss/science', '', 0, 0, NULL, '', NULL, 'http://science.howstuffworks.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (690, 1, 'CS Monitor', 36, 'http://rss.csmonitor.com/feeds/world', '', 0, 0, NULL, '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (988, 1, 'New York Times', 28, 'http://rss.nytimes.com/services/xml/rss/nyt/Baseball.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/baseball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (789, 1, 'Skateboarder Magazine', 60, 'http://www.skateboardermag.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.skateboardermag.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1268, 1, 'Yahoo Sports', 34, 'https://sports.yahoo.com/soccer/rss.xml', '', 0, 0, NULL, '', NULL, 'http://sports.yahoo.com/soccer/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (759, 1, 'Transworld BMX', 60, 'http://bmx.transworld.net/feed/', '', 0, 0, NULL, '', NULL, 'http://bmx.transworld.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (772, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/golf-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 43, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (788, 1, 'Thrasher Magazine', 60, 'http://www.thrashermagazine.com/en/rss/junk-drawer-feed/', '', 0, 0, NULL, '', NULL, 'http://www.thrashermagazine.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1148, 1, 'Breaking Fremont News', 189, 'http://breakingfremontnews.com/feed/', '', 0, 0, NULL, '', NULL, 'http://breakingfremontnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (632, 1, 'Uncut', 16, 'http://www.uncut.co.uk/feed', '', 0, 0, NULL, '', NULL, 'http://www.uncut.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (932, 1, 'Modern Hiker', 51, 'http://www.modernhiker.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.modernhiker.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1018, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/mice', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/mice/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 31, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (977, 1, 'Longview Daily News', 69, 'http://tdn.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', 0, 0, NULL, '', NULL, 'http://tdn.com/search/?f=rss&k%5B%5D=%23topstory&l=50&s=start_time&sd=desc&t=article', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (983, 1, 'Fox13now', 71, 'http://fox13now.com/feed/', '', 0, 0, NULL, '', NULL, 'http://fox13now.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1138, 1, 'Detroit Free Press', 175, 'http://rssfeeds.freep.com/freep/home&x=1', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (511, 1, 'News OK', 79, 'http://newsok.com/rss/Jason%20Kersey', '', 0, 0, NULL, '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1159, 1, '13 News Now', 193, 'http://rssfeeds.13newsnow.com/wvec/local', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (185, 1, 'ESPN', 32, 'http://sports.espn.go.com/espn/rss/golf/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (729, 1, 'Forbes', 38, 'http://www.forbes.com/entrepreneurs/feed2/', '', 0, 0, NULL, '', NULL, 'http://www.forbes.com/entrepreneurs/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (993, 1, 'The Sydney Morning Herald articles', 59, 'http://www.smh.com.au/rssheadlines/cricket/article/rss.xml', '', 0, 0, NULL, '', NULL, 'http://smh.com.au', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (14, 1, 'Defamer', 8, 'http://defamer.gawker.com/rss', '', 0, 0, NULL, '', NULL, 'http://defamer.gawker.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (992, 1, 'The Dysfunctional Tennis Blog', 31, 'http://feeds.feedburner.com/tennisx', '', 0, 0, NULL, '', NULL, 'http://www.tennis-x.com/xblog', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (855, 1, 'Huff Post', 21, 'http://www.huffingtonpost.com/news/interior-design/feed//', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tag/interior-design', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (69, 1, 'Epicurious.com', 20, 'http://FEEDS.FEEDBURNER.COM/EPICURIOUS/EPIBLOG?FORMAT=XML', '', 0, 0, NULL, '', NULL, 'http://www.epicurious.com/features/blogs/editor/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (141, 1, 'ScienceDaily', 41, 'http://www.sciencedaily.com/rss/top/environment.xml', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/top/environment/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 23, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (100, 1, 'FOX News', 36, 'http://feeds.foxnews.com/foxnews/world', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (36, 1, 'Comedy News', 11, 'http://feeds.feedburner.com/COMEDYNEWSORG/PUBLISHEDNEWS', '', 0, 0, NULL, '', NULL, 'http://www.comedynews.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1276, 1, 'Sports Illustrated', 31, 'http://www.si.com/rss/si_tennis.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_tennis.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (931, 1, 'Your EDM', 16, 'http://www.youredm.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.youredm.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (818, 1, 'The Independent', 59, 'http://www.independent.co.uk/sport/general/athletics/?service=rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/sport/general/athletics/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 56, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (145, 1, 'Worldwide Religious News', 49, 'http://wwrn.org/rss/', '', 0, 0, NULL, '', NULL, 'http://wwrn.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (500, 1, 'WMAR Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=10004', '', 0, 0, NULL, '', NULL, 'http://www.abc2news.com/worldcup', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 33, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (577, 1, 'Health.com', 20, 'http://www.health.com/health/food-recipes/feed', '', 0, 0, NULL, '', NULL, 'http://www.health.com/health/food-recipes', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (646, 1, 'Screen Rant', 9, 'http://feeds.feedburner.com/ScreenRant', '', 0, 0, NULL, '', NULL, 'http://screenrant.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (907, 1, 'CNET iPhone Update', 17, 'http://www.cnet.com/rss/iphone-update/', '', 0, 0, NULL, '', NULL, 'http://www.cnet.com/#ftag=CAD4aa2096', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1071, 1, 'The Oakland Post', 153, 'http://www.oaklandpostonline.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news*&f=rss', '', 0, 0, NULL, '', NULL, 'http://www.oaklandpostonline.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1000, 1, 'AstroSage.com Daily Horoscope', NULL, 'http://feeds.feedburner.com/dayhoroscope', '', 0, 0, NULL, '', NULL, 'http://www.astrosage.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1208, 1, 'KMBC', 83, 'http://www.kmbc.com/11665144?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.kmbc.com/11665144', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (827, 1, 'Swimming World News', 59, 'http://www.swimmingworldmagazine.com/news/feed/', '', 0, 0, NULL, '', NULL, 'http://www.swimmingworldmagazine.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 50, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1135, 1, 'stltoday.com', 182, 'http://www.stltoday.com/search/?c=news%2Flocal,news%2flocal%2f*&d1=&d2=&s=start_time&sd=desc&l=50&f=rss&t=article', '', 0, 0, NULL, '', NULL, 'http://www.stltoday.com/search/?c=news%2Flocal,news%2flocal%2f*&d1=&d2=&s=start_time&sd=desc&l=50&f=rss&t=article', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (256, 1, 'Philly.com Sports', 100, 'http://www.philly.com/philly_sports.rss', '', 0, 0, NULL, '', NULL, 'http://www.philly.com/r?19=960&32=3796&7=195227&40=http%3A%2F%2Fwww.philly.com%2Fphilly%2Fsports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (588, 1, 'NPR', 24, 'http://www.npr.org/rss/rss.php?id=1052', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1052', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (81, 1, 'HuffPost', 19, 'http://www.huffingtonpost.com/feeds/verticals/health-fitness/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/health-fitness/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (923, 1, 'NYT', 9, 'http://rss.nytimes.com/services/xml/rss/nyt/Movies.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/movies/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (143, 1, 'U.S. EPA', 41, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate?opendocument', '', 0, 0, NULL, '', NULL, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate!open', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 25, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (963, 1, 'KOB.com', 80, 'http://www.kob.com/rssFeeds/rss504.xml', '', 0, 0, NULL, '', NULL, 'http://www.kob.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (751, 1, 'Four Wheeler', 60, 'http://www.fourwheeler.com/rss/news/', '', 0, 0, NULL, '', NULL, 'http://www.fourwheeler.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (915, 1, 'Sun Sentinel', 68, 'http://www.sun-sentinel.com/news/florida/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.sun-sentinel.com/news/florida/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (83, 1, 'Muscle & Fitness', 19, 'http://www.muscleandfitness.com/RSS.XML', '', 0, 0, NULL, '', NULL, 'http://www.muscleandfitness.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (587, 1, 'NPR', 20, 'http://www.npr.org/rss/rss.php?id=1053', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1053', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1238, 1, 'ESPN.com', 60, 'http://sports.espn.go.com/espn/rss/action/news', '', 0, 0, NULL, '', NULL, 'http://sports.espn.go.com/action/index', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1133, 1, 'San Jose / Valley News', 146, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200749.xml', '', 0, 0, NULL, '', NULL, 'http://www.mercurynews.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (672, 1, 'HeraldNet.com', 51, 'http://www.heraldnet.com/section/RSS16&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.heraldnet.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1109, 1, 'FOX 8 News', 164, 'http://www.fox8live.com/category/235041/local-news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.fox8live.com/category/235041/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (541, 1, 'Christian Headlines', 49, 'http://www.christianheadlines.com/rss/', '', 0, 0, NULL, '', NULL, 'http://www.christianheadlines.com/rss/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1236, 1, 'ProSoccerTalk', 34, 'http://prosoccertalk.nbcsports.com/feed/', '', 0, 0, NULL, '', NULL, 'http://soccer.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (844, 1, 'NYT', 37, 'http://rss.nytimes.com/services/xml/rss/nyt/Politics.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/politics/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (856, 1, 'RT', 36, 'http://rt.com/rss/', '', 0, 0, NULL, '', NULL, 'https://www.rt.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (579, 1, 'Med News Today', 19, 'http://www.medicalnewstoday.com/rss/sports_medicine.xml', '', 0, 0, NULL, '', NULL, 'http://www.medicalnewstoday.com/sections/sports_medicine/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (149, 1, 'Gallup', 44, 'http://www.gallup.com/TAG/ALL+GALLUP+HEADLINES.RSS', '', 0, 0, NULL, '', NULL, 'http://www.gallup.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (310, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcbayarea.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (582, 1, 'SF Gate -Wine', 20, 'http://www.sfgate.com/rss/feed/Wine-551.php', '', 0, 0, NULL, '', NULL, 'http://www.sfgate.com/rss/feed/Wine-551.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1279, 1, 'Local News | The Sacramento Bee & Sacbee.com', 119, 'http://www.sacbee.com/news/local/?widgetName=rssfeed&widgetContentId=713546&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.sacbee.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (368, 1, 'NYT', 55, 'http://rss.nytimes.com/services/xml/rss/nyt/Arts.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/arts/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (698, 1, 'NBC News', 40, 'http://feeds.nbcnews.com/feeds/health', '', 0, 0, NULL, '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (163, 1, 'FOX Sports', 28, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1257, 1, 'New York Times', 29, 'http://rss.nytimes.com/services/xml/rss/nyt/CollegeBasketball.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/sports/ncaabasketball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (411, 1, 'Star-Telegram', NULL, 'http://www.star-telegram.com/sports/?widgetName=rssfeed&widgetContentId=714290&getXmlFeed=true', '', 0, 0, NULL, '', NULL, 'http://www.star-telegram.com/sports/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 21, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1270, 1, 'Sports Illustrated', 28, 'http://www.si.com/rss/si_mlb.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_mlb.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (803, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 28, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1121, 1, 'Civil Beat', 176, 'http://www.civilbeat.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.civilbeat.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (728, 1, 'WashPost', 25, 'http://feeds.washingtonpost.com/rss/entertainment/books', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/entertainment/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1223, 1, 'Pawcurious', 116, 'http://feeds.feedburner.com/Pawcurious?format=xml', '', 0, 0, NULL, '', NULL, 'http://pawcurious.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (410, 1, 'CBS 11', 134, 'http://cbs11tv.com/entertainment/resources_rss.xml', '', 0, 0, NULL, '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (377, 1, 'Beautiful Decay', 55, 'http://feeds.feedburner.com/beautifuldecay/OhOn', '', 0, 0, NULL, '', NULL, 'http://beautifuldecay.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1216, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/fieldhockey/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (144, 1, 'HuffPost', 49, 'http://www.huffingtonpost.com/FEEDS/VERTICALS/RELIGION/INDEX.XML', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/religion/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (568, 1, 'TV.com', 10, 'http://createfeed.fivefilters.org/extract.php?url=www.tv.com%2F&in_id_or_class=&url_contains=', '', 0, 0, NULL, '', NULL, 'http://www.tv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (25, 1, 'The Race', 9, 'http://feeds.feedburner.com/HOLLYWOODREPORTER-THERACE?FORMAT=XML', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/76/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1271, 1, 'Sports Illustrated', 29, 'http://www.si.com/rss/si_nba.rss', '', 0, 0, NULL, '', NULL, 'http://www.si.com/si_nba.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1217, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/fieldhockey/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1228, 1, 'ScienceDaily', 52, 'http://feeds.sciencedaily.com/sciencedaily/strange_offbeat?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/strange_offbeat/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1175, 1, 'KOAT 7', 198, 'http://www.koat.com/9154708?format=rss_2.0&view=feed', '', 0, 0, NULL, '', NULL, 'http://www.koat.com/9154708', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (277, 1, 'San Antonio Express', 138, 'http://www.mysanantonio.com/rss/feed/mySA-Entertainment-923.php', '', 0, 0, NULL, '', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Entertainment-923.php', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (795, 1, 'National Speed Sport News', 59, 'http://www.nationalspeedsportnews.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.nationalspeedsportnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 22, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (797, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/swimming-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 36, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (791, 1, 'HuffPost', 51, 'http://www.huffingtonpost.com/news/cooking-how-to/feed//', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/tag/cooking-how-to', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (650, 1, 'Adweek', NULL, 'http://feeds.adweek.com/adweek/television', '', 0, 0, NULL, '', NULL, 'http://www.adweek.com/adweek/feeds/106', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (61, 1, 'NYT', 17, 'http://rss.nytimes.com/services/xml/rss/nyt/PersonalTech.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/technology/personaltech/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1246, 1, 'Engadget', 39, 'http://www.engadget.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.engadget.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1116, 1, 'Star Advertiser', 176, 'http://www.staradvertiser.com/news/hawaiinews/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.staradvertiser.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (709, 1, 'NBC News', 23, 'http://feeds.nbcnews.com/feeds/travel', '', 0, 0, NULL, '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (423, 1, 'Detroit Sports Nation', 93, 'http://detroitsportsnation.com/feed/', '', 0, 0, NULL, '', NULL, 'http://detroitsportsnation.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (707, 1, 'USA TODAY', 23, 'http://rssfeeds.usatoday.com/UsatodaycomTravel-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1030, 1, 'My Fox Tampa Bay', 124, 'http://www.myfoxtampabay.com/category/233680/local?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxtampabay.com/category/233680/local', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (386, 1, 'WBNS Sports', NULL, 'http://www.10tv.com/content/syndication/sports.xml', '', 0, 0, NULL, '', NULL, 'http://www.10tv.com/content/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 32, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (562, 1, 'Scientific American', 41, 'http://rss.sciam.com/sciam/society-and-policy', '', 0, 0, NULL, '', NULL, 'http://www.scientificamerican.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1010, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/birds', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/plants_animals/birds/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 30, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (494, 1, 'On the Forecheck', 30, 'http://www.ontheforecheck.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://www.ontheforecheck.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (957, 1, 'Discovery', 41, 'http://feeds.feedburner.com/DiscoverEnvironment', '', 0, 0, NULL, '', NULL, 'http://discovermagazine.com/rss/topic-feeds/environment', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (549, 1, 'New Urban Legends', 50, 'http://www.snopes.com/info/whatsnew.xml', '', 0, 0, NULL, '', NULL, 'http://www.snopes.com/info/whatsnew.asp', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (917, 1, 'ABC Ohio', 73, 'http://abcnews.go.com/topics/urss?pageid=1085217', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (781, 1, 'Rock And Ice Magazine', 60, 'http://www.rockandice.com/RSSRetrieve.aspx?ID=13126&Type=RSS20', '', 0, 0, NULL, '', NULL, 'http://www.rockandice.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (190, 1, 'FOX Sports', 34, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (122, 1, 'NYT', 39, 'http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/technology/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (554, 1, 'Radar Online', 50, 'http://www.radaronline.com/rss', '', 0, 0, NULL, '', NULL, 'http://radaronline.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (796, 1, 'BeerPulse', 51, 'http://feeds.feedburner.com/beerpulse', '', 0, 0, NULL, '', NULL, 'http://beerpulse.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (421, 1, 'FOX Detroit', 93, 'http://www.myfoxdetroit.com/category/238935/entertainment?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxdetroit.com/category/238935/entertainment', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1025, 1, 'Fox 43', 121, 'http://fox43tv.com/feed/', '', 0, 0, NULL, '', NULL, 'http://fox43tv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (790, 1, 'LoveKnitting Blog', 51, 'http://blog.loveknitting.com/feed/', '', 0, 0, NULL, '', NULL, 'http://blog.loveknitting.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (819, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/swimming/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/swimming/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (267, 1, 'Phoenix Business Journal', 137, 'http://feeds.bizjournals.com/bizj_phoenix', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1186, 1, 'Tucson- Arizona Daily Star', 207, 'http://tucson.com/search/?f=rss&c=news&l=25&s=start_time&sd=desc', '', 0, 0, NULL, '', NULL, 'http://tucson.com/search/?f=rss&c=news&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (131, 1, 'Scientific American', 41, 'http://rss.sciam.com/ScientificAmerican-News', '', 0, 0, NULL, '', NULL, 'http://www.scientificamerican.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 26, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (364, 1, 'ARTnews', 55, 'http://www.artnews.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.artnews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (647, 1, 'CNET', 24, 'http://www.cnet.com/rss/gaming/', '', 0, 0, NULL, '', NULL, 'http://www.cnet.com/#ftag=CADa872701', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1154, 1, 'Milwaukee Neighborhood News Service', 191, 'http://milwaukeenns.org/feed/', '', 0, 0, NULL, '', NULL, 'http://milwaukeenns.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (7, 1, 'TMZ', 8, 'http://www.tmz.com/RSS.XML', '', 0, 0, NULL, '', NULL, 'http://www.tmz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (769, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fencing/nc/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/fencing/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 33, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (75, 1, 'Dezeen', 21, 'http://feeds.feedburner.com/DEZEEN', '', 0, 0, NULL, '', NULL, 'http://www.dezeen.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1112, 1, 'Local News | CCCT', 170, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100101&categoryId=20000', '', 0, 0, NULL, '', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (936, 1, 'BuzzFeed', 8, 'http://www.buzzfeed.com/celebrity.xml', '', 0, 0, NULL, '', NULL, 'http://www.buzzfeed.com/celeb', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (882, 1, 'LA Times', 8, 'http://www.latimes.com/entertainment/gossip/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/entertainment/gossip/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1220, 1, 'That Pet Blog', 116, 'http://feeds.feedburner.com/ThatPetBlog?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.thatpetblog.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1284, 1, 'Associated Press', 39, 'http://hosted2.ap.org/atom/APDEFAULT/495d344a0d10421e9baa8ee77029cfbd', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (785, 1, 'Cycling Weekly', NULL, 'http://www.cyclingweekly.co.uk/feed', '', 0, 0, NULL, '', NULL, 'http://www.cyclingweekly.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (114, 1, 'FOX Business', 38, 'http://feeds.foxbusiness.com/FOXBUSINESS/LATEST', '', 0, 0, NULL, '', NULL, 'http://www.foxbusiness.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (623, 1, 'SB Nation Kansas City', 83, 'http://kansascity.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://kansascity.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (697, 1, 'History', 53, 'http://www.history.com//news/feed/rss2', '', 0, 0, NULL, '', NULL, 'http://www.history.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1049, 1, 'KSNB', 140, 'http://www.nbcneb.com/home/headlines/index.rss2', '', 0, 0, NULL, '', NULL, 'http://www.nbcneb.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (624, 1, 'SportingKC', 34, 'http://www.sportingkc.com/rss/en.xml', '', 0, 0, NULL, '', NULL, 'http://www.sportingkc.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (63, 1, 'Electronic Design', 17, 'http://electronicdesign.com/rss.xml', '', 0, 0, NULL, '', NULL, 'http://electronicdesign.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (879, 1, 'WashPost', 36, 'http://feeds.washingtonpost.com/rss/world', '', 0, 0, NULL, '', NULL, 'http://www.washingtonpost.com/pb/world/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (817, 1, 'Ripley''s Amazing Animals', 52, 'http://www.ripleys.com/bions/animals/feed/', '', 0, 0, NULL, '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (208, 1, 'Metro', NULL, 'http://www.metro.us/rss.xml?c=1410180502-2', '', 0, 0, NULL, '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 25, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1124, 1, 'WISH-TV', 171, 'http://wishtv.com/feed/', '', 0, 0, NULL, '', NULL, 'http://wishtv.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (375, 1, 'Huff Post', 55, 'http://www.huffingtonpost.com/feeds/verticals/arts/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/arts/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (178, 1, 'USA TODAY', 31, 'http://rssfeeds.usatoday.com/UsatodayTennis-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (874, 1, 'The Guardian', 36, 'http://www.theguardian.com/world/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/world', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (116, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7031.xml', '', 0, 0, NULL, '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (996, 1, 'CHN', 30, 'http://www.collegehockeynews.com/news/xml/newsfeed.xml', '', 0, 0, NULL, '', NULL, 'http://collegehockeynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (346, 1, 'Complex Music', 16, 'http://assets.complex.com/feeds/channels/music.xml', '', 0, 0, NULL, '', NULL, 'http://www.complex.com/music', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1229, 1, 'Cosmopolitan', 8, 'http://cosmo.intoday.in.feedsportal.com/c/34156/f/618495/index.rss?http://cosmo.intoday.in/cosmo_rss.jsp?stId=263', '', 0, 0, NULL, '', NULL, 'http://www.cosmo.intoday.in', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (508, 1, 'KOCO Sports', NULL, 'http://www.koco.com/sports/topstory.rss', '', 0, 0, NULL, '', NULL, 'http://www.koco.com/9844982', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 30, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (59, 1, 'Engadget', 17, 'http://www.engadget.com/tag/mobile/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.engadget.com/tag/mobile/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (119, 1, 'TechCrunch', 39, 'http://feeds.feedburner.com/TechCrunch/', '', 0, 0, NULL, '', NULL, 'http://techcrunch.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (188, 1, 'BBC Sport', 59, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/cricket/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/cricket/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (585, 1, 'Food Safety News', 20, 'http://feeds.lexblog.com/foodsafetynews/mRcs', '', 0, 0, NULL, '', NULL, 'http://www.foodsafetynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (485, 1, 'Sports of Boston', 110, 'http://feeds.sportsofboston.com/SportsofBoston?format=xml', '', 0, 0, NULL, '', NULL, 'http://sportsofboston.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (84, 1, 'FOX News', 23, 'http://feeds.foxnews.com/FOXNEWS/INTERNAL/TRAVEL/MIXED', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (871, 1, 'AdWeek', 43, 'http://feeds.adweek.com/adweek/all-news', '', 0, 0, NULL, '', NULL, 'http://www.adweek.com/adweek/feeds/%2A', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (158, 1, 'FOX Sports', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (492, 1, 'News Channel 5', NULL, 'http://www.scrippsmedia.com/newschannel5/news/sports/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.scrippsmedia.com/templates/Lib.Feed.xml?path=/newschannel5/news/sports&format=RSSFull&limit=50', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 26, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (42, 1, 'Eurogamer.net', 24, 'http://www.eurogamer.net/?format=rss', '', 0, 0, NULL, '', NULL, 'http://www.eurogamer.net/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (749, 1, 'Universal Sports', 33, 'http://universalsports.com/winter-sports/feed/', '', 0, 0, NULL, '', NULL, 'http://universalsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (968, 1, 'POLITICO', 37, 'http://www.politico.com/rss/politicopicks.xml', '', 0, 0, NULL, '', NULL, 'http://www.politico.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (903, 1, 'WWD', 18, 'http://wwd.com/custom-feed/fashion/', '', 0, 0, NULL, '', NULL, 'http://wwd.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (872, 1, 'The Independent', 43, 'http://rss.feedsportal.com/c/266/f/3524/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/news/media/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (692, 1, 'MMA Junkie', 59, 'http://www.mmajunkie.com/news/rss', '', 0, 0, NULL, '', NULL, 'http://mmajunkie.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (881, 1, 'LA Times', 7, 'http://www.latimes.com/nation/rss2.0.xml', '', 0, 0, NULL, '', NULL, 'http://www.latimes.com/nation/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (169, 1, 'FOX Sports', 29, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', 0, 0, NULL, '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (939, 1, 'TrailerAddict', 58, 'http://www.traileraddict.com/rss', '', 0, 0, NULL, '', NULL, 'http://www.traileraddict.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1064, 1, 'KETV', 149, 'http://www.ketv.com/9675452?format=rss_2.0&view=asFeed', '', 0, 0, NULL, '', NULL, 'http://www.ketv.com/9675452', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (112, 1, 'HuffPost', 37, 'http://feeds.huffingtonpost.com/c/35496/f/677086/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/politics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (658, 1, 'Cracked', 11, 'http://feeds.feedburner.com/CrackedRSS', '', 0, 0, NULL, '', NULL, 'http://www.cracked.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (710, 1, 'HuffPost', 23, 'http://www.huffingtonpost.com/feeds/verticals/travel/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/travel/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1070, 1, 'The Oakland Press', 153, 'http://www.theoaklandpress.com/section?template=RSS&profile=4001177&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.theoaklandpress.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (484, 1, 'SB Nation Boston', 110, 'http://boston.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://boston.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (538, 1, 'The Vegas Parlay', 70, 'http://feeds.feedburner.com/TheVegasParlay?format=xml', '', 0, 0, NULL, '', NULL, 'http://thevegasparlay.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1227, 1, 'ScienceDaily', 39, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_technology?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.sciencedaily.com/news/top/technology/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (382, 1, 'Weird Florida', 52, 'http://wlrn.org/feeds/1128/rss.xml', '', 0, 0, NULL, '', NULL, 'http://wlrn.org', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 12, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (703, 1, 'Surfline', 60, 'http://www.surfline.com/rss/surfnews.cfm', '', 0, 0, NULL, '', NULL, 'http://www.surfline.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 14, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (676, 1, 'The Guardian', 51, 'http://www.theguardian.com/sport/chess/rss', '', 0, 0, NULL, '', NULL, 'http://www.theguardian.com/sport/chess', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 10, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (908, 1, 'CNET Android Update', 17, 'http://www.cnet.com/rss/android-update/', '', 0, 0, NULL, '', NULL, 'http://www.cnet.com/#ftag=CADe34d7bf', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (50, 1, 'Clever Ideas, Great Ads', 14, 'http://great-ads.blogspot.com/feeds/posts/default', '', 0, 0, NULL, '', NULL, 'http://great-ads.blogspot.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (990, 1, 'News', 31, 'http://www.wtatennis.com/feed.rss/category/12009823,12010172,12010877/limit/20/page/news/request/article', '', 0, 0, NULL, '', NULL, 'http://www.wtatennis.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (196, 1, 'HistoryOrb.com', NULL, 'http://feeds.feedburner.com/historyorb/todayinhistory', '', 0, 0, NULL, '', NULL, 'http://www.onthisday.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (408, 1, 'Fort Worth Business Press', 173, 'http://www.fwbusinesspress.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&nsa=eedition&c[]=news,news/*&f=rss', '', 0, 0, NULL, '', NULL, 'http://www.fortworthbusiness.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&nsa=eedition&c%5B%5D=news,news/*&f=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (542, 1, 'PBS', 49, 'http://www.pbs.org/wnet/religionandethics/feed/', '', 0, 0, NULL, '', NULL, 'http://www.pbs.org/wnet/religionandethics', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (187, 1, 'The Ski Channel', 33, 'http://www.theskichannel.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.theskichannel.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (924, 1, 'The A.V. Club', 9, 'http://www.avclub.com/feed/rss/?tags=film', '', 0, 0, NULL, '', NULL, 'http://www.avclub.com/search?tags=film', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1134, 1, 'Boise Weekly', 181, 'http://www.boiseweekly.com/boise/Rss.xml?section=920003', '', 0, 0, NULL, '', NULL, 'http://www.boiseweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (344, 1, 'San Francisco Business Times', 118, 'http://feeds.bizjournals.com/bizj_sanfrancisco', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1118, 1, 'Action News Jax', 148, 'http://www.actionnewsjax.com/list/rss/ap/florida/florida-news/aHG/', '', 0, 0, NULL, '', NULL, 'http://www.actionnewsjax.com/list/ap/florida/florida-news/aHG/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (288, 1, 'CBS 8', 125, 'http://www.cbs8.com/Global/category.asp?clienttype=rss_img&C=154659', '', 0, 0, NULL, '', NULL, 'http://www.cbs8.com/category/154659/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1061, 1, 'The Raleigh Telegram', 145, 'http://raleightelegram.com/feed', '', 0, 0, NULL, '', NULL, 'http://raleightelegram.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (997, 1, 'Tennis Channel', 31, 'http://tennischannel.com/feed/', '', 0, 0, NULL, '', NULL, 'http://tennischannel.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1285, 1, 'Associated Press', 40, 'http://hosted2.ap.org/atom/APDEFAULT/bbd825583c8542898e6fa7d440b9febc', '', 0, 0, NULL, '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (766, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/cross-country-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 37, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (470, 1, 'WTOP Sports', NULL, 'http://wtop.com/section/sports/feed', '', 0, 0, NULL, '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 41, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (359, 1, 'BET', NULL, 'http://feeds.bet.com/BETcom-SportsNews', '', 0, 0, NULL, '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 42, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (376, 1, 'The Art Newspaper', 55, 'http://www.theartnewspaper.com/rss/', '', 0, 0, NULL, '', NULL, 'http://178.23.169.98', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (868, 1, 'Knight Foundation', 43, 'http://www.knightfoundation.org/rss/', '', 0, 0, NULL, '', NULL, 'http://www.knightfoundation.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1162, 1, 'Breaking Irvine News', 194, 'http://breakingirvinenews.com/feed/', '', 0, 0, NULL, '', NULL, 'http://breakingirvinenews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (866, 1, 'The Huffington Post', 43, 'http://www.huffingtonpost.com/feeds/verticals/media/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/media/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1068, 1, 'CBS Miami', 152, 'http://miami.cbslocal.com/feed/', '', 0, 0, NULL, '', NULL, 'http://miami.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (191, 1, 'USA TODAY', 34, 'http://rssfeeds.usatoday.com/UsatodaycomSoccer-TopStories', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1095, 1, 'CityBeat', 162, 'http://citybeat.com/cincinnati/rss-34-1-blogs.xml', '', 0, 0, NULL, '', NULL, 'http://www.citybeat.com/cincinnati/blogs-1-1-1-34.html', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (223, 1, 'LA Daily News', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000040&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (425, 1, 'SB Nation Detroit', 93, 'http://detroit.sbnation.com/rss/current', '', 0, 0, NULL, '', NULL, 'http://detroit.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (522, 1, 'WHAS11 Sports', NULL, 'http://rssfeeds.whas11.com/whas/sports', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 38, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (390, 1, 'WOSU News Sports', NULL, 'http://wosu.org/2012/news-archive/category/sports/feed', '', 0, 0, NULL, '', NULL, 'http://wosu.org/2012/news-archive', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 40, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1215, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/fieldhockey/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (859, 1, 'Polygon', 24, 'http://www.polygon.com/rss/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.polygon.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1005, 1, 'La Crosse Tribune - Regional and State News', 64, 'http://lacrossetribune.com/search/?f=rss&c=news/state-and-regional/wi&l=25&s=start_time&sd=desc', '', 0, 0, NULL, '', NULL, 'http://lacrossetribune.com/search/?f=rss&c=news/state-and-regional/wi&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (206, 1, 'Metro', 66, 'http://www.metro.us/rss.xml?c=1414044023-4', '', 0, 0, NULL, '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (55, 1, 'Telegraph Fashion', 18, 'http://fashion.telegraph.co.uk/RSS/', '', 0, 0, NULL, '', NULL, 'http://fashion.telegraph.co.uk/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (720, 1, 'Reuters', 8, 'http://feeds.reuters.com/reuters/peopleNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (202, 1, 'New York Post', 66, 'http://nypost.com/news/feed/', '', 0, 0, NULL, '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (214, 1, 'myfoxny.com', 66, 'http://www.myfoxny.com/category/233104/local-news?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.myfoxny.com/category/233104/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (209, 1, 'NYU News', 66, 'http://www.nyunews.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.nyunews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (161, 1, 'ESPN', 28, 'http://sports.espn.go.com/espn/rss/mlb/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (154, 1, 'ESPN', 27, 'http://sports.espn.go.com/espn/rss/ncf/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 18, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (357, 1, 'BET', 18, 'http://feeds.bet.com/BETcom-FashionBeauty', '', 0, 0, NULL, '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (241, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcchicago.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (821, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/cycling/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/cycling/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 6, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1158, 1, 'Rambler Newspapers', 192, 'http://ramblernewspapers.com/category/irving/feed/', '', 0, 0, NULL, '', NULL, 'http://ramblernewspapers.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (820, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/athletics/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/sport/0/athletics/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (137, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Environment.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/science/earth/index.html?partner=rss&emc=rss', '', NULL, false, '', false, false, false, false, false, false, NULL, NULL, 0, false, 18, true, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (826, 1, 'The Roar', 59, 'http://feeds.theroar.com.au/theroar/cricket', '', 0, 0, NULL, '', NULL, 'http://www.theroar.com.au', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 58, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1184, 1, 'KFYO 790', 205, 'http://kfyo.com/feed/', '', 0, 0, NULL, '', NULL, 'http://kfyo.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (928, 1, 'NYT', 10, 'http://rss.nytimes.com/services/xml/rss/nyt/Television.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/arts/television/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (201, 1, 'SPIN', 16, 'http://www.spin.com/feed/', '', 0, 0, NULL, '', NULL, 'http://www.spin.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 20, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (927, 1, 'The Billings Gazette', 85, 'http://billingsgazette.com/search/?f=rss&c=news/state-and-regional/wyoming&l=25&s=start_time&sd=desc', '', 0, 0, NULL, '', NULL, 'http://billingsgazette.com/search/?f=rss&c=news/state-and-regional/wyoming&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (694, 1, 'NPR', 16, 'http://www.npr.org/rss/rss.php?id=1039', '', 0, 0, NULL, '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1039', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 8, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (98, 1, 'CNN', NULL, 'http://rss.cnn.com/rss/edition.rss', '', 0, 0, NULL, '', NULL, 'http://edition.cnn.com/index.html?eref=edition', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1130, 1, 'New Santa Ana', 180, 'http://feeds.feedburner.com/NewSantaAna', '', 0, 0, NULL, '', NULL, 'http://newsantaana.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (949, 1, 'Daily Mail', 36, 'http://www.dailymail.co.uk/news/worldnews/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.dailymail.co.uk/news/worldnews/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (153, 1, 'ESPN', 27, 'http://sports.espn.go.com/espn/rss/nfl/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (570, 1, 'Television', 10, 'http://feeds.feedburner.com/thr/television', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/60/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (311, 1, 'Mashable', 39, 'http://feeds.mashable.com/mashable/tech', '', 0, 0, NULL, '', NULL, 'http://mashable.com/category/tech/?utm_campaign=Mash-Prod-RSS-Feedburner-Tech-Partial&utm_cid=Mash-Prod-RSS-Feedburner-Tech-Partial', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (155, 1, 'CBS Sports', 27, 'http://www.cbssports.com/partners/feeds/rss/nfl_news', '', 0, 0, NULL, '', NULL, 'http://www.cbssports.com/nfl', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 22, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (829, 1, 'ESPN', 59, 'http://sports-ak.espn.go.com/espn/rss/horse/news', '', 0, 0, NULL, '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (834, 1, 'Boxing News', 59, 'http://www.boxing.com/news/rss', '', 0, 0, NULL, '', NULL, 'http://www.boxing.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 16, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (234, 1, 'Chicago Sun Times', 120, 'http://chicago.suntimes.com/feed/', '', 0, 0, NULL, '', NULL, 'http://chicago.suntimes.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (160, 1, 'USA TODAY', 27, 'http://rssfeeds.usatoday.com/UsatodaycomCollegeFootball-TopStories', '', 0, 0, NULL, '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 23, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (648, 1, 'Media', NULL, 'http://www.ft.com/rss/companies/media', '', 0, 0, NULL, '', NULL, 'http://www.ft.com/companies/media', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 9, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (399, 1, 'The Charlotte Observer', 174, 'http://www.charlotteobserver.com/entertainment/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.charlotteobserver.com/122/index.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (804, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 35, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (815, 1, 'Bizjournals', 26, 'http://feeds.bizjournals.com/industry_2', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1127, 1, 'The Orange County Register', 178, 'http://www.ocregister.com/common/rss/rss.php?catID=18860', '', 0, 0, NULL, '', NULL, 'http://www.ocregister.com/common/archives/?catID=18860', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1170, 1, 'ABC 15', 200, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10008&categoryId=20415', '', 0, 0, NULL, '', NULL, 'http://www.abc15.com/southernarizona', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (227, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbclosangeles.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (970, 1, 'Denver Post', 82, 'http://feeds.denverpost.com/dp-news-breaking?_ga=1.259951821.670207890.1435690703', '', 0, 0, NULL, '', NULL, 'http://www.denverpost.com/breakingnews/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (213, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcnewyork.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (299, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/233343/entertainment?clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.fox4news.com/category/233343/entertainment', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 24, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (305, 1, 'The Dallas Sports Rant', 67, 'http://feeds.feedburner.com/DallasSportsRant?format=xml', '', 0, 0, NULL, '', NULL, 'http://www.dallassportsrant.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (32, 1, 'Billboard.com', 16, 'http://billboard.feedsportal.com/34735/f/639534/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.billboard.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 17, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (792, 1, 'SpeedwayMedia.com', 59, 'http://www.speedwaymedia.com/?feed=rss2&cat=56', '', 0, 0, NULL, '', NULL, 'http://www.speedwaymedia.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 49, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (809, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d2/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/wrestling/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 41, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (667, 1, 'Ripley''s Amazing Humans', 52, 'http://www.ripleys.com/bions/humans/feed/', '', 0, 0, NULL, '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (810, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d3/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/wrestling/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 24, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (640, 1, 'Reuters', 52, 'http://feeds.reuters.com/reuters/oddlyEnoughNews', '', 0, 0, NULL, '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 7, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (816, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/3798/index.rss', '', 0, 0, NULL, '', NULL, 'http://www.independent.co.uk/sport/motor-racing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 55, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (642, 1, 'NME', 16, 'http://www.nme.com/rss/news', '', 0, 0, NULL, '', NULL, 'http://www.nme.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 11, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (813, 1, 'Bizjournals', 41, 'http://feeds.bizjournals.com/industry_24', '', 0, 0, NULL, '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (649, 1, 'Adweek', 14, 'http://feeds.adweek.com/adweek/advertising-branding', '', 0, 0, NULL, '', NULL, 'http://www.adweek.com/adweek/feeds/11', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (295, 1, 'Pitchfork', 16, 'http://pitchfork.com/rss/news/', '', 0, 0, NULL, '', NULL, 'http://pitchfork.com/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 19, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1239, 1, 'NBA.com', 29, 'http://www.nba.com/rss/nba_rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.nba.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (763, 1, 'NCAA', 29, 'http://www.ncaa.com/news/basketball-men/d1/rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.ncaa.com/news/basketball-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 5, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (892, 1, 'StyleCaster', 18, 'http://stylecaster.com/feed/', '', 0, 0, NULL, '', NULL, 'http://stylecaster.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (31, 1, 'Hollywood Reporter', 10, 'http://feed.hollywoodreporter.com/LIVE_FEED', '', 0, 0, NULL, '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/72/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (906, 1, 'CNET', 39, 'http://www.cnet.com/rss/news/', '', 0, 0, NULL, '', NULL, 'http://www.cnet.com/#ftag=CAD590a51e', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (563, 1, 'Discover', 41, 'http://feeds.feedburner.com/DiscoverEnvironment?format=xml', '', 0, 0, NULL, '', NULL, 'http://discovermagazine.com/rss/topic-feeds/environment', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (261, 1, 'NBC Philadelphia', 100, 'http://www.nbcphiladelphia.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, NULL, '', NULL, 'http://www.nbcphiladelphia.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (133, 1, 'BBC', 41, 'http://feeds.bbci.co.uk/news/science_and_environment/rss.xml?edition=uk', '', 0, 0, NULL, '', NULL, 'http://www.bbc.co.uk/news/science_and_environment/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (127, 1, 'FOX', 40, 'http://feeds.foxnews.com/FOXNEWS/HEALTH', '', 0, 0, NULL, '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 15, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1209, 1, 'Mesa Independent', 210, 'http://feeds.feedblitz.com/mesaindependent', '', 0, 0, NULL, '', NULL, 'http://mesaindependent.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1210, 1, 'AZCentral', 210, 'http://rssfeeds.azcentral.com/phoenix/mesa', '', 0, 0, NULL, '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1199, 1, 'Long Beach Press Telegram', 209, 'http://www.presstelegram.com/section?template=RSS&profile=4000254&mime=xml', '', 0, 0, NULL, '', NULL, 'http://www.presstelegram.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 3, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (128, 1, 'ABC News', 40, 'http://feeds.abcnews.com/ABCNEWS/HEALTHHEADLINES', '', 0, 0, NULL, '', NULL, 'http://abcnews.go.com/Health/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1193, 1, 'KMPH Fox 26', 208, 'http://www.kmph-kfre.com/Global/category.asp?C=109555&clienttype=rss', '', 0, 0, NULL, '', NULL, 'http://www.kmph-kfre.com/category/109555/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 2, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1198, 1, 'ABC 30 – Central Valley News', 208, 'http://cdn.abclocal.go.com/kfsn/xml?id=7110337', '', 0, 0, NULL, '', NULL, 'http://abclocal.go.com/kfsn/channel?section=news/local&id=7110337', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (1187, 1, 'Tucson Weekly', 207, 'http://www.tucsonweekly.com/tucson/Rss.xml', '', 0, 0, NULL, '', NULL, 'http://www.tucsonweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (139, 1, 'HuffPost', 41, 'http://www.huffingtonpost.com/feeds/verticals/science/index.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/science/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 24, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (140, 1, 'WIRED', 41, 'http://www.wired.com/category/science/feed/', '', 0, 0, NULL, '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 29, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (546, 1, 'Beliefnet', 49, 'http://www.beliefnet.com/Feeds/All.aspx', '', 0, 0, NULL, '', NULL, 'http://www.beliefnet.com/Feeds/All.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 0, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (136, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Space.xml', '', 0, 0, NULL, '', NULL, 'http://www.nytimes.com/pages/science/space/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 22, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (891, 1, 'HuffPost', 38, 'http://www.huffingtonpost.com/feeds/verticals/business/news.xml', '', 0, 0, NULL, '', NULL, 'http://www.huffingtonpost.com/business/', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 1, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (894, 1, 'WSJ', 39, 'http://www.wsj.com/xml/rss/3_7455.xml', '', 0, 0, NULL, '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 4, false, false, false, '', 0, NULL, '', false);
INSERT INTO ttrss_feeds VALUES (358, 1, 'BET', 40, 'http://feeds.bet.com/BETcom-Health', '', 0, 0, NULL, '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, NULL, 0, false, 13, false, false, false, '', 0, NULL, '', false);


--
-- Name: ttrss_feeds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_feeds_id_seq', 196, true);


--
-- Data for Name: ttrss_filter_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_filter_actions VALUES (1, 'filter', 'Delete article');
INSERT INTO ttrss_filter_actions VALUES (2, 'catchup', 'Mark as read');
INSERT INTO ttrss_filter_actions VALUES (3, 'mark', 'Set starred');
INSERT INTO ttrss_filter_actions VALUES (4, 'tag', 'Assign tags');
INSERT INTO ttrss_filter_actions VALUES (5, 'publish', 'Publish article');
INSERT INTO ttrss_filter_actions VALUES (6, 'score', 'Modify score');
INSERT INTO ttrss_filter_actions VALUES (7, 'label', 'Assign label');
INSERT INTO ttrss_filter_actions VALUES (8, 'stop', 'Stop / Do nothing');
INSERT INTO ttrss_filter_actions VALUES (9, 'plugin', 'Invoke plugin');


--
-- Data for Name: ttrss_filter_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_filter_types VALUES (1, 'title', 'Title');
INSERT INTO ttrss_filter_types VALUES (2, 'content', 'Content');
INSERT INTO ttrss_filter_types VALUES (3, 'both', 'Title or Content');
INSERT INTO ttrss_filter_types VALUES (4, 'link', 'Link');
INSERT INTO ttrss_filter_types VALUES (5, 'date', 'Article Date');
INSERT INTO ttrss_filter_types VALUES (6, 'author', 'Author');
INSERT INTO ttrss_filter_types VALUES (7, 'tag', 'Article Tags');


--
-- Data for Name: ttrss_filters2; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: ttrss_filters2_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Name: ttrss_filters2_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_filters2_actions_id_seq', 1, false);


--
-- Name: ttrss_filters2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_filters2_id_seq', 1, false);

--
-- Data for Name: ttrss_filters2_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_filters2_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_filters2_rules_id_seq', 1, false);

--
-- Data for Name: ttrss_labels2; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_labels2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_labels2_id_seq', 1, false);


--
-- Data for Name: ttrss_linked_feeds; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_linked_instances; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Name: ttrss_linked_instances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_linked_instances_id_seq', 1, false);

--
-- Data for Name: ttrss_plugin_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_plugin_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_plugin_storage_id_seq', 1, false);

--
-- Data for Name: ttrss_prefs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_prefs VALUES ('PURGE_OLD_DAYS', 3, 1, 0, '60');
INSERT INTO ttrss_prefs VALUES ('DEFAULT_UPDATE_INTERVAL', 3, 1, 0, '30');
INSERT INTO ttrss_prefs VALUES ('DEFAULT_ARTICLE_LIMIT', 3, 2, 0, '30');
INSERT INTO ttrss_prefs VALUES ('ALLOW_DUPLICATE_POSTS', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('ENABLE_FEED_CATS', 1, 2, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('SHORT_DATE_FORMAT', 2, 3, 0, 'M d, G:i');
INSERT INTO ttrss_prefs VALUES ('LONG_DATE_FORMAT', 2, 3, 0, 'D, M d Y - G:i');
INSERT INTO ttrss_prefs VALUES ('COMBINED_DISPLAY_MODE', 1, 2, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('HIDE_READ_FEEDS', 1, 2, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('FEEDS_SORT_BY_UNREAD', 1, 2, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('REVERSE_HEADLINES', 1, 2, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('DIGEST_ENABLE', 1, 4, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('CONFIRM_FEED_CATCHUP', 1, 2, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('CDM_AUTO_CATCHUP', 1, 2, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_DEFAULT_VIEW_MODE', 2, 1, 0, 'adaptive');
INSERT INTO ttrss_prefs VALUES ('_DEFAULT_VIEW_LIMIT', 3, 1, 0, '30');
INSERT INTO ttrss_prefs VALUES ('_PREFS_ACTIVE_TAB', 2, 1, 0, '');
INSERT INTO ttrss_prefs VALUES ('STRIP_UNSAFE_TAGS', 1, 3, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('BLACKLISTED_TAGS', 2, 3, 0, 'main, generic, misc, uncategorized, blog, blogroll, general, news');
INSERT INTO ttrss_prefs VALUES ('DIGEST_CATCHUP', 1, 4, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('PURGE_UNREAD_ARTICLES', 1, 3, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('STRIP_IMAGES', 1, 2, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_DEFAULT_VIEW_ORDER_BY', 2, 1, 0, 'default');
INSERT INTO ttrss_prefs VALUES ('ENABLE_API_ACCESS', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_COLLAPSED_SPECIAL', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_COLLAPSED_LABELS', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_COLLAPSED_UNCAT', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_COLLAPSED_FEEDLIST', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_ENABLE_CATS', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_SHOW_IMAGES', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_HIDE_READ', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_SORT_FEEDS_UNREAD', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_THEME_ID', 2, 1, 0, '0');
INSERT INTO ttrss_prefs VALUES ('USER_TIMEZONE', 2, 1, 0, 'Automatic');
INSERT INTO ttrss_prefs VALUES ('USER_STYLESHEET', 2, 2, 0, '');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_BROWSE_CATS', 1, 1, 0, 'true');
INSERT INTO ttrss_prefs VALUES ('SSL_CERT_SERIAL', 2, 3, 0, '');
INSERT INTO ttrss_prefs VALUES ('DIGEST_PREFERRED_TIME', 2, 4, 0, '00:00');
INSERT INTO ttrss_prefs VALUES ('_PREFS_SHOW_EMPTY_CATS', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_DEFAULT_INCLUDE_CHILDREN', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('_ENABLED_PLUGINS', 2, 1, 0, '');
INSERT INTO ttrss_prefs VALUES ('_MOBILE_REVERSE_HEADLINES', 1, 1, 0, 'false');
INSERT INTO ttrss_prefs VALUES ('USER_CSS_THEME', 2, 2, 0, '');
INSERT INTO ttrss_prefs VALUES ('USER_LANGUAGE', 2, 2, 0, '');
INSERT INTO ttrss_prefs VALUES ('SHOW_CONTENT_PREVIEW', 1, 2, 1, 'true');
INSERT INTO ttrss_prefs VALUES ('ON_CATCHUP_SHOW_NEXT_FEED', 1, 2, 1, 'false');
INSERT INTO ttrss_prefs VALUES ('FRESH_ARTICLE_MAX_AGE', 3, 2, 1, '24');
INSERT INTO ttrss_prefs VALUES ('CDM_EXPANDED', 1, 2, 1, 'true');
INSERT INTO ttrss_prefs VALUES ('HIDE_READ_SHOWS_SPECIAL', 1, 2, 1, 'true');
INSERT INTO ttrss_prefs VALUES ('VFEED_GROUP_BY_FEED', 1, 2, 1, 'false');
INSERT INTO ttrss_prefs VALUES ('SORT_HEADLINES_BY_FEED_DATE', 1, 2, 1, 'false');
INSERT INTO ttrss_prefs VALUES ('AUTO_ASSIGN_LABELS', 1, 3, 1, 'false');


--
-- Data for Name: ttrss_prefs_sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_prefs_sections VALUES (1, 0, 'General');
INSERT INTO ttrss_prefs_sections VALUES (2, 1, 'Interface');
INSERT INTO ttrss_prefs_sections VALUES (3, 3, 'Advanced');
INSERT INTO ttrss_prefs_sections VALUES (4, 2, 'Digest');


--
-- Data for Name: ttrss_prefs_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_prefs_types VALUES (1, 'bool');
INSERT INTO ttrss_prefs_types VALUES (2, 'string');
INSERT INTO ttrss_prefs_types VALUES (3, 'integer');


--
-- Data for Name: ttrss_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_settings_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_settings_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_settings_profiles_id_seq', 1, false);


--
-- Data for Name: ttrss_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_tags_id_seq', 1, false);


--
-- Data for Name: ttrss_user_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Name: ttrss_user_entries_int_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_user_entries_int_id_seq', 1, false);

--
-- Data for Name: ttrss_user_labels2; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: ttrss_user_prefs; Type: TABLE DATA; Schema: public; Owner: postgres
--
INSERT INTO ttrss_user_prefs VALUES (1, 'PURGE_OLD_DAYS', NULL, '60');
INSERT INTO ttrss_user_prefs VALUES (1, 'DEFAULT_UPDATE_INTERVAL', NULL, '30');
INSERT INTO ttrss_user_prefs VALUES (1, 'DEFAULT_ARTICLE_LIMIT', NULL, '30');
INSERT INTO ttrss_user_prefs VALUES (1, 'ALLOW_DUPLICATE_POSTS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'ENABLE_FEED_CATS', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'SHORT_DATE_FORMAT', NULL, 'M d, G:i');
INSERT INTO ttrss_user_prefs VALUES (1, 'LONG_DATE_FORMAT', NULL, 'D, M d Y - G:i');
INSERT INTO ttrss_user_prefs VALUES (1, 'COMBINED_DISPLAY_MODE', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'HIDE_READ_FEEDS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'FEEDS_SORT_BY_UNREAD', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'REVERSE_HEADLINES', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'DIGEST_ENABLE', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'CONFIRM_FEED_CATCHUP', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'CDM_AUTO_CATCHUP', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_DEFAULT_VIEW_MODE', NULL, 'adaptive');
INSERT INTO ttrss_user_prefs VALUES (1, '_DEFAULT_VIEW_LIMIT', NULL, '30');
INSERT INTO ttrss_user_prefs VALUES (1, '_PREFS_ACTIVE_TAB', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, 'STRIP_UNSAFE_TAGS', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'BLACKLISTED_TAGS', NULL, 'main, generic, misc, uncategorized, blog, blogroll, general, news');
INSERT INTO ttrss_user_prefs VALUES (1, 'DIGEST_CATCHUP', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'PURGE_UNREAD_ARTICLES', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'STRIP_IMAGES', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_DEFAULT_VIEW_ORDER_BY', NULL, 'default');
INSERT INTO ttrss_user_prefs VALUES (1, 'ENABLE_API_ACCESS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_COLLAPSED_SPECIAL', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_COLLAPSED_LABELS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_COLLAPSED_UNCAT', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_COLLAPSED_FEEDLIST', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_ENABLE_CATS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_SHOW_IMAGES', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_HIDE_READ', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_SORT_FEEDS_UNREAD', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_THEME_ID', NULL, '0');
INSERT INTO ttrss_user_prefs VALUES (1, 'USER_TIMEZONE', NULL, 'Automatic');
INSERT INTO ttrss_user_prefs VALUES (1, 'USER_STYLESHEET', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_BROWSE_CATS', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'SSL_CERT_SERIAL', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, 'DIGEST_PREFERRED_TIME', NULL, '00:00');
INSERT INTO ttrss_user_prefs VALUES (1, '_PREFS_SHOW_EMPTY_CATS', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_DEFAULT_INCLUDE_CHILDREN', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, '_ENABLED_PLUGINS', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, '_MOBILE_REVERSE_HEADLINES', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'USER_CSS_THEME', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, 'USER_LANGUAGE', NULL, '');
INSERT INTO ttrss_user_prefs VALUES (1, 'SHOW_CONTENT_PREVIEW', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'ON_CATCHUP_SHOW_NEXT_FEED', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'FRESH_ARTICLE_MAX_AGE', NULL, '24');
INSERT INTO ttrss_user_prefs VALUES (1, 'CDM_EXPANDED', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'HIDE_READ_SHOWS_SPECIAL', NULL, 'true');
INSERT INTO ttrss_user_prefs VALUES (1, 'VFEED_GROUP_BY_FEED', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'SORT_HEADLINES_BY_FEED_DATE', NULL, 'false');
INSERT INTO ttrss_user_prefs VALUES (1, 'AUTO_ASSIGN_LABELS', NULL, 'false');

--
-- Data for Name: ttrss_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_users VALUES (1, 'admin', 'SHA1:5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', NULL, 10, '', '', false, NULL, '', NULL, false, NULL, NULL);


--
-- Name: ttrss_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ttrss_users_id_seq', 1, true);


--
-- Data for Name: ttrss_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ttrss_version VALUES (130);


--
-- Name: ttrss_access_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_access_keys
    ADD CONSTRAINT ttrss_access_keys_pkey PRIMARY KEY (id);


--
-- Name: ttrss_archived_feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_archived_feeds
    ADD CONSTRAINT ttrss_archived_feeds_pkey PRIMARY KEY (id);


--
-- Name: ttrss_enclosures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_enclosures
    ADD CONSTRAINT ttrss_enclosures_pkey PRIMARY KEY (id);


--
-- Name: ttrss_entries_guid_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_entries
    ADD CONSTRAINT ttrss_entries_guid_key UNIQUE (guid);


--
-- Name: ttrss_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_entries
    ADD CONSTRAINT ttrss_entries_pkey PRIMARY KEY (id);


--
-- Name: ttrss_entry_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_entry_comments
    ADD CONSTRAINT ttrss_entry_comments_pkey PRIMARY KEY (id);


--
-- Name: ttrss_error_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_error_log
    ADD CONSTRAINT ttrss_error_log_pkey PRIMARY KEY (id);


--
-- Name: ttrss_feed_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_feed_categories
    ADD CONSTRAINT ttrss_feed_categories_pkey PRIMARY KEY (id);


--
-- Name: ttrss_feedbrowser_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_feedbrowser_cache
    ADD CONSTRAINT ttrss_feedbrowser_cache_pkey PRIMARY KEY (feed_url);


--
-- Name: ttrss_feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_feeds
    ADD CONSTRAINT ttrss_feeds_pkey PRIMARY KEY (id);


--
-- Name: ttrss_filter_actions_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_actions
    ADD CONSTRAINT ttrss_filter_actions_description_key UNIQUE (description);


--
-- Name: ttrss_filter_actions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_actions
    ADD CONSTRAINT ttrss_filter_actions_name_key UNIQUE (name);


--
-- Name: ttrss_filter_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_actions
    ADD CONSTRAINT ttrss_filter_actions_pkey PRIMARY KEY (id);


--
-- Name: ttrss_filter_types_description_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_types
    ADD CONSTRAINT ttrss_filter_types_description_key UNIQUE (description);


--
-- Name: ttrss_filter_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_types
    ADD CONSTRAINT ttrss_filter_types_name_key UNIQUE (name);


--
-- Name: ttrss_filter_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filter_types
    ADD CONSTRAINT ttrss_filter_types_pkey PRIMARY KEY (id);


--
-- Name: ttrss_filters2_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filters2_actions
    ADD CONSTRAINT ttrss_filters2_actions_pkey PRIMARY KEY (id);


--
-- Name: ttrss_filters2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filters2
    ADD CONSTRAINT ttrss_filters2_pkey PRIMARY KEY (id);


--
-- Name: ttrss_filters2_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_filters2_rules
    ADD CONSTRAINT ttrss_filters2_rules_pkey PRIMARY KEY (id);


--
-- Name: ttrss_labels2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_labels2
    ADD CONSTRAINT ttrss_labels2_pkey PRIMARY KEY (id);


--
-- Name: ttrss_linked_instances_access_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_linked_instances
    ADD CONSTRAINT ttrss_linked_instances_access_key_key UNIQUE (access_key);


--
-- Name: ttrss_linked_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_linked_instances
    ADD CONSTRAINT ttrss_linked_instances_pkey PRIMARY KEY (id);


--
-- Name: ttrss_plugin_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_plugin_storage
    ADD CONSTRAINT ttrss_plugin_storage_pkey PRIMARY KEY (id);


--
-- Name: ttrss_prefs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_prefs
    ADD CONSTRAINT ttrss_prefs_pkey PRIMARY KEY (pref_name);


--
-- Name: ttrss_prefs_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_prefs_sections
    ADD CONSTRAINT ttrss_prefs_sections_pkey PRIMARY KEY (id);


--
-- Name: ttrss_prefs_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_prefs_types
    ADD CONSTRAINT ttrss_prefs_types_pkey PRIMARY KEY (id);


--
-- Name: ttrss_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_sessions
    ADD CONSTRAINT ttrss_sessions_pkey PRIMARY KEY (id);


--
-- Name: ttrss_settings_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_settings_profiles
    ADD CONSTRAINT ttrss_settings_profiles_pkey PRIMARY KEY (id);


--
-- Name: ttrss_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_tags
    ADD CONSTRAINT ttrss_tags_pkey PRIMARY KEY (id);


--
-- Name: ttrss_user_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_user_entries
    ADD CONSTRAINT ttrss_user_entries_pkey PRIMARY KEY (int_id);


--
-- Name: ttrss_users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_users
    ADD CONSTRAINT ttrss_users_login_key UNIQUE (login);


--
-- Name: ttrss_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ttrss_users
    ADD CONSTRAINT ttrss_users_pkey PRIMARY KEY (id);


--
-- Name: ttrss_cat_counters_cache_owner_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_cat_counters_cache_owner_uid_idx ON ttrss_cat_counters_cache USING btree (owner_uid);


--
-- Name: ttrss_counters_cache_feed_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_counters_cache_feed_id_idx ON ttrss_counters_cache USING btree (feed_id);


--
-- Name: ttrss_counters_cache_owner_uid_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_counters_cache_owner_uid_idx ON ttrss_counters_cache USING btree (owner_uid);


--
-- Name: ttrss_counters_cache_value_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_counters_cache_value_idx ON ttrss_counters_cache USING btree (value);


--
-- Name: ttrss_enclosures_post_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_enclosures_post_id_idx ON ttrss_enclosures USING btree (post_id);


--
-- Name: ttrss_entries_date_entered_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_entries_date_entered_index ON ttrss_entries USING btree (date_entered);


--
-- Name: ttrss_entries_tsvector_combined_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_entries_tsvector_combined_idx ON ttrss_entries USING gin (tsvector_combined);

--
-- Name: ttrss_entries_updated_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_entries_updated_idx ON ttrss_entries USING btree (updated);


--
-- Name: ttrss_entry_comments_ref_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_entry_comments_ref_id_index ON ttrss_entry_comments USING btree (ref_id);


--
-- Name: ttrss_feeds_cat_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_feeds_cat_id_idx ON ttrss_feeds USING btree (cat_id);


--
-- Name: ttrss_feeds_owner_uid_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_feeds_owner_uid_index ON ttrss_feeds USING btree (owner_uid);


--
-- Name: ttrss_sessions_expire_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_sessions_expire_index ON ttrss_sessions USING btree (expire);


--
-- Name: ttrss_tags_owner_uid_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_tags_owner_uid_index ON ttrss_tags USING btree (owner_uid);


--
-- Name: ttrss_tags_post_int_id_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_tags_post_int_id_idx ON ttrss_tags USING btree (post_int_id);


--
-- Name: ttrss_user_entries_feed_id; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_entries_feed_id ON ttrss_user_entries USING btree (feed_id);


--
-- Name: ttrss_user_entries_owner_uid_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_entries_owner_uid_index ON ttrss_user_entries USING btree (owner_uid);


--
-- Name: ttrss_user_entries_ref_id_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_entries_ref_id_index ON ttrss_user_entries USING btree (ref_id);


--
-- Name: ttrss_user_entries_unread_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_entries_unread_idx ON ttrss_user_entries USING btree (unread);


--
-- Name: ttrss_user_prefs_owner_uid_index; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_prefs_owner_uid_index ON ttrss_user_prefs USING btree (owner_uid);


--
-- Name: ttrss_user_prefs_pref_name_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ttrss_user_prefs_pref_name_idx ON ttrss_user_prefs USING btree (pref_name);


--
-- Name: ttrss_access_keys_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_access_keys
    ADD CONSTRAINT ttrss_access_keys_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_archived_feeds_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_archived_feeds
    ADD CONSTRAINT ttrss_archived_feeds_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_cat_counters_cache_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_cat_counters_cache
    ADD CONSTRAINT ttrss_cat_counters_cache_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_counters_cache_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_counters_cache
    ADD CONSTRAINT ttrss_counters_cache_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_enclosures_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_enclosures
    ADD CONSTRAINT ttrss_enclosures_post_id_fkey FOREIGN KEY (post_id) REFERENCES ttrss_entries(id) ON DELETE CASCADE;


--
-- Name: ttrss_entry_comments_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_entry_comments
    ADD CONSTRAINT ttrss_entry_comments_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_entry_comments_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_entry_comments
    ADD CONSTRAINT ttrss_entry_comments_ref_id_fkey FOREIGN KEY (ref_id) REFERENCES ttrss_entries(id) ON DELETE CASCADE;


--
-- Name: ttrss_error_log_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_error_log
    ADD CONSTRAINT ttrss_error_log_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE SET NULL;


--
-- Name: ttrss_feed_categories_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feed_categories
    ADD CONSTRAINT ttrss_feed_categories_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_feed_categories_parent_cat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feed_categories
    ADD CONSTRAINT ttrss_feed_categories_parent_cat_fkey FOREIGN KEY (parent_cat) REFERENCES ttrss_feed_categories(id) ON DELETE SET NULL;


--
-- Name: ttrss_feeds_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feeds
    ADD CONSTRAINT ttrss_feeds_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES ttrss_feed_categories(id) ON DELETE SET NULL;


--
-- Name: ttrss_feeds_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feeds
    ADD CONSTRAINT ttrss_feeds_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_feeds_parent_feed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_feeds
    ADD CONSTRAINT ttrss_feeds_parent_feed_fkey FOREIGN KEY (parent_feed) REFERENCES ttrss_feeds(id) ON DELETE SET NULL;


--
-- Name: ttrss_filters2_actions_action_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_actions
    ADD CONSTRAINT ttrss_filters2_actions_action_id_fkey FOREIGN KEY (action_id) REFERENCES ttrss_filter_actions(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_actions_filter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_actions
    ADD CONSTRAINT ttrss_filters2_actions_filter_id_fkey FOREIGN KEY (filter_id) REFERENCES ttrss_filters2(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2
    ADD CONSTRAINT ttrss_filters2_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_rules_cat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_rules
    ADD CONSTRAINT ttrss_filters2_rules_cat_id_fkey FOREIGN KEY (cat_id) REFERENCES ttrss_feed_categories(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_rules_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_rules
    ADD CONSTRAINT ttrss_filters2_rules_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES ttrss_feeds(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_rules_filter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_rules
    ADD CONSTRAINT ttrss_filters2_rules_filter_id_fkey FOREIGN KEY (filter_id) REFERENCES ttrss_filters2(id) ON DELETE CASCADE;


--
-- Name: ttrss_filters2_rules_filter_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_filters2_rules
    ADD CONSTRAINT ttrss_filters2_rules_filter_type_fkey FOREIGN KEY (filter_type) REFERENCES ttrss_filter_types(id);


--
-- Name: ttrss_labels2_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_labels2
    ADD CONSTRAINT ttrss_labels2_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_linked_feeds_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_linked_feeds
    ADD CONSTRAINT ttrss_linked_feeds_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES ttrss_linked_instances(id) ON DELETE CASCADE;


--
-- Name: ttrss_plugin_storage_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_plugin_storage
    ADD CONSTRAINT ttrss_plugin_storage_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_prefs_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_prefs
    ADD CONSTRAINT ttrss_prefs_section_id_fkey FOREIGN KEY (section_id) REFERENCES ttrss_prefs_sections(id);


--
-- Name: ttrss_prefs_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_prefs
    ADD CONSTRAINT ttrss_prefs_type_id_fkey FOREIGN KEY (type_id) REFERENCES ttrss_prefs_types(id);


--
-- Name: ttrss_settings_profiles_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_settings_profiles
    ADD CONSTRAINT ttrss_settings_profiles_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_tags_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_tags
    ADD CONSTRAINT ttrss_tags_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_tags_post_int_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_tags
    ADD CONSTRAINT ttrss_tags_post_int_id_fkey FOREIGN KEY (post_int_id) REFERENCES ttrss_user_entries(int_id) ON DELETE CASCADE;


--
-- Name: ttrss_user_entries_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_entries
    ADD CONSTRAINT ttrss_user_entries_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES ttrss_feeds(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_entries_orig_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_entries
    ADD CONSTRAINT ttrss_user_entries_orig_feed_id_fkey FOREIGN KEY (orig_feed_id) REFERENCES ttrss_archived_feeds(id) ON DELETE SET NULL;


--
-- Name: ttrss_user_entries_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_entries
    ADD CONSTRAINT ttrss_user_entries_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_entries_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_entries
    ADD CONSTRAINT ttrss_user_entries_ref_id_fkey FOREIGN KEY (ref_id) REFERENCES ttrss_entries(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_labels2_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_labels2
    ADD CONSTRAINT ttrss_user_labels2_article_id_fkey FOREIGN KEY (article_id) REFERENCES ttrss_entries(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_labels2_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_labels2
    ADD CONSTRAINT ttrss_user_labels2_label_id_fkey FOREIGN KEY (label_id) REFERENCES ttrss_labels2(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_prefs_owner_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_prefs
    ADD CONSTRAINT ttrss_user_prefs_owner_uid_fkey FOREIGN KEY (owner_uid) REFERENCES ttrss_users(id) ON DELETE CASCADE;


--
-- Name: ttrss_user_prefs_pref_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_prefs
    ADD CONSTRAINT ttrss_user_prefs_pref_name_fkey FOREIGN KEY (pref_name) REFERENCES ttrss_prefs(pref_name) ON DELETE CASCADE;


--
-- Name: ttrss_user_prefs_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ttrss_user_prefs
    ADD CONSTRAINT ttrss_user_prefs_profile_fkey FOREIGN KEY (profile) REFERENCES ttrss_settings_profiles(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


