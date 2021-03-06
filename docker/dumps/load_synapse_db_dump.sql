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
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.access_tokens (
    id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text,
    token text NOT NULL,
    last_used bigint,
    valid_until_ms bigint
);


ALTER TABLE public.access_tokens OWNER TO sip_user;

--
-- Name: account_data; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.account_data (
    user_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.account_data OWNER TO sip_user;

--
-- Name: account_data_max_stream_id; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.account_data_max_stream_id (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    CONSTRAINT private_user_data_max_stream_id_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.account_data_max_stream_id OWNER TO sip_user;

--
-- Name: account_validity; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.account_validity (
    user_id text NOT NULL,
    expiration_ts_ms bigint NOT NULL,
    email_sent boolean NOT NULL,
    renewal_token text
);


ALTER TABLE public.account_validity OWNER TO sip_user;

--
-- Name: application_services_state; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.application_services_state (
    as_id text NOT NULL,
    state character varying(5),
    last_txn integer
);


ALTER TABLE public.application_services_state OWNER TO sip_user;

--
-- Name: application_services_txns; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.application_services_txns (
    as_id text NOT NULL,
    txn_id integer NOT NULL,
    event_ids text NOT NULL
);


ALTER TABLE public.application_services_txns OWNER TO sip_user;

--
-- Name: applied_module_schemas; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.applied_module_schemas (
    module_name text NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_module_schemas OWNER TO sip_user;

--
-- Name: applied_schema_deltas; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.applied_schema_deltas (
    version integer NOT NULL,
    file text NOT NULL
);


ALTER TABLE public.applied_schema_deltas OWNER TO sip_user;

--
-- Name: appservice_room_list; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.appservice_room_list (
    appservice_id text NOT NULL,
    network_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.appservice_room_list OWNER TO sip_user;

--
-- Name: appservice_stream_position; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.appservice_stream_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint,
    CONSTRAINT appservice_stream_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.appservice_stream_position OWNER TO sip_user;

--
-- Name: background_updates; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.background_updates (
    update_name text NOT NULL,
    progress_json text NOT NULL,
    depends_on text
);


ALTER TABLE public.background_updates OWNER TO sip_user;

--
-- Name: blocked_rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.blocked_rooms (
    room_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.blocked_rooms OWNER TO sip_user;

--
-- Name: cache_invalidation_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.cache_invalidation_stream (
    stream_id bigint,
    cache_func text,
    keys text[],
    invalidation_ts bigint
);


ALTER TABLE public.cache_invalidation_stream OWNER TO sip_user;

--
-- Name: current_state_delta_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.current_state_delta_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text,
    prev_event_id text
);


ALTER TABLE public.current_state_delta_stream OWNER TO sip_user;

--
-- Name: current_state_events; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.current_state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    membership text
);


ALTER TABLE public.current_state_events OWNER TO sip_user;

--
-- Name: deleted_pushers; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.deleted_pushers (
    stream_id bigint NOT NULL,
    app_id text NOT NULL,
    pushkey text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.deleted_pushers OWNER TO sip_user;

--
-- Name: destinations; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.destinations (
    destination text NOT NULL,
    retry_last_ts bigint,
    retry_interval bigint,
    failure_ts bigint
);


ALTER TABLE public.destinations OWNER TO sip_user;

--
-- Name: device_federation_inbox; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_federation_inbox (
    origin text NOT NULL,
    message_id text NOT NULL,
    received_ts bigint NOT NULL
);


ALTER TABLE public.device_federation_inbox OWNER TO sip_user;

--
-- Name: device_federation_outbox; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_federation_outbox (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    queued_ts bigint NOT NULL,
    messages_json text NOT NULL
);


ALTER TABLE public.device_federation_outbox OWNER TO sip_user;

--
-- Name: device_inbox; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_inbox (
    user_id text NOT NULL,
    device_id text NOT NULL,
    stream_id bigint NOT NULL,
    message_json text NOT NULL
);


ALTER TABLE public.device_inbox OWNER TO sip_user;

--
-- Name: device_lists_outbound_last_success; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_lists_outbound_last_success (
    destination text NOT NULL,
    user_id text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.device_lists_outbound_last_success OWNER TO sip_user;

--
-- Name: device_lists_outbound_pokes; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_lists_outbound_pokes (
    destination text NOT NULL,
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL,
    sent boolean NOT NULL,
    ts bigint NOT NULL,
    opentracing_context text
);


ALTER TABLE public.device_lists_outbound_pokes OWNER TO sip_user;

--
-- Name: device_lists_remote_cache; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_lists_remote_cache (
    user_id text NOT NULL,
    device_id text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.device_lists_remote_cache OWNER TO sip_user;

--
-- Name: device_lists_remote_extremeties; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_lists_remote_extremeties (
    user_id text NOT NULL,
    stream_id text NOT NULL
);


ALTER TABLE public.device_lists_remote_extremeties OWNER TO sip_user;

--
-- Name: device_lists_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_lists_stream (
    stream_id bigint NOT NULL,
    user_id text NOT NULL,
    device_id text NOT NULL
);


ALTER TABLE public.device_lists_stream OWNER TO sip_user;

--
-- Name: device_max_stream_id; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.device_max_stream_id (
    stream_id bigint NOT NULL
);


ALTER TABLE public.device_max_stream_id OWNER TO sip_user;

--
-- Name: devices; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.devices (
    user_id text NOT NULL,
    device_id text NOT NULL,
    display_name text,
    last_seen bigint,
    ip text,
    user_agent text
);


ALTER TABLE public.devices OWNER TO sip_user;

--
-- Name: e2e_device_keys_json; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.e2e_device_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_device_keys_json OWNER TO sip_user;

--
-- Name: e2e_one_time_keys_json; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.e2e_one_time_keys_json (
    user_id text NOT NULL,
    device_id text NOT NULL,
    algorithm text NOT NULL,
    key_id text NOT NULL,
    ts_added_ms bigint NOT NULL,
    key_json text NOT NULL
);


ALTER TABLE public.e2e_one_time_keys_json OWNER TO sip_user;

--
-- Name: e2e_room_keys; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.e2e_room_keys (
    user_id text NOT NULL,
    room_id text NOT NULL,
    session_id text NOT NULL,
    version bigint NOT NULL,
    first_message_index integer,
    forwarded_count integer,
    is_verified boolean,
    session_data text NOT NULL
);


ALTER TABLE public.e2e_room_keys OWNER TO sip_user;

--
-- Name: e2e_room_keys_versions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.e2e_room_keys_versions (
    user_id text NOT NULL,
    version bigint NOT NULL,
    algorithm text NOT NULL,
    auth_data text NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.e2e_room_keys_versions OWNER TO sip_user;

--
-- Name: erased_users; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.erased_users (
    user_id text NOT NULL
);


ALTER TABLE public.erased_users OWNER TO sip_user;

--
-- Name: event_auth; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_auth (
    event_id text NOT NULL,
    auth_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_auth OWNER TO sip_user;

--
-- Name: event_backward_extremities; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_backward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_backward_extremities OWNER TO sip_user;

--
-- Name: event_edges; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_edges (
    event_id text NOT NULL,
    prev_event_id text NOT NULL,
    room_id text NOT NULL,
    is_state boolean NOT NULL
);


ALTER TABLE public.event_edges OWNER TO sip_user;

--
-- Name: event_forward_extremities; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_forward_extremities (
    event_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.event_forward_extremities OWNER TO sip_user;

--
-- Name: event_json; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_json (
    event_id text NOT NULL,
    room_id text NOT NULL,
    internal_metadata text NOT NULL,
    json text NOT NULL,
    format_version integer
);


ALTER TABLE public.event_json OWNER TO sip_user;

--
-- Name: event_push_actions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_push_actions (
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    profile_tag character varying(32),
    actions text NOT NULL,
    topological_ordering bigint,
    stream_ordering bigint,
    notif smallint,
    highlight smallint
);


ALTER TABLE public.event_push_actions OWNER TO sip_user;

--
-- Name: event_push_actions_staging; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_push_actions_staging (
    event_id text NOT NULL,
    user_id text NOT NULL,
    actions text NOT NULL,
    notif smallint NOT NULL,
    highlight smallint NOT NULL
);


ALTER TABLE public.event_push_actions_staging OWNER TO sip_user;

--
-- Name: event_push_summary; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_push_summary (
    user_id text NOT NULL,
    room_id text NOT NULL,
    notif_count bigint NOT NULL,
    stream_ordering bigint NOT NULL
);


ALTER TABLE public.event_push_summary OWNER TO sip_user;

--
-- Name: event_push_summary_stream_ordering; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_push_summary_stream_ordering (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_ordering bigint NOT NULL,
    CONSTRAINT event_push_summary_stream_ordering_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.event_push_summary_stream_ordering OWNER TO sip_user;

--
-- Name: event_reference_hashes; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_reference_hashes (
    event_id text,
    algorithm text,
    hash bytea
);


ALTER TABLE public.event_reference_hashes OWNER TO sip_user;

--
-- Name: event_relations; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_relations (
    event_id text NOT NULL,
    relates_to_id text NOT NULL,
    relation_type text NOT NULL,
    aggregation_key text
);


ALTER TABLE public.event_relations OWNER TO sip_user;

--
-- Name: event_reports; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_reports (
    id bigint NOT NULL,
    received_ts bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL,
    user_id text NOT NULL,
    reason text,
    content text
);


ALTER TABLE public.event_reports OWNER TO sip_user;

--
-- Name: event_search; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_search (
    event_id text,
    room_id text,
    sender text,
    key text,
    vector tsvector,
    origin_server_ts bigint,
    stream_ordering bigint
);


ALTER TABLE public.event_search OWNER TO sip_user;

--
-- Name: event_to_state_groups; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.event_to_state_groups (
    event_id text NOT NULL,
    state_group bigint NOT NULL
);


ALTER TABLE public.event_to_state_groups OWNER TO sip_user;

--
-- Name: events; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.events (
    stream_ordering integer NOT NULL,
    topological_ordering bigint NOT NULL,
    event_id text NOT NULL,
    type text NOT NULL,
    room_id text NOT NULL,
    content text,
    unrecognized_keys text,
    processed boolean NOT NULL,
    outlier boolean NOT NULL,
    depth bigint DEFAULT 0 NOT NULL,
    origin_server_ts bigint,
    received_ts bigint,
    sender text,
    contains_url boolean
);


ALTER TABLE public.events OWNER TO sip_user;

--
-- Name: ex_outlier_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.ex_outlier_stream (
    event_stream_ordering bigint NOT NULL,
    event_id text NOT NULL,
    state_group bigint NOT NULL
);


ALTER TABLE public.ex_outlier_stream OWNER TO sip_user;

--
-- Name: federation_stream_position; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.federation_stream_position (
    type text NOT NULL,
    stream_id integer NOT NULL
);


ALTER TABLE public.federation_stream_position OWNER TO sip_user;

--
-- Name: group_attestations_remote; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_attestations_remote (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL,
    attestation_json text NOT NULL
);


ALTER TABLE public.group_attestations_remote OWNER TO sip_user;

--
-- Name: group_attestations_renewals; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_attestations_renewals (
    group_id text NOT NULL,
    user_id text NOT NULL,
    valid_until_ms bigint NOT NULL
);


ALTER TABLE public.group_attestations_renewals OWNER TO sip_user;

--
-- Name: group_invites; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_invites (
    group_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.group_invites OWNER TO sip_user;

--
-- Name: group_roles; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_roles OWNER TO sip_user;

--
-- Name: group_room_categories; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    profile text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_room_categories OWNER TO sip_user;

--
-- Name: group_rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_rooms OWNER TO sip_user;

--
-- Name: group_summary_roles; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_summary_roles (
    group_id text NOT NULL,
    role_id text NOT NULL,
    role_order bigint NOT NULL,
    CONSTRAINT group_summary_roles_role_order_check CHECK ((role_order > 0))
);


ALTER TABLE public.group_summary_roles OWNER TO sip_user;

--
-- Name: group_summary_room_categories; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_summary_room_categories (
    group_id text NOT NULL,
    category_id text NOT NULL,
    cat_order bigint NOT NULL,
    CONSTRAINT group_summary_room_categories_cat_order_check CHECK ((cat_order > 0))
);


ALTER TABLE public.group_summary_room_categories OWNER TO sip_user;

--
-- Name: group_summary_rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_summary_rooms (
    group_id text NOT NULL,
    room_id text NOT NULL,
    category_id text NOT NULL,
    room_order bigint NOT NULL,
    is_public boolean NOT NULL,
    CONSTRAINT group_summary_rooms_room_order_check CHECK ((room_order > 0))
);


ALTER TABLE public.group_summary_rooms OWNER TO sip_user;

--
-- Name: group_summary_users; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_summary_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    role_id text NOT NULL,
    user_order bigint NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_summary_users OWNER TO sip_user;

--
-- Name: group_users; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.group_users (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    is_public boolean NOT NULL
);


ALTER TABLE public.group_users OWNER TO sip_user;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.groups (
    group_id text NOT NULL,
    name text,
    avatar_url text,
    short_description text,
    long_description text,
    is_public boolean NOT NULL,
    join_policy text DEFAULT 'invite'::text NOT NULL
);


ALTER TABLE public.groups OWNER TO sip_user;

--
-- Name: guest_access; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.guest_access (
    event_id text NOT NULL,
    room_id text NOT NULL,
    guest_access text NOT NULL
);


ALTER TABLE public.guest_access OWNER TO sip_user;

--
-- Name: history_visibility; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.history_visibility (
    event_id text NOT NULL,
    room_id text NOT NULL,
    history_visibility text NOT NULL
);


ALTER TABLE public.history_visibility OWNER TO sip_user;

--
-- Name: local_group_membership; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_group_membership (
    group_id text NOT NULL,
    user_id text NOT NULL,
    is_admin boolean NOT NULL,
    membership text NOT NULL,
    is_publicised boolean NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_membership OWNER TO sip_user;

--
-- Name: local_group_updates; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_group_updates (
    stream_id bigint NOT NULL,
    group_id text NOT NULL,
    user_id text NOT NULL,
    type text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.local_group_updates OWNER TO sip_user;

--
-- Name: local_invites; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_invites (
    stream_id bigint NOT NULL,
    inviter text NOT NULL,
    invitee text NOT NULL,
    event_id text NOT NULL,
    room_id text NOT NULL,
    locally_rejected text,
    replaced_by text
);


ALTER TABLE public.local_invites OWNER TO sip_user;

--
-- Name: local_media_repository; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_media_repository (
    media_id text,
    media_type text,
    media_length integer,
    created_ts bigint,
    upload_name text,
    user_id text,
    quarantined_by text,
    url_cache text,
    last_access_ts bigint
);


ALTER TABLE public.local_media_repository OWNER TO sip_user;

--
-- Name: local_media_repository_thumbnails; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_media_repository_thumbnails (
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_type text,
    thumbnail_method text,
    thumbnail_length integer
);


ALTER TABLE public.local_media_repository_thumbnails OWNER TO sip_user;

--
-- Name: local_media_repository_url_cache; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.local_media_repository_url_cache (
    url text,
    response_code integer,
    etag text,
    expires_ts bigint,
    og text,
    media_id text,
    download_ts bigint
);


ALTER TABLE public.local_media_repository_url_cache OWNER TO sip_user;

--
-- Name: monthly_active_users; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.monthly_active_users (
    user_id text NOT NULL,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.monthly_active_users OWNER TO sip_user;

--
-- Name: open_id_tokens; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.open_id_tokens (
    token text NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.open_id_tokens OWNER TO sip_user;

--
-- Name: presence; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.presence (
    user_id text NOT NULL,
    state character varying(20),
    status_msg text,
    mtime bigint
);


ALTER TABLE public.presence OWNER TO sip_user;

--
-- Name: presence_allow_inbound; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.presence_allow_inbound (
    observed_user_id text NOT NULL,
    observer_user_id text NOT NULL
);


ALTER TABLE public.presence_allow_inbound OWNER TO sip_user;

--
-- Name: presence_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.presence_stream (
    stream_id bigint,
    user_id text,
    state text,
    last_active_ts bigint,
    last_federation_update_ts bigint,
    last_user_sync_ts bigint,
    status_msg text,
    currently_active boolean
);


ALTER TABLE public.presence_stream OWNER TO sip_user;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.profiles (
    user_id text NOT NULL,
    displayname text,
    avatar_url text
);


ALTER TABLE public.profiles OWNER TO sip_user;

--
-- Name: public_room_list_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.public_room_list_stream (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    visibility boolean NOT NULL,
    appservice_id text,
    network_id text
);


ALTER TABLE public.public_room_list_stream OWNER TO sip_user;

--
-- Name: push_rules; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.push_rules (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    priority_class smallint NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    conditions text NOT NULL,
    actions text NOT NULL
);


ALTER TABLE public.push_rules OWNER TO sip_user;

--
-- Name: push_rules_enable; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.push_rules_enable (
    id bigint NOT NULL,
    user_name text NOT NULL,
    rule_id text NOT NULL,
    enabled smallint
);


ALTER TABLE public.push_rules_enable OWNER TO sip_user;

--
-- Name: push_rules_stream; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.push_rules_stream (
    stream_id bigint NOT NULL,
    event_stream_ordering bigint NOT NULL,
    user_id text NOT NULL,
    rule_id text NOT NULL,
    op text NOT NULL,
    priority_class smallint,
    priority integer,
    conditions text,
    actions text
);


ALTER TABLE public.push_rules_stream OWNER TO sip_user;

--
-- Name: pusher_throttle; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.pusher_throttle (
    pusher bigint NOT NULL,
    room_id text NOT NULL,
    last_sent_ts bigint,
    throttle_ms bigint
);


ALTER TABLE public.pusher_throttle OWNER TO sip_user;

--
-- Name: pushers; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.pushers (
    id bigint NOT NULL,
    user_name text NOT NULL,
    access_token bigint,
    profile_tag text NOT NULL,
    kind text NOT NULL,
    app_id text NOT NULL,
    app_display_name text NOT NULL,
    device_display_name text NOT NULL,
    pushkey text NOT NULL,
    ts bigint NOT NULL,
    lang text,
    data text,
    last_stream_ordering integer,
    last_success bigint,
    failing_since bigint
);


ALTER TABLE public.pushers OWNER TO sip_user;

--
-- Name: ratelimit_override; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.ratelimit_override (
    user_id text NOT NULL,
    messages_per_second bigint,
    burst_count bigint
);


ALTER TABLE public.ratelimit_override OWNER TO sip_user;

--
-- Name: receipts_graph; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.receipts_graph (
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_ids text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.receipts_graph OWNER TO sip_user;

--
-- Name: receipts_linearized; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.receipts_linearized (
    stream_id bigint NOT NULL,
    room_id text NOT NULL,
    receipt_type text NOT NULL,
    user_id text NOT NULL,
    event_id text NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.receipts_linearized OWNER TO sip_user;

--
-- Name: received_transactions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.received_transactions (
    transaction_id text,
    origin text,
    ts bigint,
    response_code integer,
    response_json bytea,
    has_been_referenced smallint DEFAULT 0
);


ALTER TABLE public.received_transactions OWNER TO sip_user;

--
-- Name: redactions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.redactions (
    event_id text NOT NULL,
    redacts text NOT NULL,
    have_censored boolean DEFAULT false NOT NULL,
    received_ts bigint
);


ALTER TABLE public.redactions OWNER TO sip_user;

--
-- Name: rejections; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.rejections (
    event_id text NOT NULL,
    reason text NOT NULL,
    last_check text NOT NULL
);


ALTER TABLE public.rejections OWNER TO sip_user;

--
-- Name: remote_media_cache; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.remote_media_cache (
    media_origin text,
    media_id text,
    media_type text,
    created_ts bigint,
    upload_name text,
    media_length integer,
    filesystem_id text,
    last_access_ts bigint,
    quarantined_by text
);


ALTER TABLE public.remote_media_cache OWNER TO sip_user;

--
-- Name: remote_media_cache_thumbnails; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.remote_media_cache_thumbnails (
    media_origin text,
    media_id text,
    thumbnail_width integer,
    thumbnail_height integer,
    thumbnail_method text,
    thumbnail_type text,
    thumbnail_length integer,
    filesystem_id text
);


ALTER TABLE public.remote_media_cache_thumbnails OWNER TO sip_user;

--
-- Name: remote_profile_cache; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.remote_profile_cache (
    user_id text NOT NULL,
    displayname text,
    avatar_url text,
    last_check bigint NOT NULL
);


ALTER TABLE public.remote_profile_cache OWNER TO sip_user;

--
-- Name: room_account_data; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_account_data (
    user_id text NOT NULL,
    room_id text NOT NULL,
    account_data_type text NOT NULL,
    stream_id bigint NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.room_account_data OWNER TO sip_user;

--
-- Name: room_alias_servers; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_alias_servers (
    room_alias text NOT NULL,
    server text NOT NULL
);


ALTER TABLE public.room_alias_servers OWNER TO sip_user;

--
-- Name: room_aliases; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_aliases (
    room_alias text NOT NULL,
    room_id text NOT NULL,
    creator text
);


ALTER TABLE public.room_aliases OWNER TO sip_user;

--
-- Name: room_depth; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_depth (
    room_id text NOT NULL,
    min_depth integer NOT NULL
);


ALTER TABLE public.room_depth OWNER TO sip_user;

--
-- Name: room_memberships; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_memberships (
    event_id text NOT NULL,
    user_id text NOT NULL,
    sender text NOT NULL,
    room_id text NOT NULL,
    membership text NOT NULL,
    forgotten integer DEFAULT 0,
    display_name text,
    avatar_url text
);


ALTER TABLE public.room_memberships OWNER TO sip_user;

--
-- Name: room_names; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_names (
    event_id text NOT NULL,
    room_id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.room_names OWNER TO sip_user;

--
-- Name: room_stats_current; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_stats_current (
    room_id text NOT NULL,
    current_state_events integer NOT NULL,
    joined_members integer NOT NULL,
    invited_members integer NOT NULL,
    left_members integer NOT NULL,
    banned_members integer NOT NULL,
    local_users_in_room integer NOT NULL,
    completed_delta_stream_id bigint NOT NULL
);


ALTER TABLE public.room_stats_current OWNER TO sip_user;

--
-- Name: room_stats_earliest_token; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_stats_earliest_token (
    room_id text NOT NULL,
    token bigint NOT NULL
);


ALTER TABLE public.room_stats_earliest_token OWNER TO sip_user;

--
-- Name: room_stats_historical; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_stats_historical (
    room_id text NOT NULL,
    end_ts bigint NOT NULL,
    bucket_size bigint NOT NULL,
    current_state_events bigint NOT NULL,
    joined_members bigint NOT NULL,
    invited_members bigint NOT NULL,
    left_members bigint NOT NULL,
    banned_members bigint NOT NULL,
    local_users_in_room bigint NOT NULL,
    total_events bigint NOT NULL,
    total_event_bytes bigint NOT NULL
);


ALTER TABLE public.room_stats_historical OWNER TO sip_user;

--
-- Name: room_stats_state; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_stats_state (
    room_id text NOT NULL,
    name text,
    canonical_alias text,
    join_rules text,
    history_visibility text,
    encryption text,
    avatar text,
    guest_access text,
    is_federatable boolean,
    topic text
);


ALTER TABLE public.room_stats_state OWNER TO sip_user;

--
-- Name: room_tags; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_tags (
    user_id text NOT NULL,
    room_id text NOT NULL,
    tag text NOT NULL,
    content text NOT NULL
);


ALTER TABLE public.room_tags OWNER TO sip_user;

--
-- Name: room_tags_revisions; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.room_tags_revisions (
    user_id text NOT NULL,
    room_id text NOT NULL,
    stream_id bigint NOT NULL
);


ALTER TABLE public.room_tags_revisions OWNER TO sip_user;

--
-- Name: rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.rooms (
    room_id text NOT NULL,
    is_public boolean,
    creator text
);


ALTER TABLE public.rooms OWNER TO sip_user;

--
-- Name: schema_version; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.schema_version (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    version integer NOT NULL,
    upgraded boolean NOT NULL,
    CONSTRAINT schema_version_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.schema_version OWNER TO sip_user;

--
-- Name: server_keys_json; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.server_keys_json (
    server_name text NOT NULL,
    key_id text NOT NULL,
    from_server text NOT NULL,
    ts_added_ms bigint NOT NULL,
    ts_valid_until_ms bigint NOT NULL,
    key_json bytea NOT NULL
);


ALTER TABLE public.server_keys_json OWNER TO sip_user;

--
-- Name: server_signature_keys; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.server_signature_keys (
    server_name text,
    key_id text,
    from_server text,
    ts_added_ms bigint,
    verify_key bytea,
    ts_valid_until_ms bigint
);


ALTER TABLE public.server_signature_keys OWNER TO sip_user;

--
-- Name: state_events; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.state_events (
    event_id text NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    prev_state text
);


ALTER TABLE public.state_events OWNER TO sip_user;

--
-- Name: state_group_edges; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.state_group_edges (
    state_group bigint NOT NULL,
    prev_state_group bigint NOT NULL
);


ALTER TABLE public.state_group_edges OWNER TO sip_user;

--
-- Name: state_group_id_seq; Type: SEQUENCE; Schema: public; Owner: sip_user
--

CREATE SEQUENCE public.state_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_group_id_seq OWNER TO sip_user;

--
-- Name: state_groups; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.state_groups (
    id bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.state_groups OWNER TO sip_user;

--
-- Name: state_groups_state; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.state_groups_state (
    state_group bigint NOT NULL,
    room_id text NOT NULL,
    type text NOT NULL,
    state_key text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.state_groups_state OWNER TO sip_user;

--
-- Name: stats_incremental_position; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.stats_incremental_position (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint NOT NULL,
    CONSTRAINT stats_incremental_position_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.stats_incremental_position OWNER TO sip_user;

--
-- Name: stream_ordering_to_exterm; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.stream_ordering_to_exterm (
    stream_ordering bigint NOT NULL,
    room_id text NOT NULL,
    event_id text NOT NULL
);


ALTER TABLE public.stream_ordering_to_exterm OWNER TO sip_user;

--
-- Name: threepid_guest_access_tokens; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.threepid_guest_access_tokens (
    medium text,
    address text,
    guest_access_token text,
    first_inviter text
);


ALTER TABLE public.threepid_guest_access_tokens OWNER TO sip_user;

--
-- Name: threepid_validation_session; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.threepid_validation_session (
    session_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    client_secret text NOT NULL,
    last_send_attempt bigint NOT NULL,
    validated_at bigint
);


ALTER TABLE public.threepid_validation_session OWNER TO sip_user;

--
-- Name: threepid_validation_token; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.threepid_validation_token (
    token text NOT NULL,
    session_id text NOT NULL,
    next_link text,
    expires bigint NOT NULL
);


ALTER TABLE public.threepid_validation_token OWNER TO sip_user;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.topics (
    event_id text NOT NULL,
    room_id text NOT NULL,
    topic text NOT NULL
);


ALTER TABLE public.topics OWNER TO sip_user;

--
-- Name: user_daily_visits; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_daily_visits (
    user_id text NOT NULL,
    device_id text,
    "timestamp" bigint NOT NULL
);


ALTER TABLE public.user_daily_visits OWNER TO sip_user;

--
-- Name: user_directory; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_directory (
    user_id text NOT NULL,
    room_id text,
    display_name text,
    avatar_url text
);


ALTER TABLE public.user_directory OWNER TO sip_user;

--
-- Name: user_directory_search; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_directory_search (
    user_id text NOT NULL,
    vector tsvector
);


ALTER TABLE public.user_directory_search OWNER TO sip_user;

--
-- Name: user_directory_stream_pos; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_directory_stream_pos (
    lock character(1) DEFAULT 'X'::bpchar NOT NULL,
    stream_id bigint,
    CONSTRAINT user_directory_stream_pos_lock_check CHECK ((lock = 'X'::bpchar))
);


ALTER TABLE public.user_directory_stream_pos OWNER TO sip_user;

--
-- Name: user_external_ids; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_external_ids (
    auth_provider text NOT NULL,
    external_id text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.user_external_ids OWNER TO sip_user;

--
-- Name: user_filters; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_filters (
    user_id text,
    filter_id bigint,
    filter_json bytea
);


ALTER TABLE public.user_filters OWNER TO sip_user;

--
-- Name: user_ips; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_ips (
    user_id text NOT NULL,
    access_token text NOT NULL,
    device_id text,
    ip text NOT NULL,
    user_agent text NOT NULL,
    last_seen bigint NOT NULL
);


ALTER TABLE public.user_ips OWNER TO sip_user;

--
-- Name: user_stats_current; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_stats_current (
    user_id text NOT NULL,
    joined_rooms bigint NOT NULL,
    completed_delta_stream_id bigint NOT NULL
);


ALTER TABLE public.user_stats_current OWNER TO sip_user;

--
-- Name: user_stats_historical; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_stats_historical (
    user_id text NOT NULL,
    end_ts bigint NOT NULL,
    bucket_size bigint NOT NULL,
    joined_rooms bigint NOT NULL,
    invites_sent bigint NOT NULL,
    rooms_created bigint NOT NULL,
    total_events bigint NOT NULL,
    total_event_bytes bigint NOT NULL
);


ALTER TABLE public.user_stats_historical OWNER TO sip_user;

--
-- Name: user_threepid_id_server; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_threepid_id_server (
    user_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    id_server text NOT NULL
);


ALTER TABLE public.user_threepid_id_server OWNER TO sip_user;

--
-- Name: user_threepids; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.user_threepids (
    user_id text NOT NULL,
    medium text NOT NULL,
    address text NOT NULL,
    validated_at bigint NOT NULL,
    added_at bigint NOT NULL
);


ALTER TABLE public.user_threepids OWNER TO sip_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.users (
    name text,
    password_hash text,
    creation_ts bigint,
    admin smallint DEFAULT 0 NOT NULL,
    upgrade_ts bigint,
    is_guest smallint DEFAULT 0 NOT NULL,
    appservice_id text,
    consent_version text,
    consent_server_notice_sent text,
    user_type text,
    deactivated smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO sip_user;

--
-- Name: users_in_public_rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.users_in_public_rooms (
    user_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.users_in_public_rooms OWNER TO sip_user;

--
-- Name: users_pending_deactivation; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.users_pending_deactivation (
    user_id text NOT NULL
);


ALTER TABLE public.users_pending_deactivation OWNER TO sip_user;

--
-- Name: users_who_share_private_rooms; Type: TABLE; Schema: public; Owner: sip_user
--

CREATE TABLE public.users_who_share_private_rooms (
    user_id text NOT NULL,
    other_user_id text NOT NULL,
    room_id text NOT NULL
);


ALTER TABLE public.users_who_share_private_rooms OWNER TO sip_user;

--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.access_tokens (id, user_id, device_id, token, last_used, valid_until_ms) FROM stdin;
\.


--
-- Data for Name: account_data; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.account_data (user_id, account_data_type, stream_id, content) FROM stdin;
\.


--
-- Data for Name: account_data_max_stream_id; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.account_data_max_stream_id (lock, stream_id) FROM stdin;
\.


--
-- Data for Name: account_validity; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.account_validity (user_id, expiration_ts_ms, email_sent, renewal_token) FROM stdin;
\.


--
-- Data for Name: application_services_state; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.application_services_state (as_id, state, last_txn) FROM stdin;
\.


--
-- Data for Name: application_services_txns; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.application_services_txns (as_id, txn_id, event_ids) FROM stdin;
\.


--
-- Data for Name: applied_module_schemas; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.applied_module_schemas (module_name, file) FROM stdin;
\.


--
-- Data for Name: applied_schema_deltas; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.applied_schema_deltas (version, file) FROM stdin;
55	55/access_token_expiry.sql
55	55/track_threepid_validations.sql
55	55/users_alter_deactivated.sql
56	56/add_spans_to_device_lists.sql
56	56/current_state_events_membership.sql
56	56/current_state_events_membership_mk2.sql
56	56/destinations_failure_ts.sql
56	56/destinations_retry_interval_type.sql.postgres
56	56/devices_last_seen.sql
56	56/fix_room_keys_index.sql
56	56/redaction_censor.sql
56	56/redaction_censor2.sql
56	56/room_membership_idx.sql
56	56/stats_separated.sql
56	56/user_external_ids.sql
56	56/users_in_public_rooms_idx.sql
\.


--
-- Data for Name: appservice_room_list; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.appservice_room_list (appservice_id, network_id, room_id) FROM stdin;
\.


--
-- Data for Name: appservice_stream_position; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.appservice_stream_position (lock, stream_ordering) FROM stdin;
X	0
\.


--
-- Data for Name: background_updates; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.background_updates (update_name, progress_json, depends_on) FROM stdin;
\.


--
-- Data for Name: blocked_rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.blocked_rooms (room_id, user_id) FROM stdin;
\.


--
-- Data for Name: cache_invalidation_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.cache_invalidation_stream (stream_id, cache_func, keys, invalidation_ts) FROM stdin;
\.


--
-- Data for Name: current_state_delta_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.current_state_delta_stream (stream_id, room_id, type, state_key, event_id, prev_event_id) FROM stdin;
\.


--
-- Data for Name: current_state_events; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.current_state_events (event_id, room_id, type, state_key, membership) FROM stdin;
\.


--
-- Data for Name: deleted_pushers; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.deleted_pushers (stream_id, app_id, pushkey, user_id) FROM stdin;
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.destinations (destination, retry_last_ts, retry_interval, failure_ts) FROM stdin;
\.


--
-- Data for Name: device_federation_inbox; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_federation_inbox (origin, message_id, received_ts) FROM stdin;
\.


--
-- Data for Name: device_federation_outbox; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_federation_outbox (destination, stream_id, queued_ts, messages_json) FROM stdin;
\.


--
-- Data for Name: device_inbox; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_inbox (user_id, device_id, stream_id, message_json) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_last_success; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_lists_outbound_last_success (destination, user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_outbound_pokes; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_lists_outbound_pokes (destination, stream_id, user_id, device_id, sent, ts, opentracing_context) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_cache; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_lists_remote_cache (user_id, device_id, content) FROM stdin;
\.


--
-- Data for Name: device_lists_remote_extremeties; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_lists_remote_extremeties (user_id, stream_id) FROM stdin;
\.


--
-- Data for Name: device_lists_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_lists_stream (stream_id, user_id, device_id) FROM stdin;
\.


--
-- Data for Name: device_max_stream_id; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.device_max_stream_id (stream_id) FROM stdin;
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.devices (user_id, device_id, display_name, last_seen, ip, user_agent) FROM stdin;
\.


--
-- Data for Name: e2e_device_keys_json; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.e2e_device_keys_json (user_id, device_id, ts_added_ms, key_json) FROM stdin;
\.


--
-- Data for Name: e2e_one_time_keys_json; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.e2e_one_time_keys_json (user_id, device_id, algorithm, key_id, ts_added_ms, key_json) FROM stdin;
\.


--
-- Data for Name: e2e_room_keys; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.e2e_room_keys (user_id, room_id, session_id, version, first_message_index, forwarded_count, is_verified, session_data) FROM stdin;
\.


--
-- Data for Name: e2e_room_keys_versions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.e2e_room_keys_versions (user_id, version, algorithm, auth_data, deleted) FROM stdin;
\.


--
-- Data for Name: erased_users; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.erased_users (user_id) FROM stdin;
\.


--
-- Data for Name: event_auth; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_auth (event_id, auth_id, room_id) FROM stdin;
\.


--
-- Data for Name: event_backward_extremities; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_backward_extremities (event_id, room_id) FROM stdin;
\.


--
-- Data for Name: event_edges; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_edges (event_id, prev_event_id, room_id, is_state) FROM stdin;
\.


--
-- Data for Name: event_forward_extremities; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_forward_extremities (event_id, room_id) FROM stdin;
\.


--
-- Data for Name: event_json; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_json (event_id, room_id, internal_metadata, json, format_version) FROM stdin;
\.


--
-- Data for Name: event_push_actions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_push_actions (room_id, event_id, user_id, profile_tag, actions, topological_ordering, stream_ordering, notif, highlight) FROM stdin;
\.


--
-- Data for Name: event_push_actions_staging; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_push_actions_staging (event_id, user_id, actions, notif, highlight) FROM stdin;
\.


--
-- Data for Name: event_push_summary; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_push_summary (user_id, room_id, notif_count, stream_ordering) FROM stdin;
\.


--
-- Data for Name: event_push_summary_stream_ordering; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_push_summary_stream_ordering (lock, stream_ordering) FROM stdin;
X	0
\.


--
-- Data for Name: event_reference_hashes; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_reference_hashes (event_id, algorithm, hash) FROM stdin;
\.


--
-- Data for Name: event_relations; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_relations (event_id, relates_to_id, relation_type, aggregation_key) FROM stdin;
\.


--
-- Data for Name: event_reports; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_reports (id, received_ts, room_id, event_id, user_id, reason, content) FROM stdin;
\.


--
-- Data for Name: event_search; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_search (event_id, room_id, sender, key, vector, origin_server_ts, stream_ordering) FROM stdin;
\.


--
-- Data for Name: event_to_state_groups; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.event_to_state_groups (event_id, state_group) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.events (stream_ordering, topological_ordering, event_id, type, room_id, content, unrecognized_keys, processed, outlier, depth, origin_server_ts, received_ts, sender, contains_url) FROM stdin;
\.


--
-- Data for Name: ex_outlier_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.ex_outlier_stream (event_stream_ordering, event_id, state_group) FROM stdin;
\.


--
-- Data for Name: federation_stream_position; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.federation_stream_position (type, stream_id) FROM stdin;
federation	-1
events	-1
\.


--
-- Data for Name: group_attestations_remote; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_attestations_remote (group_id, user_id, valid_until_ms, attestation_json) FROM stdin;
\.


--
-- Data for Name: group_attestations_renewals; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_attestations_renewals (group_id, user_id, valid_until_ms) FROM stdin;
\.


--
-- Data for Name: group_invites; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_invites (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: group_roles; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_roles (group_id, role_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_room_categories; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_room_categories (group_id, category_id, profile, is_public) FROM stdin;
\.


--
-- Data for Name: group_rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_rooms (group_id, room_id, is_public) FROM stdin;
\.


--
-- Data for Name: group_summary_roles; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_summary_roles (group_id, role_id, role_order) FROM stdin;
\.


--
-- Data for Name: group_summary_room_categories; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_summary_room_categories (group_id, category_id, cat_order) FROM stdin;
\.


--
-- Data for Name: group_summary_rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_summary_rooms (group_id, room_id, category_id, room_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_summary_users; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_summary_users (group_id, user_id, role_id, user_order, is_public) FROM stdin;
\.


--
-- Data for Name: group_users; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.group_users (group_id, user_id, is_admin, is_public) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.groups (group_id, name, avatar_url, short_description, long_description, is_public, join_policy) FROM stdin;
\.


--
-- Data for Name: guest_access; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.guest_access (event_id, room_id, guest_access) FROM stdin;
\.


--
-- Data for Name: history_visibility; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.history_visibility (event_id, room_id, history_visibility) FROM stdin;
\.


--
-- Data for Name: local_group_membership; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_group_membership (group_id, user_id, is_admin, membership, is_publicised, content) FROM stdin;
\.


--
-- Data for Name: local_group_updates; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_group_updates (stream_id, group_id, user_id, type, content) FROM stdin;
\.


--
-- Data for Name: local_invites; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_invites (stream_id, inviter, invitee, event_id, room_id, locally_rejected, replaced_by) FROM stdin;
\.


--
-- Data for Name: local_media_repository; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_media_repository (media_id, media_type, media_length, created_ts, upload_name, user_id, quarantined_by, url_cache, last_access_ts) FROM stdin;
\.


--
-- Data for Name: local_media_repository_thumbnails; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_media_repository_thumbnails (media_id, thumbnail_width, thumbnail_height, thumbnail_type, thumbnail_method, thumbnail_length) FROM stdin;
\.


--
-- Data for Name: local_media_repository_url_cache; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.local_media_repository_url_cache (url, response_code, etag, expires_ts, og, media_id, download_ts) FROM stdin;
\.


--
-- Data for Name: monthly_active_users; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.monthly_active_users (user_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: open_id_tokens; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.open_id_tokens (token, ts_valid_until_ms, user_id) FROM stdin;
\.


--
-- Data for Name: presence; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.presence (user_id, state, status_msg, mtime) FROM stdin;
\.


--
-- Data for Name: presence_allow_inbound; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.presence_allow_inbound (observed_user_id, observer_user_id) FROM stdin;
\.


--
-- Data for Name: presence_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.presence_stream (stream_id, user_id, state, last_active_ts, last_federation_update_ts, last_user_sync_ts, status_msg, currently_active) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.profiles (user_id, displayname, avatar_url) FROM stdin;
\.


--
-- Data for Name: public_room_list_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.public_room_list_stream (stream_id, room_id, visibility, appservice_id, network_id) FROM stdin;
\.


--
-- Data for Name: push_rules; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.push_rules (id, user_name, rule_id, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: push_rules_enable; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.push_rules_enable (id, user_name, rule_id, enabled) FROM stdin;
\.


--
-- Data for Name: push_rules_stream; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.push_rules_stream (stream_id, event_stream_ordering, user_id, rule_id, op, priority_class, priority, conditions, actions) FROM stdin;
\.


--
-- Data for Name: pusher_throttle; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.pusher_throttle (pusher, room_id, last_sent_ts, throttle_ms) FROM stdin;
\.


--
-- Data for Name: pushers; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.pushers (id, user_name, access_token, profile_tag, kind, app_id, app_display_name, device_display_name, pushkey, ts, lang, data, last_stream_ordering, last_success, failing_since) FROM stdin;
\.


--
-- Data for Name: ratelimit_override; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.ratelimit_override (user_id, messages_per_second, burst_count) FROM stdin;
\.


--
-- Data for Name: receipts_graph; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.receipts_graph (room_id, receipt_type, user_id, event_ids, data) FROM stdin;
\.


--
-- Data for Name: receipts_linearized; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.receipts_linearized (stream_id, room_id, receipt_type, user_id, event_id, data) FROM stdin;
\.


--
-- Data for Name: received_transactions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.received_transactions (transaction_id, origin, ts, response_code, response_json, has_been_referenced) FROM stdin;
\.


--
-- Data for Name: redactions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.redactions (event_id, redacts, have_censored, received_ts) FROM stdin;
\.


--
-- Data for Name: rejections; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.rejections (event_id, reason, last_check) FROM stdin;
\.


--
-- Data for Name: remote_media_cache; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.remote_media_cache (media_origin, media_id, media_type, created_ts, upload_name, media_length, filesystem_id, last_access_ts, quarantined_by) FROM stdin;
\.


--
-- Data for Name: remote_media_cache_thumbnails; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.remote_media_cache_thumbnails (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_method, thumbnail_type, thumbnail_length, filesystem_id) FROM stdin;
\.


--
-- Data for Name: remote_profile_cache; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.remote_profile_cache (user_id, displayname, avatar_url, last_check) FROM stdin;
\.


--
-- Data for Name: room_account_data; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_account_data (user_id, room_id, account_data_type, stream_id, content) FROM stdin;
\.


--
-- Data for Name: room_alias_servers; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_alias_servers (room_alias, server) FROM stdin;
\.


--
-- Data for Name: room_aliases; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_aliases (room_alias, room_id, creator) FROM stdin;
\.


--
-- Data for Name: room_depth; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_depth (room_id, min_depth) FROM stdin;
\.


--
-- Data for Name: room_memberships; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_memberships (event_id, user_id, sender, room_id, membership, forgotten, display_name, avatar_url) FROM stdin;
\.


--
-- Data for Name: room_names; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_names (event_id, room_id, name) FROM stdin;
\.


--
-- Data for Name: room_stats_current; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_stats_current (room_id, current_state_events, joined_members, invited_members, left_members, banned_members, local_users_in_room, completed_delta_stream_id) FROM stdin;
\.


--
-- Data for Name: room_stats_earliest_token; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_stats_earliest_token (room_id, token) FROM stdin;
\.


--
-- Data for Name: room_stats_historical; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_stats_historical (room_id, end_ts, bucket_size, current_state_events, joined_members, invited_members, left_members, banned_members, local_users_in_room, total_events, total_event_bytes) FROM stdin;
\.


--
-- Data for Name: room_stats_state; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_stats_state (room_id, name, canonical_alias, join_rules, history_visibility, encryption, avatar, guest_access, is_federatable, topic) FROM stdin;
\.


--
-- Data for Name: room_tags; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_tags (user_id, room_id, tag, content) FROM stdin;
\.


--
-- Data for Name: room_tags_revisions; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.room_tags_revisions (user_id, room_id, stream_id) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.rooms (room_id, is_public, creator) FROM stdin;
\.


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.schema_version (lock, version, upgraded) FROM stdin;
X	56	t
\.


--
-- Data for Name: server_keys_json; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.server_keys_json (server_name, key_id, from_server, ts_added_ms, ts_valid_until_ms, key_json) FROM stdin;
\.


--
-- Data for Name: server_signature_keys; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.server_signature_keys (server_name, key_id, from_server, ts_added_ms, verify_key, ts_valid_until_ms) FROM stdin;
\.


--
-- Data for Name: state_events; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.state_events (event_id, room_id, type, state_key, prev_state) FROM stdin;
\.


--
-- Data for Name: state_group_edges; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.state_group_edges (state_group, prev_state_group) FROM stdin;
\.


--
-- Data for Name: state_groups; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.state_groups (id, room_id, event_id) FROM stdin;
\.


--
-- Data for Name: state_groups_state; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.state_groups_state (state_group, room_id, type, state_key, event_id) FROM stdin;
\.


--
-- Data for Name: stats_incremental_position; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.stats_incremental_position (lock, stream_id) FROM stdin;
X	1
\.


--
-- Data for Name: stream_ordering_to_exterm; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.stream_ordering_to_exterm (stream_ordering, room_id, event_id) FROM stdin;
\.


--
-- Data for Name: threepid_guest_access_tokens; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.threepid_guest_access_tokens (medium, address, guest_access_token, first_inviter) FROM stdin;
\.


--
-- Data for Name: threepid_validation_session; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.threepid_validation_session (session_id, medium, address, client_secret, last_send_attempt, validated_at) FROM stdin;
\.


--
-- Data for Name: threepid_validation_token; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.threepid_validation_token (token, session_id, next_link, expires) FROM stdin;
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.topics (event_id, room_id, topic) FROM stdin;
\.


--
-- Data for Name: user_daily_visits; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_daily_visits (user_id, device_id, "timestamp") FROM stdin;
\.


--
-- Data for Name: user_directory; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_directory (user_id, room_id, display_name, avatar_url) FROM stdin;
\.


--
-- Data for Name: user_directory_search; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_directory_search (user_id, vector) FROM stdin;
\.


--
-- Data for Name: user_directory_stream_pos; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_directory_stream_pos (lock, stream_id) FROM stdin;
X	0
\.


--
-- Data for Name: user_external_ids; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_external_ids (auth_provider, external_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_filters; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_filters (user_id, filter_id, filter_json) FROM stdin;
\.


--
-- Data for Name: user_ips; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_ips (user_id, access_token, device_id, ip, user_agent, last_seen) FROM stdin;
\.


--
-- Data for Name: user_stats_current; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_stats_current (user_id, joined_rooms, completed_delta_stream_id) FROM stdin;
\.


--
-- Data for Name: user_stats_historical; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_stats_historical (user_id, end_ts, bucket_size, joined_rooms, invites_sent, rooms_created, total_events, total_event_bytes) FROM stdin;
\.


--
-- Data for Name: user_threepid_id_server; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_threepid_id_server (user_id, medium, address, id_server) FROM stdin;
\.


--
-- Data for Name: user_threepids; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.user_threepids (user_id, medium, address, validated_at, added_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.users (name, password_hash, creation_ts, admin, upgrade_ts, is_guest, appservice_id, consent_version, consent_server_notice_sent, user_type, deactivated) FROM stdin;
\.


--
-- Data for Name: users_in_public_rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.users_in_public_rooms (user_id, room_id) FROM stdin;
\.


--
-- Data for Name: users_pending_deactivation; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.users_pending_deactivation (user_id) FROM stdin;
\.


--
-- Data for Name: users_who_share_private_rooms; Type: TABLE DATA; Schema: public; Owner: sip_user
--

COPY public.users_who_share_private_rooms (user_id, other_user_id, room_id) FROM stdin;
\.


--
-- Name: state_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sip_user
--

SELECT pg_catalog.setval('public.state_group_id_seq', 1, false);


--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (id);


--
-- Name: access_tokens access_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_token_key UNIQUE (token);


--
-- Name: account_data account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.account_data
    ADD CONSTRAINT account_data_uniqueness UNIQUE (user_id, account_data_type);


--
-- Name: account_validity account_validity_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.account_validity
    ADD CONSTRAINT account_validity_pkey PRIMARY KEY (user_id);


--
-- Name: application_services_state application_services_state_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.application_services_state
    ADD CONSTRAINT application_services_state_pkey PRIMARY KEY (as_id);


--
-- Name: application_services_txns application_services_txns_as_id_txn_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.application_services_txns
    ADD CONSTRAINT application_services_txns_as_id_txn_id_key UNIQUE (as_id, txn_id);


--
-- Name: applied_module_schemas applied_module_schemas_module_name_file_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.applied_module_schemas
    ADD CONSTRAINT applied_module_schemas_module_name_file_key UNIQUE (module_name, file);


--
-- Name: applied_schema_deltas applied_schema_deltas_version_file_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.applied_schema_deltas
    ADD CONSTRAINT applied_schema_deltas_version_file_key UNIQUE (version, file);


--
-- Name: appservice_stream_position appservice_stream_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.appservice_stream_position
    ADD CONSTRAINT appservice_stream_position_lock_key UNIQUE (lock);


--
-- Name: background_updates background_updates_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.background_updates
    ADD CONSTRAINT background_updates_uniqueness UNIQUE (update_name);


--
-- Name: current_state_events current_state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_event_id_key UNIQUE (event_id);


--
-- Name: current_state_events current_state_events_room_id_type_state_key_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.current_state_events
    ADD CONSTRAINT current_state_events_room_id_type_state_key_key UNIQUE (room_id, type, state_key);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (destination);


--
-- Name: devices device_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT device_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_device_keys_json e2e_device_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.e2e_device_keys_json
    ADD CONSTRAINT e2e_device_keys_json_uniqueness UNIQUE (user_id, device_id);


--
-- Name: e2e_one_time_keys_json e2e_one_time_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.e2e_one_time_keys_json
    ADD CONSTRAINT e2e_one_time_keys_json_uniqueness UNIQUE (user_id, device_id, algorithm, key_id);


--
-- Name: event_backward_extremities event_backward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_backward_extremities
    ADD CONSTRAINT event_backward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_edges event_edges_event_id_prev_event_id_room_id_is_state_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_edges
    ADD CONSTRAINT event_edges_event_id_prev_event_id_room_id_is_state_key UNIQUE (event_id, prev_event_id, room_id, is_state);


--
-- Name: event_forward_extremities event_forward_extremities_event_id_room_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_forward_extremities
    ADD CONSTRAINT event_forward_extremities_event_id_room_id_key UNIQUE (event_id, room_id);


--
-- Name: event_push_actions event_id_user_id_profile_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_push_actions
    ADD CONSTRAINT event_id_user_id_profile_tag_uniqueness UNIQUE (room_id, event_id, user_id, profile_tag);


--
-- Name: event_json event_json_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_json
    ADD CONSTRAINT event_json_event_id_key UNIQUE (event_id);


--
-- Name: event_push_summary_stream_ordering event_push_summary_stream_ordering_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_push_summary_stream_ordering
    ADD CONSTRAINT event_push_summary_stream_ordering_lock_key UNIQUE (lock);


--
-- Name: event_reference_hashes event_reference_hashes_event_id_algorithm_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_reference_hashes
    ADD CONSTRAINT event_reference_hashes_event_id_algorithm_key UNIQUE (event_id, algorithm);


--
-- Name: event_reports event_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_reports
    ADD CONSTRAINT event_reports_pkey PRIMARY KEY (id);


--
-- Name: event_to_state_groups event_to_state_groups_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.event_to_state_groups
    ADD CONSTRAINT event_to_state_groups_event_id_key UNIQUE (event_id);


--
-- Name: events events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_event_id_key UNIQUE (event_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (stream_ordering);


--
-- Name: ex_outlier_stream ex_outlier_stream_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.ex_outlier_stream
    ADD CONSTRAINT ex_outlier_stream_pkey PRIMARY KEY (event_stream_ordering);


--
-- Name: group_roles group_roles_group_id_role_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.group_roles
    ADD CONSTRAINT group_roles_group_id_role_id_key UNIQUE (group_id, role_id);


--
-- Name: group_room_categories group_room_categories_group_id_category_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.group_room_categories
    ADD CONSTRAINT group_room_categories_group_id_category_id_key UNIQUE (group_id, category_id);


--
-- Name: group_summary_roles group_summary_roles_group_id_role_id_role_order_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.group_summary_roles
    ADD CONSTRAINT group_summary_roles_group_id_role_id_role_order_key UNIQUE (group_id, role_id, role_order);


--
-- Name: group_summary_room_categories group_summary_room_categories_group_id_category_id_cat_orde_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.group_summary_room_categories
    ADD CONSTRAINT group_summary_room_categories_group_id_category_id_cat_orde_key UNIQUE (group_id, category_id, cat_order);


--
-- Name: group_summary_rooms group_summary_rooms_group_id_category_id_room_id_room_order_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.group_summary_rooms
    ADD CONSTRAINT group_summary_rooms_group_id_category_id_room_id_room_order_key UNIQUE (group_id, category_id, room_id, room_order);


--
-- Name: guest_access guest_access_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.guest_access
    ADD CONSTRAINT guest_access_event_id_key UNIQUE (event_id);


--
-- Name: history_visibility history_visibility_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.history_visibility
    ADD CONSTRAINT history_visibility_event_id_key UNIQUE (event_id);


--
-- Name: local_media_repository local_media_repository_media_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.local_media_repository
    ADD CONSTRAINT local_media_repository_media_id_key UNIQUE (media_id);


--
-- Name: local_media_repository_thumbnails local_media_repository_thumbn_media_id_thumbnail_width_thum_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.local_media_repository_thumbnails
    ADD CONSTRAINT local_media_repository_thumbn_media_id_thumbnail_width_thum_key UNIQUE (media_id, thumbnail_width, thumbnail_height, thumbnail_type);


--
-- Name: user_threepids medium_address; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.user_threepids
    ADD CONSTRAINT medium_address UNIQUE (medium, address);


--
-- Name: open_id_tokens open_id_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.open_id_tokens
    ADD CONSTRAINT open_id_tokens_pkey PRIMARY KEY (token);


--
-- Name: presence_allow_inbound presence_allow_inbound_observed_user_id_observer_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.presence_allow_inbound
    ADD CONSTRAINT presence_allow_inbound_observed_user_id_observer_user_id_key UNIQUE (observed_user_id, observer_user_id);


--
-- Name: presence presence_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_user_id_key UNIQUE (user_id);


--
-- Name: account_data_max_stream_id private_user_data_max_stream_id_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.account_data_max_stream_id
    ADD CONSTRAINT private_user_data_max_stream_id_lock_key UNIQUE (lock);


--
-- Name: profiles profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_key UNIQUE (user_id);


--
-- Name: push_rules_enable push_rules_enable_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_pkey PRIMARY KEY (id);


--
-- Name: push_rules_enable push_rules_enable_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.push_rules_enable
    ADD CONSTRAINT push_rules_enable_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: push_rules push_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_pkey PRIMARY KEY (id);


--
-- Name: push_rules push_rules_user_name_rule_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.push_rules
    ADD CONSTRAINT push_rules_user_name_rule_id_key UNIQUE (user_name, rule_id);


--
-- Name: pusher_throttle pusher_throttle_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.pusher_throttle
    ADD CONSTRAINT pusher_throttle_pkey PRIMARY KEY (pusher, room_id);


--
-- Name: pushers pushers2_app_id_pushkey_user_name_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_app_id_pushkey_user_name_key UNIQUE (app_id, pushkey, user_name);


--
-- Name: pushers pushers2_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.pushers
    ADD CONSTRAINT pushers2_pkey PRIMARY KEY (id);


--
-- Name: receipts_graph receipts_graph_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.receipts_graph
    ADD CONSTRAINT receipts_graph_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: receipts_linearized receipts_linearized_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.receipts_linearized
    ADD CONSTRAINT receipts_linearized_uniqueness UNIQUE (room_id, receipt_type, user_id);


--
-- Name: received_transactions received_transactions_transaction_id_origin_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.received_transactions
    ADD CONSTRAINT received_transactions_transaction_id_origin_key UNIQUE (transaction_id, origin);


--
-- Name: redactions redactions_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.redactions
    ADD CONSTRAINT redactions_event_id_key UNIQUE (event_id);


--
-- Name: rejections rejections_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.rejections
    ADD CONSTRAINT rejections_event_id_key UNIQUE (event_id);


--
-- Name: remote_media_cache remote_media_cache_media_origin_media_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.remote_media_cache
    ADD CONSTRAINT remote_media_cache_media_origin_media_id_key UNIQUE (media_origin, media_id);


--
-- Name: remote_media_cache_thumbnails remote_media_cache_thumbnails_media_origin_media_id_thumbna_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.remote_media_cache_thumbnails
    ADD CONSTRAINT remote_media_cache_thumbnails_media_origin_media_id_thumbna_key UNIQUE (media_origin, media_id, thumbnail_width, thumbnail_height, thumbnail_type);


--
-- Name: room_account_data room_account_data_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_account_data
    ADD CONSTRAINT room_account_data_uniqueness UNIQUE (user_id, room_id, account_data_type);


--
-- Name: room_aliases room_aliases_room_alias_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_aliases
    ADD CONSTRAINT room_aliases_room_alias_key UNIQUE (room_alias);


--
-- Name: room_depth room_depth_room_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_depth
    ADD CONSTRAINT room_depth_room_id_key UNIQUE (room_id);


--
-- Name: room_memberships room_memberships_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_memberships
    ADD CONSTRAINT room_memberships_event_id_key UNIQUE (event_id);


--
-- Name: room_names room_names_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_names
    ADD CONSTRAINT room_names_event_id_key UNIQUE (event_id);


--
-- Name: room_stats_current room_stats_current_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_stats_current
    ADD CONSTRAINT room_stats_current_pkey PRIMARY KEY (room_id);


--
-- Name: room_stats_historical room_stats_historical_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_stats_historical
    ADD CONSTRAINT room_stats_historical_pkey PRIMARY KEY (room_id, end_ts);


--
-- Name: room_tags_revisions room_tag_revisions_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_tags_revisions
    ADD CONSTRAINT room_tag_revisions_uniqueness UNIQUE (user_id, room_id);


--
-- Name: room_tags room_tag_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.room_tags
    ADD CONSTRAINT room_tag_uniqueness UNIQUE (user_id, room_id, tag);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);


--
-- Name: schema_version schema_version_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.schema_version
    ADD CONSTRAINT schema_version_lock_key UNIQUE (lock);


--
-- Name: server_keys_json server_keys_json_uniqueness; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.server_keys_json
    ADD CONSTRAINT server_keys_json_uniqueness UNIQUE (server_name, key_id, from_server);


--
-- Name: server_signature_keys server_signature_keys_server_name_key_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.server_signature_keys
    ADD CONSTRAINT server_signature_keys_server_name_key_id_key UNIQUE (server_name, key_id);


--
-- Name: state_events state_events_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.state_events
    ADD CONSTRAINT state_events_event_id_key UNIQUE (event_id);


--
-- Name: state_groups state_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.state_groups
    ADD CONSTRAINT state_groups_pkey PRIMARY KEY (id);


--
-- Name: stats_incremental_position stats_incremental_position_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.stats_incremental_position
    ADD CONSTRAINT stats_incremental_position_lock_key UNIQUE (lock);


--
-- Name: threepid_validation_session threepid_validation_session_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.threepid_validation_session
    ADD CONSTRAINT threepid_validation_session_pkey PRIMARY KEY (session_id);


--
-- Name: threepid_validation_token threepid_validation_token_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.threepid_validation_token
    ADD CONSTRAINT threepid_validation_token_pkey PRIMARY KEY (token);


--
-- Name: topics topics_event_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_event_id_key UNIQUE (event_id);


--
-- Name: user_directory_stream_pos user_directory_stream_pos_lock_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.user_directory_stream_pos
    ADD CONSTRAINT user_directory_stream_pos_lock_key UNIQUE (lock);


--
-- Name: user_external_ids user_external_ids_auth_provider_external_id_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.user_external_ids
    ADD CONSTRAINT user_external_ids_auth_provider_external_id_key UNIQUE (auth_provider, external_id);


--
-- Name: user_stats_current user_stats_current_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.user_stats_current
    ADD CONSTRAINT user_stats_current_pkey PRIMARY KEY (user_id);


--
-- Name: user_stats_historical user_stats_historical_pkey; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.user_stats_historical
    ADD CONSTRAINT user_stats_historical_pkey PRIMARY KEY (user_id, end_ts);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: sip_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: access_tokens_device_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX access_tokens_device_id ON public.access_tokens USING btree (user_id, device_id);


--
-- Name: account_data_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX account_data_stream_id ON public.account_data USING btree (user_id, stream_id);


--
-- Name: application_services_txns_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX application_services_txns_id ON public.application_services_txns USING btree (as_id);


--
-- Name: appservice_room_list_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX appservice_room_list_idx ON public.appservice_room_list USING btree (appservice_id, network_id, room_id);


--
-- Name: blocked_rooms_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX blocked_rooms_idx ON public.blocked_rooms USING btree (room_id);


--
-- Name: cache_invalidation_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX cache_invalidation_stream_id ON public.cache_invalidation_stream USING btree (stream_id);


--
-- Name: current_state_delta_stream_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX current_state_delta_stream_idx ON public.current_state_delta_stream USING btree (stream_id);


--
-- Name: current_state_events_member_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX current_state_events_member_index ON public.current_state_events USING btree (state_key) WHERE (type = 'm.room.member'::text);


--
-- Name: deleted_pushers_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX deleted_pushers_stream_id ON public.deleted_pushers USING btree (stream_id);


--
-- Name: device_federation_inbox_sender_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_federation_inbox_sender_id ON public.device_federation_inbox USING btree (origin, message_id);


--
-- Name: device_federation_outbox_destination_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_federation_outbox_destination_id ON public.device_federation_outbox USING btree (destination, stream_id);


--
-- Name: device_federation_outbox_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_federation_outbox_id ON public.device_federation_outbox USING btree (stream_id);


--
-- Name: device_inbox_stream_id_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_inbox_stream_id_user_id ON public.device_inbox USING btree (stream_id, user_id);


--
-- Name: device_inbox_user_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_inbox_user_stream_id ON public.device_inbox USING btree (user_id, device_id, stream_id);


--
-- Name: device_lists_outbound_last_success_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_outbound_last_success_idx ON public.device_lists_outbound_last_success USING btree (destination, user_id, stream_id);


--
-- Name: device_lists_outbound_pokes_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_outbound_pokes_id ON public.device_lists_outbound_pokes USING btree (destination, stream_id);


--
-- Name: device_lists_outbound_pokes_stream; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_outbound_pokes_stream ON public.device_lists_outbound_pokes USING btree (stream_id);


--
-- Name: device_lists_outbound_pokes_user; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_outbound_pokes_user ON public.device_lists_outbound_pokes USING btree (destination, user_id);


--
-- Name: device_lists_remote_cache_unique_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX device_lists_remote_cache_unique_id ON public.device_lists_remote_cache USING btree (user_id, device_id);


--
-- Name: device_lists_remote_extremeties_unique_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX device_lists_remote_extremeties_unique_idx ON public.device_lists_remote_extremeties USING btree (user_id);


--
-- Name: device_lists_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_stream_id ON public.device_lists_stream USING btree (stream_id, user_id);


--
-- Name: device_lists_stream_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX device_lists_stream_user_id ON public.device_lists_stream USING btree (user_id, device_id);


--
-- Name: e2e_room_keys_versions_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX e2e_room_keys_versions_idx ON public.e2e_room_keys_versions USING btree (user_id, version);


--
-- Name: e2e_room_keys_with_version_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX e2e_room_keys_with_version_idx ON public.e2e_room_keys USING btree (user_id, version, room_id, session_id);


--
-- Name: erased_users_user; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX erased_users_user ON public.erased_users USING btree (user_id);


--
-- Name: ev_b_extrem_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_b_extrem_id ON public.event_backward_extremities USING btree (event_id);


--
-- Name: ev_b_extrem_room; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_b_extrem_room ON public.event_backward_extremities USING btree (room_id);


--
-- Name: ev_edges_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_edges_id ON public.event_edges USING btree (event_id);


--
-- Name: ev_edges_prev_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_edges_prev_id ON public.event_edges USING btree (prev_event_id);


--
-- Name: ev_extrem_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_extrem_id ON public.event_forward_extremities USING btree (event_id);


--
-- Name: ev_extrem_room; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX ev_extrem_room ON public.event_forward_extremities USING btree (room_id);


--
-- Name: evauth_edges_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX evauth_edges_id ON public.event_auth USING btree (event_id);


--
-- Name: event_contains_url_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_contains_url_index ON public.events USING btree (room_id, topological_ordering, stream_ordering) WHERE ((contains_url = true) AND (outlier = false));


--
-- Name: event_json_room_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_json_room_id ON public.event_json USING btree (room_id);


--
-- Name: event_push_actions_highlights_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_highlights_index ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering) WHERE (highlight = 1);


--
-- Name: event_push_actions_rm_tokens; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_rm_tokens ON public.event_push_actions USING btree (user_id, room_id, topological_ordering, stream_ordering);


--
-- Name: event_push_actions_room_id_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_room_id_user_id ON public.event_push_actions USING btree (room_id, user_id);


--
-- Name: event_push_actions_staging_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_staging_id ON public.event_push_actions_staging USING btree (event_id);


--
-- Name: event_push_actions_stream_ordering; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_stream_ordering ON public.event_push_actions USING btree (stream_ordering, user_id);


--
-- Name: event_push_actions_u_highlight; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_actions_u_highlight ON public.event_push_actions USING btree (user_id, stream_ordering);


--
-- Name: event_push_summary_user_rm; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_push_summary_user_rm ON public.event_push_summary USING btree (user_id, room_id);


--
-- Name: event_reference_hashes_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_reference_hashes_id ON public.event_reference_hashes USING btree (event_id);


--
-- Name: event_relations_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX event_relations_id ON public.event_relations USING btree (event_id);


--
-- Name: event_relations_relates; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_relations_relates ON public.event_relations USING btree (relates_to_id, relation_type, aggregation_key);


--
-- Name: event_search_ev_ridx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_search_ev_ridx ON public.event_search USING btree (room_id);


--
-- Name: event_search_event_id_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX event_search_event_id_idx ON public.event_search USING btree (event_id);


--
-- Name: event_search_fts_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_search_fts_idx ON public.event_search USING gin (vector);


--
-- Name: event_to_state_groups_sg_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX event_to_state_groups_sg_index ON public.event_to_state_groups USING btree (state_group);


--
-- Name: events_order_room; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX events_order_room ON public.events USING btree (room_id, topological_ordering, stream_ordering);


--
-- Name: events_room_stream; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX events_room_stream ON public.events USING btree (room_id, stream_ordering);


--
-- Name: events_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX events_ts ON public.events USING btree (origin_server_ts, stream_ordering);


--
-- Name: group_attestations_remote_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_remote_g_idx ON public.group_attestations_remote USING btree (group_id, user_id);


--
-- Name: group_attestations_remote_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_remote_u_idx ON public.group_attestations_remote USING btree (user_id);


--
-- Name: group_attestations_remote_v_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_remote_v_idx ON public.group_attestations_remote USING btree (valid_until_ms);


--
-- Name: group_attestations_renewals_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_renewals_g_idx ON public.group_attestations_renewals USING btree (group_id, user_id);


--
-- Name: group_attestations_renewals_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_renewals_u_idx ON public.group_attestations_renewals USING btree (user_id);


--
-- Name: group_attestations_renewals_v_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_attestations_renewals_v_idx ON public.group_attestations_renewals USING btree (valid_until_ms);


--
-- Name: group_invites_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX group_invites_g_idx ON public.group_invites USING btree (group_id, user_id);


--
-- Name: group_invites_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_invites_u_idx ON public.group_invites USING btree (user_id);


--
-- Name: group_rooms_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX group_rooms_g_idx ON public.group_rooms USING btree (group_id, room_id);


--
-- Name: group_rooms_r_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_rooms_r_idx ON public.group_rooms USING btree (room_id);


--
-- Name: group_summary_rooms_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX group_summary_rooms_g_idx ON public.group_summary_rooms USING btree (group_id, room_id, category_id);


--
-- Name: group_summary_users_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_summary_users_g_idx ON public.group_summary_users USING btree (group_id);


--
-- Name: group_users_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX group_users_g_idx ON public.group_users USING btree (group_id, user_id);


--
-- Name: group_users_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX group_users_u_idx ON public.group_users USING btree (user_id);


--
-- Name: groups_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX groups_idx ON public.groups USING btree (group_id);


--
-- Name: local_group_membership_g_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_group_membership_g_idx ON public.local_group_membership USING btree (group_id);


--
-- Name: local_group_membership_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_group_membership_u_idx ON public.local_group_membership USING btree (user_id, group_id);


--
-- Name: local_invites_for_user_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_invites_for_user_idx ON public.local_invites USING btree (invitee, locally_rejected, replaced_by, room_id);


--
-- Name: local_invites_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_invites_id ON public.local_invites USING btree (stream_id);


--
-- Name: local_media_repository_thumbnails_media_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_media_repository_thumbnails_media_id ON public.local_media_repository_thumbnails USING btree (media_id);


--
-- Name: local_media_repository_url_cache_by_url_download_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_media_repository_url_cache_by_url_download_ts ON public.local_media_repository_url_cache USING btree (url, download_ts);


--
-- Name: local_media_repository_url_cache_expires_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_media_repository_url_cache_expires_idx ON public.local_media_repository_url_cache USING btree (expires_ts);


--
-- Name: local_media_repository_url_cache_media_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_media_repository_url_cache_media_idx ON public.local_media_repository_url_cache USING btree (media_id);


--
-- Name: local_media_repository_url_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX local_media_repository_url_idx ON public.local_media_repository USING btree (created_ts) WHERE (url_cache IS NOT NULL);


--
-- Name: monthly_active_users_time_stamp; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX monthly_active_users_time_stamp ON public.monthly_active_users USING btree ("timestamp");


--
-- Name: monthly_active_users_users; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX monthly_active_users_users ON public.monthly_active_users USING btree (user_id);


--
-- Name: open_id_tokens_ts_valid_until_ms; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX open_id_tokens_ts_valid_until_ms ON public.open_id_tokens USING btree (ts_valid_until_ms);


--
-- Name: presence_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX presence_stream_id ON public.presence_stream USING btree (stream_id, user_id);


--
-- Name: presence_stream_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX presence_stream_user_id ON public.presence_stream USING btree (user_id);


--
-- Name: public_room_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX public_room_index ON public.rooms USING btree (is_public);


--
-- Name: public_room_list_stream_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX public_room_list_stream_idx ON public.public_room_list_stream USING btree (stream_id);


--
-- Name: public_room_list_stream_rm_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX public_room_list_stream_rm_idx ON public.public_room_list_stream USING btree (room_id, stream_id);


--
-- Name: push_rules_enable_user_name; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX push_rules_enable_user_name ON public.push_rules_enable USING btree (user_name);


--
-- Name: push_rules_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX push_rules_stream_id ON public.push_rules_stream USING btree (stream_id);


--
-- Name: push_rules_stream_user_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX push_rules_stream_user_stream_id ON public.push_rules_stream USING btree (user_id, stream_id);


--
-- Name: push_rules_user_name; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX push_rules_user_name ON public.push_rules USING btree (user_name);


--
-- Name: ratelimit_override_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX ratelimit_override_idx ON public.ratelimit_override USING btree (user_id);


--
-- Name: receipts_linearized_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX receipts_linearized_id ON public.receipts_linearized USING btree (stream_id);


--
-- Name: receipts_linearized_room_stream; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX receipts_linearized_room_stream ON public.receipts_linearized USING btree (room_id, stream_id);


--
-- Name: receipts_linearized_user; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX receipts_linearized_user ON public.receipts_linearized USING btree (user_id);


--
-- Name: received_transactions_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX received_transactions_ts ON public.received_transactions USING btree (ts);


--
-- Name: redactions_have_censored; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX redactions_have_censored ON public.redactions USING btree (event_id) WHERE (NOT have_censored);


--
-- Name: redactions_have_censored_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX redactions_have_censored_ts ON public.redactions USING btree (received_ts) WHERE (NOT have_censored);


--
-- Name: redactions_redacts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX redactions_redacts ON public.redactions USING btree (redacts);


--
-- Name: remote_profile_cache_time; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX remote_profile_cache_time ON public.remote_profile_cache USING btree (last_check);


--
-- Name: remote_profile_cache_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX remote_profile_cache_user_id ON public.remote_profile_cache USING btree (user_id);


--
-- Name: room_account_data_stream_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_account_data_stream_id ON public.room_account_data USING btree (user_id, stream_id);


--
-- Name: room_alias_servers_alias; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_alias_servers_alias ON public.room_alias_servers USING btree (room_alias);


--
-- Name: room_aliases_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_aliases_id ON public.room_aliases USING btree (room_id);


--
-- Name: room_depth_room; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_depth_room ON public.room_depth USING btree (room_id);


--
-- Name: room_memberships_room_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_memberships_room_id ON public.room_memberships USING btree (room_id);


--
-- Name: room_memberships_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_memberships_user_id ON public.room_memberships USING btree (user_id);


--
-- Name: room_memberships_user_room_forgotten; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_memberships_user_room_forgotten ON public.room_memberships USING btree (user_id, room_id) WHERE (forgotten = 1);


--
-- Name: room_names_room_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_names_room_id ON public.room_names USING btree (room_id);


--
-- Name: room_stats_earliest_token_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX room_stats_earliest_token_idx ON public.room_stats_earliest_token USING btree (room_id);


--
-- Name: room_stats_historical_end_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX room_stats_historical_end_ts ON public.room_stats_historical USING btree (end_ts);


--
-- Name: room_stats_state_room; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX room_stats_state_room ON public.room_stats_state USING btree (room_id);


--
-- Name: state_group_edges_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX state_group_edges_idx ON public.state_group_edges USING btree (state_group);


--
-- Name: state_group_edges_prev_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX state_group_edges_prev_idx ON public.state_group_edges USING btree (prev_state_group);


--
-- Name: state_groups_state_type_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX state_groups_state_type_idx ON public.state_groups_state USING btree (state_group, type, state_key);


--
-- Name: stream_ordering_to_exterm_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX stream_ordering_to_exterm_idx ON public.stream_ordering_to_exterm USING btree (stream_ordering);


--
-- Name: stream_ordering_to_exterm_rm_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX stream_ordering_to_exterm_rm_idx ON public.stream_ordering_to_exterm USING btree (room_id, stream_ordering);


--
-- Name: threepid_guest_access_tokens_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX threepid_guest_access_tokens_index ON public.threepid_guest_access_tokens USING btree (medium, address);


--
-- Name: threepid_validation_token_session_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX threepid_validation_token_session_id ON public.threepid_validation_token USING btree (session_id);


--
-- Name: topics_room_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX topics_room_id ON public.topics USING btree (room_id);


--
-- Name: user_daily_visits_ts_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_daily_visits_ts_idx ON public.user_daily_visits USING btree ("timestamp");


--
-- Name: user_daily_visits_uts_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_daily_visits_uts_idx ON public.user_daily_visits USING btree (user_id, "timestamp");


--
-- Name: user_directory_room_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_directory_room_idx ON public.user_directory USING btree (room_id);


--
-- Name: user_directory_search_fts_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_directory_search_fts_idx ON public.user_directory_search USING gin (vector);


--
-- Name: user_directory_search_user_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX user_directory_search_user_idx ON public.user_directory_search USING btree (user_id);


--
-- Name: user_directory_user_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX user_directory_user_idx ON public.user_directory USING btree (user_id);


--
-- Name: user_filters_by_user_id_filter_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_filters_by_user_id_filter_id ON public.user_filters USING btree (user_id, filter_id);


--
-- Name: user_ips_device_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_ips_device_id ON public.user_ips USING btree (user_id, device_id, last_seen);


--
-- Name: user_ips_last_seen; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_ips_last_seen ON public.user_ips USING btree (user_id, last_seen);


--
-- Name: user_ips_last_seen_only; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_ips_last_seen_only ON public.user_ips USING btree (last_seen);


--
-- Name: user_ips_user_token_ip_unique_index; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX user_ips_user_token_ip_unique_index ON public.user_ips USING btree (user_id, access_token, ip);


--
-- Name: user_stats_historical_end_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_stats_historical_end_ts ON public.user_stats_historical USING btree (end_ts);


--
-- Name: user_threepid_id_server_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX user_threepid_id_server_idx ON public.user_threepid_id_server USING btree (user_id, medium, address, id_server);


--
-- Name: user_threepids_medium_address; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_threepids_medium_address ON public.user_threepids USING btree (medium, address);


--
-- Name: user_threepids_user_id; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX user_threepids_user_id ON public.user_threepids USING btree (user_id);


--
-- Name: users_creation_ts; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX users_creation_ts ON public.users USING btree (creation_ts);


--
-- Name: users_in_public_rooms_r_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX users_in_public_rooms_r_idx ON public.users_in_public_rooms USING btree (room_id);


--
-- Name: users_in_public_rooms_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX users_in_public_rooms_u_idx ON public.users_in_public_rooms USING btree (user_id, room_id);


--
-- Name: users_who_share_private_rooms_o_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX users_who_share_private_rooms_o_idx ON public.users_who_share_private_rooms USING btree (other_user_id);


--
-- Name: users_who_share_private_rooms_r_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE INDEX users_who_share_private_rooms_r_idx ON public.users_who_share_private_rooms USING btree (room_id);


--
-- Name: users_who_share_private_rooms_u_idx; Type: INDEX; Schema: public; Owner: sip_user
--

CREATE UNIQUE INDEX users_who_share_private_rooms_u_idx ON public.users_who_share_private_rooms USING btree (user_id, other_user_id, room_id);


--
-- PostgreSQL database dump complete
--

