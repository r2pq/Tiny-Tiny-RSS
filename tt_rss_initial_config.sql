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

INSERT INTO ttrss_feed_categories VALUES (8, 1, false, 0, '', 4, 'Celebrity');
INSERT INTO ttrss_feed_categories VALUES (9, 1, false, 1, '', 4, 'Movies');
INSERT INTO ttrss_feed_categories VALUES (10, 1, false, 2, '', 4, 'TV');
INSERT INTO ttrss_feed_categories VALUES (46, 1, false, 1, '', 3, 'Horoscope');
INSERT INTO ttrss_feed_categories VALUES (48, 1, false, 3, '', 3, 'Feel Good');
INSERT INTO ttrss_feed_categories VALUES (50, 1, false, 5, '', 3, 'Rumor/Scandal');
INSERT INTO ttrss_feed_categories VALUES (52, 1, false, 7, '', 3, 'Weird');
INSERT INTO ttrss_feed_categories VALUES (54, 1, false, 9, '', 3, 'Staff Picks');
INSERT INTO ttrss_feed_categories VALUES (27, 1, false, 0, '', 2, 'Football');
INSERT INTO ttrss_feed_categories VALUES (29, 1, false, 2, '', 2, 'Basketball');
INSERT INTO ttrss_feed_categories VALUES (31, 1, false, 4, '', 2, 'Tennis');
INSERT INTO ttrss_feed_categories VALUES (33, 1, false, 6, '', 2, 'Winter Sports');
INSERT INTO ttrss_feed_categories VALUES (35, 1, false, 8, '', 2, 'Cricket');
INSERT INTO ttrss_feed_categories VALUES (36, 1, false, 1, '', 5, 'World');
INSERT INTO ttrss_feed_categories VALUES (38, 1, false, 3, '', 5, 'Business');
INSERT INTO ttrss_feed_categories VALUES (40, 1, false, 5, '', 5, 'Health');
INSERT INTO ttrss_feed_categories VALUES (42, 1, false, 7, '', 5, 'Environment');
INSERT INTO ttrss_feed_categories VALUES (44, 1, false, 9, '', 5, 'Polls');
INSERT INTO ttrss_feed_categories VALUES (16, 1, false, 3, '', 4, 'Music');
INSERT INTO ttrss_feed_categories VALUES (11, 1, false, 4, '', 4, 'Humor');
INSERT INTO ttrss_feed_categories VALUES (12, 1, false, 5, '', 4, 'Gaming');
INSERT INTO ttrss_feed_categories VALUES (13, 1, false, 6, '', 4, 'Viral');
INSERT INTO ttrss_feed_categories VALUES (14, 1, false, 7, '', 4, 'Cool Ads');
INSERT INTO ttrss_feed_categories VALUES (15, 1, false, 8, '', 4, 'Trailers');
INSERT INTO ttrss_feed_categories VALUES (4, 1, false, 0, '', NULL, 'entertainment');
INSERT INTO ttrss_feed_categories VALUES (45, 1, false, 0, '', 3, 'Today in History');
INSERT INTO ttrss_feed_categories VALUES (47, 1, false, 2, '', 3, 'Quote of the Day');
INSERT INTO ttrss_feed_categories VALUES (49, 1, false, 4, '', 3, 'Religion');
INSERT INTO ttrss_feed_categories VALUES (51, 1, false, 6, '', 3, 'Hobbies');
INSERT INTO ttrss_feed_categories VALUES (53, 1, false, 8, '', 3, 'Discovery');
INSERT INTO ttrss_feed_categories VALUES (3, 1, false, 1, '', NULL, 'extra');
INSERT INTO ttrss_feed_categories VALUES (17, 1, false, 0, '', 1, 'Electronics');
INSERT INTO ttrss_feed_categories VALUES (18, 1, false, 1, '', 1, 'Fashion');
INSERT INTO ttrss_feed_categories VALUES (19, 1, false, 2, '', 1, 'Fitness');
INSERT INTO ttrss_feed_categories VALUES (20, 1, false, 3, '', 1, 'Food & Drink');
INSERT INTO ttrss_feed_categories VALUES (21, 1, false, 4, '', 1, 'Design');
INSERT INTO ttrss_feed_categories VALUES (22, 1, false, 5, '', 1, 'Autos');
INSERT INTO ttrss_feed_categories VALUES (23, 1, false, 6, '', 1, 'Travel');
INSERT INTO ttrss_feed_categories VALUES (24, 1, false, 7, '', 1, 'Games');
INSERT INTO ttrss_feed_categories VALUES (25, 1, false, 8, '', 1, 'Books');
INSERT INTO ttrss_feed_categories VALUES (26, 1, false, 9, '', 1, 'Finance');
INSERT INTO ttrss_feed_categories VALUES (1, 1, false, 2, '', NULL, 'products');
INSERT INTO ttrss_feed_categories VALUES (28, 1, false, 1, '', 2, 'Baseball');
INSERT INTO ttrss_feed_categories VALUES (30, 1, false, 3, '', 2, 'Hockey');
INSERT INTO ttrss_feed_categories VALUES (32, 1, false, 5, '', 2, 'Golf');
INSERT INTO ttrss_feed_categories VALUES (34, 1, false, 7, '', 2, 'Soccer');
INSERT INTO ttrss_feed_categories VALUES (2, 1, false, 3, '', NULL, 'sports');
INSERT INTO ttrss_feed_categories VALUES (7, 1, false, 0, '', 5, 'US');
INSERT INTO ttrss_feed_categories VALUES (37, 1, false, 2, '', 5, 'Politics');
INSERT INTO ttrss_feed_categories VALUES (39, 1, false, 4, '', 5, 'Tech');
INSERT INTO ttrss_feed_categories VALUES (41, 1, false, 6, '', 5, 'Science');
INSERT INTO ttrss_feed_categories VALUES (43, 1, false, 8, '', 5, 'Media');
INSERT INTO ttrss_feed_categories VALUES (5, 1, false, 4, '', NULL, 'topstories');


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

INSERT INTO ttrss_feeds VALUES (124, 1, 'BBC News - Technology', 39, 'http://feeds.bbci.co.uk/news/technology/rss.xml?edition=uk', '', 0, 0, '2015-04-28 22:16:01.845447', '', NULL, 'http://www.bbc.co.uk/news/technology/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, '2015-04-25 17:05:52.690973', '2015-04-28 22:16:01.548676', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:23.892691', false);
INSERT INTO ttrss_feeds VALUES (105, 1, 'CNN.com - Top Stories', 37, 'http://rss.cnn.com/RSS/CNN_TOPSTORIES.RSS', '', 0, 0, '2015-04-28 22:16:51.518838', '', NULL, 'http://www.cnn.com/index.html?eref=rss_topstories', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.23099', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:28.320629', false);
INSERT INTO ttrss_feeds VALUES (181, 1, 'BBC Sport - Golf', 32, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/golf/rss.xml', '', 0, 0, '2015-04-28 22:17:07.484761', '', NULL, 'http://www.bbc.co.uk/sport/0/golf/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:07.198949', 0, false, 0, false, false, false, '', 0, '2015-04-28 14:49:16.208051', false);
INSERT INTO ttrss_feeds VALUES (62, 1, 'Tech2', 17, 'http://tech2.in.com/rssfeed/news.xml', '', 0, 0, '2015-04-28 22:16:03.523524', '', NULL, 'http://tech.firstpost.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:01.848354', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:41:25.352425', false);
INSERT INTO ttrss_feeds VALUES (118, 1, 'NBC News Business', 38, 'http://feeds.nbcnews.com/feeds/business', '', 0, 0, '2015-04-28 22:16:52.583611', '', NULL, 'http://www.nbcnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.486199', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:30.766121', false);
INSERT INTO ttrss_feeds VALUES (19, 1, 'L.A. Times - Movie News', 9, 'http://feeds.latimes.com/LATIMES/ENTERTAINMENT/NEWS/MOVIES/', '', 0, 0, '2015-04-28 22:16:08.328665', '', NULL, 'http://www.latimes.com/entertainment/movies/?track=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.237679', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:41:31.342912', false);
INSERT INTO ttrss_feeds VALUES (127, 1, 'FOX News', 40, 'http://feeds.foxnews.com/FOXNEWS/HEALTH', '', 0, 0, '2015-04-28 22:16:53.706632', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:53.616348', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:32.538523', false);
INSERT INTO ttrss_feeds VALUES (26, 1, 'Screen Rant', 9, 'http://screenrant.com/feed/', '', 0, 0, '2015-04-28 22:16:09.889207', '', NULL, 'http://screenrant.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:09.574396', 0, false, 7, false, false, false, '', 0, '2015-04-28 12:41:34.567102', false);
INSERT INTO ttrss_feeds VALUES (183, 1, 'FOX Sports Digital', 32, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', 0, 0, '2015-04-28 22:17:07.863175', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=golf', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:07.747949', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:11.076286', false);
INSERT INTO ttrss_feeds VALUES (28, 1, 'All Content', 9, 'http://www.rogerebert.com/feed', '', 0, 0, '2015-04-28 22:16:11.019608', '', NULL, 'http://www.rogerebert.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:10.812172', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:36.146243', false);
INSERT INTO ttrss_feeds VALUES (128, 1, 'ABC News: Health', 40, 'http://feeds.abcnews.com/ABCNEWS/HEALTHHEADLINES', '', 0, 0, '2015-04-28 22:16:54.172139', '', NULL, 'http://abcnews.go.com/Health/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:53.709303', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:33.132231', false);
INSERT INTO ttrss_feeds VALUES (53, 1, 'Fads & Ads', 14, 'http://blog.tartanlabs.com/rss', '', 0, 0, '2015-04-28 22:16:41.652641', '', NULL, 'http://blog.tartanlabs.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:41.522914', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:11.085669', false);
INSERT INTO ttrss_feeds VALUES (153, 1, 'ESPN.com - NFL', 27, 'http://sports.espn.go.com/espn/rss/nfl/news', '', 0, 0, '2015-04-28 22:17:02.596419', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:02.19944', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:52.68997', false);
INSERT INTO ttrss_feeds VALUES (187, 1, 'The Ski Channel', 33, 'http://www.theskichannel.com/feed/', '', 0, 0, '2015-04-28 22:17:10.295921', '', NULL, 'http://www.theskichannel.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:09.025604', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:19.829687', false);
INSERT INTO ttrss_feeds VALUES (99, 1, 'CNN.com Recently Published/Updated', 36, 'http://rss.cnn.com/rss/cnn_latest.rss', '', 0, 0, '2015-04-28 22:16:50.403678', '', NULL, 'http://www.cnn.com/?eref=rss_latest', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:50.164031', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:26.34087', false);
INSERT INTO ttrss_feeds VALUES (103, 1, 'Al Jazeera English', 36, 'http://www.aljazeera.com/xml/rss/all.xml', '', 0, 0, '2015-04-28 22:16:50.903066', '', NULL, 'http://www.aljazeera.com/default.html', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:50.727415', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:27.685938', false);
INSERT INTO ttrss_feeds VALUES (6, 1, 'NYT > U.S.', 7, 'http://www.nytimes.com/services/xml/rss/nyt/US.xml', '', 0, 0, '2015-04-28 22:16:06.561196', '', NULL, 'http://www.nytimes.com/pages/national/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:06.388688', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:41:28.740265', false);
INSERT INTO ttrss_feeds VALUES (22, 1, 'Awards', 9, 'http://feeds.feedburner.com/THR/AWARDS', '', 0, 0, '2015-04-28 22:16:08.804617', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/7739/all/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.631538', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:33.135942', false);
INSERT INTO ttrss_feeds VALUES (184, 1, 'Golf News : CBSSports.com', 32, 'http://www.cbssports.com/partners/feeds/rss/golf_news', '', 0, 0, '2015-04-28 22:17:07.930825', '', NULL, 'http://www.cbssports.com/golf', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:07.865521', 0, false, 0, false, false, false, '', 0, '2015-04-27 23:04:49.144595', false);
INSERT INTO ttrss_feeds VALUES (24, 1, 'Film | The Guardian', 9, 'http://www.theguardian.com/film/rss', '', 0, 0, '2015-04-28 22:16:09.444598', '', NULL, 'http://www.theguardian.com/film', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.96679', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:33.618105', false);
INSERT INTO ttrss_feeds VALUES (25, 1, 'The Race', 9, 'http://feeds.feedburner.com/HOLLYWOODREPORTER-THERACE?FORMAT=XML', '', 0, 0, '2015-04-28 22:16:09.569777', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/76/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:09.449561', 0, false, 8, false, false, false, '', 0, '2015-04-28 12:41:34.204404', false);
INSERT INTO ttrss_feeds VALUES (78, 1, 'Edmunds.com Reviews and Articles', 22, 'http://www.edmunds.com/feeds/rss/articles.xml', '', 0, 0, '2015-04-28 22:16:42.349889', '', NULL, 'http://www.edmunds.com/feeds/rss/articles.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:41.971194', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:11.652887', false);
INSERT INTO ttrss_feeds VALUES (85, 1, 'CNN.com - Travel', 23, 'http://rss.cnn.com/RSS/CNN_TRAVEL.RSS', '', 0, 0, '2015-04-28 22:16:45.32598', '', NULL, 'http://www.cnn.com/TRAVEL/index.html?eref=rss_travel', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:44.94671', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:15.597234', false);
INSERT INTO ttrss_feeds VALUES (137, 1, 'NYT > Environment', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Environment.xml', '', 0, 0, '2015-04-28 22:16:57.382853', '', NULL, 'http://www.nytimes.com/pages/science/earth/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.241017', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:36.396129', false);
INSERT INTO ttrss_feeds VALUES (150, 1, 'Bleacher Report - Front Page', 27, 'http://bleacherreport.com/articles/feed', '', 0, 0, '2015-04-28 22:17:02.012622', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:01.703154', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:51.823014', false);
INSERT INTO ttrss_feeds VALUES (64, 1, 'News', 17, 'http://www.electronicsweekly.com/news/feed/', '', 0, 0, '2015-04-28 22:16:04.281205', '', NULL, 'http://www.electronicsweekly.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:03.853619', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:41:26.184479', false);
INSERT INTO ttrss_feeds VALUES (8, 1, 'People', 8, 'http://feeds.people.com/people/headlines', '', 0, 0, '2015-04-28 22:16:04.841662', '', NULL, 'http://www.people.com/news', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:04.723338', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:41:26.767207', false);
INSERT INTO ttrss_feeds VALUES (11, 1, 'EW.com: Latest Movies', 8, 'http://rss.ew.com/web/ew/rss/media/movies/index.xml', '', 0, 0, '2015-04-28 22:16:05.375153', '', NULL, 'http://www.ew.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:05.187532', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:41:27.507393', false);
INSERT INTO ttrss_feeds VALUES (59, 1, 'Engadget RSS Feed', 17, 'http://www.engadget.com/tag/mobile/rss.xml', '', 0, 0, '2015-04-28 22:16:38.330432', '', NULL, 'http://www.engadget.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:21.630511', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:07.146081', false);
INSERT INTO ttrss_feeds VALUES (15, 1, 'Dlisted', 8, 'http://dlisted.com/feed/rdf/', '', 0, 0, '2015-04-28 22:16:07.810221', '', NULL, 'http://dlisted.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:07.005551', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:29.616843', false);
INSERT INTO ttrss_feeds VALUES (27, 1, '#MovieTrailers | ExtraTV.com', 9, 'http://www.extratv.com/feeds/category/movie-trailers/rss.xml', '', 0, 0, '2015-04-28 22:16:10.808315', '', NULL, 'http://extratv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:09.893373', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:41:35.717897', false);
INSERT INTO ttrss_feeds VALUES (86, 1, 'BudgetTravel.com Features', 23, 'http://www.budgettravel.com/latest/features/feed/', '', 0, 0, '2015-04-28 22:16:46.305106', '', NULL, 'http://www.budgettravel.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:45.330684', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:16.160625', false);
INSERT INTO ttrss_feeds VALUES (158, 1, 'FOX Sports Digital', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', 0, 0, '2015-04-28 22:17:03.250665', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=cfb', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:03.204852', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:42:54.539339', false);
INSERT INTO ttrss_feeds VALUES (31, 1, 'Live Feed', 10, 'http://feed.hollywoodreporter.com/LIVE_FEED', '', 0, 0, '2015-04-28 22:16:11.603304', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/72/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.4252', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:39.013306', false);
INSERT INTO ttrss_feeds VALUES (94, 1, 'FOXNews.com', 7, 'http://feeds.foxnews.com/foxnews/latest', '', 0, 0, '2015-04-28 22:16:49.35494', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:49.181769', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:24.69518', false);
INSERT INTO ttrss_feeds VALUES (65, 1, 'Books', 25, 'http://www.npr.org/rss/rss.php?id=1032', '', 0, 0, '2015-04-28 22:16:11.969519', '', NULL, 'http://www.npr.org/templates/story/story.php?storyId=1032', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.800257', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:39.651585', false);
INSERT INTO ttrss_feeds VALUES (35, 1, 'BuzzFeed  - Latest', 11, 'http://WWW.BUZZFEED.COM/INDEX.XML', '', 0, 0, '2015-04-28 22:16:15.012612', '', NULL, 'http://www.buzzfeed.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:13.996568', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:42.633039', false);
INSERT INTO ttrss_feeds VALUES (100, 1, 'FOX News', 36, 'http://feeds.foxnews.com/foxnews/world', '', 0, 0, '2015-04-28 22:16:50.502202', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:50.406484', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:26.575601', false);
INSERT INTO ttrss_feeds VALUES (164, 1, 'USATODAY - MLB Top Stories', 28, 'http://rssfeeds.usatoday.com/UsatodaycomMlb-TopStories', '', 0, 0, '2015-04-28 22:17:04.5369', '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.365283', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:57.073502', false);
INSERT INTO ttrss_feeds VALUES (54, 1, 'NYT > Fashion & Style', 18, 'http://rss.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml', '', 0, 0, '2015-04-28 22:16:18.553719', '', NULL, 'http://www.nytimes.com/pages/fashion/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:18.477017', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:46.86031', false);
INSERT INTO ttrss_feeds VALUES (119, 1, 'TechCrunch', 39, 'http://feeds.feedburner.com/TechCrunch/', '', 0, 0, '2015-04-28 22:16:52.731921', '', NULL, 'http://techcrunch.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.586326', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:30.88079', false);
INSERT INTO ttrss_feeds VALUES (55, 1, 'Telegraph Fashion - Home Page', 18, 'http://fashion.telegraph.co.uk/RSS/', '', 0, 0, '2015-04-28 22:16:18.851734', '', NULL, 'http://fashion.telegraph.co.uk/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:18.556816', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:47.165557', false);
INSERT INTO ttrss_feeds VALUES (182, 1, 'USATODAY - Golf Top Stories', 32, 'http://rssfeeds.usatoday.com/UsatodaycomGolf-TopStories', '', 0, 0, '2015-04-28 22:17:07.745483', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:07.487749', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:10.576996', false);
INSERT INTO ttrss_feeds VALUES (133, 1, 'BBC News - Science & Environment', 41, 'http://feeds.bbci.co.uk/news/science_and_environment/rss.xml?edition=uk', '', 0, 0, '2015-04-28 22:16:56.926516', '', NULL, 'http://www.bbc.co.uk/news/science_and_environment/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:56.738595', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:35.967756', false);
INSERT INTO ttrss_feeds VALUES (106, 1, 'Post Politics: Breaking Politics News, Political Analysis & More - The Washington Post', 37, 'http://feeds.washingtonpost.com/rss/politics', '', 0, 0, '2015-04-28 22:16:51.600333', '', NULL, 'http://www.washingtonpost.com/politics?wprss=rss_politics', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.52257', 0, false, 7, false, false, false, '', 0, '2015-04-28 12:42:28.639779', false);
INSERT INTO ttrss_feeds VALUES (161, 1, 'ESPN.com - MLB', 28, 'http://sports.espn.go.com/espn/rss/mlb/news', '', 0, 0, '2015-04-28 22:17:04.244694', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.065508', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:55.719998', false);
INSERT INTO ttrss_feeds VALUES (5, 1, 'CNN.com - Top Stories', 7, 'http://rss.cnn.com/rss/cnn_topstories.rss', '', 0, 0, '2015-04-28 22:16:06.385349', '', NULL, 'http://www.cnn.com/index.html?eref=rss_topstories', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:06.100455', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:41:28.370826', false);
INSERT INTO ttrss_feeds VALUES (148, 1, 'FiveThirtyEight » Nate Silver | FiveThirtyEight', 44, 'http://fivethirtyeight.com/contributors/nate-silver/feed/', '', 0, 0, '2015-04-28 22:16:59.507971', '', NULL, 'http://fivethirtyeight.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:59.37531', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:48.653447', false);
INSERT INTO ttrss_feeds VALUES (32, 1, 'Billboard.com Music News', 16, 'http://billboard.feedsportal.com/34735/f/639534/index.rss', '', 0, 0, '2015-04-28 22:16:11.68523', '', NULL, 'http://www.billboard.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.607504', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:39.19061', false);
INSERT INTO ttrss_feeds VALUES (154, 1, 'ESPN.com - NCF', 27, 'http://sports.espn.go.com/espn/rss/ncf/news', '', 0, 0, '2015-04-28 22:17:02.791056', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:02.598808', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:52.897019', false);
INSERT INTO ttrss_feeds VALUES (155, 1, 'NFL Football News : CBSSports.com', 27, 'http://www.cbssports.com/partners/feeds/rss/nfl_news', '', 0, 0, '2015-04-28 22:17:03.016669', '', NULL, 'http://www.cbssports.com/nfl', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:02.793539', 0, false, 8, false, false, false, '', 0, '2015-04-28 12:42:53.092849', false);
INSERT INTO ttrss_feeds VALUES (67, 1, 'Books and Author Interviews', 25, 'http://www.telegraph.co.uk/CULTURE/BOOKS/RSS', '', 0, 0, '2015-04-28 22:16:12.112283', '', NULL, 'http://www.telegraph.co.uk/culture/books/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:12.066314', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:40.126914', false);
INSERT INTO ttrss_feeds VALUES (69, 1, 'Epicurious.com: Editor''s Blog', 20, 'http://FEEDS.FEEDBURNER.COM/EPICURIOUS/EPIBLOG?FORMAT=XML', '', 0, 0, '2015-04-28 22:16:12.347589', '', NULL, 'http://www.epicurious.com/features/blogs/editor/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:12.251225', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:40.30436', false);
INSERT INTO ttrss_feeds VALUES (37, 1, 'Comedy.co.uk - British Comedy News', 11, 'http://feeds.feedburner.com/BRITISHCOMEDYNEWS', '', 0, 0, '2015-04-28 22:16:15.30223', '', NULL, 'http://www.comedy.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.176766', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:43.299585', false);
INSERT INTO ttrss_feeds VALUES (41, 1, 'GamesRadar - Updates', 12, 'http://www.gamesradar.com/all-platforms/news/rss', '', 0, 0, '2015-04-28 22:16:17.359205', '', NULL, 'http://www.gamesradar.com/all-platforms/news/rss/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:16.995124', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:45.367493', false);
INSERT INTO ttrss_feeds VALUES (47, 1, 'Viral Viral Videos', 13, 'http://feeds.feedburner.com/viralviralvideos', '', 0, 0, '2015-04-28 22:16:19.388614', '', NULL, 'http://www.viralviralvideos.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:19.356143', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:47.900811', false);
INSERT INTO ttrss_feeds VALUES (104, 1, 'CNN.com - Politics', 37, 'http://rss.cnn.com/RSS/CNN_ALLPOLITICS.RSS', '', 0, 0, '2015-04-28 22:16:51.228279', '', NULL, 'http://www.cnn.com/POLITICS/index.html?eref=rss_politics', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:50.905674', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:27.861392', false);
INSERT INTO ttrss_feeds VALUES (3, 1, 'CNN.com Recently', 7, 'http://rss.cnn.com/RSS/CNN_LATEST.RSS', '', 0, 0, '2015-04-28 22:16:05.697229', '', NULL, 'http://www.cnn.com/?eref=rss_latest', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:05.38333', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:27.701635', false);
INSERT INTO ttrss_feeds VALUES (16, 1, 'POPSUGAR Celebrity', 8, 'http://feeds.feedburner.com/popsugar', '', 0, 0, '2015-04-28 22:16:07.930214', '', NULL, 'http://www.popsugar.com/celebrity', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:07.815253', 0, false, 8, false, false, false, '', 0, '2015-04-28 12:41:29.741392', false);
INSERT INTO ttrss_feeds VALUES (29, 1, 'FOX News', 16, 'http://feeds.foxnews.com/FOXNEWS/ENTERTAINMENT', '', 0, 0, '2015-04-28 22:16:11.175664', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.025037', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:36.263369', false);
INSERT INTO ttrss_feeds VALUES (167, 1, 'ESPN.com - NCB', 29, 'http://sports.espn.go.com/espn/rss/ncb/news', '', 0, 0, '2015-04-28 22:17:05.033289', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.864839', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:58.277655', false);
INSERT INTO ttrss_feeds VALUES (30, 1, 'TVGuide.com: Breaking News', 10, 'http://rss.tvguide.com/BREAKINGNEWS', '', 0, 0, '2015-04-28 22:16:11.420539', '', NULL, 'http://www.tvguide.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.17981', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:36.825877', false);
INSERT INTO ttrss_feeds VALUES (178, 1, 'USATODAY - Tennis Top Stories', 31, 'http://rssfeeds.usatoday.com/UsatodayTennis-TopStories', '', 0, 0, '2015-04-28 22:17:06.611595', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.361464', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:08.182812', false);
INSERT INTO ttrss_feeds VALUES (33, 1, 'RollingStone.com: Music', 16, 'http://www.rollingstone.com/music.rss', '', 0, 0, '2015-04-28 22:16:11.797469', '', NULL, 'http://www.rollingstone.com/music', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.687848', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:39.477991', false);
INSERT INTO ttrss_feeds VALUES (57, 1, 'The GQ Eye: GQ on Style', 18, 'http://www.gq.com/style/blogs/the-gq-eye/rss.xml', '', 0, 0, '2015-04-28 22:16:19.52464', '', NULL, 'http://www.gq.com/style/blogs/the-gq-eye/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:19.394163', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:48.212213', false);
INSERT INTO ttrss_feeds VALUES (58, 1, 'Engadget RSS Feed', 17, '//www.engadget.com/rss.xml', '', 0, 0, '2015-04-28 22:16:19.693532', '', NULL, 'http://www.engadget.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:19.52933', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:48.325505', false);
INSERT INTO ttrss_feeds VALUES (76, 1, 'The Verge -  All Posts', 21, 'http://www.theverge.com/rss/frontpage', '', 0, 0, '2015-04-28 22:16:41.742791', '', NULL, 'http://www.theverge.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:41.656073', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:11.151537', false);
INSERT INTO ttrss_feeds VALUES (83, 1, 'Muscle & Fitness', 19, 'http://www.muscleandfitness.com/RSS.XML', '', 0, 0, '2015-04-28 22:16:44.820041', '', NULL, 'http://www.muscleandfitness.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:44.609729', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:15.288772', false);
INSERT INTO ttrss_feeds VALUES (90, 1, 'gamesTM - Official Website » News', 24, 'http://www.gamestm.co.uk/category/news/feed/', '', 0, 0, '2015-04-28 22:16:48.342782', '', NULL, 'http://www.gamestm.co.uk', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:46.969171', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:23.62278', false);
INSERT INTO ttrss_feeds VALUES (7, 1, 'TMZ', 8, 'http://www.tmz.com/RSS.XML', '', 0, 0, '2015-04-28 22:16:04.719401', '', NULL, 'http://www.tmz.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:04.283845', 0, false, 10, false, false, false, '', 0, '2015-04-28 12:41:26.599687', false);
INSERT INTO ttrss_feeds VALUES (93, 1, 'U.S. News - Money', 26, 'http://www.usnews.com/rss/money?int=a48e09', '', 0, 0, '2015-04-28 22:16:49.178521', '', NULL, 'http://money.usnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:48.755346', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:24.287604', false);
INSERT INTO ttrss_feeds VALUES (4, 1, 'CNN.com - U.S.', 7, 'http://rss.cnn.com/rss/cnn_us.rss', '', 0, 0, '2015-04-28 22:16:06.095262', '', NULL, 'http://www.cnn.com/US/index.html?eref=rss_us', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:05.700877', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:41:28.065233', false);
INSERT INTO ttrss_feeds VALUES (95, 1, 'National: Breaking National News & Headlines - Washington Post', 7, 'http://feeds.washingtonpost.com/rss/national', '', 0, 0, '2015-04-28 22:16:49.417948', '', NULL, 'http://www.washingtonpost.com/2010/07/08/ABBw3vC_page.html?wprss=rss_national', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:49.35777', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:25.011613', false);
INSERT INTO ttrss_feeds VALUES (12, 1, 'PerezHilton', 8, 'http://i.perezhilton.com/?feed=rss2', '', 0, 0, '2015-04-28 22:16:06.815685', '', NULL, 'http://perezhilton.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:06.565462', 0, false, 7, false, false, false, '', 0, '2015-04-28 12:41:29.157281', false);
INSERT INTO ttrss_feeds VALUES (151, 1, 'Bleacher Report -', 27, 'http://bleacherreport.com/articles/feed?tag_id=22188', '', 0, 0, '2015-04-28 22:17:02.061829', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:02.015582', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:52.213985', false);
INSERT INTO ttrss_feeds VALUES (17, 1, 'Hello', 8, 'http://www.hellomagazine.com/rss.xml', '', 0, 0, '2015-04-28 22:16:08.17907', '', NULL, 'http://www.hola.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:07.933041', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:41:30.436257', false);
INSERT INTO ttrss_feeds VALUES (97, 1, 'CNN.com - World', 36, 'http://rss.cnn.com/rss/cnn_world.rss', '', 0, 0, '2015-04-28 22:16:49.856476', '', NULL, 'http://www.cnn.com/WORLD/index.html?eref=rss_world', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:49.477381', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:25.486445', false);
INSERT INTO ttrss_feeds VALUES (18, 1, 'TheWrap', 8, 'http://www.thewrap.com/feed/', '', 0, 0, '2015-04-28 22:16:08.235328', '', NULL, 'http://www.thewrap.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.181392', 0, false, 9, false, false, false, '', 0, '2015-04-28 12:41:31.077138', false);
INSERT INTO ttrss_feeds VALUES (165, 1, 'Bleacher Report - NBA', 29, 'http://bleacherreport.com/articles/feed?tag_id=19', '', 0, 0, '2015-04-28 22:17:04.685377', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.539377', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:57.62271', false);
INSERT INTO ttrss_feeds VALUES (98, 1, 'CNN.com - Top Stories', 36, 'http://rss.cnn.com/rss/edition.rss', '', 0, 0, '2015-04-28 22:16:50.159769', '', NULL, 'http://edition.cnn.com/index.html?eref=edition', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:49.85977', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:25.856404', false);
INSERT INTO ttrss_feeds VALUES (20, 1, 'Hollywood Reporter', 9, 'http://feeds.feedburner.com/THR/NEWS', '', 0, 0, '2015-04-28 22:16:08.470679', '', NULL, 'http://www.hollywoodreporter.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.331325', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:41:31.419131', false);
INSERT INTO ttrss_feeds VALUES (77, 1, 'Automotive News Breaking News Feed', 22, 'http://feeds.feedburner.com/autonews/BreakingNews', '', 0, 0, '2015-04-28 22:16:41.966972', '', NULL, 'http://www.autonews.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:41.747195', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:11.261982', false);
INSERT INTO ttrss_feeds VALUES (101, 1, 'BBC News - World', 36, 'http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk', '', 0, 0, '2015-04-28 22:16:50.724855', '', NULL, 'http://www.bbc.co.uk/news/world/#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:50.504923', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:27.203298', false);
INSERT INTO ttrss_feeds VALUES (107, 1, 'Campaigns: Campaign and Election News & Analysis - The Washington Post', 37, 'http://feeds.washingtonpost.com/rss/politics/campaigns', '', 0, 0, '2015-04-28 22:16:51.670154', '', NULL, 'http://www.washingtonpost.com/politics/campaigns?wprss=rss_campaigns', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.603276', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:28.79355', false);
INSERT INTO ttrss_feeds VALUES (79, 1, 'Motor Trend Car Reviews RSS', 22, 'http://www.motortrend.com/widgetrss/motortrend-roadtests.xml', '', 0, 0, '2015-04-28 22:16:43.830207', '', NULL, 'http://www.motortrend.com/roadtests/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:42.353931', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:14.11879', false);
INSERT INTO ttrss_feeds VALUES (81, 1, 'Health and Fitness - The Huffington Post', 19, 'http://www.huffingtonpost.com/feeds/verticals/health-fitness/index.xml', '', 0, 0, '2015-04-28 22:16:43.92764', '', NULL, 'http://www.huffingtonpost.com/health-fitness/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:43.834023', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:14.293046', false);
INSERT INTO ttrss_feeds VALUES (112, 1, 'Politics - The Huffington Post', 37, 'http://www.huffingtonpost.com/FEEDS/VERTICALS/POLITICS/INDEX.XML', '', 0, 0, '2015-04-28 22:16:52.090994', '', NULL, 'http://www.huffingtonpost.com/politics/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.969349', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:42:29.409581', false);
INSERT INTO ttrss_feeds VALUES (130, 1, 'FOX News', 41, 'http://feeds.foxnews.com/FOXNEWS/SCIENCE', '', 0, 0, '2015-04-28 22:16:54.486865', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:54.382094', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:33.681879', false);
INSERT INTO ttrss_feeds VALUES (23, 1, 'Variety', 9, 'http://feeds.feedburner.com/variety/news/frontpage', '', 0, 0, '2015-04-28 22:16:08.960999', '', NULL, 'http://variety.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.810419', 0, false, 9, false, false, false, '', 0, '2015-04-28 12:41:33.249158', false);
INSERT INTO ttrss_feeds VALUES (108, 1, 'White House: Latest White House News, Headlines, Analysis & More - The Washington Post', 37, 'http://feeds.washingtonpost.com/rss/politics/whitehouse', '', 0, 0, '2015-04-28 22:16:51.73595', '', NULL, 'http://www.washingtonpost.com/politics/whitehouse?wprss=rss_whitehouse', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.673134', 0, false, 8, false, false, false, '', 0, '2015-04-28 12:42:28.900453', false);
INSERT INTO ttrss_feeds VALUES (66, 1, 'NYT > Books', 25, 'http://feeds.nytimes.com/NYT/RSS/BOOKS', '', 0, 0, '2015-04-28 22:16:12.063409', '', NULL, 'http://www.nytimes.com/pages/books/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:11.972156', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:39.84827', false);
INSERT INTO ttrss_feeds VALUES (166, 1, 'ESPN.com - NBA', 29, 'http://sports.espn.go.com/espn/rss/nba/news', '', 0, 0, '2015-04-28 22:17:04.862797', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.68782', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:58.080074', false);
INSERT INTO ttrss_feeds VALUES (110, 1, 'Courts & Law - The Washington Post', 37, 'http://feeds.washingtonpost.com/rss/politics/courts-law', '', 0, 0, '2015-04-28 22:16:51.852651', '', NULL, 'http://www.washingtonpost.com/politics/courts-law?wprss=rss_courts_law', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.802455', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:29.103737', false);
INSERT INTO ttrss_feeds VALUES (68, 1, '[Unknown]', 25, 'http://www.publishersweekly.com/pw/feeds/recent/index.xml', '', 0, 0, '2015-04-28 22:16:12.248195', '', NULL, 'http://www.publishersweekly.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:12.115819', 0, false, 3, false, false, false, '', 0, '2015-04-28 15:19:35.379672', false);
INSERT INTO ttrss_feeds VALUES (144, 1, 'Religion - The Huffington Post', 49, 'http://www.huffingtonpost.com/FEEDS/VERTICALS/RELIGION/INDEX.XML', '', 0, 0, '2015-04-28 22:16:58.61364', '', NULL, 'http://www.huffingtonpost.com/religion/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:58.499044', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:47.090082', false);
INSERT INTO ttrss_feeds VALUES (71, 1, 'Bon Appétit', 20, 'http://www.bonappetit.com/rss2', '', 0, 0, '2015-04-28 22:16:13.989344', '', NULL, 'http://www.bonappetit.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:13.888303', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:41.201951', false);
INSERT INTO ttrss_feeds VALUES (168, 1, 'NBA Basketball News : CBSSports.com', 29, 'http://www.cbssports.com/partners/feeds/rss/nba_news', '', 0, 0, '2015-04-28 22:17:05.145446', '', NULL, 'http://www.cbssports.com/nba', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.035631', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:58.434678', false);
INSERT INTO ttrss_feeds VALUES (147, 1, 'POLITICO - TOP 10 Full Polls', 44, 'http://www.politico.com/rss/polls.xml', '', 0, 0, '2015-04-28 22:16:59.372731', '', NULL, 'http://www.politico.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:59.306463', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:48.563433', false);
INSERT INTO ttrss_feeds VALUES (36, 1, 'ComedyNews.Org', 11, 'http://feeds.feedburner.com/COMEDYNEWSORG/PUBLISHEDNEWS', '', 0, 0, '2015-04-28 22:16:15.092599', '', NULL, 'http://www.comedynews.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.016678', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:43.067595', false);
INSERT INTO ttrss_feeds VALUES (186, 1, 'Snowboarding.com Snowboarding News Feed', 33, 'http://www.snowboarding.com/feeds/', '', 0, 0, '2015-04-28 22:17:09.02302', '', NULL, 'http://www.snowboarding.com/feeds/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:08.181275', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:16.531483', false);
INSERT INTO ttrss_feeds VALUES (48, 1, 'Upworthy', 13, 'http://feeds.feedburner.com/UPWORTHY', '', 0, 0, '2015-04-28 22:16:19.963167', '', NULL, 'http://www.upworthy.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:19.697899', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:48.5881', false);
INSERT INTO ttrss_feeds VALUES (82, 1, 'Shape Magazine', 19, 'http://www.shape.com/RSS.XML', '', 0, 0, '2015-04-28 22:16:44.606489', '', NULL, 'http://www.shape.com/RSS.XML', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:43.931669', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:15.113225', false);
INSERT INTO ttrss_feeds VALUES (96, 1, 'Washington Post: Breaking News, World, US, DC News & Analysis', 7, 'http://feeds.washingtonpost.com/rss/homepage', '', 0, 0, '2015-04-28 22:16:49.474817', '', NULL, 'http://www.washingtonpost.com?wprss=rss_homepage', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:49.420365', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:25.227508', false);
INSERT INTO ttrss_feeds VALUES (72, 1, 'WIRED » Design', 21, 'http://www.wired.com/category/design/feed/', '', 0, 0, '2015-04-28 22:16:15.174445', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.095487', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:43.220758', false);
INSERT INTO ttrss_feeds VALUES (116, 1, 'WSJ.com: Markets', 38, 'http://www.wsj.com/xml/rss/3_7031.xml', '', 0, 0, '2015-04-28 22:16:52.467764', '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.402009', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:30.196459', false);
INSERT INTO ttrss_feeds VALUES (38, 1, 'CollegeHumor: Originals', 11, 'http://www.collegehumor.com/ORIGINALS/RSS', '', 0, 0, '2015-04-28 22:16:15.461908', '', NULL, 'http://www.collegehumor.com/originals', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.306359', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:43.739181', false);
INSERT INTO ttrss_feeds VALUES (117, 1, 'WSJ.com: Business', 38, 'http://www.wsj.com/xml/rss/3_7148.xml', '', 0, 0, '2015-04-28 22:16:52.483689', '', NULL, 'http://online.wsj.com/article/business.html', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.469997', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:30.3809', false);
INSERT INTO ttrss_feeds VALUES (75, 1, 'Dezeen', 21, 'http://feeds.feedburner.com/DEZEEN', '', 0, 0, '2015-04-28 22:16:15.818428', '', NULL, 'http://www.dezeen.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.711537', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:44.199607', false);
INSERT INTO ttrss_feeds VALUES (120, 1, 'WIRED', 39, 'http://feeds.wired.com/wired/index', '', 0, 0, '2015-04-28 22:16:52.878729', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.735357', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:42:31.196147', false);
INSERT INTO ttrss_feeds VALUES (61, 1, 'NYT > Personal Tech', 17, 'http://rss.nytimes.com/services/xml/rss/nyt/PersonalTech.xml', '', 0, 0, '2015-04-28 22:16:38.583467', '', NULL, 'http://www.nytimes.com/pages/technology/personaltech/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:38.506524', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:07.503714', false);
INSERT INTO ttrss_feeds VALUES (121, 1, 'WIRED » Business', 38, 'http://www.wired.com/category/business/feed/', '', 0, 0, '2015-04-28 22:16:52.941579', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.881267', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:31.351075', false);
INSERT INTO ttrss_feeds VALUES (111, 1, 'FOX News', 37, 'http://feeds.foxnews.com/foxnews/politics', '', 0, 0, '2015-04-28 22:16:51.96677', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.854836', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:29.23498', false);
INSERT INTO ttrss_feeds VALUES (122, 1, 'NYT > Technology', 39, 'http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml', '', 0, 0, '2015-04-28 22:16:53.016587', '', NULL, 'http://www.nytimes.com/pages/technology/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.9443', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:31.426227', false);
INSERT INTO ttrss_feeds VALUES (113, 1, 'Business and financial news - CNNMoney.com', 38, 'http://rss.cnn.com/RSS/MONEY_TOPSTORIES.RSS', '', 0, 0, '2015-04-28 22:16:52.19951', '', NULL, 'http://money.cnn.com/?section=money_topstories', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.093355', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:29.644769', false);
INSERT INTO ttrss_feeds VALUES (126, 1, 'NYT > Health', 40, 'http://rss.nytimes.com/services/xml/rss/nyt/Health.xml', '', 0, 0, '2015-04-28 22:16:53.612855', '', NULL, 'http://www.nytimes.com/pages/health/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:53.510351', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:32.288186', false);
INSERT INTO ttrss_feeds VALUES (114, 1, 'FOX Business', 38, 'http://feeds.foxbusiness.com/FOXBUSINESS/LATEST', '', 0, 0, '2015-04-28 22:16:52.321795', '', NULL, 'http://www.foxbusiness.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.201975', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:29.884557', false);
INSERT INTO ttrss_feeds VALUES (115, 1, 'WSJ.com: US Business', 38, 'http://www.wsj.com/xml/rss/3_7014.xml', '', 0, 0, '2015-04-28 22:16:52.39964', '', NULL, 'http://online.wsj.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:52.324302', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:42:30.043834', false);
INSERT INTO ttrss_feeds VALUES (129, 1, 'Universe News', 41, 'http://www.nasa.gov/rss/universe.rss', '', 0, 0, '2015-04-28 22:16:54.380009', '', NULL, 'http://www.nasa.gov/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:54.174376', 0, false, 10, false, false, false, '', 0, '2015-04-28 12:42:33.595434', false);
INSERT INTO ttrss_feeds VALUES (132, 1, 'News from Science', 41, 'http://news.sciencemag.org/RSS/CURRENT.XML', '', 0, 0, '2015-04-28 22:16:56.735997', '', NULL, 'http://news.sciencemag.org/rss/current.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:54.638287', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:35.759426', false);
INSERT INTO ttrss_feeds VALUES (131, 1, 'Scientific American News', 41, 'http://rss.sciam.com/ScientificAmerican-News', '', 0, 0, '2015-04-28 22:16:54.636172', '', NULL, 'http://www.scientificamerican.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:54.489428', 0, false, 8, false, false, false, '', 0, '2015-04-28 12:42:33.856885', false);
INSERT INTO ttrss_feeds VALUES (157, 1, 'FOX Sports Digital', 27, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', 0, 0, '2015-04-28 22:17:03.202416', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nfl', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:03.08916', 0, false, 7, false, false, false, '', 0, '2015-04-28 12:42:53.737137', false);
INSERT INTO ttrss_feeds VALUES (134, 1, 'Speaking of Science', 41, 'http://feeds.washingtonpost.com/rss/rss_speaking-of-science', '', 0, 0, '2015-04-28 22:16:56.989627', '', NULL, 'http://www.washingtonpost.com/news/speaking-of-science', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:56.929167', 0, false, 9, false, false, false, '', 0, '2015-04-28 12:42:36.073111', false);
INSERT INTO ttrss_feeds VALUES (162, 1, 'MLB Baseball News : CBSSports.com', 28, 'http://www.cbssports.com/partners/feeds/rss/mlb_news', '', 0, 0, '2015-04-28 22:17:04.312153', '', NULL, 'http://www.cbssports.com/mlb', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.246934', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:55.879668', false);
INSERT INTO ttrss_feeds VALUES (135, 1, 'NYT > Science', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Science.xml', '', 0, 0, '2015-04-28 22:16:57.165285', '', NULL, 'http://www.nytimes.com/pages/science/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:56.992119', 0, false, 5, false, false, false, '', 0, '2015-04-28 12:42:36.142539', false);
INSERT INTO ttrss_feeds VALUES (136, 1, 'NYT > Space & Cosmos', 41, 'http://rss.nytimes.com/services/xml/rss/nyt/Space.xml', '', 0, 0, '2015-04-28 22:16:57.238416', '', NULL, 'http://www.nytimes.com/pages/science/space/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.167872', 0, false, 6, false, false, false, '', 0, '2015-04-28 12:42:36.326555', false);
INSERT INTO ttrss_feeds VALUES (138, 1, 'CNN.com - Science and Space', 41, 'http://rss.cnn.com/rss/edition_space.rss', '', 0, 0, '2015-04-28 22:16:57.440878', '', NULL, 'http://edition.cnn.com/TECH/space/?eref=edition_space', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.385499', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:36.604853', false);
INSERT INTO ttrss_feeds VALUES (139, 1, 'Science - The Huffington Post', 41, 'http://www.huffingtonpost.com/feeds/verticals/science/index.xml', '', 0, 0, '2015-04-28 22:16:57.539088', '', NULL, 'http://www.huffingtonpost.com/science/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.443667', 0, false, 7, false, false, false, '', 0, '2015-04-28 12:42:36.63263', false);
INSERT INTO ttrss_feeds VALUES (140, 1, 'WIRED » Science', 41, 'http://www.wired.com/category/science/feed/', '', 0, 0, '2015-04-28 22:16:57.589484', '', NULL, 'http://www.wired.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.54156', 0, false, 11, false, false, false, '', 0, '2015-04-28 12:42:36.747134', false);
INSERT INTO ttrss_feeds VALUES (123, 1, 'Latest News from CIO UK', 39, 'http://rss.feedsportal.com/c/663/f/8422/index.rss', '', 0, 0, '2015-04-28 22:16:53.091376', '', NULL, 'http://www.cio.co.uk/news/', '', NULL, false, '', false, true, false, false, false, false, '2015-04-25 17:06:07.558201', '2015-04-28 22:16:53.01912', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:31.580808', false);
INSERT INTO ttrss_feeds VALUES (156, 1, 'College Football News : CBSSports.com', 27, 'http://www.cbssports.com/partners/feeds/rss/cfb_news', '', 0, 0, '2015-04-28 22:17:03.085644', '', NULL, 'http://www.cbssports.com/collegefootball', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:03.019125', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:53.243833', false);
INSERT INTO ttrss_feeds VALUES (125, 1, 'CNN.com - Health', 40, 'http://rss.cnn.com/RSS/CNN_HEALTH.RSS', '', 0, 0, '2015-04-28 22:16:53.506952', '', NULL, 'http://www.cnn.com/HEALTH/index.html?eref=rss_health', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:53.094103', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:31.792257', false);
INSERT INTO ttrss_feeds VALUES (145, 1, 'WorldWide Religious News', 49, 'http://wwrn.org/rss/', '', 0, 0, '2015-04-28 22:16:59.25865', '', NULL, 'http://wwrn.org/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:58.616531', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:48.137314', false);
INSERT INTO ttrss_feeds VALUES (175, 1, 'Tennis News : CBSSports.com', 31, 'http://www.cbssports.com/partners/feeds/rss/tennis_news', '', 0, 0, '2015-04-28 22:17:06.127479', '', NULL, 'http://www.cbssports.com/tennis', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.062995', 0, false, 0, false, false, false, '', 0, '2015-04-25 21:11:25.932941', false);
INSERT INTO ttrss_feeds VALUES (146, 1, 'Pew Research Center', 44, 'http://www.pewresearch.org/feed/', '', 0, 0, '2015-04-28 22:16:59.304188', '', NULL, 'http://www.pewresearch.org', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:59.261218', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:48.445086', false);
INSERT INTO ttrss_feeds VALUES (152, 1, 'Bleacher Report - College Football', 27, 'http://bleacherreport.com/articles/feed?tag_id=23', '', 0, 0, '2015-04-28 22:17:02.196609', '', NULL, 'http://bleacherreport.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:02.064934', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:52.260312', false);
INSERT INTO ttrss_feeds VALUES (63, 1, 'Electronic Design', 17, 'http://electronicdesign.com/rss.xml', '', 0, 0, '2015-04-28 22:16:03.850871', '', NULL, 'http://electronicdesign.com/rss.xml', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:03.52714', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:25.746784', false);
INSERT INTO ttrss_feeds VALUES (13, 1, 'Cele|bitchy', 8, 'http://feeds.feedburner.com/Celebitchy', '', 0, 0, '2015-04-28 22:16:06.913087', '', NULL, 'http://www.celebitchy.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:06.818323', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:29.332119', false);
INSERT INTO ttrss_feeds VALUES (14, 1, 'Defamer', 8, 'http://defamer.gawker.com/rss', '', 0, 0, '2015-04-28 22:16:07.001512', '', NULL, 'http://defamer.gawker.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:06.915939', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:29.44462', false);
INSERT INTO ttrss_feeds VALUES (89, 1, 'GamesRadar - Movie News', 24, 'http://www.gamesradar.com/all-platforms/news/feed/', '', 0, 0, '2015-04-28 22:16:46.967005', '', NULL, 'http://www.gamesradar.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:46.766209', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:21.985048', false);
INSERT INTO ttrss_feeds VALUES (141, 1, 'Top Environment News -- ScienceDaily', 42, 'http://www.sciencedaily.com/rss/top/environment.xml', '', 0, 0, '2015-04-28 22:16:57.963086', '', NULL, 'http://www.sciencedaily.com/news/top/environment/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.592533', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:37.07023', false);
INSERT INTO ttrss_feeds VALUES (143, 1, 'U.S. EPA News feed', 42, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate?opendocument', '', 0, 0, '2015-04-28 22:16:58.496167', '', NULL, 'http://yosemite.epa.gov/opa/admpress.nsf/RSS/climate!open', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:58.128517', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:47.000164', false);
INSERT INTO ttrss_feeds VALUES (10, 1, 'E! Online (US) - Top Stories', 8, 'http://feeds.eonline.com/eonline/topstories', '', 0, 0, '2015-04-28 22:16:05.183638', '', NULL, 'http://www.eonline.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:04.976408', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:27.183598', false);
INSERT INTO ttrss_feeds VALUES (87, 1, 'Intelligent Travel', 23, 'http://feeds.feedburner.com/INTELLIGENTTRAVEL', '', 0, 0, '2015-04-28 22:16:46.399926', '', NULL, 'http://intelligenttravel.nationalgeographic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:46.307456', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:16.378751', false);
INSERT INTO ttrss_feeds VALUES (70, 1, 'FN Dish – Food Network Blog', 20, 'http://blog.foodnetwork.com/fn-dish/feed/', '', 0, 0, '2015-04-28 22:16:13.884893', '', NULL, 'http://blog.foodnetwork.com/fn-dish', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:12.350867', 0, false, 2, false, false, false, '', 0, '2015-04-28 13:45:20.827176', false);
INSERT INTO ttrss_feeds VALUES (159, 1, 'USATODAY - NFL Top Stories', 27, 'http://rssfeeds.usatoday.com/UsatodaycomNfl-TopStories', '', 0, 0, '2015-04-28 22:17:03.576775', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:03.253301', 0, false, 10, false, false, false, '', 0, '2015-04-28 12:42:55.149383', false);
INSERT INTO ttrss_feeds VALUES (88, 1, 'GameSpot Game Listings', 24, 'http://www.gamespot.com/feeds/new-games/', '', 0, 0, '2015-04-28 22:16:46.763993', '', NULL, 'http://www.gamespot.com/feeds/new-games/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:46.402268', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:16.87928', false);
INSERT INTO ttrss_feeds VALUES (39, 1, 'IGN All', 12, 'http://feeds.ign.com/IGN/ALL', '', 0, 0, '2015-04-28 22:16:15.707556', '', NULL, 'http://www.ign.com/articles', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.465146', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:43.984726', false);
INSERT INTO ttrss_feeds VALUES (91, 1, 'Personal finance news - CNNMoney.com', 26, 'http://rss.cnn.com/RSS/MONEY_PF.RSS', '', 0, 0, '2015-04-28 22:16:48.446036', '', NULL, 'http://money.cnn.com/pf/?section=money_pf', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:48.345507', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:23.72923', false);
INSERT INTO ttrss_feeds VALUES (40, 1, 'GameSpot', 12, 'http://gamespot.com/rss/game_updates.php?', '', 0, 0, '2015-04-28 22:16:16.990981', '', NULL, 'http://www.gamespot.com/feeds/mashup/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:15.823281', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:41:45.121864', false);
INSERT INTO ttrss_feeds VALUES (160, 1, 'USATODAY - College Football Top Stories', 27, 'http://rssfeeds.usatoday.com/UsatodaycomCollegeFootball-TopStories', '', 0, 0, '2015-04-28 22:17:04.06336', '', NULL, 'http://www.usatoday.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:03.579187', 0, false, 9, false, false, false, '', 0, '2015-04-28 12:42:55.501088', false);
INSERT INTO ttrss_feeds VALUES (42, 1, 'Eurogamer.net', 12, 'http://www.eurogamer.net/?format=rss', '', 0, 0, '2015-04-28 22:16:17.858473', '', NULL, 'http://www.eurogamer.net/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:17.363212', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:45.863678', false);
INSERT INTO ttrss_feeds VALUES (142, 1, 'NYT > Energy & Environment', 42, 'http://rss.nytimes.com/services/xml/rss/nyt/EnergyEnvironment.xml', '', 0, 0, '2015-04-28 22:16:58.12573', '', NULL, 'http://www.nytimes.com/pages/business/energy-environment/index.html?partner=rss&emc=rss', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:57.965697', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:37.285113', false);
INSERT INTO ttrss_feeds VALUES (43, 1, 'VideoGamer.com - Latest News', 12, 'http://feeds.videogamer.com/rss/news.xml', '', 0, 0, '2015-04-28 22:16:18.473775', '', NULL, 'http://www.videogamer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:17.86209', 0, false, 4, false, false, false, '', 0, '2015-04-28 12:41:46.714211', false);
INSERT INTO ttrss_feeds VALUES (174, 1, 'USATODAY - NHL Top Stories', 30, 'http://rssfeeds.usatoday.com/UsatodaycomNhl-TopStories', '', 0, 0, '2015-04-28 22:17:06.060677', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.780114', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:06.482693', false);
INSERT INTO ttrss_feeds VALUES (177, 1, 'ESPN.com - TENNIS', 31, 'http://sports.espn.go.com/espn/rss/tennis/news', '', 0, 0, '2015-04-28 22:17:06.359008', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.191257', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:07.670797', false);
INSERT INTO ttrss_feeds VALUES (45, 1, 'BuzzFeed Videos - Latest', 13, 'http://www.buzzfeed.com/VIDEOS.XML', '', 0, 0, '2015-04-28 22:16:19.351981', '', NULL, 'http://www.buzzfeed.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:18.975725', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:47.726452', false);
INSERT INTO ttrss_feeds VALUES (60, 1, 'CNET', 17, 'http://www.cnet.com/rss/all/', '', 0, 0, '2015-04-28 22:16:38.503455', '', NULL, 'http://www.cnet.com/#ftag=CADf328eec', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:38.333472', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:07.362475', false);
INSERT INTO ttrss_feeds VALUES (44, 1, 'Vimeo / The Viral Video Channel', 13, 'http://vimeo.com/CHANNELS/53200/VIDEOS/RSS', '', 0, 0, '2015-04-28 22:16:18.972726', '', NULL, 'http://vimeo.com/channels/53200/videos', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:18.853944', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:47.357454', false);
INSERT INTO ttrss_feeds VALUES (169, 1, 'FOX Sports Digital', 29, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', 0, 0, '2015-04-28 22:17:05.203769', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nba', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.147943', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:01.147074', false);
INSERT INTO ttrss_feeds VALUES (49, 1, 'Ads of the World™', 14, 'http://adsoftheworld.com/NODE/FEED', '', 0, 0, '2015-04-28 22:16:21.388825', '', NULL, 'http://adsoftheworld.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:19.968459', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:41:50.219114', false);
INSERT INTO ttrss_feeds VALUES (179, 1, 'TENNIS.com - Headlines', 31, 'http://feeds.feedburner.com/tenniscom-news', '', 0, 0, '2015-04-28 22:17:06.717088', '', NULL, 'http://www.tennis.com/pro-game/list/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.61387', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:09.301403', false);
INSERT INTO ttrss_feeds VALUES (92, 1, 'Kiplinger''s Personal Finance', 26, 'http://www.kiplinger.com/about/rss/kiplinger.rss', '', 0, 0, '2015-04-28 22:16:48.752354', '', NULL, 'http://www.kiplinger.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:48.448617', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:23.838497', false);
INSERT INTO ttrss_feeds VALUES (170, 1, 'USATODAY - NBA Top Stories', 29, 'http://rssfeeds.usatoday.com/UsatodaycomNba-TopStories', '', 0, 0, '2015-04-28 22:17:05.471361', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.206121', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:02.110788', false);
INSERT INTO ttrss_feeds VALUES (149, 1, 'ALL GALLUP HEADLINES', 44, 'http://www.gallup.com/TAG/ALL+GALLUP+HEADLINES.RSS', '', 0, 0, '2015-04-28 22:17:01.699248', '', NULL, 'http://www.gallup.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:59.510803', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:51.712202', false);
INSERT INTO ttrss_feeds VALUES (180, 1, 'BBC Sport - Tennis', 31, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/tennis/rss.xml', '', 0, 0, '2015-04-28 22:17:07.196705', '', NULL, 'http://www.bbc.co.uk/sport/0/tennis/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.719483', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:09.479947', false);
INSERT INTO ttrss_feeds VALUES (171, 1, 'ESPN.com - NHL', 30, 'http://sports.espn.go.com/espn/rss/nhl/news', '', 0, 0, '2015-04-28 22:17:05.64191', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.473761', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:02.482098', false);
INSERT INTO ttrss_feeds VALUES (172, 1, 'NHL Hockey News : CBSSports.com', 30, 'http://www.cbssports.com/partners/feeds/rss/nhl_news', '', 0, 0, '2015-04-28 22:17:05.709396', '', NULL, 'http://www.cbssports.com/nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.644332', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:02.594709', false);
INSERT INTO ttrss_feeds VALUES (185, 1, 'ESPN.com - GOLF', 32, 'http://sports.espn.go.com/espn/rss/golf/news', '', 0, 0, '2015-04-28 22:17:08.178392', '', NULL, 'http://espn.go.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:07.933638', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:11.386643', false);
INSERT INTO ttrss_feeds VALUES (173, 1, 'FOX Sports Digital', 30, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', 0, 0, '2015-04-28 22:17:05.777701', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=nhl', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:05.711702', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:05.552707', false);
INSERT INTO ttrss_feeds VALUES (176, 1, 'FOX Sports Digital', 31, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', 0, 0, '2015-04-28 22:17:06.18875', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=tennis', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:06.130619', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:07.47442', false);
INSERT INTO ttrss_feeds VALUES (191, 1, 'USATODAY - Soccer Top Stories', 34, 'http://rssfeeds.usatoday.com/UsatodaycomSoccer-TopStories', '', 0, 0, '2015-04-28 22:17:11.885771', '', NULL, 'http://api-internal.usatoday.com.akadns.net', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:11.499901', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:22.56747', false);
INSERT INTO ttrss_feeds VALUES (192, 1, 'BBC Sport - Football', 34, 'http://feeds.bbci.co.uk/sport/0/football/rss.xml?edition=uk', '', 0, 0, '2015-04-28 22:17:12.117661', '', NULL, 'http://www.bbc.co.uk/sport/0/football/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:11.888811', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:22.732706', false);
INSERT INTO ttrss_feeds VALUES (196, 1, 'Today in History | HistoryOrb.com', 45, 'http://feeds.feedburner.com/historyorb/todayinhistory', '', 0, 0, '2015-04-28 22:17:13.414039', '', NULL, 'http://www.historyorb.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:13.363012', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:24.866506', false);
INSERT INTO ttrss_feeds VALUES (163, 1, 'FOX Sports Digital', 28, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', 0, 0, '2015-04-28 22:17:04.36303', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=mlb', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:04.314615', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:42:56.58606', false);
INSERT INTO ttrss_feeds VALUES (188, 1, 'BBC Sport - Cricket', 35, 'http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/cricket/rss.xml', '', 0, 0, '2015-04-28 22:17:10.615256', '', NULL, 'http://www.bbc.co.uk/sport/0/cricket/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:10.298912', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:19.925827', false);
INSERT INTO ttrss_feeds VALUES (189, 1, 'ESPN SOCCER', 34, 'http://soccernet.espn.go.com/rss/news', '', 0, 0, '2015-04-28 22:17:11.437598', '', NULL, 'http://www.espnfc.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:10.617987', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:20.856206', false);
INSERT INTO ttrss_feeds VALUES (9, 1, 'Us Magazine Latest News', 8, 'http://www.usmagazine.com/celebrity_news/rss', '', 0, 0, '2015-04-28 22:16:04.972143', '', NULL, 'http://usmagazine.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:04.84483', 0, false, 11, false, false, false, '', 0, '2015-04-28 12:41:26.98419', false);
INSERT INTO ttrss_feeds VALUES (50, 1, 'Clever Ideas, Great Ads', 14, 'http://great-ads.blogspot.com/feeds/posts/default', '', 0, 0, '2015-04-28 22:16:21.626807', '', NULL, 'http://great-ads.blogspot.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:21.391318', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:41:50.446478', false);
INSERT INTO ttrss_feeds VALUES (51, 1, 'Best ads: TV, Print, Outdoor, Interactive, Radio', 14, 'http://www.bestadsontv.com/feed/', '', 0, 0, '2015-04-28 22:16:41.248575', '', NULL, 'http://www.bestadsontv.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:38.586512', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:10.703129', false);
INSERT INTO ttrss_feeds VALUES (52, 1, 'AdWeek: AdFreak', 14, 'http://feeds.adweek.com/adweek/adfreak?format=xml', '', 0, 0, '2015-04-28 22:16:41.519009', '', NULL, 'http://www.adweek.com/adfreak', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:41.251466', 0, false, 1, false, false, false, '', 0, '2015-04-28 12:42:10.941446', false);
INSERT INTO ttrss_feeds VALUES (84, 1, 'FOX News', 23, 'http://feeds.foxnews.com/FOXNEWS/INTERNAL/TRAVEL/MIXED', '', 0, 0, '2015-04-28 22:16:44.942291', '', NULL, 'http://www.foxnews.com/', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:44.82418', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:42:15.45461', false);
INSERT INTO ttrss_feeds VALUES (190, 1, 'FOX Sports Digital', 34, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', 0, 0, '2015-04-28 22:17:11.497025', '', NULL, 'http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU&tag=soccer', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:11.440365', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:21.868188', false);
INSERT INTO ttrss_feeds VALUES (193, 1, 'MLSsoccer.com News', 34, 'http://www.mlssoccer.com/rss/en.xml', '', 0, 0, '2015-04-28 22:17:12.222033', '', NULL, 'http://www.mlssoccer.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:12.120815', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:23.059604', false);
INSERT INTO ttrss_feeds VALUES (21, 1, 'Box Office', 9, 'http://feeds.feedburner.com/THR/BOXOFFICE', '', 0, 0, '2015-04-28 22:16:08.626996', '', NULL, 'http://www.hollywoodreporter.com/taxonomy/term/3495/0/feed', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:08.475099', 0, false, 2, false, false, false, '', 0, '2015-04-28 12:41:31.655925', false);
INSERT INTO ttrss_feeds VALUES (194, 1, 'Infoplease - This Day in History', 45, 'http://infoplease.com/rss/dayinhistory.rss', '', 0, 0, '2015-04-28 22:17:12.942897', '', NULL, 'http://www.infoplease.com/dayinhistory', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:12.224302', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:23.760637', false);
INSERT INTO ttrss_feeds VALUES (195, 1, 'This day in music', 45, 'http://www.thisdayinmusic.com/xml/onthisday.php?showfacts=10', '', 0, 0, '2015-04-28 22:17:13.359552', '', NULL, 'http://www.thisdayinmusic.com', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:17:12.946358', 0, false, 0, false, false, false, '', 0, '2015-04-28 12:43:24.786556', false);
INSERT INTO ttrss_feeds VALUES (109, 1, 'Congress: Congressional News, Schedule, Votes & More - The Washington Post', 37, 'http://feeds.washingtonpost.com/rss/politics/congress', '', 0, 0, '2015-04-28 22:16:51.800264', '', NULL, 'http://www.washingtonpost.com/politics/congress?wprss=rss_congress', '', NULL, false, '', false, true, false, false, false, false, NULL, '2015-04-28 22:16:51.738926', 0, false, 3, false, false, false, '', 0, '2015-04-28 12:42:28.980092', false);


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


