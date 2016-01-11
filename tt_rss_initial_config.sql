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

INSERT INTO ttrss_feeds VALUES (586, 1, 'Food and Drink', 20, 'http://rss.feedsportal.com/c/266/f/3806/index.rss', '', 0, 0, '2016-01-11 20:10:34.565247', '', NULL, 'http://www.independent.co.uk/life-style/food-and-drink/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:47:03.819889', '2016-01-11 20:10:34.486156', 0, false, 3, false, false, false, '', 0, '2016-01-11 19:30:31.274939', false);
INSERT INTO ttrss_feeds VALUES (499, 1, 'WMAR Baltimore City', 106, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=30450', '', -1, 0, '2015-09-28 21:42:04.912864', '', NULL, 'http://www.abc2news.com/baltimore-city', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:04.441843', '2015-09-28 21:42:04.447863', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:42:04.813465', false);
INSERT INTO ttrss_feeds VALUES (200, 1, 'New York Times', 66, 'http://rss.nytimes.com/services/xml/rss/nyt/NYRegion.xml', '', 0, 0, '2016-01-11 20:07:57.549087', '', NULL, 'http://www.nytimes.com/pages/nyregion/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:31.901096', '2016-01-11 20:07:57.431113', 0, false, 5, false, false, false, '', 0, '2016-01-11 13:28:30.356454', false);
INSERT INTO ttrss_feeds VALUES (757, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/464881/index.rss', '', 0, 0, '2016-01-11 20:10:27.123038', '', NULL, 'http://www.independent.co.uk/sport/general/sailing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 17:34:43.879227', '2016-01-11 20:10:27.060356', 0, false, 57, false, false, false, '', 0, '2016-01-11 15:30:28.95288', false);
INSERT INTO ttrss_feeds VALUES (535, 1, 'Las Vegas Sun', 70, 'http://www.lasvegassun.com/feeds/headlines/sports/', '', 0, 0, '2016-01-11 20:06:52.385753', '', NULL, 'http://lasvegassun.com/news/sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:19.917185', '2016-01-11 20:06:50.867469', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:46:45.114556', false);
INSERT INTO ttrss_feeds VALUES (888, 1, 'ABC News', 36, 'http://feeds.abcnews.com/abcnews/worldnewsheadlines', '', 0, 0, '2016-01-11 20:15:06.220575', '', NULL, 'http://abcnews.go.com/WN/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-30 21:46:52.583008', '2016-01-11 20:15:05.727883', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:35:08.22497', false);
INSERT INTO ttrss_feeds VALUES (298, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/202495/sports-tsr?clienttype=rss', '', 0, 0, '2016-01-11 20:07:50.782291', 'HTTP Code: 404', NULL, 'http://www.fox4news.com/category/202495/sports-tsr', '', NULL, false, '', false, true, false, false, false, false, '2015-08-26 20:57:13.835113', '2016-01-11 20:07:50.524699', 0, false, 43, false, false, false, '', 0, '2015-08-13 13:05:19.271444', false);
INSERT INTO ttrss_feeds VALUES (167, 1, 'ESPN', 29, 'http://sports.espn.go.com/espn/rss/ncb/news', '', 0, 0, '2016-01-11 20:00:29.092237', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:03:58.75252', '2016-01-11 20:00:28.842752', 0, false, 13, false, false, false, '', 0, '2016-01-11 20:00:29.051161', false);
INSERT INTO ttrss_feeds VALUES (1287, 1, 'Associated Press', 52, 'http://hosted2.ap.org/atom/APDEFAULT/aa9398e6757a46fa93ed5dea7bd3729e', '', 0, 0, '2016-01-11 20:15:20.818796', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:20.783116', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:35:12.945379', false);
INSERT INTO ttrss_feeds VALUES (1014, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/fish', '', 0, 0, '2016-01-11 20:11:17.641239', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/fish/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:15:02.872008', '2016-01-11 20:11:17.247484', 0, false, 35, false, false, false, '', 0, '2016-01-11 16:52:40.057261', false);
INSERT INTO ttrss_feeds VALUES (1240, 1, 'PGA.com', 32, 'http://www.pga.com/pgachampionship/rss', '', 0, 0, '2016-01-11 20:15:40.881967', '', NULL, 'http://www.pga.com/pgachampionship/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 17:33:30.945658', '2016-01-11 20:15:35.123741', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:36:16.590808', false);
INSERT INTO ttrss_feeds VALUES (774, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d2/rss.xml', '', 0, 0, '2016-01-11 20:15:42.859506', '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:54.188598', '2016-01-11 20:15:42.654818', 0, false, 34, false, false, false, '', 0, '2016-01-11 17:36:18.593418', false);
INSERT INTO ttrss_feeds VALUES (681, 1, 'Daily Mail', 51, 'http://www.dailymail.co.uk/home/gardening/index.rss', '', 0, 0, '2016-01-11 20:00:07.999', '', NULL, 'http://www.dailymail.co.uk/home/gardening/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:14:47.651339', '2016-01-11 20:00:07.710301', 0, false, 4, false, false, false, '', 0, '2016-01-11 19:40:04.742764', false);
INSERT INTO ttrss_feeds VALUES (1173, 1, 'FOX 39 Laredo', 201, 'http://www.mylaredofox.com/feed/', '', 0, 0, '2016-01-11 20:11:34.337735', '', NULL, 'http://www.mylaredofox.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:47.944224', '2016-01-11 20:11:34.24642', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:51:18.118229', false);
INSERT INTO ttrss_feeds VALUES (1115, 1, 'Local News | MCA', 123, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=20000', '', 0, 0, '2016-01-11 20:01:00.653591', '', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:59.747518', '2016-01-11 20:01:00.577667', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:00:51.762623', false);
INSERT INTO ttrss_feeds VALUES (170, 1, 'USA TODAY', 29, 'http://rssfeeds.usatoday.com/UsatodaycomNba-TopStories', '', 0, 0, '2016-01-11 20:00:31.571538', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:04:00.020319', '2016-01-11 20:00:30.588949', 0, false, 19, false, false, false, '', 0, '2016-01-11 20:00:31.4756', false);
INSERT INTO ttrss_feeds VALUES (4, 1, 'CNN', 7, 'http://rss.cnn.com/rss/cnn_us.rss', '', 0, 0, '2016-01-11 20:11:19.815834', '', NULL, 'http://www.cnn.com/US/index.html?eref=rss_us', '', NULL, false, '', false, true, false, false, false, false, '2015-11-30 21:46:03.283403', '2016-01-11 20:11:19.653751', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:11:22.202403', false);
INSERT INTO ttrss_feeds VALUES (417, 1, 'WXYZ Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10004', '', 0, 0, '2016-01-11 20:11:41.551721', '', NULL, 'http://www.wxyz.com/sports/live', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:22:03.67714', '2016-01-11 20:11:40.523145', 0, false, 34, false, false, false, '', 0, '2016-01-11 17:11:36.863294', false);
INSERT INTO ttrss_feeds VALUES (437, 1, 'WMC Action News 5 Sports', NULL, 'http://www.wmcactionnews5.com/category/4195/news?clienttype=rss', '', 0, 0, '2016-01-11 20:11:38.057618', '', NULL, 'http://www.wmcactionnews5.com/category/4195/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:23:46.710648', '2016-01-11 20:11:37.596618', 0, false, 39, false, false, false, '', 0, '2016-01-11 16:52:50.738185', false);
INSERT INTO ttrss_feeds VALUES (639, 1, 'Release Music', 16, 'http://www.releasemagazine.net/category/news/feed/', '', 0, 0, '2016-01-11 20:15:19.264691', '', NULL, 'http://www.releasemagazine.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:20:08.685537', '2016-01-11 20:15:10.109437', 0, false, 13, false, false, false, '', 0, '2016-01-11 09:55:13.195833', false);
INSERT INTO ttrss_feeds VALUES (373, 1, 'FT', 55, 'http://www.ft.com/rss/arts', '', 0, 0, '2016-01-11 20:10:26.653805', '', NULL, 'http://www.ft.com/arts', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:13:32.926432', '2016-01-11 20:10:26.37134', 0, false, 20, false, false, false, '', 0, '2016-01-11 15:30:28.513467', false);
INSERT INTO ttrss_feeds VALUES (857, 1, 'House & Home', 21, 'http://houseandhome.com/rss/feeds', '', 0, 0, '2016-01-11 20:15:09.531029', 'HTTP Code: 404', NULL, 'http://houseandhome.com/rss/feeds', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:20:46.397243', '2016-01-11 20:15:06.672025', 0, false, 3, false, false, false, '', 0, '2015-08-12 12:36:50.677372', false);
INSERT INTO ttrss_feeds VALUES (239, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, '2015-09-28 21:54:11.23141', '', NULL, 'http://www.nbcchicago.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:08.72357', '2015-09-28 21:54:08.730648', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:54:10.942297', false);
INSERT INTO ttrss_feeds VALUES (497, 1, 'WBAL', 106, 'http://www.wbaltv.com/entertainment/topstory.rss', '', 0, 0, '2016-01-11 20:06:43.372221', '', NULL, 'http://www.wbaltv.com/9380350', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:56.896421', '2016-01-11 20:06:43.066167', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:46:49.761011', false);
INSERT INTO ttrss_feeds VALUES (1051, 1, 'Las Vegas Sun', 143, 'http://lasvegassun.com/feeds/headlines/henderson/', '', 0, 0, '2016-01-11 20:00:38.341107', '', NULL, 'http://lasvegassun.com/news/henderson/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:46.864566', '2016-01-11 20:00:38.131223', 0, false, 0, false, false, false, '', 0, '2016-01-11 20:00:38.287609', false);
INSERT INTO ttrss_feeds VALUES (1083, 1, 'TWC News', 155, 'http://www.twcnews.com/services/contentfeed.nc.triad.news.top-stories.full.rss', '', 0, 0, '2016-01-11 20:00:41.134959', '', NULL, 'http://www.twcnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:05.217402', '2016-01-11 20:00:40.193974', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:00:56.145049', false);
INSERT INTO ttrss_feeds VALUES (496, 1, 'WBAL TV', 106, 'http://www.wbaltv.com/video/topstory.rss', '', -1, 0, '2015-09-28 21:42:07.533443', '', NULL, 'http://www.wbaltv.com/9380288', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:05.57256', '2015-09-28 21:42:05.577921', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:42:07.44575', false);
INSERT INTO ttrss_feeds VALUES (431, 1, 'ABC El Paso', 142, 'http://www.kvia.com/15160496?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:01:07.091007', '', NULL, 'http://www.kvia.com/15160496', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:32.788915', '2016-01-11 20:01:05.681852', 0, false, 4, false, false, false, '', 0, '2016-01-11 15:00:57.851235', false);
INSERT INTO ttrss_feeds VALUES (117, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7148.xml', '', 0, 0, '2016-01-11 20:15:45.878053', '', NULL, 'http://online.wsj.com/article/business.html', '', NULL, false, '', false, true, false, false, false, false, '2015-07-02 01:36:50.081533', '2016-01-11 20:15:45.844956', 0, false, 15, false, false, false, '', 0, '2016-01-11 18:55:39.242177', false);
INSERT INTO ttrss_feeds VALUES (1286, 1, 'Associated Press', 41, 'http://hosted2.ap.org/atom/APDEFAULT/b2f0ca3a594644ee9e50a8ec4ce2d6de', '', 0, 0, '2016-01-11 20:05:29.762186', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:29.617158', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:45:21.907361', false);
INSERT INTO ttrss_feeds VALUES (294, 1, 'Dallas Morning News', 134, 'http://www.dallasnews.com/newskiosk/rss/dallasnewslifetravel.xml', '', -1, 0, '2015-09-28 21:51:35.551081', '', NULL, 'http://www.dallasnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:34.885472', '2015-09-28 21:51:34.895025', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:51:35.468013', false);
INSERT INTO ttrss_feeds VALUES (843, 1, 'BBC', 37, 'http://feeds.bbci.co.uk/news/politics/rss.xml', '', 0, 0, '2016-01-11 20:11:18.317463', '', NULL, 'http://www.bbc.co.uk/news/politics/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 18:38:38.12907', '2016-01-11 20:11:18.211784', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:11:11.96897', false);
INSERT INTO ttrss_feeds VALUES (1076, 1, 'Fox 23', 154, 'http://www.fox23.com/list/rss/news/local/local-news/aKzh/', '', 0, 0, '2016-01-11 20:00:42.945257', '', NULL, 'http://www.fox23.com/list/news/local/local-news/aKzh/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:23.411623', '2016-01-11 20:00:42.781512', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:00:57.629639', false);
INSERT INTO ttrss_feeds VALUES (770, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:15:41.860734', '', NULL, 'http://www.ncaa.com/news/golf-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:03:12.757492', '2016-01-11 20:15:41.714111', 0, false, 31, false, false, false, '', 0, '2016-01-11 17:36:17.573705', false);
INSERT INTO ttrss_feeds VALUES (839, 1, 'NPR', 36, 'http://www.npr.org/rss/rss.php?id=1004', '', 0, 0, '2016-01-11 20:11:39.169962', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1004', '', NULL, false, '', false, true, false, false, false, false, '2015-11-30 21:59:02.661534', '2016-01-11 20:11:39.132212', 0, false, 10, false, false, false, '', 0, '2016-01-11 17:11:34.916412', false);
INSERT INTO ttrss_feeds VALUES (1036, 1, 'San Diego 6', 127, 'http://www.sandiego6.com/news/local/index.rss2', '', 0, 0, '2016-01-11 19:56:01.230841', 'HTTP Code: 404', NULL, 'http://www.sandiego6.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:23.557233', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2015-12-17 18:15:16.897644', false);
INSERT INTO ttrss_feeds VALUES (966, 1, 'ABQJournal', 198, 'http://www.abqjournal.com/feed', '', 0, 0, '2016-01-11 20:11:45.105539', '', NULL, 'http://www.abqjournal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:00.903057', '2016-01-11 20:11:42.60049', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:12:20.125173', false);
INSERT INTO ttrss_feeds VALUES (1214, 1, 'Daily Press', 211, 'http://dailypress.feedsportal.com/c/34257/f/623179/index.rss', '', 0, 0, '2016-01-11 20:06:16.166662', '', NULL, 'http://www.dailypress.com/news/hampton/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:36:59.384043', '2016-01-11 20:06:16.097179', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:26:11.937111', false);
INSERT INTO ttrss_feeds VALUES (439, 1, 'MyFox Memphis Sports', 123, 'http://www.myfoxmemphis.com/category/230022/sports?clienttype=rss', '', 0, 0, '2016-01-11 20:01:01.209658', 'HTTP Code: 404', NULL, 'http://www.myfoxmemphis.com/category/230022/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:01.488915', '2016-01-11 20:01:00.657488', 0, false, 3, false, false, false, '', 0, '2015-12-09 06:17:28.38535', false);
INSERT INTO ttrss_feeds VALUES (124, 1, 'BBC News', 39, 'http://feeds.bbci.co.uk/news/technology/rss.xml?edition=uk', '', 0, 0, '2016-01-11 20:07:00.082709', '', NULL, 'http://www.bbc.co.uk/news/technology/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-04-25 17:05:52.690973', '2016-01-11 20:06:59.946342', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:26:43.717191', false);
INSERT INTO ttrss_feeds VALUES (1029, 1, 'TampaBay.com', 124, 'http://www.tampabay.com/feeds/rss.page?collatedTag=news,pinellas,neigh-south&section=staffArticle&feedType=rss', '', 0, 0, '2016-01-11 19:55:59.051807', '', NULL, 'http://www.tampabay.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:45:32.084163', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:16:52.832257', false);
INSERT INTO ttrss_feeds VALUES (1026, 1, 'Atlanta Journal Constitution', 122, 'http://www.ajc.com/list/rss/news/breaking-news-center/aFSL/', '', 0, 0, '2016-01-11 20:01:19.455249', '', NULL, 'http://www.ajc.com/list/news/breaking-news-center/aFSL/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:10.614567', '2016-01-11 20:01:19.053134', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:01:15.402561', false);
INSERT INTO ttrss_feeds VALUES (634, 1, 'NPR', 52, 'http://www.npr.org/rss/rss.php?id=1146', '', 0, 0, '2016-01-11 20:07:02.613715', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1146', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:29:04.565975', '2016-01-11 20:07:02.449589', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:07:51.025863', false);
INSERT INTO ttrss_feeds VALUES (1224, 1, 'The Conscious Cat', 116, 'http://consciouscat.net/feed', '', 0, 0, '2016-01-11 19:56:29.702001', '', NULL, 'http://consciouscat.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 7, false, false, false, '', 0, '2016-01-11 15:16:30.233272', false);
INSERT INTO ttrss_feeds VALUES (495, 1, 'Nashville Post', 186, 'https://www.nashvillepost.com/feed', '', 0, 0, '2016-01-11 20:12:09.199285', '', NULL, 'https://www.nashvillepost.com/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:38.888078', '2016-01-11 20:12:08.740914', 0, false, 1, false, false, false, '', 0, '2016-01-11 08:15:06.486648', false);
INSERT INTO ttrss_feeds VALUES (103, 1, 'Al Jazeera', 36, 'http://www.aljazeera.com/xml/rss/all.xml', '', 0, 0, '2016-01-11 19:55:36.939597', '', NULL, 'http://www.aljazeera.com/default.html', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 21:57:14.352422', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 07:55:45.567328', false);
INSERT INTO ttrss_feeds VALUES (768, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d2/rss.xml', '', 0, 0, '2016-01-11 20:15:41.507243', '', NULL, 'http://www.ncaa.com/news/cross-country-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:03:00.614751', '2016-01-11 20:15:41.307279', 0, false, 27, false, false, false, '', 0, '2016-01-11 17:36:17.328586', false);
INSERT INTO ttrss_feeds VALUES (675, 1, 'FIVB', 59, 'http://www.fivb.org/vis/rss/press.aspx', '', 0, 0, '2016-01-11 20:15:28.666098', '', NULL, 'http://www.fivb.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:49:12.030606', '2016-01-11 20:15:27.421945', 0, false, 18, false, false, false, '', 0, '2016-01-11 08:55:29.396508', false);
INSERT INTO ttrss_feeds VALUES (265, 1, 'Complete Philly Coverage', 100, 'http://completephillycoverage.com/feed', '', 0, 0, '2016-01-11 20:07:50.52127', '', NULL, 'http://completephillycoverage.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:30:28.168296', '2016-01-11 20:07:50.137074', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:48:27.118163', false);
INSERT INTO ttrss_feeds VALUES (941, 1, 'Fandango', 58, 'http://www.fandango.com/rss/comingsoonmovies.rss', '', 0, 0, '2016-01-11 20:11:08.289721', '', NULL, 'http://www.fandango.com/default.aspx?wssaffid=11839&wssac=123', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:03:34.641607', '2016-01-11 20:11:08.145843', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:06.469339', false);
INSERT INTO ttrss_feeds VALUES (1096, 1, 'Stockton News', 165, 'http://www.kcra.com/12970050?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:01:20.40747', '', NULL, 'http://www.kcra.com/12970050', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:19.033059', '2016-01-11 20:01:19.498326', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:01:41.410986', false);
INSERT INTO ttrss_feeds VALUES (641, 1, 'Reuters', 55, 'http://feeds.reuters.com/news/artsculture', '', 0, 0, '2016-01-11 20:15:30.385177', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:29:57.543272', '2016-01-11 20:15:29.962058', 0, false, 7, false, false, false, '', 0, '2016-01-11 08:55:31.724131', false);
INSERT INTO ttrss_feeds VALUES (1165, 1, 'Reno Gazette-Journal', 196, 'http://rssfeeds.rgj.com/reno/news', '', 0, 0, '2016-01-11 20:15:43.612009', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:45.323076', '2016-01-11 20:15:43.193931', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:35:33.915128', false);
INSERT INTO ttrss_feeds VALUES (950, 1, 'Fashion - Los Angeles Times', 18, 'http://www.latimes.com/fashion/rss2.0.xml', '', 0, 0, '2016-01-11 20:00:35.092955', '', NULL, 'http://www.latimes.com/fashion/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:25.075649', '2016-01-11 20:00:35.029176', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:00:50.722566', false);
INSERT INTO ttrss_feeds VALUES (744, 1, 'Velo News', 60, 'http://velonews.competitor.com/feed', '', 0, 0, '2016-01-11 20:15:33.241947', '', NULL, 'http://velonews.competitor.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:49:11.701304', '2016-01-11 20:15:32.745311', 0, false, 20, false, false, false, '', 0, '2016-01-11 16:16:14.192178', false);
INSERT INTO ttrss_feeds VALUES (113, 1, 'CNN Money', 38, 'http://rss.cnn.com/rss/money_latest.rss', '', 0, 0, '2016-01-11 20:11:20.987643', '', NULL, 'http://money.cnn.com/?section=money_latest', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:52:32.364767', '2016-01-11 20:11:20.890829', 0, false, 10, false, false, false, '', 0, '2016-01-11 12:11:15.759443', false);
INSERT INTO ttrss_feeds VALUES (458, 1, 'SB Nation Denver', 82, 'http://denver.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:06:45.328469', '', NULL, 'http://denver.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:33.478496', '2016-01-11 20:06:45.156814', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:46:52.008763', false);
INSERT INTO ttrss_feeds VALUES (476, 1, 'Boston Herald', 141, 'http://feeds.feedburner.com/bostonherald/entertainment/fashion/', '', 0, 0, '2016-01-11 20:00:59.058926', '', NULL, 'http://www.bostonherald.com/feed/34', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:50.646792', '2016-01-11 20:00:58.888673', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:00:49.560151', false);
INSERT INTO ttrss_feeds VALUES (1091, 1, 'WLWT', 162, 'http://www.wlwt.com/9838828?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:00:44.882059', '', NULL, 'http://www.wlwt.com/9838828', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:34.47457', '2016-01-11 20:00:43.692824', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:00:59.048251', false);
INSERT INTO ttrss_feeds VALUES (428, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200808.xml', '', 0, 0, '2016-01-11 20:01:05.678261', '47 Maximum (20) redirects followed', NULL, 'http://www.elpasotimes.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:32.590056', '2016-01-11 20:01:03.881477', 0, false, 2, false, false, false, '', 0, '2015-12-17 20:16:56.118692', false);
INSERT INTO ttrss_feeds VALUES (811, 1, 'Bizjournals', 40, 'http://feeds.bizjournals.com/industry_6', '', 0, 0, '2016-01-11 20:07:02.841834', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:15.147766', '2016-01-11 20:07:02.619272', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:07:51.218614', false);
INSERT INTO ttrss_feeds VALUES (262, 1, 'SB Nation Philly', 100, 'http://philly.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:07:52.092023', '', NULL, 'http://philly.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:50:18.914063', '2016-01-11 20:07:51.986872', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:48:28.542232', false);
INSERT INTO ttrss_feeds VALUES (1180, 1, 'Isthmus', 203, 'http://isthmus.com/api/rss/content.rss', '', 0, 0, '2016-01-11 20:11:20.555428', '', NULL, 'http://isthmus.com/api/rss/content.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:38.00182', '2016-01-11 20:11:20.363719', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:24.102543', false);
INSERT INTO ttrss_feeds VALUES (118, 1, 'NBC', 38, 'http://feeds.nbcnews.com/feeds/business', '', 0, 0, '2016-01-11 20:07:03.957975', '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:26:53.216991', '2016-01-11 20:07:03.896089', 0, false, 14, false, false, false, '', 0, '2016-01-11 16:47:10.138374', false);
INSERT INTO ttrss_feeds VALUES (849, 1, 'Food & Wine', 20, 'http://www.foodandwine.com/feeds/latest_articles', '', 0, 0, '2016-01-11 19:55:48.829565', '', NULL, 'http://www.foodandwine.com/articles_feeds', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:35:52.300764', false);
INSERT INTO ttrss_feeds VALUES (115, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7014.xml', '', 0, 0, '2016-01-11 20:15:34.155413', '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:35:26.116082', '2016-01-11 20:15:33.993464', 0, false, 17, false, false, false, '', 0, '2016-01-11 08:55:35.164915', false);
INSERT INTO ttrss_feeds VALUES (1267, 1, 'Yahoo Sports', 32, 'https://sports.yahoo.com/golf/rss.xml', '', 0, 0, '2016-01-11 20:11:20.658244', '', NULL, 'http://sports.yahoo.com/golf', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:20.559279', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:24.762824', false);
INSERT INTO ttrss_feeds VALUES (126, 1, 'NYT', 40, 'http://rss.nytimes.com/services/xml/rss/nyt/Health.xml', '', 0, 0, '2016-01-11 20:10:48.29704', '', NULL, 'http://www.nytimes.com/pages/health/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:48.202942', 0, false, 16, false, false, false, '', 0, '2016-01-11 18:30:53.38792', false);
INSERT INTO ttrss_feeds VALUES (877, 1, 'NYT', 36, 'http://rss.nytimes.com/services/xml/rss/nyt/World.xml', '', 0, 0, '2016-01-11 20:15:44.341421', '', NULL, 'http://www.nytimes.com/pages/world/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:33:04.652608', '2016-01-11 20:15:44.221116', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:36:16.732054', false);
INSERT INTO ttrss_feeds VALUES (1169, 1, 'Pasadena Star News', 185, 'http://www.pasadenastarnews.com/section?template=RSS&profile=4000511&mime=xml', '', 0, 0, '2016-01-11 20:06:49.112002', '', NULL, 'http://www.pasadenastarnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:07.335289', '2016-01-11 20:06:48.76533', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:26:49.887758', false);
INSERT INTO ttrss_feeds VALUES (597, 1, 'Los Angeles Business Journal', 63, 'http://labusinessjournal.com/rss/headlines/la-finance/', '', 0, 0, '2016-01-11 20:05:39.361316', '', NULL, 'http://labusinessjournal.com/news/la-finance/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 20:30:39.505268', '2016-01-11 20:05:39.081131', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:05:39.195998', false);
INSERT INTO ttrss_feeds VALUES (62, 1, 'Tech2', 17, 'http://tech2.in.com/rssfeed/news.xml', '', 0, 0, '2016-01-11 20:01:47.829024', '', NULL, 'http://tech.firstpost.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:58:08.253137', '2016-01-11 20:01:46.350138', 0, false, 7, false, false, false, '', 0, '2016-01-11 09:21:33.538699', false);
INSERT INTO ttrss_feeds VALUES (1100, 1, 'CBS 11', 166, 'http://www.ktva.com/feed/', '', 0, 0, '2016-01-11 20:00:48.269317', '', NULL, 'http://www.ktva.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:48.802168', '2016-01-11 20:00:47.078628', 0, false, 1, false, false, false, '', 0, '2016-01-11 08:20:39.938727', false);
INSERT INTO ttrss_feeds VALUES (1101, 1, 'WKYT', 167, 'http://www.wkyt.com/home/headlines/index.rss2', '', 0, 0, '2016-01-11 20:00:53.32939', '', NULL, 'http://www.wkyt.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-09-30 18:21:01.346308', '2016-01-11 20:00:52.761268', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:20:45.643587', false);
INSERT INTO ttrss_feeds VALUES (1161, 1, 'Irvine Community News', 194, 'https://www.irvinecommunitynewsandviews.org/feed/', '', 0, 0, '2016-01-11 20:15:05.309054', '', NULL, 'https://www.irvinecommunitynewsandviews.org', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:05.668011', '2016-01-11 20:15:03.659114', 0, false, 1, false, false, false, '', 0, '2016-01-11 08:55:08.497606', false);
INSERT INTO ttrss_feeds VALUES (754, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/3795/index.rss', '', 0, 0, '2016-01-11 20:10:26.295719', '', NULL, 'http://www.independent.co.uk/sport/general/rugby-league/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:54:44.157892', '2016-01-11 20:10:26.200672', 0, false, 53, false, false, false, '', 0, '2016-01-11 15:30:28.31274', false);
INSERT INTO ttrss_feeds VALUES (573, 1, 'LA Times', 10, 'http://www.latimes.com/entertainment/tv/rss2.0.xml', '', 0, 0, '2016-01-11 20:10:46.40586', '', NULL, 'http://www.latimes.com/entertainment/tv/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:46.322708', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:10:51.194984', false);
INSERT INTO ttrss_feeds VALUES (405, 1, 'WCCB Sports', NULL, 'http://www.wccbcharlotte.com/sports/index.rss2', '', 0, 0, '2016-01-11 20:11:37.589811', 'HTTP Code: 404', NULL, 'http://www.wccbcharlotte.com/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:23:20.133176', '2016-01-11 20:11:34.8493', 0, false, 37, false, false, false, '', 0, '2015-12-10 10:10:28.887099', false);
INSERT INTO ttrss_feeds VALUES (534, 1, 'Las Vegas Review Journal - Sports', 70, 'http://www.lvrj.com/sports.rss', '', 0, 0, '2016-01-11 20:06:48.762422', '', NULL, 'http://www.reviewjournal.com/rss.xml/31', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:02.370633', '2016-01-11 20:06:48.135323', 0, false, 6, false, false, false, '', 0, '2016-01-11 09:06:35.155015', false);
INSERT INTO ttrss_feeds VALUES (1160, 1, 'The Orange County Register', 194, 'http://www.ocregister.com/common/rss/rss.php?catID=18883', '', 0, 0, '2016-01-11 20:15:05.724458', '', NULL, 'http://www.ocregister.com/common/archives/?catID=18883', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:07.164011', '2016-01-11 20:15:05.313846', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:35:07.776817', false);
INSERT INTO ttrss_feeds VALUES (441, 1, 'Local Memphis Sports', 123, 'http://www2.localmemphis.com/rss/64.rss', '', 0, 0, '2016-01-11 20:01:01.611945', '', NULL, 'http://www.localmemphis.com/sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:04.136263', '2016-01-11 20:01:01.213558', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:00:53.761635', false);
INSERT INTO ttrss_feeds VALUES (366, 1, 'ArtForum', 55, 'http://artforum.com/rss.xml', '', 0, 0, '2016-01-11 20:10:27.056808', '', NULL, 'http://artforum.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:54:12.866388', '2016-01-11 20:10:26.657919', 0, false, 10, false, false, false, '', 0, '2016-01-11 15:30:28.743707', false);
INSERT INTO ttrss_feeds VALUES (845, 1, 'NPR', 37, 'http://www.npr.org/rss/rss.php?id=1014', '', 0, 0, '2016-01-11 20:07:13.126234', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1014', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:30:46.330516', '2016-01-11 20:07:13.087453', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:27:03.010609', false);
INSERT INTO ttrss_feeds VALUES (1206, 1, 'Kansas City infoZine', 83, 'http://rss.infozine.com/kc/headlines.xml', '', 0, 0, '2016-01-11 20:06:49.162667', '', NULL, 'http://www.infozine.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:51.85275', '2016-01-11 20:06:49.115275', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:46:35.476086', false);
INSERT INTO ttrss_feeds VALUES (716, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/51', '', 0, 0, '2016-01-11 20:15:34.479152', '', NULL, 'http://www.yardbarker.com/motocross', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:07:54.643043', '2016-01-11 20:15:34.160023', 0, false, 23, false, false, false, '', 0, '2016-01-11 16:55:28.521946', false);
INSERT INTO ttrss_feeds VALUES (222, 1, 'LA Daily News Sports', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000070&mime=xml', '', 0, 0, '2016-01-11 20:07:57.615119', '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:15.751941', '2016-01-11 20:07:57.551916', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:29:14.53173', false);
INSERT INTO ttrss_feeds VALUES (680, 1, 'HuffPost', 51, 'http://www.huffingtonpost.com/news/gardening/feed//', '', 0, 0, '2016-01-11 20:15:42.118282', '', NULL, 'http://www.huffingtonpost.com/tag/gardening', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:16:00.749218', '2016-01-11 20:15:42.037304', 0, false, 6, false, false, false, '', 0, '2016-01-11 14:35:31.701477', false);
INSERT INTO ttrss_feeds VALUES (553, 1, 'Hollywood Life', 50, 'http://www.hollywoodlife.net/feed', '', 0, 0, '2016-01-11 20:10:40.024125', '', NULL, 'http://hollywoodlife.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 22:42:56.949705', '2016-01-11 20:10:39.89369', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:30:42.926088', false);
INSERT INTO ttrss_feeds VALUES (442, 1, 'Local Memphis', 123, 'http://www2.localmemphis.com/rss/65.rss', '', 0, 0, '2016-01-11 20:01:01.826922', '', NULL, 'http://www.localmemphis.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:06.648013', '2016-01-11 20:01:01.615845', 0, false, 7, false, false, false, '', 0, '2016-01-11 15:00:54.152829', false);
INSERT INTO ttrss_feeds VALUES (233, 1, 'Chicago Tribune', 120, 'http://chicagotribune.com/services/chi-latestnews-rss,0,7516175.hyperlink', '', 0, 0, '2016-01-11 20:07:13.010169', '', NULL, 'http://www.chicagotribune.com/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:21.614137', '2016-01-11 20:07:12.551767', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:47:56.217052', false);
INSERT INTO ttrss_feeds VALUES (1128, 1, 'Aurora Sentinel', 179, 'http://www.aurorasentinel.com/feed/', '', 0, 0, '2016-01-11 20:07:13.412502', '', NULL, 'http://www.aurorasentinel.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:47.542307', '2016-01-11 20:07:13.129066', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:27:40.25604', false);
INSERT INTO ttrss_feeds VALUES (664, 1, 'Charlotte Area Sports Blog', 98, 'http://feeds.feedburner.com/CharlotteAreaSportsBlog?format=xml', '', 0, 0, '2016-01-11 20:11:18.010734', '', NULL, 'http://charlotteprosports.blogspot.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:17.644297', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:52:40.523393', false);
INSERT INTO ttrss_feeds VALUES (220, 1, 'LA Times Sports', 115, 'http://www.latimes.com/sports/rss2.0.xml', '', 0, 0, '2016-01-11 20:07:54.271455', '', NULL, 'http://www.latimes.com/sports/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:16.684685', '2016-01-11 20:07:54.175498', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:29:11.125642', false);
INSERT INTO ttrss_feeds VALUES (1248, 1, 'CollegeFootballTalk', 27, 'http://collegefootballtalk.nbcsports.com/rss.xml', '', 0, 0, '2016-01-11 20:07:57.931229', '', NULL, 'http://collegefootballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:47:56.944342', '2016-01-11 20:07:57.706191', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:27:54.768737', false);
INSERT INTO ttrss_feeds VALUES (1151, 1, 'JSOnline.com', 191, 'http://www.jsonline.com/rss/?c=y&path=%2Fnewswatch', '', 0, 0, '2016-01-11 20:12:08.651744', '', NULL, 'http://www.jsonline.com/newswatch', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:14.082638', '2016-01-11 20:12:08.328205', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:32:20.956036', false);
INSERT INTO ttrss_feeds VALUES (771, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d2/rss.xml', '', 0, 0, '2016-01-11 20:15:42.305633', '', NULL, 'http://www.ncaa.com/news/golf-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:52.538406', '2016-01-11 20:15:42.122279', 0, false, 38, false, false, false, '', 0, '2016-01-11 16:16:20.11342', false);
INSERT INTO ttrss_feeds VALUES (1047, 1, 'Journal Star', 140, 'http://journalstar.com/search/?f=rss&t=article&c=news/local&l=25&s=start_time&sd=desc', '', 0, 0, '2016-01-11 19:56:04.151639', '', NULL, 'http://journalstar.com/search/?f=rss&t=article&c=news/local&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:38.964261', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 10:36:09.956598', false);
INSERT INTO ttrss_feeds VALUES (1114, 1, 'WTSP', 172, 'http://rssfeeds.wtsp.com/wtsp/localnews&x=1', '', 0, 0, '2016-01-11 19:56:04.802396', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:46.779031', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:56:13.500939', false);
INSERT INTO ttrss_feeds VALUES (737, 1, 'The Independent', 39, 'http://rss.feedsportal.com/c/266/f/3821/index.rss', '', 0, 0, '2016-01-11 20:10:42.621399', '', NULL, 'http://www.independent.co.uk/life-style/gadgets-and-tech/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:42.553157', 0, false, 9, false, false, false, '', 0, '2016-01-11 18:30:45.434204', false);
INSERT INTO ttrss_feeds VALUES (406, 1, 'Charlotte Observer', 174, 'http://www.charlotteobserver.com/sports/spt-columns-blogs/scott-fowler/?widgetName=rssfeed&widgetContentId=8167599&getXmlFeed=true', '', 0, 0, '2016-01-11 20:01:09.521951', '', NULL, 'http://www.charlotteobserver.com/sports/spt-columns-blogs/scott-fowler/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:52.705554', '2016-01-11 20:01:09.400067', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:01:24.113084', false);
INSERT INTO ttrss_feeds VALUES (97, 1, 'CNN', 36, 'http://rss.cnn.com/rss/cnn_world.rss', '', 0, 0, '2016-01-11 20:02:04.362423', '', NULL, 'http://www.cnn.com/WORLD/index.html?eref=rss_world', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 18:30:11.436039', '2016-01-11 20:02:04.249993', 0, false, 14, false, false, false, '', 0, '2016-01-11 10:41:47.599589', false);
INSERT INTO ttrss_feeds VALUES (335, 1, 'The Florida Times-Union', 68, 'http://feeds.jacksonville.com/JacksonvillecomSports?format=xml', '', 0, 0, '2016-01-11 20:15:20.000307', '', NULL, 'http://jacksonville.com/taxonomy/term/1893/2', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:12:57.843666', '2016-01-11 20:15:19.269209', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:35:13.721184', false);
INSERT INTO ttrss_feeds VALUES (750, 1, 'The Independent', 33, 'http://rss.feedsportal.com/c/266/f/3861/index.rss', '', 0, 0, '2016-01-11 20:10:26.367909', '', NULL, 'http://www.independent.co.uk/travel/skiing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 20:30:29.15905', '2016-01-11 20:10:26.300481', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:30:28.390776', false);
INSERT INTO ttrss_feeds VALUES (1281, 1, 'Associated Press', 37, 'http://hosted2.ap.org/atom/APDEFAULT/89ae8247abe8493fae24405546e9a1aa', '', 0, 0, '2016-01-11 20:06:49.773913', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:49.691961', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:46:57.347552', false);
INSERT INTO ttrss_feeds VALUES (911, 1, 'Cruising World', 51, 'http://www.cruisingworld.com/rss.xml', '', 0, 0, '2016-01-11 20:15:09.678153', '', NULL, 'http://www.cruisingworld.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:13:37.361129', '2016-01-11 20:15:09.535946', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:35:12.276319', false);
INSERT INTO ttrss_feeds VALUES (1105, 1, 'CBS Pittsburgh', 168, 'http://pittsburgh.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:00:50.94631', '', NULL, 'http://pittsburgh.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:14.179928', '2016-01-11 20:00:50.767753', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:01:03.246787', false);
INSERT INTO ttrss_feeds VALUES (601, 1, 'UPI', 52, 'http://rss.upi.com/news/odd_news.rss', '', 0, 0, '2016-01-11 20:06:47.266499', '', NULL, 'http://www.upi.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-08 21:55:06.147034', '2016-01-11 20:06:46.776962', 0, false, 10, false, false, false, '', 0, '2016-01-11 16:46:53.96755', false);
INSERT INTO ttrss_feeds VALUES (20, 1, 'Hollywood Reporter', 9, 'http://feeds.feedburner.com/THR/NEWS', '', 0, 0, '2016-01-11 20:01:55.743681', '', NULL, 'http://www.hollywoodreporter.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:55.519954', 0, false, 7, false, false, false, '', 0, '2016-01-11 11:21:41.220237', false);
INSERT INTO ttrss_feeds VALUES (1103, 1, 'WTAE', 168, 'http://www.wtae.com/9682036?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:00:51.163642', '', NULL, 'http://www.wtae.com/9682036', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:15.708892', '2016-01-11 20:00:50.949962', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:01:03.553261', false);
INSERT INTO ttrss_feeds VALUES (982, 1, 'ABC', 71, 'http://abcnews.go.com/topics/urss?pageid=1085245', '', 0, 0, '2016-01-11 19:55:49.700386', '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:37:28.707201', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:36:38.978896', false);
INSERT INTO ttrss_feeds VALUES (547, 1, 'Perez Hilton', 50, 'http://img.perezhilton.com/?feed=rss2-featured', '', 0, 0, '2016-01-11 20:10:33.474922', '', NULL, 'http://img.perezhilton.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:44:15.599386', '2016-01-11 20:10:33.222964', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:10:35.036523', false);
INSERT INTO ttrss_feeds VALUES (27, 1, 'Extra TV', 9, 'http://www.extratv.com/feeds/category/movie-trailers/rss.xml', '', 0, 0, '2016-01-11 20:01:58.778009', '', NULL, 'http://extratv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:58.012716', 0, false, 9, false, false, false, '', 0, '2016-01-11 13:01:58.961751', false);
INSERT INTO ttrss_feeds VALUES (1260, 1, 'New York Times', 34, 'http://rss.nytimes.com/services/xml/rss/nyt/Soccer.xml', '', 0, 0, '2016-01-11 20:07:21.003413', '', NULL, 'http://www.nytimes.com/pages/sports/soccer/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:20.920484', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:07:58.9238', false);
INSERT INTO ttrss_feeds VALUES (559, 1, 'Celeb Dirty Laundry', 50, 'http://feeds.feedburner.com/celebritydirtylaundry', '', 0, 0, '2016-01-11 20:10:40.812134', '', NULL, 'http://www.celebdirtylaundry.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-08 19:37:31.630334', '2016-01-11 20:10:40.576817', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:50:41.781482', false);
INSERT INTO ttrss_feeds VALUES (742, 1, 'The Independent', 38, 'http://rss.feedsportal.com/c/266/f/3510/index.rss', '', 0, 0, '2016-01-11 20:15:32.740576', '', NULL, 'http://www.independent.co.uk/news/business/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:10.177008', '2016-01-11 20:15:32.66775', 0, false, 9, false, false, false, '', 0, '2016-01-11 16:16:13.723955', false);
INSERT INTO ttrss_feeds VALUES (1007, 1, '| INFORUM', NULL, 'http://www.inforum.com/latest/rss/', '', 0, 0, '2016-01-11 20:07:20.916741', '', NULL, 'http://www.inforum.com/latest', '', NULL, false, '', false, true, false, false, false, false, '2015-07-14 20:52:37.395036', '2016-01-11 20:07:20.480639', 0, false, 5, false, false, false, '', 0, '2016-01-11 10:27:01.461727', false);
INSERT INTO ttrss_feeds VALUES (1242, 1, 'Kansas City Star', 83, 'http://www.kansascity.com/?widgetName=rssfeed&widgetContentId=6199&getXmlFeed=true', '', 0, 0, '2016-01-11 20:06:49.904267', '', NULL, 'http://www.kansascity.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:49.918871', '2016-01-11 20:06:49.777709', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:26:50.869655', false);
INSERT INTO ttrss_feeds VALUES (1243, 1, 'Bleacher Report', 27, 'http://bleacherreport.com/articles/feed?tag_id=16', '', 0, 0, '2016-01-11 20:07:58.146443', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:47:53.94761', '2016-01-11 20:07:57.93648', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:07:44.818311', false);
INSERT INTO ttrss_feeds VALUES (947, 1, 'Daily Mail', 40, 'http://www.dailymail.co.uk/health/index.rss', '', 0, 0, '2016-01-11 20:07:46.176257', '', NULL, 'http://www.dailymail.co.uk/health/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:45.533121', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:47:25.444138', false);
INSERT INTO ttrss_feeds VALUES (558, 1, 'Honest Cooking', 51, 'http://honestcooking.com/feed/', '', 0, 0, '2016-01-11 20:15:42.033569', '', NULL, 'http://honestcooking.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:57:54.325766', '2016-01-11 20:15:41.865201', 0, false, 12, false, false, false, '', 0, '2016-01-11 09:15:48.157893', false);
INSERT INTO ttrss_feeds VALUES (883, 1, 'Chicago Tribune', 7, 'http://chicagotribune.feedsportal.com/c/34253/f/622809/index.rss', '', 0, 0, '2016-01-11 20:15:44.215895', '', NULL, 'http://www.chicagotribune.com/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:05:18.792222', '2016-01-11 20:15:44.136584', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:35:34.377397', false);
INSERT INTO ttrss_feeds VALUES (67, 1, 'Telegraph', 25, 'http://www.telegraph.co.uk/CULTURE/BOOKS/RSS', '', 0, 0, '2016-01-11 20:01:59.567195', '', NULL, 'http://www.telegraph.co.uk/culture/books/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:58:32.668662', '2016-01-11 20:01:59.382773', 0, false, 8, false, false, false, '', 0, '2016-01-11 08:21:47.227229', false);
INSERT INTO ttrss_feeds VALUES (852, 1, 'DailyFinance.com', 26, 'http://www.dailyfinance.com/rss.xml', '', 0, 0, '2016-01-11 20:07:26.703397', '', NULL, 'http://www.dailyfinance.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:26.424264', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:07:38.547483', false);
INSERT INTO ttrss_feeds VALUES (738, 1, 'The Independent', 59, 'http://www.independent.co.uk/sport/rugby/rugby-union/rss', '', 0, 0, '2016-01-11 20:02:05.680776', '', NULL, 'http://www.independent.co.uk/sport/rugby/rugby-union/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:12.580574', '2016-01-11 20:02:05.5077', 0, false, 54, false, false, false, '', 0, '2016-01-11 15:41:54.822954', false);
INSERT INTO ttrss_feeds VALUES (475, 1, 'Boston Herald', 141, 'http://feeds.feedburner.com/bostonherald/', '', -1, 0, '2015-09-28 21:48:49.205654', '', NULL, 'http://www.bostonherald.com/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:49.010717', '2015-09-28 21:48:49.016256', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:48:49.059152', false);
INSERT INTO ttrss_feeds VALUES (308, 1, 'Mercury News', NULL, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200733.xml', '', 0, 0, '2016-01-11 20:10:44.196091', '', NULL, 'http://www.mercurynews.com/entertainment/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:06:31.468851', '2016-01-11 20:10:43.977077', 0, false, 23, false, false, false, '', 0, '2016-01-11 18:30:47.971788', false);
INSERT INTO ttrss_feeds VALUES (572, 1, 'HitFix', 10, 'http://www.hitfix.com/channels/tv.rss', '', 0, 0, '2016-01-11 20:10:46.481372', '', NULL, 'http://www.hitfix.com/tv.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 19:16:32.8242', '2016-01-11 20:10:46.409292', 0, false, 5, false, false, false, '', 0, '2016-01-11 17:10:51.484393', false);
INSERT INTO ttrss_feeds VALUES (296, 1, 'Dallas Voice', 134, 'http://www.dallasvoice.com/feed', '', -1, 0, '2015-09-28 21:51:44.763524', '', NULL, 'http://www.dallasvoice.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:42.844548', '2015-09-28 21:51:42.852546', 0, false, 4, false, false, false, '', 0, '2015-09-28 21:51:44.659014', false);
INSERT INTO ttrss_feeds VALUES (57, 1, 'The GQ Eye', 18, 'http://www.gq.com/style/blogs/the-gq-eye/rss.xml', '', 0, 0, '2016-01-11 20:07:28.531527', 'LibXML error 76 at line 41 (column 10): Opening and ending tag mismatch: link line 40 and head
', NULL, 'http://www.gq.com/style/blogs/the-gq-eye/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:40:40.792677', '2016-01-11 20:07:28.197306', 0, false, 12, false, false, false, '', 0, '2015-06-30 19:51:09.654073', false);
INSERT INTO ttrss_feeds VALUES (479, 1, 'ABC Boston', 141, 'http://www.wcvb.com/9849848?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:01:00.575356', '', NULL, 'http://www.wcvb.com/9849848', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:51.6984', '2016-01-11 20:00:59.061486', 0, false, 2, false, false, false, '', 0, '2016-01-11 13:20:45.893356', false);
INSERT INTO ttrss_feeds VALUES (767, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:15:35.120084', '', NULL, 'http://www.ncaa.com/news/cross-country-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:03:02.291741', '2016-01-11 20:15:35.038101', 0, false, 32, false, false, false, '', 0, '2016-01-11 17:36:15.960562', false);
INSERT INTO ttrss_feeds VALUES (28, 1, 'Roger Bert', 9, 'http://www.rogerebert.com/feed', '', 0, 0, '2016-01-11 20:01:58.851996', '', NULL, 'http://www.rogerebert.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:58.780851', 0, false, 3, false, false, false, '', 0, '2016-01-11 13:41:42.171931', false);
INSERT INTO ttrss_feeds VALUES (166, 1, 'ESPN', 29, 'http://sports.espn.go.com/espn/rss/nba/news', '', 0, 0, '2016-01-11 20:00:29.300395', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 21:57:35.081523', '2016-01-11 20:00:29.095567', 0, false, 12, false, false, false, '', 0, '2016-01-11 20:00:29.235554', false);
INSERT INTO ttrss_feeds VALUES (1250, 1, 'CollegeBasketballTalk', 29, 'http://collegebasketballtalk.nbcsports.com/rss.xml', '', 0, 0, '2016-01-11 20:10:06.782931', '', NULL, 'http://collegebasketball.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:27.125102', '2016-01-11 20:10:06.56015', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:10:09.938644', false);
INSERT INTO ttrss_feeds VALUES (840, 1, 'Frieze Blog', 55, 'http://feeds.feedburner.com/FriezeBlog', '', 0, 0, '2016-01-11 20:05:28.930763', '', NULL, 'http://blog.frieze.com/archive/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:43:54.045298', '2016-01-11 20:05:28.595478', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:05:23.148699', false);
INSERT INTO ttrss_feeds VALUES (1245, 1, 'Bleacher Report', 30, 'http://bleacherreport.com/articles/feed?tag_id=17', '', 0, 0, '2016-01-11 20:02:04.684188', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:04.559469', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:02:04.521068', false);
INSERT INTO ttrss_feeds VALUES (896, 1, 'Mother Jones', 37, 'http://feeds.feedburner.com/motherjones/Politics', '', 0, 0, '2016-01-11 20:07:01.031304', '', NULL, 'http://www.motherjones.com/politics/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:00.721131', 0, false, 2, false, false, false, '', 0, '2016-01-11 10:46:43.32834', false);
INSERT INTO ttrss_feeds VALUES (1125, 1, 'Orange County News', 178, 'http://cdn.abclocal.go.com/kabc/xml?id=7095562', '', 0, 0, '2016-01-11 20:07:54.945952', '', NULL, 'http://abclocal.go.com/kabc/channel?section=news/local/orange_county&id=7095562', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:57.4189', '2016-01-11 20:07:54.65143', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:07:26.718258', false);
INSERT INTO ttrss_feeds VALUES (864, 1, 'Destructoid', 24, 'http://www.destructoid.com/?mode=atom', '', 0, 0, '2016-01-11 20:07:03.893019', '', NULL, 'http://www.destructoid.com/?mode=atom', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:03.659373', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:06:53.68807', false);
INSERT INTO ttrss_feeds VALUES (1153, 1, 'Milwaukee Business Journal', 191, 'http://feeds.bizjournals.com/bizj_milwaukee', '', 0, 0, '2016-01-11 20:11:45.499968', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:07.626124', '2016-01-11 20:11:45.234412', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:31:34.787906', false);
INSERT INTO ttrss_feeds VALUES (1062, 1, 'CBS Dallas / Fort Worth', 147, 'http://dfw.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:01:14.570694', '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:19.951167', '2016-01-11 20:01:14.4438', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:01:21.782543', false);
INSERT INTO ttrss_feeds VALUES (946, 1, 'Daily Mail', 7, 'http://www.dailymail.co.uk/ushome/index.rss', '', 0, 0, '2016-01-11 19:55:55.471515', '', NULL, 'http://www.dailymail.co.uk/ushome/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, '2015-07-01 19:34:00.18824', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:15:57.390168', false);
INSERT INTO ttrss_feeds VALUES (930, 1, 'EDM Sauce', 16, 'http://www.edmsauce.com/feed/', '', 0, 0, '2016-01-11 19:55:42.648692', '', NULL, 'http://www.edmsauce.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:21:03.619604', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:55:51.115027', false);
INSERT INTO ttrss_feeds VALUES (13, 1, 'Cele|bitchy', 8, 'http://feeds.feedburner.com/Celebitchy', '', 0, 0, '2016-01-11 20:10:40.281433', '', NULL, 'http://www.celebitchy.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-29 20:55:37.156386', '2016-01-11 20:10:40.027432', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:30:43.19167', false);
INSERT INTO ttrss_feeds VALUES (1048, 1, 'KLKN', 140, 'http://www.klkntv.com/Global/category.asp?C=148537&clienttype=rss', '', 0, 0, '2016-01-11 19:56:04.424766', '', NULL, 'http://www.klkntv.com/category/148537/news-home-page', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:41.766453', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:36:49.497112', false);
INSERT INTO ttrss_feeds VALUES (1251, 1, 'Bleacher Report', 29, 'http://bleacherreport.com/articles/feed?tag_id=22', '', 0, 0, '2016-01-11 20:10:06.432662', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:13.234009', '2016-01-11 20:10:06.274521', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:10:12.69564', false);
INSERT INTO ttrss_feeds VALUES (403, 1, 'WSOC TV', 98, 'http://www.wsoctv.com/feeds/categories/sports/', '', 0, 0, '2016-01-11 19:56:07.321158', '', NULL, 'http://www.wsoctv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:58:29.569574', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:17:02.445567', false);
INSERT INTO ttrss_feeds VALUES (986, 1, 'KXLY.com', 76, 'http://www.kxly.com/?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 19:56:05.751634', '', NULL, 'http://www.kxly.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:16:58.91739', false);
INSERT INTO ttrss_feeds VALUES (863, 1, 'Extreme Tech', 24, 'http://www.extremetech.com/category/Gaming/feed', '', 0, 0, '2016-01-11 20:02:04.542511', '', NULL, 'http://www.extremetech.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:04.366707', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:41:45.648966', false);
INSERT INTO ttrss_feeds VALUES (87, 1, 'Intelligent Travel', 23, 'http://feeds.feedburner.com/INTELLIGENTTRAVEL', '', 0, 0, '2016-01-11 19:56:15.025506', '', NULL, 'http://intelligenttravel.nationalgeographic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 9, false, false, false, '', 0, '2016-01-11 08:16:32.579814', false);
INSERT INTO ttrss_feeds VALUES (248, 1, 'Click 2 Houston', 131, 'http://www.click2houston.com/5695744?format=rss_2.0&view=feed', '', -1, 0, '2015-09-28 21:53:26.828666', '', NULL, 'http://www.click2houston.com/5695744', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:25.671532', '2015-09-28 21:53:25.680942', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:53:26.693871', false);
INSERT INTO ttrss_feeds VALUES (669, 1, 'Los Angeles Business Journal', 115, 'http://labusinessjournal.com/rss/headlines/la-government/', '', 0, 0, '2016-01-11 19:55:48.748929', '', NULL, 'http://labusinessjournal.com/news/la-government/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:13.942096', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:36:40.263226', false);
INSERT INTO ttrss_feeds VALUES (536, 1, 'Vegas Sports Gab', 70, 'http://feeds.feedburner.com/VegasSportsGab?format=xml', '', 0, 0, '2016-01-11 20:07:25.812086', '', NULL, 'http://www.vegassportsgab.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:57.728754', '2016-01-11 20:07:24.950327', 0, false, 8, false, false, false, '', 0, '2016-01-11 09:46:58.506219', false);
INSERT INTO ttrss_feeds VALUES (247, 1, 'Your Houston', 131, 'http://www.yourhoustonnews.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=101houston*&f=rss', '', -1, 0, '2015-09-28 21:53:28.224023', '', NULL, 'http://www.yourhoustonnews.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=101houston*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:28.276024', '2015-09-28 21:53:27.635472', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:53:28.154615', false);
INSERT INTO ttrss_feeds VALUES (776, 1, 'NCAA', 59, 'http://www.ncaa.com/news/volleyball-men/nc/rss.xml', '', 0, 0, '2016-01-11 20:10:27.321748', '', NULL, 'http://www.ncaa.com/news/volleyball-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:27.126764', 0, false, 26, false, false, false, '', 0, '2016-01-11 15:30:29.136594', false);
INSERT INTO ttrss_feeds VALUES (637, 1, 'Music Connection', 16, 'http://musicconnection.com/feed/', '', 0, 0, '2016-01-11 20:07:02.097409', '', NULL, 'http://www.musicconnection.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 22:09:26.118724', '2016-01-11 20:07:01.315338', 0, false, 10, false, false, false, '', 0, '2016-01-11 20:07:02.056585', false);
INSERT INTO ttrss_feeds VALUES (633, 1, 'FACT Magazine', 16, 'http://feeds.feedburner.com/factmag', '', 0, 0, '2016-01-11 20:05:54.342479', '', NULL, 'http://www.factmag.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:07:02.809384', '2016-01-11 20:05:54.148481', 0, false, 9, false, false, false, '', 0, '2016-01-11 19:25:43.629387', false);
INSERT INTO ttrss_feeds VALUES (316, 1, 'The Austin Chronicle', 144, 'http://www.austinchronicle.com/gyrobase/rss/issue.xml', '', -1, 0, '2015-09-28 21:50:55.335348', '', NULL, 'http://www.austinchronicle.com/rss/issue.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:54.511485', '2015-09-28 21:50:54.518754', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:50:55.159746', false);
INSERT INTO ttrss_feeds VALUES (793, 1, 'MRN', 59, 'http://www.mrn.com/Race-Series/NASCAR-Sprint-Cup/News.aspx?rss=true', '', 0, 0, '2016-01-11 20:15:41.302857', '', NULL, 'http://www.mrn.com/Race-Series/NASCAR-Sprint-Cup/News.aspx', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:40.885733', 0, false, 21, false, false, false, '', 0, '2016-01-11 18:35:30.603086', false);
INSERT INTO ttrss_feeds VALUES (832, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/boxing/rss.xml', '', 0, 0, '2016-01-11 20:05:13.513323', '', NULL, 'http://www.bbc.co.uk/sport/0/boxing/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:59:38.169273', '2016-01-11 20:05:13.145502', 0, false, 10, false, false, false, '', 0, '2016-01-11 13:45:15.733985', false);
INSERT INTO ttrss_feeds VALUES (920, 1, 'WKRC', 73, 'http://www.local12.com/news/features/top-stories/rss.xml', '', 0, 0, '2016-01-11 20:15:25.706585', 'HTTP Code: 404', NULL, 'http://www.local12.com/news/features/top-stories/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:31:31.414994', '2016-01-11 20:15:25.462761', 0, false, 3, false, false, false, '', 0, '2015-11-24 13:16:03.096692', false);
INSERT INTO ttrss_feeds VALUES (825, 1, 'The Roar', 59, 'http://feeds.theroar.com.au/theroar/rugby-union', '', 0, 0, '2016-01-11 20:00:23.808809', '', NULL, 'http://www.theroar.com.au', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:33:53.561607', '2016-01-11 20:00:23.493302', 0, false, 59, false, false, false, '', 0, '2016-01-11 19:00:25.554099', false);
INSERT INTO ttrss_feeds VALUES (302, 1, 'NBC Dallas-Fort Worth', 173, 'http://www.nbcdfw.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:01:12.073938', '', NULL, 'http://www.nbcdfw.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:07.659253', '2016-01-11 20:01:10.866557', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:01:02.599356', false);
INSERT INTO ttrss_feeds VALUES (1078, 1, 'KARE 11', 156, 'http://rssfeeds.kare11.com/kare/local&x=1', '', 0, 0, '2016-01-11 20:00:36.311673', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:35.56976', '2016-01-11 20:00:35.096512', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:40:38.752881', false);
INSERT INTO ttrss_feeds VALUES (1046, 1, 'KRDO', 129, 'http://www.krdo.com/14776464?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:06:39.562354', '', NULL, 'http://www.krdo.com/14776464', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:15.080492', '2016-01-11 20:06:39.495498', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:46:45.360617', false);
INSERT INTO ttrss_feeds VALUES (974, 1, 'Horoscope.com', 213, 'http://my.horoscope.com/astrology/daily-horoscopes-rss.html', '', 0, 0, '2016-01-11 20:07:56.508841', '', NULL, 'http://www.horoscope.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-27 20:13:16.964277', '2016-01-11 20:07:55.85056', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:28:29.016071', false);
INSERT INTO ttrss_feeds VALUES (1126, 1, 'Click On Detroit News', 175, 'http://www.clickondetroit.com/4905432?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:01:08.349686', 'HTTP Code: 404', NULL, 'http://www.clickondetroit.com/4905432', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:37.488563', '2016-01-11 20:01:07.095258', 0, false, 0, false, false, false, '', 0, '2015-12-10 06:57:30.456481', false);
INSERT INTO ttrss_feeds VALUES (1008, 1, '| The Dickinson Press', 77, 'http://www.thedickinsonpress.com/latest/rss/', '', 0, 0, '2016-01-11 20:05:58.647326', '', NULL, 'http://www.thedickinsonpress.com/latest', '', NULL, false, '', false, true, false, false, false, false, '2015-07-14 21:08:54.639804', '2016-01-11 20:05:58.209938', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:26:31.785775', false);
INSERT INTO ttrss_feeds VALUES (108, 1, 'WashPost', NULL, 'http://feeds.washingtonpost.com/rss/politics/whitehouse', '', 0, 0, '2016-01-11 20:07:46.274534', '', NULL, 'http://www.washingtonpost.com/pb/politics/white-house/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 22:17:12.172496', '2016-01-11 20:07:46.196995', 0, false, 17, false, false, false, '', 0, '2016-01-11 12:47:25.853205', false);
INSERT INTO ttrss_feeds VALUES (860, 1, 'N4G:  news feed', NULL, 'http://n4g.com/rss/news?channel=&sort=latest', '', 0, 0, '2016-01-11 20:07:03.042288', '', NULL, 'http://contoso/testfeed', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 22:24:17.641391', '2016-01-11 20:07:02.898325', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:47:09.332', false);
INSERT INTO ttrss_feeds VALUES (773, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:15:42.650368', '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:42.495535', 0, false, 30, false, false, false, '', 0, '2016-01-11 16:16:20.466923', false);
INSERT INTO ttrss_feeds VALUES (11, 1, 'EW', 8, 'http://rss.ew.com/web/ew/rss/media/movies/index.xml', '', 0, 0, '2016-01-11 20:01:54.13694', '', NULL, 'http://www.ew.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:53.902828', 0, false, 7, false, false, false, '', 0, '2016-01-11 10:01:57.720365', false);
INSERT INTO ttrss_feeds VALUES (426, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200816.xml', '', -1, 0, '2015-09-28 21:49:31.125745', '', NULL, 'http://www.elpasotimes.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:27.92332', '2015-09-28 21:49:27.929424', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:49:31.041598', false);
INSERT INTO ttrss_feeds VALUES (125, 1, 'CNN', 40, 'http://rss.cnn.com/rss/cnn_health.rss', '', 0, 0, '2016-01-11 20:11:21.113028', '', NULL, 'http://www.cnn.com/HEALTH/index.html?eref=rss_health', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:53:07.972204', '2016-01-11 20:11:20.992121', 0, false, 14, false, false, false, '', 0, '2016-01-11 12:11:15.83373', false);
INSERT INTO ttrss_feeds VALUES (1019, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/rodents', '', 0, 0, '2016-01-11 19:56:24.616499', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/rodents/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:14:33.155702', '2016-01-11 20:15:01.959024', 0, false, 32, false, false, false, '', 0, '2016-01-11 18:56:28.343946', false);
INSERT INTO ttrss_feeds VALUES (1146, 1, 'Region Phoenix Metro | KNXV', 187, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10008&categoryId=20412', '', 0, 0, '2016-01-11 20:12:11.370662', '', NULL, 'http://www.abc15.com/phoenixmetro', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:04.770889', '2016-01-11 20:12:10.127033', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:32:22.366212', false);
INSERT INTO ttrss_feeds VALUES (938, 1, 'BuzzFeed', 16, 'http://www.buzzfeed.com/music.xml', '', 0, 0, '2016-01-11 19:56:33.670897', '', NULL, 'http://www.buzzfeed.com/music', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:37:21.958984', false);
INSERT INTO ttrss_feeds VALUES (1043, 1, 'Journal Gazette', 133, 'http://www.journalgazette.net/rss/', '', 0, 0, '2016-01-11 19:56:31.629456', 'LibXML error 68 at line 1 (column 2): StartTag: invalid element name
', NULL, 'http://www.journalgazette.net/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:19.885003', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 10:36:32.895903', false);
INSERT INTO ttrss_feeds VALUES (171, 1, 'ESPN', 30, 'http://sports.espn.go.com/espn/rss/nhl/news', '', 0, 0, '2016-01-11 20:07:38.101802', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:15:57.591127', '2016-01-11 20:07:37.857034', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:08:25.525535', false);
INSERT INTO ttrss_feeds VALUES (238, 1, 'CBS Chicago', 120, 'http://chicago.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:54:17.77913', '', NULL, 'http://chicago.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:17.423993', '2015-09-28 21:54:17.429754', 0, false, 5, false, false, false, '', 0, '2015-09-28 21:54:17.469581', false);
INSERT INTO ttrss_feeds VALUES (1037, 1, '11 Alive', 122, 'http://archive.11alive.com/rss/local/3/10.xml', '', 0, 0, '2016-01-11 20:01:09.646415', '', NULL, 'http://www.11alive.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:12.403263', '2016-01-11 20:01:09.524845', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:01:17.191917', false);
INSERT INTO ttrss_feeds VALUES (1093, 1, 'All Arlington Voice Reports', 163, 'http://www.arlingtonvoice.com/rss', '', 0, 0, '2016-01-11 20:00:41.943061', '', NULL, 'http://www.arlingtonvoice.com/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:17.778353', '2016-01-11 20:00:41.503819', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:00:44.290512', false);
INSERT INTO ttrss_feeds VALUES (361, 1, 'BET', 37, 'http://feeds.bet.com/BETcom-Politics', '', 0, 0, '2016-01-11 20:01:26.421929', '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 22:02:58.126595', '2016-01-11 20:01:26.188067', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:21:22.790224', false);
INSERT INTO ttrss_feeds VALUES (1098, 1, 'KTUU', 166, 'http://www.ktuu.com/news/news/21043664?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:00:48.443514', '', NULL, 'http://www.ktuu.com/news/news/21043664', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:50.362979', '2016-01-11 20:00:48.273537', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:01:00.895335', false);
INSERT INTO ttrss_feeds VALUES (175, 1, 'CBS Sports', 31, 'http://www.cbssports.com/partners/feeds/rss/tennis_news', '', 0, 0, '2016-01-11 20:06:36.569007', '', NULL, 'http://www.cbssports.com/tennis', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:36.514012', 0, false, 10, false, false, false, '', 0, '2015-06-10 19:18:09.525305', false);
INSERT INTO ttrss_feeds VALUES (1147, 1, 'Alameda Times-Star', 189, 'http://feeds.insidebayarea.com/mngi/rss/CustomRssServlet/181/201303.xml', '', 0, 0, '2016-01-11 20:07:13.767298', '', NULL, 'http://www.insidebayarea.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:55.622263', '2016-01-11 20:07:13.755823', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:47:39.621558', false);
INSERT INTO ttrss_feeds VALUES (509, 1, 'FOX25 - KOKH-TV', NULL, 'http://www.okcfox.com/category/244798/sports?clienttype=rss', '', 0, 0, '2016-01-11 20:06:57.99099', 'HTTP Code: 404', NULL, 'http://www.okcfox.com/category/244798/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 21:58:05.192144', '2016-01-11 20:06:57.149513', 0, false, 22, false, false, false, '', 0, '2015-10-13 14:06:06.856076', false);
INSERT INTO ttrss_feeds VALUES (349, 1, 'SFGate Sports', 118, 'http://www.sfgate.com/rss/feed/Top-Sports-Stories-RSS-Feed-487.php', '', 0, 0, '2016-01-11 20:01:12.443232', '', NULL, 'http://www.sfgate.com/rss/feed/Top-Sports-Stories-RSS-Feed-487.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:24.382868', '2016-01-11 20:01:12.322782', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:01:02.920062', false);
INSERT INTO ttrss_feeds VALUES (1233, 1, 'Yahoo Sports', 27, 'https://sports.yahoo.com/nfl/rss.xml', '', 0, 0, '2016-01-11 20:07:58.566467', '', NULL, 'http://sports.yahoo.com/nfl', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:39.518417', '2016-01-11 20:07:58.462662', 0, false, 3, false, false, false, '', 0, '2016-01-11 08:47:39.085565', false);
INSERT INTO ttrss_feeds VALUES (1252, 1, 'FOX Sports', 29, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cbk', '', 0, 0, '2016-01-11 20:10:06.904915', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cbk', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:28.383507', '2016-01-11 20:10:06.78793', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:07.191016', false);
INSERT INTO ttrss_feeds VALUES (878, 1, 'Slate Articles', 41, 'http://feeds.slate.com/slate-2093565', '', 0, 0, '2016-01-11 20:11:00.864629', '', NULL, 'http://www.slate.com/articles/science/science.teaser.all.10.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:03:15.971154', '2016-01-11 20:11:00.827385', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:11:02.599372', false);
INSERT INTO ttrss_feeds VALUES (823, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/horse-racing/rss.xml', '', 0, 0, '2016-01-11 20:01:44.677602', '', NULL, 'http://www.bbc.co.uk/sport/0/horse-racing/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 19:56:10.745656', '2016-01-11 20:01:44.515634', 0, false, 5, false, false, false, '', 0, '2016-01-11 09:21:31.426666', false);
INSERT INTO ttrss_feeds VALUES (618, 1, 'The Business Journal', 83, 'http://feeds.bizjournals.com/bizj_kansascity', '', 0, 0, '2016-01-11 20:07:22.126165', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:43.147065', '2016-01-11 20:07:21.922382', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:48:00.103427', false);
INSERT INTO ttrss_feeds VALUES (1021, 1, 'Huffington Post – Dogs', 116, 'http://www.huffingtonpost.com/news/dogs/feed//', '', 0, 0, '2016-01-11 20:07:24.697162', '', NULL, 'http://www.huffingtonpost.com/tag/dogs', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:34:27.885412', '2016-01-11 20:07:24.579514', 0, false, 8, false, false, false, '', 0, '2016-01-11 20:07:24.623453', false);
INSERT INTO ttrss_feeds VALUES (367, 1, 'Art in America', 55, 'http://www.artinamericamagazine.com/rss/', '', 0, 0, '2016-01-11 20:10:47.701625', '', NULL, 'http://www.artinamericamagazine.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:08:47.89048', '2016-01-11 20:10:47.014807', 0, false, 11, false, false, false, '', 0, '2016-01-11 18:30:51.955246', false);
INSERT INTO ttrss_feeds VALUES (657, 1, 'Good News Network', 48, 'http://www.goodnewsnetwork.org/feed/', '', 0, 0, '2016-01-11 20:11:39.057455', '', NULL, 'http://www.goodnewsnetwork.org', '', NULL, false, '', false, true, false, false, false, false, '2015-10-27 13:49:31.020602', '2016-01-11 20:11:38.826045', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:11:46.303046', false);
INSERT INTO ttrss_feeds VALUES (30, 1, 'TVGuide.com', 10, 'http://rss.tvguide.com/BREAKINGNEWS', '', 0, 0, '2016-01-11 20:01:58.952678', '', NULL, 'http://www.tvguide.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:58.856439', 0, false, 8, false, false, false, '', 0, '2016-01-11 13:41:42.282122', false);
INSERT INTO ttrss_feeds VALUES (654, 1, 'L.A Times', 25, 'http://www.latimes.com/books/rss2.0.xml', '', 0, 0, '2016-01-11 20:11:18.758133', '', NULL, 'http://www.latimes.com/books/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:18.690808', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:52:41.20284', false);
INSERT INTO ttrss_feeds VALUES (960, 1, 'Patheos', 49, 'http://feeds.feedburner.com/PatheosArticles-Atheism', '', 0, 0, '2016-01-11 20:07:45.529054', '', NULL, 'http://www.patheos.com/Resources/Additional-Resources.html', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:45.342606', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:47:25.393532', false);
INSERT INTO ttrss_feeds VALUES (236, 1, 'Chicago Daily Herald', 120, 'http://chicago.dailyherald.il-foreclosure.com/rss', '', -1, 0, '2015-09-28 21:54:31.443487', '', NULL, 'http://chicago.dailyherald.il-foreclosure.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:27.585546', '2015-09-28 21:54:27.591101', 0, false, 10, false, false, false, '', 0, '2015-09-28 21:54:31.384798', false);
INSERT INTO ttrss_feeds VALUES (1143, 1, 'San Bernadino Sun', 185, 'http://www.sbsun.com/section?template=RSS&profile=4000690&mime=xml', '', 0, 0, '2016-01-11 19:55:56.09645', '', NULL, 'http://www.sbsun.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:05.554508', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:36:42.593646', false);
INSERT INTO ttrss_feeds VALUES (934, 1, 'Magnetic Magazine', 16, 'http://feeds.feedburner.com/magneticmag', '', 0, 0, '2016-01-11 19:56:33.265377', '', NULL, 'http://www.magneticmag.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 10:36:34.290047', false);
INSERT INTO ttrss_feeds VALUES (1035, 1, 'NBC 7', 127, 'http://www.nbcsandiego.com/news/local/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 19:56:00.481268', '', NULL, 'http://www.nbcsandiego.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:21.513341', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:16:20.284317', false);
INSERT INTO ttrss_feeds VALUES (898, 1, 'Men''s Health', 19, 'http://www.mensfitness.co.uk/news/feed', '', 0, 0, '2016-01-11 19:56:35.424868', '', NULL, 'http://www.coachmag.co.uk/taxonomy/term/3/all/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:48:52.269601', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 10:36:37.138553', false);
INSERT INTO ttrss_feeds VALUES (92, 1, 'Kiplinger', 26, 'http://www.kiplinger.com/about/rss/kiplinger.rss', '', 0, 0, '2016-01-11 19:56:15.840755', '', NULL, 'http://www.kiplinger.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:06:47.55881', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:56:24.002957', false);
INSERT INTO ttrss_feeds VALUES (889, 1, 'HuffPost', 36, 'http://www.huffingtonpost.com/feeds/verticals/world/news.xml', '', 0, 0, '2016-01-11 20:15:30.854806', '', NULL, 'http://www.huffingtonpost.com/world/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:29:46.41511', '2016-01-11 20:15:30.390132', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:55:24.732544', false);
INSERT INTO ttrss_feeds VALUES (325, 1, 'Indianapolis Business Journal', 171, 'http://www.ibj.com/rss/9', '', 0, 0, '2016-01-11 20:01:31.216566', '', NULL, 'http://www.ibj.com/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:28.18419', '2016-01-11 20:01:30.871449', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:01:31.26385', false);
INSERT INTO ttrss_feeds VALUES (854, 1, 'TheBlaze', 37, 'http://www.theblaze.com/stories/feed/', '', 0, 0, '2016-01-11 20:07:26.860744', '', NULL, 'http://www.theblaze.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 18:29:31.68915', '2016-01-11 20:07:26.707155', 0, false, 11, false, false, false, '', 0, '2016-01-11 14:08:14.968462', false);
INSERT INTO ttrss_feeds VALUES (807, 1, 'NCAA', 59, 'http://www.ncaa.com/news/icehockey-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:05:06.539202', '', NULL, 'http://www.ncaa.com/news/icehockey-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:16.386054', '2016-01-11 20:05:06.285057', 0, false, 46, false, false, false, '', 0, '2016-01-11 12:05:05.450453', false);
INSERT INTO ttrss_feeds VALUES (1256, 1, 'New York Times', 27, 'http://rss.nytimes.com/services/xml/rss/nyt/CollegeFootball.xml', '', 0, 0, '2016-01-11 19:56:09.730186', '', NULL, 'http://www.nytimes.com/pages/sports/ncaafootball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:48:03.958948', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:16:13.110883', false);
INSERT INTO ttrss_feeds VALUES (644, 1, 'SF Gate', 52, 'http://www.sfgate.com/weird/feed/Weird-News-RSS-Feed-433.php', '', 0, 0, '2016-01-11 20:07:00.195248', '', NULL, 'http://www.sfgate.com/weird/feed/Weird-News-RSS-Feed-433.php', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:00.087266', 0, false, 11, false, false, false, '', 0, '2016-01-11 16:47:07.099488', false);
INSERT INTO ttrss_feeds VALUES (1111, 1, 'Kern Golden Empire', 169, 'http://www.kerngoldenempire.com/rss/91.rss', '', 0, 0, '2016-01-11 20:00:36.915892', 'Unknown/unsupported feed type', NULL, 'http://www.kerngoldenempire.com/rss/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:41.001826', '2016-01-11 20:00:36.809834', 0, false, 0, false, false, false, '', 0, '2015-08-11 12:40:00.01463', false);
INSERT INTO ttrss_feeds VALUES (1106, 1, 'Post-Gazette', 168, 'http://www.post-gazette.com/rss/local', '', 0, 0, '2016-01-11 20:00:51.847249', '', NULL, 'http://www.post-gazette.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:17.690708', '2016-01-11 20:00:51.458431', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:01:15.123519', false);
INSERT INTO ttrss_feeds VALUES (576, 1, 'Health.com', 19, 'http://www.health.com/health/diet-fitness/feed', '', 0, 0, '2016-01-11 20:10:33.642586', '', NULL, 'http://www.health.com/health/diet-fitness', '', NULL, false, '', false, true, false, false, false, false, '2015-08-26 18:27:32.441995', '2016-01-11 20:10:33.478877', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:50:31.419909', false);
INSERT INTO ttrss_feeds VALUES (90, 1, 'gamesTM', 24, 'http://www.gamestm.co.uk/category/news/feed/', '', 0, 0, '2016-01-11 20:07:45.338284', '', NULL, 'http://www.gamestm.co.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 21:37:01.314893', '2016-01-11 20:07:43.905251', 0, false, 13, false, false, false, '', 0, '2016-01-11 12:47:25.22116', false);
INSERT INTO ttrss_feeds VALUES (740, 1, 'The Independent', 55, 'http://www.independent.co.uk/arts-entertainment/architecture/?service=rss', '', 0, 0, '2016-01-11 20:07:27.561399', '', NULL, 'http://www.independent.co.uk/arts-entertainment/architecture/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:16:26.215504', '2016-01-11 20:07:27.342088', 0, false, 6, false, false, false, '', 0, '2016-01-11 10:46:55.287788', false);
INSERT INTO ttrss_feeds VALUES (1110, 1, 'ABC 23', 169, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100001&categoryId=20000', '', 0, 0, '2016-01-11 20:00:38.126452', '', NULL, 'http://www.turnto23.com/kelso-valley-manhunt', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:42.589627', '2016-01-11 20:00:36.920558', 0, false, 1, false, false, false, '', 0, '2016-01-11 20:00:38.078925', false);
INSERT INTO ttrss_feeds VALUES (1204, 1, 'KSHB', 83, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10014&categoryId=20000', '', 0, 0, '2016-01-11 20:07:22.28595', '', NULL, 'http://www.kshb.com/news/local/union-station-centennial', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:45.458037', '2016-01-11 20:07:22.130681', 0, false, 4, false, false, false, '', 0, '2016-01-11 14:08:11.671812', false);
INSERT INTO ttrss_feeds VALUES (544, 1, 'Religion Compass', 49, 'http://feeds.feedburner.com/ReligionCompassExchanges?format=xml', '', 0, 0, '2016-01-11 20:10:39.890116', '', NULL, 'http://religion-compass.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 22:54:31.06622', '2016-01-11 20:10:39.399776', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:30:42.648456', false);
INSERT INTO ttrss_feeds VALUES (243, 1, 'SB Nation Chicago', 120, 'http://chicago.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:07:55.064753', '', NULL, 'http://chicago.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:39.883657', '2016-01-11 20:07:54.948821', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:28:27.42284', false);
INSERT INTO ttrss_feeds VALUES (318, 1, 'The Daily Texan', 67, 'http://dailytexanonline.com/rss.xml', '', -1, 0, '2015-06-12 00:21:11.858892', '', NULL, 'http://www.dailytexanonline.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 21:22:28.600514', '2015-06-12 00:21:11.233987', 0, false, 5, false, false, false, '', 0, '2015-06-12 00:00:54.296385', false);
INSERT INTO ttrss_feeds VALUES (1087, 1, 'NBC 24', 160, 'http://www.nbc24.com/rss.aspx?stories=194900&path=news', '', 0, 0, '2016-01-11 20:00:57.392573', 'HTTP Code: 404', NULL, 'http://www.nbc24.com/news/contents.aspx?id=194900', '', NULL, false, '', false, true, false, false, false, false, '2015-09-30 18:21:06.791974', '2016-01-11 20:00:56.542809', 0, false, 0, false, false, false, '', 0, '2015-08-12 12:47:42.973802', false);
INSERT INTO ttrss_feeds VALUES (278, 1, 'KSAT', 67, 'http://www.ksat.com/content/pns/ksat.topstories.news.rss', '', -1, 0, '2015-06-12 00:21:12.282125', '', NULL, 'http://www.ksat.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 21:23:29.089415', '2015-06-12 00:21:11.863516', 0, false, 6, false, false, false, '', 0, '2015-06-12 00:00:58.500024', false);
INSERT INTO ttrss_feeds VALUES (679, 1, 'CS Monitor', 25, 'http://rss.csmonitor.com/feeds/books', '', 0, 0, '2016-01-11 20:07:43.047649', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:55:37.591934', '2016-01-11 20:07:42.8394', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:48:19.512893', false);
INSERT INTO ttrss_feeds VALUES (1172, 1, 'AZ Central', 200, 'http://rssfeeds.azcentral.com/phoenix/glendaleandpeoria', '', 0, 0, '2016-01-11 19:55:42.526307', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:12.971564', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:35:46.365639', false);
INSERT INTO ttrss_feeds VALUES (370, 1, 'Art Asia Pacific', 55, 'http://artasiapacific.com/rss/pages', '', 0, 0, '2016-01-11 19:56:34.369308', '', NULL, 'http://artasiapacific.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:09:38.055811', '2016-01-11 20:15:01.959024', 0, false, 9, false, false, false, '', 0, '2016-01-11 15:37:22.52988', false);
INSERT INTO ttrss_feeds VALUES (711, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/58', '', 0, 0, '2016-01-11 20:02:07.517384', '', NULL, 'http://www.yardbarker.com/gymnastics', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:09:23.449609', '2016-01-11 20:02:07.297491', 0, false, 62, false, false, false, '', 0, '2016-01-11 17:41:59.252129', false);
INSERT INTO ttrss_feeds VALUES (111, 1, 'FOX News', 37, 'http://feeds.foxnews.com/foxnews/politics', '', 0, 0, '2016-01-11 19:56:17.808702', 'LibXML error 76 at line 42 (column 8): Opening and ending tag mismatch: meta line 33 and head
', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:53:50.576201', '2016-01-11 20:15:01.959024', 0, false, 13, false, false, false, '', 0, '2016-01-07 17:17:51.001921', false);
INSERT INTO ttrss_feeds VALUES (429, 1, 'ABC 7', 142, 'http://www.kvia.com/15161272?format=rss_2.0&view=feed', '', -1, 0, '2015-09-28 21:49:26.86323', '', NULL, 'http://www.kvia.com/15161272', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:26.034949', '2015-09-28 21:49:26.041046', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:49:26.7185', false);
INSERT INTO ttrss_feeds VALUES (1031, 1, 'My News 13', 126, 'http://mynews13.com/content/news/cfnews13/feeds/rss.html/local-headlines.html', '', 0, 0, '2016-01-11 19:56:25.461158', '', NULL, 'http://www.mynews13.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:51.93663', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:56:29.506392', false);
INSERT INTO ttrss_feeds VALUES (1272, 1, 'Sports Illustrated', 29, 'http://www.si.com/rss/si_ncaab.rss', '', 0, 0, '2016-01-11 20:10:07.151879', '', NULL, 'http://www.si.com/si_ncaab.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:34.404348', '2016-01-11 20:10:07.145383', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:50:08.994418', false);
INSERT INTO ttrss_feeds VALUES (575, 1, 'ScienceDaily', 19, 'http://feeds.sciencedaily.com/sciencedaily/health_medicine/fitness', '', 0, 0, '2016-01-11 20:10:34.173437', '', NULL, 'http://www.sciencedaily.com/news/health_medicine/fitness/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:45:32.049106', '2016-01-11 20:10:33.646899', 0, false, 4, false, false, false, '', 0, '2016-01-11 19:10:36.211904', false);
INSERT INTO ttrss_feeds VALUES (734, 1, 'Forbes', 39, 'http://www.forbes.com/technology/feed2/', '', 0, 0, '2016-01-11 20:01:41.03551', '', NULL, 'http://www.forbes.com/technology/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:37:32.431318', '2016-01-11 20:01:40.942566', 0, false, 6, false, false, false, '', 0, '2016-01-11 19:01:41.595312', false);
INSERT INTO ttrss_feeds VALUES (54, 1, 'NYT', 18, 'http://rss.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml', '', 0, 0, '2016-01-11 20:00:15.991309', '', NULL, 'http://www.nytimes.com/section/fashion?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:16.722342', '2016-01-11 20:00:15.823817', 0, false, 10, false, false, false, '', 0, '2016-01-11 18:00:21.966145', false);
INSERT INTO ttrss_feeds VALUES (173, 1, 'FOX Sports', 30, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', 0, 0, '2016-01-11 20:06:36.511279', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:16:53.796721', '2016-01-11 20:06:36.289646', 0, false, 6, false, false, false, '', 0, '2016-01-11 16:46:41.227947', false);
INSERT INTO ttrss_feeds VALUES (954, 1, 'SAVEUR', 20, 'http://www.saveur.com/rss.xml', '', 0, 0, '2016-01-11 20:06:36.28669', '', NULL, 'http://www.saveur.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 18:49:12.172249', '2016-01-11 20:06:36.231282', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:46:40.59651', false);
INSERT INTO ttrss_feeds VALUES (972, 1, 'Think Progress', 36, 'http://thinkprogress.org/world/issue/feed/', '', 0, 0, '2016-01-11 19:56:05.835462', '', NULL, 'http://thinkprogress.org', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:54:30.613726', '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:16:59.879621', false);
INSERT INTO ttrss_feeds VALUES (1033, 1, 'My Fox Orlando', 126, 'http://www.myfoxorlando.com/category/235345/central-florida-news?clienttype=rss', '', 0, 0, '2016-01-11 20:01:21.393951', 'LibXML error 23 at line 1 (column 5797): EntityRef: expecting '';''
', NULL, 'http://www.myfoxorlando.com/category/235345/central-florida-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:53.615649', '2016-01-11 20:01:20.845296', 0, false, 1, false, false, false, '', 0, '2015-08-26 19:25:27.281138', false);
INSERT INTO ttrss_feeds VALUES (237, 1, 'RedEye Chicago', 120, 'http://neighborhoods.redeyechicago.com/feed/', '', -1, 0, '2015-09-28 22:01:31.907994', '', NULL, 'http://neighborhoods.redeyechicago.com/feed/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:38.142014', '2015-09-28 22:01:31.750443', 0, false, 9, false, false, false, '', 0, '2015-06-10 19:00:41.305009', false);
INSERT INTO ttrss_feeds VALUES (257, 1, 'CBS Philly', 136, 'http://philadelphia.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:52:45.329039', '', NULL, 'http://philadelphia.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:45.988091', '2015-09-28 21:52:44.119462', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:52:44.713175', false);
INSERT INTO ttrss_feeds VALUES (529, 1, 'KOIN', 72, 'http://koin.com/feed/', '', -1, 0, '2015-09-28 21:43:40.874389', '', NULL, 'http://koin.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:41.50503', '2015-09-28 21:43:40.461705', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:43:40.573801', false);
INSERT INTO ttrss_feeds VALUES (904, 1, 'WWD', 18, 'http://wwd.com/custom-feed/markets/', '', 0, 0, '2016-01-11 20:00:25.971183', '', NULL, 'http://wwd.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:20.064372', '2016-01-11 20:00:25.887128', 0, false, 6, false, false, false, '', 0, '2016-01-11 19:00:27.087424', false);
INSERT INTO ttrss_feeds VALUES (780, 1, 'USA BMX', 60, 'https://www.usabmx.com/site/sections/27.rss', '', 0, 0, '2016-01-11 20:15:45.431169', '', NULL, 'https://www.usabmx.com/site/sections/27', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 20:08:32.901047', '2016-01-11 20:15:45.055632', 0, false, 19, false, false, false, '', 0, '2016-01-11 08:55:44.216685', false);
INSERT INTO ttrss_feeds VALUES (276, 1, 'My SA', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Sports-921.php', '', 0, 0, '2016-01-11 20:10:39.059572', '', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Sports-921.php', '', NULL, false, '', false, true, false, false, false, false, '2015-08-12 19:47:50.366108', '2016-01-11 20:10:38.071231', 0, false, 46, false, false, false, '', 0, '2016-01-11 19:50:38.742833', false);
INSERT INTO ttrss_feeds VALUES (953, 1, 'BuzzFeed', 52, 'http://www.buzzfeed.com/wtf.xml', '', 0, 0, '2016-01-11 20:07:43.535889', '', NULL, 'http://www.buzzfeed.com/wtf', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:24:43.936102', '2016-01-11 20:07:43.162106', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:47:15.608134', false);
INSERT INTO ttrss_feeds VALUES (567, 1, 'Metacritic', 10, 'http://www.metacritic.com/rss/features', '', 0, 0, '2016-01-11 20:10:47.010691', '', NULL, 'http://www.metacritic.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-29 18:16:31.018608', '2016-01-11 20:10:46.662466', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:10:51.693026', false);
INSERT INTO ttrss_feeds VALUES (385, 1, '10 TV Central Ohio', 73, 'http://www.10tv.com/content/syndication/news_central-ohio.xml', '', -1, 0, '2015-06-23 22:20:02.037949', '', NULL, 'http://www.10tv.com/content/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:18:39.898482', '2015-06-23 22:20:01.90633', 0, false, 0, false, false, false, '', 0, '2015-06-23 22:18:33.406542', false);
INSERT INTO ttrss_feeds VALUES (45, 1, 'BuzzFeed', 13, 'http://www.buzzfeed.com/VIDEOS.XML', '', 0, 0, '2016-01-11 20:07:28.193053', '', NULL, 'http://www.buzzfeed.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:58:17.079192', '2016-01-11 20:07:27.909459', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:08:16.016563', false);
INSERT INTO ttrss_feeds VALUES (1234, 1, 'ProFootballTalk', 27, 'http://profootballtalk.nbcsports.com/category/rumor-mill/feed/atom/', '', 0, 0, '2016-01-11 20:07:58.459296', '', NULL, 'http://profootballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:38.076339', '2016-01-11 20:07:58.369226', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:47:32.531879', false);
INSERT INTO ttrss_feeds VALUES (955, 1, 'Discovery', 40, 'http://feeds.feedburner.com/DiscoverHealthMedicine', '', 0, 0, '2016-01-11 20:07:43.75555', '', NULL, 'http://discovermagazine.com/rss/topic-feeds/health-medicine', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:43.541951', 0, false, 3, false, false, false, '', 0, '2016-01-11 10:27:22.825536', false);
INSERT INTO ttrss_feeds VALUES (565, 1, 'NPR', 41, 'http://www.npr.org/rss/rss.php?id=1025', '', 0, 0, '2016-01-11 20:10:39.127239', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1025', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:01:35.407154', '2016-01-11 20:10:39.063188', 0, false, 20, false, false, false, '', 0, '2016-01-11 17:10:43.254506', false);
INSERT INTO ttrss_feeds VALUES (858, 1, 'Slate', 37, 'http://feeds.slate.com/slate-101526', '', 0, 0, '2016-01-11 19:55:37.008006', '', NULL, 'http://www.slate.com/articles/news_and_politics/politics.teaser.all.10.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:16:27.070569', '2016-01-11 20:15:01.959024', 0, false, 10, false, false, false, '', 0, '2016-01-11 09:15:59.082255', false);
INSERT INTO ttrss_feeds VALUES (978, 1, 'The Salt Lake Tribune', 71, 'http://www.sltrib.com/rss/feed/?sec=/News/&level=0', '', 0, 0, '2016-01-11 19:56:06.997956', '', NULL, 'http://www.sltrib.com/News/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:33:10.243283', '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:16:11.019571', false);
INSERT INTO ttrss_feeds VALUES (440, 1, 'Local Memphis', 123, 'http://www2.localmemphis.com/rss/59.rss', '', -1, 0, '2015-09-28 21:48:58.792524', '', NULL, 'http://www.localmemphis.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:57.985493', '2015-09-28 21:48:57.992347', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:48:58.721353', false);
INSERT INTO ttrss_feeds VALUES (315, 1, 'Mashable', 51, 'http://feeds.mashable.com/mashable/lifestyle', '', 0, 0, '2016-01-11 20:00:28.141474', '', NULL, 'http://mashable.com/category/lifestyle/?utm_campaign=Mash-Prod-RSS-Feedburner-Lifestyle-Partial&utm_cid=Mash-Prod-RSS-Feedburner-Lifestyle-Partial', '', NULL, false, '', false, false, false, false, false, false, '2015-10-20 19:20:07.169203', '2016-01-11 20:00:27.942951', 0, false, 11, false, false, false, '', 0, '2016-01-11 08:20:21.251558', false);
INSERT INTO ttrss_feeds VALUES (937, 1, 'BuzzFeed', 37, 'http://www.buzzfeed.com/politics.xml', '', 0, 0, '2016-01-11 20:11:08.14296', '', NULL, 'http://www.buzzfeed.com/politics', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:07.332289', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:11:06.232153', false);
INSERT INTO ttrss_feeds VALUES (147, 1, 'Politico', 44, 'http://www.politico.com/rss/polls.xml', '', 0, 0, '2016-01-11 20:02:04.125005', '', NULL, 'http://www.politico.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 21:08:30.840437', '2016-01-11 20:02:04.082913', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:41:45.290194', false);
INSERT INTO ttrss_feeds VALUES (1040, 1, 'The Jersey City Independent', 128, 'http://www.jerseycityindependent.com/feed/', '', 0, 0, '2016-01-11 19:56:03.481133', '', NULL, 'http://www.jerseycityindependent.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:30.212636', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:16:56.279019', false);
INSERT INTO ttrss_feeds VALUES (1045, 1, 'WIVB', 135, 'http://wivb.com/feed', '', 0, 0, '2016-01-11 19:56:04.964699', '', NULL, 'http://wivb.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:53.254718', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:56:13.599997', false);
INSERT INTO ttrss_feeds VALUES (351, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124642', '', 0, 0, '2016-01-11 20:01:13.391764', '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:31.086833', '2016-01-11 20:01:13.122663', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:01:04.012702', false);
INSERT INTO ttrss_feeds VALUES (228, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/entertainment/top-stories/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:15:21.914069', '', NULL, 'http://www.nbclosangeles.com/entertainment/top-stories', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:20.427247', '2016-01-11 20:15:20.861643', 0, false, 6, false, false, false, '', 0, '2016-01-11 18:35:13.379775', false);
INSERT INTO ttrss_feeds VALUES (724, 1, 'Transworld Motocross', 60, 'http://motocross.transworld.net/feed/', '', 0, 0, '2016-01-11 20:00:14.984198', '', NULL, 'http://motocross.transworld.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:41:24.637233', '2016-01-11 20:00:14.562005', 0, false, 17, false, false, false, '', 0, '2016-01-11 18:00:20.944178', false);
INSERT INTO ttrss_feeds VALUES (980, 1, 'Deseret News', 71, 'http://www.deseretnews.com/utah/index.rss', '', 0, 0, '2016-01-11 20:06:57.143418', '', NULL, 'http://www.deseretnews.com/home/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:35:10.820109', '2016-01-11 20:06:56.856283', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:26:56.860826', false);
INSERT INTO ttrss_feeds VALUES (384, 1, 'The Columbus Dispatch', 150, 'http://www.dispatch.com/content/syndication/lae_events.xml', '', 0, 0, '2016-01-11 20:15:27.297316', '', NULL, 'http://www.dispatch.com/content/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:13.392468', '2016-01-11 20:15:27.186229', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:55:21.474011', false);
INSERT INTO ttrss_feeds VALUES (808, 1, 'NCAA', 59, 'http://www.ncaa.com/news/gymnastics-men/nc/rss.xml', '', 0, 0, '2016-01-11 20:05:07.158017', '', NULL, 'http://www.ncaa.com/news/gymnastics-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:02:45.05862', '2016-01-11 20:05:06.948542', 0, false, 23, false, false, false, '', 0, '2016-01-11 12:05:06.196838', false);
INSERT INTO ttrss_feeds VALUES (1141, 1, 'Desert Star Weekly', 183, 'http://desertstarweekly.com/feed/', '', 0, 0, '2016-01-11 20:07:55.614851', '', NULL, 'http://desertstarweekly.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:50.411621', '2016-01-11 20:07:55.068706', 0, false, 0, false, false, false, '', 0, '2015-12-11 18:06:57.4615', false);
INSERT INTO ttrss_feeds VALUES (629, 1, 'HuffPost', 52, 'http://www.huffingtonpost.com/feeds/verticals/weird-news/index.xml', '', 0, 0, '2016-01-11 20:00:34.81173', '', NULL, 'http://www.huffingtonpost.com/weird-news/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 18:10:54.810181', '2016-01-11 20:00:34.612021', 0, false, 8, false, false, false, '', 0, '2016-01-11 18:00:49.958491', false);
INSERT INTO ttrss_feeds VALUES (1088, 1, 'Toledo Free Press', 160, 'http://www.toledofreepress.com/feed/', '', 0, 0, '2016-01-11 20:00:58.047969', '56 Recv failure: Connection reset by peer', NULL, 'http://www.toledofreepress.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-30 18:21:10.08683', '2016-01-11 20:00:57.903317', 0, false, 2, false, false, false, '', 0, '2015-08-18 04:10:54.585697', false);
INSERT INTO ttrss_feeds VALUES (246, 1, 'Houston Business Journal', 131, 'http://feeds.bizjournals.com/bizj_houston?format=xml', '', 0, 0, '2016-01-11 20:05:07.88554', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:16.709284', '2016-01-11 20:05:07.690822', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:25:07.565876', false);
INSERT INTO ttrss_feeds VALUES (1085, 1, 'Toledo News Now', 160, 'http://www.toledonewsnow.com/Global/category.asp?C=160943&clienttype=rss', '', 0, 0, '2016-01-11 20:00:58.884959', '', NULL, 'http://www.wtol.com/category/160943/top-local-news-from-wtol', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:43.945443', '2016-01-11 20:00:58.055558', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:00:49.012309', false);
INSERT INTO ttrss_feeds VALUES (1099, 1, 'AlaskaDispatch', 166, 'http://www.adn.com/rss-feeds/feed/all', '', 0, 0, '2016-01-11 20:00:47.074322', '', NULL, 'http://www.adn.com/rss-feeds/feed/all', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:47.949649', '2016-01-11 20:00:45.688572', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:00:44.10512', false);
INSERT INTO ttrss_feeds VALUES (593, 1, 'BBC Sport - Cricket', 59, 'http://feeds.bbci.co.uk/sport/0/cricket/rss.xml#', '', 0, 0, '2016-01-11 20:05:56.931327', '', NULL, 'http://www.bbc.co.uk/sport/0/cricket/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:19:42.475387', '2016-01-11 20:05:56.661203', 0, false, 8, false, false, false, '', 0, '2016-01-11 20:05:56.896863', false);
INSERT INTO ttrss_feeds VALUES (1104, 1, 'New Orleans Community News', 164, 'http://blog.nola.com/new_orleans/atom.xml', '', 0, 0, '2016-01-11 20:00:49.311636', '', NULL, 'http://blog.nola.com/new_orleans/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:55.713999', '2016-01-11 20:00:49.04345', 0, false, 1, false, false, false, '', 0, '2016-01-08 14:25:31.60303', false);
INSERT INTO ttrss_feeds VALUES (1225, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_science?format=xml', '', 0, 0, '2016-01-11 19:56:06.69876', '', NULL, 'http://www.sciencedaily.com/news/top/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:16:29.699137', false);
INSERT INTO ttrss_feeds VALUES (1023, 1, 'American Humane Association', 116, 'http://feeds.feedburner.com/AmericanHumaneAssociation', '', 0, 0, '2016-01-11 20:07:24.947651', '', NULL, 'http://americanhumaneblog.org', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:34:26.187672', '2016-01-11 20:07:24.768353', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:07:02.01336', false);
INSERT INTO ttrss_feeds VALUES (177, 1, 'ESPN', 31, 'http://sports.espn.go.com/espn/rss/tennis/news', '', 0, 0, '2016-01-11 19:56:05.395987', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 23:00:59.667364', '2016-01-11 20:15:01.959024', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:56:13.963339', false);
INSERT INTO ttrss_feeds VALUES (913, 1, 'Nat Geo', 41, 'http://feeds.nationalgeographic.com/ng/news/news_environment', '', 0, 0, '2016-01-11 19:56:30.045547', '', NULL, 'http://news.nationalgeographic.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:07:34.379412', '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:37:18.25201', false);
INSERT INTO ttrss_feeds VALUES (981, 1, 'Daily Herald Provo', 71, 'http://www.heraldextra.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', 0, 0, '2016-01-11 19:56:06.2671', '', NULL, 'http://www.heraldextra.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:32:55.610579', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:16:10.522103', false);
INSERT INTO ttrss_feeds VALUES (715, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/33', '', 0, 0, '2016-01-11 20:15:33.988651', '', NULL, 'http://www.yardbarker.com/skateboarding', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:35:11.984534', '2016-01-11 20:15:33.708152', 0, false, 22, false, false, false, '', 0, '2016-01-11 16:55:28.09461', false);
INSERT INTO ttrss_feeds VALUES (1044, 1, 'The Buffalo News', 135, 'http://www.buffalonews.com/section/rssGen?profileID=1016&profileName=City%20of%20Buffalo', '', 0, 0, '2016-01-11 20:00:05.507579', '', NULL, 'http://www.buffalonews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:54.497154', '2016-01-11 20:00:05.343221', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:40:03.689874', false);
INSERT INTO ttrss_feeds VALUES (176, 1, 'FOX Sports', 31, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', 0, 0, '2016-01-11 20:06:36.636328', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:34:25.901308', '2016-01-11 20:06:36.573303', 0, false, 8, false, false, false, '', 0, '2016-01-11 16:46:41.718524', false);
INSERT INTO ttrss_feeds VALUES (107, 1, 'WashPost', NULL, 'http://feeds.washingtonpost.com/rss/politics/campaigns', '', 0, 0, '2016-01-11 20:02:02.679136', '', NULL, 'http://www.washingtonpost.com/pb/politics/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:26:20.096389', '2016-01-11 20:02:02.406052', 0, false, 15, false, false, false, '', 0, '2016-01-11 19:02:04.456986', false);
INSERT INTO ttrss_feeds VALUES (1140, 1, 'Press Enterprise', 183, 'http://www.pe.com/common/rss/rss.php?catID=24122', '', 0, 0, '2016-01-11 20:05:07.686588', '', NULL, 'http://www.pe.com/common/archives/?catID=24122', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:52.293268', '2016-01-11 20:05:07.329322', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:25:07.362164', false);
INSERT INTO ttrss_feeds VALUES (224, 1, 'IB Daily', 38, 'http://www.investors.com/Rss.axd?path=InvestingRSS.xml', '', 0, 0, '2016-01-11 20:05:58.203612', '', NULL, 'http://www.investors.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:21.234942', '2016-01-11 20:05:57.519139', 0, false, 11, false, false, false, '', 0, '2016-01-11 16:45:46.722834', false);
INSERT INTO ttrss_feeds VALUES (172, 1, 'CBS Sports', 30, 'http://www.cbssports.com/partners/feeds/rss/nhl_news', '', 0, 0, '2016-01-11 20:07:38.147981', '', NULL, 'http://www.cbssports.com/nhl', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:17:55.139113', '2016-01-11 20:07:38.104794', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:07:40.05808', false);
INSERT INTO ttrss_feeds VALUES (985, 1, 'Times News', 76, 'http://magicvalley.com/search/?f=rss&c=news/local&l=25&s=start_time&sd=desc', '', 0, 0, '2016-01-11 20:07:47.15546', '', NULL, 'http://magicvalley.com/search/?f=rss&c=news/local&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:46.837761', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:47:26.573496', false);
INSERT INTO ttrss_feeds VALUES (1142, 1, 'KIII TV3', 170, 'http://www.kiiitv.com/category/194865/news?clienttype=rss', '', 0, 0, '2016-01-11 20:00:52.756337', '', NULL, 'http://www.kiiitv.com/category/194865/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:20.265523', '2016-01-11 20:00:52.290717', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:01:15.697061', false);
INSERT INTO ttrss_feeds VALUES (1050, 1, 'FOX 21', 129, 'http://fox21news.com/feed/', '', 0, 0, '2016-01-11 20:07:25.935944', '', NULL, 'http://fox21news.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:17.114302', '2016-01-11 20:07:25.816627', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:07:02.295239', false);
INSERT INTO ttrss_feeds VALUES (721, 1, 'Racer X', 60, 'http://racerxonline.com/feeds/rss/category/breaking-news', '', 0, 0, '2016-01-11 20:00:12.095704', '', NULL, 'http://racerxonline.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:25:18.246434', '2016-01-11 20:00:11.848089', 0, false, 9, false, false, false, '', 0, '2016-01-11 08:20:09.566315', false);
INSERT INTO ttrss_feeds VALUES (1176, 1, 'KRQE 13', 198, 'http://krqe.com/feed/', '', 0, 0, '2016-01-11 20:11:40.519125', '', NULL, 'http://krqe.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:54.491479', '2016-01-11 20:11:40.325366', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:11:36.737126', false);
INSERT INTO ttrss_feeds VALUES (1032, 1, 'WESH', 126, 'http://www.wesh.com/11789118?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 19:56:25.706968', '', NULL, 'http://www.wesh.com/11789118', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:56.328101', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:56:29.83525', false);
INSERT INTO ttrss_feeds VALUES (18, 1, 'The Wrap', 8, 'http://www.thewrap.com/feed/', '', 0, 0, '2016-01-11 20:07:43.902514', '', NULL, 'http://www.thewrap.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 21:58:56.913383', '2016-01-11 20:07:43.823167', 0, false, 12, false, false, false, '', 0, '2016-01-11 12:47:24.873255', false);
INSERT INTO ttrss_feeds VALUES (1072, 1, 'ABC East Bay', 153, 'http://cdn.abclocal.go.com/kgo/xml?id=7102525', '', 0, 0, '2016-01-11 20:01:14.435053', '', NULL, 'http://abclocal.go.com/kgo/channel?section=news/local/east_bay&id=7102525', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:30.153115', '2016-01-11 20:01:14.056522', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:01:21.672005', false);
INSERT INTO ttrss_feeds VALUES (438, 1, 'Fox Memphis', 123, 'http://www.myfoxmemphis.com/category/50813/tennessee-headlines?clienttype=rss', '', -1, 0, '2015-09-28 21:49:03.622966', '', NULL, 'http://www.myfoxmemphis.com/category/50813/tennessee-headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:04.009096', '2015-09-28 21:49:02.01111', 0, false, 4, false, false, false, '', 0, '2015-09-28 21:49:02.94967', false);
INSERT INTO ttrss_feeds VALUES (722, 1, 'Reuters', 40, 'http://feeds.reuters.com/reuters/healthNews', '', 0, 0, '2016-01-11 20:00:12.970367', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:24:26.702433', '2016-01-11 20:00:12.821022', 0, false, 10, false, false, false, '', 0, '2016-01-11 19:20:08.942942', false);
INSERT INTO ttrss_feeds VALUES (743, 1, 'The Independent', 26, 'http://www.independent.co.uk/money/spend-save/?service=rss', '', 0, 0, '2016-01-11 20:00:13.779431', 'LibXML error 68 at line 4 (column 33): xmlParseEntityRef: no name
', NULL, 'http://www.independent.co.uk/money/spend-save/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:06:53.965879', '2016-01-11 20:00:13.419145', 0, false, 4, false, false, false, '', 0, '2015-11-27 20:51:05.212342', false);
INSERT INTO ttrss_feeds VALUES (1060, 1, 'News 4 Jax', 148, 'http://www.news4jax.com/4908618?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:01:18.319758', 'HTTP Code: 404', NULL, 'http://www.news4jax.com/4908618', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:47.598187', '2016-01-11 20:01:17.807014', 0, false, 2, false, false, false, '', 0, '2015-12-01 17:37:26.668758', false);
INSERT INTO ttrss_feeds VALUES (1273, 1, 'Sports Illustrated', 27, 'http://www.si.com/rss/si_ncaaf.rss', '', 0, 0, '2016-01-11 20:07:58.170731', '', NULL, 'http://www.si.com/si_ncaaf.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:48:05.57587', '2016-01-11 20:07:58.164047', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:29:15.206299', false);
INSERT INTO ttrss_feeds VALUES (861, 1, 'Bodybuilding', 19, 'http://www.bodybuilding.com/rss/articles/training', '', 0, 0, '2016-01-11 20:11:19.401063', '', NULL, 'http://www.bodybuilding.com/fun/bbmaintrain.htm', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:32:43.226128', '2016-01-11 20:11:18.960344', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:52:41.991909', false);
INSERT INTO ttrss_feeds VALUES (1039, 1, 'NJ News 12', 128, 'http://newjersey.news12.com/cmlink/1.4124770#', '', 0, 0, '2016-01-11 19:56:01.648495', '', NULL, 'http://newjersey.news12.com/cmlink/1.4124770', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:28.397056', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 10:36:08.724931', false);
INSERT INTO ttrss_feeds VALUES (566, 1, 'The Earth Times', 41, 'http://feeds.earthtimes.org/earthtimes?format=xml', '', 0, 0, '2016-01-11 19:56:32.929681', '', NULL, 'http://www.earthtimes.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:05:57.643054', '2016-01-11 20:15:01.959024', 0, false, 12, false, false, false, '', 0, '2016-01-11 19:16:49.154348', false);
INSERT INTO ttrss_feeds VALUES (78, 1, 'Edmunds.com', 22, 'http://www.edmunds.com/feeds/rss/articles.xml', '', 0, 0, '2016-01-11 19:56:13.560697', '', NULL, 'http://www.edmunds.com/feeds/rss/articles.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:33:05.034095', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:56:13.294926', false);
INSERT INTO ttrss_feeds VALUES (342, 1, 'SFGate', 63, 'http://www.sfgate.com/bayarea/feed/Bay-Area-News-429.php', '', -1, 0, '2015-06-12 00:21:19.827792', '', NULL, 'http://www.sfgate.com/bayarea/feed/Bay-Area-News-429.php', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:37:07.656764', '2015-06-12 00:21:19.720561', 0, false, 2, false, false, false, '', 0, '2015-06-12 00:21:19.788278', false);
INSERT INTO ttrss_feeds VALUES (306, 1, 'Mercury News', 63, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200735.xml', '', -1, 0, '2015-07-07 18:20:10.561628', '', NULL, 'http://www.mercurynews.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-22 18:46:22.512563', '2015-07-07 18:20:09.098959', 0, false, 3, false, false, false, '', 0, '2015-07-07 18:20:10.472589', false);
INSERT INTO ttrss_feeds VALUES (685, 1, 'Volleyball Magazine', 59, 'http://www.volleyballmag.com/feeds/all', '', 0, 0, '2016-01-11 20:15:28.876797', '', NULL, 'http://www.volleyballmag.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:27:30.218185', '2016-01-11 20:15:28.737871', 0, false, 61, false, false, false, '', 0, '2016-01-11 08:55:30.23684', false);
INSERT INTO ttrss_feeds VALUES (1123, 1, 'AL.com', 177, 'http://blog.al.com/news_birmingham_impact/atom.xml', '', 0, 0, '2016-01-11 20:00:15.584445', '', NULL, 'http://www.al.com/news/birmingham/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:52.214476', '2016-01-11 20:00:15.229361', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:00:21.534194', false);
INSERT INTO ttrss_feeds VALUES (1038, 1, 'NJ.com', 128, 'http://blog.nj.com/hudsoncountynow_impact/atom.xml', '', 0, 0, '2016-01-11 19:56:03.835337', '', NULL, 'http://www.nj.com/hudson/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:33.365581', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:36:54.631355', false);
INSERT INTO ttrss_feeds VALUES (890, 1, 'Huff Post', 38, 'http://www.huffingtonpost.com/feeds/verticals/money/news.xml', '', 0, 0, '2016-01-11 20:15:45.839881', '', NULL, 'http://www.huffingtonpost.com/money/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:24.769338', '2016-01-11 20:15:45.773802', 0, false, 2, false, false, false, '', 0, '2016-01-11 08:55:44.842899', false);
INSERT INTO ttrss_feeds VALUES (452, 1, 'SB Nation Seattle', 130, 'http://seattle.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:06:40.258398', '', NULL, 'http://seattle.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:28.71934', '2016-01-11 20:06:40.223237', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:46:46.291431', false);
INSERT INTO ttrss_feeds VALUES (448, 1, 'Seattle Pi', 130, 'http://www.seattlepi.com/ae/collectionRss/A-E-Heds-9147.php', '', 0, 0, '2016-01-11 20:06:40.32969', '', NULL, 'http://www.seattlepi.com/entertainment/collectionRss/A-E-Heds-9147.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:32.23096', '2016-01-11 20:06:40.262781', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:26:34.287622', false);
INSERT INTO ttrss_feeds VALUES (520, 1, 'WLKY', 95, 'http://www.wlky.com/9366964?format=rss_2.0&view=feed', '', -1, 0, '2015-09-28 21:42:27.129504', '', NULL, 'http://www.wlky.com/9366964', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 18:01:58.882318', '2015-09-28 21:42:24.704469', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:42:27.026314', false);
INSERT INTO ttrss_feeds VALUES (314, 1, 'SF Gate', 30, 'http://www.sfgate.com/sharks/feed/San-Jose-Sharks-RSS-Feed-492.php', '', 0, 0, '2016-01-11 20:00:26.210123', '', NULL, 'http://www.sfgate.com/sharks/feed/San-Jose-Sharks-RSS-Feed-492.php', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:00:25.97593', 0, false, 9, false, false, false, '', 0, '2016-01-11 19:00:27.202141', false);
INSERT INTO ttrss_feeds VALUES (661, 1, 'HuffPost', 48, 'http://www.huffingtonpost.com/feeds/verticals/good-news/index.xml', '', 0, 0, '2016-01-11 20:07:00.361706', '', NULL, 'http://www.huffingtonpost.com/good-news/', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 20:00:52.586117', '2016-01-11 20:07:00.199792', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:06:46.47906', false);
INSERT INTO ttrss_feeds VALUES (135, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Science.xml', '', 0, 0, '2016-01-11 20:10:59.185861', '', NULL, 'http://www.nytimes.com/section/science?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:46:16.716912', '2016-01-11 20:10:59.086974', 0, false, 21, false, false, false, '', 0, '2016-01-11 16:52:22.847426', false);
INSERT INTO ttrss_feeds VALUES (621, 1, 'KCTV Kansas City', 83, 'http://www.kctv5.com/category/208603/sports?clienttype=rss', '', 0, 0, '2016-01-11 20:07:24.572642', '', NULL, 'http://www.kctv5.com/category/208603/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:48.769833', '2016-01-11 20:07:24.087519', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:08:12.563671', false);
INSERT INTO ttrss_feeds VALUES (337, 1, 'AllMusic Blog', 16, 'http://www.allmusic.com/rss', '', 0, 0, '2016-01-11 20:00:27.939456', '', NULL, 'http://www.allmusic.com/blog', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:20:03.610132', '2016-01-11 20:00:27.583917', 0, false, 15, false, false, false, '', 0, '2016-01-11 20:00:27.907931', false);
INSERT INTO ttrss_feeds VALUES (519, 1, 'WHAS 11', 95, 'http://rssfeeds.whas11.com/whas/local', '', -1, 0, '2015-09-28 21:42:22.045336', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 20:55:59.832683', '2015-09-28 21:42:20.390584', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:42:21.884241', false);
INSERT INTO ttrss_feeds VALUES (1057, 1, 'WRAL', 145, 'http://www.wral.com/news/rss/142/', '', 0, 0, '2016-01-11 19:56:09.666767', '', NULL, 'http://www.wral.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:00.542936', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 13:16:13.619428', false);
INSERT INTO ttrss_feeds VALUES (35, 1, 'BuzzFeed', 11, 'http://www.buzzfeed.com/comedy.xml', '', 0, 0, '2016-01-11 20:11:08.496781', '', NULL, 'http://www.buzzfeed.com/comedy', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:41:28.069512', '2016-01-11 20:11:08.29367', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:06.705454', false);
INSERT INTO ttrss_feeds VALUES (457, 1, 'CBS Denver', 82, 'http://cbs4denver.com/local/resources_rss.xmlhttp://cbs4denver.com/local/resources_rss.xml', '', -1, 0, '2015-09-28 21:42:32.878123', '', NULL, 'http://denver.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:31.757541', '2015-09-28 21:42:31.766429', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:42:32.255254', false);
INSERT INTO ttrss_feeds VALUES (517, 1, 'WAVE 3', 95, 'http://www.wave3.com/category/1178/home?clienttype=rss', '', -1, 0, '2015-09-28 21:42:23.651808', '', NULL, 'http://www.wave3.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 18:00:25.898233', '2015-09-28 21:42:23.086647', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:42:23.271642', false);
INSERT INTO ttrss_feeds VALUES (693, 1, 'BBC', 40, 'http://feeds.bbci.co.uk/news/health/rss.xml', '', 0, 0, '2016-01-11 19:55:54.0544', '', NULL, 'http://www.bbc.co.uk/news/health/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:12.697717', '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:36:44.648961', false);
INSERT INTO ttrss_feeds VALUES (526, 1, 'Portland Tribune', 72, 'http://pamplinmedia.com/component/obrss/portland-tribune', '', -1, 0, '2015-09-28 21:43:39.621009', '', NULL, 'http://pamplinmedia.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:36.196779', '2015-09-28 21:43:36.210155', 0, false, 3, false, false, false, '', 0, '2015-09-28 21:43:39.424179', false);
INSERT INTO ttrss_feeds VALUES (9, 1, 'US Magazine', 8, 'http://www.usmagazine.com/celebrity_news/rss', '', 0, 0, '2016-01-11 20:15:20.780225', '', NULL, 'http://www.usmagazine.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:50:53.177312', '2016-01-11 20:15:20.419519', 0, false, 14, false, false, false, '', 0, '2016-01-11 16:35:12.865079', false);
INSERT INTO ttrss_feeds VALUES (106, 1, 'WashPost', 37, 'http://feeds.washingtonpost.com/rss/politics', '', 0, 0, '2016-01-11 20:05:07.324925', '', NULL, 'http://www.washingtonpost.com/pb/politics/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-12 20:55:11.951907', '2016-01-11 20:05:07.16266', 0, false, 16, false, false, false, '', 0, '2016-01-11 12:05:06.249358', false);
INSERT INTO ttrss_feeds VALUES (419, 1, 'Fox Detroit', 93, 'http://www.myfoxdetroit.com/category/233687/local-news?clienttype=rss', '', -1, 0, '2015-06-12 00:15:37.884552', '', NULL, 'http://www.myfoxdetroit.com/category/233687/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-06-12 00:15:37.215733', 0, false, 7, false, false, false, '', 0, '2015-06-11 23:55:37.572985', false);
INSERT INTO ttrss_feeds VALUES (726, 1, 'Reuters', 38, 'http://feeds.reuters.com/reuters/businessNews', '', 0, 0, '2016-01-11 20:15:33.465899', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:21:12.589835', '2016-01-11 20:15:33.247564', 0, false, 8, false, false, false, '', 0, '2016-01-11 09:35:28.802468', false);
INSERT INTO ttrss_feeds VALUES (851, 1, 'The Guardian', 21, 'http://www.theguardian.com/lifeandstyle/home-and-garden/rss', '', 0, 0, '2016-01-11 20:07:26.312251', '', NULL, 'http://www.theguardian.com/lifeandstyle/home-and-garden', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:20:50.276949', '2016-01-11 20:07:25.939211', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:07:38.054354', false);
INSERT INTO ttrss_feeds VALUES (1171, 1, 'AZ Central', 137, 'http://rssfeeds.azcentral.com/phoenix/local', '', 0, 0, '2016-01-11 20:07:57.426128', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:26.011616', '2016-01-11 20:07:57.062096', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:28:30.243735', false);
INSERT INTO ttrss_feeds VALUES (1075, 1, 'KTUL', 154, 'http://www.ktul.com/global/category.asp?C=189710&clienttype=rss', '', 0, 0, '2016-01-11 20:00:42.776396', 'HTTP Code: 404', NULL, 'http://www.ktul.com/category/189710/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:21.471299', '2016-01-11 20:00:41.948375', 0, false, 0, false, false, false, '', 0, '2015-09-16 16:15:18.120801', false);
INSERT INTO ttrss_feeds VALUES (446, 1, 'Seattle Pi', 130, 'http://www.seattlepi.com/local/feed/seattlepi-com-Local-News-218.php', '', -1, 0, '2015-09-28 21:41:27.127474', '', NULL, 'http://www.seattlepi.com/local/feed/seattlepi-com-Local-News-218.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:27.013294', '2015-09-28 21:41:27.019479', 0, false, 3, false, false, false, '', 0, '2015-09-28 21:41:27.040657', false);
INSERT INTO ttrss_feeds VALUES (48, 1, 'Upworthy', NULL, 'http://feeds.feedburner.com/UPWORTHY', '', 0, 0, '2016-01-11 20:07:46.833207', '', NULL, 'http://www.upworthy.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:47:58.833031', '2016-01-11 20:07:46.278392', 0, false, 8, false, false, false, '', 0, '2016-01-11 12:47:26.274158', false);
INSERT INTO ttrss_feeds VALUES (323, 1, 'Indystar', 92, 'http://rssfeeds.indystar.com/indystar/todaystopstories&x=1', '', -1, 0, '2015-06-12 00:20:46.730269', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:19:54.387816', '2015-06-12 00:20:45.419682', 0, false, 0, false, false, false, '', 0, '2015-06-11 12:40:38.057138', false);
INSERT INTO ttrss_feeds VALUES (327, 1, 'RTV6', 92, 'http://www.theindychannel.com/news/topstory.rss', '', -1, 0, '2015-06-12 00:21:32.584788', '', NULL, 'http://www.theindychannel.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 21:09:35.334731', '2015-06-12 00:21:31.086194', 0, false, 1, false, false, false, '', 0, '2015-06-12 00:01:17.311338', false);
INSERT INTO ttrss_feeds VALUES (326, 1, 'WTHR', 92, 'http://www.wthr.com/category/23903/local-news?clienttype=rss', '', -1, 0, '2015-06-22 19:47:16.836994', '', NULL, 'http://www.wthr.com/category/23903/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:47:16.384507', '2015-06-22 19:47:16.390142', 0, false, 2, false, false, false, '', 0, '2015-06-22 19:47:16.481309', false);
INSERT INTO ttrss_feeds VALUES (1177, 1, 'KASA.com', 198, 'http://kasa.com/feed/', '', 0, 0, '2016-01-11 20:11:41.964299', '', NULL, 'http://kasa.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:56.317343', '2016-01-11 20:11:41.554522', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:52:54.666358', false);
INSERT INTO ttrss_feeds VALUES (477, 1, 'WCVB', 110, 'http://www.wcvb.com/9849828?format=rss_2.0&view=feed', '', -1, 0, '2015-06-22 19:13:37.66538', '', NULL, 'http://www.wcvb.com/9849828?absolute=true', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:13:37.472481', '2015-06-22 19:13:37.475869', 0, false, 0, false, false, false, '', 0, '2015-06-22 19:13:37.512417', false);
INSERT INTO ttrss_feeds VALUES (86, 1, 'BudgetTravel.com', 23, 'http://www.budgettravel.com/latest/features/feed/', '', 0, 0, '2016-01-11 19:56:14.744306', '', NULL, 'http://www.budgettravel.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:53:45.223729', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-07 20:37:05.000754', false);
INSERT INTO ttrss_feeds VALUES (1069, 1, 'Inside Bay Area', 153, 'http://feeds.insidebayarea.com/mngi/rss/CustomRssServlet/181/201302.xml', '', 0, 0, '2016-01-11 20:00:15.820252', '', NULL, 'http://www.insidebayarea.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:25.311183', '2016-01-11 20:00:15.590876', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:00:21.788045', false);
INSERT INTO ttrss_feeds VALUES (324, 1, 'Indystar', 92, 'http://rssfeeds.indystar.com/indystar/allsports&x=1', '', 0, 0, '2016-01-11 20:07:52.916644', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:31:47.408761', '2016-01-11 20:07:52.095385', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:48:29.21141', false);
INSERT INTO ttrss_feeds VALUES (1086, 1, 'Toledo Blade', 160, 'http://www.toledoblade.com/rss/local', '', 0, 0, '2016-01-11 20:00:57.900704', '', NULL, 'http://www.toledoblade.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-30 18:21:08.226584', '2016-01-11 20:00:57.39694', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:01:39.288649', false);
INSERT INTO ttrss_feeds VALUES (482, 1, 'WBUR', 110, 'http://www.wbur.org/feed', '', -1, 0, '2015-06-12 00:21:11.230953', '', NULL, 'http://www.wbur.org/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:36:08.245223', '2015-06-12 00:21:11.129926', 0, false, 1, false, false, false, '', 0, '2015-06-11 17:20:48.088092', false);
INSERT INTO ttrss_feeds VALUES (539, 1, 'Religion News Service', 49, 'http://feeds.feedburner.com/religion-news-service?format=xml', '', 0, 0, '2016-01-11 19:56:23.390705', '', NULL, 'http://www.religionnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 22:54:37.842954', '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 09:16:47.173768', false);
INSERT INTO ttrss_feeds VALUES (130, 1, 'FOX', 41, 'http://feeds.foxnews.com/FOXNEWS/SCIENCE', '', 0, 0, '2016-01-11 20:10:58.619935', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:58.442867', 0, false, 16, false, false, false, '', 0, '2016-01-11 08:50:56.967321', false);
INSERT INTO ttrss_feeds VALUES (53, 1, 'Fads & Ads', 14, 'http://blog.tartanlabs.com/rss', '', 0, 0, '2016-01-11 19:56:12.789623', '', NULL, 'http://blog.tartanlabs.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:56:12.716779', false);
INSERT INTO ttrss_feeds VALUES (471, 1, 'WTOP', 114, 'http://wtop.com/section/entertainment/feed', '', 0, 0, '2016-01-11 19:56:26.055184', '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:39.891889', '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 08:16:42.434469', false);
INSERT INTO ttrss_feeds VALUES (121, 1, 'WIRED', 38, 'http://www.wired.com/category/business/feed/', '', 0, 0, '2016-01-11 20:11:18.208581', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:26.566139', '2016-01-11 20:11:18.014119', 0, false, 12, false, false, false, '', 0, '2016-01-11 08:51:16.962938', false);
INSERT INTO ttrss_feeds VALUES (837, 1, 'NPR', 55, 'http://www.npr.org/rss/rss.php?id=1047', '', 0, 0, '2016-01-11 19:56:14.68792', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1047', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:31:40.687957', '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:17:09.800336', false);
INSERT INTO ttrss_feeds VALUES (89, 1, 'GamesRadar', 24, 'http://www.gamesradar.com/all-platforms/news/feed/', '', 0, 0, '2016-01-11 19:56:15.703172', '', NULL, 'http://www.gamesradar.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 11, false, false, false, '', 0, '2016-01-11 18:56:23.791723', false);
INSERT INTO ttrss_feeds VALUES (85, 1, 'CNN', 23, 'http://rss.cnn.com/RSS/CNN_TRAVEL.RSS', '', 0, 0, '2016-01-11 19:56:14.701115', 'HTTP Code: 404', NULL, 'http://www.cnn.com/TRAVEL/index.html?eref=rss_travel', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 7, false, false, false, '', 0, '2015-08-10 12:50:21.265121', false);
INSERT INTO ttrss_feeds VALUES (424, 1, 'Detroit Sport Radio - Podcast', 93, 'http://www.blogtalkradio.com/detroitsportsrag/podcast', '', 0, 0, '2016-01-11 20:05:44.926171', '', NULL, 'http://www.blogtalkradio.com/detroitsportsrag', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:09:17.002164', '2016-01-11 20:05:44.360793', 0, false, 5, false, false, false, '', 0, '2016-01-11 12:45:30.878606', false);
INSERT INTO ttrss_feeds VALUES (822, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/formula1/rss.xml', '', 0, 0, '2016-01-11 20:05:13.834735', '', NULL, 'http://www.bbc.co.uk/sport/0/formula1/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 19:56:09.417825', '2016-01-11 20:05:13.800642', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:25:11.722797', false);
INSERT INTO ttrss_feeds VALUES (581, 1, 'SF Gate', 20, 'http://www.sfgate.com/rss/feed/Food-Dining-550.php', '', 0, 0, '2016-01-11 20:07:26.421369', '', NULL, 'http://www.sfgate.com/rss/feed/Food-Dining-550.php', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:15:56.389685', '2016-01-11 20:07:26.316967', 0, false, 7, false, false, false, '', 0, '2016-01-11 12:07:38.158104', false);
INSERT INTO ttrss_feeds VALUES (168, 1, 'CBS Sports', 29, 'http://www.cbssports.com/partners/feeds/rss/nba_news', '', 0, 0, '2016-01-11 20:00:29.940605', '', NULL, 'http://www.cbssports.com/nba', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:04:01.029042', '2016-01-11 20:00:29.850399', 0, false, 16, false, false, false, '', 0, '2016-01-11 14:00:21.269516', false);
INSERT INTO ttrss_feeds VALUES (6, 1, 'NYT', 7, 'http://www.nytimes.com/services/xml/rss/nyt/US.xml', '', 0, 0, '2016-01-11 20:05:57.199847', '', NULL, 'http://www.nytimes.com/pages/national/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:44:26.439618', '2016-01-11 20:05:56.93511', 0, false, 9, false, false, false, '', 0, '2016-01-11 17:26:29.998576', false);
INSERT INTO ttrss_feeds VALUES (506, 1, 'KOCO', 188, 'http://www.koco.com/11777728?format=rss_2.0&view=feed', '', -1, 0, '2015-09-28 21:39:28.494203', '', NULL, 'http://www.koco.com/11777728', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:25.76245', '2015-09-28 21:39:25.814081', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:39:28.380307', false);
INSERT INTO ttrss_feeds VALUES (746, 1, 'The Independent', 18, 'http://rss.feedsportal.com/c/266/f/3803/index.rss', '', 0, 0, '2016-01-11 20:00:16.082023', '', NULL, 'http://www.independent.co.uk/life-style/fashion/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:17.562284', '2016-01-11 20:00:15.996645', 0, false, 9, false, false, false, '', 0, '2016-01-11 18:00:22.094485', false);
INSERT INTO ttrss_feeds VALUES (1218, 1, 'Cute Overload', 116, 'http://cuteoverload.com/feed/', '', 0, 0, '2016-01-11 20:11:09.768187', '', NULL, 'http://cuteoverload.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:09.669656', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:11:08.175575', false);
INSERT INTO ttrss_feeds VALUES (1221, 1, 'BlogPaws', 116, 'http://feeds.feedburner.com/BlogPaws?format=xml', '', 0, 0, '2016-01-11 20:06:49.689103', '', NULL, 'http://blogpaws.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:49.425198', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:06:35.89438', false);
INSERT INTO ttrss_feeds VALUES (995, 1, 'NHL.com', 30, 'http://www.nhl.com/rss/news.xml', '', 0, 0, '2016-01-11 20:07:47.194301', '', NULL, 'http://www.nhl.com/rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-18 20:02:53.377385', '2016-01-11 20:07:47.158587', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:27:28.957103', false);
INSERT INTO ttrss_feeds VALUES (493, 1, 'Nashville Public Radio', 186, 'http://nashvillepublicradio.org/rss.xml', '', -1, 0, '2015-09-28 21:39:37.500915', '', NULL, 'http://nashvillepublicradio.org', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:37.246369', '2015-09-28 21:39:37.252667', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:39:37.398714', false);
INSERT INTO ttrss_feeds VALUES (527, 1, 'Portland Business Journal', 72, 'http://feeds.bizjournals.com/bizj_portland', '', 0, 0, '2016-01-11 20:06:52.577882', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:42.386646', '2016-01-11 20:06:52.389954', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:26:52.112031', false);
INSERT INTO ttrss_feeds VALUES (865, 1, 'NYT', 38, 'http://rss.nytimes.com/services/xml/rss/nyt/Business.xml', '', 0, 0, '2016-01-11 19:55:37.658758', '', NULL, 'http://www.nytimes.com/pages/business/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:39:17.651617', '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 17:36:26.521262', false);
INSERT INTO ttrss_feeds VALUES (507, 1, 'Fox 25', 188, 'http://www.okcfox.com/category/244797/news?clienttype=rss', '', -1, 0, '2015-09-28 21:39:31.919039', '', NULL, 'http://www.okcfox.com/category/244797/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:30.604648', '2015-09-28 21:39:30.613147', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:39:30.863277', false);
INSERT INTO ttrss_feeds VALUES (1028, 1, 'Bay News 9', 124, 'http://www.baynews9.com/content/news/baynews9/feeds/rss.html/local-news.html', '', 0, 0, '2016-01-11 19:56:37.833392', '', NULL, 'http://www.baynews9.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:45:33.918254', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 19:16:53.955941', false);
INSERT INTO ttrss_feeds VALUES (723, 1, 'Cycle News', 60, 'http://www.cyclenews.com/1/Racing-Article-Group-Headlines/Article-Headlines.aspx', '', 0, 0, '2016-01-11 20:00:12.815034', 'HTTP Code: 404', NULL, 'http://www.cyclenews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-12-14 20:15:36.188442', '2016-01-11 20:00:12.098959', 0, false, 2, false, false, false, '', 0, '2015-11-17 21:10:30.409674', false);
INSERT INTO ttrss_feeds VALUES (1156, 1, 'Scottsdale Independent', 190, 'http://feeds.feedblitz.com/ScottsdaleIndependent', '', 0, 0, '2016-01-11 20:07:20.477459', '', NULL, 'http://www.scottsdaleindependent.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:56.483653', '2016-01-11 20:07:13.769921', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:08:05.601535', false);
INSERT INTO ttrss_feeds VALUES (1012, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/cows_sheep_pigs', '', 0, 0, '2016-01-11 19:56:36.298641', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/cows,_sheep,_pigs/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:14:57.439084', '2016-01-11 20:15:01.959024', 0, false, 33, false, false, false, '', 0, '2016-01-11 19:16:52.087001', false);
INSERT INTO ttrss_feeds VALUES (689, 1, 'CS Monitor', 41, 'http://rss.csmonitor.com/feeds/environment', '', 0, 0, '2016-01-11 20:15:29.189082', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:28:51.264131', '2016-01-11 20:15:28.881958', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:35:23.227956', false);
INSERT INTO ttrss_feeds VALUES (798, 1, 'American Craft Beer', 51, 'http://americancraftbeer.com/feed/rss/the-biz/the-biz.html?format=feed', '', 0, 0, '2016-01-11 20:00:21.841398', 'LibXML error 5 at line 720 (column 1): Extra content at the end of the document
', NULL, 'http://americancraftbeer.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:12:53.297707', '2016-01-11 20:00:16.085412', 0, false, 0, false, false, false, '', 0, '2015-12-22 01:56:43.29588', false);
INSERT INTO ttrss_feeds VALUES (43, 1, 'VideoGamer.com', 24, 'http://feeds.videogamer.com/rss/news.xml', '', 0, 0, '2016-01-11 20:11:17.147476', '', NULL, 'http://www.videogamer.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:49:47.632906', '2016-01-11 20:11:16.496942', 0, false, 12, false, false, false, '', 0, '2016-01-11 16:52:39.636918', false);
INSERT INTO ttrss_feeds VALUES (830, 1, 'Bleacher Report', 59, 'http://bleacherreport.com/articles/feed?tag_id=2318', '', 0, 0, '2016-01-11 20:05:12.752574', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-06 21:26:02.80563', '2016-01-11 20:05:11.577156', 0, false, 14, false, false, false, '', 0, '2016-01-11 12:05:10.746467', false);
INSERT INTO ttrss_feeds VALUES (356, 1, 'SB Nation Bay Area', 118, 'http://bayarea.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:49.904889', '', NULL, 'http://bayarea.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:28.761368', '2016-01-11 20:05:49.76175', 0, false, 4, false, false, false, '', 0, '2016-01-11 15:25:45.597194', false);
INSERT INTO ttrss_feeds VALUES (420, 1, 'MyFox Detroit Sports', 93, 'http://www.myfoxdetroit.com/category/230149/sports?clienttype=rss', '', 0, 0, '2016-01-11 20:07:48.754777', 'LibXML error 23 at line 1 (column 5777): EntityRef: expecting '';''
', NULL, 'http://www.myfoxdetroit.com/category/230149/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:11:28.126604', '2016-01-11 20:07:48.111121', 0, false, 6, false, false, false, '', 0, '2015-08-06 08:42:14.516804', false);
INSERT INTO ttrss_feeds VALUES (512, 1, 'OklahomaSports.Net', 79, 'http://oklahomasports.net/feed/', '', 0, 0, '2016-01-11 20:11:34.639089', '', NULL, 'http://oklahomasports.net', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 18:40:11.95736', '2016-01-11 20:11:34.340247', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:52:45.771491', false);
INSERT INTO ttrss_feeds VALUES (645, 1, 'ComingSoon.net', 9, 'http://www.comingsoon.net/feed', '', 0, 0, '2016-01-11 20:05:54.752722', '', NULL, 'http://www.comingsoon.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:28:34.938409', '2016-01-11 20:05:54.346931', 0, false, 13, false, false, false, '', 0, '2016-01-11 17:45:42.914428', false);
INSERT INTO ttrss_feeds VALUES (182, 1, 'USA TODAY', 32, 'http://rssfeeds.usatoday.com/UsatodaycomGolf-TopStories', '', 0, 0, '2016-01-11 20:06:39.357276', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:18:56.621028', '2016-01-11 20:06:39.10076', 0, false, 6, false, false, false, '', 0, '2016-01-11 16:46:44.772582', false);
INSERT INTO ttrss_feeds VALUES (165, 1, 'Bleacher Report', 29, 'http://bleacherreport.com/articles/feed?tag_id=19', '', 0, 0, '2016-01-11 20:00:28.838517', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:03:57.11293', '2016-01-11 20:00:28.669306', 0, false, 7, false, false, false, '', 0, '2016-01-11 14:40:22.318819', false);
INSERT INTO ttrss_feeds VALUES (235, 1, 'Chicago Tribune', 120, 'http://feeds.feedburner.com/ChicagoBreakingSports/', '', 0, 0, '2016-01-11 20:07:55.846392', '', NULL, 'http://www.chicagotribune.com/sports/breaking/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:24.014936', '2016-01-11 20:07:55.620166', 0, false, 8, false, false, false, '', 0, '2016-01-11 09:47:37.972183', false);
INSERT INTO ttrss_feeds VALUES (409, 1, 'CBS 11', 173, 'http://cbs11tv.com/gasprices/resources_rss.xml', '', -1, 0, '2015-09-28 21:50:07.255206', '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:07.297893', '2015-09-28 21:50:06.805088', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:50:07.179187', false);
INSERT INTO ttrss_feeds VALUES (984, 1, 'Idaho Statesman', 76, 'http://www.idahostatesman.com/102/index.rss', '', 0, 0, '2016-01-11 20:06:56.851623', '', NULL, 'http://www.idahostatesman.com/102/index.html', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:58:25.618965', '2016-01-11 20:06:56.715684', 0, false, 0, false, false, false, '', 0, '2015-10-28 05:45:13.357124', false);
INSERT INTO ttrss_feeds VALUES (1145, 1, 'AZ Central', 187, 'http://rssfeeds.azcentral.com/phoenix/gilbert', '', 0, 0, '2016-01-11 20:12:10.123951', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:00.79173', '2016-01-11 20:12:09.202136', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:32:22.243206', false);
INSERT INTO ttrss_feeds VALUES (1016, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/horses', '', 0, 0, '2016-01-11 19:55:54.406414', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/horses/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:35:57.240606', '2016-01-11 20:15:01.959024', 0, false, 38, false, false, false, '', 0, '2016-01-11 16:16:47.991359', false);
INSERT INTO ttrss_feeds VALUES (1020, 1, 'ScienceDaily', 116, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/veterinary_medicine', '', 0, 0, '2016-01-11 19:56:25.075341', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/veterinary_medicine/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:14:35.738532', '2016-01-11 20:15:01.959024', 0, false, 10, false, false, false, '', 0, '2016-01-11 18:56:28.734294', false);
INSERT INTO ttrss_feeds VALUES (599, 1, 'Optimist World', 48, 'http://optimistworld.com/RssFeed.aspx?SectionId=1C848EEB-3E15-4C39-A4AA-F71880EFCD64&title=Optimist%20World%20|%20Good%20News&link=News.aspx', '', 0, 0, '2016-01-11 20:07:47.526687', 'HTTP Code: 404', NULL, 'http://optimistworld.com/News.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:39:55.461302', '2016-01-11 20:07:47.200197', 0, false, 1, false, false, false, '', 0, '2015-08-27 07:33:03.560167', false);
INSERT INTO ttrss_feeds VALUES (317, 1, 'Austin Business Journal', 144, 'http://feeds.bizjournals.com/bizj_austin', '', 0, 0, '2016-01-11 20:01:26.185021', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:59.407172', '2016-01-11 20:01:25.999131', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:21:22.570857', false);
INSERT INTO ttrss_feeds VALUES (571, 1, 'HuffPost', 10, 'http://www.huffingtonpost.com/feeds/verticals/tv/index.xml', '', 0, 0, '2016-01-11 20:10:46.658118', '', NULL, 'http://www.huffingtonpost.com/tv/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:46.486768', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:10:51.615803', false);
INSERT INTO ttrss_feeds VALUES (192, 1, 'BBC Sport', 34, 'http://feeds.bbci.co.uk/sport/0/football/rss.xml?edition=uk', '', 0, 0, '2016-01-11 20:11:08.746176', '', NULL, 'http://www.bbc.co.uk/sport/0/football/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 18:37:59.623824', '2016-01-11 20:11:08.501399', 0, false, 0, false, false, false, '', 0, '2016-01-11 11:11:01.842455', false);
INSERT INTO ttrss_feeds VALUES (824, 1, 'Bleacher Report', 59, 'http://bleacherreport.com/articles/feed?tag_id=2474', '', 0, 0, '2016-01-11 20:05:13.877602', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:40:51.735028', '2016-01-11 20:05:13.839087', 0, false, 15, false, false, false, '', 0, '2016-01-11 12:05:12.165544', false);
INSERT INTO ttrss_feeds VALUES (1117, 1, 'WIAT 42', 177, 'http://wiat.com/feed/', '', 0, 0, '2016-01-11 20:06:38.376194', '', NULL, 'http://wiat.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:50.529478', '2016-01-11 20:06:38.213095', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:07:31.170321', false);
INSERT INTO ttrss_feeds VALUES (404, 1, 'WSCO TV Charlotte', 98, 'http://www.wsoctv.com/feeds/categories/entertainment/', '', 0, 0, '2016-01-11 20:05:15.958214', '', NULL, 'http://www.wsoctv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:04:06.381626', '2016-01-11 20:05:15.670359', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:45:12.653336', false);
INSERT INTO ttrss_feeds VALUES (430, 1, 'KVIA Sports', NULL, 'http://www.kvia.com/15160498?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:07:49.44809', '', NULL, 'http://www.kvia.com/15160498', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:54:07.829713', '2016-01-11 20:07:49.186099', 0, false, 28, false, false, false, '', 0, '2016-01-11 16:48:26.639109', false);
INSERT INTO ttrss_feeds VALUES (183, 1, 'FOX Sports', 32, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', 0, 0, '2016-01-11 20:06:39.441408', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:09:45.066457', '2016-01-11 20:06:39.360009', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:46:45.261395', false);
INSERT INTO ttrss_feeds VALUES (392, 1, 'The Buckeye Battle Cry', NULL, 'http://thebuckeyebattlecry.com/feed', '', 0, 0, '2016-01-11 20:11:42.402797', '', NULL, 'http://thebuckeyebattlecry.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:17:36.601892', '2016-01-11 20:11:41.96888', 0, false, 35, false, false, false, '', 0, '2016-01-11 17:11:37.455264', false);
INSERT INTO ttrss_feeds VALUES (899, 1, 'The Guardian', 25, 'http://www.theguardian.com/books/rss', '', 0, 0, '2016-01-11 20:01:25.993083', '', NULL, 'http://www.theguardian.com/books', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 18:48:52.672818', '2016-01-11 20:01:25.274587', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:21:21.805557', false);
INSERT INTO ttrss_feeds VALUES (1182, 1, 'The Chronicle of Winston-Salem', 204, 'http://www.wschronicle.com/feed/', '', 0, 0, '2016-01-11 20:07:42.337912', '', NULL, 'http://www.wschronicle.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:52.214732', '2016-01-11 20:07:41.971556', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:47:14.283555', false);
INSERT INTO ttrss_feeds VALUES (1255, 1, 'New York Times', 27, 'http://rss.nytimes.com/services/xml/rss/nyt/ProFootball.xml', '', 0, 0, '2016-01-11 20:07:57.701618', '', NULL, 'http://www.nytimes.com/pages/sports/football/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:47:59.401324', '2016-01-11 20:07:57.619995', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:29:14.585405', false);
INSERT INTO ttrss_feeds VALUES (1002, 1, 'StarTribune.com', 161, 'http://www.startribune.com/local/index.rss2', '', 0, 0, '2016-01-11 20:00:45.411945', '', NULL, 'http://www.startribune.com/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:38.46456', '2016-01-11 20:00:45.055788', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:00:39.451557', false);
INSERT INTO ttrss_feeds VALUES (242, 1, 'CBS Chicago Sports', 120, 'http://chicago.cbslocal.com/category/sports/feed/', '', 0, 0, '2016-01-11 20:07:47.700293', '', NULL, 'http://chicago.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:15.795165', '2016-01-11 20:07:47.531744', 0, false, 4, false, false, false, '', 0, '2016-01-11 12:07:59.538284', false);
INSERT INTO ttrss_feeds VALUES (1131, 1, 'The Orange County Register', 180, 'http://www.ocregister.com/common/rss/rss.php?catID=18895', '', 0, 0, '2016-01-11 20:07:48.106535', '', NULL, 'http://www.ocregister.com/common/archives/?catID=18895', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:07.40639', '2016-01-11 20:07:47.934838', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:47:29.310911', false);
INSERT INTO ttrss_feeds VALUES (1247, 1, 'Yahoo Sports', 27, 'https://sports.yahoo.com/ncaaf/rss.xml', '', 0, 0, '2016-01-11 20:07:58.364019', '', NULL, 'http://sports.yahoo.com/ncaaf', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:50:08.413354', '2016-01-11 20:07:58.17429', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:48:36.338474', false);
INSERT INTO ttrss_feeds VALUES (1113, 1, 'The Monitor', 170, 'http://www.themonitor.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/local*&f=rss', '', 0, 0, '2016-01-11 20:00:52.285017', '', NULL, 'http://www.themonitor.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news/local*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:19.570612', '2016-01-11 20:00:51.851934', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:01:15.401327', false);
INSERT INTO ttrss_feeds VALUES (1102, 1, 'WTVQ', 167, 'http://www.wtvq.com/rss/3441.rss', '', 0, 0, '2016-01-11 20:00:56.538943', 'HTTP Code: 404', NULL, 'http://www.wtvq.com/rss/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-30 18:20:58.929113', '2016-01-11 20:00:53.334039', 0, false, 1, false, false, false, '', 0, '2015-08-31 10:22:10.581858', false);
INSERT INTO ttrss_feeds VALUES (427, 1, 'El Paso Times', 142, 'http://feeds.elpasotimes.com/mngi/rss/CustomRssServlet/525/200229.xml', '', 0, 0, '2016-01-11 20:01:03.876033', '47 Maximum (20) redirects followed', NULL, 'http://www.elpasotimes.com/sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:32.654628', '2016-01-11 20:01:01.830175', 0, false, 3, false, false, false, '', 0, '2015-12-17 20:16:55.926948', false);
INSERT INTO ttrss_feeds VALUES (1080, 1, 'Cleveland.com', 157, 'http://blog.cleveland.com/metro/atom.xml', '', 0, 0, '2016-01-11 20:01:10.590528', '', NULL, 'http://blog.cleveland.com/metro/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:54.659518', '2016-01-11 20:01:10.3845', 0, false, 1, false, false, false, '', 0, '2015-12-08 22:16:47.202178', false);
INSERT INTO ttrss_feeds VALUES (380, 1, 'LA Times', 55, 'http://www.latimes.com/entertainment/arts/rss2.0.xml', '', 0, 0, '2016-01-11 20:11:13.069963', '', NULL, 'http://www.latimes.com/entertainment/arts/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-01 22:13:29.204059', '2016-01-11 20:11:13.012476', 0, false, 13, false, false, false, '', 0, '2016-01-11 14:31:12.050054', false);
INSERT INTO ttrss_feeds VALUES (44, 1, 'Vimeo', 13, 'http://vimeo.com/CHANNELS/53200/VIDEOS/RSS', '', 0, 0, '2016-01-11 20:11:17.243627', '', NULL, 'https://vimeo.com/channels/53200/videos', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:50:31.907943', '2016-01-11 20:11:17.14987', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:52:39.812159', false);
INSERT INTO ttrss_feeds VALUES (1266, 1, 'Yahoo Sports', 30, 'https://sports.yahoo.com/nhl/rss.xml', '', 0, 0, '2016-01-11 20:11:20.108443', '', NULL, 'http://sports.yahoo.com/nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:19.911811', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:23.18064', false);
INSERT INTO ttrss_feeds VALUES (1274, 1, 'Sports Illustrated', 30, 'http://www.si.com/rss/si_hockey.rss', '', 0, 0, '2016-01-11 20:01:36.394579', '', NULL, 'http://www.si.com/si_nhl.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:36.307276', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:42:04.792425', false);
INSERT INTO ttrss_feeds VALUES (184, 1, 'CBS Sports', 32, 'http://www.cbssports.com/partners/feeds/rss/golf_news', '', 0, 0, '2016-01-11 20:06:39.490368', '', NULL, 'http://www.cbssports.com/golf', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:09:29.376522', '2016-01-11 20:06:39.444103', 0, false, 5, false, false, false, '', 0, '2016-01-11 00:46:33.628588', false);
INSERT INTO ttrss_feeds VALUES (603, 1, 'Adage', 43, 'http://adage.com/rss-channel.php?section_id=1', '', 0, 0, '2016-01-11 20:05:39.077203', '', NULL, 'http://adage.com/rss-channel.php?section_id=1', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:23:49.192656', '2016-01-11 20:05:38.673721', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:05:38.798126', false);
INSERT INTO ttrss_feeds VALUES (1065, 1, 'Miami Herald', 152, 'http://www.miamiherald.com/news/local/?widgetName=rssfeed&widgetContentId=712015&getXmlFeed=true', '', 0, 0, '2016-01-11 20:06:47.704087', '', NULL, 'http://www.miamiherald.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:12.833167', '2016-01-11 20:06:47.549543', 0, false, 4, false, false, false, '', 0, '2016-01-11 08:46:36.030218', false);
INSERT INTO ttrss_feeds VALUES (473, 1, 'DC Pro Sports Report', 114, 'http://dcprosportsreport.com/feed/', '', 0, 0, '2016-01-11 20:06:41.795258', '', NULL, 'http://dcprosportsreport.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:45.059173', '2016-01-11 20:06:40.33237', 0, false, 3, false, false, false, '', 0, '2016-01-11 02:07:04.112036', false);
INSERT INTO ttrss_feeds VALUES (313, 1, 'Fear The Fin', 30, 'http://www.fearthefin.com/rss/', '', 0, 0, '2016-01-11 20:00:25.883666', '', NULL, 'http://www.fearthefin.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:28:31.083939', '2016-01-11 20:00:25.486833', 0, false, 5, false, false, false, '', 0, '2016-01-11 20:00:25.859415', false);
INSERT INTO ttrss_feeds VALUES (372, 1, 'Aesthetica Magazine', 55, 'http://www.aestheticamagazine.com/feed/', '', 0, 0, '2016-01-11 20:11:12.307386', '', NULL, 'http://www.aestheticamagazine.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:45:43.438253', '2016-01-11 20:11:11.329789', 0, false, 0, false, false, false, '', 0, '2016-01-11 11:11:07.128527', false);
INSERT INTO ttrss_feeds VALUES (735, 1, 'The Independent', 40, 'http://www.independent.co.uk/life-style/health-and-wellbeing/rss', '', 0, 0, '2016-01-11 20:01:36.627275', 'LibXML error 39 at line 314 (column 53): AttValue: " or '' expected
', NULL, 'http://www.independent.co.uk/life-style/health-and-families/rss', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:55:56.016401', '2016-01-11 20:01:36.398001', 0, false, 11, false, false, false, '', 0, '2015-12-02 08:46:50.394693', false);
INSERT INTO ttrss_feeds VALUES (1168, 1, 'KOB 4', 198, 'http://www.kob.com/rssFeeds/rss500.xml', '', 0, 0, '2016-01-11 20:06:19.281457', '', NULL, 'http://www.kob.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:52.60502', '2016-01-11 20:06:18.923259', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:07:06.730387', false);
INSERT INTO ttrss_feeds VALUES (973, 1, 'ABC News', 70, 'http://abcnews.go.com/topics/urss?pageid=1085222', '', 0, 0, '2016-01-11 20:06:50.863488', '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:16.784982', '2016-01-11 20:06:49.90706', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:26:51.437855', false);
INSERT INTO ttrss_feeds VALUES (232, 1, 'Mayors Manor', 30, 'http://mayorsmanor.com/feed/', '', 0, 0, '2016-01-11 20:06:46.772329', '', NULL, 'http://mayorsmanor.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:45.331051', 0, false, 7, false, false, false, '', 0, '2016-01-11 20:06:46.742034', false);
INSERT INTO ttrss_feeds VALUES (1097, 1, 'Recordnet.com', 165, 'http://www.recordnet.com/news?template=rss&mime=xml', '', 0, 0, '2016-01-11 20:00:51.454178', '', NULL, 'http://www.recordnet.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:16.542607', '2016-01-11 20:00:51.167267', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:00:43.889753', false);
INSERT INTO ttrss_feeds VALUES (952, 1, 'Forbes', 26, 'http://www.forbes.com/finance/feed/', '', 0, 0, '2016-01-11 20:07:43.158111', '', NULL, 'http://www.forbes.com/finance/feed2/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:43.051866', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:47:15.280683', false);
INSERT INTO ttrss_feeds VALUES (293, 1, 'Dallas Business Journal', 134, 'http://feeds.bizjournals.com/bizj_dallas', '', 0, 0, '2016-01-11 20:01:33.327937', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:40.908529', '2016-01-11 20:01:33.13689', 0, false, 3, false, false, false, '', 0, '2016-01-11 19:01:33.55881', false);
INSERT INTO ttrss_feeds VALUES (132, 1, 'Science mag', 41, 'http://news.sciencemag.org/RSS/CURRENT.XML', '', 0, 0, '2016-01-11 20:11:15.0341', '', NULL, 'http://news.sciencemag.org/rss/current.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 22:46:36.044884', '2016-01-11 20:11:13.072526', 0, false, 17, false, false, false, '', 0, '2016-01-11 16:52:37.27109', false);
INSERT INTO ttrss_feeds VALUES (1261, 1, 'New York Times', 31, 'http://rss.nytimes.com/services/xml/rss/nyt/Tennis.xml', '', 0, 0, '2016-01-11 20:01:35.753428', '', NULL, 'http://www.nytimes.com/pages/sports/tennis/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:35.694637', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:01:35.967655', false);
INSERT INTO ttrss_feeds VALUES (1179, 1, 'Winston-Salem Journal', 204, 'http://www.journalnow.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=news/local/more_headlines*&f=rss', '', 0, 0, '2016-01-11 20:07:41.968036', '', NULL, 'http://www.journalnow.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news/local/more_headlines*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:33:14.866743', '2016-01-11 20:07:41.821065', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:08:31.029043', false);
INSERT INTO ttrss_feeds VALUES (1202, 1, 'The Orange County Register', 209, 'http://www.ocregister.com/common/rss/rss.php?catID=23541', '', 0, 0, '2016-01-11 20:06:26.241182', '', NULL, 'http://www.ocregister.com/common/archives/?catID=23541', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:14.903567', '2016-01-11 20:06:25.891632', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:46:31.842134', false);
INSERT INTO ttrss_feeds VALUES (956, 1, 'Discovery', 39, 'http://feeds.feedburner.com/DiscoverTechnology', '', 0, 0, '2016-01-11 20:07:47.930999', '', NULL, 'http://discovermagazine.com/rss/topic-feeds/technology', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:47.70367', 0, false, 3, false, false, false, '', 0, '2016-01-11 08:47:26.541235', false);
INSERT INTO ttrss_feeds VALUES (179, 1, 'TENNIS.com', 31, 'http://feeds.feedburner.com/tenniscom-news', '', 0, 0, '2016-01-11 20:01:36.302848', '', NULL, 'http://www.tennis.com/pro-game/list/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-18 18:38:30.829623', '2016-01-11 20:01:36.027323', 0, false, 9, false, false, false, '', 0, '2016-01-11 19:01:37.017754', false);
INSERT INTO ttrss_feeds VALUES (948, 1, 'Daily Mail', 55, 'http://www.dailymail.co.uk/news/arts/index.rss', '', 0, 0, '2016-01-11 20:11:09.666239', '', NULL, 'http://www.dailymail.co.uk/news/arts/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:09.30516', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:11:08.133631', false);
INSERT INTO ttrss_feeds VALUES (379, 1, 'Anthem Magazine', 55, 'http://anthemmagazine.com/feed/', '', 0, 0, '2016-01-11 20:00:11.486361', '', NULL, 'http://anthemmagazine.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:44:54.393649', '2016-01-11 20:00:10.770298', 0, false, 8, false, false, false, '', 0, '2016-01-11 08:20:08.306064', false);
INSERT INTO ttrss_feeds VALUES (712, 1, 'Reuters', 36, 'http://feeds.reuters.com/Reuters/worldNews', '', 0, 0, '2016-01-11 20:00:11.844229', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:59:29.069389', '2016-01-11 20:00:11.622817', 0, false, 11, false, false, false, '', 0, '2016-01-11 09:40:06.560696', false);
INSERT INTO ttrss_feeds VALUES (701, 1, 'NYT', 23, 'http://www.nytimes.com/services/xml/rss/nyt/BusinessSpecial.xml', '', 0, 0, '2016-01-11 20:11:18.687303', '', NULL, 'http://www.nytimes.com/pages/business/businessspecial/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:50:35.119728', '2016-01-11 20:11:18.320129', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:52:41.045992', false);
INSERT INTO ttrss_feeds VALUES (350, 1, 'SF Gate', 118, 'http://www.sfgate.com/rss/feed/Entertainment-530.php', '', 0, 0, '2016-01-11 20:01:12.499866', '', NULL, 'http://www.sfgate.com/rss/feed/Entertainment-530.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:24.980536', '2016-01-11 20:01:12.446415', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:01:02.969271', false);
INSERT INTO ttrss_feeds VALUES (189, 1, 'ESPN', 34, 'http://soccernet.espn.go.com/rss/news', '', 0, 0, '2016-01-11 20:05:09.640624', '', NULL, 'http://www.espnfc.com/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 18:07:49.858479', '2016-01-11 20:05:08.544379', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:05:08.845463', false);
INSERT INTO ttrss_feeds VALUES (622, 1, 'Sports News', NULL, 'http://www.kmbc.com/11665168?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:05:57.272441', '', NULL, 'http://www.kmbc.com/11665168', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:10:34.887421', '2016-01-11 20:05:57.202568', 0, false, 18, false, false, false, '', 0, '2016-01-11 16:06:42.589922', false);
INSERT INTO ttrss_feeds VALUES (435, 1, 'MCA Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=10004', '', 0, 0, '2016-01-11 20:05:15.659421', '', NULL, 'http://www.commercialappeal.com/ncaa-bracket-contest', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:44:16.189847', '2016-01-11 20:05:14.630592', 0, false, 29, false, false, false, '', 0, '2016-01-11 12:05:14.804689', false);
INSERT INTO ttrss_feeds VALUES (835, 1, 'NPR', 55, 'http://www.npr.org/rss/rss.php?id=1008', '', 0, 0, '2016-01-11 20:07:48.810712', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1008', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:31:38.488015', '2016-01-11 20:07:48.759108', 0, false, 3, false, false, false, '', 0, '2016-01-11 13:28:22.129424', false);
INSERT INTO ttrss_feeds VALUES (1213, 1, 'Daily Press', 211, 'http://dailypress.feedsportal.com/c/34257/f/656252/index.rss', '', 0, 0, '2016-01-11 20:06:16.242804', '', NULL, 'http://www.dailypress.com/news/?track=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:01.281909', '2016-01-11 20:06:16.16945', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:07:01.817466', false);
INSERT INTO ttrss_feeds VALUES (600, 1, 'Positive News', 48, 'http://positivenews.org.uk/feed/', '', 0, 0, '2016-01-11 20:11:33.700639', 'HTTP Code: 500', NULL, 'http://positivenews.org.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:40:00.213879', '2016-01-11 20:11:21.349877', 0, false, 3, false, false, false, '', 0, '2016-01-07 15:15:14.212477', false);
INSERT INTO ttrss_feeds VALUES (472, 1, 'Washington Post', 114, 'http://feeds.washingtonpost.com/rss/rss_dc-sports-bog', '', 0, 0, '2016-01-11 20:06:41.866389', '', NULL, 'http://www.washingtonpost.com/blogs/dc-sports-bog', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:46.927441', '2016-01-11 20:06:41.80103', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:46:47.989957', false);
INSERT INTO ttrss_feeds VALUES (1120, 1, 'KITV', 176, 'http://www.kitv.com/8906310?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:07:49.111564', 'HTTP Code: 404', NULL, 'http://www.kitv.com/8906310', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:03.015485', '2016-01-11 20:07:48.814635', 0, false, 3, false, false, false, '', 0, '2015-10-29 05:21:37.795557', false);
INSERT INTO ttrss_feeds VALUES (212, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:07:41.698757', '', NULL, 'http://www.nbcnewyork.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:34.828118', '2016-01-11 20:07:40.239696', 0, false, 10, false, false, false, '', 0, '2016-01-11 08:47:20.16089', false);
INSERT INTO ttrss_feeds VALUES (353, 1, 'BET.com', 16, 'http://feeds.bet.com/BETcom-Music', '', 0, 0, '2016-01-11 20:00:27.496785', '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 22:09:33.443174', '2016-01-11 20:00:26.790309', 0, false, 16, false, false, false, '', 0, '2016-01-11 16:40:23.508867', false);
INSERT INTO ttrss_feeds VALUES (604, 1, 'Mediaite', 37, 'http://www.mediaite.com/feed/', '', 0, 0, '2016-01-11 20:11:34.176885', '', NULL, 'http://www.mediaite.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-30 18:38:40.573998', '2016-01-11 20:11:33.705025', 0, false, 14, false, false, false, '', 0, '2016-01-11 16:52:45.182535', false);
INSERT INTO ttrss_feeds VALUES (217, 1, 'SB Nation New York', 66, 'http://newyork.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:07:41.817185', '', NULL, 'http://newyork.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:36.747849', '2016-01-11 20:07:41.702747', 0, false, 11, false, false, false, '', 0, '2016-01-11 12:07:53.30772', false);
INSERT INTO ttrss_feeds VALUES (134, 1, 'WashPost', 41, 'http://feeds.washingtonpost.com/rss/rss_speaking-of-science', '', 0, 0, '2016-01-11 20:10:59.083677', '', NULL, 'http://www.washingtonpost.com/news/speaking-of-science', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 22:46:25.012309', '2016-01-11 20:10:59.02703', 0, false, 27, false, false, false, '', 0, '2016-01-11 16:52:22.738627', false);
INSERT INTO ttrss_feeds VALUES (260, 1, 'NBC 10 Philadelphia', 100, 'http://www.nbcphiladelphia.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:00:34.607837', '', NULL, 'http://www.nbcphiladelphia.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:36:37.655378', '2016-01-11 20:00:31.620466', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:00:31.576484', false);
INSERT INTO ttrss_feeds VALUES (1108, 1, 'WWL', 164, 'http://rssfeeds.wwltv.com/wwl/local', '', 0, 0, '2016-01-11 20:00:50.764009', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:59.162904', '2016-01-11 20:00:50.016444', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:01:03.116104', false);
INSERT INTO ttrss_feeds VALUES (40, 1, 'GameSpot', 24, 'http://gamespot.com/rss/game_updates.php?', '', 0, 0, '2016-01-11 20:11:15.632885', '', NULL, 'http://www.gamespot.com/feeds/mashup/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:49:40.084218', '2016-01-11 20:11:15.039327', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:52:37.847084', false);
INSERT INTO ttrss_feeds VALUES (398, 1, 'Charlotte Business Journal', 174, 'http://feeds.bizjournals.com/bizj_charlotte?format=xml', '', 0, 0, '2016-01-11 20:01:09.384095', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:48.648957', '2016-01-11 20:01:09.183359', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:01:00.14823', false);
INSERT INTO ttrss_feeds VALUES (1027, 1, 'Atlanta Daily World', 122, 'http://atlantadailyworld.com/category/adw-news/feed/', '', 0, 0, '2016-01-11 20:01:10.379769', '', NULL, 'http://atlantadailyworld.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:13.582464', '2016-01-11 20:01:09.650433', 0, false, 3, false, false, false, '', 0, '2016-01-11 10:01:08.210523', false);
INSERT INTO ttrss_feeds VALUES (870, 1, 'New York Times', 43, 'http://rss.nytimes.com/services/xml/rss/nyt/MediaandAdvertising.xml', '', 0, 0, '2016-01-11 20:07:12.455568', '', NULL, 'http://www.nytimes.com/pages/business/media/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-19 02:12:28.742473', '2016-01-11 20:07:12.298287', 0, false, 4, false, false, false, '', 0, '2016-01-11 15:27:02.013117', false);
INSERT INTO ttrss_feeds VALUES (537, 1, 'Las Vegas Sun', 70, 'http://lasvegassun.com/feeds/headlines/blogs/talking-points/', '', 0, 0, '2016-01-11 20:01:18.895184', '', NULL, 'http://lasvegassun.com/news/blogs/talking-points/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:30.114346', '2016-01-11 20:01:18.324913', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:01:39.174178', false);
INSERT INTO ttrss_feeds VALUES (747, 1, 'BBC Sport', 33, 'http://feeds.bbci.co.uk/sport/0/winter-sports/rss.xml', '', 0, 0, '2016-01-11 20:15:32.663268', '', NULL, 'http://www.bbc.co.uk/sport/0/winter-sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 20:30:35.385044', '2016-01-11 20:15:32.403133', 0, false, 0, false, false, false, '', 0, '2016-01-10 11:01:20.234807', false);
INSERT INTO ttrss_feeds VALUES (991, 1, 'ITF Pro Circuit News', 31, 'http://www.itftennis.com/data/rss/itfprocircuitnews.xml', '', 0, 0, '2016-01-11 20:05:21.40883', '', NULL, 'http://www.itftennis.com/procircuit/news.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-08-10 22:52:07.664928', '2016-01-11 20:05:15.961609', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:25:14.721544', false);
INSERT INTO ttrss_feeds VALUES (967, 1, 'On the Runway', 18, 'http://runway.blogs.nytimes.com/feed/', '', 0, 0, '2016-01-11 20:00:30.584045', '', NULL, 'http://runway.blogs.nytimes.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:23.517577', '2016-01-11 20:00:29.943127', 0, false, 3, false, false, false, '', 0, '2016-01-11 20:00:30.542798', false);
INSERT INTO ttrss_feeds VALUES (1054, 1, 'NBC 10 Philadelphia', 136, 'http://www.nbcphiladelphia.com/news/local/?rss=y&embedThumb=y&summary=', '', 0, 0, '2016-01-11 20:05:05.393325', '', NULL, 'http://www.nbcphiladelphia.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:39.984583', '2016-01-11 20:05:01.564614', 0, false, 0, false, false, false, '', 0, '2016-01-11 20:05:05.284725', false);
INSERT INTO ttrss_feeds VALUES (574, 1, 'History.com', 215, 'http://www.history.com/this-day-in-history/rss', '', 0, 0, '2016-01-11 20:07:56.754378', '', NULL, 'http://css.history.com/this-day-in-history', '', NULL, false, '', false, true, false, false, false, false, '2015-10-19 20:22:04.951128', '2016-01-11 20:07:56.512282', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:48:32.744748', false);
INSERT INTO ttrss_feeds VALUES (454, 1, 'Seattle Sports Insider', 69, 'http://seattlesportsinsider.com/rss.xml', '', 0, 0, '2016-01-11 20:05:45.579274', '', NULL, 'http://seattlesportsinsider.com/frontpage/76', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:29:27.067023', '2016-01-11 20:05:45.025473', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:45:38.959542', false);
INSERT INTO ttrss_feeds VALUES (873, 1, 'The Independent', 36, 'http://rss.feedsportal.com/c/266/f/3503/index.rss', '', 0, 0, '2016-01-11 20:15:43.188486', '', NULL, 'http://www.independent.co.uk/news/world/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:42.864034', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:36:18.631923', false);
INSERT INTO ttrss_feeds VALUES (1077, 1, 'FOX 9 News', 161, 'http://www.myfoxtwincities.com/category/230083/news?clienttype=rss', '', 0, 0, '2016-01-11 20:01:21.769232', 'LibXML error 23 at line 1 (column 5748): EntityRef: expecting '';''
', NULL, 'http://www.myfoxtwincities.com/category/230083/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:40.70463', '2016-01-11 20:01:21.402088', 0, false, 2, false, false, false, '', 0, '2015-08-13 13:11:51.847502', false);
INSERT INTO ttrss_feeds VALUES (381, 1, 'Juxtapoz Magazine', 55, 'http://www.juxtapoz.com/current/feed/rss', '', 0, 0, '2016-01-11 20:11:13.009135', 'HTTP Code: 404', NULL, 'http://www.juxtapoz.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-01 22:13:51.183275', '2016-01-11 20:11:12.310611', 0, false, 17, false, false, false, '', 0, '2015-12-10 18:50:19.091289', false);
INSERT INTO ttrss_feeds VALUES (1211, 1, 'City of Virginia Beach', 211, 'http://www.vbgov.com/feed/rss/news', '', 0, 0, '2016-01-11 20:06:26.847024', '', NULL, 'http://www.vbgov.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:03.385176', '2016-01-11 20:06:26.244164', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:26:14.292765', false);
INSERT INTO ttrss_feeds VALUES (605, 1, 'NPR', 43, 'http://www.npr.org/rss/rss.php?id=1020', '', 0, 0, '2016-01-11 20:11:34.242949', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1020', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:24:10.034944', '2016-01-11 20:11:34.179632', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:11:29.066066', false);
INSERT INTO ttrss_feeds VALUES (814, 1, 'Bizjournals', 39, 'http://feeds.bizjournals.com/industry_7', '', 0, 0, '2016-01-11 20:00:35.025794', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:00:34.819653', 0, false, 8, false, false, false, '', 0, '2016-01-11 18:00:50.25871', false);
INSERT INTO ttrss_feeds VALUES (880, 1, 'Science : NPR', 40, 'http://www.npr.org/rss/rss.php?id=1007', '', 0, 0, '2016-01-11 20:15:44.033966', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1007', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:09.419487', '2016-01-11 20:15:43.911251', 0, false, 5, false, false, false, '', 0, '2016-01-11 16:16:21.31225', false);
INSERT INTO ttrss_feeds VALUES (653, 1, 'Deadline', 9, 'http://deadline.com/feed/', '', 0, 0, '2016-01-11 20:11:39.129438', '', NULL, 'http://deadline.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:41:08.679357', '2016-01-11 20:11:39.060671', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:34.864121', false);
INSERT INTO ttrss_feeds VALUES (1139, 1, 'KSDK', 182, 'http://rssfeeds.ksdk.com/ksdk-localnews&x=1', '', 0, 0, '2016-01-11 20:06:36.163678', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:36.11339', '2016-01-11 20:06:34.546265', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:46:40.394099', false);
INSERT INTO ttrss_feeds VALUES (1181, 1, 'The Herald-Sun', 145, 'http://www.heraldsun.com/atom', '', 0, 0, '2016-01-11 19:56:09.126294', 'HTTP Code: 404', NULL, 'http://www.heraldsun.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:58.886675', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2015-08-26 07:20:41.757776', false);
INSERT INTO ttrss_feeds VALUES (998, 1, 'New York Times', 32, 'http://www.nytimes.com/services/xml/rss/nyt/Golf.xml', '', 0, 0, '2016-01-11 20:01:36.024227', '', NULL, 'http://www.nytimes.com/pages/sports/golf/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-18 18:41:34.009559', '2016-01-11 20:01:35.756446', 0, false, 2, false, false, false, '', 0, '2016-01-11 19:01:36.240714', false);
INSERT INTO ttrss_feeds VALUES (630, 1, 'Q Magazine', 16, 'http://www.qthemusic.com/feed/', '', 0, 0, '2016-01-11 20:11:01.618405', '', NULL, 'http://www.qthemusic.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:41:56.658707', '2016-01-11 20:11:00.867369', 0, false, 12, false, false, false, '', 0, '2016-01-11 11:30:58.99648', false);
INSERT INTO ttrss_feeds VALUES (909, 1, 'CNET', 22, 'http://www.cnet.com/rss/car-tech/', '', 0, 0, '2016-01-11 20:11:07.327806', '', NULL, 'http://www.cnet.com/roadshow/#ftag=CADae39d16', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:32:02.430545', '2016-01-11 20:11:07.249273', 0, false, 1, false, false, false, '', 0, '2016-01-10 05:20:24.638628', false);
INSERT INTO ttrss_feeds VALUES (1055, 1, 'News 3 LV', 143, 'http://www.news3lv.com/rss/3269.rss', '', 0, 0, '2016-01-11 20:00:38.445338', '', NULL, 'http://www.mynews3.com/content/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:48.138835', '2016-01-11 20:00:38.345033', 0, false, 1, false, false, false, '', 0, '2016-01-11 20:00:38.387645', false);
INSERT INTO ttrss_feeds VALUES (801, 1, 'NCAA', 59, 'http://www.ncaa.com/news/skiing/nc/rss.xml', '', 0, 0, '2016-01-11 20:00:15.225172', '', NULL, 'http://www.ncaa.com/news/skiing/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:02:47.783583', '2016-01-11 20:00:15.043162', 0, false, 39, false, false, false, '', 0, '2016-01-11 18:00:21.294702', false);
INSERT INTO ttrss_feeds VALUES (1259, 1, 'New York Times', 30, 'http://rss.nytimes.com/services/xml/rss/nyt/Hockey.xml', '', 0, 0, '2016-01-11 20:11:20.887269', '', NULL, 'http://www.nytimes.com/pages/sports/hockey/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:20.823427', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:27.363657', false);
INSERT INTO ttrss_feeds VALUES (635, 1, 'Daily Express', 52, 'http://feeds.feedburner.com/daily-express-weird-news', '', 0, 0, '2016-01-11 20:05:54.145771', '', NULL, 'http://www.express.co.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:08:17.222761', '2016-01-11 20:05:53.968601', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:45:42.463817', false);
INSERT INTO ttrss_feeds VALUES (1090, 1, 'TwinCities.com', 161, 'http://feeds.twincities.com/mngi/rss/CustomRssServlet/569/200315.xml', '', 0, 0, '2016-01-11 20:00:45.548402', '', NULL, 'http://www.twincities.com/localnews/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:41.466552', '2016-01-11 20:00:45.417024', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:40:33.97506', false);
INSERT INTO ttrss_feeds VALUES (1200, 1, 'Long Beach Post', 209, 'http://www.lbpost.com/?format=feed', '', 0, 0, '2016-01-11 20:06:25.889014', '', NULL, 'http://lbpost.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:17.847865', '2016-01-11 20:06:19.285552', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:46:31.643575', false);
INSERT INTO ttrss_feeds VALUES (714, 1, 'Reuters', 7, 'http://feeds.reuters.com/Reuters/domesticNews', '', -1, 0, '2015-06-23 19:50:01.669539', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:46:10.503891', '2015-06-23 19:50:01.44842', 0, false, 5, false, false, false, '', 0, '2015-06-23 19:28:45.63833', false);
INSERT INTO ttrss_feeds VALUES (614, 1, 'News 10', 119, 'http://www.news10.net/rss/local.aspx', '', -1, 0, '2015-09-29 17:35:02.2533', '6 Couldn''t resolve host ''archive.abc10.com''', NULL, 'http://www.news10.net/news/default.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:41:40.369135', '2015-09-29 17:35:01.89038', 0, false, 2, false, false, false, '', 0, '2015-06-17 21:43:34.215055', false);
INSERT INTO ttrss_feeds VALUES (146, 1, 'Pew Research Center', 44, 'http://www.pewresearch.org/feed/', '', 0, 0, '2016-01-11 20:01:23.213168', '', NULL, 'http://www.pewresearch.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 21:06:51.283079', '2016-01-11 20:01:23.185576', 0, false, 3, false, false, false, '', 0, '2016-01-11 13:21:14.030867', false);
INSERT INTO ttrss_feeds VALUES (686, 1, 'CS Monitor', 7, 'http://rss.csmonitor.com/feeds/usa', '', -1, 0, '2015-06-17 23:12:40.023527', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:40:00.947827', '2015-06-17 23:12:39.979661', 0, false, 4, false, false, false, '', 0, '2015-06-17 23:12:34.902758', false);
INSERT INTO ttrss_feeds VALUES (1235, 1, 'ProBasketballTalk', 29, 'http://probasketballtalk.nbcsports.com/feed/', '', 0, 0, '2016-01-11 20:06:48.132139', '', NULL, 'http://nba.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:03:48.731806', '2016-01-11 20:06:47.925032', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:26:48.562184', false);
INSERT INTO ttrss_feeds VALUES (1155, 1, 'WTMJ', 191, 'http://www.620wtmj.com/news/local/index.rss', '', 0, 0, '2016-01-11 20:12:08.324424', '6 Couldn''t resolve host ''www.wtmj.comnews''', NULL, 'http://www.620wtmj.com/templates/Lib.Feed.xml?path=/news/local&format=RSS&limit=100', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:11.797071', '2016-01-11 20:12:08.06174', 0, false, 1, false, false, false, '', 0, '2015-09-23 07:53:06.865398', false);
INSERT INTO ttrss_feeds VALUES (312, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:01:30.623062', '', NULL, 'http://www.nbcbayarea.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:11.937629', '2016-01-11 20:01:29.750548', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:21:28.044787', false);
INSERT INTO ttrss_feeds VALUES (1222, 1, 'Love That Pet', 116, 'https://www.lovethatpet.com/feed/', '', 0, 0, '2016-01-11 20:06:56.454952', '', NULL, 'https://www.lovethatpet.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:52.582766', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:07:50.808992', false);
INSERT INTO ttrss_feeds VALUES (799, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:10:59.0241', '', NULL, 'http://www.ncaa.com/news/swimming-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:19.33227', '2016-01-11 20:10:58.866171', 0, false, 45, false, false, false, '', 0, '2016-01-11 16:52:22.692898', false);
INSERT INTO ttrss_feeds VALUES (700, 1, 'USA Track & Field', 59, 'http://www.usatf.org/News.aspx?rss=news', '', 0, 0, '2016-01-11 20:01:40.93373', '', NULL, 'http://www.usatf.org/News/2015.aspx?rss=news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:59:42.507266', '2016-01-11 20:01:36.672265', 0, false, 60, false, false, false, '', 0, '2016-01-11 09:01:35.307378', false);
INSERT INTO ttrss_feeds VALUES (521, 1, 'WAVE 3 Sports', NULL, 'http://www.wave3.com/category/1181/sports?clienttype=rss', '', 0, 0, '2016-01-11 19:56:08.603766', '', NULL, 'http://www.wave3.com/category/1181/louisville-sports', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:52:11.726264', '2016-01-11 20:15:01.959024', 0, false, 36, false, false, false, '', 0, '2016-01-11 18:16:11.902091', false);
INSERT INTO ttrss_feeds VALUES (895, 1, 'POPSUGAR', 19, 'http://www.popsugar.com/fitness/feed', '', 0, 0, '2016-01-11 20:15:27.41875', '', NULL, 'http://www.popsugar.com/fitness', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:31:55.893586', '2016-01-11 20:15:27.30153', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:55:21.563548', false);
INSERT INTO ttrss_feeds VALUES (683, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/57', '', 0, 0, '2016-01-11 20:15:34.728112', '', NULL, 'http://www.yardbarker.com/beach_volleyball', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 17:46:00.421985', '2016-01-11 20:15:34.48358', 0, false, 65, false, false, false, '', 0, '2016-01-11 17:36:15.61255', false);
INSERT INTO ttrss_feeds VALUES (762, 1, 'NCAA', NULL, 'http://www.ncaa.com/news/baseball/d3/rss.xml', '', 0, 0, '2016-01-11 20:15:35.034045', '', NULL, 'http://www.ncaa.com/news/baseball/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 22:18:18.782067', '2016-01-11 20:15:34.733771', 0, false, 10, false, false, false, '', 0, '2016-01-11 17:36:15.747616', false);
INSERT INTO ttrss_feeds VALUES (1073, 1, 'KTVU San Francisco', 153, 'http://www.ktvu.com/category/289821/east-bay-news?clienttype=rss', '', 0, 0, '2016-01-11 20:00:26.782451', 'HTTP Code: 404', NULL, 'http://wn.ktvu.com/category/289821/east-bay-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:28.811928', '2016-01-11 20:00:26.21799', 0, false, 1, false, false, false, '', 0, '2015-08-25 17:22:27.193131', false);
INSERT INTO ttrss_feeds VALUES (1107, 1, 'WDSU', 164, 'http://www.wdsu.com/9854386?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:00:50.013059', '', NULL, 'http://www.wdsu.com/9854386', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:56.388544', '2016-01-11 20:00:49.31954', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:01:02.221376', false);
INSERT INTO ttrss_feeds VALUES (215, 1, 'FOX New York', 66, 'http://www.myfoxny.com/category/230819/sports?clienttype=rss', '', 0, 0, '2016-01-11 20:07:40.23513', 'LibXML error 23 at line 713 (column 50): EntityRef: expecting '';''
', NULL, 'http://www.myfoxny.com/category/230819/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:34.39732', '2016-01-11 20:07:40.215931', 0, false, 9, false, false, false, '', 0, '2015-08-13 13:07:59.705738', false);
INSERT INTO ttrss_feeds VALUES (467, 1, 'ABC', 7, 'http://feeds.abcnews.com/abcnews/usheadlines', '', -1, 0, '2015-06-17 23:15:02.498218', '', NULL, 'http://www.wjla.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 23:12:42.595213', '2015-06-17 23:15:02.472118', 0, false, 0, false, false, false, '', 0, '2015-06-17 23:12:23.417579', false);
INSERT INTO ttrss_feeds VALUES (741, 1, 'Mountain Bike Action Magazine', 60, 'http://feeds.feedburner.com/MbaNewsFeed?format=xml', '', 0, 0, '2016-01-11 20:00:14.413891', '', NULL, 'http://mbaction.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:43:21.506518', '2016-01-11 20:00:14.138846', 0, false, 6, false, false, false, '', 0, '2016-01-11 13:20:09.356919', false);
INSERT INTO ttrss_feeds VALUES (1189, 1, 'Tucson News Now', 207, 'http://www.tucsonnewsnow.com/Global/category.asp?C=5168&clienttype=rss', '', 0, 0, '2016-01-11 20:11:38.279729', '', NULL, 'http://www.TucsonNewsNow.com/category/5168/tucson-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:43.615595', '2016-01-11 20:11:38.062009', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:52:51.161392', false);
INSERT INTO ttrss_feeds VALUES (501, 1, 'ABC Baltimore', 106, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=10008', '', 0, 0, '2016-01-11 20:01:18.965007', '', NULL, 'http://www.abc2news.com/comiccon', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:58.597382', '2016-01-11 20:01:18.899609', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:01:40.565105', false);
INSERT INTO ttrss_feeds VALUES (1152, 1, 'WISN', 191, 'http://www.wisn.com/9374280?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:12:08.056788', '', NULL, 'http://www.wisn.com/9374280', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:09.679502', '2016-01-11 20:11:45.504616', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:32:20.447432', false);
INSERT INTO ttrss_feeds VALUES (739, 1, 'The Independent', 55, 'http://www.independent.co.uk/arts-entertainment/theatre-dance/?service=rss', '', 0, 0, '2016-01-11 20:01:41.192759', 'LibXML error 68 at line 4 (column 35): xmlParseEntityRef: no name
', NULL, 'http://www.independent.co.uk/arts-entertainment/theatre-dance/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:41.039353', 0, false, 5, false, false, false, '', 0, '2015-12-01 17:57:02.325196', false);
INSERT INTO ttrss_feeds VALUES (987, 1, 'NFL.com', 27, 'http://search.nfl.com/urss?q=news', '', 0, 0, '2016-01-11 20:10:02.616885', '', NULL, 'http://search.nfl.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:42.248202', '2016-01-11 20:10:01.391524', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:50:02.654083', false);
INSERT INTO ttrss_feeds VALUES (1254, 1, 'HardballTalk', 28, 'http://hardballtalk.nbcsports.com/rss/entries.xml', '', 0, 0, '2016-01-11 20:05:05.748037', 'HTTP Code: 404', NULL, 'http://hardballtalk.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:56:22.357561', '2016-01-11 20:05:05.399903', 0, false, 0, false, false, false, '', 0, '2015-09-06 00:08:43.174427', false);
INSERT INTO ttrss_feeds VALUES (1149, 1, 'Channel 9 News', 188, 'http://www.news9.com/category/211667/news9com-news-rss?clienttype=rss', '', 0, 0, '2016-01-11 20:12:08.73664', '', NULL, 'http://www.news9.com/category/211667/news9com-news-rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:29.132591', '2016-01-11 20:12:08.654813', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:32:21.139572', false);
INSERT INTO ttrss_feeds VALUES (784, 1, 'Cycling News', 60, 'http://feeds.feedburner.com/cyclingnews/news?format=xml', '', 0, 0, '2016-01-11 20:01:43.241503', '', NULL, 'http://www.cyclingnews.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:18:35.293627', '2016-01-11 20:01:42.985037', 0, false, 3, false, false, false, '', 0, '2016-01-11 11:41:20.561861', false);
INSERT INTO ttrss_feeds VALUES (786, 1, 'Skate Daily', 60, 'http://skatedaily.net/feed/', '', 0, 0, '2016-01-11 20:05:06.054569', '', NULL, 'http://skatedaily.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:24:10.95149', '2016-01-11 20:05:05.753351', 0, false, 12, false, false, false, '', 0, '2016-01-07 12:45:32.967639', false);
INSERT INTO ttrss_feeds VALUES (748, 1, 'NCAA', 27, 'http://www.ncaa.com/news/football/fbs/rss.xml', '', 0, 0, '2016-01-11 20:10:02.8404', '', NULL, 'http://www.ncaa.com/news/football/fbs/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:43.938078', '2016-01-11 20:10:02.621286', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:50:02.865747', false);
INSERT INTO ttrss_feeds VALUES (49, 1, 'Ads of the World™', 14, 'http://adsoftheworld.com/NODE/FEED', '', 0, 0, '2016-01-11 19:55:57.268154', '', NULL, 'http://adsoftheworld.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:36:43.588639', false);
INSERT INTO ttrss_feeds VALUES (705, 1, 'SURFER Magazine', 60, 'http://surfermag.com/feed/', '', 0, 0, '2016-01-11 20:15:29.746102', '', NULL, 'http://www.surfermag.com', '', NULL, false, '', false, true, false, false, false, false, '2015-12-14 20:14:49.870923', '2016-01-11 20:15:29.195276', 0, false, 13, false, false, false, '', 0, '2016-01-11 08:15:32.449772', false);
INSERT INTO ttrss_feeds VALUES (345, 1, 'KTVU San Francisco', 118, 'http://www.ktvu.com/category/289753/san-francisco-penninsula?clienttype=rss', '', -1, 0, '2015-09-28 21:50:39.077756', 'HTTP Code: 404', NULL, 'http://wn.ktvu.com/category/289753/san-francisco-penninsula', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:39.328824', '2015-09-28 21:50:38.596132', 0, false, 8, false, false, false, '', 0, '2015-06-12 00:01:13.665935', false);
INSERT INTO ttrss_feeds VALUES (1092, 1, 'Arlington News', 163, 'http://www.star-telegram.com/news/local/community/arlington/?widgetName=rssfeed&widgetContentId=714290&getXmlFeed=true', '', 0, 0, '2016-01-11 20:00:41.498518', '', NULL, 'http://www.star-telegram.com/news/local/community/arlington/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:16.051155', '2016-01-11 20:00:41.140359', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:00:56.390636', false);
INSERT INTO ttrss_feeds VALUES (1174, 1, 'Dallas Morning News', 202, 'http://www.dallasnews.com/news/community-news/garland-mesquite/?rss', '', 0, 0, '2016-01-11 19:55:39.28809', '', NULL, 'http://www.dallasnews.com/news/community-news/garland-mesquite/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:08.983104', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:36:30.499658', false);
INSERT INTO ttrss_feeds VALUES (450, 1, 'My North West - Sports', NULL, 'http://www.mynorthwest.com/resources/podcasts/podcast.php?c=27', '', 0, 0, '2016-01-11 19:56:08.014246', '', NULL, 'http://kiroradio.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:34:58.02397', '2016-01-11 20:15:01.959024', 0, false, 27, false, false, false, '', 0, '2016-01-11 18:16:11.693612', false);
INSERT INTO ttrss_feeds VALUES (611, 1, 'The Sacramento Observer', 119, 'http://feeds.feedburner.com/Sacobserver?format=xml', '', -1, 0, '2015-09-29 17:40:01.528232', '', NULL, 'http://sacobserver.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:39:02.730276', '2015-09-29 17:40:01.495907', 0, false, 3, false, false, false, '', 0, '2015-09-29 17:38:58.243369', false);
INSERT INTO ttrss_feeds VALUES (951, 1, 'NYT', 25, 'http://rss.nytimes.com/services/xml/rss/nyt/Books.xml', '', 0, 0, '2016-01-11 20:07:42.665304', '', NULL, 'http://www.nytimes.com/pages/books/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:42.59957', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:47:14.832062', false);
INSERT INTO ttrss_feeds VALUES (347, 1, 'CBS 5', 118, 'http://cbs5.com/moviereviews/resources_rss.xml', '', -1, 0, '2015-09-28 21:50:23.090083', '', NULL, 'http://sanfrancisco.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:22.142971', '2015-09-28 21:50:22.150755', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:50:22.528969', false);
INSERT INTO ttrss_feeds VALUES (1089, 1, 'CBS Minnesota', 161, 'http://minnesota.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:00:45.685167', '', NULL, 'http://minnesota.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:44.197503', '2016-01-11 20:00:45.55234', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:40:34.068071', false);
INSERT INTO ttrss_feeds VALUES (64, 1, 'Electronics weekly', 17, 'http://www.electronicsweekly.com/news/feed/', '', 0, 0, '2016-01-11 20:01:53.246593', '', NULL, 'http://www.electronicsweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:48.705621', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:01:50.278284', false);
INSERT INTO ttrss_feeds VALUES (805, 1, 'AUTOSPORT.com', 59, 'http://www.autosport.com/rss/nascarnews.xml', '', 0, 0, '2016-01-11 20:05:06.944754', '', NULL, 'http://www.autosport.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 19:56:11.39309', '2016-01-11 20:05:06.544878', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:45:06.774043', false);
INSERT INTO ttrss_feeds VALUES (725, 1, 'Reuters', 41, 'http://feeds.reuters.com/reuters/environment', '', 0, 0, '2016-01-11 20:15:33.703908', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:26:46.767085', '2016-01-11 20:15:33.47146', 0, false, 10, false, false, false, '', 0, '2016-01-11 18:35:27.936852', false);
INSERT INTO ttrss_feeds VALUES (343, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124648', '', -1, 0, '2015-09-28 21:50:38.114098', '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:35.61568', '2015-09-28 21:50:35.621724', 0, false, 7, false, false, false, '', 0, '2015-09-28 21:50:38.097853', false);
INSERT INTO ttrss_feeds VALUES (8, 1, 'People', 8, 'http://feeds.people.com/people/headlines', '', 0, 0, '2016-01-11 20:01:53.711855', '', NULL, 'http://www.people.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:53.500696', 0, false, 9, false, false, false, '', 0, '2016-01-11 19:01:50.804573', false);
INSERT INTO ttrss_feeds VALUES (156, 1, 'CBS Sports', 27, 'http://www.cbssports.com/partners/feeds/rss/cfb_news', '', 0, 0, '2016-01-11 20:10:03.190623', '', NULL, 'http://www.cbssports.com/collegefootball', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:48.104404', '2016-01-11 20:10:03.05522', 0, false, 17, false, false, false, '', 0, '2016-01-11 15:30:03.435563', false);
INSERT INTO ttrss_feeds VALUES (556, 1, 'People', NULL, 'http://rss.people.com/web/people/rss/topheadlines/index.xml', '', 0, 0, '2016-01-11 20:01:53.89991', '', NULL, 'http://www.people.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:19.576201', '2016-01-11 20:01:53.714352', 0, false, 19, false, false, false, '', 0, '2016-01-11 19:01:51.136709', false);
INSERT INTO ttrss_feeds VALUES (159, 1, 'USA TODAY', 27, 'http://rssfeeds.usatoday.com/UsatodaycomNfl-TopStories', '', 0, 0, '2016-01-11 20:10:05.060814', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:04.603663', '2016-01-11 20:10:04.756842', 0, false, 24, false, false, false, '', 0, '2016-01-11 17:50:05.883192', false);
INSERT INTO ttrss_feeds VALUES (309, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, '2015-09-28 21:51:15.841718', '', NULL, 'http://www.nbcbayarea.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:14.74142', '2015-09-28 21:51:14.747009', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:51:15.650023', false);
INSERT INTO ttrss_feeds VALUES (732, 1, 'Forbes', 38, 'http://www.forbes.com/business/feed2/', '', 0, 0, '2016-01-11 20:11:00.824502', '', NULL, 'http://www.forbes.com/business/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-12 18:55:34.280145', '2016-01-11 20:11:00.707105', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:11:02.445162', false);
INSERT INTO ttrss_feeds VALUES (285, 1, 'UT San Diego', 125, 'http://www.signonsandiego.com/rss/headlines/', '', -1, 0, '2015-09-28 21:52:05.112802', '', NULL, 'http://www.sandiegouniontribune.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:03.912342', '2015-09-28 21:52:03.922399', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:52:04.995849', false);
INSERT INTO ttrss_feeds VALUES (286, 1, 'CBS 8', 125, 'http://www.cbs8.com/Global/category.asp?clienttype=rss_img&C=154671', '', -1, 0, '2015-09-28 21:52:06.453712', '', NULL, 'http://www.cbs8.com/category/154671/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:06.124051', '2015-09-28 21:52:06.132969', 0, false, 3, false, false, false, '', 0, '2015-09-28 21:52:06.368388', false);
INSERT INTO ttrss_feeds VALUES (253, 1, 'KPRC Radio', 67, 'http://www.kprcradio.com/rss/onair-36776/', '', -1, 0, '2015-06-12 00:21:28.491421', '', NULL, 'http://www.kprcradio.com/onair/houston-public-affairs-36776/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:47:51.241085', '2015-06-12 00:21:27.030563', 0, false, 0, false, false, false, '', 0, '2015-06-11 12:40:54.635187', false);
INSERT INTO ttrss_feeds VALUES (303, 1, 'KERA', 67, 'http://www.kera.org/feed/', '', -1, 0, '2015-06-22 19:36:43.92831', '', NULL, 'http://www.kera.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:36:43.447347', '2015-06-22 19:36:43.450394', 0, false, 2, false, false, false, '', 0, '2015-06-22 19:36:43.784197', false);
INSERT INTO ttrss_feeds VALUES (319, 1, 'KXAN', 67, 'http://kxan.com/feed/', '', -1, 0, '2015-06-12 00:21:30.832931', '', NULL, 'http://kxan.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 21:08:42.903047', '2015-06-12 00:21:30.541409', 0, false, 3, false, false, false, '', 0, '2015-06-12 00:01:14.0731', false);
INSERT INTO ttrss_feeds VALUES (719, 1, 'Reuters', 37, 'http://feeds.reuters.com/Reuters/PoliticsNews', '', 0, 0, '2016-01-11 19:56:30.252353', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:29:37.24483', '2016-01-11 20:15:01.959024', 0, false, 9, false, false, false, '', 0, '2016-01-11 18:16:33.430032', false);
INSERT INTO ttrss_feeds VALUES (1082, 1, 'WXII 12', 155, 'http://www.wxii12.com/9678710?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:00:40.186588', '', NULL, 'http://www.wxii12.com/9678710', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:04.215009', '2016-01-11 20:00:39.764309', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:00:54.663618', false);
INSERT INTO ttrss_feeds VALUES (532, 1, 'Las Vegas Review Journal', 70, 'http://www.lvrj.com/news.rss', '', -1, 0, '2015-09-28 21:43:13.101876', '', NULL, 'http://www.reviewjournal.com/rss.xml/1', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:11.961678', '2015-09-28 21:43:11.97197', 0, false, 5, false, false, false, '', 0, '2015-09-28 21:43:13.032413', false);
INSERT INTO ttrss_feeds VALUES (687, 1, 'CS Monitor', 38, 'http://rss.csmonitor.com/feeds/wam', '', 0, 0, '2016-01-11 19:55:37.576637', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 21:11:25.397405', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:15:55.717053', false);
INSERT INTO ttrss_feeds VALUES (340, 1, 'WOKV', 68, 'http://www.wokv.com/feeds/categories/news/', '', -1, 0, '2015-06-12 00:16:35.373783', '', NULL, 'http://www.wokv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 17:16:32.352646', '2015-06-12 00:16:34.830173', 0, false, 2, false, false, false, '', 0, '2015-06-12 00:16:35.13714', false);
INSERT INTO ttrss_feeds VALUES (336, 1, 'Jacksonville News', 68, 'http://www.news4jax.com/news/topstory.rss', '', -1, 0, '2015-06-12 00:20:20.864601', '', NULL, 'http://www.news4jax.com/4908618', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 18:45:06.133072', '2015-06-12 00:20:20.365561', 0, false, 3, false, false, false, '', 0, '2015-06-11 12:40:26.794289', false);
INSERT INTO ttrss_feeds VALUES (334, 1, 'The Florida Times-Union', 68, 'http://feeds.jacksonville.com/JacksonvillecomMostPopularStories?format=xml', '', -1, 0, '2015-06-12 00:21:18.83371', '', NULL, 'http://jacksonville.com/feeds/mostpopularstories', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:13:00.314587', '2015-06-12 00:21:12.28543', 0, false, 4, false, false, false, '', 0, '2015-06-12 00:21:18.803119', false);
INSERT INTO ttrss_feeds VALUES (528, 1, 'KATU', 72, 'http://www.katu.com/news/?fin=xml&type=default&c=y', '', -1, 0, '2015-09-28 21:43:43.785881', '', NULL, 'http://www.katu.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:43.901606', '2015-09-28 21:43:42.649642', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:43:43.663663', false);
INSERT INTO ttrss_feeds VALUES (16, 1, 'POP SUGAR', 8, 'http://feeds.feedburner.com/popsugar', '', 0, 0, '2016-01-11 20:01:54.815448', '', NULL, 'http://www.popsugar.com/celebrity', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:54.500731', 0, false, 11, false, false, false, '', 0, '2016-01-11 19:01:51.951644', false);
INSERT INTO ttrss_feeds VALUES (445, 1, 'The Seattle Times', 69, 'http://seattletimes.nwsource.com/rss/seattletimes.xml', '', -1, 0, '2015-06-12 00:21:09.19245', '', NULL, 'http://www.seattletimes.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-02 19:09:33.185688', '2015-06-12 00:20:55.265046', 0, false, 3, false, false, false, '', 0, '2015-06-11 14:20:40.228187', false);
INSERT INTO ttrss_feeds VALUES (1190, 1, 'Tucson City News', 207, 'http://www.tucsonaz.gov/news.xml', '', 0, 0, '2016-01-11 20:10:52.698401', '', NULL, 'https://www.tucsonaz.gov/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:49.737649', '2016-01-11 20:10:51.952053', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:30:58.89517', false);
INSERT INTO ttrss_feeds VALUES (268, 1, 'Arizona Capitol Times', 74, 'http://azcapitoltimes.com/feed/', '', -1, 0, '2015-06-12 00:20:47.023416', '', NULL, 'http://azcapitoltimes.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-13 18:25:41.133402', '2015-06-12 00:20:46.733657', 0, false, 0, false, false, false, '', 0, '2015-06-11 12:40:38.331645', false);
INSERT INTO ttrss_feeds VALUES (272, 1, 'ei8ht', 74, 'http://www.azpbs.org/horizon/rss/headlines/', '', -1, 0, '2015-06-12 00:21:27.027965', '', NULL, 'http://www.azpbs.org/horizon', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:46:19.020539', '2015-06-12 00:21:25.74076', 0, false, 1, false, false, false, '', 0, '2015-06-12 00:01:10.310644', false);
INSERT INTO ttrss_feeds VALUES (266, 1, 'The Arizona Republic', 74, 'http://www.azcentral.com/rss/feeds/republicfront.xml', '', -1, 0, '2015-07-21 20:49:57.978396', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 20:49:55.681111', '2015-07-21 20:49:55.686782', 0, false, 2, false, false, false, '', 0, '2015-07-21 20:49:57.88786', false);
INSERT INTO ttrss_feeds VALUES (730, 1, 'Pink Bike', 60, 'http://www.pinkbike.com/pinkbike_xml_feed.php', '', 0, 0, '2016-01-11 20:00:14.134798', '', NULL, 'http://www.pinkbike.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:43:36.844376', '2016-01-11 20:00:13.786012', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:00:14.490534', false);
INSERT INTO ttrss_feeds VALUES (245, 1, 'Houston Chronicle', 131, 'http://www.chron.com/rss/feed/News-270.php', '', -1, 0, '2015-09-28 21:53:15.182387', '', NULL, 'http://www.chron.com/rss/feed/News-270.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:15.007452', '2015-09-28 21:53:15.014699', 0, false, 6, false, false, false, '', 0, '2015-09-28 21:53:15.09177', false);
INSERT INTO ttrss_feeds VALUES (504, 1, 'NewsOK.com', 79, 'http://www.newsok.com/rss/news', '', -1, 0, '2015-07-21 18:34:31.197643', '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 18:34:29.53486', '2015-07-21 18:34:29.538616', 0, false, 0, false, false, false, '', 0, '2015-07-21 18:34:31.011973', false);
INSERT INTO ttrss_feeds VALUES (1203, 1, 'breakingnews.com', 209, 'http://www.breakingnews.com/feeds/rss/long-beach-ca-us', '', 0, 0, '2016-01-11 20:06:18.660088', '', NULL, 'http://www.breakingnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:21.266753', '2016-01-11 20:06:17.478354', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:07:05.16322', false);
INSERT INTO ttrss_feeds VALUES (912, 1, 'Nature.com', 41, 'http://feeds.nature.com/nature/rss/current', '', 0, 0, '2016-01-11 19:55:54.928888', '', NULL, 'http://www.nature.com/nature/current_issue/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:36:41.91076', false);
INSERT INTO ttrss_feeds VALUES (252, 1, 'CBS Houston', 131, 'http://houston.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:53:23.000017', '', NULL, 'http://houston.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:21.929782', '2015-09-28 21:53:21.937435', 0, false, 3, false, false, false, '', 0, '2015-09-28 21:53:22.476817', false);
INSERT INTO ttrss_feeds VALUES (249, 1, 'Houston Sports', 67, 'http://www.click2houston.com/mobile/4735518?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:07:51.982106', 'HTTP Code: 404', NULL, 'http://www.click2houston.com/mobile/4735518', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:31:34.101398', '2016-01-11 20:07:50.787183', 0, false, 1, false, false, false, '', 0, '2015-12-03 16:28:26.94577', false);
INSERT INTO ttrss_feeds VALUES (17, 1, 'Hello', 8, 'http://www.hellomagazine.com/rss.xml', '', 0, 0, '2016-01-11 20:01:55.041563', '', NULL, 'http://www.hellomagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:54.819015', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:01:52.400291', false);
INSERT INTO ttrss_feeds VALUES (300, 1, 'NBC 5', 173, 'http://www.nbcdfw.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, '2015-09-28 21:50:04.779126', '', NULL, 'http://www.nbcdfw.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:03.243386', '2015-09-28 21:50:03.249671', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:50:04.579647', false);
INSERT INTO ttrss_feeds VALUES (884, 1, 'U.S. News', 40, 'http://www.usnews.com/rss/health', '', 0, 0, '2016-01-11 20:15:44.859635', '', NULL, 'http://health.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:17:30.406551', '2016-01-11 20:15:44.566672', 0, false, 4, false, false, false, '', 0, '2016-01-11 15:36:18.0745', false);
INSERT INTO ttrss_feeds VALUES (1067, 1, 'Miami Beach 411', 152, 'http://www.miamibeach411.com/news/rss_2.0', '', 0, 0, '2016-01-11 20:00:07.334318', '', NULL, 'http://www.miamibeach411.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:22.557849', '2016-01-11 20:00:06.884547', 0, false, 2, false, false, false, '', 0, '2015-07-16 18:17:53.823601', false);
INSERT INTO ttrss_feeds VALUES (533, 1, 'Las Vegas Sun', 70, 'http://lasvegassun.com/feeds/headlines/news/', '', -1, 0, '2015-09-28 21:43:14.761221', '', NULL, 'http://lasvegassun.com/news/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:13.94966', '2015-09-28 21:43:13.955641', 0, false, 4, false, false, false, '', 0, '2015-09-28 21:43:14.666696', false);
INSERT INTO ttrss_feeds VALUES (51, 1, 'Best ads son TV', 14, 'http://www.bestadsontv.com/feed/', '', 0, 0, '2016-01-11 19:56:12.087902', '', NULL, 'http://www.bestadsontv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:56:20.841865', false);
INSERT INTO ttrss_feeds VALUES (383, 1, 'The Columbus Dispatch', 150, 'http://www.dispatch.com/content/syndication/news_local-state.xml', '', -1, 0, '2015-09-28 21:50:20.458136', '', NULL, 'http://www.dispatch.com/content/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:17.536402', '2015-09-28 21:50:17.542386', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:50:20.337562', false);
INSERT INTO ttrss_feeds VALUES (1063, 1, 'Fox 30', 148, 'http://www.fox30jax.com/list/rss/ap/florida/florida-news/aHG/', '', 0, 0, '2016-01-11 20:01:14.052859', '', NULL, 'http://www.fox30jax.com/list/ap/florida/florida-news/aHG/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:45.722391', '2016-01-11 20:01:13.591717', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:11.676083', false);
INSERT INTO ttrss_feeds VALUES (455, 1, 'Denver Post', 82, 'http://feeds.denverpost.com/dp-news-breaking-local', '', -1, 0, '2015-09-28 21:42:30.418303', '', NULL, 'http://www.denverpost.com/breakingnews/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:29.637952', '2015-09-28 21:42:29.648041', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:42:30.189575', false);
INSERT INTO ttrss_feeds VALUES (925, 1, 'The A.V. Club', 16, 'http://www.avclub.com/feed/rss/?tags=music', '', 0, 0, '2016-01-11 20:01:55.169665', '', NULL, 'http://www.avclub.com/search?tags=music', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:22:36.556594', '2016-01-11 20:01:55.045869', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:01:52.511032', false);
INSERT INTO ttrss_feeds VALUES (436, 1, 'WMC Action News 5', 123, 'http://www.wmcactionnews5.com/category/4728/news?clienttype=rss', '', -1, 0, '2015-09-28 21:49:05.93884', '', NULL, 'http://www.wmcactionnews5.com/category/4728/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:04.659143', '2015-09-28 21:49:04.666956', 0, false, 6, false, false, false, '', 0, '2015-09-28 21:49:04.87282', false);
INSERT INTO ttrss_feeds VALUES (491, 1, 'News Channel 5', 186, 'http://www.scrippsmedia.com/newschannel5/news/index.rss', '', -1, 0, '2015-09-28 21:39:41.579716', '', NULL, 'http://www.scrippsmedia.com/templates/Lib.Feed.xml?path=/newschannel5/news&format=RSSFull&limit=50', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:40.40112', '2015-09-28 21:39:40.408796', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:39:41.326368', false);
INSERT INTO ttrss_feeds VALUES (1263, 1, 'Yahoo Sports', 28, 'https://sports.yahoo.com/mlb/rss.xml', '', 0, 0, '2016-01-11 20:10:05.319044', '', NULL, 'http://sports.yahoo.com/mlb', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:49.328629', '2016-01-11 20:10:05.258534', 0, false, 0, false, false, false, '', 0, '2016-01-11 08:50:05.172997', false);
INSERT INTO ttrss_feeds VALUES (219, 1, 'L.A Times', 115, 'http://www.latimes.com/local/rss2.0.xml', '', 0, 0, '2016-01-11 20:15:24.965162', '', NULL, 'http://www.latimes.com/local/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:25.766175', '2016-01-11 20:15:24.773512', 0, false, 10, false, false, false, '', 0, '2016-01-11 17:36:03.554777', false);
INSERT INTO ttrss_feeds VALUES (258, 1, 'Fox Philadelphia', 100, 'http://www.myfoxphilly.com/category/233386/local-news?clienttype=rss', '', -1, 0, '2015-06-22 20:01:34.305606', '', NULL, 'http://www.myfoxphilly.com/category/233386/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 20:01:33.647784', '2015-06-22 20:01:33.660586', 0, false, 4, false, false, false, '', 0, '2015-06-22 19:59:31.860555', false);
INSERT INTO ttrss_feeds VALUES (259, 1, 'NBC 10 Philadelphia', 100, 'http://www.nbcphiladelphia.com/news/local/?rss=y&embedThumb=y&summary=y', '', -1, 0, '2015-06-12 00:21:36.067129', '', NULL, 'http://www.nbcphiladelphia.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:57:36.903186', '2015-06-12 00:21:35.470716', 0, false, 6, false, false, false, '', 0, '2015-06-11 12:41:00.692253', false);
INSERT INTO ttrss_feeds VALUES (456, 1, 'FOX 31', 82, 'http://www.kdvr.com/news/rss2.0.xml', '', -1, 0, '2015-09-28 21:42:27.986559', '', NULL, 'http://kdvr.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:27.214222', '2015-09-28 21:42:27.21981', 0, false, 4, false, false, false, '', 0, '2015-09-28 21:42:27.823469', false);
INSERT INTO ttrss_feeds VALUES (631, 1, 'Oddee.com', 52, 'http://www.oddee.com/rss.aspx', '', 0, 0, '2016-01-11 20:05:53.96476', '', NULL, 'http://www.oddee.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:29:49.814861', '2016-01-11 20:05:53.064636', 0, false, 6, false, false, false, '', 0, '2016-01-11 20:05:53.920462', false);
INSERT INTO ttrss_feeds VALUES (19, 1, 'L.A. Times', 9, 'http://feeds.latimes.com/LATIMES/ENTERTAINMENT/NEWS/MOVIES/', '', 0, 0, '2016-01-11 20:01:55.517139', '', NULL, 'http://www.latimes.com/entertainment/movies/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:55.172539', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:01:52.857221', false);
INSERT INTO ttrss_feeds VALUES (434, 1, 'Common Appeal', 123, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100107&categoryId=10001', '', -1, 0, '2015-09-28 21:48:56.785793', '', NULL, 'http://www.commercialappeal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:56.084479', '2015-09-28 21:48:56.09043', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:48:56.697763', false);
INSERT INTO ttrss_feeds VALUES (1241, 1, 'MLB.com', 28, 'http://mlb.mlb.com/partnerxml/gen/news/rss/mlb.xml', '', 0, 0, '2016-01-11 20:10:05.462293', '', NULL, 'http://mlb.mlb.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:50.229033', '2016-01-11 20:10:05.332152', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:10:11.408837', false);
INSERT INTO ttrss_feeds VALUES (867, 1, 'Nieman Lab', 43, 'http://www.niemanlab.org/reading/feed/', '', 0, 0, '2016-01-11 20:07:12.295115', '', NULL, 'http://www.niemanlab.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-19 02:12:09.589689', '2016-01-11 20:07:03.961057', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:27:01.90908', false);
INSERT INTO ttrss_feeds VALUES (269, 1, 'FOX 10 News Phoenix', 137, 'http://www.fox10phoenix.com/category/233272/local-news?clienttype=rss', '', -1, 0, '2015-09-28 21:52:31.028102', 'HTTP Code: 404', NULL, 'http://www.fox10phoenix.com/category/233272/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:30.666975', '2015-09-28 21:52:30.674066', 0, false, 3, false, false, false, '', 0, '2015-06-12 00:16:33.556923', false);
INSERT INTO ttrss_feeds VALUES (401, 1, 'FOX Charlotte', 174, 'http://www.wccbcharlotte.com/news/local/index.rss2', '', -1, 0, '2015-09-28 21:49:51.057952', '', NULL, 'http://www.wccbcharlotte.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:50.285699', '2015-09-28 21:49:50.291105', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:49:50.983734', false);
INSERT INTO ttrss_feeds VALUES (270, 1, 'KPHO Phoenix', 137, 'http://www.kpho.com/category/216452/kpho-newstream?clienttype=rss', '', -1, 0, '2015-09-28 21:52:28.664279', '', NULL, 'http://www.kpho.com/category/216452/cbs5-newstream', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:28.750361', '2015-09-28 21:52:27.99292', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:52:28.532642', false);
INSERT INTO ttrss_feeds VALUES (971, 1, 'Colorado Springs Gazette RSS - news >> local', 129, 'http://gazette.com/rss/news/local', '', 0, 0, '2016-01-11 20:07:21.615307', '', NULL, 'http://gazette.com/rss/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:20.080087', '2016-01-11 20:07:21.008', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:07:59.695784', false);
INSERT INTO ttrss_feeds VALUES (397, 1, 'The Charlotte Observer', 98, 'http://www.charlotteobserver.com/local/index.rss', '', -1, 0, '2015-06-12 00:20:39.043319', '', NULL, 'http://www.charlotteobserver.com/141/index.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 19:21:00.705444', '2015-06-12 00:20:39.02656', 0, false, 4, false, false, false, '', 0, '2015-06-10 19:00:58.2569', false);
INSERT INTO ttrss_feeds VALUES (831, 1, 'The Guardian', 59, 'http://www.theguardian.com/sport/boxing/rss', '', 0, 0, '2016-01-11 20:05:13.136606', '', NULL, 'http://www.theguardian.com/sport/boxing', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:12.757994', 0, false, 52, false, false, false, '', 0, '2016-01-11 12:05:10.863013', false);
INSERT INTO ttrss_feeds VALUES (416, 1, 'WXYZ', 93, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10001', '', -1, 0, '2015-06-22 19:23:16.254526', '', NULL, 'http://www.wxyz.com/working', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:06:24.437024', '2015-06-22 19:23:16.010869', 0, false, 0, false, false, false, '', 0, '2015-06-22 19:23:16.126999', false);
INSERT INTO ttrss_feeds VALUES (1034, 1, 'MyFox Atlanta', 122, 'http://www.myfoxatlanta.com/category/233685/local-news?clienttype=rss', '', 0, 0, '2016-01-11 20:01:20.836304', 'LibXML error 23 at line 1 (column 5818): EntityRef: expecting '';''
', NULL, 'http://www.myfoxatlanta.com/category/233685/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:09.499253', '2016-01-11 20:01:20.414815', 0, false, 2, false, false, false, '', 0, '2015-08-21 05:21:41.686956', false);
INSERT INTO ttrss_feeds VALUES (914, 1, 'NBC Miami', 152, 'http://www.nbcmiami.com/news/top-stories/?rss=y', '', 0, 0, '2016-01-11 20:06:34.540916', '', NULL, 'http://www.nbcmiami.com/news/top-stories', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:19.936009', '2016-01-11 20:06:28.538965', 0, false, 3, false, false, false, '', 0, '2016-01-11 08:46:23.349325', false);
INSERT INTO ttrss_feeds VALUES (422, 1, 'CBS Detroit', 93, 'http://detroit.cbslocal.com/feed/', '', -1, 0, '2015-06-12 00:20:52.020412', '', NULL, 'http://detroit.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 20:23:28.672238', '2015-06-12 00:20:50.761775', 0, false, 1, false, false, false, '', 0, '2015-06-11 14:41:30.21785', false);
INSERT INTO ttrss_feeds VALUES (1017, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/insects_and_butterflies', '', 0, 0, '2016-01-11 19:56:23.806792', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/insects_and_butterflies/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:15:04.734192', '2016-01-11 20:15:01.959024', 0, false, 36, false, false, false, '', 0, '2016-01-11 18:56:27.588667', false);
INSERT INTO ttrss_feeds VALUES (307, 1, 'Mercury News Sports', NULL, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200223.xml', '', 0, 0, '2016-01-11 20:07:21.803084', '', NULL, 'http://www.mercurynews.com/sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:47:52.461649', '2016-01-11 20:07:21.619834', 0, false, 49, false, false, false, '', 0, '2016-01-11 16:47:59.810653', false);
INSERT INTO ttrss_feeds VALUES (21, 1, 'Box Office', 9, 'http://feeds.feedburner.com/THR/BOXOFFICE', '', 0, 0, '2016-01-11 20:01:55.956822', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/3495/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:55.747678', 0, false, 5, false, false, false, '', 0, '2016-01-11 10:02:01.153845', false);
INSERT INTO ttrss_feeds VALUES (498, 1, 'CBS Baltimore', 106, 'http://baltimore.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:42:03.898897', '', NULL, 'http://baltimore.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:03.484487', '2015-09-28 21:42:03.490538', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:42:03.525096', false);
INSERT INTO ttrss_feeds VALUES (481, 1, 'CBS Boston', 110, 'http://boston.cbslocal.com/feed/', '', -1, 0, '2015-06-17 21:40:25.994975', '', NULL, 'http://boston.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 21:40:25.788279', '2015-06-17 21:40:25.793727', 0, false, 3, false, false, false, '', 0, '2015-06-17 21:37:07.375875', false);
INSERT INTO ttrss_feeds VALUES (451, 1, 'KOMO News', 130, 'http://www.komonews.com/news/local/index.rss', '', -1, 0, '2015-09-28 21:41:35.109502', '', NULL, 'http://www.komonews.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:34.091191', '2015-09-28 21:41:34.100223', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:41:34.94154', false);
INSERT INTO ttrss_feeds VALUES (1164, 1, 'WBRZ', 195, 'http://www.wbrz.com/feeds/rssfeed.cfm?category=281&cat_name=Community', '', 0, 0, '2016-01-11 20:15:47.96775', '', NULL, 'http://www.wbrz.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:53.823422', '2016-01-11 20:15:47.843926', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:36:22.748838', false);
INSERT INTO ttrss_feeds VALUES (1191, 1, '1030 KVOI AM', 207, 'http://www.kvoi.com/feed/', '', 0, 0, '2016-01-11 20:10:58.129465', '', NULL, 'http://www.kvoi.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:57.055763', '2016-01-11 20:10:52.70131', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:30:58.497435', false);
INSERT INTO ttrss_feeds VALUES (22, 1, 'Awards', 9, 'http://feeds.feedburner.com/THR/AWARDS', '', 0, 0, '2016-01-11 20:01:56.166568', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/7739/all/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:55.959749', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:41:46.08134', false);
INSERT INTO ttrss_feeds VALUES (41, 1, 'GamesRadar', 24, 'http://www.gamesradar.com/all-platforms/news/rss', '', 0, 0, '2016-01-11 20:11:15.889607', '', NULL, 'http://www.gamesradar.com/all-platforms/news/rss/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:49:43.918219', '2016-01-11 20:11:15.635872', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:52:38.119282', false);
INSERT INTO ttrss_feeds VALUES (24, 1, 'The Guardian', 9, 'http://www.theguardian.com/film/rss', '', 0, 0, '2016-01-11 20:01:57.047238', '', NULL, 'http://www.theguardian.com/us/film', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:56.172476', 0, false, 6, false, false, false, '', 0, '2016-01-11 19:01:53.712897', false);
INSERT INTO ttrss_feeds VALUES (1275, 1, 'Sports Illustrated', 34, 'http://www.si.com/rss/si_soccer.rss', '', 0, 0, '2016-01-11 20:01:57.72261', '', NULL, 'http://www.si.com/si_soccer.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:57.632308', 0, false, 0, false, false, false, '', 0, '2016-01-11 11:41:28.98975', false);
INSERT INTO ttrss_feeds VALUES (297, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/233338/local-news?clienttype=rss', '', -1, 0, '2015-06-12 00:16:32.349127', '', NULL, 'http://www.fox4news.com/category/233338/local-news', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-06-12 00:16:32.001252', 0, false, 44, false, false, false, '', 0, '2015-06-12 00:16:32.054705', false);
INSERT INTO ttrss_feeds VALUES (560, 1, 'Live Science', 41, 'http://www.livescience.com/home/feed/site.xml', '', 0, 0, '2016-01-11 19:55:35.343567', '', NULL, 'http://www.livescience.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:56:12.398194', '2016-01-11 20:15:01.959024', 0, false, 15, false, false, false, '', 0, '2016-01-11 19:35:55.212377', false);
INSERT INTO ttrss_feeds VALUES (180, 1, 'BBC Sport', 31, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/tennis/rss.xml', '', 0, 0, '2016-01-11 20:05:21.816432', '', NULL, 'http://www.bbc.co.uk/sport/0/tennis/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 19:03:36.733459', '2016-01-11 20:05:21.411652', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:25:15.098406', false);
INSERT INTO ttrss_feeds VALUES (682, 1, 'CS Monitor', 41, 'http://rss.csmonitor.com/feeds/science', '', 0, 0, '2016-01-11 20:06:27.380578', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:46:22.201428', '2016-01-11 20:06:27.155763', 0, false, 9, false, false, false, '', 0, '2016-01-11 08:06:17.570286', false);
INSERT INTO ttrss_feeds VALUES (1157, 1, 'Dallas Morning News', 192, 'http://www.dallasnews.com/news/community-news/irving/?rss', '', 0, 0, '2016-01-11 19:55:35.638485', '', NULL, 'http://www.dallasnews.com/news/community-news/irving/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:01.386257', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:36:23.053757', false);
INSERT INTO ttrss_feeds VALUES (1094, 1, 'Local 12', 162, 'http://www.local12.com/news/features/top-stories//rss.xml', '', 0, 0, '2016-01-11 20:00:45.052411', 'HTTP Code: 404', NULL, 'http://www.local12.com/news/features/top-stories/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:35.627352', '2016-01-11 20:00:44.892671', 0, false, 2, false, false, false, '', 0, '2015-11-24 20:30:11.595386', false);
INSERT INTO ttrss_feeds VALUES (1001, 1, 'Astrology and Horoscope 2015 by www.findyourfate.com', NULL, 'http://www.findyourfate.com/rss/horoscope-astrology.asp', '', 0, 0, '2016-01-11 20:05:28.130958', '', NULL, 'http://www.findyourfate.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 22:25:34.365681', '2016-01-11 20:05:27.483396', 0, false, 2, false, false, false, '', 0, '2016-01-11 20:05:28.091492', false);
INSERT INTO ttrss_feeds VALUES (1278, 1, 'The Onion', 11, 'http://www.theonion.com/feeds/rss', '', 0, 0, '2016-01-11 20:06:43.062097', '', NULL, 'http://www.theonion.com/search', '', NULL, false, '', false, true, false, false, false, false, '2015-09-01 18:33:54.350691', '2016-01-11 20:06:42.993813', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:07:38.257492', false);
INSERT INTO ttrss_feeds VALUES (1015, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/frogs_and_reptiles', '', 0, 0, '2016-01-11 20:05:28.592502', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/frogs_and_reptiles/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:15:09.287275', '2016-01-11 20:05:28.13556', 0, false, 37, false, false, false, '', 0, '2016-01-11 16:05:30.1709', false);
INSERT INTO ttrss_feeds VALUES (1219, 1, 'Puppy In Training', 116, 'http://feeds2.feedburner.com/puppyintraining', '', 0, 0, '2016-01-11 19:55:50.09335', '', NULL, 'http://puppyintraining.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 17:36:39.171698', false);
INSERT INTO ttrss_feeds VALUES (1058, 1, 'Star Local', 147, 'http://starlocalmedia.com/search/?q=&t=article&l=10&d=&d1=&d2=&s=start_time&sd=desc&c[]=live_and_local,live_and_local/*&f=rss', '', 0, 0, '2016-01-11 20:00:07.707361', '', NULL, 'http://starlocalmedia.com/search/?q=&t=article&l=10&d=&d1=&d2=&s=start_time&sd=desc&c[]=live_and_local,live_and_local/*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:18.252737', '2016-01-11 20:00:07.339142', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:40:05.10564', false);
INSERT INTO ttrss_feeds VALUES (1183, 1, 'Fox 34', 205, 'http://www.fox34.com/category/301948/local-news', '', 0, 0, '2016-01-11 20:01:58.008228', 'LibXML error 23 at line 46 (column 69): EntityRef: expecting '';''
', NULL, 'http://www.myfoxlubbock.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 21:23:05.159291', '2016-01-11 20:01:57.725308', 0, false, 0, false, false, false, '', 0, '2015-08-31 22:31:45.516237', false);
INSERT INTO ttrss_feeds VALUES (838, 1, 'NPR', 38, 'http://www.npr.org/rss/rss.php?id=1006', '', 0, 0, '2016-01-11 20:05:28.97922', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1006', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:06:41.772792', '2016-01-11 20:05:28.933529', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:45:21.296376', false);
INSERT INTO ttrss_feeds VALUES (33, 1, 'Rolling Stone', 16, 'http://www.rollingstone.com/music.rss', '', 0, 0, '2016-01-11 20:01:59.231515', '', NULL, 'http://www.rollingstone.com/music', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:19:42.600245', '2016-01-11 20:01:58.956027', 0, false, 21, false, false, false, '', 0, '2016-01-11 09:01:54.696812', false);
INSERT INTO ttrss_feeds VALUES (162, 1, 'CBS Sports', 28, 'http://www.cbssports.com/partners/feeds/rss/mlb_news', '', 0, 0, '2016-01-11 20:10:05.699817', '', NULL, 'http://www.cbssports.com/mlb', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:55.451625', '2016-01-11 20:10:05.647009', 0, false, 9, false, false, false, '', 0, '2016-01-11 03:50:23.833895', false);
INSERT INTO ttrss_feeds VALUES (1253, 1, 'CBS Sports', 29, 'http://www.cbssports.com/partners/feeds/rss/cb_news', '', 0, 0, '2016-01-11 20:10:06.555358', '', NULL, 'http://www.cbssports.com/collegebasketball', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:25.026868', '2016-01-11 20:10:06.437396', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:50:07.295662', false);
INSERT INTO ttrss_feeds VALUES (1195, 1, 'The Collegian', 208, 'http://collegian.csufresno.edu/feed/', '', 0, 0, '2016-01-11 20:06:16.093792', '', NULL, 'http://collegian.csufresno.edu', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:26.615036', '2016-01-11 20:05:58.650975', 0, false, 4, false, false, false, '', 0, '2016-01-11 19:06:25.580946', false);
INSERT INTO ttrss_feeds VALUES (94, 1, 'FOX News', 7, 'http://feeds.foxnews.com/foxnews/national', '', 0, 0, '2016-01-11 20:11:19.649219', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:27:33.525699', '2016-01-11 20:11:19.404287', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:11:22.050542', false);
INSERT INTO ttrss_feeds VALUES (910, 1, 'New Electronics News', 17, 'http://www.newelectronics.co.uk/rss/news/4#', '', 0, 0, '2016-01-11 19:55:51.865175', '', NULL, 'http://www.newelectronics.co.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:30:36.715756', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:36:02.902584', false);
INSERT INTO ttrss_feeds VALUES (505, 1, 'News OK', 79, 'http://newsok.com/rss/sports', '', 0, 0, '2016-01-11 20:05:38.668135', '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 18:54:57.897245', '2016-01-11 20:05:36.622693', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:45:25.645539', false);
INSERT INTO ttrss_feeds VALUES (1136, 1, 'Detroit | WXYZ', 175, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=30466', '', 0, 0, '2016-01-11 20:01:09.17738', '', NULL, 'http://www.wxyz.com/detroit', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:41.440787', '2016-01-11 20:01:09.038002', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:00:59.95422', false);
INSERT INTO ttrss_feeds VALUES (994, 1, 'The Hockey News', 30, 'http://thehockeynews.com.feedsportal.com/c/34166/f/621201/index.rss', '', 0, 0, '2016-01-11 19:56:08.694859', '', NULL, 'http://www.thehockeynews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 19:10:49.769881', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:16:12.191132', false);
INSERT INTO ttrss_feeds VALUES (486, 1, 'Boston Sports Media Watch', 110, 'http://feeds2.feedburner.com/BostonSportsMediaWatch', '', 0, 0, '2016-01-11 20:05:39.699539', '', NULL, 'http://www.bostonsportsmedia.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:06:36.696543', '2016-01-11 20:05:39.365261', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:05:39.54914', false);
INSERT INTO ttrss_feeds VALUES (52, 1, 'AdWeek', 14, 'http://feeds.adweek.com/adweek/adfreak?format=xml', '', 0, 0, '2016-01-11 19:56:12.46211', '', NULL, 'http://www.adweek.com/adfreak', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:36:16.13499', false);
INSERT INTO ttrss_feeds VALUES (1024, 1, 'Hampton Roads', 121, 'http://hamptonroads.com/taxterm/3', '', 0, 0, '2016-01-11 19:56:37.455407', '', NULL, 'http://hamptonroads.com/taxonomy/term/3', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:03.57417', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:16:53.506527', false);
INSERT INTO ttrss_feeds VALUES (1066, 1, 'Local 10', 152, 'http://www.local10.com/Local-10-Mobile/3972514?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:00:06.87852', 'HTTP Code: 404', NULL, 'http://www.local10.com/Local-10-Mobile/3972514', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:25.110647', '2016-01-11 20:00:06.148216', 0, false, 1, false, false, false, '', 0, '2015-12-08 09:35:58.393566', false);
INSERT INTO ttrss_feeds VALUES (65, 1, 'NPR', 25, 'http://www.npr.org/rss/rss.php?id=1032', '', 0, 0, '2016-01-11 20:01:59.378086', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1032', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:58:28.360269', '2016-01-11 20:01:59.235651', 0, false, 7, false, false, false, '', 0, '2016-01-11 13:41:42.676617', false);
INSERT INTO ttrss_feeds VALUES (713, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/55', '', 0, 0, '2016-01-11 20:05:44.356793', '', NULL, 'http://www.yardbarker.com/hunting_fishing', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:36:15.127202', '2016-01-11 20:05:44.174611', 0, false, 66, false, false, false, '', 0, '2016-01-11 15:05:36.685626', false);
INSERT INTO ttrss_feeds VALUES (164, 1, 'USA TODAY', 28, 'http://rssfeeds.usatoday.com/UsatodaycomMlb-TopStories', '', 0, 0, '2016-01-11 20:10:06.26964', '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:57.556967', '2016-01-11 20:10:05.704014', 0, false, 10, false, false, false, '', 0, '2016-01-11 17:10:12.494363', false);
INSERT INTO ttrss_feeds VALUES (68, 1, 'Publishers Weekly', 25, 'http://www.publishersweekly.com/pw/feeds/recent/index.xml', '', 0, 0, '2016-01-11 20:01:59.866472', '', NULL, 'http://www.publishersweekly.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:58:30.821171', '2016-01-11 20:01:59.571518', 0, false, 9, false, false, false, '', 0, '2016-01-11 12:21:43.624155', false);
INSERT INTO ttrss_feeds VALUES (211, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/news/politics/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:07:37.851712', '', NULL, 'http://www.nbcnewyork.com/news/politics', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:19.997889', '2016-01-11 20:07:28.536718', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:08:25.281082', false);
INSERT INTO ttrss_feeds VALUES (70, 1, 'FN Dish', 20, 'http://blog.foodnetwork.com/fn-dish/feed/', '', 0, 0, '2016-01-11 20:02:00.832627', '', NULL, 'http://blog.foodnetwork.com/fn-dish', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:00.132598', 0, false, 11, false, false, false, '', 0, '2016-01-11 17:03:09.07701', false);
INSERT INTO ttrss_feeds VALUES (348, 1, 'KRON 4', 125, 'http://kron4.com/feed/', '', -1, 0, '2015-09-28 21:51:59.778216', '', NULL, 'http://kron4.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:00.161685', '2015-09-28 21:51:59.318213', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:51:59.516027', false);
INSERT INTO ttrss_feeds VALUES (71, 1, 'Bon Appétit', 20, 'http://www.bonappetit.com/rss2', '', 0, 0, '2016-01-11 20:02:00.938088', '', NULL, 'http://www.bonappetit.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:00.837416', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:01:41.391871', false);
INSERT INTO ttrss_feeds VALUES (174, 1, 'USA TODAY', 30, 'http://rssfeeds.usatoday.com/UsatodaycomNhl-TopStories', '', 0, 0, '2016-01-11 20:11:09.001761', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:23:13.495558', '2016-01-11 20:11:08.75107', 0, false, 10, false, false, false, '', 0, '2016-01-11 17:11:07.389383', false);
INSERT INTO ttrss_feeds VALUES (612, 1, 'CBS Sacramento', 119, 'http://sacramento.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:44:08.148112', '', NULL, 'http://sacramento.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:33:30.883538', '2015-09-28 21:44:07.933969', 0, false, 0, false, false, false, '', 0, '2015-09-28 17:25:01.994908', false);
INSERT INTO ttrss_feeds VALUES (91, 1, 'CNN Money', 26, 'http://rss.cnn.com/RSS/MONEY_PF.RSS', '', 0, 0, '2016-01-11 20:02:02.39923', 'HTTP Code: 404', NULL, 'http://money.cnn.com/pf/?section=money_pf', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:25:51.612928', '2016-01-11 20:02:02.334597', 0, false, 5, false, false, false, '', 0, '2015-08-10 12:36:46.709516', false);
INSERT INTO ttrss_feeds VALUES (802, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:01:43.469882', '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:22.97186', '2016-01-11 20:01:43.3045', 0, false, 42, false, false, false, '', 0, '2016-01-11 09:21:30.361022', false);
INSERT INTO ttrss_feeds VALUES (613, 1, 'FOX 40', 119, 'http://feeds.feedburner.com/Ktxl-Fox40NewsAtTen', '', -1, 0, '2015-09-28 21:44:06.448024', '', NULL, 'http://fox40.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:33:33.951749', '2015-09-28 21:44:06.307546', 0, false, 1, false, false, false, '', 0, '2015-09-28 17:30:20.918118', false);
INSERT INTO ttrss_feeds VALUES (341, 1, 'Pro Sports Blogging', NULL, 'http://www.prosportsblogging.com/feed/', '', 0, 0, '2016-01-11 20:05:49.757305', '', NULL, 'http://www.prosportsblogging.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:46:22.341009', '2016-01-11 20:05:49.187363', 0, false, 47, false, false, false, '', 0, '2016-01-08 02:46:23.509098', false);
INSERT INTO ttrss_feeds VALUES (619, 1, 'KCTV Kansas City', 83, 'http://www.kctv5.com/category/210833/app-news?clienttype=rss', '', -1, 0, '2015-09-28 21:42:41.916813', '', NULL, 'http://www.kctv5.com/category/210833/app-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:41.540425', '2015-09-28 21:42:41.546074', 0, false, 6, false, false, false, '', 0, '2015-09-28 21:42:41.842203', false);
INSERT INTO ttrss_feeds VALUES (280, 1, 'Fox San Antonio', 138, 'http://www.foxsanantonio.com/news/features/top-stories/rss.xml', '', -1, 0, '2015-09-28 21:52:16.265863', '', NULL, 'http://www.foxsanantonio.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:15.946493', '2015-09-28 21:52:15.956089', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:52:16.122238', false);
INSERT INTO ttrss_feeds VALUES (255, 1, 'Philly.com', 136, 'http://www.philly.com/philly_news.rss', '', -1, 0, '2015-09-28 21:52:42.77254', '', NULL, 'http://www.philly.com/r?19=960&32=3796&7=195202&40=http%3A%2F%2Fwww.philly.com%2Fphilly%2Fnews%2F', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:42.19935', '2015-09-28 21:52:42.205255', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:52:42.556926', false);
INSERT INTO ttrss_feeds VALUES (37, 1, 'British Comedy Guide', 11, 'http://feeds.feedburner.com/BRITISHCOMEDYNEWS', '', 0, 0, '2016-01-11 20:02:01.365849', '', NULL, 'http://www.comedy.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:01.127353', 0, false, 4, false, false, false, '', 0, '2016-01-11 13:41:44.903107', false);
INSERT INTO ttrss_feeds VALUES (289, 1, 'KPBS News', 125, 'http://feeds.kpbs.org/kpbs/local?format=xml', '', -1, 0, '2015-09-28 21:52:11.708527', '', NULL, 'http://www.kpbs.org/news/local/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:09.123063', '2015-09-28 21:52:09.130142', 0, false, 4, false, false, false, '', 0, '2015-09-28 21:52:11.613038', false);
INSERT INTO ttrss_feeds VALUES (221, 1, 'LA Daily News', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000019&mime=xml', '', 0, 0, '2016-01-11 20:15:24.769971', '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:24.964113', '2016-01-11 20:15:24.714956', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:36:03.504344', false);
INSERT INTO ttrss_feeds VALUES (1258, 1, 'New York Times', 29, 'http://rss.nytimes.com/services/xml/rss/nyt/ProBasketball.xml', '', 0, 0, '2016-01-11 20:10:07.128761', '', NULL, 'http://www.nytimes.com/pages/sports/basketball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:31.923997', '2016-01-11 20:10:07.014415', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:07.356452', false);
INSERT INTO ttrss_feeds VALUES (101, 1, 'BBC', 36, 'http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk', '', 0, 0, '2016-01-11 20:15:43.906309', '', NULL, 'http://www.bbc.co.uk/news/world/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 18:37:44.788215', '2016-01-11 20:15:43.617019', 0, false, 13, false, false, false, '', 0, '2016-01-11 16:55:33.40514', false);
INSERT INTO ttrss_feeds VALUES (402, 1, 'WCNC', 98, 'http://www.wcnc.com/news/local/index.rss2', '', -1, 0, '2015-06-22 19:30:02.743327', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:28:48.710624', '2015-06-22 19:30:02.173292', 0, false, 1, false, false, false, '', 0, '2015-06-22 19:28:12.009849', false);
INSERT INTO ttrss_feeds VALUES (400, 1, 'WSOC', 174, 'http://www.wsoctv.com/list/rss/news/local/latest-news/mxc/', '', -1, 0, '2015-09-28 21:49:46.891673', '', NULL, 'http://www.wsoctv.com/list/news/latest-news/mxc/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:46.639351', '2015-09-28 21:49:46.645467', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:49:46.815636', false);
INSERT INTO ttrss_feeds VALUES (636, 1, 'Unexplained Mysteries', 52, 'http://www.unexplained-mysteries.com/news/umnews.xml', '', 0, 0, '2016-01-11 20:05:53.060675', '', NULL, 'http://www.unexplained-mysteries.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:08:08.05922', '2016-01-11 20:05:52.937166', 0, false, 9, false, false, false, '', 0, '2016-01-11 12:25:41.866097', false);
INSERT INTO ttrss_feeds VALUES (1264, 1, 'Yahoo Sports', 29, 'https://sports.yahoo.com/nba/rss.xml', '', 0, 0, '2016-01-11 20:10:07.587037', '', NULL, 'http://sports.yahoo.com/nba', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:37.198672', '2016-01-11 20:10:07.468198', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:10:12.177152', false);
INSERT INTO ttrss_feeds VALUES (38, 1, 'College Humor', 11, 'http://www.collegehumor.com/ORIGINALS/RSS', '', 0, 0, '2016-01-11 20:02:01.670121', '', NULL, 'http://www.collegehumor.comhttp://www.collegehumor.com/originals', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:01.370208', 0, false, 3, false, false, false, '', 0, '2016-01-11 19:02:04.100509', false);
INSERT INTO ttrss_feeds VALUES (752, 1, 'Off Road Xtreme', 60, 'http://www.offroadxtreme.com/rss/', '', 0, 0, '2016-01-11 20:05:56.656576', '', NULL, 'http://www.offroadxtreme.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:55.113752', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:06:41.438852', false);
INSERT INTO ttrss_feeds VALUES (1212, 1, 'WAVY-TV', 211, 'http://wavy.com/feed/', '', 0, 0, '2016-01-11 20:06:17.366075', '', NULL, 'http://wavy.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:36:57.411995', '2016-01-11 20:06:17.230702', 0, false, 3, false, false, false, '', 0, '2016-01-11 13:46:15.023165', false);
INSERT INTO ttrss_feeds VALUES (39, 1, 'IGN', 24, 'http://feeds.ign.com/IGN/ALL', '', 0, 0, '2016-01-11 20:02:02.329286', '', NULL, 'http://www.ign.com/articles', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:49:46.212837', '2016-01-11 20:02:01.683939', 0, false, 10, false, false, false, '', 0, '2016-01-11 19:22:58.493984', false);
INSERT INTO ttrss_feeds VALUES (129, 1, 'NASA', 41, 'http://www.nasa.gov/rss/universe.rss', '', 0, 0, '2016-01-11 20:10:58.438532', '', NULL, 'http://www.nasa.gov/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:58.132364', 0, false, 28, false, false, false, '', 0, '2016-01-11 16:52:22.015724', false);
INSERT INTO ttrss_feeds VALUES (271, 1, 'KPHO Phoenix', 137, 'http://www.kpho.com/category/13566/national-sports?clienttype=rss', '', 0, 0, '2016-01-11 20:02:03.403394', '', NULL, 'http://www.cbs5az.com/category/13566/national-sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:33.439534', '2016-01-11 20:02:02.686065', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:21:58.488917', false);
INSERT INTO ttrss_feeds VALUES (468, 1, 'CBS DC', 114, 'http://washington.cbslocal.com/feed/', '', -1, 0, '2015-09-28 21:41:48.246733', '', NULL, 'http://washington.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:49.129446', '2015-09-28 21:41:47.733728', 0, false, 2, false, false, false, '', 0, '2015-09-28 21:41:47.783547', false);
INSERT INTO ttrss_feeds VALUES (480, 1, 'WHDH-TV', 110, 'http://www.whdh.com/?clienttype=rss', '', -1, 0, '2015-06-22 19:35:50.606226', '', NULL, 'http://www.whdh.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:35:50.437411', '2015-06-22 19:35:50.441099', 0, false, 2, false, false, false, '', 0, '2015-06-22 19:29:49.029684', false);
INSERT INTO ttrss_feeds VALUES (916, 1, 'NBC 4i', 150, 'http://nbc4i.com/feed/', '', 0, 0, '2016-01-11 20:01:12.318941', '', NULL, 'http://nbc4i.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:16.061536', '2016-01-11 20:01:12.077747', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:01:02.825282', false);
INSERT INTO ttrss_feeds VALUES (464, 1, 'WashTimes', 114, 'http://washingtontimes.com/rss/headlines/news/local/', '', -1, 0, '2015-09-28 21:41:52.696413', '', NULL, 'http://www.washingtontimes.com/news/local/?utm_medium=RSS', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:49.749409', '2015-09-28 21:41:49.755752', 0, false, 1, false, false, false, '', 0, '2015-09-28 21:41:52.576309', false);
INSERT INTO ttrss_feeds VALUES (254, 1, 'SB Nation Houston', 131, 'http://houston.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:52.896307', '', NULL, 'http://houston.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:53.022708', '2016-01-11 20:05:52.738208', 0, false, 4, false, false, false, '', 0, '2016-01-11 12:45:38.42216', false);
INSERT INTO ttrss_feeds VALUES (320, 1, 'The Austin Chronicle', 144, 'http://www.austinchronicle.com/gyrobase/rss/sports.xml', '', 0, 0, '2016-01-11 20:01:25.265391', '', NULL, 'http://www.austinchronicle.com/rss/sports.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:56.814586', '2016-01-11 20:01:25.007837', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:21:21.626364', false);
INSERT INTO ttrss_feeds VALUES (846, 1, 'Teen Vogue Fashion', 18, 'http://www.teenvogue.com/services/rss/feeds/fashion.xml', '', 0, 0, '2016-01-11 20:02:03.701674', '', NULL, 'http://www.teenvogue.com/fashion', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:19.075898', '2016-01-11 20:02:03.407414', 0, false, 7, false, false, false, '', 0, '2016-01-11 19:02:05.594328', false);
INSERT INTO ttrss_feeds VALUES (95, 1, 'WashPost', 7, 'http://feeds.washingtonpost.com/rss/national', '', 0, 0, '2016-01-11 20:01:26.566584', '', NULL, 'http://www.washingtonpost.com/pb/national/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-30 21:45:49.50782', '2016-01-11 20:01:26.425791', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:41:18.85639', false);
INSERT INTO ttrss_feeds VALUES (598, 1, 'Ripley''s Nature & Places', 53, 'http://www.ripleys.com/bions/planet/feed/', '', 0, 0, '2016-01-11 20:15:31.795051', '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-19 20:19:05.265118', '2016-01-11 20:15:30.85936', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:55:29.462104', false);
INSERT INTO ttrss_feeds VALUES (524, 1, 'Louisville Sports Live', 95, 'http://louisvillesportslive.net/feed/', '', 0, 0, '2016-01-11 20:06:45.154054', '', NULL, 'http://louisvillesportslive.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 20:55:57.44312', '2016-01-11 20:06:43.594638', 0, false, 3, false, false, false, '', 0, '2016-01-11 09:46:31.149253', false);
INSERT INTO ttrss_feeds VALUES (695, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/24', '', 0, 0, '2016-01-11 20:00:10.764251', '', NULL, 'http://www.yardbarker.com/track_and_field', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:35:30.158965', '2016-01-11 20:00:08.151196', 0, false, 67, false, false, false, '', 0, '2016-01-11 08:20:07.852444', false);
INSERT INTO ttrss_feeds VALUES (12, 1, 'Perez Hilton', 8, 'http://i.perezhilton.com/?feed=rss2', '', 0, 0, '2016-01-11 20:01:54.430303', '', NULL, 'http://perezhilton.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:54.140547', 0, false, 10, false, false, false, '', 0, '2016-01-11 16:02:58.439858', false);
INSERT INTO ttrss_feeds VALUES (850, 1, 'Media Matters', 37, 'http://feeds.mediamatters.org/mediamatters/latest?format=xml', '', 0, 0, '2016-01-11 20:02:04.079009', '', NULL, 'http://mediamatters.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:53:49.573516', '2016-01-11 20:02:03.706146', 0, false, 5, false, false, false, '', 0, '2016-01-11 12:01:43.737509', false);
INSERT INTO ttrss_feeds VALUES (26, 1, 'Screen Rant', 9, 'http://screenrant.com/feed/', '', 0, 0, '2016-01-11 20:01:57.629138', '', NULL, 'http://screenrant.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:35:58.863636', '2016-01-11 20:01:57.269124', 0, false, 10, false, false, false, '', 0, '2016-01-11 14:41:42.812455', false);
INSERT INTO ttrss_feeds VALUES (901, 1, 'IGN Articles', 24, 'http://feeds.ign.com/ign/articles', '', 0, 0, '2016-01-11 20:07:01.310233', '', NULL, 'http://www.ign.com/articles', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:01.03592', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:47:26.918344', false);
INSERT INTO ttrss_feeds VALUES (1265, 1, 'Yahoo Sports', 29, 'https://sports.yahoo.com/ncaab/rss.xml', '', 0, 0, '2016-01-11 20:10:07.763526', '', NULL, 'http://sports.yahoo.com/ncaab', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:37.462051', '2016-01-11 20:10:07.591969', 0, false, 0, false, false, false, '', 0, '2016-01-11 08:10:10.734539', false);
INSERT INTO ttrss_feeds VALUES (1119, 1, 'Hawaii News Now', 176, 'http://www.hawaiinewsnow.com/Global/category.asp?C=3497&clienttype=rss', '', 0, 0, '2016-01-11 20:10:08.449376', '', NULL, 'http://www.hawaiinewsnow.com/category/3497/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:00.808742', '2016-01-11 20:10:08.003566', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:30:09.002411', false);
INSERT INTO ttrss_feeds VALUES (1022, 1, 'Huffington Post – Pets', 116, 'http://www.huffingtonpost.com/news/pet/feed//', '', 0, 0, '2016-01-11 20:07:24.765388', '', NULL, 'http://www.huffingtonpost.com/tag/pet', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:34:30.948739', '2016-01-11 20:07:24.699975', 0, false, 9, false, false, false, '', 0, '2016-01-11 16:48:02.344985', false);
INSERT INTO ttrss_feeds VALUES (469, 1, 'WTOP', 114, 'http://wtop.com/region/local/feed/', '', -1, 0, '2015-09-28 21:41:54.287249', '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:52.886942', '2015-09-28 21:41:52.892518', 0, false, 0, false, false, false, '', 0, '2015-09-28 21:41:54.152241', false);
INSERT INTO ttrss_feeds VALUES (1122, 1, 'MyFox Austin', 144, 'http://www.myfoxaustin.com/category/234942/local?clienttype=rss', '', 0, 0, '2016-01-11 20:10:11.019285', 'LibXML error 23 at line 1 (column 5590): EntityRef: expecting '';''
', NULL, 'http://www.myfoxaustin.com/category/234942/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:03.209064', '2016-01-11 20:10:10.409872', 0, false, 0, false, false, false, '', 0, '2015-08-20 16:32:28.845468', false);
INSERT INTO ttrss_feeds VALUES (1226, 1, 'ScienceDaily', 40, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_health?format=xml', '', 0, 0, '2016-01-11 19:55:52.507275', '', NULL, 'http://www.sciencedaily.com/news/top/health/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:36:03.600974', false);
INSERT INTO ttrss_feeds VALUES (696, 1, 'U.S. News', 40, 'http://www.usnews.com/rss/health?int=a7fe09', '', 0, 0, '2016-01-11 19:55:53.894022', '', NULL, 'http://health.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:23.564597', '2016-01-11 20:15:01.959024', 0, false, 12, false, false, false, '', 0, '2016-01-11 16:16:47.445192', false);
INSERT INTO ttrss_feeds VALUES (643, 1, 'TheMovieBox.Net', 58, 'http://feeds.feedburner.com/themovieboxnet/', '', 0, 0, '2016-01-11 20:05:57.514996', '', NULL, 'http://themoviebox.net/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:57.27526', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:26:30.523529', false);
INSERT INTO ttrss_feeds VALUES (848, 1, 'B of F', 18, 'http://www.businessoffashion.com/syndication/feed', '', 0, 0, '2016-01-11 20:00:22.575332', '', NULL, 'http://www.businessoffashion.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:18.087421', '2016-01-11 20:00:22.046533', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:00:24.305083', false);
INSERT INTO ttrss_feeds VALUES (93, 1, 'U.S. News', 26, 'http://www.usnews.com/rss/money?int=a48e09', '', 0, 0, '2016-01-11 19:56:17.205801', '', NULL, 'http://money.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:09:58.479671', '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:16:19.705531', false);
INSERT INTO ttrss_feeds VALUES (1004, 1, 'Milwaukee County News', NULL, 'http://www.wisn.com/10149330?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 19:56:19.353324', '', NULL, 'http://www.wisn.com/10149330', '', NULL, false, '', false, true, false, false, false, false, '2015-07-13 19:40:19.869547', '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 18:56:26.345534', false);
INSERT INTO ttrss_feeds VALUES (1196, 1, 'North Fresno News', 208, 'http://northfresno.kmph.com/feed/rss.xml', '', 0, 0, '2016-01-11 20:06:17.226024', '', NULL, 'http://northfresno.kmph.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:28.099201', '2016-01-11 20:06:16.498368', 0, false, 3, false, false, false, '', 0, '2016-01-11 13:46:14.842326', false);
INSERT INTO ttrss_feeds VALUES (1081, 1, 'News Net 5', 157, 'http://scrippsobfeeds2.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10003&categoryId=20000', '', 0, 0, '2016-01-11 20:00:38.805962', '', NULL, 'http://www.newsnet5.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:56.634323', '2016-01-11 20:00:38.664431', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:40:28.922204', false);
INSERT INTO ttrss_feeds VALUES (352, 1, 'The San Francisco Examiner', 118, 'http://www.sfexaminer.com/sanfrancisco/Rss.xml?section=2124643', '', 0, 0, '2016-01-11 20:01:13.119479', '', NULL, 'http://archives.sfexaminer.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:26.65536', '2016-01-11 20:01:12.503945', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:01:03.732344', false);
INSERT INTO ttrss_feeds VALUES (584, 1, 'LA Times', 20, 'http://www.latimes.com/food/rss2.0.xml', '', 0, 0, '2016-01-11 20:07:03.656163', '', NULL, 'http://www.latimes.com/food/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 21:13:25.920466', '2016-01-11 20:07:03.046872', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:47:09.45932', false);
INSERT INTO ttrss_feeds VALUES (225, 1, 'CBS Los Angeles', 115, 'http://losangeles.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:15:25.124291', '', NULL, 'http://losangeles.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:26.191362', '2016-01-11 20:15:24.970425', 0, false, 9, false, false, false, '', 0, '2016-01-11 17:36:03.635443', false);
INSERT INTO ttrss_feeds VALUES (1249, 1, 'USA TODAY', 29, 'http://rssfeeds.usatoday.com/UsatodaycomCollegeMensBasketball-TopStories', '', 0, 0, '2016-01-11 20:10:07.463112', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:35.403269', '2016-01-11 20:10:07.157499', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:08.17729', false);
INSERT INTO ttrss_feeds VALUES (203, 1, 'New York Post Sports', 66, 'http://nypost.com/sports/feed/', '', 0, 0, '2016-01-11 20:07:54.323155', '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:41.748747', '2016-01-11 20:07:54.276154', 0, false, 13, false, false, false, '', 0, '2016-01-11 17:29:11.193058', false);
INSERT INTO ttrss_feeds VALUES (240, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:10:14.570471', '', NULL, 'http://www.nbcchicago.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:20.294855', '2016-01-11 20:10:11.025091', 0, false, 6, false, false, false, '', 0, '2016-01-11 18:30:14.490289', false);
INSERT INTO ttrss_feeds VALUES (264, 1, 'CSN Philly Sports', 100, 'http://www.csnphilly.com/rss-top-headlines.xml', '', 0, 0, '2016-01-11 20:10:17.913255', '', NULL, 'http://www.csnphilly.com/rss-top-headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:53:51.361262', '2016-01-11 20:10:17.586937', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:30:18.730238', false);
INSERT INTO ttrss_feeds VALUES (626, 1, 'Sunny Skyz', 48, 'http://feeds.feedburner.com/SunnySkyz', '', 0, 0, '2016-01-11 20:10:18.119478', '', NULL, 'http://www.sunnyskyz.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 21:11:04.726122', '2016-01-11 20:10:17.918151', 0, false, 4, false, false, false, '', 0, '2016-01-11 14:10:20.232814', false);
INSERT INTO ttrss_feeds VALUES (800, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d2/rss.xml', '', 0, 0, '2016-01-11 20:00:15.040439', '', NULL, 'http://www.ncaa.com/news/swimming-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:20.82106', '2016-01-11 20:00:14.987768', 0, false, 44, false, false, false, '', 0, '2016-01-11 18:00:21.237351', false);
INSERT INTO ttrss_feeds VALUES (466, 1, 'Roll Call', 37, 'http://www.rollcall.com/politics/archives/?zkDo=showRSS', '', -1, 0, '2015-06-22 19:20:35.05572', '', NULL, 'http://www.rollcall.com/rss/all_news.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 19:20:34.43225', '2015-06-22 19:20:34.436081', 0, false, 7, false, false, false, '', 0, '2015-06-22 19:20:34.684948', false);
INSERT INTO ttrss_feeds VALUES (79, 1, 'Motor Trend', 22, 'http://www.motortrend.com/widgetrss/motortrend-roadtests.xml', '', 0, 0, '2016-01-11 19:56:14.634892', '', NULL, 'http://www.motortrend.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:33:07.073114', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:17:09.720727', false);
INSERT INTO ttrss_feeds VALUES (975, 1, 'Quartz', 38, 'http://qz.com/feed/', '', 0, 0, '2016-01-11 20:02:07.953548', '', NULL, 'http://qz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:07.859084', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:41:59.548724', false);
INSERT INTO ttrss_feeds VALUES (1053, 1, 'Review Journal', 143, 'http://www.reviewjournal.com/news/feed', '', 0, 0, '2016-01-11 20:00:38.661504', '', NULL, 'http://www.reviewjournal.com/rss.xml/1', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:49.655399', '2016-01-11 20:00:38.448553', 0, false, 2, false, false, false, '', 0, '2016-01-11 20:00:38.615481', false);
INSERT INTO ttrss_feeds VALUES (104, 1, 'CNN', 37, 'http://rss.cnn.com/rss/cnn_allpolitics.rss', '', 0, 0, '2016-01-11 20:02:05.820406', '', NULL, 'http://www.cnn.com/POLITICS/index.html?eref=rss_politics', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:44:04.650634', '2016-01-11 20:02:05.685021', 0, false, 12, false, false, false, '', 0, '2016-01-11 11:41:35.701492', false);
INSERT INTO ttrss_feeds VALUES (929, 1, 'EDM.com', 16, 'http://feeds.edm.com/edm/news', '', 0, 0, '2016-01-11 20:11:09.302494', '', NULL, 'http://edm.com/articles?type=1', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 20:05:02.497668', '2016-01-11 20:11:09.006345', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:31:07.060991', false);
INSERT INTO ttrss_feeds VALUES (702, 1, 'Yardbarker', 60, 'http://www.yardbarker.com/rss/sport/35', '', 0, 0, '2016-01-11 20:02:06.123688', '', NULL, 'http://www.yardbarker.com/surfing', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:21:17.92313', '2016-01-11 20:02:05.82324', 0, false, 21, false, false, false, '', 0, '2016-01-11 11:41:36.041754', false);
INSERT INTO ttrss_feeds VALUES (1201, 1, 'Grunion Gazette - Long Beach', 209, 'http://www.gazettes.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=longbeach*&f=rss', '', 0, 0, '2016-01-11 20:06:18.920437', '', NULL, 'http://www.gazettes.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c[]=longbeach*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:20.03127', '2016-01-11 20:06:18.662639', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:07:06.409116', false);
INSERT INTO ttrss_feeds VALUES (708, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/22', '', 0, 0, '2016-01-11 20:02:07.293396', '', NULL, 'http://www.yardbarker.com/horse_racing', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 17:46:02.659867', '2016-01-11 20:02:06.996435', 0, false, 64, false, false, false, '', 0, '2016-01-11 09:02:05.409114', false);
INSERT INTO ttrss_feeds VALUES (193, 1, 'Major League Soccer', 34, 'http://www.mlssoccer.com/rss/en.xml', '', 0, 0, '2016-01-11 20:15:03.655028', '', NULL, 'http://www.mlssoccer.com/rss-feed', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:06:48.755761', '2016-01-11 20:15:03.279044', 0, false, 4, false, false, false, '', 0, '2016-01-11 09:55:04.666888', false);
INSERT INTO ttrss_feeds VALUES (940, 1, 'VH1', 16, 'http://www.vh1.com/rss/news/today_on_vh1.jhtml', '', 0, 0, '2016-01-11 20:07:27.906618', '', NULL, 'http://www.vh1.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:27.564133', 0, false, 6, false, false, false, '', 0, '2016-01-11 12:07:39.863472', false);
INSERT INTO ttrss_feeds VALUES (606, 1, 'Quote of the Day', 214, 'http://feeds.feedburner.com/brainyquote/QUOTEBR', '', 15, 5, '2016-01-11 20:07:42.835274', '', NULL, 'http://www.brainyquote.com/link/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-26 19:15:42.656653', '2016-01-11 20:07:42.668053', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:07:45.64705', false);
INSERT INTO ttrss_feeds VALUES (926, 1, 'KOTATV', 85, 'http://www.kotatv.com/news/south-dakota-news/27244182?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:15:32.187372', '', NULL, 'http://www.kotatv.com/news/south-dakota-news/27244182', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:55:07.996734', '2016-01-11 20:15:32.07464', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:55:26.333474', false);
INSERT INTO ttrss_feeds VALUES (275, 1, 'My SA', NULL, 'http://www.mysanantonio.com/default/feed/local-news-176.php', '', -1, 0, '2015-06-12 00:20:42.210266', '', NULL, 'http://www.mysanantonio.com/default/feed/local-news-176.php', '', NULL, false, '', false, true, false, false, false, false, '2015-08-12 19:48:01.95786', '2015-06-12 00:20:40.743575', 0, false, 48, false, false, false, '', 0, '2015-06-11 13:00:28.267221', false);
INSERT INTO ttrss_feeds VALUES (1230, 1, 'Cosmopolitan', 18, 'http://cosmo.intoday.in.feedsportal.com/c/34156/f/618495/index.rss?http://cosmo.intoday.in/cosmo_rss.jsp?stId=264', '', 0, 0, '2016-01-11 20:02:07.628822', '', NULL, 'http://www.cosmo.intoday.in', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:36:05.075149', '2016-01-11 20:02:07.519729', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:41:59.308155', false);
INSERT INTO ttrss_feeds VALUES (663, 1, 'NDTV', 59, 'http://feeds.feedburner.com/ndtv/qJNd', '', 0, 0, '2016-01-11 20:02:07.856268', '', NULL, 'http://sports.ndtv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 18:29:53.91527', '2016-01-11 20:02:07.632076', 0, false, 69, false, false, false, '', 0, '2016-01-11 09:41:49.214152', false);
INSERT INTO ttrss_feeds VALUES (250, 1, 'KPRC Houston', 131, 'http://www.click2houston.com/5536186?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:05:08.532983', 'HTTP Code: 404', NULL, 'http://www.click2houston.com/5536186', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:24.130417', '2016-01-11 20:05:07.888235', 0, false, 2, false, false, false, '', 0, '2015-12-03 17:20:42.364909', false);
INSERT INTO ttrss_feeds VALUES (1074, 1, 'News On 6', 154, 'http://www.newson6.com/category/208401/newson6com-news-rss?clienttype=rss', '', 0, 0, '2016-01-11 20:00:43.108425', '', NULL, 'http://www.newson6.com/category/208401/newson6com-news-rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:24.130285', '2016-01-11 20:00:42.948591', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:00:57.724125', false);
INSERT INTO ttrss_feeds VALUES (23, 1, 'Variety', 9, 'http://feeds.feedburner.com/variety/news/frontpage', '', 0, 0, '2016-01-11 19:55:42.107896', '', NULL, 'http://variety.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:56:00.608757', '2016-01-11 20:15:01.959024', 0, false, 12, false, false, false, '', 0, '2016-01-11 16:16:37.43206', false);
INSERT INTO ttrss_feeds VALUES (10, 1, 'E!', 8, 'http://feeds.eonline.com/eonline/topstories', '', 0, 0, '2016-01-11 20:06:27.152936', '', NULL, 'http://www.eonline.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 12:39:23.013314', '2016-01-11 20:06:26.921462', 0, false, 6, false, false, false, '', 0, '2016-01-11 20:06:27.07789', false);
INSERT INTO ttrss_feeds VALUES (88, 1, 'GameSpot', 24, 'http://www.gamespot.com/feeds/new-games/', '', 0, 0, '2016-01-11 19:56:15.403296', '', NULL, 'http://www.gamespot.com/feeds/new-games/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 9, false, false, false, '', 0, '2016-01-11 16:17:10.437239', false);
INSERT INTO ttrss_feeds VALUES (148, 1, 'Five Thirty Eight', 44, 'http://fivethirtyeight.com/contributors/nate-silver/feed/', '', 0, 0, '2016-01-11 20:01:23.301551', '', NULL, 'http://fivethirtyeight.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:23.216269', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:21:19.761836', false);
INSERT INTO ttrss_feeds VALUES (1059, 1, 'ABC 11', 145, 'http://cdn.abclocal.go.com/wtvd/xml?id=7095536', '', 0, 0, '2016-01-11 19:56:31.181549', '', NULL, 'http://abclocal.go.com/wtvd/index', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:03.072605', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:37:19.449178', false);
INSERT INTO ttrss_feeds VALUES (518, 1, 'Jayski''s NASCAR Silly Season Site', NULL, 'http://www.jayski.com/jayski.rss', '', 0, 0, '2016-01-11 20:07:02.445098', '', NULL, 'http://www.jayski.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:36:56.696585', '2016-01-11 20:07:02.102667', 0, false, 16, false, false, false, '', 0, '2016-01-11 15:06:58.132315', false);
INSERT INTO ttrss_feeds VALUES (964, 1, 'ABC News', 80, 'http://abcnews.go.com/topics/urss?pageid=1085236', '', 0, 0, '2016-01-11 20:02:06.515216', '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 20:41:26.293661', '2016-01-11 20:02:06.126515', 0, false, 0, false, false, false, '', 0, '2016-01-11 11:41:36.417192', false);
INSERT INTO ttrss_feeds VALUES (1167, 1, 'My News 4', 196, 'http://www.mynews4.com/rss/3298.rss', '', 0, 0, '2016-01-11 20:15:44.561144', '', NULL, 'http://www.mynews4.com/news/local/default.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:46.514718', '2016-01-11 20:15:44.344435', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:35:34.883941', false);
INSERT INTO ttrss_feeds VALUES (1129, 1, 'Denver Post', 179, 'http://feeds.denverpost.com/dp-news-local-aurora', '', 0, 0, '2016-01-11 20:07:13.752174', '', NULL, 'http://www.denverpost.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:55.264477', '2016-01-11 20:07:13.416103', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:07:57.632022', false);
INSERT INTO ttrss_feeds VALUES (902, 1, 'Mother Jones', 41, 'http://www.motherjones.com/rss/sections/Environment/feed', '', 0, 0, '2016-01-11 20:02:08.411106', '', NULL, 'http://www.motherjones.com/politics/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:55:10.383609', '2016-01-11 20:02:07.956553', 0, false, 4, false, false, false, '', 0, '2016-01-11 14:21:52.723825', false);
INSERT INTO ttrss_feeds VALUES (905, 1, 'This Old House', 21, 'http://feeds.thisoldhouse.com/ThisOldHouseLatest', '', 0, 0, '2016-01-11 20:15:46.127672', '', NULL, 'http://www.thisoldhouse.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:20:53.400714', '2016-01-11 20:15:45.882495', 0, false, 1, false, false, false, '', 0, '2016-01-11 11:55:37.520983', false);
INSERT INTO ttrss_feeds VALUES (204, 1, 'New York Post', 66, 'http://nypost.com/entertainment/feed/', '', 0, 0, '2016-01-11 20:07:40.033524', '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:32.371191', '2016-01-11 20:07:39.991722', 0, false, 7, false, false, false, '', 0, '2016-01-11 14:08:28.311145', false);
INSERT INTO ttrss_feeds VALUES (207, 1, 'Metro Sports', NULL, 'http://www.metro.us/rss.xml?c=1410180502-1', '', 0, 0, '2016-01-11 20:10:23.401826', '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:07:59.684808', '2016-01-11 20:10:20.777528', 0, false, 45, false, false, false, '', 0, '2016-01-11 15:30:24.989399', false);
INSERT INTO ttrss_feeds VALUES (671, 1, 'LA Business Journal', 39, 'http://labusinessjournal.com/rss/headlines/la-technology/', '', 0, 0, '2016-01-11 20:10:23.969104', '', NULL, 'http://labusinessjournal.com/news/la-technology/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:13:32.316311', '2016-01-11 20:10:23.69619', 0, false, 10, false, false, false, '', 0, '2016-01-11 15:30:25.997458', false);
INSERT INTO ttrss_feeds VALUES (691, 1, 'MMA Fighting', 59, 'http://www.mmafighting.com/rss/current', '', 0, 0, '2016-01-11 20:10:24.276717', '', NULL, 'http://www.mmafighting.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-06 21:26:01.696675', '2016-01-11 20:10:24.096026', 0, false, 19, false, false, false, '', 0, '2016-01-11 15:30:26.350844', false);
INSERT INTO ttrss_feeds VALUES (105, 1, 'CNN', NULL, 'http://rss.cnn.com/RSS/CNN_TOPSTORIES.RSS', '', 0, 0, '2016-01-11 20:07:46.193037', 'HTTP Code: 404', NULL, 'http://www.cnn.com/index.html?eref=rss_topstories', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:33:51.24803', '2016-01-11 20:07:46.1826', 0, false, 14, false, false, false, '', 0, '2015-08-10 12:27:23.855001', false);
INSERT INTO ttrss_feeds VALUES (717, 1, 'Reuters', 39, 'http://feeds.reuters.com/reuters/technologyNews', '', 0, 0, '2016-01-11 20:10:24.698653', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:11:52.136035', '2016-01-11 20:10:24.48613', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:30:23.09722', false);
INSERT INTO ttrss_feeds VALUES (674, 1, 'CS Monitor', 39, 'http://rss.csmonitor.com/feeds/scitech', '', 0, 0, '2016-01-11 19:55:52.108115', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:19:09.61708', '2016-01-11 20:15:01.959024', 0, false, 5, false, false, false, '', 0, '2016-01-11 08:56:03.042395', false);
INSERT INTO ttrss_feeds VALUES (1011, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/cats', '', 0, 0, '2016-01-11 19:56:35.831435', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/cats/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:34:54.642152', '2016-01-11 20:15:01.959024', 0, false, 39, false, false, false, '', 0, '2016-01-11 19:16:51.632965', false);
INSERT INTO ttrss_feeds VALUES (1280, 1, 'Associated Press', 36, 'http://hosted2.ap.org/atom/APDEFAULT/cae69a7523db45408eeb2b3a98c0c9c5', '', 0, 0, '2016-01-11 20:15:20.858021', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, '2015-12-14 20:52:19.620768', '2016-01-11 20:15:20.822246', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:35:12.981657', false);
INSERT INTO ttrss_feeds VALUES (226, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/news/local/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:15:24.710445', '', NULL, 'http://www.nbclosangeles.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:22.451891', '2016-01-11 20:15:21.918036', 0, false, 7, false, false, false, '', 0, '2016-01-11 08:55:20.977266', false);
INSERT INTO ttrss_feeds VALUES (1244, 1, 'Bleacher Report', 28, 'http://bleacherreport.com/articles/feed?tag_id=18', '', 0, 0, '2016-01-11 20:10:05.237951', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 19:48:50.67432', '2016-01-11 20:10:05.066651', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:50:06.01301', false);
INSERT INTO ttrss_feeds VALUES (230, 1, 'SB Nation Los Angeles', 63, 'http://losangeles.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:52.934106', '', NULL, 'http://losangeles.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:49:46.298954', '2016-01-11 20:05:52.898669', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:45:38.60694', false);
INSERT INTO ttrss_feeds VALUES (1185, 1, 'WPRI 12', 206, 'http://wpri.com/feed/', '', 0, 0, '2016-01-11 20:06:17.473433', '', NULL, 'http://wpri.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:14.78813', '2016-01-11 20:06:17.369484', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:06:09.996264', false);
INSERT INTO ttrss_feeds VALUES (731, 1, 'HuffPost', 25, 'http://www.huffingtonpost.com/feeds/verticals/books/index.xml', '', 0, 0, '2016-01-11 20:10:24.975026', '', NULL, 'http://www.huffingtonpost.com/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:24.831498', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:30:27.059946', false);
INSERT INTO ttrss_feeds VALUES (688, 1, 'Yardbarker', 59, 'http://www.yardbarker.com/rss/sport/25', '', 0, 0, '2016-01-11 20:07:49.181767', '', NULL, 'http://www.yardbarker.com/mma', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:36:25.527287', '2016-01-11 20:07:49.116527', 0, false, 63, false, false, false, '', 0, '2016-01-11 12:47:30.331708', false);
INSERT INTO ttrss_feeds VALUES (216, 1, 'Sports Blog New York', 66, 'http://sportsblognewyork.com/feed/', '', 0, 0, '2016-01-11 20:07:54.169053', 'LibXML error 76 at line 111 (column 12): Opening and ending tag mismatch: link line 18 and head
', NULL, 'http://sportsblognewyork.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:39.690162', '2016-01-11 20:07:53.562843', 0, false, 12, false, false, false, '', 0, '2015-12-02 23:26:49.821967', false);
INSERT INTO ttrss_feeds VALUES (369, 1, 'The Guardian', 55, 'http://www.theguardian.com/artanddesign/art/rss', '', 0, 0, '2016-01-11 20:11:11.32721', '', NULL, 'http://www.theguardian.com/artanddesign/art', '', NULL, false, '', false, true, false, false, false, false, '2015-06-01 21:51:24.70555', '2016-01-11 20:11:11.115264', 0, false, 15, false, false, false, '', 0, '2016-01-11 17:11:09.782423', false);
INSERT INTO ttrss_feeds VALUES (1269, 1, 'Sports Illustrated', 27, 'http://www.si.com/rss/si_nfl.rss', '', 0, 0, '2016-01-11 20:07:58.159857', '', NULL, 'http://www.si.com/si_nfl.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:49:48.637871', '2016-01-11 20:07:58.151101', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:27:41.442449', false);
INSERT INTO ttrss_feeds VALUES (1178, 1, 'Local Channel 3000', 203, 'http://www.channel3000.com/16042556?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:11:20.360068', '', NULL, 'http://www.channel3000.com/16042556', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:35.53712', '2016-01-11 20:11:20.111884', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:11:23.322092', false);
INSERT INTO ttrss_feeds VALUES (1282, 1, 'Associated Press', 38, 'http://hosted2.ap.org/atom/APDEFAULT/f70471f764144b2fab526d39972d37b3', '', 0, 0, '2016-01-11 19:55:55.978822', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:36:42.421815', false);
INSERT INTO ttrss_feeds VALUES (812, 1, 'Travel Business News', 23, 'http://feeds.bizjournals.com/industry_12', '', 0, 0, '2016-01-11 20:00:22.04205', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:53:38.923147', '2016-01-11 20:00:21.850123', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:00:23.937095', false);
INSERT INTO ttrss_feeds VALUES (1194, 1, 'FresnoStateNews.com', 208, 'http://feeds.feedburner.com/fresnostatenews?format=xml', '', 0, 0, '2016-01-11 20:06:16.495708', '', NULL, 'http://www.fresnostatenews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:31.678777', '2016-01-11 20:06:16.245533', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:06:27.123234', false);
INSERT INTO ttrss_feeds VALUES (77, 1, 'Automotive News', 22, 'http://feeds.feedburner.com/autonews/BreakingNews', '', 0, 0, '2016-01-11 19:56:13.137211', '', NULL, 'http://www.autonews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:31:59.253549', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:16:30.44115', false);
INSERT INTO ttrss_feeds VALUES (120, 1, 'WIRED', 39, 'http://feeds.wired.com/wired/index', '', 0, 0, '2016-01-11 19:56:18.260532', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 15, false, false, false, '', 0, '2016-01-11 18:56:25.691471', false);
INSERT INTO ttrss_feeds VALUES (1084, 1, 'Essex County', 159, 'http://blog.nj.com/essex_impact/atom.xml', '', 0, 0, '2016-01-11 20:01:10.861593', '', NULL, 'http://www.nj.com/essex/index.ssf/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:09.43201', '2016-01-11 20:01:10.594694', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:41:00.008084', false);
INSERT INTO ttrss_feeds VALUES (976, 1, 'Local News | BellinghamHerald.com &', 69, 'http://www.bellinghamherald.com/news/local/?widgetName=rssfeed&widgetContentId=21615405&getXmlFeed=true', '', 0, 0, '2016-01-11 20:06:28.535863', '', NULL, 'http://www.bellinghamherald.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 21:06:14.592679', '2016-01-11 20:06:27.786041', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:46:27.981693', false);
INSERT INTO ttrss_feeds VALUES (123, 1, 'CIO UK', 39, 'http://rss.feedsportal.com/c/663/f/8422/index.rss', '', 0, 0, '2016-01-11 19:56:18.484363', '', NULL, 'http://www.cio.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-04-25 17:06:07.558201', '2016-01-11 20:15:01.959024', 0, false, 12, false, false, false, '', 0, '2016-01-11 18:56:25.895915', false);
INSERT INTO ttrss_feeds VALUES (1013, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/dogs', '', 0, 0, '2016-01-11 19:56:36.841241', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/dogs/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:15:00.231454', '2016-01-11 20:15:01.959024', 0, false, 34, false, false, false, '', 0, '2016-01-11 19:16:52.564454', false);
INSERT INTO ttrss_feeds VALUES (1006, 1, 'Quinnipiac Polls', 44, 'http://www.quinnipiac.edu/news-and-events/quinnipiac-university-poll/rss-polling-aggregate/', '', 0, 0, '2016-01-11 20:02:06.993672', '', NULL, 'http://www.quinnipiac.edu', '', NULL, false, '', false, true, false, false, false, false, '2015-07-14 17:21:18.298314', '2016-01-11 20:02:06.51825', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:02:05.109449', false);
INSERT INTO ttrss_feeds VALUES (733, 1, 'The Independent', 25, 'http://rss.feedsportal.com/c/266/f/3847/index.rss', '', 0, 0, '2016-01-11 20:10:25.050534', '', NULL, 'http://www.independent.co.uk/arts-entertainment/books/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:58:33.51814', '2016-01-11 20:10:24.980113', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:30:27.164391', false);
INSERT INTO ttrss_feeds VALUES (869, 1, 'Columbia Journalism Review', 43, 'http://cjr.org/index.xml', '', 0, 0, '2016-01-11 20:10:25.568698', '', NULL, 'http://www.cjr.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:23:39.305222', '2016-01-11 20:10:25.055991', 0, false, 2, false, false, false, '', 0, '2016-01-11 20:10:25.477078', false);
INSERT INTO ttrss_feeds VALUES (1232, 1, 'Future Music', 16, 'http://futuremusic.com/feed/', '', 0, 0, '2016-01-11 20:10:26.06254', '', NULL, 'http://futuremusic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:25.571558', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:30:28.17611', false);
INSERT INTO ttrss_feeds VALUES (1277, 1, 'Sports Illustrated', 60, 'http://www.si.com/rss/si_motorsports.rss', '', 0, 0, '2016-01-11 20:10:26.196057', '', NULL, 'http://www.si.com/si_motorsports.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:26.067249', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:30:28.2204', false);
INSERT INTO ttrss_feeds VALUES (99, 1, 'CNN', NULL, 'http://rss.cnn.com/rss/cnn_latest.rss', '', 0, 0, '2016-01-11 20:00:14.557675', '', NULL, 'http://www.cnn.com/?eref=rss_latest', '', NULL, false, '', false, true, false, false, false, false, '2015-06-30 17:49:04.218943', '2016-01-11 20:00:14.4226', 0, false, 12, false, false, false, '', 0, '2016-01-11 18:00:20.503833', false);
INSERT INTO ttrss_feeds VALUES (1163, 1, 'The Advocate', 195, 'http://theadvocate.com/feed?feedName=News&feedURL=http://theadvocate.com/news/&publication=Advocate&sections=/news/&areas=Stories&counts=20&feedContentPage=/shared/templates/feeds/rss2.csp', '', 0, 0, '2016-01-11 20:15:47.839677', '', NULL, 'http://theadvocate.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:51.828352', '2016-01-11 20:15:46.13256', 0, false, 0, false, false, false, '', 0, '2016-01-11 08:55:45.558826', false);
INSERT INTO ttrss_feeds VALUES (778, 1, 'NCAA', 59, 'http://www.ncaa.com/news/waterpolo-men/nc/rss.xml', '', 0, 0, '2016-01-11 20:10:27.729702', '', NULL, 'http://www.ncaa.com/news/waterpolo-men/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:02:51.889878', '2016-01-11 20:10:27.505544', 0, false, 48, false, false, false, '', 0, '2016-01-11 15:30:29.463902', false);
INSERT INTO ttrss_feeds VALUES (806, 1, 'NCAA', 59, 'http://www.ncaa.com/news/icehockey-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:05:10.714902', '', NULL, 'http://www.ncaa.com/news/icehockey-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:29.654913', '2016-01-11 20:05:10.515868', 0, false, 25, false, false, false, '', 0, '2016-01-11 12:05:10.006899', false);
INSERT INTO ttrss_feeds VALUES (1283, 1, 'Associated Press', 7, 'http://hosted2.ap.org/atom/APDEFAULT/386c25518f464186bf7a2ac026580ce7', '', 0, 0, '2016-01-11 20:00:31.617166', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 19:41:50.988558', '2016-01-11 20:00:31.575851', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:40:29.182585', false);
INSERT INTO ttrss_feeds VALUES (304, 1, 'SB Nation Dallas', 134, 'http://dallas.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:52.734676', '', NULL, 'http://dallas.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:52.954954', '2016-01-11 20:05:52.634324', 0, false, 5, false, false, false, '', 0, '2016-01-11 12:45:38.381172', false);
INSERT INTO ttrss_feeds VALUES (828, 1, 'The Guardian', 59, 'http://www.theguardian.com/sport/rugby-union/rss', '', 0, 0, '2016-01-11 20:05:11.140175', '', NULL, 'http://www.theguardian.com/sport/rugby-union', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:10.719391', 0, false, 51, false, false, false, '', 0, '2016-01-11 12:05:10.194107', false);
INSERT INTO ttrss_feeds VALUES (1137, 1, 'KMOV', 182, 'http://www.kmov.com/category/216452/kpho-newstream?clienttype=rss', '', 0, 0, '2016-01-11 20:06:36.227703', '', NULL, 'http://www.kmov.com/category/216452/cbs5-newstream', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:38.234133', '2016-01-11 20:06:36.169751', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:46:40.495252', false);
INSERT INTO ttrss_feeds VALUES (418, 1, 'ABC Detroit', 93, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10017&categoryId=10008', '', 0, 0, '2016-01-11 19:56:20.592074', '', NULL, 'http://www.wxyz.com/cma', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:23:01.153063', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 18:56:26.400177', false);
INSERT INTO ttrss_feeds VALUES (662, 1, 'Cricbuzz', 59, 'http://live-feeds.cricbuzz.com/CricbuzzFeed', '', 0, 0, '2016-01-11 20:07:00.716485', '', NULL, 'http://www.cricbuzz.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 20:38:06.565113', '2016-01-11 20:07:00.366322', 0, false, 68, false, false, false, '', 0, '2016-01-11 09:06:46.780553', false);
INSERT INTO ttrss_feeds VALUES (959, 1, 'Muslim Voices', 49, 'http://feeds.feedburner.com/MuslimVoicesBlog', '', 0, 0, '2016-01-11 20:15:27.182676', '', NULL, 'http://muslimvoices.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 21:17:29.165948', '2016-01-11 20:15:26.840146', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:55:21.306886', false);
INSERT INTO ttrss_feeds VALUES (1079, 1, 'KSTP', 156, 'http://kstp.com/rssFeeds/rss1.xml', '', 0, 0, '2016-01-11 20:00:36.806771', '', NULL, 'http://kstp.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:38.530819', '2016-01-11 20:00:36.316604', 0, false, 0, false, false, false, '', 0, '2016-01-11 20:00:36.685855', false);
INSERT INTO ttrss_feeds VALUES (775, 1, 'NCAA', 59, 'http://www.ncaa.com/news/trackfield-indoor-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:07:53.558611', '', NULL, 'http://www.ncaa.com/news/trackfield-indoor-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:53.378103', 0, false, 29, false, false, false, '', 0, '2016-01-11 16:48:29.710424', false);
INSERT INTO ttrss_feeds VALUES (301, 1, 'NBC 5 Dallas', 134, 'http://www.nbcdfw.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:01:31.808161', '', NULL, 'http://www.nbcdfw.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:37.052244', '2016-01-11 20:01:31.364976', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:32.010577', false);
INSERT INTO ttrss_feeds VALUES (157, 1, 'FOX Sports', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', 0, 0, '2016-01-11 20:10:04.053445', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:14:52.795234', '2016-01-11 20:10:03.918933', 0, false, 21, false, false, false, '', 0, '2016-01-11 17:50:04.899761', false);
INSERT INTO ttrss_feeds VALUES (782, 1, 'Climbing', 60, 'http://www.climbing.com/feed/', '', 0, 0, '2016-01-11 20:15:45.049218', '', NULL, 'http://www.climbing.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:44.866184', 0, false, 0, false, false, false, '', 0, '2016-01-11 11:15:39.029034', false);
INSERT INTO ttrss_feeds VALUES (1166, 1, 'KOLO', 196, 'http://www.kolotv.com/home/headlines/index.rss', '', 0, 0, '2016-01-11 20:10:10.400172', '', NULL, 'http://www.kolotv.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:47.777505', '2016-01-11 20:10:08.454579', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:50:11.218778', false);
INSERT INTO ttrss_feeds VALUES (777, 1, 'NCAA', 59, 'http://www.ncaa.com/news/volleyball-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:10:27.502909', '', NULL, 'http://www.ncaa.com/news/volleyball-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:27.324397', 0, false, 40, false, false, false, '', 0, '2016-01-11 15:30:29.3036', false);
INSERT INTO ttrss_feeds VALUES (794, 1, 'The full pint', 51, 'http://thefullpint.com/feed/', '', 0, 0, '2016-01-11 20:15:45.769127', '', NULL, 'http://thefullpint.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:18:52.897175', '2016-01-11 20:15:45.435827', 0, false, 9, false, false, false, '', 0, '2016-01-11 17:55:40.154819', false);
INSERT INTO ttrss_feeds VALUES (842, 1, 'Mental Floss', 11, 'http://mentalfloss.com/feeds/all', '', 0, 0, '2016-01-11 20:07:42.595878', '', NULL, 'http://mentalfloss.com/feeds/all', '', NULL, false, '', false, true, false, false, false, false, '2015-08-26 21:07:51.927518', '2016-01-11 20:07:42.342122', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:47:14.554234', false);
INSERT INTO ttrss_feeds VALUES (833, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/rugby-union/rss.xml', '', 0, 0, '2016-01-11 20:05:13.795848', '', NULL, 'http://www.bbc.co.uk/sport/0/rugby-union/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:59:40.951095', '2016-01-11 20:05:13.517488', 0, false, 11, false, false, false, '', 0, '2016-01-11 12:05:11.476911', false);
INSERT INTO ttrss_feeds VALUES (1132, 1, 'KBOI 2 News', 181, 'http://www.kboi2.com/news/?fin=xml&type=default&c=y', '', 0, 0, '2016-01-11 20:06:38.207596', 'LibXML error 68 at line 13 (column 14): StartTag: invalid element name
', NULL, 'http://www.kboi2.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:45.093255', '2016-01-11 20:06:36.640145', 0, false, 0, false, false, false, '', 0, '2015-12-03 15:35:06.007492', false);
INSERT INTO ttrss_feeds VALUES (543, 1, 'Religion In Africa', NULL, 'http://religioninafrica.com/feed/', '', 0, 0, '2016-01-11 19:55:39.893127', '', NULL, 'http://religioninafrica.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 22:09:53.488169', '2016-01-11 20:15:01.959024', 0, false, 20, false, false, false, '', 0, '2015-06-10 19:16:39.563645', false);
INSERT INTO ttrss_feeds VALUES (1052, 1, 'Colorado Springs Independent', 129, 'http://www.csindy.com/coloradosprings/Rss.xml', '', 0, 0, '2016-01-11 20:06:40.220455', '', NULL, 'http://www.csindy.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:18.44284', '2016-01-11 20:06:39.566677', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:46:45.915756', false);
INSERT INTO ttrss_feeds VALUES (231, 1, 'KABC-TV', 115, 'http://cdn.abclocal.go.com/kabc/xml?id=7075946', '', 0, 0, '2016-01-11 20:07:54.64723', '', NULL, 'http://abclocal.go.com/kabc/index', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:39.629101', '2016-01-11 20:07:54.327332', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:07:26.53025', false);
INSERT INTO ttrss_feeds VALUES (673, 1, 'LA Business Journal', 40, 'http://labusinessjournal.com/rss/headlines/la-healthcare/', '', 0, 0, '2016-01-11 20:01:42.980974', '', NULL, 'http://labusinessjournal.com/news/la-healthcare/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:17.072396', '2016-01-11 20:01:42.318504', 0, false, 8, false, false, false, '', 0, '2016-01-11 09:21:29.884228', false);
INSERT INTO ttrss_feeds VALUES (502, 1, 'Baltimore Sun', 106, 'http://www.baltimoresun.com/sports/baltimore-sports-blog/rss2.0.xml', '', 0, 0, '2016-01-11 20:06:43.5915', '', NULL, 'http://www.baltimoresun.com/sports/baltimore-sports-blog/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:01.30719', '2016-01-11 20:06:43.37683', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:46:49.991257', false);
INSERT INTO ttrss_feeds VALUES (921, 1, 'fox8.com', 73, 'http://fox8.com/feed/', '', 0, 0, '2016-01-11 19:56:30.561948', '', NULL, 'http://fox8.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:45:47.905671', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:37:18.759399', false);
INSERT INTO ttrss_feeds VALUES (787, 1, 'Transworld Skateboarding', 60, 'http://skateboarding.transworld.net/feed/', '', 0, 0, '2016-01-11 20:02:08.648168', '', NULL, 'http://skateboarding.transworld.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:08.413796', 0, false, 18, false, false, false, '', 0, '2016-01-11 15:22:07.29874', false);
INSERT INTO ttrss_feeds VALUES (478, 1, 'WCVB Sports', NULL, 'http://www.wcvb.com/9849852?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:06:59.941646', '', NULL, 'http://www.wcvb.com/9849852', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:19:59.260755', '2016-01-11 20:06:59.251436', 0, false, 31, false, false, false, '', 0, '2016-01-11 18:26:59.232335', false);
INSERT INTO ttrss_feeds VALUES (922, 1, 'KGWN', 85, 'http://www.kgwn.tv/home/headlines/index.rss2', '', 0, 0, '2016-01-11 19:56:30.856205', '', NULL, 'http://www.kgwn.tv/home/headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:47:15.663484', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:16:47.711729', false);
INSERT INTO ttrss_feeds VALUES (1042, 1, 'NBC 33', 133, 'http://www.21alive.com/news/local/index.rss2', '', 0, 0, '2016-01-11 19:56:31.962061', '', NULL, 'http://www.21alive.com/news/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:20.153075', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:56:37.411667', false);
INSERT INTO ttrss_feeds VALUES (210, 1, 'CBS New York', 66, 'http://newyork.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:07:40.21103', '', NULL, 'http://newyork.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:33.555361', '2016-01-11 20:07:40.038389', 0, false, 8, false, false, false, '', 0, '2016-01-11 14:08:28.363787', false);
INSERT INTO ttrss_feeds VALUES (1041, 1, 'WANE', 133, 'http://wane.com/feed/', '', 0, 0, '2016-01-11 19:56:32.651515', '', NULL, 'http://wane.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:21.331031', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:37:20.718247', false);
INSERT INTO ttrss_feeds VALUES (47, 1, 'Viral Viral Videos', 13, 'http://feeds.feedburner.com/viralviralvideos', '', 0, 0, '2016-01-11 20:15:26.398767', '', NULL, 'http://www.viralviralvideos.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 21:50:30.846498', '2016-01-11 20:15:26.209012', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:16:05.947412', false);
INSERT INTO ttrss_feeds VALUES (152, 1, 'Bleacher Report', 27, 'http://bleacherreport.com/articles/feed?tag_id=23', '', 0, 0, '2016-01-11 20:10:03.050462', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:14:42.947761', '2016-01-11 20:10:02.844233', 0, false, 16, false, false, false, '', 0, '2016-01-11 18:30:03.412942', false);
INSERT INTO ttrss_feeds VALUES (718, 1, 'Reuters', 41, 'http://feeds.reuters.com/reuters/scienceNews', '', 0, 0, '2016-01-11 20:10:24.483068', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 21:58:49.313841', '2016-01-11 20:10:24.281158', 0, false, 11, false, false, false, '', 0, '2016-01-11 15:10:29.87315', false);
INSERT INTO ttrss_feeds VALUES (779, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d1/rss.xml', '', 0, 0, '2016-01-11 20:10:27.915326', '', NULL, 'http://www.ncaa.com/news/wrestling/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:27.73295', 0, false, 47, false, false, false, '', 0, '2016-01-11 15:30:29.628819', false);
INSERT INTO ttrss_feeds VALUES (783, 1, 'DPM Climbing', 60, 'http://feeds.feedburner.com/deadpoint?format=xml', '', 0, 0, '2016-01-11 20:10:28.07315', '', NULL, 'http://www.dpmclimbing.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:14:42.36155', '2016-01-11 20:10:27.920847', 0, false, 4, false, false, false, '', 0, '2016-01-11 15:10:33.845647', false);
INSERT INTO ttrss_feeds VALUES (1268, 1, 'Yahoo Sports', 34, 'https://sports.yahoo.com/soccer/rss.xml', '', 0, 0, '2016-01-11 20:11:20.820217', '', NULL, 'http://sports.yahoo.com/soccer/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:20.662581', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:11:27.169715', false);
INSERT INTO ttrss_feeds VALUES (932, 1, 'Modern Hiker', 51, 'http://www.modernhiker.com/feed/', '', 0, 0, '2016-01-11 20:11:07.246389', '', NULL, 'http://www.modernhiker.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:14:01.970519', '2016-01-11 20:11:01.623375', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:31:05.417546', false);
INSERT INTO ttrss_feeds VALUES (704, 1, 'ABC News', 23, 'http://feeds.abcnews.com/abcnews/travelheadlines', '', 0, 0, '2016-01-11 20:10:28.484814', '', NULL, 'http://abcnews.go.com/Travel/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:52:29.261429', '2016-01-11 20:10:28.076858', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:30:30.465142', false);
INSERT INTO ttrss_feeds VALUES (1205, 1, 'Kansas City Local News', 70, 'http://kcmetro.com/local-news/kansas-city/feed/rss.html', '', 0, 0, '2016-01-11 20:01:17.801238', '', NULL, 'http://kcmetro.com/local-news/kansas-city/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:43:20.08319', '2016-01-11 20:01:14.574889', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:01:23.475087', false);
INSERT INTO ttrss_feeds VALUES (690, 1, 'CS Monitor', 36, 'http://rss.csmonitor.com/feeds/world', '', 0, 0, '2016-01-11 20:10:28.638309', '', NULL, 'http://www.csmonitor.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:32:48.701432', '2016-01-11 20:10:28.487912', 0, false, 9, false, false, false, '', 0, '2016-01-11 07:51:16.015432', false);
INSERT INTO ttrss_feeds VALUES (632, 1, 'Uncut', 16, 'http://www.uncut.co.uk/feed', '', 0, 0, '2016-01-11 20:11:38.682939', '', NULL, 'http://www.uncut.co.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:20:06.880876', '2016-01-11 20:11:38.473376', 0, false, 14, false, false, false, '', 0, '2016-01-11 12:11:21.463376', false);
INSERT INTO ttrss_feeds VALUES (592, 1, 'HowStuffWorks', 41, 'http://syndication.howstuffworks.com/rss/science', '', 0, 0, '2016-01-11 20:11:19.908399', '', NULL, 'http://science.howstuffworks.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-04 21:11:15.340406', '2016-01-11 20:11:19.820534', 0, false, 14, false, false, false, '', 0, '2016-01-11 17:11:22.595466', false);
INSERT INTO ttrss_feeds VALUES (789, 1, 'Skateboarder Magazine', 60, 'http://www.skateboardermag.com/feed/', '', 0, 0, '2016-01-11 20:10:29.19843', 'LibXML error 68 at line 1 (column 2): StartTag: invalid element name
', NULL, 'http://www.skateboardermag.com', '', NULL, false, '', false, true, false, false, false, false, '2015-12-14 20:15:36.792059', '2016-01-11 20:10:28.643647', 0, false, 11, false, false, false, '', 0, '2015-07-09 12:51:27.911477', false);
INSERT INTO ttrss_feeds VALUES (759, 1, 'Transworld BMX', 60, 'http://bmx.transworld.net/feed/', '', 0, 0, '2016-01-11 20:10:29.424654', '', NULL, 'http://bmx.transworld.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:30:04.050189', '2016-01-11 20:10:29.203574', 0, false, 16, false, false, false, '', 0, '2016-01-11 15:51:08.026699', false);
INSERT INTO ttrss_feeds VALUES (181, 1, 'BBC Sport', 32, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/golf/rss.xml', '', 0, 0, '2016-01-11 20:06:39.0961', '', NULL, 'http://www.bbc.co.uk/sport/0/golf/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 17:32:01.731904', '2016-01-11 20:06:38.915209', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:46:31.226366', false);
INSERT INTO ttrss_feeds VALUES (1018, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/mice', '', 0, 0, '2016-01-11 19:56:24.250251', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/mice/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 18:14:31.247655', '2016-01-11 20:15:01.959024', 0, false, 31, false, false, false, '', 0, '2016-01-11 18:56:27.977043', false);
INSERT INTO ttrss_feeds VALUES (788, 1, 'Thrasher Magazine', 60, 'http://www.thrashermagazine.com/en/rss/junk-drawer-feed/', '', 0, 0, '2016-01-11 20:10:30.367636', 'HTTP Code: 404', NULL, 'http://www.thrashermagazine.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-12-14 20:15:38.34602', '2016-01-11 20:10:29.428036', 0, false, 15, false, false, false, '', 0, '2015-09-23 05:20:10.866376', false);
INSERT INTO ttrss_feeds VALUES (1148, 1, 'Breaking Fremont News', 189, 'http://breakingfremontnews.com/feed/', '', 0, 0, '2016-01-11 20:07:50.13284', '', NULL, 'http://breakingfremontnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:55.693518', '2016-01-11 20:07:49.450802', 0, false, 0, false, false, false, '', 0, '2015-07-21 18:42:57.191531', false);
INSERT INTO ttrss_feeds VALUES (958, 1, 'Discovery', 53, 'http://feeds.feedburner.com/20ThingsYouDidntKnowAbout', '', 0, 0, '2016-01-11 20:15:32.070309', '', NULL, 'http://discovermagazine.com/rss/department-feeds/20-things', '', NULL, false, '', false, true, false, false, false, false, '2015-10-19 20:19:56.577421', '2016-01-11 20:15:31.79981', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:15:27.401306', false);
INSERT INTO ttrss_feeds VALUES (977, 1, 'Longview Daily News', 69, 'http://tdn.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', 0, 0, '2016-01-11 20:05:14.462212', '', NULL, 'http://tdn.com/search/?f=rss&t=article&l=50&s=start_time&sd=desc&k%5B%5D=%23topstory', '', NULL, false, '', false, true, false, false, false, false, '2015-07-15 21:06:17.509004', '2016-01-11 20:05:14.100985', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:45:12.88489', false);
INSERT INTO ttrss_feeds VALUES (772, 1, 'NCAA', 59, 'http://www.ncaa.com/news/golf-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:15:42.491136', '', NULL, 'http://www.ncaa.com/news/golf-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:21.912635', '2016-01-11 20:15:42.309694', 0, false, 43, false, false, false, '', 0, '2016-01-11 17:36:18.206142', false);
INSERT INTO ttrss_feeds VALUES (983, 1, 'Fox13now', 71, 'http://fox13now.com/feed/', '', 0, 0, '2016-01-11 20:05:14.625623', '', NULL, 'http://fox13now.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-06 22:41:06.870628', '2016-01-11 20:05:14.467238', 0, false, 3, false, false, false, '', 0, '2016-01-11 12:05:13.595685', false);
INSERT INTO ttrss_feeds VALUES (988, 1, 'New York Times', 28, 'http://rss.nytimes.com/services/xml/rss/nyt/Baseball.xml', '', 0, 0, '2016-01-11 20:10:05.551408', '', NULL, 'http://www.nytimes.com/pages/sports/baseball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:56:58.908159', '2016-01-11 20:10:05.465367', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:50:13.361436', false);
INSERT INTO ttrss_feeds VALUES (500, 1, 'WMAR Sports', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10009&categoryId=10004', '', 0, 0, '2016-01-11 20:11:40.31917', '', NULL, 'http://www.abc2news.com/worldcup', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:21:40.783232', '2016-01-11 20:11:39.187699', 0, false, 33, false, false, false, '', 0, '2016-01-11 17:11:36.357236', false);
INSERT INTO ttrss_feeds VALUES (1138, 1, 'Detroit Free Press', 175, 'http://rssfeeds.freep.com/freep/home&x=1', '', 0, 0, '2016-01-11 20:01:09.033621', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:39.358358', '2016-01-11 20:01:08.354657', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:00:59.853243', false);
INSERT INTO ttrss_feeds VALUES (511, 1, 'News OK', 79, 'http://newsok.com/rss/Jason%20Kersey', '', 0, 0, '2016-01-11 20:05:24.732563', '', NULL, 'http://newsok.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 18:37:59.638314', '2016-01-11 20:05:23.716032', 0, false, 1, false, false, false, '', 0, '2016-01-11 20:05:24.673903', false);
INSERT INTO ttrss_feeds VALUES (141, 1, 'ScienceDaily', 41, 'http://www.sciencedaily.com/rss/top/environment.xml', '', 0, 0, '2016-01-11 19:55:36.425542', '', NULL, 'http://www.sciencedaily.com/news/top/environment/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 21:56:42.678772', '2016-01-11 20:15:01.959024', 0, false, 23, false, false, false, '', 0, '2016-01-11 11:35:41.093535', false);
INSERT INTO ttrss_feeds VALUES (993, 1, 'The Sydney Morning Herald articles', 59, 'http://www.smh.com.au/rssheadlines/cricket/article/rss.xml', '', 0, 0, '2016-01-11 20:05:25.226295', '', NULL, 'http://smh.com.au', '', NULL, false, '', false, true, false, false, false, false, '2015-08-06 21:29:14.141373', '2016-01-11 20:05:24.737004', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:05:26.849476', false);
INSERT INTO ttrss_feeds VALUES (14, 1, 'Defamer', 8, 'http://defamer.gawker.com/rss', '', 0, 0, '2016-01-11 20:01:54.497267', '', NULL, 'http://defamer.gawker.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 19:48:03.635849', '2016-01-11 20:01:54.433446', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:01:51.671888', false);
INSERT INTO ttrss_feeds VALUES (100, 1, 'FOX News', 36, 'http://feeds.foxnews.com/foxnews/world', '', 0, 0, '2016-01-11 19:56:17.653747', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 15, false, false, false, '', 0, '2016-01-11 18:56:25.120672', false);
INSERT INTO ttrss_feeds VALUES (992, 1, 'The Dysfunctional Tennis Blog', 31, 'http://feeds.feedburner.com/tennisx', '', 0, 0, '2016-01-11 20:05:25.440826', '', NULL, 'http://www.tennis-x.com/xblog', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 20:12:47.449305', '2016-01-11 20:05:25.230069', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:45:18.253266', false);
INSERT INTO ttrss_feeds VALUES (185, 1, 'ESPN', 32, 'http://sports.espn.go.com/espn/rss/golf/news', '', 0, 0, '2016-01-11 20:06:42.080538', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:11:04.63271', '2016-01-11 20:06:41.870815', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:26:36.509217', false);
INSERT INTO ttrss_feeds VALUES (1159, 1, '13 News Now', 193, 'http://rssfeeds.13newsnow.com/wvec/local', '', 0, 0, '2016-01-11 19:55:34.966746', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:58.337554', '2016-01-11 20:15:47.972715', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:36:22.374439', false);
INSERT INTO ttrss_feeds VALUES (855, 1, 'Huff Post', 21, 'http://www.huffingtonpost.com/news/interior-design/feed//', '', 0, 0, '2016-01-11 20:07:27.339364', '', NULL, 'http://www.huffingtonpost.com/tag/interior-design', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:20:58.311074', '2016-01-11 20:07:26.863984', 0, false, 4, false, false, false, '', 0, '2016-01-11 13:28:00.378946', false);
INSERT INTO ttrss_feeds VALUES (729, 1, 'Forbes', 38, 'http://www.forbes.com/entrepreneurs/feed2/', '', 0, 0, '2016-01-11 20:10:31.083006', '', NULL, 'http://www.forbes.com/entrepreneurs/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-26 18:12:13.470892', '2016-01-11 20:10:30.373406', 0, false, 6, false, false, false, '', 0, '2016-01-11 08:10:35.248908', false);
INSERT INTO ttrss_feeds VALUES (69, 1, 'Epicurious.com', 20, 'http://FEEDS.FEEDBURNER.COM/EPICURIOUS/EPIBLOG?FORMAT=XML', '', 0, 0, '2016-01-11 20:02:00.128791', '', NULL, 'http://www.epicurious.com/features/blogs/editor/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:59.869783', 0, false, 10, false, false, false, '', 0, '2016-01-11 19:02:02.527475', false);
INSERT INTO ttrss_feeds VALUES (931, 1, 'Your EDM', 16, 'http://www.youredm.com/feed/', '', 0, 0, '2016-01-11 20:10:32.355024', '', NULL, 'http://www.youredm.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:31.088082', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:30:32.104619', false);
INSERT INTO ttrss_feeds VALUES (36, 1, 'Comedy News', 11, 'http://feeds.feedburner.com/COMEDYNEWSORG/PUBLISHEDNEWS', '', 0, 0, '2016-01-11 20:02:01.122867', '', NULL, 'http://www.comedynews.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:00.940633', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:42:29.941197', false);
INSERT INTO ttrss_feeds VALUES (1276, 1, 'Sports Illustrated', 31, 'http://www.si.com/rss/si_tennis.rss', '', 0, 0, '2016-01-11 20:02:04.554478', '', NULL, 'http://www.si.com/si_tennis.rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:02:04.547505', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:41:48.151349', false);
INSERT INTO ttrss_feeds VALUES (818, 1, 'The Independent', 59, 'http://www.independent.co.uk/sport/general/athletics/?service=rss', '', 0, 0, '2016-01-11 20:10:32.658865', '', NULL, 'http://www.independent.co.uk/sport/general/athletics/rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:32.357912', 0, false, 56, false, false, false, '', 0, '2016-01-11 09:30:33.442308', false);
INSERT INTO ttrss_feeds VALUES (145, 1, 'Worldwide Religious News', 49, 'http://wwrn.org/rss/', '', 0, 0, '2016-01-11 20:10:33.218837', '', NULL, 'http://wwrn.org/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 21:17:22.992115', '2016-01-11 20:10:32.6619', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:10:35.307274', false);
INSERT INTO ttrss_feeds VALUES (1135, 1, 'stltoday.com', 182, 'http://www.stltoday.com/search/?c=news%2Flocal,news%2flocal%2f*&d1=&d2=&s=start_time&sd=desc&l=50&f=rss&t=article', '', 0, 0, '2016-01-11 19:55:55.873611', '', NULL, 'http://www.stltoday.com/search/?c=news%2Flocal,news%2flocal%2f*&d1=&d2=&s=start_time&sd=desc&l=50&f=rss&t=article', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:33.204713', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:36:42.319551', false);
INSERT INTO ttrss_feeds VALUES (83, 1, 'Muscle & Fitness', 19, 'http://www.muscleandfitness.com/RSS.XML', '', 0, 0, '2016-01-11 20:10:34.481565', '', NULL, 'http://www.muscleandfitness.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:46:39.421908', '2016-01-11 20:10:34.312784', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:10:39.923218', false);
INSERT INTO ttrss_feeds VALUES (923, 1, 'NYT', 9, 'http://rss.nytimes.com/services/xml/rss/nyt/Movies.xml', '', 0, 0, '2016-01-11 19:56:30.348356', '', NULL, 'http://www.nytimes.com/pages/movies/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:37:18.488546', false);
INSERT INTO ttrss_feeds VALUES (1000, 1, 'AstroSage.com Daily Horoscope', NULL, 'http://feeds.feedburner.com/dayhoroscope', '', 0, 0, '2016-01-11 20:05:22.64201', '', NULL, 'http://www.astrosage.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 22:23:41.532897', '2016-01-11 20:05:22.390466', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:45:14.548783', false);
INSERT INTO ttrss_feeds VALUES (1071, 1, 'The Oakland Post', 153, 'http://www.oaklandpostonline.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news*&f=rss', '', 0, 0, '2016-01-11 20:01:22.801019', '', NULL, 'http://www.oaklandpostonline.com/search/?q=&t=article&l=25&d=&d1=&d2=&s=start_time&sd=desc&c%5B%5D=news*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:27.022374', '2016-01-11 20:01:22.290942', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:41:18.418587', false);
INSERT INTO ttrss_feeds VALUES (587, 1, 'NPR', 20, 'http://www.npr.org/rss/rss.php?id=1053', '', 0, 0, '2016-01-11 20:10:34.689712', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1053', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:45:30.007475', '2016-01-11 20:10:34.569868', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:30:31.33812', false);
INSERT INTO ttrss_feeds VALUES (827, 1, 'Swimming World News', 59, 'http://www.swimmingworldmagazine.com/news/feed/', '', 0, 0, '2016-01-11 20:05:36.616453', '', NULL, 'http://www.swimmingworldmagazine.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:35:23.995756', '2016-01-11 20:05:29.766823', 0, false, 50, false, false, false, '', 0, '2016-01-11 16:05:36.227155', false);
INSERT INTO ttrss_feeds VALUES (1238, 1, 'ESPN.com', 60, 'http://sports.espn.go.com/espn/rss/action/news', '', 0, 0, '2016-01-11 20:10:34.915728', '', NULL, 'http://sports.espn.go.com/action/index', '', NULL, false, '', false, true, false, false, false, false, '2015-08-11 18:17:41.722377', '2016-01-11 20:10:34.693844', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:30:39.562858', false);
INSERT INTO ttrss_feeds VALUES (256, 1, 'Philly.com Sports', 100, 'http://www.philly.com/philly_sports.rss', '', 0, 0, '2016-01-11 20:05:49.184579', '', NULL, 'http://www.philly.com/r?19=960&32=3796&7=195227&40=http%3A%2F%2Fwww.philly.com%2Fphilly%2Fsports', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:46:03.91445', '2016-01-11 20:05:49.092479', 0, false, 3, false, false, false, '', 0, '2016-01-11 09:25:35.182388', false);
INSERT INTO ttrss_feeds VALUES (143, 1, 'U.S. EPA', 41, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate?opendocument', '', 0, 0, '2016-01-11 20:01:23.182977', '', NULL, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate!open', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:06:49.101516', '2016-01-11 20:01:23.02361', 0, false, 25, false, false, false, '', 0, '2016-01-11 17:21:19.642304', false);
INSERT INTO ttrss_feeds VALUES (915, 1, 'Sun Sentinel', 68, 'http://www.sun-sentinel.com/news/florida/rss2.0.xml', '', 0, 0, '2016-01-11 20:15:20.413841', '', NULL, 'http://www.sun-sentinel.com/news/florida/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:12:53.985789', '2016-01-11 20:15:20.00362', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:35:12.891306', false);
INSERT INTO ttrss_feeds VALUES (963, 1, 'KOB.com', 80, 'http://www.kob.com/rssFeeds/rss504.xml', '', 0, 0, '2016-01-11 20:02:05.122966', '', NULL, 'http://www.kob.com/rssFeeds/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-30 18:29:45.043623', '2016-01-11 20:02:04.687391', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:41:48.721895', false);
INSERT INTO ttrss_feeds VALUES (1208, 1, 'KMBC', 83, 'http://www.kmbc.com/11665144?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:07:24.081', '', NULL, 'http://www.kmbc.com/11665144', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:47.367701', '2016-01-11 20:07:22.290435', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:08:12.347616', false);
INSERT INTO ttrss_feeds VALUES (751, 1, 'Four Wheeler', 60, 'http://www.fourwheeler.com/rss/news/', '', 0, 0, '2016-01-11 20:02:05.503008', '', NULL, 'http://www.fourwheeler.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 23:02:38.081138', '2016-01-11 20:02:05.126252', 0, false, 5, false, false, false, '', 0, '2016-01-11 13:41:49.183286', false);
INSERT INTO ttrss_feeds VALUES (577, 1, 'Health.com', 20, 'http://www.health.com/health/food-recipes/feed', '', 0, 0, '2016-01-11 20:10:35.027505', '', NULL, 'http://www.health.com/health/food-recipes', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:43:17.20968', '2016-01-11 20:10:34.919662', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:50:41.080706', false);
INSERT INTO ttrss_feeds VALUES (646, 1, 'Screen Rant', 9, 'http://feeds.feedburner.com/ScreenRant', '', 0, 0, '2016-01-11 20:10:20.771809', '', NULL, 'http://screenrant.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 22:36:09.198519', '2016-01-11 20:10:20.296445', 0, false, 14, false, false, false, '', 0, '2016-01-11 12:30:19.488994', false);
INSERT INTO ttrss_feeds VALUES (588, 1, 'NPR', 24, 'http://www.npr.org/rss/rss.php?id=1052', '', 0, 0, '2016-01-11 20:10:35.104459', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1052', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:48:51.841673', '2016-01-11 20:10:35.030406', 0, false, 6, false, false, false, '', 0, '2016-01-11 18:30:39.731805', false);
INSERT INTO ttrss_feeds VALUES (81, 1, 'HuffPost', 19, 'http://www.huffingtonpost.com/feeds/verticals/health-fitness/index.xml', '', 0, 0, '2016-01-11 20:10:34.309216', '', NULL, 'http://www.huffingtonpost.com/health-fitness/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:32:46.931901', '2016-01-11 20:10:34.179262', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:30:30.898916', false);
INSERT INTO ttrss_feeds VALUES (1133, 1, 'San Jose / Valley News', 146, 'http://feeds.mercurynews.com/mngi/rss/CustomRssServlet/568/200749.xml', '', 0, 0, '2016-01-11 20:01:30.86847', '', NULL, 'http://www.mercurynews.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:17.361278', '2016-01-11 20:01:30.626165', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:01:30.937339', false);
INSERT INTO ttrss_feeds VALUES (541, 1, 'Christian Headlines', 49, 'http://www.christianheadlines.com/rss/', '', 0, 0, '2016-01-11 20:10:35.304247', '', NULL, 'http://www.christianheadlines.com/rss/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 22:54:25.890813', '2016-01-11 20:10:35.108467', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:30:40.348423', false);
INSERT INTO ttrss_feeds VALUES (579, 1, 'Med News Today', 19, 'http://www.medicalnewstoday.com/rss/sports_medicine.xml', '', 0, 0, '2016-01-11 20:05:29.614301', '', NULL, 'http://www.medicalnewstoday.com/sections/sports_medicine/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:31:11.842757', '2016-01-11 20:05:28.982435', 0, false, 6, false, false, false, '', 0, '2016-01-11 08:25:23.08537', false);
INSERT INTO ttrss_feeds VALUES (1109, 1, 'FOX 8 News', 164, 'http://www.fox8live.com/category/235041/local-news?clienttype=rss', '', 0, 0, '2016-01-11 20:00:49.038816', '', NULL, 'http://www.fox8live.com/category/235041/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:55.302418', '2016-01-11 20:00:48.453719', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:01:01.211935', false);
INSERT INTO ttrss_feeds VALUES (1236, 1, 'ProSoccerTalk', 34, 'http://prosoccertalk.nbcsports.com/feed/', '', 0, 0, '2016-01-11 20:06:47.922114', '', NULL, 'http://soccer.nbcsports.com', '', NULL, false, '', false, true, false, false, false, false, '2015-08-10 22:43:56.661538', '2016-01-11 20:06:47.707174', 0, false, 1, false, false, false, '', 0, '2016-01-11 08:46:36.286418', false);
INSERT INTO ttrss_feeds VALUES (582, 1, 'SF Gate -Wine', 20, 'http://www.sfgate.com/rss/feed/Wine-551.php', '', 0, 0, '2016-01-11 20:10:35.873266', '', NULL, 'http://www.sfgate.com/rss/feed/Wine-551.php', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:52:00.057807', '2016-01-11 20:10:35.308471', 0, false, 9, false, false, false, '', 0, '2016-01-11 18:30:40.853218', false);
INSERT INTO ttrss_feeds VALUES (368, 1, 'NYT', 55, 'http://rss.nytimes.com/services/xml/rss/nyt/Arts.xml', '', 0, 0, '2016-01-11 20:11:11.111925', '', NULL, 'http://www.nytimes.com/pages/arts/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-01 21:53:59.935883', '2016-01-11 20:11:10.896159', 0, false, 18, false, false, false, '', 0, '2016-01-11 05:11:04.250407', false);
INSERT INTO ttrss_feeds VALUES (163, 1, 'FOX Sports', 28, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', 0, 0, '2016-01-11 20:10:05.643091', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:33:54.569023', '2016-01-11 20:10:05.55541', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:10:11.9756', false);
INSERT INTO ttrss_feeds VALUES (844, 1, 'NYT', 37, 'http://rss.nytimes.com/services/xml/rss/nyt/Politics.xml', '', 0, 0, '2016-01-11 20:01:23.435639', '', NULL, 'http://www.nytimes.com/pages/politics/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:13:59.861207', '2016-01-11 20:01:23.306362', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:21:19.824035', false);
INSERT INTO ttrss_feeds VALUES (856, 1, 'RT', 36, 'http://rt.com/rss/', '', 0, 0, '2016-01-11 20:01:25.002382', '', NULL, 'https://www.rt.com', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:41:31.641402', '2016-01-11 20:01:23.444082', 0, false, 12, false, false, false, '', 0, '2016-01-11 17:41:17.003225', false);
INSERT INTO ttrss_feeds VALUES (1257, 1, 'New York Times', 29, 'http://rss.nytimes.com/services/xml/rss/nyt/CollegeBasketball.xml', '', 0, 0, '2016-01-11 20:10:07.009764', '', NULL, 'http://www.nytimes.com/pages/sports/ncaabasketball/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:31.25668', '2016-01-11 20:10:06.909542', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:07.254981', false);
INSERT INTO ttrss_feeds VALUES (698, 1, 'NBC News', 40, 'http://feeds.nbcnews.com/feeds/health', '', 0, 0, '2016-01-11 20:00:11.615598', '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:12:18.518811', '2016-01-11 20:00:11.490375', 0, false, 9, false, false, false, '', 0, '2016-01-11 08:20:08.804073', false);
INSERT INTO ttrss_feeds VALUES (149, 1, 'Gallup', 44, 'http://www.gallup.com/TAG/ALL+GALLUP+HEADLINES.RSS', '', 0, 0, '2016-01-11 20:01:27.152668', '', NULL, 'http://www.gallup.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 20:29:52.998489', '2016-01-11 20:01:26.569261', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:41:19.437362', false);
INSERT INTO ttrss_feeds VALUES (310, 1, 'NBC Bay Area', 146, 'http://www.nbcbayarea.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:01:28.241488', '', NULL, 'http://www.nbcbayarea.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:09.855038', '2016-01-11 20:01:27.155756', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:21:25.896151', false);
INSERT INTO ttrss_feeds VALUES (672, 1, 'HeraldNet.com', 51, 'http://www.heraldnet.com/section/RSS16&mime=xml', '', 0, 0, '2016-01-11 20:10:24.093184', '', NULL, 'http://www.heraldnet.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:15:20.329293', '2016-01-11 20:10:23.971669', 0, false, 5, false, false, false, '', 0, '2016-01-11 15:30:26.260571', false);
INSERT INTO ttrss_feeds VALUES (1279, 1, 'Local News | The Sacramento Bee & Sacbee.com', 119, 'http://www.sacbee.com/news/local/?widgetName=rssfeed&widgetContentId=713546&getXmlFeed=true', '', 0, 0, '2016-01-11 20:01:29.747504', '', NULL, 'http://www.sacbee.com/news/local/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:28.54232', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:01:30.789843', false);
INSERT INTO ttrss_feeds VALUES (803, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d2/rss.xml', '', 0, 0, '2016-01-11 20:01:43.979904', '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:32.100072', '2016-01-11 20:01:43.472425', 0, false, 28, false, false, false, '', 0, '2016-01-11 09:21:30.52926', false);
INSERT INTO ttrss_feeds VALUES (410, 1, 'CBS 11', 134, 'http://cbs11tv.com/entertainment/resources_rss.xml', '', 0, 0, '2016-01-11 20:01:33.133984', '', NULL, 'http://dfw.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:40.198322', '2016-01-11 20:01:31.811667', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:01:11.459308', false);
INSERT INTO ttrss_feeds VALUES (377, 1, 'Beautiful Decay', 55, 'http://feeds.feedburner.com/beautifuldecay/OhOn', '', 0, 0, '2016-01-11 20:10:36.327044', '', NULL, 'http://beautifuldecay.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 20:48:38.633224', '2016-01-11 20:10:35.878594', 0, false, 16, false, false, false, '', 0, '2016-01-11 19:50:37.055382', false);
INSERT INTO ttrss_feeds VALUES (795, 1, 'National Speed Sport News', 59, 'http://www.nationalspeedsportnews.com/feed/', '', 0, 0, '2016-01-11 20:05:10.511298', '', NULL, 'http://www.nationalspeedsportnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:42:17.40893', '2016-01-11 20:05:09.645272', 0, false, 22, false, false, false, '', 0, '2016-01-11 12:45:09.850223', false);
INSERT INTO ttrss_feeds VALUES (411, 1, 'Star-Telegram', NULL, 'http://www.star-telegram.com/sports/?widgetName=rssfeed&widgetContentId=714290&getXmlFeed=true', '', 0, 0, '2016-01-11 20:05:40.107403', '', NULL, 'http://www.star-telegram.com/sports/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:04:55.417326', '2016-01-11 20:05:39.817961', 0, false, 21, false, false, false, '', 0, '2016-01-11 16:45:27.652657', false);
INSERT INTO ttrss_feeds VALUES (1175, 1, 'KOAT 7', 198, 'http://www.koat.com/9154708?format=rss_2.0&view=feed', '', 0, 0, '2016-01-11 20:11:42.597012', '', NULL, 'http://www.koat.com/9154708', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:38:58.400202', '2016-01-11 20:11:42.406997', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:31:29.546364', false);
INSERT INTO ttrss_feeds VALUES (1216, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d2/rss.xml', '', 0, 0, '2016-01-11 20:01:33.904992', '', NULL, 'http://www.ncaa.com/news/fieldhockey/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:18:46.544634', '2016-01-11 20:01:33.728929', 0, false, 3, false, false, false, '', 0, '2016-01-11 19:01:34.273464', false);
INSERT INTO ttrss_feeds VALUES (568, 1, 'TV.com', 10, 'http://createfeed.fivefilters.org/extract.php?url=www.tv.com%2F&in_id_or_class=&url_contains=', '', 0, 0, '2016-01-11 20:10:37.418113', '', NULL, 'http://www.tv.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:06:13.645173', '2016-01-11 20:10:36.331685', 0, false, 6, false, false, false, '', 0, '2016-01-11 10:10:59.67023', false);
INSERT INTO ttrss_feeds VALUES (25, 1, 'The Race', 9, 'http://feeds.feedburner.com/HOLLYWOODREPORTER-THERACE?FORMAT=XML', '', 0, 0, '2016-01-11 20:01:57.264534', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/76/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:57.05081', 0, false, 11, false, false, false, '', 0, '2016-01-11 12:21:41.379238', false);
INSERT INTO ttrss_feeds VALUES (1121, 1, 'Civil Beat', 176, 'http://www.civilbeat.com/feed/', '', 0, 0, '2016-01-11 20:05:40.246887', '', NULL, 'http://www.civilbeat.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:58.076679', '2016-01-11 20:05:40.111302', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:25:28.327687', false);
INSERT INTO ttrss_feeds VALUES (907, 1, 'CNET iPhone Update', 17, 'http://www.cnet.com/rss/iphone-update/', '', 0, 0, '2016-01-11 19:55:51.214322', '', NULL, 'http://www.cnet.com/#ftag=CAD4aa2096', '', NULL, false, '', false, true, false, false, false, false, '2015-11-16 21:10:59.973955', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-08 16:37:34.106093', false);
INSERT INTO ttrss_feeds VALUES (1223, 1, 'Pawcurious', 116, 'http://feeds.feedburner.com/Pawcurious?format=xml', '', 0, 0, '2016-01-11 20:06:56.711003', '', NULL, 'http://pawcurious.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:56.457753', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:26:56.197113', false);
INSERT INTO ttrss_feeds VALUES (1217, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d3/rss.xml', '', 0, 0, '2016-01-11 20:01:34.104174', '', NULL, 'http://www.ncaa.com/news/fieldhockey/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-12-10 19:37:53.121471', '2016-01-11 20:01:33.907671', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:34.483366', false);
INSERT INTO ttrss_feeds VALUES (1270, 1, 'Sports Illustrated', 28, 'http://www.si.com/rss/si_mlb.rss', '', 0, 0, '2016-01-11 20:10:05.253705', '', NULL, 'http://www.si.com/si_mlb.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:56:48.588343', '2016-01-11 20:10:05.242863', 0, false, 0, false, false, false, '', 0, '2016-01-11 10:10:07.834491', false);
INSERT INTO ttrss_feeds VALUES (144, 1, 'HuffPost', 49, 'http://www.huffingtonpost.com/FEEDS/VERTICALS/RELIGION/INDEX.XML', '', 0, 0, '2016-01-11 20:07:43.817217', 'HTTP Code: 404', NULL, 'http://www.huffingtonpost.com/religion/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 21:17:21.471123', '2016-01-11 20:07:43.759715', 0, false, 7, false, false, false, '', 0, '2016-01-11 19:07:55.587481', false);
INSERT INTO ttrss_feeds VALUES (1228, 1, 'ScienceDaily', 52, 'http://feeds.sciencedaily.com/sciencedaily/strange_offbeat?format=xml', '', 0, 0, '2016-01-11 20:01:35.125331', '', NULL, 'http://www.sciencedaily.com/news/strange_offbeat/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:34.691973', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:35.291199', false);
INSERT INTO ttrss_feeds VALUES (1271, 1, 'Sports Illustrated', 29, 'http://www.si.com/rss/si_nba.rss', '', 0, 0, '2016-01-11 20:10:07.140402', '', NULL, 'http://www.si.com/si_nba.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:34:32.791046', '2016-01-11 20:10:07.133533', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:50:07.963942', false);
INSERT INTO ttrss_feeds VALUES (277, 1, 'San Antonio Express', 138, 'http://www.mysanantonio.com/rss/feed/mySA-Entertainment-923.php', '', 0, 0, '2016-01-11 20:01:43.301653', '', NULL, 'http://www.mysanantonio.com/rss/feed/mySA-Entertainment-923.php', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:19.907732', '2016-01-11 20:01:43.245548', 0, false, 1, false, false, false, '', 0, '2016-01-11 09:21:30.280302', false);
INSERT INTO ttrss_feeds VALUES (728, 1, 'WashPost', 25, 'http://feeds.washingtonpost.com/rss/entertainment/books', '', 0, 0, '2016-01-11 20:10:24.82825', '', NULL, 'http://www.washingtonpost.com/pb/entertainment/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:24.7017', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:30:26.812413', false);
INSERT INTO ttrss_feeds VALUES (1116, 1, 'Star Advertiser', 176, 'http://www.staradvertiser.com/news/hawaiinews/index.rss', '', 0, 0, '2016-01-11 20:05:41.302759', '', NULL, 'http://www.staradvertiser.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:59.403084', '2016-01-11 20:05:40.251775', 0, false, 1, false, false, false, '', 0, '2016-01-11 11:45:30.310156', false);
INSERT INTO ttrss_feeds VALUES (791, 1, 'HuffPost', 51, 'http://www.huffingtonpost.com/news/cooking-how-to/feed//', '', 0, 0, '2016-01-11 20:05:06.28031', '', NULL, 'http://www.huffingtonpost.com/tag/cooking-how-to', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:16:44.746612', '2016-01-11 20:05:06.060729', 0, false, 7, false, false, false, '', 0, '2016-01-11 20:05:06.075704', false);
INSERT INTO ttrss_feeds VALUES (797, 1, 'NCAA', 59, 'http://www.ncaa.com/news/swimming-men/d3/rss.xml', '', 0, 0, '2016-01-11 20:01:35.323057', '', NULL, 'http://www.ncaa.com/news/swimming-men/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:17:08.495684', '2016-01-11 20:01:35.128577', 0, false, 36, false, false, false, '', 0, '2016-01-11 15:01:25.555159', false);
INSERT INTO ttrss_feeds VALUES (61, 1, 'NYT', 17, 'http://rss.nytimes.com/services/xml/rss/nyt/PersonalTech.xml', '', 0, 0, '2016-01-11 19:55:58.963468', '', NULL, 'http://www.nytimes.com/pages/technology/personaltech/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:36:45.344728', false);
INSERT INTO ttrss_feeds VALUES (423, 1, 'Detroit Sports Nation', 93, 'http://detroitsportsnation.com/feed/', '', 0, 0, '2016-01-11 20:05:43.377645', '', NULL, 'http://detroitsportsnation.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:09:00.187774', '2016-01-11 20:05:41.904887', 0, false, 4, false, false, false, '', 0, '2016-01-11 10:05:27.692389', false);
INSERT INTO ttrss_feeds VALUES (1030, 1, 'My Fox Tampa Bay', 124, 'http://www.myfoxtampabay.com/category/233680/local?clienttype=rss', '', 0, 0, '2016-01-11 20:05:44.171449', 'LibXML error 23 at line 1 (column 5525): EntityRef: expecting '';''
', NULL, 'http://www.myfoxtampabay.com/category/233680/local', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 17:45:45.700119', '2016-01-11 20:05:43.384746', 0, false, 0, false, false, false, '', 0, '2015-08-27 07:50:25.62163', false);
INSERT INTO ttrss_feeds VALUES (917, 1, 'ABC Ohio', 73, 'http://abcnews.go.com/topics/urss?pageid=1085217', '', 0, 0, '2016-01-11 20:15:25.451571', '', NULL, 'http://abcnews.go.com/topics/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:39:31.908986', '2016-01-11 20:15:25.12942', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:16:02.537274', false);
INSERT INTO ttrss_feeds VALUES (386, 1, 'WBNS Sports', NULL, 'http://www.10tv.com/content/syndication/sports.xml', '', 0, 0, '2016-01-11 20:06:26.917357', '', NULL, 'http://www.10tv.com/content/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:21:02.435754', '2016-01-11 20:06:26.850813', 0, false, 32, false, false, false, '', 0, '2016-01-11 16:46:33.094365', false);
INSERT INTO ttrss_feeds VALUES (1010, 1, 'ScienceDaily', 41, 'http://feeds.sciencedaily.com/sciencedaily/plants_animals/birds', '', 0, 0, '2016-01-11 20:06:27.782809', '', NULL, 'http://www.sciencedaily.com/news/plants_animals/birds/', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:34:34.484397', '2016-01-11 20:06:27.385785', 0, false, 30, false, false, false, '', 0, '2016-01-11 17:06:18.954028', false);
INSERT INTO ttrss_feeds VALUES (562, 1, 'Scientific American', 41, 'http://rss.sciam.com/sciam/society-and-policy', '', 0, 0, '2016-01-11 20:10:37.735606', '', NULL, 'http://www.scientificamerican.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 21:58:09.525389', '2016-01-11 20:10:37.42139', 0, false, 19, false, false, false, '', 0, '2016-01-11 18:30:41.678126', false);
INSERT INTO ttrss_feeds VALUES (1246, 1, 'Engadget', 39, 'http://www.engadget.com/rss.xml', '', 0, 0, '2016-01-11 20:01:35.691394', '', NULL, 'http://www.engadget.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-17 17:54:59.778553', '2016-01-11 20:01:35.327762', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:01:25.648747', false);
INSERT INTO ttrss_feeds VALUES (650, 1, 'Adweek', NULL, 'http://feeds.adweek.com/adweek/television', '', 0, 0, '2016-01-11 20:15:26.835464', '', NULL, 'http://www.adweek.com/adweek/feeds/106', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 23:33:28.622716', '2016-01-11 20:15:26.402404', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:55:21.017537', false);
INSERT INTO ttrss_feeds VALUES (709, 1, 'NBC News', 23, 'http://feeds.nbcnews.com/feeds/travel', '', 0, 0, '2016-01-11 20:01:41.860751', '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 18:11:53.406018', '2016-01-11 20:01:41.785666', 0, false, 3, false, false, false, '', 0, '2016-01-11 19:01:42.431456', false);
INSERT INTO ttrss_feeds VALUES (494, 1, 'On the Forecheck', 30, 'http://www.ontheforecheck.com/rss/current', '', 0, 0, '2016-01-11 20:10:37.848867', '', NULL, 'http://www.ontheforecheck.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-08-18 20:03:11.840271', '2016-01-11 20:10:37.740436', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:30:41.748261', false);
INSERT INTO ttrss_feeds VALUES (707, 1, 'USA TODAY', 23, 'http://rssfeeds.usatoday.com/UsatodaycomTravel-TopStories', '', 0, 0, '2016-01-11 20:01:42.313855', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:55:07.656836', '2016-01-11 20:01:41.865335', 0, false, 6, false, false, false, '', 0, '2016-01-11 09:21:29.313882', false);
INSERT INTO ttrss_feeds VALUES (957, 1, 'Discovery', 41, 'http://feeds.feedburner.com/DiscoverEnvironment', '', 0, 0, '2016-01-11 20:10:38.067783', '', NULL, 'http://discovermagazine.com/rss/topic-feeds/environment', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:37.8547', 0, false, 3, false, false, false, '', 0, '2016-01-11 18:30:41.922552', false);
INSERT INTO ttrss_feeds VALUES (549, 1, 'New Urban Legends', 50, 'http://www.snopes.com/info/whatsnew.xml', '', 0, 0, '2016-01-11 20:10:39.396764', '', NULL, 'http://www.snopes.com/info/whatsnew.asp', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:39.13067', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:50:36.944307', false);
INSERT INTO ttrss_feeds VALUES (364, 1, 'ARTnews', 55, 'http://www.artnews.com/feed/', '', 0, 0, '2016-01-11 20:11:10.892386', '', NULL, 'http://www.artnews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:16:15.125411', '2016-01-11 20:11:09.774076', 0, false, 12, false, false, false, '', 0, '2016-01-11 15:51:45.709826', false);
INSERT INTO ttrss_feeds VALUES (190, 1, 'FOX Sports', 34, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', 0, 0, '2016-01-11 20:06:42.989732', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:42.795741', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:46:49.160025', false);
INSERT INTO ttrss_feeds VALUES (790, 1, 'LoveKnitting Blog', 51, 'http://blog.loveknitting.com/feed/', '', 0, 0, '2016-01-11 20:01:44.513065', '', NULL, 'http://blog.loveknitting.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:18:22.981644', '2016-01-11 20:01:44.374738', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:22:38.439175', false);
INSERT INTO ttrss_feeds VALUES (1154, 1, 'Milwaukee Neighborhood News Service', 191, 'http://milwaukeenns.org/feed/', '', 0, 0, '2016-01-11 20:11:45.23158', '', NULL, 'http://milwaukeenns.org', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:39:06.367208', '2016-01-11 20:11:45.109427', 0, false, 4, false, false, false, '', 0, '2016-01-11 11:31:25.80923', false);
INSERT INTO ttrss_feeds VALUES (796, 1, 'BeerPulse', 51, 'http://feeds.feedburner.com/beerpulse', '', 0, 0, '2016-01-11 20:07:53.373392', '', NULL, 'http://beerpulse.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:14:20.721814', '2016-01-11 20:07:52.923247', 0, false, 3, false, false, false, '', 0, '2016-01-11 08:47:32.485027', false);
INSERT INTO ttrss_feeds VALUES (122, 1, 'NYT', 39, 'http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml', '', 0, 0, '2016-01-11 19:56:18.380322', '', NULL, 'http://www.nytimes.com/pages/technology/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 13, false, false, false, '', 0, '2016-01-11 18:56:25.781983', false);
INSERT INTO ttrss_feeds VALUES (819, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/swimming/rss.xml', '', 0, 0, '2016-01-11 20:01:45.640045', '', NULL, 'http://www.bbc.co.uk/sport/0/swimming/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 19:56:08.221815', '2016-01-11 20:01:45.388053', 0, false, 12, false, false, false, '', 0, '2016-01-11 16:02:46.794624', false);
INSERT INTO ttrss_feeds VALUES (421, 1, 'FOX Detroit', 93, 'http://www.myfoxdetroit.com/category/238935/entertainment?clienttype=rss', '', 0, 0, '2016-01-11 19:56:23.197554', 'LibXML error 23 at line 1 (column 5777): EntityRef: expecting '';''
', NULL, 'http://www.myfoxdetroit.com/category/238935/entertainment', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:23:21.312554', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2015-08-06 18:25:36.457553', false);
INSERT INTO ttrss_feeds VALUES (1025, 1, 'Fox 43', 121, 'http://fox43tv.com/feed/', '', 0, 0, '2016-01-11 19:56:25.175271', '', NULL, 'http://fox43tv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:41:08.809825', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:56:29.222796', false);
INSERT INTO ttrss_feeds VALUES (267, 1, 'Phoenix Business Journal', 137, 'http://feeds.bizjournals.com/bizj_phoenix', '', 0, 0, '2016-01-11 20:01:46.346228', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:24.400102', '2016-01-11 20:01:46.164162', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:01:47.680338', false);
INSERT INTO ttrss_feeds VALUES (781, 1, 'Rock And Ice Magazine', 60, 'http://www.rockandice.com/RSSRetrieve.aspx?ID=13126&Type=RSS20', '', 0, 0, '2016-01-11 20:10:23.691901', '', NULL, 'http://www.rockandice.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-11 21:10:29.509677', '2016-01-11 20:10:23.406351', 0, false, 10, false, false, false, '', 0, '2016-01-11 15:30:25.631451', false);
INSERT INTO ttrss_feeds VALUES (554, 1, 'Radar Online', 50, 'http://www.radaronline.com/rss', '', 0, 0, '2016-01-11 20:10:40.573495', '', NULL, 'http://radaronline.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:40.284581', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:30:43.336117', false);
INSERT INTO ttrss_feeds VALUES (1186, 1, 'Tucson- Arizona Daily Star', 207, 'http://tucson.com/search/?f=rss&c=news&l=25&s=start_time&sd=desc', '', 0, 0, '2016-01-11 20:10:51.947661', '', NULL, 'http://tucson.com/search/?f=rss&c=news&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:47.199581', '2016-01-11 20:10:51.468215', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:10:57.130833', false);
INSERT INTO ttrss_feeds VALUES (647, 1, 'CNET', 24, 'http://www.cnet.com/rss/gaming/', '', 0, 0, '2016-01-11 20:05:14.096866', '', NULL, 'http://www.cnet.com/#ftag=CADa872701', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 17:51:20.141123', '2016-01-11 20:05:13.881951', 0, false, 0, false, false, false, '', 0, '2016-01-11 20:05:13.963247', false);
INSERT INTO ttrss_feeds VALUES (131, 1, 'Scientific American', 41, 'http://rss.sciam.com/ScientificAmerican-News', '', 0, 0, '2016-01-11 20:10:58.861469', '', NULL, 'http://www.scientificamerican.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:58.623018', 0, false, 26, false, false, false, '', 0, '2016-01-11 16:52:22.394951', false);
INSERT INTO ttrss_feeds VALUES (7, 1, 'TMZ', 8, 'http://www.tmz.com/RSS.XML', '', 0, 0, '2016-01-11 20:01:53.496813', '', NULL, 'http://www.tmz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:53.251524', 0, false, 13, false, false, false, '', 0, '2016-01-11 19:01:50.594854', false);
INSERT INTO ttrss_feeds VALUES (1112, 1, 'Local News | CCCT', 170, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=100101&categoryId=20000', '', 0, 0, '2016-01-11 20:01:19.048459', '', NULL, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:48:23.972203', '2016-01-11 20:01:18.967719', 0, false, 0, false, false, false, '', 0, '2016-01-11 13:21:07.738778', false);
INSERT INTO ttrss_feeds VALUES (1284, 1, 'Associated Press', 39, 'http://hosted2.ap.org/atom/APDEFAULT/495d344a0d10421e9baa8ee77029cfbd', '', 0, 0, '2016-01-11 20:01:19.493947', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:19.458837', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:01:41.154979', false);
INSERT INTO ttrss_feeds VALUES (114, 1, 'FOX Business', 38, 'http://feeds.foxbusiness.com/FOXBUSINESS/LATEST', '', 0, 0, '2016-01-11 19:55:38.929557', '', NULL, 'http://www.foxbusiness.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:39:22.82093', '2016-01-11 20:15:01.959024', 0, false, 13, false, false, false, '', 0, '2016-01-11 07:55:49.062159', false);
INSERT INTO ttrss_feeds VALUES (697, 1, 'History', 53, 'http://www.history.com//news/feed/rss2', '', 0, 0, '2016-01-11 19:56:26.291047', '', NULL, 'http://www.history.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:31:16.827518', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:16:43.476902', false);
INSERT INTO ttrss_feeds VALUES (1049, 1, 'KSNB', 140, 'http://www.nbcneb.com/home/headlines/index.rss2', '', 0, 0, '2016-01-11 20:01:22.287392', '', NULL, 'http://www.nbcneb.com/home/headlines', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:44:40.415009', '2016-01-11 20:01:21.775981', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:41:09.844552', false);
INSERT INTO ttrss_feeds VALUES (1220, 1, 'That Pet Blog', 116, 'http://feeds.feedburner.com/ThatPetBlog?format=xml', '', 0, 0, '2016-01-11 20:06:49.422645', '', NULL, 'http://www.thatpetblog.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:06:49.165978', 0, false, 6, false, false, false, '', 0, '2016-01-11 18:47:16.779665', false);
INSERT INTO ttrss_feeds VALUES (624, 1, 'SportingKC', 34, 'http://www.sportingkc.com/rss/en.xml', '', 0, 0, '2016-01-11 20:01:48.097894', 'HTTP Code: 404', NULL, 'http://www.sportingkc.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:06:50.517835', '2016-01-11 20:01:47.83205', 0, false, 6, false, false, false, '', 0, '2015-10-06 21:18:23.779744', false);
INSERT INTO ttrss_feeds VALUES (769, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fencing/nc/rss.xml', '', 0, 0, '2016-01-11 20:15:41.710179', '', NULL, 'http://www.ncaa.com/news/fencing/nc/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:41.51103', 0, false, 33, false, false, false, '', 0, '2016-01-11 17:36:17.507243', false);
INSERT INTO ttrss_feeds VALUES (623, 1, 'SB Nation Kansas City', 83, 'http://kansascity.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:07:21.917685', '', NULL, 'http://kansascity.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:40.097216', '2016-01-11 20:07:21.808067', 0, false, 7, false, false, false, '', 0, '2016-01-11 16:47:59.920172', false);
INSERT INTO ttrss_feeds VALUES (63, 1, 'Electronic Design', 17, 'http://electronicdesign.com/rss.xml', '', 0, 0, '2016-01-11 20:01:48.593136', '', NULL, 'http://electronicdesign.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:48.10221', 0, false, 3, false, false, false, '', 0, '2016-01-11 10:01:55.717998', false);
INSERT INTO ttrss_feeds VALUES (882, 1, 'LA Times', 8, 'http://www.latimes.com/entertainment/gossip/rss2.0.xml', '', 0, 0, '2016-01-11 20:15:44.131912', '', NULL, 'http://www.latimes.com/entertainment/gossip/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:44.03868', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:16:21.381586', false);
INSERT INTO ttrss_feeds VALUES (75, 1, 'Dezeen', 21, 'http://feeds.feedburner.com/DEZEEN', '', 0, 0, '2016-01-11 20:10:44.346036', '', NULL, 'http://www.dezeen.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:21:46.168593', '2016-01-11 20:10:44.199284', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:52:07.637869', false);
INSERT INTO ttrss_feeds VALUES (936, 1, 'BuzzFeed', 8, 'http://www.buzzfeed.com/celebrity.xml', '', 0, 0, '2016-01-11 20:10:44.768743', '', NULL, 'http://www.buzzfeed.com/celeb', '', NULL, false, '', false, true, false, false, false, false, '2015-06-29 20:55:00.659378', '2016-01-11 20:10:44.350513', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:48.566862', false);
INSERT INTO ttrss_feeds VALUES (785, 1, 'Cycling Weekly', NULL, 'http://www.cyclingweekly.co.uk/feed', '', 0, 0, '2016-01-11 20:10:44.957076', '', NULL, 'http://www.cyclingweekly.co.uk', '', NULL, false, '', false, true, false, false, false, false, '2015-07-14 20:50:30.914181', '2016-01-11 20:10:44.77385', 0, false, 4, false, false, false, '', 0, '2016-01-11 16:52:09.259631', false);
INSERT INTO ttrss_feeds VALUES (879, 1, 'WashPost', 36, 'http://feeds.washingtonpost.com/rss/world', '', 0, 0, '2016-01-11 20:01:48.700969', '', NULL, 'http://www.washingtonpost.com/pb/world/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 18:51:26.644379', '2016-01-11 20:01:48.599197', 0, false, 8, false, false, false, '', 0, '2016-01-11 19:01:49.988109', false);
INSERT INTO ttrss_feeds VALUES (817, 1, 'Ripley''s Amazing Animals', 52, 'http://www.ripleys.com/bions/animals/feed/', '', 0, 0, '2016-01-11 20:10:46.017334', '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:26:15.124736', '2016-01-11 20:10:44.959816', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:11:30.635722', false);
INSERT INTO ttrss_feeds VALUES (208, 1, 'Metro', NULL, 'http://www.metro.us/rss.xml?c=1410180502-2', '', 0, 0, '2016-01-11 20:10:46.319464', '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:06:52.1625', '2016-01-11 20:10:46.02024', 0, false, 25, false, false, false, '', 0, '2016-01-11 17:10:51.056288', false);
INSERT INTO ttrss_feeds VALUES (585, 1, 'Food Safety News', 20, 'http://feeds.lexblog.com/foodsafetynews/mRcs', '', 0, 0, '2016-01-11 20:10:48.200166', '', NULL, 'http://www.foodsafetynews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:47.937723', 0, false, 6, false, false, false, '', 0, '2016-01-11 12:10:42.860891', false);
INSERT INTO ttrss_feeds VALUES (178, 1, 'USA TODAY', 31, 'http://rssfeeds.usatoday.com/UsatodayTennis-TopStories', '', 0, 0, '2016-01-11 20:06:38.911001', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 22:14:38.268822', '2016-01-11 20:06:38.379612', 0, false, 11, false, false, false, '', 0, '2016-01-11 16:46:43.899474', false);
INSERT INTO ttrss_feeds VALUES (1124, 1, 'WISH-TV', 171, 'http://wishtv.com/feed/', '', 0, 0, '2016-01-11 20:01:31.359893', '', NULL, 'http://wishtv.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:31.054555', '2016-01-11 20:01:31.221614', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:31.334897', false);
INSERT INTO ttrss_feeds VALUES (485, 1, 'Sports of Boston', 110, 'http://feeds.sportsofboston.com/SportsofBoston?format=xml', '', 0, 0, '2016-01-11 20:11:18.956387', '', NULL, 'http://sportsofboston.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:21:25.621531', '2016-01-11 20:11:18.761186', 0, false, 6, false, false, false, '', 0, '2016-01-11 19:31:19.892123', false);
INSERT INTO ttrss_feeds VALUES (84, 1, 'FOX News', 23, 'http://feeds.foxnews.com/FOXNEWS/INTERNAL/TRAVEL/MIXED', '', 0, 0, '2016-01-11 20:11:38.470344', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:50:19.703302', '2016-01-11 20:11:38.282792', 0, false, 8, false, false, false, '', 0, '2016-01-11 16:12:14.59097', false);
INSERT INTO ttrss_feeds VALUES (508, 1, 'KOCO Sports', NULL, 'http://www.koco.com/sports/topstory.rss', '', 0, 0, '2016-01-11 20:06:59.248996', '', NULL, 'http://www.koco.com/9844982', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 22:22:03.08501', '2016-01-11 20:06:58.912972', 0, false, 30, false, false, false, '', 0, '2016-01-11 09:06:46.083769', false);
INSERT INTO ttrss_feeds VALUES (1229, 1, 'Cosmopolitan', 8, 'http://cosmo.intoday.in.feedsportal.com/c/34156/f/618495/index.rss?http://cosmo.intoday.in/cosmo_rss.jsp?stId=263', '', 0, 0, '2016-01-11 20:01:33.53429', '', NULL, 'http://www.cosmo.intoday.in', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:33.452853', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:33.824503', false);
INSERT INTO ttrss_feeds VALUES (188, 1, 'BBC Sport', 59, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/cricket/rss.xml', '', 0, 0, '2016-01-11 20:01:46.159506', '', NULL, 'http://www.bbc.co.uk/sport/0/cricket/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:01.013685', '2016-01-11 20:01:45.642614', 0, false, 9, false, false, false, '', 0, '2016-01-11 13:01:51.276346', false);
INSERT INTO ttrss_feeds VALUES (116, 1, 'WSJ', 38, 'http://www.wsj.com/xml/rss/3_7031.xml', '', 0, 0, '2016-01-11 19:55:48.933096', '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:35:09.935986', '2016-01-11 20:15:01.959024', 0, false, 16, false, false, false, '', 0, '2016-01-11 09:35:57.639422', false);
INSERT INTO ttrss_feeds VALUES (59, 1, 'Engadget', 17, 'http://www.engadget.com/tag/mobile/rss.xml', '', 0, 0, '2016-01-11 19:55:58.880512', '', NULL, 'http://www.engadget.com/tag/mobile/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:58:11.300953', '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:36:45.244736', false);
INSERT INTO ttrss_feeds VALUES (119, 1, 'TechCrunch', 39, 'http://feeds.feedburner.com/TechCrunch/', '', 0, 0, '2016-01-11 19:56:18.118443', '', NULL, 'http://techcrunch.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 14, false, false, false, '', 0, '2016-01-11 18:56:25.596759', false);
INSERT INTO ttrss_feeds VALUES (158, 1, 'FOX Sports', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', 0, 0, '2016-01-11 20:10:03.909661', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:14:45.988724', '2016-01-11 20:10:03.569325', 0, false, 20, false, false, false, '', 0, '2016-01-11 17:50:04.503507', false);
INSERT INTO ttrss_feeds VALUES (874, 1, 'The Guardian', 36, 'http://www.theguardian.com/world/rss', '', 0, 0, '2016-01-11 20:15:06.667265', '', NULL, 'http://www.theguardian.com/world', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:33:13.024246', '2016-01-11 20:15:06.231231', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:35:08.432934', false);
INSERT INTO ttrss_feeds VALUES (375, 1, 'Huff Post', 55, 'http://www.huffingtonpost.com/feeds/verticals/arts/index.xml', '', 0, 0, '2016-01-11 20:10:47.901903', '', NULL, 'http://www.huffingtonpost.com/arts/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-01 22:05:49.26475', '2016-01-11 20:10:47.705014', 0, false, 14, false, false, false, '', 0, '2016-01-11 18:30:52.123578', false);
INSERT INTO ttrss_feeds VALUES (996, 1, 'CHN', 30, 'http://www.collegehockeynews.com/news/xml/newsfeed.xml', '', 0, 0, '2016-01-11 20:15:28.732993', '', NULL, 'http://collegehockeynews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 21:22:27.672541', '2016-01-11 20:15:28.67101', 0, false, 0, false, false, false, '', 0, '2016-01-11 07:15:28.913441', false);
INSERT INTO ttrss_feeds VALUES (871, 1, 'AdWeek', 43, 'http://feeds.adweek.com/adweek/all-news', '', 0, 0, '2016-01-11 20:05:11.573949', '', NULL, 'http://www.adweek.com/adweek/feeds/%2A', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 23:23:44.88856', '2016-01-11 20:05:11.145574', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:05:10.559455', false);
INSERT INTO ttrss_feeds VALUES (346, 1, 'Complex Music', 16, 'http://assets.complex.com/feeds/channels/music.xml', '', 0, 0, '2016-01-11 20:10:47.935395', '', NULL, 'http://www.complex.com/music', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 22:09:46.7401', '2016-01-11 20:10:47.905162', 0, false, 18, false, false, false, '', 0, '2016-01-11 18:30:53.012398', false);
INSERT INTO ttrss_feeds VALUES (112, 1, 'HuffPost', 37, 'http://feeds.huffingtonpost.com/c/35496/f/677086/index.rss', '', 0, 0, '2016-01-11 20:05:41.902415', '', NULL, 'http://www.huffingtonpost.com/politics/', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:45:34.992152', '2016-01-11 20:05:41.488374', 0, false, 15, false, false, false, '', 0, '2016-01-11 10:05:27.321254', false);
INSERT INTO ttrss_feeds VALUES (903, 1, 'WWD', 18, 'http://wwd.com/custom-feed/fashion/', '', 0, 0, '2016-01-11 20:00:27.580051', '', NULL, 'http://wwd.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:21.946714', '2016-01-11 20:00:27.50182', 0, false, 5, false, false, false, '', 0, '2016-01-11 19:00:28.394492', false);
INSERT INTO ttrss_feeds VALUES (968, 1, 'POLITICO', 37, 'http://www.politico.com/rss/politicopicks.xml', '', 0, 0, '2016-01-11 20:11:38.822929', '', NULL, 'http://www.politico.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:11:38.687816', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:11:34.469311', false);
INSERT INTO ttrss_feeds VALUES (658, 1, 'Cracked', 11, 'http://feeds.feedburner.com/CrackedRSS', '', 0, 0, '2016-01-11 20:05:54.994233', '', NULL, 'http://www.cracked.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:51:22.512265', '2016-01-11 20:05:54.757567', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:26:27.238967', false);
INSERT INTO ttrss_feeds VALUES (692, 1, 'MMA Junkie', 59, 'http://www.mmajunkie.com/news/rss', '', 0, 0, '2016-01-11 19:55:58.487311', '', NULL, 'http://mmajunkie.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 21:35:14.337325', '2016-01-11 20:15:01.959024', 0, false, 20, false, false, false, '', 0, '2016-01-11 11:36:01.455259', false);
INSERT INTO ttrss_feeds VALUES (710, 1, 'HuffPost', 23, 'http://www.huffingtonpost.com/feeds/verticals/travel/index.xml', '', 0, 0, '2016-01-11 20:05:55.110833', '', NULL, 'http://www.huffingtonpost.com/travel/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 19:43:40.743474', '2016-01-11 20:05:54.997213', 0, false, 2, false, false, false, '', 0, '2016-01-11 17:26:27.37448', false);
INSERT INTO ttrss_feeds VALUES (42, 1, 'Eurogamer.net', 24, 'http://www.eurogamer.net/?format=rss', '', 0, 0, '2016-01-11 20:11:16.493493', '', NULL, 'http://www.eurogamer.net/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:49:38.893041', '2016-01-11 20:11:15.892881', 0, false, 3, false, false, false, '', 0, '2016-01-11 16:52:38.918226', false);
INSERT INTO ttrss_feeds VALUES (169, 1, 'FOX Sports', 29, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', 0, 0, '2016-01-11 20:00:29.847602', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:15:08.721291', '2016-01-11 20:00:29.305211', 0, false, 14, false, false, false, '', 0, '2016-01-11 20:00:29.803133', false);
INSERT INTO ttrss_feeds VALUES (492, 1, 'News Channel 5', NULL, 'http://www.scrippsmedia.com/newschannel5/news/sports/index.rss', '', 0, 0, '2016-01-11 20:06:58.908305', '', NULL, 'http://www.scrippsmedia.com/templates/Lib.Feed.xml?path=/newschannel5/news/sports&format=RSSFull&limit=50', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 19:07:00.015698', '2016-01-11 20:06:57.99689', 0, false, 26, false, false, false, '', 0, '2016-01-11 09:06:45.640702', false);
INSERT INTO ttrss_feeds VALUES (872, 1, 'The Independent', 43, 'http://rss.feedsportal.com/c/266/f/3524/index.rss', '', 0, 0, '2016-01-11 20:07:12.546791', '', NULL, 'http://www.independent.co.uk/news/media/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-19 02:11:32.8684', '2016-01-11 20:07:12.460294', 0, false, 7, false, false, false, '', 0, '2016-01-11 15:27:02.139601', false);
INSERT INTO ttrss_feeds VALUES (1064, 1, 'KETV', 149, 'http://www.ketv.com/9675452?format=rss_2.0&view=asFeed', '', 0, 0, '2016-01-11 20:00:39.759199', '', NULL, 'http://www.ketv.com/9675452', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:00.689915', '2016-01-11 20:00:38.809469', 0, false, 0, false, false, false, '', 0, '2016-01-11 20:00:39.676156', false);
INSERT INTO ttrss_feeds VALUES (939, 1, 'TrailerAddict', 58, 'http://www.traileraddict.com/rss', '', 0, 0, '2016-01-11 20:15:26.204868', '', NULL, 'http://www.traileraddict.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:25.712734', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:55:20.477954', false);
INSERT INTO ttrss_feeds VALUES (749, 1, 'Universal Sports', 33, 'http://universalsports.com/winter-sports/feed/', '', 0, 0, '2016-01-11 20:15:32.398173', 'LibXML error 39 at line 30 (column 13): AttValue: " or '' expected
', NULL, 'http://universalsports.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:32.191764', 0, false, 3, false, false, false, '', 0, '2015-12-23 17:55:22.056523', false);
INSERT INTO ttrss_feeds VALUES (881, 1, 'LA Times', 7, 'http://www.latimes.com/nation/rss2.0.xml', '', 0, 0, '2016-01-11 20:07:13.084813', '', NULL, 'http://www.latimes.com/nation/rss2.0.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-22 22:53:24.739935', '2016-01-11 20:07:13.013558', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:27:02.947384', false);
INSERT INTO ttrss_feeds VALUES (990, 1, 'News', 31, 'http://www.wtatennis.com/feed.rss/category/12009823,12010172,12010877/limit/20/page/news/request/article', '', 0, 0, '2016-01-11 20:05:22.224454', '', NULL, 'http://www.wtatennis.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 19:02:05.03223', '2016-01-11 20:05:21.820062', 0, false, 2, false, false, false, '', 0, '2016-01-11 13:25:15.831789', false);
INSERT INTO ttrss_feeds VALUES (676, 1, 'The Guardian', 51, 'http://www.theguardian.com/sport/chess/rss', '', 0, 0, '2016-01-11 19:55:50.461138', '', NULL, 'http://www.theguardian.com/sport/chess', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 19:19:24.537641', '2016-01-11 20:15:01.959024', 0, false, 10, false, false, false, '', 0, '2016-01-11 09:16:10.255789', false);
INSERT INTO ttrss_feeds VALUES (382, 1, 'Weird Florida', 52, 'http://wlrn.org/feeds/1128/rss.xml', '', 0, 0, '2016-01-11 20:00:23.489129', '', NULL, 'http://wlrn.org', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 19:39:33.915642', '2016-01-11 20:00:22.579834', 0, false, 12, false, false, false, '', 0, '2016-01-11 19:00:25.266233', false);
INSERT INTO ttrss_feeds VALUES (908, 1, 'CNET Android Update', 17, 'http://www.cnet.com/rss/android-update/', '', 0, 0, '2016-01-11 19:55:51.949962', '', NULL, 'http://www.cnet.com/#ftag=CADe34d7bf', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:02:59.077213', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 14:55:54.025419', false);
INSERT INTO ttrss_feeds VALUES (1070, 1, 'The Oakland Press', 153, 'http://www.theoaklandpress.com/section?template=RSS&profile=4001177&mime=xml', '', 0, 0, '2016-01-11 20:01:23.020719', '', NULL, 'http://www.theoaklandpress.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:46:28.378882', '2016-01-11 20:01:22.803848', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:41:18.585006', false);
INSERT INTO ttrss_feeds VALUES (196, 1, 'HistoryOrb.com', NULL, 'http://feeds.feedburner.com/historyorb/todayinhistory', '', 0, 0, '2016-01-11 20:05:22.387702', '', NULL, 'http://www.onthisday.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 22:24:25.885991', '2016-01-11 20:05:22.228215', 0, false, 11, false, false, false, '', 0, '2016-01-11 20:05:22.379261', false);
INSERT INTO ttrss_feeds VALUES (1227, 1, 'ScienceDaily', 39, 'http://feeds.sciencedaily.com/sciencedaily/top_news/top_technology?format=xml', '', 0, 0, '2016-01-11 20:01:34.684881', '', NULL, 'http://www.sciencedaily.com/news/top/technology/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:01:34.107738', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:01:34.838303', false);
INSERT INTO ttrss_feeds VALUES (50, 1, 'Clever Ideas, Great Ads', 14, 'http://great-ads.blogspot.com/feeds/posts/default', '', 0, 0, '2016-01-11 19:55:57.789105', '', NULL, 'http://great-ads.blogspot.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 4, false, false, false, '', 0, '2016-01-11 19:55:57.727314', false);
INSERT INTO ttrss_feeds VALUES (703, 1, 'Surfline', 60, 'http://www.surfline.com/rss/surfnews.cfm', '', 0, 0, '2016-01-11 20:15:29.957659', '', NULL, 'http://www.surfline.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 20:33:39.230073', '2016-01-11 20:15:29.750643', 0, false, 14, false, false, false, '', 0, '2016-01-11 16:55:24.35152', false);
INSERT INTO ttrss_feeds VALUES (408, 1, 'Fort Worth Business Press', 173, 'http://www.fwbusinesspress.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&nsa=eedition&c[]=news,news/*&f=rss', '', 0, 0, '2016-01-11 20:05:23.709245', '', NULL, 'http://www.fortworthbusiness.com/search/?q=&t=article&l=100&d=&d1=&d2=&s=start_time&sd=desc&nsa=eedition&c%5B%5D=news,news/*&f=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:05.828657', '2016-01-11 20:05:22.649041', 0, false, 1, false, false, false, '', 0, '2016-01-11 20:05:23.449777', false);
INSERT INTO ttrss_feeds VALUES (484, 1, 'SB Nation Boston', 110, 'http://boston.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:39.813422', '', NULL, 'http://boston.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 21:33:41.082062', '2016-01-11 20:05:39.703446', 0, false, 5, false, false, false, '', 0, '2016-01-11 14:45:29.585884', false);
INSERT INTO ttrss_feeds VALUES (538, 1, 'The Vegas Parlay', 70, 'http://feeds.feedburner.com/TheVegasParlay?format=xml', '', 0, 0, '2016-01-11 20:06:47.546365', '', NULL, 'http://thevegasparlay.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:59.794405', '2016-01-11 20:06:47.269496', 0, false, 7, false, false, false, '', 0, '2016-01-11 18:26:42.836651', false);
INSERT INTO ttrss_feeds VALUES (924, 1, 'The A.V. Club', 9, 'http://www.avclub.com/feed/rss/?tags=film', '', 0, 0, '2016-01-11 19:56:30.503256', '', NULL, 'http://www.avclub.com/search?tags=film', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:09:29.872927', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:37:18.704364', false);
INSERT INTO ttrss_feeds VALUES (997, 1, 'Tennis Channel', 31, 'http://tennischannel.com/feed/', '', 0, 0, '2016-01-11 20:05:25.991008', '', NULL, 'http://tennischannel.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 20:10:39.047165', '2016-01-11 20:05:25.444787', 0, false, 3, false, false, false, '', 0, '2016-01-11 14:25:21.753254', false);
INSERT INTO ttrss_feeds VALUES (344, 1, 'San Francisco Business Times', 118, 'http://feeds.bizjournals.com/bizj_sanfrancisco', '', 0, 0, '2016-01-11 20:01:13.587589', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:32.878403', '2016-01-11 20:01:13.396627', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:01:04.17515', false);
INSERT INTO ttrss_feeds VALUES (1285, 1, 'Associated Press', 40, 'http://hosted2.ap.org/atom/APDEFAULT/bbd825583c8542898e6fa7d440b9febc', '', 0, 0, '2016-01-11 20:05:27.479072', '', NULL, 'http://hosted2.ap.org/atom/APDEFAULT/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:25.994566', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:05:27.817867', false);
INSERT INTO ttrss_feeds VALUES (1118, 1, 'Action News Jax', 148, 'http://www.actionnewsjax.com/list/rss/ap/florida/florida-news/aHG/', '', 0, 0, '2016-01-11 20:01:28.537183', '', NULL, 'http://www.actionnewsjax.com/list/ap/florida/florida-news/aHG/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:50:43.908218', '2016-01-11 20:01:28.244114', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:21:26.185213', false);
INSERT INTO ttrss_feeds VALUES (766, 1, 'NCAA', 59, 'http://www.ncaa.com/news/cross-country-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:05:41.484101', '', NULL, 'http://www.ncaa.com/news/cross-country-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:05:41.305427', 0, false, 37, false, false, false, '', 0, '2016-01-11 15:05:35.100095', false);
INSERT INTO ttrss_feeds VALUES (542, 1, 'PBS', 49, 'http://www.pbs.org/wnet/religionandethics/feed/', '', 0, 0, '2016-01-11 20:06:42.126981', '', NULL, 'http://www.pbs.org/wnet/religionandethics', '', NULL, false, '', false, true, false, false, false, false, '2015-06-25 21:27:42.640343', '2016-01-11 20:06:42.084072', 0, false, 5, false, false, false, '', 0, '2016-01-11 18:26:36.608214', false);
INSERT INTO ttrss_feeds VALUES (288, 1, 'CBS 8', 125, 'http://www.cbs8.com/Global/category.asp?clienttype=rss_img&C=154659', '', 0, 0, '2016-01-11 20:01:33.449879', '', NULL, 'http://www.cbs8.com/category/154659/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:51:58.043568', '2016-01-11 20:01:33.331995', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:01:33.691302', false);
INSERT INTO ttrss_feeds VALUES (1134, 1, 'Boise Weekly', 181, 'http://www.boiseweekly.com/boise/Rss.xml?section=920003', '', 0, 0, '2016-01-11 20:00:05.335913', '', NULL, 'http://www.boiseweekly.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:43.179475', '2016-01-11 20:00:02.159573', 0, false, 1, false, false, false, '', 0, '2016-01-11 12:20:03.244576', false);
INSERT INTO ttrss_feeds VALUES (1061, 1, 'The Raleigh Telegram', 145, 'http://raleightelegram.com/feed', '', 0, 0, '2016-01-11 20:00:06.140332', '', NULL, 'http://raleightelegram.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:45:02.496506', '2016-01-11 20:00:05.519692', 0, false, 1, false, false, false, '', 0, '2015-07-15 22:39:26.462419', false);
INSERT INTO ttrss_feeds VALUES (187, 1, 'The Ski Channel', 33, 'http://www.theskichannel.com/feed/', '', 0, 0, '2016-01-11 20:06:42.790306', '', NULL, 'http://www.theskichannel.com', '', NULL, false, '', false, true, false, false, false, false, '2015-07-08 20:30:26.181808', '2016-01-11 20:06:42.131133', 0, false, 2, false, false, false, '', 0, '2016-01-11 16:07:33.081615', false);
INSERT INTO ttrss_feeds VALUES (425, 1, 'SB Nation Detroit', 93, 'http://detroit.sbnation.com/rss/current', '', 0, 0, '2016-01-11 20:05:45.023009', '', NULL, 'http://detroit.sbnation.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 00:27:00.12535', '2016-01-11 20:05:44.928674', 0, false, 8, false, false, false, '', 0, '2016-01-11 15:05:37.176361', false);
INSERT INTO ttrss_feeds VALUES (522, 1, 'WHAS11 Sports', NULL, 'http://rssfeeds.whas11.com/whas/sports', '', 0, 0, '2016-01-11 20:05:45.976245', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:26:49.660336', '2016-01-11 20:05:45.581997', 0, false, 38, false, false, false, '', 0, '2016-01-11 16:05:46.259608', false);
INSERT INTO ttrss_feeds VALUES (390, 1, 'WOSU News Sports', NULL, 'http://wosu.org/2012/news-archive/category/sports/feed', '', 0, 0, '2016-01-11 20:05:48.06641', '', NULL, 'http://wosu.org/2012/news-archive', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:27:12.702013', '2016-01-11 20:05:45.978844', 0, false, 40, false, false, false, '', 0, '2016-01-11 16:05:48.752854', false);
INSERT INTO ttrss_feeds VALUES (1095, 1, 'CityBeat', 162, 'http://citybeat.com/cincinnati/rss-34-1-blogs.xml', '', 0, 0, '2016-01-11 20:00:43.689676', '', NULL, 'http://www.citybeat.com/cincinnati/blogs-1-1-1-34.html', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:47:28.598928', '2016-01-11 20:00:43.111796', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:00:58.265835', false);
INSERT INTO ttrss_feeds VALUES (470, 1, 'WTOP Sports', NULL, 'http://wtop.com/section/sports/feed', '', 0, 0, '2016-01-11 20:05:48.365904', '', NULL, 'http://wtop.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-09 18:28:01.43881', '2016-01-11 20:05:48.071905', 0, false, 41, false, false, false, '', 0, '2016-01-11 16:45:37.319895', false);
INSERT INTO ttrss_feeds VALUES (376, 1, 'The Art Newspaper', 55, 'http://www.theartnewspaper.com/rss/', '', 0, 0, '2016-01-11 20:01:41.780854', 'HTTP Code: 404', NULL, 'http://178.23.169.98', '', NULL, false, '', false, true, false, false, false, false, '2015-06-10 22:38:57.738036', '2016-01-11 20:01:41.198106', 0, false, 19, false, false, false, '', 0, '2015-11-30 05:17:42.209363', false);
INSERT INTO ttrss_feeds VALUES (1068, 1, 'CBS Miami', 152, 'http://miami.cbslocal.com/feed/', '', 0, 0, '2016-01-11 20:00:08.146899', '', NULL, 'http://miami.cbslocal.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:40:28.429646', '2016-01-11 20:00:08.006857', 0, false, 0, false, false, false, '', 0, '2016-01-11 19:40:04.799979', false);
INSERT INTO ttrss_feeds VALUES (1162, 1, 'Breaking Irvine News', 194, 'http://breakingirvinenews.com/feed/', '', 0, 0, '2016-01-11 20:15:02.776221', '', NULL, 'http://breakingirvinenews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:05.523731', '2016-01-11 20:15:01.985181', 0, false, 0, false, false, false, '', 0, '2015-07-21 19:50:08.68956', false);
INSERT INTO ttrss_feeds VALUES (191, 1, 'USA TODAY', 34, 'http://rssfeeds.usatoday.com/UsatodaycomSoccer-TopStories', '', 0, 0, '2016-01-11 20:15:03.275454', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:05:12.49517', '2016-01-11 20:15:02.781323', 0, false, 5, false, false, false, '', 0, '2016-01-11 17:35:03.871758', false);
INSERT INTO ttrss_feeds VALUES (223, 1, 'LA Daily News', 115, 'http://www.dailynews.com/section?template=RSS&profile=4000040&mime=xml', '', 0, 0, '2016-01-11 20:15:10.106542', '', NULL, 'http://www.dailynews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:18.924478', '2016-01-11 20:15:09.681882', 0, false, 4, false, false, false, '', 0, '2016-01-11 17:35:12.381831', false);
INSERT INTO ttrss_feeds VALUES (359, 1, 'BET', NULL, 'http://feeds.bet.com/BETcom-SportsNews', '', 0, 0, '2016-01-11 20:05:48.615037', 'HTTP Code: 304', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-12 19:46:57.522699', '2016-01-11 20:05:48.370308', 0, false, 42, false, false, false, '', 0, '2015-11-17 11:55:16.317625', false);
INSERT INTO ttrss_feeds VALUES (868, 1, 'Knight Foundation', 43, 'http://www.knightfoundation.org/rss/', '', 0, 0, '2016-01-11 20:05:48.913722', '', NULL, 'http://www.knightfoundation.org/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-19 02:10:57.134589', '2016-01-11 20:05:48.619659', 0, false, 3, false, false, false, '', 0, '2016-01-11 15:25:44.550292', false);
INSERT INTO ttrss_feeds VALUES (866, 1, 'The Huffington Post', 43, 'http://www.huffingtonpost.com/feeds/verticals/media/index.xml', '', 0, 0, '2016-01-11 20:05:49.089186', '', NULL, 'http://www.huffingtonpost.com/media/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-30 18:50:28.417741', '2016-01-11 20:05:48.917742', 0, false, 6, false, false, false, '', 0, '2016-01-11 15:25:44.660581', false);
INSERT INTO ttrss_feeds VALUES (1005, 1, 'La Crosse Tribune - Regional and State News', 64, 'http://lacrossetribune.com/search/?f=rss&c=news/state-and-regional/wi&l=25&s=start_time&sd=desc', '', 0, 0, '2016-01-11 19:55:37.422408', '', NULL, 'http://lacrossetribune.com/search/?f=rss&c=news/state-and-regional/wi&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, '2015-07-21 18:57:02.873874', '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 15:36:25.056033', false);
INSERT INTO ttrss_feeds VALUES (161, 1, 'ESPN', 28, 'http://sports.espn.go.com/espn/rss/mlb/news', '', 0, 0, '2016-01-11 20:05:50.230935', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 19:50:59.790122', '2016-01-11 20:05:49.908031', 0, false, 7, false, false, false, '', 0, '2016-01-11 17:26:24.002273', false);
INSERT INTO ttrss_feeds VALUES (1215, 1, 'NCAA', 59, 'http://www.ncaa.com/news/fieldhockey/d1/rss.xml', '', 0, 0, '2016-01-11 20:01:33.725317', '', NULL, 'http://www.ncaa.com/news/fieldhockey/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-07-23 19:18:31.817134', '2016-01-11 20:01:33.53704', 0, false, 2, false, false, false, '', 0, '2016-01-11 19:01:34.032896', false);
INSERT INTO ttrss_feeds VALUES (154, 1, 'ESPN', 27, 'http://sports.espn.go.com/espn/rss/ncf/news', '', 0, 0, '2016-01-11 20:10:07.994466', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:14:41.057845', '2016-01-11 20:10:07.76859', 0, false, 18, false, false, false, '', 0, '2016-01-11 18:30:08.900921', false);
INSERT INTO ttrss_feeds VALUES (357, 1, 'BET', 18, 'http://feeds.bet.com/BETcom-FashionBeauty', '', 0, 0, '2016-01-11 20:05:50.877616', '', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:59.106187', '2016-01-11 20:05:50.235903', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:06:04.231683', false);
INSERT INTO ttrss_feeds VALUES (55, 1, 'Telegraph Fashion', 18, 'http://fashion.telegraph.co.uk/RSS/', '', 0, 0, '2016-01-11 20:00:13.197827', '', NULL, 'http://fashion.telegraph.co.uk/', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:14.866395', '2016-01-11 20:00:12.975621', 0, false, 11, false, false, false, '', 0, '2016-01-11 19:00:13.838179', false);
INSERT INTO ttrss_feeds VALUES (720, 1, 'Reuters', 8, 'http://feeds.reuters.com/reuters/peopleNews', '', 0, 0, '2016-01-11 20:00:13.41395', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 19:47:47.611629', '2016-01-11 20:00:13.203363', 0, false, 4, false, false, false, '', 0, '2016-01-11 19:00:14.050289', false);
INSERT INTO ttrss_feeds VALUES (241, 1, 'NBC Chicago', 120, 'http://www.nbcchicago.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:05:52.63046', '', NULL, 'http://www.nbcchicago.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:14.491059', '2016-01-11 20:05:50.883145', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:26:25.539507', false);
INSERT INTO ttrss_feeds VALUES (859, 1, 'Polygon', 24, 'http://www.polygon.com/rss/index.xml', '', 0, 0, '2016-01-11 20:07:02.891939', '', NULL, 'http://www.polygon.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:07:02.846154', 0, false, 8, false, false, false, '', 0, '2016-01-11 16:07:51.403816', false);
INSERT INTO ttrss_feeds VALUES (206, 1, 'Metro', 66, 'http://www.metro.us/rss.xml?c=1414044023-4', '', 0, 0, '2016-01-11 20:07:38.536681', '', NULL, 'http://www.metro.us', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:28.872732', '2016-01-11 20:07:38.153349', 0, false, 2, false, false, false, '', 0, '2016-01-11 12:47:10.298224', false);
INSERT INTO ttrss_feeds VALUES (202, 1, 'New York Post', 66, 'http://nypost.com/news/feed/', '', 0, 0, '2016-01-11 20:07:38.594333', '', NULL, 'http://nypost.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:28.180312', '2016-01-11 20:07:38.540988', 0, false, 4, false, false, false, '', 0, '2016-01-11 12:47:10.354218', false);
INSERT INTO ttrss_feeds VALUES (214, 1, 'myfoxny.com', 66, 'http://www.myfoxny.com/category/233104/local-news?clienttype=rss', '', 0, 0, '2016-01-11 20:07:39.056987', 'LibXML error 23 at line 713 (column 50): EntityRef: expecting '';''
', NULL, 'http://www.myfoxny.com/category/233104/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:28.529673', '2016-01-11 20:07:38.601417', 0, false, 3, false, false, false, '', 0, '2015-08-13 13:07:42.667363', false);
INSERT INTO ttrss_feeds VALUES (209, 1, 'NYU News', 66, 'http://www.nyunews.com/feed/', '', 0, 0, '2016-01-11 20:07:39.988257', '', NULL, 'http://www.nyunews.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:30.226952', '2016-01-11 20:07:39.062064', 0, false, 6, false, false, false, '', 0, '2016-01-11 17:07:42.100085', false);
INSERT INTO ttrss_feeds VALUES (821, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/cycling/rss.xml', '', 0, 0, '2016-01-11 20:01:44.906155', '', NULL, 'http://www.bbc.co.uk/sport/0/cycling/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 18:00:24.537767', '2016-01-11 20:01:44.680357', 0, false, 6, false, false, false, '', 0, '2016-01-11 11:41:21.564482', false);
INSERT INTO ttrss_feeds VALUES (820, 1, 'BBC Sport', 59, 'http://feeds.bbci.co.uk/sport/0/athletics/rss.xml', '', 0, 0, '2016-01-11 20:01:45.158857', '', NULL, 'http://www.bbc.co.uk/sport/0/athletics/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 17:59:49.754116', '2016-01-11 20:01:44.909706', 0, false, 13, false, false, false, '', 0, '2016-01-11 13:21:36.673809', false);
INSERT INTO ttrss_feeds VALUES (826, 1, 'The Roar', 59, 'http://feeds.theroar.com.au/theroar/cricket', '', 0, 0, '2016-01-11 20:01:45.384131', '', NULL, 'http://www.theroar.com.au', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:33:50.637854', '2016-01-11 20:01:45.161636', 0, false, 58, false, false, false, '', 0, '2016-01-11 09:21:31.716475', false);
INSERT INTO ttrss_feeds VALUES (1184, 1, 'KFYO 790', 205, 'http://kfyo.com/feed/', '', 0, 0, '2016-01-11 20:11:34.846341', '', NULL, 'http://kfyo.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-29 21:03:26.651729', '2016-01-11 20:11:34.642301', 0, false, 1, false, false, false, '', 0, '2016-01-11 20:11:34.798351', false);
INSERT INTO ttrss_feeds VALUES (201, 1, 'SPIN', 16, 'http://www.spin.com/feed/', '', 0, 0, '2016-01-11 20:11:39.183114', '', NULL, 'http://www.spin.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:19:56.702007', '2016-01-11 20:11:39.172674', 0, false, 20, false, false, false, '', 0, '2016-01-11 12:51:50.37485', false);
INSERT INTO ttrss_feeds VALUES (1158, 1, 'Rambler Newspapers', 192, 'http://ramblernewspapers.com/category/irving/feed/', '', 0, 0, '2016-01-11 19:55:38.521729', '', NULL, 'http://ramblernewspapers.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:02.644512', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 07:35:53.417236', false);
INSERT INTO ttrss_feeds VALUES (137, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Environment.xml', '', 0, 0, '2016-01-11 19:55:39.972235', '', NULL, 'http://www.nytimes.com/pages/science/earth/index.html?partner=rss&emc=rss', '', NULL, false, '', false, false, false, false, false, false, '2015-06-23 21:58:05.191199', '2016-01-11 20:15:01.959024', 0, false, 18, true, false, false, '', 0, '2016-01-11 15:36:31.510393', false);
INSERT INTO ttrss_feeds VALUES (928, 1, 'NYT', 10, 'http://rss.nytimes.com/services/xml/rss/nyt/Television.xml', '', 0, 0, '2016-01-11 19:55:40.086121', '', NULL, 'http://www.nytimes.com/pages/arts/television/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:15:01.959024', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:36:30.962352', false);
INSERT INTO ttrss_feeds VALUES (927, 1, 'The Billings Gazette', 85, 'http://billingsgazette.com/search/?f=rss&c=news/state-and-regional/wyoming&l=25&s=start_time&sd=desc', '', 0, 0, '2016-01-11 19:55:40.333807', '', NULL, 'http://billingsgazette.com/search/?f=rss&c=news/state-and-regional/wyoming&l=25&s=start_time&sd=desc', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:55:51.093245', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 15:36:32.010355', false);
INSERT INTO ttrss_feeds VALUES (694, 1, 'NPR', 16, 'http://www.npr.org/rss/rss.php?id=1039', '', 0, 0, '2016-01-11 19:55:42.722276', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1039', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:19:24.226154', '2016-01-11 20:15:01.959024', 0, false, 8, false, false, false, '', 0, '2016-01-11 17:36:33.676921', false);
INSERT INTO ttrss_feeds VALUES (570, 1, 'Television', 10, 'http://feeds.feedburner.com/thr/television', '', 0, 0, '2016-01-11 19:55:40.484832', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/60/0/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:59:54.595793', '2016-01-11 20:15:01.959024', 0, false, 3, false, false, false, '', 0, '2016-01-11 12:15:59.578031', false);
INSERT INTO ttrss_feeds VALUES (1130, 1, 'New Santa Ana', 180, 'http://feeds.feedburner.com/NewSantaAna', '', 0, 0, '2016-01-11 20:07:57.057228', '', NULL, 'http://newsantaana.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:53:08.866989', '2016-01-11 20:07:56.757521', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:27:48.546258', false);
INSERT INTO ttrss_feeds VALUES (949, 1, 'Daily Mail', 36, 'http://www.dailymail.co.uk/news/worldnews/index.rss', '', 0, 0, '2016-01-11 20:00:24.31882', '', NULL, 'http://www.dailymail.co.uk/news/worldnews/index.html?ITO=1490&ns_mchannel=rss&ns_campaign=1490', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:00:23.811997', 0, false, 2, false, false, false, '', 0, '2016-01-11 19:00:25.620411', false);
INSERT INTO ttrss_feeds VALUES (829, 1, 'ESPN', 59, 'http://sports-ak.espn.go.com/espn/rss/horse/news', '', 0, 0, '2016-01-11 19:55:45.561948', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:28:06.573494', '2016-01-11 20:15:01.959024', 0, false, 17, false, false, false, '', 0, '2016-01-11 14:35:48.741021', false);
INSERT INTO ttrss_feeds VALUES (311, 1, 'Mashable', 39, 'http://feeds.mashable.com/mashable/tech', '', 0, 0, '2016-01-11 20:00:24.546184', '', NULL, 'http://mashable.com/category/tech/?utm_campaign=Mash-Prod-RSS-Feedburner-Tech-Partial&utm_cid=Mash-Prod-RSS-Feedburner-Tech-Partial', '', NULL, false, '', false, true, false, false, false, false, '2015-05-28 21:35:05.727817', '2016-01-11 20:00:24.323383', 0, false, 11, false, false, false, '', 0, '2016-01-11 12:00:21.173966', false);
INSERT INTO ttrss_feeds VALUES (834, 1, 'Boxing News', 59, 'http://www.boxing.com/news/rss', '', 0, 0, '2016-01-11 19:55:47.708476', '', NULL, 'http://www.boxing.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:33:45.919508', '2016-01-11 20:15:01.959024', 0, false, 16, false, false, false, '', 0, '2016-01-11 14:35:49.230524', false);
INSERT INTO ttrss_feeds VALUES (98, 1, 'CNN', NULL, 'http://rss.cnn.com/rss/edition.rss', '', 0, 0, '2016-01-11 20:02:04.246206', '', NULL, 'http://edition.cnn.com/index.html?eref=edition', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 22:10:04.484997', '2016-01-11 20:02:04.130398', 0, false, 13, false, false, false, '', 0, '2016-01-11 17:21:59.916474', false);
INSERT INTO ttrss_feeds VALUES (234, 1, 'Chicago Sun Times', 120, 'http://chicago.suntimes.com/feed/', '', 0, 0, '2016-01-11 19:55:47.870397', '', NULL, 'http://chicago.suntimes.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:54:13.175394', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:35:51.292091', false);
INSERT INTO ttrss_feeds VALUES (648, 1, 'Media', NULL, 'http://www.ft.com/rss/companies/media', '', 0, 0, '2016-01-11 19:55:47.993106', '', NULL, 'http://www.ft.com/companies/media', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 17:59:42.064182', '2016-01-11 20:15:01.959024', 0, false, 9, false, false, false, '', 0, '2016-01-11 14:35:51.780104', false);
INSERT INTO ttrss_feeds VALUES (153, 1, 'ESPN', 27, 'http://sports.espn.go.com/espn/rss/nfl/news', '', 0, 0, '2016-01-11 20:10:03.563554', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, '2016-01-07 23:14:36.202443', '2016-01-11 20:10:03.197237', 0, false, 19, false, false, false, '', 0, '2016-01-11 17:50:03.727233', false);
INSERT INTO ttrss_feeds VALUES (155, 1, 'CBS Sports', 27, 'http://www.cbssports.com/partners/feeds/rss/nfl_news', '', 0, 0, '2016-01-11 20:10:04.105885', '', NULL, 'http://www.cbssports.com/nfl', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 21:32:59.381626', '2016-01-11 20:10:04.057797', 0, false, 22, false, false, false, '', 0, '2016-01-11 19:50:04.343851', false);
INSERT INTO ttrss_feeds VALUES (160, 1, 'USA TODAY', 27, 'http://rssfeeds.usatoday.com/UsatodaycomCollegeFootball-TopStories', '', 0, 0, '2016-01-11 20:10:04.750247', '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-05 21:57:37.854015', '2016-01-11 20:10:04.11074', 0, false, 23, false, false, false, '', 0, '2016-01-11 17:50:05.237041', false);
INSERT INTO ttrss_feeds VALUES (1127, 1, 'The Orange County Register', 178, 'http://www.ocregister.com/common/rss/rss.php?catID=18860', '', 0, 0, '2016-01-11 19:55:41.898656', '', NULL, 'http://www.ocregister.com/common/archives/?catID=18860', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:52:59.151619', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:16:37.244935', false);
INSERT INTO ttrss_feeds VALUES (1170, 1, 'ABC 15', 200, 'http://scrippsobfeeds.endplay.com/content-syndication-portlet/feedServlet?obfType=RSS_FEED&siteId=10008&categoryId=20415', '', 0, 0, '2016-01-11 19:55:42.859597', '', NULL, 'http://www.abc15.com/southernarizona', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:16.020874', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 15:36:36.801852', false);
INSERT INTO ttrss_feeds VALUES (299, 1, 'FOX 4 News', NULL, 'http://www.fox4news.com/category/233343/entertainment?clienttype=rss', '', 0, 0, '2016-01-11 20:00:25.321123', 'HTTP Code: 404', NULL, 'http://www.fox4news.com/category/233343/entertainment', '', NULL, false, '', false, true, false, false, false, false, '2015-07-07 20:31:06.423429', '2016-01-11 20:00:24.552099', 0, false, 24, false, false, false, '', 0, '2015-08-13 13:12:00.91355', false);
INSERT INTO ttrss_feeds VALUES (970, 1, 'Denver Post', 82, 'http://feeds.denverpost.com/dp-news-breaking?_ga=1.259951821.670207890.1435690703', '', 0, 0, '2016-01-11 19:55:49.439725', '', NULL, 'http://www.denverpost.com/breakingnews/', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:42:30.470926', '2016-01-11 20:15:01.959024', 0, false, 1, false, false, false, '', 0, '2016-01-11 14:35:53.242043', false);
INSERT INTO ttrss_feeds VALUES (32, 1, 'Billboard.com', 16, 'http://billboard.feedsportal.com/34735/f/639534/index.rss', '', 0, 0, '2016-01-11 20:00:25.482406', '', NULL, 'http://www.billboard.com/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 22:09:35.56552', '2016-01-11 20:00:25.331026', 0, false, 17, false, false, false, '', 0, '2016-01-11 19:00:26.53933', false);
INSERT INTO ttrss_feeds VALUES (399, 1, 'The Charlotte Observer', 174, 'http://www.charlotteobserver.com/entertainment/index.rss', '', 0, 0, '2016-01-11 20:01:09.395297', '', NULL, 'http://www.charlotteobserver.com/122/index.rss', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:49:51.782985', '2016-01-11 20:01:09.387892', 0, false, 3, false, false, false, '', 0, '2015-06-10 19:05:11.910555', false);
INSERT INTO ttrss_feeds VALUES (804, 1, 'NCAA', 59, 'http://www.ncaa.com/news/lacrosse-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:01:44.150873', '', NULL, 'http://www.ncaa.com/news/lacrosse-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:20:45.079733', '2016-01-11 20:01:43.982416', 0, false, 35, false, false, false, '', 0, '2016-01-11 09:21:30.693992', false);
INSERT INTO ttrss_feeds VALUES (227, 1, 'NBC Southern California', 115, 'http://www.nbclosangeles.com/news/sports/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:10:16.231596', '', NULL, 'http://www.nbclosangeles.com/news/sports', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:55:19.686925', '2016-01-11 20:10:14.576167', 0, false, 5, false, false, false, '', 0, '2016-01-11 18:30:15.78141', false);
INSERT INTO ttrss_feeds VALUES (213, 1, 'NBC New York', 66, 'http://www.nbcnewyork.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:10:17.384233', '', NULL, 'http://www.nbcnewyork.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:56:26.789966', '2016-01-11 20:10:16.234909', 0, false, 1, false, false, false, '', 0, '2016-01-11 18:30:18.276035', false);
INSERT INTO ttrss_feeds VALUES (305, 1, 'The Dallas Sports Rant', 67, 'http://feeds.feedburner.com/DallasSportsRant?format=xml', '', 0, 0, '2016-01-11 20:10:17.581615', '', NULL, 'http://www.dallassportsrant.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-17 21:35:25.348837', '2016-01-11 20:10:17.388983', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:30:18.49887', false);
INSERT INTO ttrss_feeds VALUES (815, 1, 'Bizjournals', 26, 'http://feeds.bizjournals.com/industry_2', '', 0, 0, '2016-01-11 20:01:44.370352', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 20:06:37.175605', '2016-01-11 20:01:44.154576', 0, false, 0, false, false, false, '', 0, '2016-01-11 09:21:30.886877', false);
INSERT INTO ttrss_feeds VALUES (792, 1, 'SpeedwayMedia.com', 59, 'http://www.speedwaymedia.com/?feed=rss2&cat=56', '', 0, 0, '2016-01-11 19:55:44.506871', '', NULL, 'http://www.speedwaymedia.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 17:42:24.768772', '2016-01-11 20:15:01.959024', 0, false, 49, false, false, false, '', 0, '2016-01-11 18:15:50.39167', false);
INSERT INTO ttrss_feeds VALUES (295, 1, 'Pitchfork', 16, 'http://pitchfork.com/rss/news/', '', 0, 0, '2016-01-11 20:00:28.158098', '', NULL, 'http://pitchfork.com/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-05-28 22:02:14.082321', '2016-01-11 20:00:28.146444', 0, false, 19, false, false, false, '', 0, '2016-01-11 18:00:43.682011', false);
INSERT INTO ttrss_feeds VALUES (809, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d2/rss.xml', '', 0, 0, '2016-01-11 19:55:44.684415', '', NULL, 'http://www.ncaa.com/news/wrestling/d2/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-06-24 17:46:06.767176', '2016-01-11 20:15:01.959024', 0, false, 41, false, false, false, '', 0, '2016-01-11 15:36:38.06413', false);
INSERT INTO ttrss_feeds VALUES (1239, 1, 'NBA.com', 29, 'http://www.nba.com/rss/nba_rss.xml', '', 0, 0, '2016-01-11 20:00:28.323692', '', NULL, 'http://www.nba.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:03:46.852825', '2016-01-11 20:00:28.16228', 0, false, 1, false, false, false, '', 0, '2016-01-11 13:40:20.081586', false);
INSERT INTO ttrss_feeds VALUES (810, 1, 'NCAA', 59, 'http://www.ncaa.com/news/wrestling/d3/rss.xml', '', 0, 0, '2016-01-11 19:55:44.852221', '', NULL, 'http://www.ncaa.com/news/wrestling/d3/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-08-06 21:25:56.50827', '2016-01-11 20:15:01.959024', 0, false, 24, false, false, false, '', 0, '2016-01-11 15:36:38.250546', false);
INSERT INTO ttrss_feeds VALUES (816, 1, 'The Independent', 59, 'http://rss.feedsportal.com/c/266/f/3798/index.rss', '', 0, 0, '2016-01-11 19:55:44.928849', '', NULL, 'http://www.independent.co.uk/sport/motor-racing/?service=Rss', '', NULL, false, '', false, true, false, false, false, false, '2015-08-07 17:52:14.348342', '2016-01-11 20:15:01.959024', 0, false, 55, false, false, false, '', 0, '2016-01-11 14:35:48.067776', false);
INSERT INTO ttrss_feeds VALUES (813, 1, 'Bizjournals', 41, 'http://feeds.bizjournals.com/industry_24', '', 0, 0, '2016-01-11 19:55:45.218219', '', NULL, 'http://www.bizjournals.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-12 18:06:43.2776', '2016-01-11 20:15:01.959024', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:35:48.368258', false);
INSERT INTO ttrss_feeds VALUES (763, 1, 'NCAA', 29, 'http://www.ncaa.com/news/basketball-men/d1/rss.xml', '', 0, 0, '2016-01-11 20:00:28.606119', '', NULL, 'http://www.ncaa.com/news/basketball-men/d1/rss.xml', '', NULL, false, '', false, true, false, false, false, false, '2015-10-06 22:03:50.798796', '2016-01-11 20:00:28.32629', 0, false, 5, false, false, false, '', 0, '2016-01-11 20:00:28.571776', false);
INSERT INTO ttrss_feeds VALUES (667, 1, 'Ripley''s Amazing Humans', 52, 'http://www.ripleys.com/bions/humans/feed/', '', 0, 0, '2016-01-11 20:10:19.247713', '', NULL, 'http://www.ripleys.com', '', NULL, false, '', false, true, false, false, false, false, '2015-10-20 18:26:53.501148', '2016-01-11 20:10:18.122523', 0, false, 4, false, false, false, '', 0, '2016-01-11 14:10:21.225274', false);
INSERT INTO ttrss_feeds VALUES (640, 1, 'Reuters', 52, 'http://feeds.reuters.com/reuters/oddlyEnoughNews', '', 0, 0, '2016-01-11 20:10:19.559882', '', NULL, 'http://www.reuters.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:19.252828', 0, false, 7, false, false, false, '', 0, '2016-01-11 10:30:19.357796', false);
INSERT INTO ttrss_feeds VALUES (892, 1, 'StyleCaster', 18, 'http://stylecaster.com/feed/', '', 0, 0, '2016-01-11 20:00:28.666027', '', NULL, 'http://stylecaster.com', '', NULL, false, '', false, true, false, false, false, false, '2015-11-02 18:35:22.410618', '2016-01-11 20:00:28.609155', 0, false, 4, false, false, false, '', 0, '2016-01-11 20:00:28.618847', false);
INSERT INTO ttrss_feeds VALUES (642, 1, 'NME', 16, 'http://www.nme.com/rss/news', '', 0, 0, '2016-01-11 20:10:19.749532', '', NULL, 'http://www.nme.com/news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 23:22:41.41973', '2016-01-11 20:10:19.565861', 0, false, 11, false, false, false, '', 0, '2016-01-11 18:30:20.217324', false);
INSERT INTO ttrss_feeds VALUES (649, 1, 'Adweek', 14, 'http://feeds.adweek.com/adweek/advertising-branding', '', 0, 0, '2016-01-11 20:10:20.290797', '', NULL, 'http://www.adweek.com/adweek/feeds/11', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:19.754914', 0, false, 1, false, false, false, '', 0, '2016-01-11 19:10:19.579913', false);
INSERT INTO ttrss_feeds VALUES (31, 1, 'Hollywood Reporter', 10, 'http://feed.hollywoodreporter.com/LIVE_FEED', '', 0, 0, '2016-01-11 20:10:41.025693', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/72/0/feed', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 18:53:07.445314', '2016-01-11 20:10:40.815404', 0, false, 2, false, false, false, '', 0, '2016-01-11 09:50:41.09561', false);
INSERT INTO ttrss_feeds VALUES (906, 1, 'CNET', 39, 'http://www.cnet.com/rss/news/', '', 0, 0, '2016-01-11 20:10:42.356754', '', NULL, 'http://www.cnet.com/#ftag=CAD590a51e', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:41.02879', 0, false, 2, false, false, false, '', 0, '2016-01-11 14:30:40.167982', false);
INSERT INTO ttrss_feeds VALUES (563, 1, 'Discover', 41, 'http://feeds.feedburner.com/DiscoverEnvironment?format=xml', '', 0, 0, '2016-01-11 20:10:42.55028', '', NULL, 'http://discovermagazine.com/rss/topic-feeds/environment', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 22:19:09.247543', '2016-01-11 20:10:42.359296', 0, false, 13, false, false, false, '', 0, '2016-01-11 18:30:45.368898', false);
INSERT INTO ttrss_feeds VALUES (261, 1, 'NBC Philadelphia', 100, 'http://www.nbcphiladelphia.com/entertainment/entertainment-news/?rss=y&embedThumb=y&summary=y', '', 0, 0, '2016-01-11 20:10:43.778771', '', NULL, 'http://www.nbcphiladelphia.com/entertainment/entertainment-news', '', NULL, false, '', false, true, false, false, false, false, '2015-06-03 21:39:12.40591', '2016-01-11 20:10:42.625603', 0, false, 0, false, false, false, '', 0, '2016-01-11 18:30:47.259933', false);
INSERT INTO ttrss_feeds VALUES (133, 1, 'BBC', 41, 'http://feeds.bbci.co.uk/news/science_and_environment/rss.xml?edition=uk', '', 0, 0, '2016-01-11 20:10:43.974187', '', NULL, 'http://www.bbc.co.uk/news/science_and_environment/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 19:21:38.974538', '2016-01-11 20:10:43.781848', 0, false, 0, false, false, false, '', 0, '2016-01-11 16:52:07.270946', false);
INSERT INTO ttrss_feeds VALUES (1187, 1, 'Tucson Weekly', 207, 'http://www.tucsonweekly.com/tucson/Rss.xml', '', 0, 0, '2016-01-11 20:10:51.46347', '', NULL, 'http://www.tucsonweekly.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:41.601197', '2016-01-11 20:10:51.302703', 0, false, 4, false, false, false, '', 0, '2016-01-11 14:50:53.245492', false);
INSERT INTO ttrss_feeds VALUES (127, 1, 'FOX', 40, 'http://feeds.foxnews.com/FOXNEWS/HEALTH', '', 0, 0, '2016-01-11 20:10:48.692652', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:48.300404', 0, false, 15, false, false, false, '', 0, '2016-01-11 18:50:51.8889', false);
INSERT INTO ttrss_feeds VALUES (1209, 1, 'Mesa Independent', 210, 'http://feeds.feedblitz.com/mesaindependent', '', 0, 0, '2016-01-11 20:10:49.461144', '', NULL, 'http://mesaindependent.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:08.02682', '2016-01-11 20:10:48.695473', 0, false, 1, false, false, false, '', 0, '2016-01-11 16:52:13.640904', false);
INSERT INTO ttrss_feeds VALUES (1210, 1, 'AZCentral', 210, 'http://rssfeeds.azcentral.com/phoenix/mesa', '', 0, 0, '2016-01-11 20:10:50.190173', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:09.912994', '2016-01-11 20:10:49.463916', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:10:54.71211', false);
INSERT INTO ttrss_feeds VALUES (1199, 1, 'Long Beach Press Telegram', 209, 'http://www.presstelegram.com/section?template=RSS&profile=4000254&mime=xml', '', 0, 0, '2016-01-11 20:10:50.236384', '', NULL, 'http://www.presstelegram.com', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:17.188189', '2016-01-11 20:10:50.192958', 0, false, 3, false, false, false, '', 0, '2016-01-11 17:10:55.012078', false);
INSERT INTO ttrss_feeds VALUES (128, 1, 'ABC News', 40, 'http://feeds.abcnews.com/ABCNEWS/HEALTHHEADLINES', '', 0, 0, '2016-01-11 20:10:50.638331', '', NULL, 'http://abcnews.go.com/Health/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-18 22:25:20.164787', '2016-01-11 20:10:50.239532', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:10:55.277604', false);
INSERT INTO ttrss_feeds VALUES (1193, 1, 'KMPH Fox 26', 208, 'http://www.kmph-kfre.com/Global/category.asp?C=109555&clienttype=rss', '', 0, 0, '2016-01-11 20:10:51.047716', 'HTTP Code: 404', NULL, 'http://www.kmph-kfre.com/category/109555/local-news', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:29.46133', '2016-01-11 20:10:50.64458', 0, false, 2, false, false, false, '', 0, '2015-10-15 12:45:28.797059', false);
INSERT INTO ttrss_feeds VALUES (1198, 1, 'ABC 30 – Central Valley News', 208, 'http://cdn.abclocal.go.com/kfsn/xml?id=7110337', '', 0, 0, '2016-01-11 20:10:51.297813', '', NULL, 'http://abclocal.go.com/kfsn/channel?section=news/local&id=7110337', '', NULL, false, '', false, true, false, false, false, false, '2015-09-28 21:37:34.730132', '2016-01-11 20:10:51.054577', 0, false, 0, false, false, false, '', 0, '2016-01-11 17:10:56.262098', false);
INSERT INTO ttrss_feeds VALUES (358, 1, 'BET', 40, 'http://feeds.bet.com/BETcom-Health', '', 0, 0, '2016-01-11 20:11:21.344049', 'HTTP Code: 404', NULL, 'http://www.bet.com?cid=rss', '', NULL, false, '', false, true, false, false, false, false, '2016-01-06 22:54:39.526077', '2016-01-11 20:11:21.118018', 0, false, 13, false, false, false, '', 0, '2015-11-17 00:01:03.063848', false);
INSERT INTO ttrss_feeds VALUES (139, 1, 'HuffPost', 41, 'http://www.huffingtonpost.com/feeds/verticals/science/index.xml', '', 0, 0, '2016-01-11 20:10:59.913299', '', NULL, 'http://www.huffingtonpost.com/science/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:59.188904', 0, false, 24, false, false, false, '', 0, '2016-01-11 18:31:05.155027', false);
INSERT INTO ttrss_feeds VALUES (140, 1, 'WIRED', 41, 'http://www.wired.com/category/science/feed/', '', 0, 0, '2016-01-11 20:11:00.18218', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2016-01-11 20:10:59.91605', 0, false, 29, false, false, false, '', 0, '2016-01-11 17:31:45.44734', false);
INSERT INTO ttrss_feeds VALUES (546, 1, 'Beliefnet', 49, 'http://www.beliefnet.com/Feeds/All.aspx', '', 0, 0, '2016-01-11 20:11:00.333032', '', NULL, 'http://www.beliefnet.com/Feeds/All.aspx', '', NULL, false, '', false, true, false, false, false, false, '2015-06-16 22:54:21.87298', '2016-01-11 20:11:00.185281', 0, false, 0, false, false, false, '', 0, '2016-01-11 12:10:55.159322', false);
INSERT INTO ttrss_feeds VALUES (136, 1, 'NYT', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Space.xml', '', 0, 0, '2016-01-11 20:11:00.406306', '', NULL, 'http://www.nytimes.com/pages/science/space/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:46:17.958581', '2016-01-11 20:11:00.335544', 0, false, 22, false, false, false, '', 0, '2016-01-11 17:11:01.911839', false);
INSERT INTO ttrss_feeds VALUES (891, 1, 'HuffPost', 38, 'http://www.huffingtonpost.com/feeds/verticals/business/news.xml', '', 0, 0, '2016-01-11 20:11:00.532617', '', NULL, 'http://www.huffingtonpost.com/business/', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 22:38:21.946012', '2016-01-11 20:11:00.409527', 0, false, 1, false, false, false, '', 0, '2016-01-11 17:11:02.012642', false);
INSERT INTO ttrss_feeds VALUES (894, 1, 'WSJ', 39, 'http://www.wsj.com/xml/rss/3_7455.xml', '', 0, 0, '2016-01-11 20:11:00.702223', '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, '2015-06-23 17:43:18.903512', '2016-01-11 20:11:00.535684', 0, false, 4, false, false, false, '', 0, '2016-01-11 18:10:54.661539', false);


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

INSERT INTO ttrss_version VALUES (127);


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


