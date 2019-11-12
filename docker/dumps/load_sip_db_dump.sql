
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg18.04+1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO sip_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO sip_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO sip_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO sip_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO sip_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO sip_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO sip_user;

--
-- Name: core_domofonuser; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.core_domofonuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    user_info jsonb NOT NULL,
    phone character varying(30) NOT NULL,
    phone_confirmed boolean NOT NULL,
    email_confirmed boolean NOT NULL,
    avatar character varying(127) NOT NULL,
    skype character varying(30) NOT NULL,
    sex character varying(6) NOT NULL,
    is_subscriber boolean NOT NULL,
    external_id integer,
    synapse_id character varying(80)
);


ALTER TABLE public.core_domofonuser OWNER TO sip_user;

--
-- Name: core_domofonuser_groups; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.core_domofonuser_groups (
    id integer NOT NULL,
    domofonuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.core_domofonuser_groups OWNER TO sip_user;

--
-- Name: core_domofonuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.core_domofonuser_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_domofonuser_groups_id_seq OWNER TO sip_user;

--
-- Name: core_domofonuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.core_domofonuser_groups_id_seq OWNED BY public.core_domofonuser_groups.id;


--
-- Name: core_domofonuser_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.core_domofonuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_domofonuser_id_seq OWNER TO sip_user;

--
-- Name: core_domofonuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.core_domofonuser_id_seq OWNED BY public.core_domofonuser.id;


--
-- Name: core_domofonuser_user_permissions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.core_domofonuser_user_permissions (
    id integer NOT NULL,
    domofonuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.core_domofonuser_user_permissions OWNER TO sip_user;

--
-- Name: core_domofonuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.core_domofonuser_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_domofonuser_user_permissions_id_seq OWNER TO sip_user;

--
-- Name: core_domofonuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.core_domofonuser_user_permissions_id_seq OWNED BY public.core_domofonuser_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO sip_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO sip_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO sip_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO sip_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO sip_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO sip_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sip_user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO sip_user;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: core_domofonuser id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser ALTER COLUMN id SET DEFAULT nextval('public.core_domofonuser_id_seq'::regclass);


--
-- Name: core_domofonuser_groups id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_groups ALTER COLUMN id SET DEFAULT nextval('public.core_domofonuser_groups_id_seq'::regclass);


--
-- Name: core_domofonuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.core_domofonuser_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.auth_group (id, name) FROM stdin;
1	regular
2	support
3	admin
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add user	7	add_domofonuser
26	Can change user	7	change_domofonuser
27	Can delete user	7	delete_domofonuser
28	Can view user	7	view_domofonuser
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
adbab9234c1c9645797e2d20c7e587e619380724	2019-10-01 19:47:00.049534+03	4
ef5617d328db3ca6ecf336ec41e9e6e1adc11904	2019-10-07 09:12:19.533094+03	7
667666d68c44fcb2ab22c964d3023dafa6217e66	2019-10-07 22:13:26.017291+03	8
c7a5b5c2f8e00d0a4b4597f76e35b3b314ca7617	2019-10-07 22:31:01.316651+03	9
7202f363bd9eb00f80e19d98927db01b316bf5e6	2019-10-07 22:41:53.649962+03	10
661f868fb0c4bc01e90e74c4b59d964f9bc1d73c	2019-10-07 22:46:03.913276+03	11
dae575dead75540f9398bfecefc575edc054a170	2019-10-07 23:12:53.233324+03	12
fb97b06651e4bb1608b6a6519c6a698297d267e4	2019-10-15 18:29:33.665126+03	17
c617fcec1c17152854c5b84678eff252ddf51f8f	2019-10-15 18:48:46.641058+03	18
\.


--
-- Data for Name: core_domofonuser; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.core_domofonuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, user_info, phone, phone_confirmed, email_confirmed, avatar, skype, sex, is_subscriber, external_id, synapse_id) FROM stdin;
8	15656229998	\N	f	89992265681				f	t	2019-10-07 22:13:25.986289+03	{"register_ip": "127.0.0.1"}	89992265651	f	f	./user/logo/default.png		empty	f	15	\N
13	pbkdf2_sha256$150000$YU8XhQM116OV$bFLG9+yZ/0Y/prnNiLrtc68axwHDLf8a2S3KugU5l2Q=	2019-10-08 16:01:29.444789+03	f	89992265651				f	t	2019-10-08 16:00:56.619911+03	{"register_ip": "127.0.0.1", "from_client_db": {"uid": 2, "dom_phone": 11111}}	89992265651	t	f	./user/logo/default.png		empty	f	2	\N
2	pbkdf2_sha256$150000$3dJKqefszo8e$FRIMcP5OgrW09w4toISLuDdde3RVx0ZBUXbF/V4USQs=	\N	f	support_user	Иван	Поддержкин	support@email.ru	f	t	2019-10-02 23:00:48.399791+03	{}	+7800100600	f	f	./user/logo/default.png		male	f	\N	\N
7	0060010087+	\N	f	+7800100600				f	t	2019-10-07 09:12:19.482092+03	{"register_ip": "127.0.0.1"}	+7800100600	t	f	./user/logo/default.png		empty	f	\N	\N
9	75656229998	\N	f	89992265657				f	t	2019-10-07 22:31:01.29665+03	{"register_ip": "127.0.0.1"}	89992265657	t	f	./user/logo/default.png		empty	f	8	\N
10	pbkdf2_sha256$150000$ygqGhfzuz1cl$gDZDHdMWPY7HX8yoFoxJRxZpkisaMAf93MWudVzicjM=	\N	f	89992265654				f	t	2019-10-07 22:41:53.630961+03	{"register_ip": "127.0.0.1"}	89992265654	t	f	./user/logo/default.png		empty	f	11	\N
11	pbkdf2_sha256$150000$Ql2yeMse35A9$J5iwJEI4zdbD1+0TKR26JraHvKikct41OiVApP8vkHE=	\N	f	89992265623				f	t	2019-10-07 22:46:03.899276+03	{"register_ip": "127.0.0.1"}	89992265623	t	f	./user/logo/default.png		empty	f	3	\N
3	pbkdf2_sha256$150000$3dJKqefszo8e$FRIMcP5OgrW09w4toISLuDdde3RVx0ZBUXbF/V4USQs=	2019-10-11 16:30:25.565019+03	f	admin	Мария	Админович	admin@email.ru	t	t	2019-10-02 23:00:48.401791+03	{"settings": {"ringtone": "../../wonderful_life.mp3", "transport": "udp", "video_freq": "15fps", "video_codec": "matrosska", "video_select": "before", "video_bitrate": "1024kbps", "background_color": "#64ff64", "video_resolution": "CIF"}}	+7800800800	f	f	./user/logo/default.png		female	t	\N	\N
12	pbkdf2_sha256$150000$uYGJEHpvCSqE$QuovHEf/ogaQYLLi+wIJvxP54PAtjsZ3MCW9pU+gVyE=	2019-10-07 23:33:17.869369+03	f	89991165659				f	t	2019-10-07 23:12:53.220324+03	{"register_ip": "127.0.0.1"}	89991165659	t	f	./user/logo/default.png		empty	f	1	\N
14	pbkdf2_sha256$150000$GPFSFWLSf8I4$xw3Bdr1pdf1k5KpYfpc/MXB3B8CLzjKYNtMKVuHC76A=	2019-10-08 16:29:15.764097+03	f	89992165659				f	t	2019-10-08 16:28:38.829984+03	{"settings": {"ringtone": null, "transport": "tcp", "video_freq": "15fps", "video_codec": null, "video_select": "ON before answer", "video_bitrate": "1024kbps", "background_color": null, "video_resolution": "QCIF"}, "register_ip": "127.0.0.1", "from_client_db": {"uid": 6, "dom_phone": 23563}}	89992165659	t	f	./user/logo/default.png		empty	f	4	\N
1	pbkdf2_sha256$150000$3dJKqefszo8e$FRIMcP5OgrW09w4toISLuDdde3RVx0ZBUXbF/V4USQs=	2019-10-15 14:47:50.368567+03	f	regular_user	Иван	Регулярнов	regular@email.ru	f	t	2019-10-02 23:00:48.39479+03	{}	+7800100500	f	f	./user/logo/default.png		male	f	\N	\N
4	pbkdf2_sha256$150000$3dJKqefszo8e$FRIMcP5OgrW09w4toISLuDdde3RVx0ZBUXbF/V4USQs=	2019-10-24 14:39:23.891711+03	t	sab			sab43@list.ru	t	t	2019-09-29 20:42:36.271586+03	{"settings": {"ringtone": null, "transport": "tcp", "video_freq": "15fps", "video_codec": null, "video_select": "ON before answer", "video_bitrate": "1024kbps", "background_color": null, "video_resolution": "QCIF"}, "register_ip": "127.0.0.1", "from_client_db": {"uid": 6, "dom_phone": 23563}}		f	f	./user/logo/default.png		empty	f	\N	\N
17	pbkdf2_sha256$150000$VFcsqklDJRjW$KTAHV+hw5X22ZZWuL99ESQ+eFkphhHY0GDFzEq/yAvs=	2019-10-15 18:30:50.251095+03	f	89992265655				f	t	2019-10-15 18:29:33.61079+03	{"settings": {"ringtone": null, "transport": "tcp", "video_freq": "15fps", "video_codec": null, "video_select": "ON before answer", "video_bitrate": "1024kbps", "background_color": null, "video_resolution": "QCIF"}, "register_ip": "127.0.0.1", "from_client_db": [{"uid": 10, "level": 1, "dom_phone": 68426}]}	89992265655	t	f	./user/logo/default.png		empty	f	10	0
18	pbkdf2_sha256$150000$iC12Zcas4Xbw$ZcIvEeyxb8Ntk6QvHK5zC8aILewoTJXHGd1BIS9uCOY=	2019-10-15 18:49:20.796672+03	f	89068294360				f	t	2019-10-15 18:48:46.575639+03	{"settings": {"ringtone": null, "transport": "tcp", "video_freq": "15fps", "video_codec": null, "video_select": "ON before answer", "video_bitrate": "1024kbps", "background_color": null, "video_resolution": "QCIF"}, "register_ip": "127.0.0.1", "from_client_db": [{"uid": 7, "level": 3, "dom_phone": 54546}, {"uid": 5, "level": 2, "dom_phone": 32325}, {"uid": 6, "level": 1, "dom_phone": 23563}], "from_synapse_db": {"access_token": [true, "MDAxZmxvY2F0aW9uIG1hdHJpeC5zYWJydXMuZGV2CjAwMTNpZGVudGlmaWVyIGtleQowMDEwY2lkIGdlbiA9IDEKMDAyOWNpZCB1c2VyX2lkID0gQHNhYjptYXRyaXguc2FicnVzLmRldgowMDE2Y2lkIHR5cGUgPSBhY2Nlc3MKMDAyMWNpZCBub25jZSA9IFUsTmQzb0U7NDRkYSppeHAKMDAyZnNpZ25hdHVyZSCK5UWadfe6QCqMhFKxQbALI8DtkjuKZHbwvzMtXbQX6go"]}}	89068294362	t	f	./user/logo/default.png		empty	f	7	@p89068294362:matrix.sabrus.dev
\.


--
-- Data for Name: core_domofonuser_groups; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.core_domofonuser_groups (id, domofonuser_id, group_id) FROM stdin;
1	1	1
2	2	2
3	3	3
6	7	1
7	8	1
8	9	1
9	10	1
10	11	1
11	12	1
16	17	1
17	18	3
\.


--
-- Data for Name: core_domofonuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.core_domofonuser_user_permissions (id, domofonuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-10-01 19:47:00.050534+03	adbab9234c1c9645797e2d20c7e587e619380724	adbab9234c1c9645797e2d20c7e587e619380724	1	[{"added": {}}]	6	4
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	core	domofonuser
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-09-29 16:15:24.043595+03
2	contenttypes	0002_remove_content_type_name	2019-09-29 16:15:24.061596+03
3	auth	0001_initial	2019-09-29 16:15:24.105598+03
4	auth	0002_alter_permission_name_max_length	2019-09-29 16:15:24.153601+03
5	auth	0003_alter_user_email_max_length	2019-09-29 16:15:24.161601+03
6	auth	0004_alter_user_username_opts	2019-09-29 16:15:24.170602+03
7	auth	0005_alter_user_last_login_null	2019-09-29 16:15:24.177602+03
8	auth	0006_require_contenttypes_0002	2019-09-29 16:15:24.181602+03
9	auth	0007_alter_validators_add_error_messages	2019-09-29 16:15:24.188603+03
10	auth	0008_alter_user_username_max_length	2019-09-29 16:15:24.196603+03
11	auth	0009_alter_user_last_name_max_length	2019-09-29 16:15:24.204604+03
12	auth	0010_alter_group_name_max_length	2019-09-29 16:15:24.217605+03
13	auth	0011_update_proxy_permissions	2019-09-29 16:15:24.225605+03
14	core	0001_initial	2019-09-29 16:15:24.271608+03
15	admin	0001_initial	2019-09-29 16:15:24.337611+03
16	admin	0002_logentry_remove_auto_add	2019-09-29 16:15:24.372613+03
17	admin	0003_logentry_add_action_flag_choices	2019-09-29 16:15:24.387614+03
18	authtoken	0001_initial	2019-09-29 16:15:24.409616+03
19	authtoken	0002_auto_20160226_1747	2019-09-29 16:15:24.471619+03
20	sessions	0001_initial	2019-09-29 16:15:24.48862+03
21	core	0002_domofonuser_external_id	2019-10-07 21:02:34.87514+03
22	core	0003_auto_20191007_2246	2019-10-07 22:46:38.347246+03
23	core	0004_domofonuser_synapse_id	2019-10-09 17:56:28.899096+03
24	core	0004_auto_20191011_2040	2019-10-11 20:40:31.630117+03
25	core	0005_auto_20191015_1804	2019-10-15 18:04:24.399373+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
y7445nix0e48y9e1oojg6avd7irfk3jk	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-13 21:09:36.350249+03
z3trm59y3gheau60r1jife6n2ll65voe	ODcxNGM1N2QyMjdlYzM4NmY5M2U1YjY0NDcyNjcwYmUwMDIzOGRhYzp7fQ==	2019-10-13 21:54:02.328734+03
5j2qajwe5b0clhfl84kqnb2zsr4t37d5	Njg0NzE1MTc5MjY0YWUxYzExNzI4MzU2NmMxNTJkODhhYTQ0NGVlOTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-13 22:33:21.687682+03
b9glm79kye1wdyzf6gz3oz9efgxrlss8	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-15 19:46:38.211285+03
36bqcyu25j4dzerugexd3agkxs6mduv7	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-16 15:55:58.37263+03
5hxjyf1v7j1ql723ibcvhtrwx8z5g3wk	Njg0NzE1MTc5MjY0YWUxYzExNzI4MzU2NmMxNTJkODhhYTQ0NGVlOTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-17 10:29:38.198379+03
cfff1efmajkx2891xcnsoq2g5avzi7da	Njg0NzE1MTc5MjY0YWUxYzExNzI4MzU2NmMxNTJkODhhYTQ0NGVlOTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-19 00:30:27.13834+03
vqorputapjqq1pn9tlr3yp0u3dq2tphl	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-19 08:31:24.581938+03
k9khpjfb965ypibs55bn904w1v5mbg3v	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-19 14:34:28.998935+03
s1vsidzcdsh9pi5rkvand3i6xf4sh3ld	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-19 16:01:12.189541+03
day0hbskyfx9hvxcj6uoob0f52jw2n94	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-19 16:01:44.073365+03
1raz3evkhxvbt9e31xrvk9kd7bns8tzl	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-20 19:52:22.601698+03
8rl1klb45sro2dovcb4lybri65ljyo9p	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-22 15:51:38.330979+03
iwk272yk7e8frtch58r4t71t44g5hnr3	Njg0NzE1MTc5MjY0YWUxYzExNzI4MzU2NmMxNTJkODhhYTQ0NGVlOTp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-22 18:53:46.833053+03
kl5it37xd0561bd6zdkc3ru4r99iuf3o	ODcxNGM1N2QyMjdlYzM4NmY5M2U1YjY0NDcyNjcwYmUwMDIzOGRhYzp7fQ==	2019-10-29 12:42:28.564562+03
8v8v1535vrla1va6jodagzzxb8tutbcj	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-29 14:20:18.371378+03
9tc9e92olzj77if2uci9xp02iw70e8o2	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-29 14:29:08.364496+03
yf7fw8ub6b09u8gm7rbxexppuhqxltdg	MTljYmYxNDUxZGYzMDNkZjQ4NDcyZTE1Njk3NDQxM2MwMjZiNTgzOTp7Il9hdXRoX3VzZXJfaWQiOiIxOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTI0OGI1ZTI5MWQ1YjMxODI0ZmI0NzNiYTZkODEyODAxMDM5ZmYyZCJ9	2019-10-29 18:49:20.823403+03
qj7peo2rl3e83gj3w8jsuq7y1g8qog5p	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-10-30 16:06:22.748659+03
s3zmh1aa8nfbcwwn7fybfi8g4bqjcily	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-11-07 14:32:33.952336+03
1f7060vf2em1yvsdvaeals51ahzze7co	OTg1MzdmM2E3NTZiMDQ1YzcxYjA3ZDE5ZTc3NDVjYTRiOWExZjgxZjp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4YTk1ZWJhOWZhOWZhOWU0NjFkODAwZWMzNjJiZjIxMGUwYzY2ZWQ2In0=	2019-11-07 14:39:23.91708+03
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 28, true);


--
-- Name: core_domofonuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.core_domofonuser_groups_id_seq', 17, true);


--
-- Name: core_domofonuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.core_domofonuser_id_seq', 18, true);


--
-- Name: core_domofonuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.core_domofonuser_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 7, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: core_domofonuser core_domofonuser_external_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser
    ADD CONSTRAINT core_domofonuser_external_id_key UNIQUE (external_id);


--
-- Name: core_domofonuser_groups core_domofonuser_groups_domofonuser_id_group_id_1a9f03bc_uniq; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_groups
    ADD CONSTRAINT core_domofonuser_groups_domofonuser_id_group_id_1a9f03bc_uniq UNIQUE (domofonuser_id, group_id);


--
-- Name: core_domofonuser_groups core_domofonuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_groups
    ADD CONSTRAINT core_domofonuser_groups_pkey PRIMARY KEY (id);


--
-- Name: core_domofonuser core_domofonuser_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser
    ADD CONSTRAINT core_domofonuser_pkey PRIMARY KEY (id);


--
-- Name: core_domofonuser core_domofonuser_synapse_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser
    ADD CONSTRAINT core_domofonuser_synapse_id_key UNIQUE (synapse_id);


--
-- Name: core_domofonuser_user_permissions core_domofonuser_user_pe_domofonuser_id_permissio_72c69648_uniq; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_user_permissions
    ADD CONSTRAINT core_domofonuser_user_pe_domofonuser_id_permissio_72c69648_uniq UNIQUE (domofonuser_id, permission_id);


--
-- Name: core_domofonuser_user_permissions core_domofonuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_user_permissions
    ADD CONSTRAINT core_domofonuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: core_domofonuser core_domofonuser_username_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser
    ADD CONSTRAINT core_domofonuser_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: core_domofonuser_groups_domofonuser_id_d71d0c69; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX core_domofonuser_groups_domofonuser_id_d71d0c69 ON public.core_domofonuser_groups USING btree (domofonuser_id);


--
-- Name: core_domofonuser_groups_group_id_eb0aae78; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX core_domofonuser_groups_group_id_eb0aae78 ON public.core_domofonuser_groups USING btree (group_id);


--
-- Name: core_domofonuser_user_permissions_domofonuser_id_c80dd93b; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX core_domofonuser_user_permissions_domofonuser_id_c80dd93b ON public.core_domofonuser_user_permissions USING btree (domofonuser_id);


--
-- Name: core_domofonuser_user_permissions_permission_id_903cc8ca; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX core_domofonuser_user_permissions_permission_id_903cc8ca ON public.core_domofonuser_user_permissions USING btree (permission_id);


--
-- Name: core_domofonuser_username_f32e180b_like; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX core_domofonuser_username_f32e180b_like ON public.core_domofonuser USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_core_domofonuser_id; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_core_domofonuser_id FOREIGN KEY (user_id) REFERENCES public.core_domofonuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_domofonuser_groups core_domofonuser_gro_domofonuser_id_d71d0c69_fk_core_domo; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_groups
    ADD CONSTRAINT core_domofonuser_gro_domofonuser_id_d71d0c69_fk_core_domo FOREIGN KEY (domofonuser_id) REFERENCES public.core_domofonuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_domofonuser_groups core_domofonuser_groups_group_id_eb0aae78_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_groups
    ADD CONSTRAINT core_domofonuser_groups_group_id_eb0aae78_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_domofonuser_user_permissions core_domofonuser_use_domofonuser_id_c80dd93b_fk_core_domo; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_user_permissions
    ADD CONSTRAINT core_domofonuser_use_domofonuser_id_c80dd93b_fk_core_domo FOREIGN KEY (domofonuser_id) REFERENCES public.core_domofonuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: core_domofonuser_user_permissions core_domofonuser_use_permission_id_903cc8ca_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.core_domofonuser_user_permissions
    ADD CONSTRAINT core_domofonuser_use_permission_id_903cc8ca_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_core_domofonuser_id; Type: FK CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_core_domofonuser_id FOREIGN KEY (user_id) REFERENCES public.core_domofonuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE admin GRANT ALL ON TABLES  TO sip_user;


--
-- PostgreSQL database dump complete
--

