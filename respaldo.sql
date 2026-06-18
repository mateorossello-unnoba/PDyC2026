--
-- PostgreSQL database dump
--

\restrict CJDV8z1Y5UfnvO6Sw8fExFvEeaKRaZg34ghwuaeB3lXMq4yTUOIAsHEgMypIlUA

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
071f17b0-99fb-4309-b313-07c82f6c30c4	\N	auth-cookie	14123153-d306-4089-b889-95f0e3cfa7cd	dfdda666-9547-4c79-860f-9ccd52f0b7f7	2	10	f	\N	\N
26f20501-7239-4698-9ba8-fd0b8ef66290	\N	auth-spnego	14123153-d306-4089-b889-95f0e3cfa7cd	dfdda666-9547-4c79-860f-9ccd52f0b7f7	3	20	f	\N	\N
ebf36f0d-9744-41e2-b4a2-8af96cffa5bd	\N	identity-provider-redirector	14123153-d306-4089-b889-95f0e3cfa7cd	dfdda666-9547-4c79-860f-9ccd52f0b7f7	2	25	f	\N	\N
28bd9599-3c62-4dc0-8e01-56a8e3ca3524	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	dfdda666-9547-4c79-860f-9ccd52f0b7f7	2	30	t	7baa8d54-07c7-4ee6-a6ac-e2706732d2fd	\N
b594c44a-b50c-46c4-9f54-1f5f4f696fc3	\N	auth-username-password-form	14123153-d306-4089-b889-95f0e3cfa7cd	7baa8d54-07c7-4ee6-a6ac-e2706732d2fd	0	10	f	\N	\N
f5d6f3dc-181c-4c90-a192-ec6f33d4015e	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	7baa8d54-07c7-4ee6-a6ac-e2706732d2fd	1	20	t	7e8f6eaa-f485-4e5d-b6fd-397715c633fe	\N
d21f4ab5-0625-436e-95e3-e2958b111605	\N	conditional-user-configured	14123153-d306-4089-b889-95f0e3cfa7cd	7e8f6eaa-f485-4e5d-b6fd-397715c633fe	0	10	f	\N	\N
3f04ee42-16da-49fa-aef7-c46fefa14e98	\N	auth-otp-form	14123153-d306-4089-b889-95f0e3cfa7cd	7e8f6eaa-f485-4e5d-b6fd-397715c633fe	0	20	f	\N	\N
19a51e38-9006-4ef3-b8f3-3a8f0cca08b3	\N	direct-grant-validate-username	14123153-d306-4089-b889-95f0e3cfa7cd	2d24af72-5b4f-41d1-abde-9c3ea3d3a797	0	10	f	\N	\N
ddc8fef1-a970-4eba-9343-917e6b4b0df5	\N	direct-grant-validate-password	14123153-d306-4089-b889-95f0e3cfa7cd	2d24af72-5b4f-41d1-abde-9c3ea3d3a797	0	20	f	\N	\N
bb51f6ba-dab0-4987-b04a-f6fc82b44fc2	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	2d24af72-5b4f-41d1-abde-9c3ea3d3a797	1	30	t	da8bb896-b5c6-429e-9e0b-e3528a3b158e	\N
62d15978-9c7a-4416-8740-010d60602514	\N	conditional-user-configured	14123153-d306-4089-b889-95f0e3cfa7cd	da8bb896-b5c6-429e-9e0b-e3528a3b158e	0	10	f	\N	\N
80ab9a47-7c8d-4091-bef4-e221d0dfccc2	\N	direct-grant-validate-otp	14123153-d306-4089-b889-95f0e3cfa7cd	da8bb896-b5c6-429e-9e0b-e3528a3b158e	0	20	f	\N	\N
acbb153d-3058-4b74-8735-f228494ab741	\N	registration-page-form	14123153-d306-4089-b889-95f0e3cfa7cd	636d1946-4356-4f2d-b2d9-c815a5360114	0	10	t	58f21f70-9e75-47fc-b9bf-d52b8b93b701	\N
5fb1e8dc-eed3-4e61-a1c4-c926c4380610	\N	registration-user-creation	14123153-d306-4089-b889-95f0e3cfa7cd	58f21f70-9e75-47fc-b9bf-d52b8b93b701	0	20	f	\N	\N
6a7acb6a-94a4-4340-bf11-9b06c182402b	\N	registration-password-action	14123153-d306-4089-b889-95f0e3cfa7cd	58f21f70-9e75-47fc-b9bf-d52b8b93b701	0	50	f	\N	\N
6a25ca37-a4ae-4df9-bcb0-564aca31c27f	\N	registration-recaptcha-action	14123153-d306-4089-b889-95f0e3cfa7cd	58f21f70-9e75-47fc-b9bf-d52b8b93b701	3	60	f	\N	\N
a6b880f8-4606-41e4-8f94-f9b477738733	\N	registration-terms-and-conditions	14123153-d306-4089-b889-95f0e3cfa7cd	58f21f70-9e75-47fc-b9bf-d52b8b93b701	3	70	f	\N	\N
2f4d5918-2b11-46c1-ae78-293712be5597	\N	reset-credentials-choose-user	14123153-d306-4089-b889-95f0e3cfa7cd	8c4ba01d-6001-4c15-8900-cb35c19ed7bb	0	10	f	\N	\N
424e3ae5-1a90-4f8f-9132-96737f513160	\N	reset-credential-email	14123153-d306-4089-b889-95f0e3cfa7cd	8c4ba01d-6001-4c15-8900-cb35c19ed7bb	0	20	f	\N	\N
a494d363-379a-47a0-84d7-d8f4623d8367	\N	reset-password	14123153-d306-4089-b889-95f0e3cfa7cd	8c4ba01d-6001-4c15-8900-cb35c19ed7bb	0	30	f	\N	\N
ce0f07a1-21c1-4ce1-a96a-9b0cb3d110a6	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	8c4ba01d-6001-4c15-8900-cb35c19ed7bb	1	40	t	d3579cb8-a6d0-4d10-9990-ec08b03a0ff7	\N
a9ce26e5-2803-4b43-b872-8b9b9e732bd8	\N	conditional-user-configured	14123153-d306-4089-b889-95f0e3cfa7cd	d3579cb8-a6d0-4d10-9990-ec08b03a0ff7	0	10	f	\N	\N
b935ae12-9959-4d0a-9546-ffc9322247cc	\N	reset-otp	14123153-d306-4089-b889-95f0e3cfa7cd	d3579cb8-a6d0-4d10-9990-ec08b03a0ff7	0	20	f	\N	\N
d9dace8f-e2a1-40d5-b88f-1c1567f8e243	\N	client-secret	14123153-d306-4089-b889-95f0e3cfa7cd	827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	2	10	f	\N	\N
0e0bc9cd-529e-4902-b74f-917d2551b363	\N	client-jwt	14123153-d306-4089-b889-95f0e3cfa7cd	827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	2	20	f	\N	\N
1df6ba21-9e49-49a2-bab4-98d1e22ee1e2	\N	client-secret-jwt	14123153-d306-4089-b889-95f0e3cfa7cd	827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	2	30	f	\N	\N
a2e72e52-c404-49bf-90f3-fa2fa230a956	\N	client-x509	14123153-d306-4089-b889-95f0e3cfa7cd	827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	2	40	f	\N	\N
a43d4a6d-2773-4e9a-b07e-cc7771c4b555	\N	idp-review-profile	14123153-d306-4089-b889-95f0e3cfa7cd	1fd2cb8c-cfdf-45be-a927-c6f73e0bb70b	0	10	f	\N	f57c0147-c5cd-4e8d-98a0-ca70c6795292
7ac97f3e-369c-4506-b61e-41bad002ac12	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	1fd2cb8c-cfdf-45be-a927-c6f73e0bb70b	0	20	t	0339621c-703a-466c-9656-1efc09ebb4e5	\N
2333e440-550e-49a8-b0e3-51df1732d42b	\N	idp-create-user-if-unique	14123153-d306-4089-b889-95f0e3cfa7cd	0339621c-703a-466c-9656-1efc09ebb4e5	2	10	f	\N	1869d245-4c0f-43cb-ba30-504e3225f638
2a58a4b4-a64c-4286-a934-91fa1033f6c4	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	0339621c-703a-466c-9656-1efc09ebb4e5	2	20	t	fa349105-47f1-4869-93f5-4de37fad7ef4	\N
b1f8dcac-05ee-46f5-bb27-2db3fefce490	\N	idp-confirm-link	14123153-d306-4089-b889-95f0e3cfa7cd	fa349105-47f1-4869-93f5-4de37fad7ef4	0	10	f	\N	\N
47ab019e-9989-4347-a954-16c8e097404c	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	fa349105-47f1-4869-93f5-4de37fad7ef4	0	20	t	a2c28a00-851c-411f-b9ad-b3a1d7a88a87	\N
b5d5fb8e-424d-4f54-adf3-b4de5c09c1fc	\N	idp-email-verification	14123153-d306-4089-b889-95f0e3cfa7cd	a2c28a00-851c-411f-b9ad-b3a1d7a88a87	2	10	f	\N	\N
a0bab88f-d078-48d2-8d7f-bcaf50dada3b	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	a2c28a00-851c-411f-b9ad-b3a1d7a88a87	2	20	t	7cc8a5ed-a9de-4bd4-b638-f721eb7fcb9e	\N
bc4cad3a-3dd4-445e-ba46-0979c1e528fd	\N	idp-username-password-form	14123153-d306-4089-b889-95f0e3cfa7cd	7cc8a5ed-a9de-4bd4-b638-f721eb7fcb9e	0	10	f	\N	\N
2c6b2a32-eb87-49f4-8085-509d2bb2bbe6	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	7cc8a5ed-a9de-4bd4-b638-f721eb7fcb9e	1	20	t	ebb0392f-1773-4ec7-b29e-f4a0698a7833	\N
0784e105-6d36-4330-b1b3-0c722dc88b07	\N	conditional-user-configured	14123153-d306-4089-b889-95f0e3cfa7cd	ebb0392f-1773-4ec7-b29e-f4a0698a7833	0	10	f	\N	\N
beede081-c3fb-4d0e-a6ef-c46145ee3d21	\N	auth-otp-form	14123153-d306-4089-b889-95f0e3cfa7cd	ebb0392f-1773-4ec7-b29e-f4a0698a7833	0	20	f	\N	\N
28cd1594-4e63-48f1-9171-f41268d8372d	\N	http-basic-authenticator	14123153-d306-4089-b889-95f0e3cfa7cd	145c389d-f09b-40b6-8a17-2b50ed6f2438	0	10	f	\N	\N
f7d31343-c384-4630-a1d2-01676f792f2d	\N	docker-http-basic-authenticator	14123153-d306-4089-b889-95f0e3cfa7cd	d6b9e31c-7f03-49aa-9ae7-ce68e744adf8	0	10	f	\N	\N
10e099aa-602a-4868-bdb8-de4ca48e3ed3	\N	auth-cookie	178a10d4-4dc3-44fb-86de-1dd2d795c19f	aee35d5b-7f57-4b1f-b00c-b6132f941704	2	10	f	\N	\N
b703bd29-fa68-4b99-9e16-29e300a69662	\N	auth-spnego	178a10d4-4dc3-44fb-86de-1dd2d795c19f	aee35d5b-7f57-4b1f-b00c-b6132f941704	3	20	f	\N	\N
cfa15487-2a13-46d0-afd5-caee7a78a1c0	\N	identity-provider-redirector	178a10d4-4dc3-44fb-86de-1dd2d795c19f	aee35d5b-7f57-4b1f-b00c-b6132f941704	2	25	f	\N	\N
912393e2-b893-4d82-ba6b-6f57dc3640c2	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	aee35d5b-7f57-4b1f-b00c-b6132f941704	2	30	t	cdc12f5d-f6b0-4e73-845a-a5a4b523613e	\N
7292c6c1-7a18-477d-838c-487ea684a157	\N	auth-username-password-form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	cdc12f5d-f6b0-4e73-845a-a5a4b523613e	0	10	f	\N	\N
d5f2184f-0b56-465a-a984-f70b7a620807	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	cdc12f5d-f6b0-4e73-845a-a5a4b523613e	1	20	t	4ba0930e-d9e2-4b9a-bea5-49972b6e7f54	\N
2c3fd8fa-b8c1-4950-969c-3422fa81c4d0	\N	conditional-user-configured	178a10d4-4dc3-44fb-86de-1dd2d795c19f	4ba0930e-d9e2-4b9a-bea5-49972b6e7f54	0	10	f	\N	\N
98d7ae9c-5403-4afd-8d2f-fc3fb8a0dac8	\N	auth-otp-form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	4ba0930e-d9e2-4b9a-bea5-49972b6e7f54	0	20	f	\N	\N
ed8856c5-f557-4618-b0bc-249fe8c791ee	\N	direct-grant-validate-username	178a10d4-4dc3-44fb-86de-1dd2d795c19f	6998544f-ca4b-4c76-a2f3-cd3936ba3240	0	10	f	\N	\N
2605c455-0e40-426a-8159-ab6ec1b9a698	\N	direct-grant-validate-password	178a10d4-4dc3-44fb-86de-1dd2d795c19f	6998544f-ca4b-4c76-a2f3-cd3936ba3240	0	20	f	\N	\N
251176d5-19b4-4c04-b592-e2a08d6c255a	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	6998544f-ca4b-4c76-a2f3-cd3936ba3240	1	30	t	13946f8d-5157-49dd-9343-b5edefb610be	\N
a6c26ed6-1e91-489f-a425-75162de7b147	\N	conditional-user-configured	178a10d4-4dc3-44fb-86de-1dd2d795c19f	13946f8d-5157-49dd-9343-b5edefb610be	0	10	f	\N	\N
eda7d429-b855-4825-b74a-4c259b5b3803	\N	direct-grant-validate-otp	178a10d4-4dc3-44fb-86de-1dd2d795c19f	13946f8d-5157-49dd-9343-b5edefb610be	0	20	f	\N	\N
b81a2521-6d64-45da-85e3-adb09e4d5446	\N	registration-page-form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	c455c0bc-ee80-4793-9d18-4513f20e6358	0	10	t	37714b82-d67c-43ac-ac07-87d2dfe525a1	\N
07354344-6334-460f-ab87-77718507cd56	\N	registration-user-creation	178a10d4-4dc3-44fb-86de-1dd2d795c19f	37714b82-d67c-43ac-ac07-87d2dfe525a1	0	20	f	\N	\N
4b00273a-15c9-4762-97a7-251a04441006	\N	registration-password-action	178a10d4-4dc3-44fb-86de-1dd2d795c19f	37714b82-d67c-43ac-ac07-87d2dfe525a1	0	50	f	\N	\N
a25c00a3-72be-45a9-915c-3ed25a05364f	\N	registration-recaptcha-action	178a10d4-4dc3-44fb-86de-1dd2d795c19f	37714b82-d67c-43ac-ac07-87d2dfe525a1	3	60	f	\N	\N
2f702e33-22a8-4eea-8be9-257df5eb14b4	\N	reset-credentials-choose-user	178a10d4-4dc3-44fb-86de-1dd2d795c19f	59121576-889e-49bd-ae0a-c825a49b0d20	0	10	f	\N	\N
2f18ea26-31d4-4704-a923-a5f01f6917c4	\N	reset-credential-email	178a10d4-4dc3-44fb-86de-1dd2d795c19f	59121576-889e-49bd-ae0a-c825a49b0d20	0	20	f	\N	\N
a5c70550-3c88-4fe7-91b3-455addb37f56	\N	reset-password	178a10d4-4dc3-44fb-86de-1dd2d795c19f	59121576-889e-49bd-ae0a-c825a49b0d20	0	30	f	\N	\N
f9f4d682-3e2e-4d1a-87ba-0dd3eb05133c	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	59121576-889e-49bd-ae0a-c825a49b0d20	1	40	t	e6030f65-040c-40fa-b6c2-166f8708ddbb	\N
0ba796b9-9faf-47c5-9d7f-a9c8e09ad872	\N	conditional-user-configured	178a10d4-4dc3-44fb-86de-1dd2d795c19f	e6030f65-040c-40fa-b6c2-166f8708ddbb	0	10	f	\N	\N
aec9e169-9ac9-4cab-b2b4-68f0eb9b86a6	\N	reset-otp	178a10d4-4dc3-44fb-86de-1dd2d795c19f	e6030f65-040c-40fa-b6c2-166f8708ddbb	0	20	f	\N	\N
b937f59d-10c0-4cee-a41c-f7cf3152f063	\N	client-secret	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3a26d255-fa37-494f-b434-869de3b8a71d	2	10	f	\N	\N
fc04ae87-61a2-4abb-a465-c4e11558afe5	\N	client-jwt	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3a26d255-fa37-494f-b434-869de3b8a71d	2	20	f	\N	\N
8e501e46-856c-43be-b654-16aaec13d409	\N	client-secret-jwt	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3a26d255-fa37-494f-b434-869de3b8a71d	2	30	f	\N	\N
f7f1a7f7-0415-49df-932b-cd313d3061ba	\N	client-x509	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3a26d255-fa37-494f-b434-869de3b8a71d	2	40	f	\N	\N
5c9ef10a-e58b-46e0-9bf6-49e24fab9377	\N	idp-review-profile	178a10d4-4dc3-44fb-86de-1dd2d795c19f	60eb6282-960b-4518-9e95-31795da6d67e	0	10	f	\N	335b8dac-ec79-4b80-8e78-95c9e2dc4753
e627d704-2cab-454e-a76f-99b7f0352695	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	60eb6282-960b-4518-9e95-31795da6d67e	0	20	t	818b1992-e330-465b-98b7-0ecd4fa1e255	\N
58069ac3-a4de-4219-8eb6-0c5056665117	\N	idp-create-user-if-unique	178a10d4-4dc3-44fb-86de-1dd2d795c19f	818b1992-e330-465b-98b7-0ecd4fa1e255	2	10	f	\N	ce92abe3-d48a-4667-aaac-c0b62bc49b44
875c27fc-768b-4db2-bc30-a9d6d18e8347	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	818b1992-e330-465b-98b7-0ecd4fa1e255	2	20	t	962819c2-cb22-4a2a-8a37-90c34b2d7bf6	\N
d3b97385-b518-4381-ad68-f6436973745c	\N	idp-confirm-link	178a10d4-4dc3-44fb-86de-1dd2d795c19f	962819c2-cb22-4a2a-8a37-90c34b2d7bf6	0	10	f	\N	\N
d51a9496-e94a-4c36-a19a-60e4e2cba188	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	962819c2-cb22-4a2a-8a37-90c34b2d7bf6	0	20	t	16b50730-5049-44e5-839f-f955bcdb20af	\N
ecabf61c-208d-4430-977d-2b242695250d	\N	idp-email-verification	178a10d4-4dc3-44fb-86de-1dd2d795c19f	16b50730-5049-44e5-839f-f955bcdb20af	2	10	f	\N	\N
c7a92a14-2096-4624-82ae-b0064f151f6d	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	16b50730-5049-44e5-839f-f955bcdb20af	2	20	t	f2eeede9-4e66-4367-8b5a-d35e7cd7bbb5	\N
9434d913-c172-422b-8105-2c97bbe1dc45	\N	idp-username-password-form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f2eeede9-4e66-4367-8b5a-d35e7cd7bbb5	0	10	f	\N	\N
9c9d62a5-f432-426a-a1ad-29fa4f52cc39	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f2eeede9-4e66-4367-8b5a-d35e7cd7bbb5	1	20	t	4ee81be4-1b3d-4789-8035-78f4c49fd7eb	\N
6b67a828-44eb-4919-b9df-ab106e98699e	\N	conditional-user-configured	178a10d4-4dc3-44fb-86de-1dd2d795c19f	4ee81be4-1b3d-4789-8035-78f4c49fd7eb	0	10	f	\N	\N
096dbacc-af09-4924-8148-b14f04466d23	\N	auth-otp-form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	4ee81be4-1b3d-4789-8035-78f4c49fd7eb	0	20	f	\N	\N
29375fa6-d4cc-47a7-a220-f00eb2515dee	\N	http-basic-authenticator	178a10d4-4dc3-44fb-86de-1dd2d795c19f	ec112309-d603-4a4a-97d2-9507b63f92be	0	10	f	\N	\N
44f29f90-42e5-42ca-8dfc-a6bab9a836fb	\N	docker-http-basic-authenticator	178a10d4-4dc3-44fb-86de-1dd2d795c19f	9439d19b-0869-4496-91fd-8029203ecc60	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
dfdda666-9547-4c79-860f-9ccd52f0b7f7	browser	browser based authentication	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
7baa8d54-07c7-4ee6-a6ac-e2706732d2fd	forms	Username, password, otp and other auth forms.	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
7e8f6eaa-f485-4e5d-b6fd-397715c633fe	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
2d24af72-5b4f-41d1-abde-9c3ea3d3a797	direct grant	OpenID Connect Resource Owner Grant	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
da8bb896-b5c6-429e-9e0b-e3528a3b158e	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
636d1946-4356-4f2d-b2d9-c815a5360114	registration	registration flow	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
58f21f70-9e75-47fc-b9bf-d52b8b93b701	registration form	registration form	14123153-d306-4089-b889-95f0e3cfa7cd	form-flow	f	t
8c4ba01d-6001-4c15-8900-cb35c19ed7bb	reset credentials	Reset credentials for a user if they forgot their password or something	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
d3579cb8-a6d0-4d10-9990-ec08b03a0ff7	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	clients	Base authentication for clients	14123153-d306-4089-b889-95f0e3cfa7cd	client-flow	t	t
1fd2cb8c-cfdf-45be-a927-c6f73e0bb70b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
0339621c-703a-466c-9656-1efc09ebb4e5	User creation or linking	Flow for the existing/non-existing user alternatives	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
fa349105-47f1-4869-93f5-4de37fad7ef4	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
a2c28a00-851c-411f-b9ad-b3a1d7a88a87	Account verification options	Method with which to verity the existing account	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
7cc8a5ed-a9de-4bd4-b638-f721eb7fcb9e	Verify Existing Account by Re-authentication	Reauthentication of existing account	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
ebb0392f-1773-4ec7-b29e-f4a0698a7833	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	f	t
145c389d-f09b-40b6-8a17-2b50ed6f2438	saml ecp	SAML ECP Profile Authentication Flow	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
d6b9e31c-7f03-49aa-9ae7-ce68e744adf8	docker auth	Used by Docker clients to authenticate against the IDP	14123153-d306-4089-b889-95f0e3cfa7cd	basic-flow	t	t
aee35d5b-7f57-4b1f-b00c-b6132f941704	browser	browser based authentication	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
cdc12f5d-f6b0-4e73-845a-a5a4b523613e	forms	Username, password, otp and other auth forms.	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
4ba0930e-d9e2-4b9a-bea5-49972b6e7f54	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
6998544f-ca4b-4c76-a2f3-cd3936ba3240	direct grant	OpenID Connect Resource Owner Grant	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
13946f8d-5157-49dd-9343-b5edefb610be	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
c455c0bc-ee80-4793-9d18-4513f20e6358	registration	registration flow	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
37714b82-d67c-43ac-ac07-87d2dfe525a1	registration form	registration form	178a10d4-4dc3-44fb-86de-1dd2d795c19f	form-flow	f	t
59121576-889e-49bd-ae0a-c825a49b0d20	reset credentials	Reset credentials for a user if they forgot their password or something	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
e6030f65-040c-40fa-b6c2-166f8708ddbb	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
3a26d255-fa37-494f-b434-869de3b8a71d	clients	Base authentication for clients	178a10d4-4dc3-44fb-86de-1dd2d795c19f	client-flow	t	t
60eb6282-960b-4518-9e95-31795da6d67e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
818b1992-e330-465b-98b7-0ecd4fa1e255	User creation or linking	Flow for the existing/non-existing user alternatives	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
962819c2-cb22-4a2a-8a37-90c34b2d7bf6	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
16b50730-5049-44e5-839f-f955bcdb20af	Account verification options	Method with which to verity the existing account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
f2eeede9-4e66-4367-8b5a-d35e7cd7bbb5	Verify Existing Account by Re-authentication	Reauthentication of existing account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
4ee81be4-1b3d-4789-8035-78f4c49fd7eb	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	f	t
ec112309-d603-4a4a-97d2-9507b63f92be	saml ecp	SAML ECP Profile Authentication Flow	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
9439d19b-0869-4496-91fd-8029203ecc60	docker auth	Used by Docker clients to authenticate against the IDP	178a10d4-4dc3-44fb-86de-1dd2d795c19f	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
f57c0147-c5cd-4e8d-98a0-ca70c6795292	review profile config	14123153-d306-4089-b889-95f0e3cfa7cd
1869d245-4c0f-43cb-ba30-504e3225f638	create unique user config	14123153-d306-4089-b889-95f0e3cfa7cd
335b8dac-ec79-4b80-8e78-95c9e2dc4753	review profile config	178a10d4-4dc3-44fb-86de-1dd2d795c19f
ce92abe3-d48a-4667-aaac-c0b62bc49b44	create unique user config	178a10d4-4dc3-44fb-86de-1dd2d795c19f
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
1869d245-4c0f-43cb-ba30-504e3225f638	false	require.password.update.after.registration
f57c0147-c5cd-4e8d-98a0-ca70c6795292	missing	update.profile.on.first.login
335b8dac-ec79-4b80-8e78-95c9e2dc4753	missing	update.profile.on.first.login
ce92abe3-d48a-4667-aaac-c0b62bc49b44	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	f	master-realm	0	f	\N	\N	t	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
859449bf-82bf-4c25-ad48-57536cb76e75	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
61ff02ee-6245-4ecd-bd34-b47489aa4f71	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
081fb9d4-b290-49e4-8bc0-341d18d41f19	t	f	broker	0	f	\N	\N	t	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
785b9dfb-13bb-4747-8629-befad8b73e33	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
24d787a1-e2d9-441b-9e81-8aa699e6654e	t	f	admin-cli	0	t	\N	\N	f	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	f	unnoba-realm	0	f	\N	\N	t	\N	f	14123153-d306-4089-b889-95f0e3cfa7cd	\N	0	f	f	unnoba Realm	f	client-secret	\N	\N	\N	t	f	f	f
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	f	realm-management	0	f	\N	\N	t	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
31abbace-d518-4094-b320-8ae3c264f262	t	f	account	0	t	\N	/realms/unnoba/account/	f	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
44556d33-a0db-49b3-aa13-8d408e5eda99	t	f	account-console	0	t	\N	/realms/unnoba/account/	f	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0ab01938-4396-4424-b1f9-83db520605f0	t	f	broker	0	f	\N	\N	t	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e6206f81-3d57-4e7f-9e54-64f93d766ca6	t	f	security-admin-console	0	t	\N	/admin/unnoba/console/	f	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
23a9d612-5b7e-455d-a85a-e379c7a0ef41	t	f	admin-cli	0	t	\N	\N	f	\N	f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
4112d709-d5c5-48e0-994c-631da6c04c9c	t	t	pdyc	0	f	Kfs6fbShlz87GUNy9nldFrbINC4Bfems		f		f	178a10d4-4dc3-44fb-86de-1dd2d795c19f	openid-connect	-1	t	f	pdyc	t	client-secret			\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
859449bf-82bf-4c25-ad48-57536cb76e75	post.logout.redirect.uris	+
61ff02ee-6245-4ecd-bd34-b47489aa4f71	post.logout.redirect.uris	+
61ff02ee-6245-4ecd-bd34-b47489aa4f71	pkce.code.challenge.method	S256
785b9dfb-13bb-4747-8629-befad8b73e33	post.logout.redirect.uris	+
785b9dfb-13bb-4747-8629-befad8b73e33	pkce.code.challenge.method	S256
31abbace-d518-4094-b320-8ae3c264f262	post.logout.redirect.uris	+
44556d33-a0db-49b3-aa13-8d408e5eda99	post.logout.redirect.uris	+
44556d33-a0db-49b3-aa13-8d408e5eda99	pkce.code.challenge.method	S256
e6206f81-3d57-4e7f-9e54-64f93d766ca6	post.logout.redirect.uris	+
e6206f81-3d57-4e7f-9e54-64f93d766ca6	pkce.code.challenge.method	S256
4112d709-d5c5-48e0-994c-631da6c04c9c	oauth2.device.authorization.grant.enabled	false
4112d709-d5c5-48e0-994c-631da6c04c9c	oidc.ciba.grant.enabled	false
4112d709-d5c5-48e0-994c-631da6c04c9c	backchannel.logout.session.required	true
4112d709-d5c5-48e0-994c-631da6c04c9c	backchannel.logout.revoke.offline.tokens	false
4112d709-d5c5-48e0-994c-631da6c04c9c	display.on.consent.screen	false
4112d709-d5c5-48e0-994c-631da6c04c9c	client.secret.creation.time	1778486069
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
72a0ac98-ebef-4047-a06b-cf5b17703bca	offline_access	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect built-in scope: offline_access	openid-connect
f85cba21-d073-4a41-bb45-0cee0d066e04	role_list	14123153-d306-4089-b889-95f0e3cfa7cd	SAML role list	saml
576771a5-f6d7-4f43-bb50-b0808f7aa2a5	profile	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect built-in scope: profile	openid-connect
3be82b5b-8068-41fd-b270-7e216ef3d945	email	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect built-in scope: email	openid-connect
776616ac-7f74-4b44-97e4-d9b8ac872f7a	address	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect built-in scope: address	openid-connect
5753649c-aa76-4f08-af27-aa0ee3b11e2e	phone	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect built-in scope: phone	openid-connect
6729c094-4296-48a3-b7ad-4677b0a296a6	roles	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect scope for add user roles to the access token	openid-connect
0fce45cf-919e-416b-8c0a-18bf2725e6a9	web-origins	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect scope for add allowed web origins to the access token	openid-connect
96f1eeec-a797-4437-a57e-caec6cbc0133	microprofile-jwt	14123153-d306-4089-b889-95f0e3cfa7cd	Microprofile - JWT built-in scope	openid-connect
4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	acr	14123153-d306-4089-b889-95f0e3cfa7cd	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	offline_access	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect built-in scope: offline_access	openid-connect
37c44c2a-060e-4e4b-87ab-6020646a352a	role_list	178a10d4-4dc3-44fb-86de-1dd2d795c19f	SAML role list	saml
5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	profile	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect built-in scope: profile	openid-connect
a12387c2-855c-4927-8938-22bcc73e54da	email	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect built-in scope: email	openid-connect
c026a8f2-9162-44cf-babc-c188c4856e59	address	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect built-in scope: address	openid-connect
63589987-e982-4c27-a827-94e62a3af714	phone	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect built-in scope: phone	openid-connect
8d282887-97ce-4e9a-be12-225585d1ad8d	roles	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect scope for add user roles to the access token	openid-connect
8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	web-origins	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect scope for add allowed web origins to the access token	openid-connect
606aa32d-4807-485a-a043-cd031cc392aa	microprofile-jwt	178a10d4-4dc3-44fb-86de-1dd2d795c19f	Microprofile - JWT built-in scope	openid-connect
43d65480-f355-4584-b1f4-5d63511b779e	acr	178a10d4-4dc3-44fb-86de-1dd2d795c19f	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
72a0ac98-ebef-4047-a06b-cf5b17703bca	true	display.on.consent.screen
72a0ac98-ebef-4047-a06b-cf5b17703bca	${offlineAccessScopeConsentText}	consent.screen.text
f85cba21-d073-4a41-bb45-0cee0d066e04	true	display.on.consent.screen
f85cba21-d073-4a41-bb45-0cee0d066e04	${samlRoleListScopeConsentText}	consent.screen.text
576771a5-f6d7-4f43-bb50-b0808f7aa2a5	true	display.on.consent.screen
576771a5-f6d7-4f43-bb50-b0808f7aa2a5	${profileScopeConsentText}	consent.screen.text
576771a5-f6d7-4f43-bb50-b0808f7aa2a5	true	include.in.token.scope
3be82b5b-8068-41fd-b270-7e216ef3d945	true	display.on.consent.screen
3be82b5b-8068-41fd-b270-7e216ef3d945	${emailScopeConsentText}	consent.screen.text
3be82b5b-8068-41fd-b270-7e216ef3d945	true	include.in.token.scope
776616ac-7f74-4b44-97e4-d9b8ac872f7a	true	display.on.consent.screen
776616ac-7f74-4b44-97e4-d9b8ac872f7a	${addressScopeConsentText}	consent.screen.text
776616ac-7f74-4b44-97e4-d9b8ac872f7a	true	include.in.token.scope
5753649c-aa76-4f08-af27-aa0ee3b11e2e	true	display.on.consent.screen
5753649c-aa76-4f08-af27-aa0ee3b11e2e	${phoneScopeConsentText}	consent.screen.text
5753649c-aa76-4f08-af27-aa0ee3b11e2e	true	include.in.token.scope
6729c094-4296-48a3-b7ad-4677b0a296a6	true	display.on.consent.screen
6729c094-4296-48a3-b7ad-4677b0a296a6	${rolesScopeConsentText}	consent.screen.text
6729c094-4296-48a3-b7ad-4677b0a296a6	false	include.in.token.scope
0fce45cf-919e-416b-8c0a-18bf2725e6a9	false	display.on.consent.screen
0fce45cf-919e-416b-8c0a-18bf2725e6a9		consent.screen.text
0fce45cf-919e-416b-8c0a-18bf2725e6a9	false	include.in.token.scope
96f1eeec-a797-4437-a57e-caec6cbc0133	false	display.on.consent.screen
96f1eeec-a797-4437-a57e-caec6cbc0133	true	include.in.token.scope
4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	false	display.on.consent.screen
4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	false	include.in.token.scope
411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	true	display.on.consent.screen
411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	${offlineAccessScopeConsentText}	consent.screen.text
37c44c2a-060e-4e4b-87ab-6020646a352a	true	display.on.consent.screen
37c44c2a-060e-4e4b-87ab-6020646a352a	${samlRoleListScopeConsentText}	consent.screen.text
5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	true	display.on.consent.screen
5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	${profileScopeConsentText}	consent.screen.text
5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	true	include.in.token.scope
a12387c2-855c-4927-8938-22bcc73e54da	true	display.on.consent.screen
a12387c2-855c-4927-8938-22bcc73e54da	${emailScopeConsentText}	consent.screen.text
a12387c2-855c-4927-8938-22bcc73e54da	true	include.in.token.scope
c026a8f2-9162-44cf-babc-c188c4856e59	true	display.on.consent.screen
c026a8f2-9162-44cf-babc-c188c4856e59	${addressScopeConsentText}	consent.screen.text
c026a8f2-9162-44cf-babc-c188c4856e59	true	include.in.token.scope
63589987-e982-4c27-a827-94e62a3af714	true	display.on.consent.screen
63589987-e982-4c27-a827-94e62a3af714	${phoneScopeConsentText}	consent.screen.text
63589987-e982-4c27-a827-94e62a3af714	true	include.in.token.scope
8d282887-97ce-4e9a-be12-225585d1ad8d	true	display.on.consent.screen
8d282887-97ce-4e9a-be12-225585d1ad8d	${rolesScopeConsentText}	consent.screen.text
8d282887-97ce-4e9a-be12-225585d1ad8d	false	include.in.token.scope
8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	false	display.on.consent.screen
8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2		consent.screen.text
8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	false	include.in.token.scope
606aa32d-4807-485a-a043-cd031cc392aa	false	display.on.consent.screen
606aa32d-4807-485a-a043-cd031cc392aa	true	include.in.token.scope
43d65480-f355-4584-b1f4-5d63511b779e	false	display.on.consent.screen
43d65480-f355-4584-b1f4-5d63511b779e	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
859449bf-82bf-4c25-ad48-57536cb76e75	6729c094-4296-48a3-b7ad-4677b0a296a6	t
859449bf-82bf-4c25-ad48-57536cb76e75	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
859449bf-82bf-4c25-ad48-57536cb76e75	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
859449bf-82bf-4c25-ad48-57536cb76e75	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
859449bf-82bf-4c25-ad48-57536cb76e75	3be82b5b-8068-41fd-b270-7e216ef3d945	t
859449bf-82bf-4c25-ad48-57536cb76e75	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
859449bf-82bf-4c25-ad48-57536cb76e75	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
859449bf-82bf-4c25-ad48-57536cb76e75	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
859449bf-82bf-4c25-ad48-57536cb76e75	96f1eeec-a797-4437-a57e-caec6cbc0133	f
61ff02ee-6245-4ecd-bd34-b47489aa4f71	6729c094-4296-48a3-b7ad-4677b0a296a6	t
61ff02ee-6245-4ecd-bd34-b47489aa4f71	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
61ff02ee-6245-4ecd-bd34-b47489aa4f71	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
61ff02ee-6245-4ecd-bd34-b47489aa4f71	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
61ff02ee-6245-4ecd-bd34-b47489aa4f71	3be82b5b-8068-41fd-b270-7e216ef3d945	t
61ff02ee-6245-4ecd-bd34-b47489aa4f71	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
61ff02ee-6245-4ecd-bd34-b47489aa4f71	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
61ff02ee-6245-4ecd-bd34-b47489aa4f71	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
61ff02ee-6245-4ecd-bd34-b47489aa4f71	96f1eeec-a797-4437-a57e-caec6cbc0133	f
24d787a1-e2d9-441b-9e81-8aa699e6654e	6729c094-4296-48a3-b7ad-4677b0a296a6	t
24d787a1-e2d9-441b-9e81-8aa699e6654e	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
24d787a1-e2d9-441b-9e81-8aa699e6654e	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
24d787a1-e2d9-441b-9e81-8aa699e6654e	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
24d787a1-e2d9-441b-9e81-8aa699e6654e	3be82b5b-8068-41fd-b270-7e216ef3d945	t
24d787a1-e2d9-441b-9e81-8aa699e6654e	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
24d787a1-e2d9-441b-9e81-8aa699e6654e	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
24d787a1-e2d9-441b-9e81-8aa699e6654e	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
24d787a1-e2d9-441b-9e81-8aa699e6654e	96f1eeec-a797-4437-a57e-caec6cbc0133	f
081fb9d4-b290-49e4-8bc0-341d18d41f19	6729c094-4296-48a3-b7ad-4677b0a296a6	t
081fb9d4-b290-49e4-8bc0-341d18d41f19	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
081fb9d4-b290-49e4-8bc0-341d18d41f19	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
081fb9d4-b290-49e4-8bc0-341d18d41f19	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
081fb9d4-b290-49e4-8bc0-341d18d41f19	3be82b5b-8068-41fd-b270-7e216ef3d945	t
081fb9d4-b290-49e4-8bc0-341d18d41f19	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
081fb9d4-b290-49e4-8bc0-341d18d41f19	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
081fb9d4-b290-49e4-8bc0-341d18d41f19	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
081fb9d4-b290-49e4-8bc0-341d18d41f19	96f1eeec-a797-4437-a57e-caec6cbc0133	f
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	6729c094-4296-48a3-b7ad-4677b0a296a6	t
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	3be82b5b-8068-41fd-b270-7e216ef3d945	t
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
f1a0e924-2f56-4d8d-9af8-ddaabf39921e	96f1eeec-a797-4437-a57e-caec6cbc0133	f
785b9dfb-13bb-4747-8629-befad8b73e33	6729c094-4296-48a3-b7ad-4677b0a296a6	t
785b9dfb-13bb-4747-8629-befad8b73e33	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
785b9dfb-13bb-4747-8629-befad8b73e33	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
785b9dfb-13bb-4747-8629-befad8b73e33	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
785b9dfb-13bb-4747-8629-befad8b73e33	3be82b5b-8068-41fd-b270-7e216ef3d945	t
785b9dfb-13bb-4747-8629-befad8b73e33	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
785b9dfb-13bb-4747-8629-befad8b73e33	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
785b9dfb-13bb-4747-8629-befad8b73e33	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
785b9dfb-13bb-4747-8629-befad8b73e33	96f1eeec-a797-4437-a57e-caec6cbc0133	f
31abbace-d518-4094-b320-8ae3c264f262	43d65480-f355-4584-b1f4-5d63511b779e	t
31abbace-d518-4094-b320-8ae3c264f262	8d282887-97ce-4e9a-be12-225585d1ad8d	t
31abbace-d518-4094-b320-8ae3c264f262	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
31abbace-d518-4094-b320-8ae3c264f262	a12387c2-855c-4927-8938-22bcc73e54da	t
31abbace-d518-4094-b320-8ae3c264f262	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
31abbace-d518-4094-b320-8ae3c264f262	606aa32d-4807-485a-a043-cd031cc392aa	f
31abbace-d518-4094-b320-8ae3c264f262	c026a8f2-9162-44cf-babc-c188c4856e59	f
31abbace-d518-4094-b320-8ae3c264f262	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
31abbace-d518-4094-b320-8ae3c264f262	63589987-e982-4c27-a827-94e62a3af714	f
44556d33-a0db-49b3-aa13-8d408e5eda99	43d65480-f355-4584-b1f4-5d63511b779e	t
44556d33-a0db-49b3-aa13-8d408e5eda99	8d282887-97ce-4e9a-be12-225585d1ad8d	t
44556d33-a0db-49b3-aa13-8d408e5eda99	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
44556d33-a0db-49b3-aa13-8d408e5eda99	a12387c2-855c-4927-8938-22bcc73e54da	t
44556d33-a0db-49b3-aa13-8d408e5eda99	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
44556d33-a0db-49b3-aa13-8d408e5eda99	606aa32d-4807-485a-a043-cd031cc392aa	f
44556d33-a0db-49b3-aa13-8d408e5eda99	c026a8f2-9162-44cf-babc-c188c4856e59	f
44556d33-a0db-49b3-aa13-8d408e5eda99	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
44556d33-a0db-49b3-aa13-8d408e5eda99	63589987-e982-4c27-a827-94e62a3af714	f
23a9d612-5b7e-455d-a85a-e379c7a0ef41	43d65480-f355-4584-b1f4-5d63511b779e	t
23a9d612-5b7e-455d-a85a-e379c7a0ef41	8d282887-97ce-4e9a-be12-225585d1ad8d	t
23a9d612-5b7e-455d-a85a-e379c7a0ef41	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
23a9d612-5b7e-455d-a85a-e379c7a0ef41	a12387c2-855c-4927-8938-22bcc73e54da	t
23a9d612-5b7e-455d-a85a-e379c7a0ef41	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
23a9d612-5b7e-455d-a85a-e379c7a0ef41	606aa32d-4807-485a-a043-cd031cc392aa	f
23a9d612-5b7e-455d-a85a-e379c7a0ef41	c026a8f2-9162-44cf-babc-c188c4856e59	f
23a9d612-5b7e-455d-a85a-e379c7a0ef41	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
23a9d612-5b7e-455d-a85a-e379c7a0ef41	63589987-e982-4c27-a827-94e62a3af714	f
0ab01938-4396-4424-b1f9-83db520605f0	43d65480-f355-4584-b1f4-5d63511b779e	t
0ab01938-4396-4424-b1f9-83db520605f0	8d282887-97ce-4e9a-be12-225585d1ad8d	t
0ab01938-4396-4424-b1f9-83db520605f0	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
0ab01938-4396-4424-b1f9-83db520605f0	a12387c2-855c-4927-8938-22bcc73e54da	t
0ab01938-4396-4424-b1f9-83db520605f0	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
0ab01938-4396-4424-b1f9-83db520605f0	606aa32d-4807-485a-a043-cd031cc392aa	f
0ab01938-4396-4424-b1f9-83db520605f0	c026a8f2-9162-44cf-babc-c188c4856e59	f
0ab01938-4396-4424-b1f9-83db520605f0	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
0ab01938-4396-4424-b1f9-83db520605f0	63589987-e982-4c27-a827-94e62a3af714	f
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	43d65480-f355-4584-b1f4-5d63511b779e	t
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	8d282887-97ce-4e9a-be12-225585d1ad8d	t
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	a12387c2-855c-4927-8938-22bcc73e54da	t
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	606aa32d-4807-485a-a043-cd031cc392aa	f
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	c026a8f2-9162-44cf-babc-c188c4856e59	f
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
3949a6ff-332f-4a9c-be55-67aeaa70dcc3	63589987-e982-4c27-a827-94e62a3af714	f
e6206f81-3d57-4e7f-9e54-64f93d766ca6	43d65480-f355-4584-b1f4-5d63511b779e	t
e6206f81-3d57-4e7f-9e54-64f93d766ca6	8d282887-97ce-4e9a-be12-225585d1ad8d	t
e6206f81-3d57-4e7f-9e54-64f93d766ca6	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
e6206f81-3d57-4e7f-9e54-64f93d766ca6	a12387c2-855c-4927-8938-22bcc73e54da	t
e6206f81-3d57-4e7f-9e54-64f93d766ca6	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
e6206f81-3d57-4e7f-9e54-64f93d766ca6	606aa32d-4807-485a-a043-cd031cc392aa	f
e6206f81-3d57-4e7f-9e54-64f93d766ca6	c026a8f2-9162-44cf-babc-c188c4856e59	f
e6206f81-3d57-4e7f-9e54-64f93d766ca6	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
e6206f81-3d57-4e7f-9e54-64f93d766ca6	63589987-e982-4c27-a827-94e62a3af714	f
4112d709-d5c5-48e0-994c-631da6c04c9c	43d65480-f355-4584-b1f4-5d63511b779e	t
4112d709-d5c5-48e0-994c-631da6c04c9c	8d282887-97ce-4e9a-be12-225585d1ad8d	t
4112d709-d5c5-48e0-994c-631da6c04c9c	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
4112d709-d5c5-48e0-994c-631da6c04c9c	a12387c2-855c-4927-8938-22bcc73e54da	t
4112d709-d5c5-48e0-994c-631da6c04c9c	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
4112d709-d5c5-48e0-994c-631da6c04c9c	606aa32d-4807-485a-a043-cd031cc392aa	f
4112d709-d5c5-48e0-994c-631da6c04c9c	c026a8f2-9162-44cf-babc-c188c4856e59	f
4112d709-d5c5-48e0-994c-631da6c04c9c	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
4112d709-d5c5-48e0-994c-631da6c04c9c	63589987-e982-4c27-a827-94e62a3af714	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
72a0ac98-ebef-4047-a06b-cf5b17703bca	8059a2fb-5237-4893-b8ee-e1fbe87829a4
411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	c4abc542-4878-4505-b231-6c033e4ab688
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
6501780f-12db-4e8c-9a06-042d1b349993	Trusted Hosts	14123153-d306-4089-b889-95f0e3cfa7cd	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
3d0a6ae1-919c-4ffd-b404-05be947b1b3b	Consent Required	14123153-d306-4089-b889-95f0e3cfa7cd	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
b4dbc3d3-ef23-4acf-895a-38543d3b731b	Full Scope Disabled	14123153-d306-4089-b889-95f0e3cfa7cd	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
1720093b-61c2-4249-aea2-d1b55b389f99	Max Clients Limit	14123153-d306-4089-b889-95f0e3cfa7cd	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
71fb4697-4a6f-44db-90b1-74516d492abf	Allowed Protocol Mapper Types	14123153-d306-4089-b889-95f0e3cfa7cd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
0cee2f35-cfc5-4921-bd48-62e2f1e52303	Allowed Client Scopes	14123153-d306-4089-b889-95f0e3cfa7cd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	anonymous
e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	Allowed Protocol Mapper Types	14123153-d306-4089-b889-95f0e3cfa7cd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	authenticated
c29daaf8-bb69-47a6-b86a-75d0dc065142	Allowed Client Scopes	14123153-d306-4089-b889-95f0e3cfa7cd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	authenticated
31adf9f0-8e80-4f62-abe4-79809bdd294d	rsa-generated	14123153-d306-4089-b889-95f0e3cfa7cd	rsa-generated	org.keycloak.keys.KeyProvider	14123153-d306-4089-b889-95f0e3cfa7cd	\N
5e183852-4e81-4f73-9137-0886994f20f9	rsa-enc-generated	14123153-d306-4089-b889-95f0e3cfa7cd	rsa-enc-generated	org.keycloak.keys.KeyProvider	14123153-d306-4089-b889-95f0e3cfa7cd	\N
8bce115b-9515-4614-8f4b-8fb73bab936b	hmac-generated	14123153-d306-4089-b889-95f0e3cfa7cd	hmac-generated	org.keycloak.keys.KeyProvider	14123153-d306-4089-b889-95f0e3cfa7cd	\N
54ba0f61-5fd2-4ffa-9637-5a048a6dc91f	aes-generated	14123153-d306-4089-b889-95f0e3cfa7cd	aes-generated	org.keycloak.keys.KeyProvider	14123153-d306-4089-b889-95f0e3cfa7cd	\N
367990eb-07c8-4738-a543-c80399b37d67	rsa-generated	178a10d4-4dc3-44fb-86de-1dd2d795c19f	rsa-generated	org.keycloak.keys.KeyProvider	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N
e92f756a-2cef-4725-9019-bf2a2501b5c7	rsa-enc-generated	178a10d4-4dc3-44fb-86de-1dd2d795c19f	rsa-enc-generated	org.keycloak.keys.KeyProvider	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N
94059eab-bce0-4022-821c-7b25057f60a7	hmac-generated	178a10d4-4dc3-44fb-86de-1dd2d795c19f	hmac-generated	org.keycloak.keys.KeyProvider	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N
0a3c0e65-5e6a-456f-be93-b05605796800	aes-generated	178a10d4-4dc3-44fb-86de-1dd2d795c19f	aes-generated	org.keycloak.keys.KeyProvider	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N
3d59a3b1-abea-4840-9247-c9012724802e	Trusted Hosts	178a10d4-4dc3-44fb-86de-1dd2d795c19f	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
479954d0-96f0-4285-b08b-e4c8fb12b082	Consent Required	178a10d4-4dc3-44fb-86de-1dd2d795c19f	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
1a41f345-7e2c-4a62-b502-7561438d0023	Full Scope Disabled	178a10d4-4dc3-44fb-86de-1dd2d795c19f	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
e5a1134f-93cc-436f-b145-46259115bc76	Max Clients Limit	178a10d4-4dc3-44fb-86de-1dd2d795c19f	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	Allowed Protocol Mapper Types	178a10d4-4dc3-44fb-86de-1dd2d795c19f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
b4998005-3abb-4e59-b535-c884ac77bf59	Allowed Client Scopes	178a10d4-4dc3-44fb-86de-1dd2d795c19f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	anonymous
bfecca90-01b7-42f8-bcc7-207cdefbfcb2	Allowed Protocol Mapper Types	178a10d4-4dc3-44fb-86de-1dd2d795c19f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	authenticated
2504af85-9405-4556-841d-5870bcc1b11b	Allowed Client Scopes	178a10d4-4dc3-44fb-86de-1dd2d795c19f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
37debeb7-ab42-4535-b1ac-95fa6fae62d8	0cee2f35-cfc5-4921-bd48-62e2f1e52303	allow-default-scopes	true
b8af3985-f216-4cbf-b903-16ed15a39253	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5e10724e-1687-4b05-97c0-c50734fe08e4	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	oidc-full-name-mapper
ec86813d-eae3-4f94-950e-954f36401a71	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	saml-user-property-mapper
f5c5f5e5-5992-476f-8641-a399e9f577cd	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	oidc-address-mapper
4f0dbf02-d804-48cf-b52f-e0f0215af93f	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b4d56499-ab8e-452a-bfee-c589c161eecb	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	saml-user-attribute-mapper
fd41b4f3-d308-4ec1-a425-8b5d33793f68	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f70e542c-ccf9-4682-be49-f92aefc2eaa5	e3cc3bea-60ee-4c59-abce-1a3ae3f52ae6	allowed-protocol-mapper-types	saml-role-list-mapper
4d6453e1-f206-4509-a60c-1d40c03f0962	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	saml-user-attribute-mapper
aff7b0bd-4ec9-4403-a352-2e0ac9a9367e	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	saml-user-property-mapper
3d2528b7-4e15-4635-abac-0973236127d8	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	oidc-address-mapper
ab54b691-24c5-4b48-87c5-9bc851653d68	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9c6e90e8-7b5b-47b0-9f2d-4ecebd40875e	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	oidc-full-name-mapper
f9bfa4cc-ac30-45b0-a37f-da028aff66cc	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
498e2f8e-8762-49c9-a2f4-8edb526da78e	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	saml-role-list-mapper
f4176f8e-e488-4dab-b881-a34d971cf30a	71fb4697-4a6f-44db-90b1-74516d492abf	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4b1244f0-2789-45a1-a829-a350c5045a93	1720093b-61c2-4249-aea2-d1b55b389f99	max-clients	200
8ce0ff79-895b-4091-8b59-8f5cfef25cef	c29daaf8-bb69-47a6-b86a-75d0dc065142	allow-default-scopes	true
f29c472e-8704-4da5-a0b8-63d2f9f63a43	6501780f-12db-4e8c-9a06-042d1b349993	client-uris-must-match	true
c72d8af6-7469-4581-8739-0a2a9c850bae	6501780f-12db-4e8c-9a06-042d1b349993	host-sending-registration-request-must-match	true
ec05103e-df9d-4bb6-a896-80736c85d011	54ba0f61-5fd2-4ffa-9637-5a048a6dc91f	secret	_bJ8UVsvCmZKT6LF-4ilPQ
f8cada11-541f-47cc-9c68-2fdf4a27b14c	54ba0f61-5fd2-4ffa-9637-5a048a6dc91f	kid	224eb227-5e8b-4fe9-b973-216d84ae534d
eda9e98f-7d41-450d-946f-3b6626ec99fc	54ba0f61-5fd2-4ffa-9637-5a048a6dc91f	priority	100
2ea40975-7eb0-4e62-b66b-b41b860b1a01	5e183852-4e81-4f73-9137-0886994f20f9	algorithm	RSA-OAEP
40633d10-5e9c-4b89-9c99-7f5b86d88b5d	5e183852-4e81-4f73-9137-0886994f20f9	certificate	MIICmzCCAYMCBgGeFgWdlDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTExMDc1MDI3WhcNMzYwNTExMDc1MjA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDcSXbLi4gpggIHwz8Bbc27eKDA7uK4IrGHgoXCqEHStAesLN1RLiEsnAOZ8sXXEnafIfaE5SPOpWmcFknoz2hpMHQaKuwJHpW4C1LnqbXp/mRe+MkwaAhz5IY1c858Vlj+XQpEzca7f8we/PRjymy8g65eYtOXwIa5HMb6a+jNl7iLHuvKKfPg5KaYXKO4E5Oo1IAi7SCeGnoYUw6TvoXuUqrqfPhKKTTTAT9XdAZboUQlQRETzStvLTNiThc5c/NxE60jbWOX+2NeUBjTV3Tv2LOaGVykZTmted1VQPpO3Q20MbNzzsM9xACUm3/Yy9I9nEgH2TLP7+OmoATuNqOXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAI4KOBXqz3SUBw1yr14ulIb39afOak+6Je0xqfs0wHFj1QOtqm/1Bitm1htGC4ThLc2S12ptc0OOp9/hfTou9wneqyiXwiDcnm8k9MtwfkwqT6hIOvnxz8CmNlaDq0ZK9PmDXvOzCX2fbdphLsP+Fsf34OCg/O84cbmF1h2LpjPQ3+2K+Vc0IdKqZE34s4Y53d45SzJLE6Nvhh4ET7/os8SLeSi3C85y8h/1U5fiYDOBqrTwufzk8nJ4brwYjqnfNWigpdbvHaw0x3YA6JYCZk9Ro1Wk2UhsxONo0p5i5cCZnXcDl6g+jmuoJwaNwGJYoNr3RxbaQAagC9qUuMtriOg=
4dcc0e96-4574-467b-a43d-012a1054fd02	5e183852-4e81-4f73-9137-0886994f20f9	priority	100
ec693dcd-66a3-4a82-9d55-859e283706c5	5e183852-4e81-4f73-9137-0886994f20f9	keyUse	ENC
6fe63eb7-8de5-416d-a4cc-64cb929ba1aa	5e183852-4e81-4f73-9137-0886994f20f9	privateKey	MIIEpAIBAAKCAQEA3El2y4uIKYICB8M/AW3Nu3igwO7iuCKxh4KFwqhB0rQHrCzdUS4hLJwDmfLF1xJ2nyH2hOUjzqVpnBZJ6M9oaTB0GirsCR6VuAtS56m16f5kXvjJMGgIc+SGNXPOfFZY/l0KRM3Gu3/MHvz0Y8psvIOuXmLTl8CGuRzG+mvozZe4ix7ryinz4OSmmFyjuBOTqNSAIu0gnhp6GFMOk76F7lKq6nz4Sik00wE/V3QGW6FEJUERE80rby0zYk4XOXPzcROtI21jl/tjXlAY01d079izmhlcpGU5rXndVUD6Tt0NtDGzc87DPcQAlJt/2MvSPZxIB9kyz+/jpqAE7jajlwIDAQABAoIBAGx2D3Oww94MEQvZalA9zCod/qh/9klLa7WY4lsxlRc1ZQG1JVMvL05TksJd8mMuyBEaG9LbL4Izl4guwT1LwdDo9oFb2NO0p2ryyGMgAF2xz6GjRQv8bQ0C28G9v1EhArha/w9ZchwnlE09pubraBZ5j4URi7UQKkVCkgYC06FFxDRpZCUOAfw7P57SA2/TEavMB5O66+nYMHViwcfihTzEs4zh6yrgMo5rKCLQ0cGXT5dh7bak/xRTXUC/9musXzgfOtpiuoGImOOVHhc6EmsPt2Bd4Jf7/7PiR4lzrijX5T+WI2j0kmVPs79FARpcVfM8Xck+iawi7t79w4/86CECgYEA/1VE8Kh6onvAJza1yeKkUJwiWg+2AXRC+LdxbZZUvOPvshlrDAFYmClu7xSHQKo919oJk6OnYYlKfjfL4Bb2V5r3VeZdESqEZorm8Gi2psMqQNuVFwLxYlKzg2Yht06mejSCODAI3QvpJ/qMtyGtje/dK76nE0EiB7d0XaHLWLMCgYEA3NzCx2Ko0e7DnToZE4MQfdyzQ69cEC3GqwBSAaGirQZfakkkAtdWnT6dFThZjXj02gJoCN+sAsFXEIcptxcLT5M6Ldgi6UIfeiSSLU0E0Y+kv/wSNilNUYAkWkkICQzLnX/JGVcRTgvB1MUlmRZXWq4CgYFc4LwNZh8dq5GYk40CgYEA5cJ4J8qjl+Sds2uyx7kvPO5SpxIuKD7TKPYBlqhJFjRR88SVpBbt/vaBwZeKYbEPt1WXeogwTT96jfttdPeUsp5a5KxHoPPOcmuZhknj2koSkoxFK5DVXzGmIZ5cxpN6kMsBRshKoYZfRz9ZMk2W2/s03XFQ7K2WjrURfFPkJKsCgYEA0fokSHF49RXd7gYFPzK1JCQGXoxCp7MNlRfZ32kvgvZzElZ1ISpfU2Hq7/jB0ymzB+2PwRf9riToRHNsaoBDJaVgg6NgFYni6ToJq3303dOGG2xoWAvOUXTVmuyh8hCzKIsLwsavUhcFceb5BuFhrXmQMlWt2o+O4Y8loy7p8yUCgYBu8Z8zzJk5YKZpgf2UPsjvJn4JmIQEbjqK1o3Gq5bNp7sYcEuEOs7RXyEgmS7h56gxP0fun96KwrqoJxRWIhRtQDG1ZDtq8RT6mkwQxebG2RQUsV2xbJtzSnDPqAC36meZ1CrUqcdeW208jcq9m3xd3k0Sp0SZqo1PJpoYCNQm9w==
44aa2cb5-4dee-41ed-b8cf-a206462f5827	31adf9f0-8e80-4f62-abe4-79809bdd294d	privateKey	MIIEowIBAAKCAQEAjM8kiBYWV1uYflTlvMYgOGRJDEt+BUl4E5Nn+uu0J5HJqLZyzox1KO1ibdxO/ybc1TVMTvk1CLTuK/EjkVj9iVDy34dyBTL6lo9ci8DB3pP8mmZ8hcDhbhl9KKdZHzl3Cofoz5BQvncESNrw+L7WNQ00a5CVlt8ij5qXL6T/VQ8xJ4hYzPX20TfQGJTMjTJh2Et8eRXW6lige4mBu1n1rdmuxLfrdWL0/xihP0ZX6T1mO0VpyjOJqoCDONNyO2w/RiTzAEjN+dIlmiu3nxXBxpDN9+IoQrkphungJ3y3vLTuHF6JAjkCVgINfTs+/Qz6PKP5Ot56wll4HL+BqnqAdQIDAQABAoIBAADVeDQXrj/5sDWIvmNnw/ZL0OI2uGDwkLFMIMiwX28SIGn9eAnMK3/gzEr150luLWFB/u/w7svcp0sjrnk0fKwrwTq8uMhRBzg7QAoW1Qg5p+oxu/ceYdUYDDDy1Z2ZiyB2uzlBc7YaL0LGegGh9a8lGfsw8uXVy2A1Z8O6XAW8PnC/4FNt89V7VjdLS56M7qQcoGRWh0L+auMG+84mRDzxSnTTrdETwu2R8/9+V+sfdfh4Rgtwtv9XS0mKYL61iF4ohmqOFDb+LAjf1RKh8dEd8TYzL2NYhKH5KKN+yQiX6QgShgf5BelTF1vKm5FqmO/k0ny2HKoO+QTLXUvsELkCgYEAv9V6za08ql2GJYMjFaoTx6fexT8JdpUAIq+X5XHpLZC8YbVbZ1GyvfVRAPC9VstkjvALGCXcFGsHUfe7peoNW0XycGLWRZK5+o9Shiut9a1okwuXxC5wg3tjFYwVkFfwqgYD79A8AIKV8Xs396BPeyr2OHuVS5oXR+TIC+7Dpk0CgYEAu+h4lhywktCKH8RW/I3mwyZ4xlO1PeayBKcpYzCWSfFfYECgDiKxyjgaCF9Fecz1lxkf7MTMNAcAiksLB7I4myEJWmWGYPeTr5H31E3FxzRuSRroi6K0OgQIDHFtKmUQFgUq65ofwqCPTSfYTuiKGJ99NWfYcvYVtTabUDqjpskCgYB1WoeRo1Tlc+lIsXyZGD6ZeVySlgmX/XbjwT/PIWxgb5aOv393KUeLZbN0O9HYcvzFZJuk3iRQaVlFD6Q/z3r0R0oU7qHeVfBoE52MbtQw4zCCJCln3nD+PlFTMStP7jxQBvYJkv3h4gEQhSyr0+pLkvClhRTD9zQeyxqGEj6mUQKBgQCe8NIe1wGcDXznxeF2GmkYpI//4YoqY9osCWD+n3hf7ySne8Jmcn5D+BQ9BKj1j6IkPoI8eXHoiAuy7irURbGPte/9YGa72m43UZZ5I5epGfY3K+WLRwJ/GC3eqIqYE4f5uEFHq8Q1ki3kK1HR3OwCS9VSuRXil7hg4WGaCR+n0QKBgHUAjW9upmUVP9+gR4076F6c9hJuSsP96E1DD13iEgXH2khm2ESrUyZH8XHb067PjUNW3LDYbqS44B7eo0rOnL3101/e7JE8wQUwt5UIg/bcClNQgQ1xsshRJVwubmDTb+be7uC2kqGMR0Y4m4/1it+PSPkeoPYkO/wqmnrbDbcJ
c42197a2-6199-4f9b-ba90-86da7aa942d7	31adf9f0-8e80-4f62-abe4-79809bdd294d	certificate	MIICmzCCAYMCBgGeFgWcwzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTExMDc1MDI3WhcNMzYwNTExMDc1MjA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCMzySIFhZXW5h+VOW8xiA4ZEkMS34FSXgTk2f667QnkcmotnLOjHUo7WJt3E7/JtzVNUxO+TUItO4r8SORWP2JUPLfh3IFMvqWj1yLwMHek/yaZnyFwOFuGX0op1kfOXcKh+jPkFC+dwRI2vD4vtY1DTRrkJWW3yKPmpcvpP9VDzEniFjM9fbRN9AYlMyNMmHYS3x5FdbqWKB7iYG7WfWt2a7Et+t1YvT/GKE/RlfpPWY7RWnKM4mqgIM403I7bD9GJPMASM350iWaK7efFcHGkM334ihCuSmG6eAnfLe8tO4cXokCOQJWAg19Oz79DPo8o/k63nrCWXgcv4GqeoB1AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAo+uFTgSLbf8oR9H6GFTLmN8Z36XZ7D3NBMVeWk8T6e8uX27fFIx857BSDetqHoWS1bYh92SCNbKdibOKByF326ESQpMUkUY2g5O2Tu7bk2oo1G9GUol+50E+QnxMcO+9BN+hzdbKFsUfw8WaINtiYStNBigDDXhrd0F40W8t0InwjHUr6OVzuEkXLc5qJOHlqK1ckSkZ9viQqJRmK4xP9J5ah5O1Cnu1m2rT/m5bJu0Keln/gugOLXPC+AHj5hAaDvaMKDPuwrZuOEPvtwgEZN7Lhm0Q4fgi3siEp9TaUmA7aSZ5fXXw6kf7nrjhdpxbZpWwa0G6RPPJFSsWaiKZE=
26e05445-67b0-41b6-960a-b5aefcdecb22	31adf9f0-8e80-4f62-abe4-79809bdd294d	keyUse	SIG
beb4b09a-9b1b-4f96-9787-f1928f7c02c0	31adf9f0-8e80-4f62-abe4-79809bdd294d	priority	100
b2969958-9b03-4747-94e8-12ecbb64e135	8bce115b-9515-4614-8f4b-8fb73bab936b	secret	JGnbGPpxfAMBbwH4JgmiuwbCzgiA940dKGzZmLgCOfx1xVu5cU79E8YOSh-1iB0ZooIib8MFkqfhiGlxBYZaPg
2e94e7b8-ef77-4593-ab58-c82ed944531c	8bce115b-9515-4614-8f4b-8fb73bab936b	priority	100
251c869e-86c5-4bcf-bc66-dd4e965745d2	8bce115b-9515-4614-8f4b-8fb73bab936b	algorithm	HS256
e605488b-e28e-4bf0-b412-de725b33913c	8bce115b-9515-4614-8f4b-8fb73bab936b	kid	98e343e9-af96-4d6e-bb1a-759cd6191ae9
ddba68ce-d90d-4c6c-b9f3-cd5567583ba1	94059eab-bce0-4022-821c-7b25057f60a7	kid	2f40d01c-86ff-46fd-8156-67371890bf05
7e94e5ff-43a2-4745-9d4c-4d3b7c26978b	94059eab-bce0-4022-821c-7b25057f60a7	secret	pbR-p92cqgEkgXmWcp99VL_8tFzCtp7r0U61i2EfcMGrU3ZUor-2VeRHfXcs5WFXXfeDp7iSFWgzGXFKQFnVxQ
837d6076-87f8-4138-872a-4a6a0215d438	94059eab-bce0-4022-821c-7b25057f60a7	priority	100
c98984aa-0ac9-4cb0-9700-2bd79c9ef7c2	94059eab-bce0-4022-821c-7b25057f60a7	algorithm	HS256
70a3d04f-c48f-42ab-a0c8-e4f427a9f930	0a3c0e65-5e6a-456f-be93-b05605796800	priority	100
ee0fef2b-074a-4b41-a931-ee658b6506f9	0a3c0e65-5e6a-456f-be93-b05605796800	secret	NDSjRecI2j6Vf-UKaht1iA
963f135f-ef7d-4289-b688-fdf7b589f9db	0a3c0e65-5e6a-456f-be93-b05605796800	kid	d24e78f5-9f9d-4c13-98fc-51afaa5115c4
81dcbb72-920b-42fc-bd1e-ad12d2e4d0d1	e92f756a-2cef-4725-9019-bf2a2501b5c7	keyUse	ENC
91711e20-9eff-49d2-bddb-213c950612eb	e92f756a-2cef-4725-9019-bf2a2501b5c7	certificate	MIICmzCCAYMCBgGeFgYzqzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZ1bm5vYmEwHhcNMjYwNTExMDc1MTA1WhcNMzYwNTExMDc1MjQ1WjARMQ8wDQYDVQQDDAZ1bm5vYmEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCxyzz/H1cnjAa6S/cL6hin02O5FUzlW8/P8bcN+2adLhMx53RWx2TRYdDwZ1B7o3cA5oVE2pzPvcHHuxvX8+XuM8ou78t7xe/T901Pt/iw93RH4YfjIes0AqI0IXU6m8D9hNToG5nh4klcDcK4SiLmqRkbe7Z7HdyaixXLo6FUsPO1PRjAGegUtj5HFn7elCeV7XFtrfHcsUkYQft6VjTSuaDyuzbkkCSPPRP/zBvpO/79NYSj8Lqr4dNLTxWbNTDIQgPLkxutfA4tjljDQGBk4+RoOd7SGWnsO1k3boYT+gZtpUF5/wgeYjt03JviW9xmV9+ytl7RlfsX93nesPyDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGMC3yGBYqb+mlS62+IWLme2ax/g2PSlFW66IhfgexpG+AW+2VDqMdAt/zcwj8DPLqLMcFOYEiv1drqCSv5CoNvaA28T1T1NuCg4lAthVi3pd9i7Rk/apqM2sEgLZuMKan6EI4qvv5Pqt+C1k/xrmDg2RiUwtWnATrerf++uyNCGjzN1v5WHv5Xk5+jT8b3GFWrbfgi7BJcU8VwSgx2lCQITk8g2ZAvZs4w2xz9SX8GHkKcxLCsXHTdh52yS3OorMsDfXnotwzIf4uoo6Wg2Wuhpz4YJ5IbCgBAoVBmf0AVAMK5440G23R0gt6vCg12OopZqYX5ZNutI5Dj7jiHcfMI=
78aced54-87ec-4e25-9f31-0c4ba81dba80	e92f756a-2cef-4725-9019-bf2a2501b5c7	priority	100
e39ddf94-a6e8-4663-97f4-82df83afdfca	e92f756a-2cef-4725-9019-bf2a2501b5c7	algorithm	RSA-OAEP
9d2eba20-b481-4ac2-8eb8-aea3c8012d67	e92f756a-2cef-4725-9019-bf2a2501b5c7	privateKey	MIIEowIBAAKCAQEAscs8/x9XJ4wGukv3C+oYp9NjuRVM5VvPz/G3DftmnS4TMed0Vsdk0WHQ8GdQe6N3AOaFRNqcz73Bx7sb1/Pl7jPKLu/Le8Xv0/dNT7f4sPd0R+GH4yHrNAKiNCF1OpvA/YTU6BuZ4eJJXA3CuEoi5qkZG3u2ex3cmosVy6OhVLDztT0YwBnoFLY+RxZ+3pQnle1xba3x3LFJGEH7elY00rmg8rs25JAkjz0T/8wb6Tv+/TWEo/C6q+HTS08VmzUwyEIDy5MbrXwOLY5Yw0BgZOPkaDne0hlp7DtZN26GE/oGbaVBef8IHmI7dNyb4lvcZlffsrZe0ZX7F/d53rD8gwIDAQABAoIBACmWouQCjr5/cKtvTZCJ586KEg+fPeeAvHGl1u38Wpp1xqOrwnjyF1ErElbJs/fX2uRpB899W6T0fDmeOPsg4C4CC09DZFPFjz4D4R++pvuuRpLx3Hly27PE0fBjyyo0eMZUpgDNRAekiQhxZ5T4MoXGFEtretn9uDamRijmU7yda6Xv8LaXueqBOzUnUNEPWqvzwBiDiQMzsLK4PHpZgqNF3Vl7Y7vAJNHrjdJk8xgOeSKSqC5WgCTWiE+uk2wLGv7JoJFZFrbYhBUiYgjoNkREyOCao275e2oA3es3kg5fQA2nWTO3gUPAfmStR7IG9Nk036DoarteUUmt77pC3DECgYEA5taT0g9wH03wU4l946i7Qp5kEPAaMti5QuyMlCDHdVdrmTqp5g8ONME1Vd09QOAIgVdzc6HyqIhUVUI7OHt/rSvA/v/HuHiN81FvpYRTcZ28N1vFsz1kyGpIoMn6JbyER5EGhRxofdXAwF+Set2/Ll6xLHwe7QkqTzCqxZC9QucCgYEAxSx8nIP39jphOZ8gvUVGR3iMWT0XNfgIqIOqMfgZzZiez5ZBheKin9j6jfmhxIq6XiKa+j8q0R93fzNpgzzsiZ/3j54caVHduWAR45XbnNfev22VvDQAX1H7rCs72D5SiU8NtHc58WXCJGTzWnEUZidIxPOX4nkl9S4Vii+EIgUCgYEAmNLesmc+F7uFrAiOq7X9o7ExFnWfIqKQpFnvB/JbmrfxqFRKPuEgypRPNzVtZBHuD5NR/+/rst/u1TMv+cjpUkBxWWEFXH+Tms8DV1Uv2TxQa2X6kRvIKVcUFj8huPIBsU+2PVH9a7GkFrgvReCgvZY7PfQ+lTdIJ31U0c9tPWkCgYB5fWDGm7XkXLJda8QjexTDou5vaensUgkbtAzhPyq++KQZ6k4zLaLgdTRk2ISpcoVEzXPKb7N1KTtbABWqTJa+cfd64YRGDLBesWg0X7jymjxgnSgez7fPA9fbjMQSCMyYWEJsiO4F5JpMDHu5pWVZUClRWXqji9wshxm0jHSQ9QKBgFk42ptWNblhc8ckTz4IQN7QlyjjRnssepC+1Pjwd1Ue33WzD1VZVQbjyJ5Vlso95hRbY6dTLdABOpKeNaZPHJodIMo5Izh3wE7a52h5AFWKQ9zcPscMvx+swGj5muOIQFFfEjI04A+GCJ24smmHe63fIyVZXa5Ra6ewYRM4n5ca
001285c0-4830-4309-af57-ebc6ab8f1db6	367990eb-07c8-4738-a543-c80399b37d67	privateKey	MIIEowIBAAKCAQEAyweg0coAiV/WF87PSYjJ9cZ0jEmaJRgcATpbpkStdzstIfaNbrX2yTWgqkklQIXU9WO37qW8jzUP9krTV9h/zgLDZZxXpMIYm1GGFyqy9aWCKhooICu4TnlageKT7d8huQT+yr2QpxsiVaHEgREsh1saoJZdPSj7MQ988d7JQYsbK8K6LyrslQZvRRnHKGb0Q8KeVHdk6q5TNbUSUs4Yq6niEwkq8kvSjs/Y5juOlDseuLF5j2iP0s2vOyZ2Tai2eyzUOYB6te6EMfi5vw1TjyzSxf9r9K9T1+1r6grGRF0aDp+Z/kvEmPbdEwsS643KeuPMY1yPulxIBrD+gIiFMwIDAQABAoIBADvhTxQw0MGzi1BQRaC5gF9FneA2YQkpuDDAhoFeZg7xXBlVP1d0wYmMkItIsXz7O9j4BSqUpS1TiBaq8PRKvT8EX57bYpoMSPeeLr8sb8W1f9NtDYKXgm9aqU//hIO2uJp6F6+yAzTV8uVwpaUvbIOrYgoU7wD30kYg/EfV3mO+3Q1kDoVY9J0XGgqw+pRj/GJk7z8iOyPbrMDQA0vKH9qVtuii1FBq6Z2lNC70q+zGsPTo2viDAwiob3IN/KwSgVKWaLhK1i2xCY+mQUFbFLiK2EsEv1HcitKKBuADncPOvv0C90eanAVm7Ly4qpEA8Z0cou3TQovQczmwbVp6cEkCgYEA/d1YlAZs5B75oyBU4USB6zdvGNSau8H+58uZ+58Gy+qwuykm3DFYqoH3mBsjdzEUuA/7jXc8B95WGh/aUJtwErd51oNXFiANZoALwlcvm0VARVrG4ZGEWj2yWICd930Fi6/hqYXSxgXI/msoUjgpYyK3HkgBpL5oVxIP3MODm/0CgYEAzLzRbf27Sr+c5OnOFgPpeaWE96bOqGqDGI0nSQiMzePZ8Rjg4L4twyJUV3cuCfA4e6t7L2W4RziQNy85do1YvSBLQduR0X//MMjGS1BW9SbK4zDnzG3KqpKGSPVKxc6AHO96DuYIBm289bgJ3Ac43+TMuWlSdo1ZcgUYxHWstO8CgYB8CWtfH+iSaUQF3SU7z7I+0B37Ht3fgUDf1o4M8D1s4uWo/Mlc6stsvAXSjuf8M8Hw0PZSv4BYQ90D9K5BlkDjFDx2gEPLrqt9enDEar76+ZIWkOz9h5EIWn7KWUVViANupef3YUiDso3rKUZRLdmi83JPXFVZPiNS76NKdUjXrQKBgBrsMXYPSZO4wr7vZ+RJO2h9tZCDZOWMrBSMa0AVWb6xWbV0mg2ztHzWhNTDnVA9QJAyqo4/CA6Fh6FaGmpWh/bGyl6squ4rsLkPjdPVirnOEhvyEGk3ftETV4k8iEqerwYfD6Pp5+BAifqd6t3+LSJ0Cd/P08I3MC3oMauT9dQNAoGBAIbQkDY9CbfqV0vuMdsCcjX/QhDR9M9aDf+uE7mbn3lJanGeWRLUJH/OKKe4ymyuCG46Me1ppPEJesga+S6esJyOWeV0uyfNXbYKuS303YLBSaMleWzGtpDCnrN/1Wlts1kLlxh6sBP2H/MeN0AjQIrihgtlJYHVsKtXIxzSqTV6
fe6389c5-6eb9-4241-934f-70aa52781470	367990eb-07c8-4738-a543-c80399b37d67	priority	100
3e66dbf7-3f7c-4278-bdf2-0faf7f874ded	367990eb-07c8-4738-a543-c80399b37d67	keyUse	SIG
d2506b9b-69f1-4bc3-9230-51e925779d5a	367990eb-07c8-4738-a543-c80399b37d67	certificate	MIICmzCCAYMCBgGeFgYyUDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZ1bm5vYmEwHhcNMjYwNTExMDc1MTA1WhcNMzYwNTExMDc1MjQ1WjARMQ8wDQYDVQQDDAZ1bm5vYmEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLB6DRygCJX9YXzs9JiMn1xnSMSZolGBwBOlumRK13Oy0h9o1utfbJNaCqSSVAhdT1Y7fupbyPNQ/2StNX2H/OAsNlnFekwhibUYYXKrL1pYIqGiggK7hOeVqB4pPt3yG5BP7KvZCnGyJVocSBESyHWxqgll09KPsxD3zx3slBixsrwrovKuyVBm9FGccoZvRDwp5Ud2TqrlM1tRJSzhirqeITCSryS9KOz9jmO46UOx64sXmPaI/Sza87JnZNqLZ7LNQ5gHq17oQx+Lm/DVOPLNLF/2v0r1PX7WvqCsZEXRoOn5n+S8SY9t0TCxLrjcp648xjXI+6XEgGsP6AiIUzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJrJX7YjKJTCQW+YCoRucpsDg+1YMCw3EEQnfE39TdaZYkK9UKs8DDP+tw04QI7uMdqk7JSuFE8J29wol1mKBnkdMGYBYSWSq1LNmlzjHj20tP3OAc5+lC2kbF1wE5IiUHlvJUhUdH7aiohLotFf/+P+ya0czsPaIWSFLkoC2IIx7wTM9wXr0cwM2ez1ASQvyB2P4AuDtZG4R3qdx5tvCF/51XyjSah5Bjh2HZMwFFp1rVRYamOM0fP1ALvuuleDk6kr1KFHeyX5ksRTpotBtdwKPdNsPn9oTfkRATdhcIRTBSz0416vvepeT5I2BDUejSAHjpozWXwkx/om0dein9A=
37881951-1fe1-4ab4-bb3a-2cb7b299b258	2504af85-9405-4556-841d-5870bcc1b11b	allow-default-scopes	true
9b30accb-6f07-4538-b1b5-59fcfda9b763	3d59a3b1-abea-4840-9247-c9012724802e	host-sending-registration-request-must-match	true
5a23b5ed-447e-4b93-99dd-f6a05e355ecf	3d59a3b1-abea-4840-9247-c9012724802e	client-uris-must-match	true
0e114b29-329e-4d19-b2de-6aaac9cba489	b4998005-3abb-4e59-b535-c884ac77bf59	allow-default-scopes	true
0ad5cceb-2a05-4461-b45b-bf83a210d54f	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	oidc-address-mapper
3b874b6d-9f1c-44fc-9485-6a491db410be	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	saml-role-list-mapper
38bfbcee-9b2a-4f36-97e9-31ee3e0ef1b1	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	saml-user-property-mapper
fe1f737e-c774-416d-8b9d-082e98fdacda	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
7d4dccb1-0a4e-4da3-89f2-86e8b3db8338	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	saml-user-attribute-mapper
d7b05875-7f6f-4110-b916-862d23a3c323	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
1a49e5a9-b864-4f49-9789-cf1750690665	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b3f02a63-e2ba-4831-bca7-4f7046eccf27	97f27b54-1ee8-4f34-8bb4-47c172f3a6f9	allowed-protocol-mapper-types	oidc-full-name-mapper
5827f850-5d76-41ad-a9ff-21c533e50ac7	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	saml-user-property-mapper
3a71bfc9-9a8d-4f57-aefc-de10fac76471	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
531c6741-d5fe-4c91-a412-ba3ab3f5a6f8	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	saml-role-list-mapper
dc74dc24-4861-46ba-91e8-caf312c14802	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	oidc-full-name-mapper
28d0926d-e685-441f-bd15-c76cd4aa259b	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	saml-user-attribute-mapper
fca3ddb9-2fb2-4435-8c7c-8661b64182e3	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d69a980d-9754-4e9f-baa6-98e25ec5db9c	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4ff68d4d-404a-49d6-9ad7-12c861507614	bfecca90-01b7-42f8-bcc7-207cdefbfcb2	allowed-protocol-mapper-types	oidc-address-mapper
d1ff2438-b564-4490-a91b-dd8f6dffee21	e5a1134f-93cc-436f-b145-46259115bc76	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
d9195ddb-003a-4d7a-bc15-352186b0ea88	0de06f84-815e-4c3e-b4e6-9f5614ef7700
d9195ddb-003a-4d7a-bc15-352186b0ea88	ff7d72a3-fe4c-40ed-b216-244935ce93ef
d9195ddb-003a-4d7a-bc15-352186b0ea88	dd0e4d6c-dce0-46f1-a65a-6f8ea6022a2a
d9195ddb-003a-4d7a-bc15-352186b0ea88	f0158f53-bb24-478e-9819-3a2b3761d623
d9195ddb-003a-4d7a-bc15-352186b0ea88	449a6091-134d-4e7f-9f1a-1f66ae31a205
d9195ddb-003a-4d7a-bc15-352186b0ea88	e9c7eac8-3615-4f21-91be-55217e48f397
d9195ddb-003a-4d7a-bc15-352186b0ea88	98652787-324e-4659-956e-83edbcdd4c41
d9195ddb-003a-4d7a-bc15-352186b0ea88	a60bcb09-3f1f-421f-a6bb-e8e226d845bf
d9195ddb-003a-4d7a-bc15-352186b0ea88	672851a4-76cc-4de3-89e5-3e85a0ec5e0e
d9195ddb-003a-4d7a-bc15-352186b0ea88	6896db4c-f746-4563-b0ed-67cc35204c26
d9195ddb-003a-4d7a-bc15-352186b0ea88	63a0c1e7-c5c2-4bbf-8e9d-5b7b50e0fad2
d9195ddb-003a-4d7a-bc15-352186b0ea88	627626dd-4fa3-464b-81d3-baab0d0cf7f9
d9195ddb-003a-4d7a-bc15-352186b0ea88	3947aafc-918e-4669-831d-3efe02fcf4b1
d9195ddb-003a-4d7a-bc15-352186b0ea88	22c106d5-f395-46a1-a275-93d3591045b8
d9195ddb-003a-4d7a-bc15-352186b0ea88	3e7564ba-8c8e-4351-9ec4-12cc428c9c2d
d9195ddb-003a-4d7a-bc15-352186b0ea88	2b46ff05-c90e-465d-bdd5-3d5df2fc2416
d9195ddb-003a-4d7a-bc15-352186b0ea88	264b7754-4a81-41aa-bd87-1561acd7fbf7
d9195ddb-003a-4d7a-bc15-352186b0ea88	e17a52bf-690b-48e5-9323-b9dbc2ad6887
449a6091-134d-4e7f-9f1a-1f66ae31a205	2b46ff05-c90e-465d-bdd5-3d5df2fc2416
f0158f53-bb24-478e-9819-3a2b3761d623	3e7564ba-8c8e-4351-9ec4-12cc428c9c2d
f0158f53-bb24-478e-9819-3a2b3761d623	e17a52bf-690b-48e5-9323-b9dbc2ad6887
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	63133af4-5509-404e-a333-a7e3baa0ec46
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	fceab210-d5fe-4fa9-a2da-82174f90f401
fceab210-d5fe-4fa9-a2da-82174f90f401	cb453048-8348-4c79-afc4-730dd4c8ebe7
14b68286-c3c4-4146-943a-8b5262c44ce7	0265af0c-a628-44f8-99cf-dc77b9d3b0af
d9195ddb-003a-4d7a-bc15-352186b0ea88	b2221fb2-634a-4e85-9f53-01abe69e21f8
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	8059a2fb-5237-4893-b8ee-e1fbe87829a4
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	5398f7a4-395c-4d01-8be6-7abda0ec34e1
d9195ddb-003a-4d7a-bc15-352186b0ea88	bc58b19f-3645-4dfb-95ff-8665f78e4434
d9195ddb-003a-4d7a-bc15-352186b0ea88	d8503f7c-ce54-4bb0-aefe-8339498a8f79
d9195ddb-003a-4d7a-bc15-352186b0ea88	6ab5cd01-0270-4d26-af98-190deb4cb32f
d9195ddb-003a-4d7a-bc15-352186b0ea88	28ad3c8d-edfb-4d6e-9a50-69700e7dd9f0
d9195ddb-003a-4d7a-bc15-352186b0ea88	b3313a60-e8cd-4f4a-bd76-4e5ec25e6fed
d9195ddb-003a-4d7a-bc15-352186b0ea88	cd46d86b-ce1e-4ddb-a599-6898a7057353
d9195ddb-003a-4d7a-bc15-352186b0ea88	97a465f1-8eb6-4feb-9cf8-02bf6ddb81ec
d9195ddb-003a-4d7a-bc15-352186b0ea88	81b204f7-4d31-40f6-b3e3-1635a562e769
d9195ddb-003a-4d7a-bc15-352186b0ea88	ec073602-ee53-481f-8ac8-c18f06d6ff96
d9195ddb-003a-4d7a-bc15-352186b0ea88	73250174-00b6-4bd7-ae59-0fdb8c89a008
d9195ddb-003a-4d7a-bc15-352186b0ea88	cd291721-514a-4527-80d9-c7b637b756bb
d9195ddb-003a-4d7a-bc15-352186b0ea88	5d757976-622f-4b21-b8a5-a8b1768fd2dc
d9195ddb-003a-4d7a-bc15-352186b0ea88	bd8b4f26-f1ef-4955-9eba-8574fd67e879
d9195ddb-003a-4d7a-bc15-352186b0ea88	acd3ee3e-5a48-4657-8473-6508be3313a0
d9195ddb-003a-4d7a-bc15-352186b0ea88	71c55d4b-e0f6-44ea-81a0-3322fcaed27c
d9195ddb-003a-4d7a-bc15-352186b0ea88	7fe7c264-78d0-4d21-b7a2-f1f89e69e011
d9195ddb-003a-4d7a-bc15-352186b0ea88	5f9c6940-92a0-4495-b2ba-9d998d0d5d5e
28ad3c8d-edfb-4d6e-9a50-69700e7dd9f0	71c55d4b-e0f6-44ea-81a0-3322fcaed27c
6ab5cd01-0270-4d26-af98-190deb4cb32f	acd3ee3e-5a48-4657-8473-6508be3313a0
6ab5cd01-0270-4d26-af98-190deb4cb32f	5f9c6940-92a0-4495-b2ba-9d998d0d5d5e
dd17f8dc-231f-4988-8b1d-1294999bbeb2	53c2e2b6-9e84-40a9-9fd7-362e9db4d9a0
dd17f8dc-231f-4988-8b1d-1294999bbeb2	cda6c5a2-15b0-4074-9fc3-1ad652e8de2f
dd17f8dc-231f-4988-8b1d-1294999bbeb2	c6fcdeb6-422e-46ea-94ad-74e3b3f0569e
dd17f8dc-231f-4988-8b1d-1294999bbeb2	61af8394-617e-44df-9750-e423a58e2319
dd17f8dc-231f-4988-8b1d-1294999bbeb2	f6200f1b-6ac9-43bb-8fda-78317279d480
dd17f8dc-231f-4988-8b1d-1294999bbeb2	d9b7c3eb-437c-4c7c-b39e-4225eeb07c4c
dd17f8dc-231f-4988-8b1d-1294999bbeb2	468c3e58-6d3c-43ec-b0e9-b8ccaf917b26
dd17f8dc-231f-4988-8b1d-1294999bbeb2	983fdf40-cfaf-407b-b154-5468debc96cc
dd17f8dc-231f-4988-8b1d-1294999bbeb2	14db64e0-eb77-4a18-8b89-e50cab510190
dd17f8dc-231f-4988-8b1d-1294999bbeb2	554e808c-836b-42ee-9b0a-e4ea0633c66d
dd17f8dc-231f-4988-8b1d-1294999bbeb2	9458b380-2c7c-422d-8555-5b90653d1dd3
dd17f8dc-231f-4988-8b1d-1294999bbeb2	eb54404c-ba03-422e-a402-f28eed6cfe17
dd17f8dc-231f-4988-8b1d-1294999bbeb2	95cb7868-1280-4ba2-a98a-6e90347e42d6
dd17f8dc-231f-4988-8b1d-1294999bbeb2	eff1d8c4-6d09-414d-86d1-62a8f2e2a377
dd17f8dc-231f-4988-8b1d-1294999bbeb2	bf06c0f5-eacd-41f9-8828-2f2440f47d27
dd17f8dc-231f-4988-8b1d-1294999bbeb2	ce4e0f4e-e8bc-4bc5-b5d6-d6817dacd7d4
dd17f8dc-231f-4988-8b1d-1294999bbeb2	6b331f2d-7777-412d-b13d-824368ad832f
61af8394-617e-44df-9750-e423a58e2319	bf06c0f5-eacd-41f9-8828-2f2440f47d27
c6fcdeb6-422e-46ea-94ad-74e3b3f0569e	eff1d8c4-6d09-414d-86d1-62a8f2e2a377
c6fcdeb6-422e-46ea-94ad-74e3b3f0569e	6b331f2d-7777-412d-b13d-824368ad832f
e0f27b45-ca2e-4920-bc94-b53a924304ea	59df46ee-17c7-4721-ae50-f80fc81d6824
e0f27b45-ca2e-4920-bc94-b53a924304ea	d99b2ccf-3e97-4eeb-942d-1a5cb530f1c2
d99b2ccf-3e97-4eeb-942d-1a5cb530f1c2	bf63a1bc-1265-4ae9-ad5f-05a0b45464ce
a0352bec-585a-4f27-ad91-31d16a17fa45	cba12445-ae86-49e1-a7b6-72bb496ec817
d9195ddb-003a-4d7a-bc15-352186b0ea88	637ce645-8782-4e3b-8026-8e23e539249f
dd17f8dc-231f-4988-8b1d-1294999bbeb2	4f3029b0-2f0c-4caf-8748-4d58f8ffc627
e0f27b45-ca2e-4920-bc94-b53a924304ea	c4abc542-4878-4505-b231-6c033e4ab688
e0f27b45-ca2e-4920-bc94-b53a924304ea	638f38bf-be84-4f19-8fd2-fe4d1af7010e
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
6c42e3a9-ab6d-44bb-97eb-38f2aad35c6b	\N	password	f66796ff-500b-4da3-9614-682bd259cc8f	1778485927984	\N	{"value":"LTWGLSzudNFzVK79mAT50FgRGh1+ijLz5orMp55QNm0=","salt":"WKAzwpPxKhsPvOL31KYobQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
ca37233e-3052-471e-9f8f-ca2691adbfb2	\N	password	6781ef79-5913-40f5-9c1b-beecf146915e	1779582244075	My password	{"value":"7ozgxZXMv0pseRkwWkfolmXU7l76vHd9VgJ1J1nm58U=","salt":"BUKFWY3+h+BjxOMFPghBGw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f7fe60c3-2379-4839-a729-2ceb2e4898f9	\N	password	77a4ed03-8c3e-4222-b4ec-5de932f3d7a2	1779584266517	\N	{"value":"iYHkCVGcsgaJ4ArSY913GVum+QnW9ivadrJm+LnVntk=","salt":"/V6ibiLyuRXwtoLQ/jlGmA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
46cf83bc-3bff-4573-8cfb-8c8ae5536f6b	\N	password	943516f1-a0f9-401e-a630-b56f6579dddb	1779584277288	\N	{"value":"c8ncsyPAVR2f8i2sl/fe3ks7a1NXVZOvle7hXwtCUN4=","salt":"N7Fw98dYQ2Fy+39PRsEWSg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
739da705-c267-4b65-87ec-460db2355508	\N	password	9b7a2450-11d5-4c10-bf13-da4080c11135	1779590188243	\N	{"value":"sIMPTDqDLnSN2hpoU5fbihp9RlGLr439hwVjsN9M+p0=","salt":"Z9jAQZvSJRcrBBT6vp2sIQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-05-11 07:51:59.734797	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	8485918407
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-05-11 07:51:59.784564	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	8485918407
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-05-11 07:51:59.884344	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	8485918407
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-05-11 07:51:59.897064	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	8485918407
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-05-11 07:52:00.169384	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	8485918407
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-05-11 07:52:00.199963	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	8485918407
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-05-11 07:52:00.410623	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	8485918407
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-05-11 07:52:00.439485	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	8485918407
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-05-11 07:52:00.45918	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	8485918407
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-05-11 07:52:00.727649	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	8485918407
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-05-11 07:52:00.858997	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	8485918407
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-05-11 07:52:00.877995	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	8485918407
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-05-11 07:52:00.918589	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	8485918407
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-11 07:52:00.97444	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	8485918407
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-11 07:52:00.980168	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	8485918407
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-11 07:52:00.987063	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	8485918407
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-11 07:52:00.994807	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	8485918407
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-05-11 07:52:01.101294	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	8485918407
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-05-11 07:52:01.213801	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	8485918407
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-05-11 07:52:01.228009	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	8485918407
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-11 07:52:01.242679	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	8485918407
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-11 07:52:01.250922	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	8485918407
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-05-11 07:52:01.296005	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	8485918407
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-05-11 07:52:01.309795	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	8485918407
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-05-11 07:52:01.31525	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	8485918407
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-05-11 07:52:01.425979	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	8485918407
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-05-11 07:52:01.660397	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	8485918407
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-05-11 07:52:01.66988	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	8485918407
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-05-11 07:52:01.844056	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	8485918407
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-05-11 07:52:01.876152	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	8485918407
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-05-11 07:52:01.92211	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	8485918407
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-05-11 07:52:01.932844	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	8485918407
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-11 07:52:01.946505	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	8485918407
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-11 07:52:01.953257	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	8485918407
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-11 07:52:02.038175	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	8485918407
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-05-11 07:52:02.050284	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	8485918407
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-11 07:52:02.067465	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	8485918407
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-05-11 07:52:02.077386	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	8485918407
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-05-11 07:52:02.089747	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	8485918407
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-11 07:52:02.094824	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	8485918407
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-11 07:52:02.101943	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	8485918407
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-05-11 07:52:02.111381	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	8485918407
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-11 07:52:02.583257	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	8485918407
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-05-11 07:52:02.605441	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	8485918407
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-11 07:52:02.620825	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	8485918407
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-11 07:52:02.631541	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	8485918407
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-11 07:52:02.637645	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	8485918407
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-11 07:52:02.740003	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	8485918407
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-11 07:52:02.751037	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	8485918407
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-05-11 07:52:02.91397	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	8485918407
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-05-11 07:52:03.015934	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	8485918407
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-05-11 07:52:03.026668	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-05-11 07:52:03.033758	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	8485918407
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-05-11 07:52:03.040512	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	8485918407
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-11 07:52:03.060117	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	8485918407
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-11 07:52:03.072009	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	8485918407
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-11 07:52:03.199041	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	8485918407
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-11 07:52:03.441672	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	8485918407
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-05-11 07:52:03.51824	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	8485918407
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-05-11 07:52:03.541842	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	8485918407
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-11 07:52:03.577143	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	8485918407
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-11 07:52:03.605142	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	8485918407
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-05-11 07:52:03.713748	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	8485918407
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-05-11 07:52:03.721802	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	8485918407
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-11 07:52:03.729982	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	8485918407
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-05-11 07:52:03.769957	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	8485918407
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-11 07:52:03.788741	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	8485918407
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-05-11 07:52:03.800893	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	8485918407
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-05-11 07:52:03.826213	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	8485918407
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-05-11 07:52:03.841679	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	8485918407
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-05-11 07:52:03.858978	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	8485918407
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-11 07:52:03.881119	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	8485918407
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-11 07:52:03.903069	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	8485918407
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-11 07:52:03.912111	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	8485918407
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-11 07:52:03.980996	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	8485918407
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-11 07:52:04.002514	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	8485918407
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-11 07:52:04.014652	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	8485918407
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-11 07:52:04.020159	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	8485918407
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-11 07:52:04.124109	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	8485918407
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-11 07:52:04.133932	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	8485918407
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-11 07:52:04.155822	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	8485918407
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-11 07:52:04.162018	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	8485918407
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-11 07:52:04.175206	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	8485918407
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-11 07:52:04.180248	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	8485918407
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-11 07:52:04.1999	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	8485918407
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-05-11 07:52:04.211906	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	8485918407
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-11 07:52:04.232886	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	8485918407
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-11 07:52:04.262033	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	8485918407
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.278401	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	8485918407
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.296203	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	8485918407
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.318495	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	8485918407
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.338443	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	8485918407
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.343476	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	8485918407
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.367497	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	8485918407
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.37428	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	8485918407
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-11 07:52:04.392556	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	8485918407
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.434023	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	8485918407
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.438592	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.452199	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.471182	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.476295	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.494852	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	8485918407
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-11 07:52:04.504505	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	8485918407
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-05-11 07:52:04.520799	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	8485918407
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-05-11 07:52:04.540684	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	8485918407
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-05-11 07:52:04.560035	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	8485918407
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-05-11 07:52:04.570348	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	8485918407
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-11 07:52:04.589389	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	8485918407
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-11 07:52:04.594596	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	8485918407
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-11 07:52:04.612682	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	8485918407
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-05-11 07:52:04.62383	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	8485918407
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-11 07:52:04.713621	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	8485918407
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-11 07:52:04.721272	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	8485918407
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-11 07:52:04.73469	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	8485918407
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-11 07:52:04.74042	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	8485918407
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-11 07:52:04.760627	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	8485918407
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-11 07:52:04.773294	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	8485918407
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
14123153-d306-4089-b889-95f0e3cfa7cd	72a0ac98-ebef-4047-a06b-cf5b17703bca	f
14123153-d306-4089-b889-95f0e3cfa7cd	f85cba21-d073-4a41-bb45-0cee0d066e04	t
14123153-d306-4089-b889-95f0e3cfa7cd	576771a5-f6d7-4f43-bb50-b0808f7aa2a5	t
14123153-d306-4089-b889-95f0e3cfa7cd	3be82b5b-8068-41fd-b270-7e216ef3d945	t
14123153-d306-4089-b889-95f0e3cfa7cd	776616ac-7f74-4b44-97e4-d9b8ac872f7a	f
14123153-d306-4089-b889-95f0e3cfa7cd	5753649c-aa76-4f08-af27-aa0ee3b11e2e	f
14123153-d306-4089-b889-95f0e3cfa7cd	6729c094-4296-48a3-b7ad-4677b0a296a6	t
14123153-d306-4089-b889-95f0e3cfa7cd	0fce45cf-919e-416b-8c0a-18bf2725e6a9	t
14123153-d306-4089-b889-95f0e3cfa7cd	96f1eeec-a797-4437-a57e-caec6cbc0133	f
14123153-d306-4089-b889-95f0e3cfa7cd	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	411eb3ca-ae92-4ba6-8b7f-0c529a31e5b1	f
178a10d4-4dc3-44fb-86de-1dd2d795c19f	37c44c2a-060e-4e4b-87ab-6020646a352a	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	a12387c2-855c-4927-8938-22bcc73e54da	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	c026a8f2-9162-44cf-babc-c188c4856e59	f
178a10d4-4dc3-44fb-86de-1dd2d795c19f	63589987-e982-4c27-a827-94e62a3af714	f
178a10d4-4dc3-44fb-86de-1dd2d795c19f	8d282887-97ce-4e9a-be12-225585d1ad8d	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2	t
178a10d4-4dc3-44fb-86de-1dd2d795c19f	606aa32d-4807-485a-a043-cd031cc392aa	f
178a10d4-4dc3-44fb-86de-1dd2d795c19f	43d65480-f355-4584-b1f4-5d63511b779e	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	14123153-d306-4089-b889-95f0e3cfa7cd	f	${role_default-roles}	default-roles-master	14123153-d306-4089-b889-95f0e3cfa7cd	\N	\N
0de06f84-815e-4c3e-b4e6-9f5614ef7700	14123153-d306-4089-b889-95f0e3cfa7cd	f	${role_create-realm}	create-realm	14123153-d306-4089-b889-95f0e3cfa7cd	\N	\N
d9195ddb-003a-4d7a-bc15-352186b0ea88	14123153-d306-4089-b889-95f0e3cfa7cd	f	${role_admin}	admin	14123153-d306-4089-b889-95f0e3cfa7cd	\N	\N
ff7d72a3-fe4c-40ed-b216-244935ce93ef	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_create-client}	create-client	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
dd0e4d6c-dce0-46f1-a65a-6f8ea6022a2a	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-realm}	view-realm	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
f0158f53-bb24-478e-9819-3a2b3761d623	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-users}	view-users	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
449a6091-134d-4e7f-9f1a-1f66ae31a205	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-clients}	view-clients	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
e9c7eac8-3615-4f21-91be-55217e48f397	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-events}	view-events	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
98652787-324e-4659-956e-83edbcdd4c41	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-identity-providers}	view-identity-providers	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
a60bcb09-3f1f-421f-a6bb-e8e226d845bf	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_view-authorization}	view-authorization	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
672851a4-76cc-4de3-89e5-3e85a0ec5e0e	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-realm}	manage-realm	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
6896db4c-f746-4563-b0ed-67cc35204c26	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-users}	manage-users	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
63a0c1e7-c5c2-4bbf-8e9d-5b7b50e0fad2	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-clients}	manage-clients	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
627626dd-4fa3-464b-81d3-baab0d0cf7f9	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-events}	manage-events	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
3947aafc-918e-4669-831d-3efe02fcf4b1	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-identity-providers}	manage-identity-providers	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
22c106d5-f395-46a1-a275-93d3591045b8	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_manage-authorization}	manage-authorization	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
3e7564ba-8c8e-4351-9ec4-12cc428c9c2d	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_query-users}	query-users	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
2b46ff05-c90e-465d-bdd5-3d5df2fc2416	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_query-clients}	query-clients	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
264b7754-4a81-41aa-bd87-1561acd7fbf7	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_query-realms}	query-realms	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
e17a52bf-690b-48e5-9323-b9dbc2ad6887	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_query-groups}	query-groups	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
63133af4-5509-404e-a333-a7e3baa0ec46	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_view-profile}	view-profile	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
fceab210-d5fe-4fa9-a2da-82174f90f401	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_manage-account}	manage-account	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
cb453048-8348-4c79-afc4-730dd4c8ebe7	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_manage-account-links}	manage-account-links	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
21afb5d7-5afd-4e47-9e8d-1fe7215470de	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_view-applications}	view-applications	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
0265af0c-a628-44f8-99cf-dc77b9d3b0af	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_view-consent}	view-consent	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
14b68286-c3c4-4146-943a-8b5262c44ce7	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_manage-consent}	manage-consent	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
a122e34f-e74b-4bdb-8d02-7299ee55118d	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_view-groups}	view-groups	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
260069df-e831-424d-8b0d-69cf153d375e	859449bf-82bf-4c25-ad48-57536cb76e75	t	${role_delete-account}	delete-account	14123153-d306-4089-b889-95f0e3cfa7cd	859449bf-82bf-4c25-ad48-57536cb76e75	\N
2cc2b12a-89e6-47a5-a5c0-8bbbf6a6d9d8	081fb9d4-b290-49e4-8bc0-341d18d41f19	t	${role_read-token}	read-token	14123153-d306-4089-b889-95f0e3cfa7cd	081fb9d4-b290-49e4-8bc0-341d18d41f19	\N
b2221fb2-634a-4e85-9f53-01abe69e21f8	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	t	${role_impersonation}	impersonation	14123153-d306-4089-b889-95f0e3cfa7cd	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	\N
8059a2fb-5237-4893-b8ee-e1fbe87829a4	14123153-d306-4089-b889-95f0e3cfa7cd	f	${role_offline-access}	offline_access	14123153-d306-4089-b889-95f0e3cfa7cd	\N	\N
5398f7a4-395c-4d01-8be6-7abda0ec34e1	14123153-d306-4089-b889-95f0e3cfa7cd	f	${role_uma_authorization}	uma_authorization	14123153-d306-4089-b889-95f0e3cfa7cd	\N	\N
e0f27b45-ca2e-4920-bc94-b53a924304ea	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f	${role_default-roles}	default-roles-unnoba	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N	\N
bc58b19f-3645-4dfb-95ff-8665f78e4434	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_create-client}	create-client	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
d8503f7c-ce54-4bb0-aefe-8339498a8f79	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-realm}	view-realm	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
6ab5cd01-0270-4d26-af98-190deb4cb32f	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-users}	view-users	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
28ad3c8d-edfb-4d6e-9a50-69700e7dd9f0	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-clients}	view-clients	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
b3313a60-e8cd-4f4a-bd76-4e5ec25e6fed	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-events}	view-events	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
cd46d86b-ce1e-4ddb-a599-6898a7057353	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-identity-providers}	view-identity-providers	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
97a465f1-8eb6-4feb-9cf8-02bf6ddb81ec	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_view-authorization}	view-authorization	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
81b204f7-4d31-40f6-b3e3-1635a562e769	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-realm}	manage-realm	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
ec073602-ee53-481f-8ac8-c18f06d6ff96	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-users}	manage-users	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
73250174-00b6-4bd7-ae59-0fdb8c89a008	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-clients}	manage-clients	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
cd291721-514a-4527-80d9-c7b637b756bb	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-events}	manage-events	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
5d757976-622f-4b21-b8a5-a8b1768fd2dc	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-identity-providers}	manage-identity-providers	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
bd8b4f26-f1ef-4955-9eba-8574fd67e879	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_manage-authorization}	manage-authorization	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
acd3ee3e-5a48-4657-8473-6508be3313a0	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_query-users}	query-users	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
71c55d4b-e0f6-44ea-81a0-3322fcaed27c	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_query-clients}	query-clients	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
7fe7c264-78d0-4d21-b7a2-f1f89e69e011	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_query-realms}	query-realms	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
5f9c6940-92a0-4495-b2ba-9d998d0d5d5e	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_query-groups}	query-groups	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
dd17f8dc-231f-4988-8b1d-1294999bbeb2	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_realm-admin}	realm-admin	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
53c2e2b6-9e84-40a9-9fd7-362e9db4d9a0	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_create-client}	create-client	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
cda6c5a2-15b0-4074-9fc3-1ad652e8de2f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-realm}	view-realm	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
c6fcdeb6-422e-46ea-94ad-74e3b3f0569e	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-users}	view-users	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
61af8394-617e-44df-9750-e423a58e2319	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-clients}	view-clients	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
f6200f1b-6ac9-43bb-8fda-78317279d480	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-events}	view-events	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
d9b7c3eb-437c-4c7c-b39e-4225eeb07c4c	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-identity-providers}	view-identity-providers	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
468c3e58-6d3c-43ec-b0e9-b8ccaf917b26	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_view-authorization}	view-authorization	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
983fdf40-cfaf-407b-b154-5468debc96cc	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-realm}	manage-realm	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
14db64e0-eb77-4a18-8b89-e50cab510190	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-users}	manage-users	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
554e808c-836b-42ee-9b0a-e4ea0633c66d	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-clients}	manage-clients	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
9458b380-2c7c-422d-8555-5b90653d1dd3	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-events}	manage-events	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
eb54404c-ba03-422e-a402-f28eed6cfe17	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-identity-providers}	manage-identity-providers	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
95cb7868-1280-4ba2-a98a-6e90347e42d6	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_manage-authorization}	manage-authorization	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
eff1d8c4-6d09-414d-86d1-62a8f2e2a377	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_query-users}	query-users	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
bf06c0f5-eacd-41f9-8828-2f2440f47d27	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_query-clients}	query-clients	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
ce4e0f4e-e8bc-4bc5-b5d6-d6817dacd7d4	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_query-realms}	query-realms	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
6b331f2d-7777-412d-b13d-824368ad832f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_query-groups}	query-groups	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
59df46ee-17c7-4721-ae50-f80fc81d6824	31abbace-d518-4094-b320-8ae3c264f262	t	${role_view-profile}	view-profile	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
d99b2ccf-3e97-4eeb-942d-1a5cb530f1c2	31abbace-d518-4094-b320-8ae3c264f262	t	${role_manage-account}	manage-account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
bf63a1bc-1265-4ae9-ad5f-05a0b45464ce	31abbace-d518-4094-b320-8ae3c264f262	t	${role_manage-account-links}	manage-account-links	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
a50ac989-8908-41a1-8e32-d9d75442d679	31abbace-d518-4094-b320-8ae3c264f262	t	${role_view-applications}	view-applications	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
cba12445-ae86-49e1-a7b6-72bb496ec817	31abbace-d518-4094-b320-8ae3c264f262	t	${role_view-consent}	view-consent	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
a0352bec-585a-4f27-ad91-31d16a17fa45	31abbace-d518-4094-b320-8ae3c264f262	t	${role_manage-consent}	manage-consent	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
e2ef76e5-2a73-467d-89fc-9cb3cd18c2fa	31abbace-d518-4094-b320-8ae3c264f262	t	${role_view-groups}	view-groups	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
46fcd0ab-5a71-479f-a2d1-2f49431c02dd	31abbace-d518-4094-b320-8ae3c264f262	t	${role_delete-account}	delete-account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	31abbace-d518-4094-b320-8ae3c264f262	\N
637ce645-8782-4e3b-8026-8e23e539249f	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	t	${role_impersonation}	impersonation	14123153-d306-4089-b889-95f0e3cfa7cd	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	\N
4f3029b0-2f0c-4caf-8748-4d58f8ffc627	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	t	${role_impersonation}	impersonation	178a10d4-4dc3-44fb-86de-1dd2d795c19f	3949a6ff-332f-4a9c-be55-67aeaa70dcc3	\N
f0a5b195-9f08-404d-9469-2833976ba9c7	0ab01938-4396-4424-b1f9-83db520605f0	t	${role_read-token}	read-token	178a10d4-4dc3-44fb-86de-1dd2d795c19f	0ab01938-4396-4424-b1f9-83db520605f0	\N
c4abc542-4878-4505-b231-6c033e4ab688	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f	${role_offline-access}	offline_access	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N	\N
638f38bf-be84-4f19-8fd2-fe4d1af7010e	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f	${role_uma_authorization}	uma_authorization	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N	\N
d9532c4a-10b5-4ca1-9d19-9382c267b11a	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f		admin	178a10d4-4dc3-44fb-86de-1dd2d795c19f	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
4dfb4	23.0.7	1778485925
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
59c7cc28-b8bc-43c6-aed4-5b5f2edf7f6d	audience resolve	openid-connect	oidc-audience-resolve-mapper	61ff02ee-6245-4ecd-bd34-b47489aa4f71	\N
5dad46b7-5be5-4e38-af46-5e5a05c7b351	locale	openid-connect	oidc-usermodel-attribute-mapper	785b9dfb-13bb-4747-8629-befad8b73e33	\N
8f9516ba-b5b2-4daf-aa03-13d026785b26	role list	saml	saml-role-list-mapper	\N	f85cba21-d073-4a41-bb45-0cee0d066e04
572a5133-03be-4703-8bce-01183818f7db	full name	openid-connect	oidc-full-name-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
c56d73b9-93f4-4efc-a655-972a2a23f575	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
0ffe706f-96e4-450c-9140-e1cb363d5111	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
494765bf-a319-45ec-988a-1e7c89e5b223	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
1702dd35-c13d-4509-b4d1-eb0041d07657	username	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
a13a1842-20da-44f2-a7c2-5b047ca0d577	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
627eba9d-6c49-4da7-a798-535f0e36b92f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
12273a9b-d70d-4090-bc21-e7de74cef635	website	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
01d51e63-8973-4d9c-ae48-241eeb9e585e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
05833bb7-5415-4ec7-9880-f3a8ce34908c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	576771a5-f6d7-4f43-bb50-b0808f7aa2a5
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	3be82b5b-8068-41fd-b270-7e216ef3d945
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3be82b5b-8068-41fd-b270-7e216ef3d945
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	address	openid-connect	oidc-address-mapper	\N	776616ac-7f74-4b44-97e4-d9b8ac872f7a
45a14ad0-c844-411a-b4f6-92715a7ed4a4	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	5753649c-aa76-4f08-af27-aa0ee3b11e2e
0e45d317-f9e6-44bf-9c10-609a68632d83	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	5753649c-aa76-4f08-af27-aa0ee3b11e2e
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	6729c094-4296-48a3-b7ad-4677b0a296a6
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	6729c094-4296-48a3-b7ad-4677b0a296a6
4bc4a617-eca2-4b53-96a6-78f9fbf1e119	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	6729c094-4296-48a3-b7ad-4677b0a296a6
90a8ece8-57b6-4662-9edd-fd9422ed707e	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	0fce45cf-919e-416b-8c0a-18bf2725e6a9
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	96f1eeec-a797-4437-a57e-caec6cbc0133
c7669945-7cf1-440f-ad1f-559d2fec286c	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	96f1eeec-a797-4437-a57e-caec6cbc0133
feb92ae2-bd81-4d54-8ad5-fe1318f84c7a	acr loa level	openid-connect	oidc-acr-mapper	\N	4eee91e6-b5b1-41f0-9d40-df0eba6cd63e
a2411245-2002-4dcf-81ee-524696b27198	audience resolve	openid-connect	oidc-audience-resolve-mapper	44556d33-a0db-49b3-aa13-8d408e5eda99	\N
cf7d1109-e9c4-4f82-864e-b490232e8691	role list	saml	saml-role-list-mapper	\N	37c44c2a-060e-4e4b-87ab-6020646a352a
e507b208-db86-43b1-966e-91c04829bf53	full name	openid-connect	oidc-full-name-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
fb3b3759-6aee-4483-92ce-b35f7c765cfc	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
22b28fd1-6a18-4682-b0fa-b551d8cfc629	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
d586b76b-19ad-4890-bb47-89215da8d161	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
20cee9a8-d105-4f01-93ce-6de455a228b3	username	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
b2c15209-a00f-412a-8cf1-f91e6af85b4d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
da388021-1ef0-42d7-8b3c-6d246a62a15e	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
047398f5-e0a1-4ee1-a806-000d141ad982	website	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
9542f2f4-472c-46a4-93a1-f06e94777604	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
5e12f88e-e280-4dca-bdee-c3d51546aa36	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	5e3a5455-f9c6-4897-960e-5fde3fd7c9cd
5f03941f-6e1e-4336-be63-fa7134135865	email	openid-connect	oidc-usermodel-attribute-mapper	\N	a12387c2-855c-4927-8938-22bcc73e54da
69101e69-d984-4b16-9439-159548185cf7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a12387c2-855c-4927-8938-22bcc73e54da
74403339-8e93-41d0-b912-fef70baf2079	address	openid-connect	oidc-address-mapper	\N	c026a8f2-9162-44cf-babc-c188c4856e59
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	63589987-e982-4c27-a827-94e62a3af714
ff1ed0c2-c026-4534-9a65-5555cda75b4f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	63589987-e982-4c27-a827-94e62a3af714
db7aaddc-fad9-437f-8dca-b1aed3b012ec	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8d282887-97ce-4e9a-be12-225585d1ad8d
025afab5-c210-4c9b-b5fb-a32a72b47311	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8d282887-97ce-4e9a-be12-225585d1ad8d
65d3936b-f1ab-4ed6-946e-1f14a26d4294	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8d282887-97ce-4e9a-be12-225585d1ad8d
5d816024-789b-4cff-883d-b27d236890fa	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8c3fa127-97a4-4a1d-b5c7-873c6a6f3af2
8279f684-dd2f-4c52-b4ab-49c70e9de865	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	606aa32d-4807-485a-a043-cd031cc392aa
947f6c12-45b0-4377-be6a-f93916e4c7b9	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	606aa32d-4807-485a-a043-cd031cc392aa
0639d9e5-781f-4940-936e-db138de0c60f	acr loa level	openid-connect	oidc-acr-mapper	\N	43d65480-f355-4584-b1f4-5d63511b779e
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	locale	openid-connect	oidc-usermodel-attribute-mapper	e6206f81-3d57-4e7f-9e54-64f93d766ca6	\N
ffa2604a-d70e-41fa-8ecb-e73819090a4e	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	4112d709-d5c5-48e0-994c-631da6c04c9c	\N
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	4112d709-d5c5-48e0-994c-631da6c04c9c	\N
c4de028f-d134-43b6-be5d-ea34f920de29	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	4112d709-d5c5-48e0-994c-631da6c04c9c	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
5dad46b7-5be5-4e38-af46-5e5a05c7b351	true	introspection.token.claim
5dad46b7-5be5-4e38-af46-5e5a05c7b351	true	userinfo.token.claim
5dad46b7-5be5-4e38-af46-5e5a05c7b351	locale	user.attribute
5dad46b7-5be5-4e38-af46-5e5a05c7b351	true	id.token.claim
5dad46b7-5be5-4e38-af46-5e5a05c7b351	true	access.token.claim
5dad46b7-5be5-4e38-af46-5e5a05c7b351	locale	claim.name
5dad46b7-5be5-4e38-af46-5e5a05c7b351	String	jsonType.label
8f9516ba-b5b2-4daf-aa03-13d026785b26	false	single
8f9516ba-b5b2-4daf-aa03-13d026785b26	Basic	attribute.nameformat
8f9516ba-b5b2-4daf-aa03-13d026785b26	Role	attribute.name
01d51e63-8973-4d9c-ae48-241eeb9e585e	true	introspection.token.claim
01d51e63-8973-4d9c-ae48-241eeb9e585e	true	userinfo.token.claim
01d51e63-8973-4d9c-ae48-241eeb9e585e	gender	user.attribute
01d51e63-8973-4d9c-ae48-241eeb9e585e	true	id.token.claim
01d51e63-8973-4d9c-ae48-241eeb9e585e	true	access.token.claim
01d51e63-8973-4d9c-ae48-241eeb9e585e	gender	claim.name
01d51e63-8973-4d9c-ae48-241eeb9e585e	String	jsonType.label
05833bb7-5415-4ec7-9880-f3a8ce34908c	true	introspection.token.claim
05833bb7-5415-4ec7-9880-f3a8ce34908c	true	userinfo.token.claim
05833bb7-5415-4ec7-9880-f3a8ce34908c	updatedAt	user.attribute
05833bb7-5415-4ec7-9880-f3a8ce34908c	true	id.token.claim
05833bb7-5415-4ec7-9880-f3a8ce34908c	true	access.token.claim
05833bb7-5415-4ec7-9880-f3a8ce34908c	updated_at	claim.name
05833bb7-5415-4ec7-9880-f3a8ce34908c	long	jsonType.label
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	true	introspection.token.claim
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	true	userinfo.token.claim
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	locale	user.attribute
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	true	id.token.claim
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	true	access.token.claim
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	locale	claim.name
0dd86d66-67ca-4757-b3ac-dbc7f8a7a821	String	jsonType.label
0ffe706f-96e4-450c-9140-e1cb363d5111	true	introspection.token.claim
0ffe706f-96e4-450c-9140-e1cb363d5111	true	userinfo.token.claim
0ffe706f-96e4-450c-9140-e1cb363d5111	middleName	user.attribute
0ffe706f-96e4-450c-9140-e1cb363d5111	true	id.token.claim
0ffe706f-96e4-450c-9140-e1cb363d5111	true	access.token.claim
0ffe706f-96e4-450c-9140-e1cb363d5111	middle_name	claim.name
0ffe706f-96e4-450c-9140-e1cb363d5111	String	jsonType.label
12273a9b-d70d-4090-bc21-e7de74cef635	true	introspection.token.claim
12273a9b-d70d-4090-bc21-e7de74cef635	true	userinfo.token.claim
12273a9b-d70d-4090-bc21-e7de74cef635	website	user.attribute
12273a9b-d70d-4090-bc21-e7de74cef635	true	id.token.claim
12273a9b-d70d-4090-bc21-e7de74cef635	true	access.token.claim
12273a9b-d70d-4090-bc21-e7de74cef635	website	claim.name
12273a9b-d70d-4090-bc21-e7de74cef635	String	jsonType.label
1702dd35-c13d-4509-b4d1-eb0041d07657	true	introspection.token.claim
1702dd35-c13d-4509-b4d1-eb0041d07657	true	userinfo.token.claim
1702dd35-c13d-4509-b4d1-eb0041d07657	username	user.attribute
1702dd35-c13d-4509-b4d1-eb0041d07657	true	id.token.claim
1702dd35-c13d-4509-b4d1-eb0041d07657	true	access.token.claim
1702dd35-c13d-4509-b4d1-eb0041d07657	preferred_username	claim.name
1702dd35-c13d-4509-b4d1-eb0041d07657	String	jsonType.label
494765bf-a319-45ec-988a-1e7c89e5b223	true	introspection.token.claim
494765bf-a319-45ec-988a-1e7c89e5b223	true	userinfo.token.claim
494765bf-a319-45ec-988a-1e7c89e5b223	nickname	user.attribute
494765bf-a319-45ec-988a-1e7c89e5b223	true	id.token.claim
494765bf-a319-45ec-988a-1e7c89e5b223	true	access.token.claim
494765bf-a319-45ec-988a-1e7c89e5b223	nickname	claim.name
494765bf-a319-45ec-988a-1e7c89e5b223	String	jsonType.label
572a5133-03be-4703-8bce-01183818f7db	true	introspection.token.claim
572a5133-03be-4703-8bce-01183818f7db	true	userinfo.token.claim
572a5133-03be-4703-8bce-01183818f7db	true	id.token.claim
572a5133-03be-4703-8bce-01183818f7db	true	access.token.claim
627eba9d-6c49-4da7-a798-535f0e36b92f	true	introspection.token.claim
627eba9d-6c49-4da7-a798-535f0e36b92f	true	userinfo.token.claim
627eba9d-6c49-4da7-a798-535f0e36b92f	picture	user.attribute
627eba9d-6c49-4da7-a798-535f0e36b92f	true	id.token.claim
627eba9d-6c49-4da7-a798-535f0e36b92f	true	access.token.claim
627eba9d-6c49-4da7-a798-535f0e36b92f	picture	claim.name
627eba9d-6c49-4da7-a798-535f0e36b92f	String	jsonType.label
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	true	introspection.token.claim
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	true	userinfo.token.claim
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	firstName	user.attribute
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	true	id.token.claim
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	true	access.token.claim
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	given_name	claim.name
6b6f864b-9ce4-4cb1-9289-50e66d307ba1	String	jsonType.label
a13a1842-20da-44f2-a7c2-5b047ca0d577	true	introspection.token.claim
a13a1842-20da-44f2-a7c2-5b047ca0d577	true	userinfo.token.claim
a13a1842-20da-44f2-a7c2-5b047ca0d577	profile	user.attribute
a13a1842-20da-44f2-a7c2-5b047ca0d577	true	id.token.claim
a13a1842-20da-44f2-a7c2-5b047ca0d577	true	access.token.claim
a13a1842-20da-44f2-a7c2-5b047ca0d577	profile	claim.name
a13a1842-20da-44f2-a7c2-5b047ca0d577	String	jsonType.label
c56d73b9-93f4-4efc-a655-972a2a23f575	true	introspection.token.claim
c56d73b9-93f4-4efc-a655-972a2a23f575	true	userinfo.token.claim
c56d73b9-93f4-4efc-a655-972a2a23f575	lastName	user.attribute
c56d73b9-93f4-4efc-a655-972a2a23f575	true	id.token.claim
c56d73b9-93f4-4efc-a655-972a2a23f575	true	access.token.claim
c56d73b9-93f4-4efc-a655-972a2a23f575	family_name	claim.name
c56d73b9-93f4-4efc-a655-972a2a23f575	String	jsonType.label
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	true	introspection.token.claim
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	true	userinfo.token.claim
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	zoneinfo	user.attribute
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	true	id.token.claim
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	true	access.token.claim
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	zoneinfo	claim.name
d9519b46-a8e8-42b1-a252-6de0dac7c5e3	String	jsonType.label
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	true	introspection.token.claim
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	true	userinfo.token.claim
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	birthdate	user.attribute
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	true	id.token.claim
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	true	access.token.claim
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	birthdate	claim.name
f61ba84b-1b3c-488b-a39b-f078c2fe5d0e	String	jsonType.label
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	true	introspection.token.claim
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	true	userinfo.token.claim
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	email	user.attribute
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	true	id.token.claim
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	true	access.token.claim
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	email	claim.name
ba8c0197-e5a4-40c8-b5ef-95b9fc5ba71f	String	jsonType.label
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	true	introspection.token.claim
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	true	userinfo.token.claim
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	emailVerified	user.attribute
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	true	id.token.claim
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	true	access.token.claim
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	email_verified	claim.name
c6cee1ab-3bbf-4e22-acd9-a3f6ad9c7828	boolean	jsonType.label
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	formatted	user.attribute.formatted
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	country	user.attribute.country
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	true	introspection.token.claim
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	postal_code	user.attribute.postal_code
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	true	userinfo.token.claim
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	street	user.attribute.street
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	true	id.token.claim
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	region	user.attribute.region
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	true	access.token.claim
c82209fe-50d6-4c86-8944-8ee9b5a7a2fc	locality	user.attribute.locality
0e45d317-f9e6-44bf-9c10-609a68632d83	true	introspection.token.claim
0e45d317-f9e6-44bf-9c10-609a68632d83	true	userinfo.token.claim
0e45d317-f9e6-44bf-9c10-609a68632d83	phoneNumberVerified	user.attribute
0e45d317-f9e6-44bf-9c10-609a68632d83	true	id.token.claim
0e45d317-f9e6-44bf-9c10-609a68632d83	true	access.token.claim
0e45d317-f9e6-44bf-9c10-609a68632d83	phone_number_verified	claim.name
0e45d317-f9e6-44bf-9c10-609a68632d83	boolean	jsonType.label
45a14ad0-c844-411a-b4f6-92715a7ed4a4	true	introspection.token.claim
45a14ad0-c844-411a-b4f6-92715a7ed4a4	true	userinfo.token.claim
45a14ad0-c844-411a-b4f6-92715a7ed4a4	phoneNumber	user.attribute
45a14ad0-c844-411a-b4f6-92715a7ed4a4	true	id.token.claim
45a14ad0-c844-411a-b4f6-92715a7ed4a4	true	access.token.claim
45a14ad0-c844-411a-b4f6-92715a7ed4a4	phone_number	claim.name
45a14ad0-c844-411a-b4f6-92715a7ed4a4	String	jsonType.label
4bc4a617-eca2-4b53-96a6-78f9fbf1e119	true	introspection.token.claim
4bc4a617-eca2-4b53-96a6-78f9fbf1e119	true	access.token.claim
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	true	introspection.token.claim
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	true	multivalued
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	foo	user.attribute
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	true	access.token.claim
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	realm_access.roles	claim.name
a8cae42c-eaa9-4f0e-a4e4-77460342c56a	String	jsonType.label
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	true	introspection.token.claim
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	true	multivalued
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	foo	user.attribute
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	true	access.token.claim
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	resource_access.${client_id}.roles	claim.name
ccbe7fb3-b6bd-4b00-8980-27a8a4afa672	String	jsonType.label
90a8ece8-57b6-4662-9edd-fd9422ed707e	true	introspection.token.claim
90a8ece8-57b6-4662-9edd-fd9422ed707e	true	access.token.claim
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	true	introspection.token.claim
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	true	userinfo.token.claim
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	username	user.attribute
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	true	id.token.claim
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	true	access.token.claim
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	upn	claim.name
c6ca1bc5-4cf9-4d2f-9a04-347bcba5e52e	String	jsonType.label
c7669945-7cf1-440f-ad1f-559d2fec286c	true	introspection.token.claim
c7669945-7cf1-440f-ad1f-559d2fec286c	true	multivalued
c7669945-7cf1-440f-ad1f-559d2fec286c	foo	user.attribute
c7669945-7cf1-440f-ad1f-559d2fec286c	true	id.token.claim
c7669945-7cf1-440f-ad1f-559d2fec286c	true	access.token.claim
c7669945-7cf1-440f-ad1f-559d2fec286c	groups	claim.name
c7669945-7cf1-440f-ad1f-559d2fec286c	String	jsonType.label
feb92ae2-bd81-4d54-8ad5-fe1318f84c7a	true	introspection.token.claim
feb92ae2-bd81-4d54-8ad5-fe1318f84c7a	true	id.token.claim
feb92ae2-bd81-4d54-8ad5-fe1318f84c7a	true	access.token.claim
cf7d1109-e9c4-4f82-864e-b490232e8691	false	single
cf7d1109-e9c4-4f82-864e-b490232e8691	Basic	attribute.nameformat
cf7d1109-e9c4-4f82-864e-b490232e8691	Role	attribute.name
047398f5-e0a1-4ee1-a806-000d141ad982	true	introspection.token.claim
047398f5-e0a1-4ee1-a806-000d141ad982	true	userinfo.token.claim
047398f5-e0a1-4ee1-a806-000d141ad982	website	user.attribute
047398f5-e0a1-4ee1-a806-000d141ad982	true	id.token.claim
047398f5-e0a1-4ee1-a806-000d141ad982	true	access.token.claim
047398f5-e0a1-4ee1-a806-000d141ad982	website	claim.name
047398f5-e0a1-4ee1-a806-000d141ad982	String	jsonType.label
20cee9a8-d105-4f01-93ce-6de455a228b3	true	introspection.token.claim
20cee9a8-d105-4f01-93ce-6de455a228b3	true	userinfo.token.claim
20cee9a8-d105-4f01-93ce-6de455a228b3	username	user.attribute
20cee9a8-d105-4f01-93ce-6de455a228b3	true	id.token.claim
20cee9a8-d105-4f01-93ce-6de455a228b3	true	access.token.claim
20cee9a8-d105-4f01-93ce-6de455a228b3	preferred_username	claim.name
20cee9a8-d105-4f01-93ce-6de455a228b3	String	jsonType.label
22b28fd1-6a18-4682-b0fa-b551d8cfc629	true	introspection.token.claim
22b28fd1-6a18-4682-b0fa-b551d8cfc629	true	userinfo.token.claim
22b28fd1-6a18-4682-b0fa-b551d8cfc629	middleName	user.attribute
22b28fd1-6a18-4682-b0fa-b551d8cfc629	true	id.token.claim
22b28fd1-6a18-4682-b0fa-b551d8cfc629	true	access.token.claim
22b28fd1-6a18-4682-b0fa-b551d8cfc629	middle_name	claim.name
22b28fd1-6a18-4682-b0fa-b551d8cfc629	String	jsonType.label
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	true	introspection.token.claim
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	true	userinfo.token.claim
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	gender	user.attribute
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	true	id.token.claim
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	true	access.token.claim
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	gender	claim.name
53b00c2a-6d8a-47e6-9678-2b80eff2cf20	String	jsonType.label
5e12f88e-e280-4dca-bdee-c3d51546aa36	true	introspection.token.claim
5e12f88e-e280-4dca-bdee-c3d51546aa36	true	userinfo.token.claim
5e12f88e-e280-4dca-bdee-c3d51546aa36	updatedAt	user.attribute
5e12f88e-e280-4dca-bdee-c3d51546aa36	true	id.token.claim
5e12f88e-e280-4dca-bdee-c3d51546aa36	true	access.token.claim
5e12f88e-e280-4dca-bdee-c3d51546aa36	updated_at	claim.name
5e12f88e-e280-4dca-bdee-c3d51546aa36	long	jsonType.label
9542f2f4-472c-46a4-93a1-f06e94777604	true	introspection.token.claim
9542f2f4-472c-46a4-93a1-f06e94777604	true	userinfo.token.claim
9542f2f4-472c-46a4-93a1-f06e94777604	locale	user.attribute
9542f2f4-472c-46a4-93a1-f06e94777604	true	id.token.claim
9542f2f4-472c-46a4-93a1-f06e94777604	true	access.token.claim
9542f2f4-472c-46a4-93a1-f06e94777604	locale	claim.name
9542f2f4-472c-46a4-93a1-f06e94777604	String	jsonType.label
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	true	introspection.token.claim
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	true	userinfo.token.claim
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	zoneinfo	user.attribute
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	true	id.token.claim
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	true	access.token.claim
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	zoneinfo	claim.name
9eedd72e-a6ed-4f9e-923a-b09f6ff3aa3d	String	jsonType.label
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	true	introspection.token.claim
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	true	userinfo.token.claim
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	birthdate	user.attribute
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	true	id.token.claim
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	true	access.token.claim
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	birthdate	claim.name
a8a696b0-1de8-4d86-82e2-ae6b8af4442e	String	jsonType.label
b2c15209-a00f-412a-8cf1-f91e6af85b4d	true	introspection.token.claim
b2c15209-a00f-412a-8cf1-f91e6af85b4d	true	userinfo.token.claim
b2c15209-a00f-412a-8cf1-f91e6af85b4d	profile	user.attribute
b2c15209-a00f-412a-8cf1-f91e6af85b4d	true	id.token.claim
b2c15209-a00f-412a-8cf1-f91e6af85b4d	true	access.token.claim
b2c15209-a00f-412a-8cf1-f91e6af85b4d	profile	claim.name
b2c15209-a00f-412a-8cf1-f91e6af85b4d	String	jsonType.label
d586b76b-19ad-4890-bb47-89215da8d161	true	introspection.token.claim
d586b76b-19ad-4890-bb47-89215da8d161	true	userinfo.token.claim
d586b76b-19ad-4890-bb47-89215da8d161	nickname	user.attribute
d586b76b-19ad-4890-bb47-89215da8d161	true	id.token.claim
d586b76b-19ad-4890-bb47-89215da8d161	true	access.token.claim
d586b76b-19ad-4890-bb47-89215da8d161	nickname	claim.name
d586b76b-19ad-4890-bb47-89215da8d161	String	jsonType.label
da388021-1ef0-42d7-8b3c-6d246a62a15e	true	introspection.token.claim
da388021-1ef0-42d7-8b3c-6d246a62a15e	true	userinfo.token.claim
da388021-1ef0-42d7-8b3c-6d246a62a15e	picture	user.attribute
da388021-1ef0-42d7-8b3c-6d246a62a15e	true	id.token.claim
da388021-1ef0-42d7-8b3c-6d246a62a15e	true	access.token.claim
da388021-1ef0-42d7-8b3c-6d246a62a15e	picture	claim.name
da388021-1ef0-42d7-8b3c-6d246a62a15e	String	jsonType.label
e507b208-db86-43b1-966e-91c04829bf53	true	introspection.token.claim
e507b208-db86-43b1-966e-91c04829bf53	true	userinfo.token.claim
e507b208-db86-43b1-966e-91c04829bf53	true	id.token.claim
e507b208-db86-43b1-966e-91c04829bf53	true	access.token.claim
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	true	introspection.token.claim
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	true	userinfo.token.claim
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	lastName	user.attribute
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	true	id.token.claim
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	true	access.token.claim
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	family_name	claim.name
f211ce44-b6d4-4319-a7b0-0e38a5c593fb	String	jsonType.label
fb3b3759-6aee-4483-92ce-b35f7c765cfc	true	introspection.token.claim
fb3b3759-6aee-4483-92ce-b35f7c765cfc	true	userinfo.token.claim
fb3b3759-6aee-4483-92ce-b35f7c765cfc	firstName	user.attribute
fb3b3759-6aee-4483-92ce-b35f7c765cfc	true	id.token.claim
fb3b3759-6aee-4483-92ce-b35f7c765cfc	true	access.token.claim
fb3b3759-6aee-4483-92ce-b35f7c765cfc	given_name	claim.name
fb3b3759-6aee-4483-92ce-b35f7c765cfc	String	jsonType.label
5f03941f-6e1e-4336-be63-fa7134135865	true	introspection.token.claim
5f03941f-6e1e-4336-be63-fa7134135865	true	userinfo.token.claim
5f03941f-6e1e-4336-be63-fa7134135865	email	user.attribute
5f03941f-6e1e-4336-be63-fa7134135865	true	id.token.claim
5f03941f-6e1e-4336-be63-fa7134135865	true	access.token.claim
5f03941f-6e1e-4336-be63-fa7134135865	email	claim.name
5f03941f-6e1e-4336-be63-fa7134135865	String	jsonType.label
69101e69-d984-4b16-9439-159548185cf7	true	introspection.token.claim
69101e69-d984-4b16-9439-159548185cf7	true	userinfo.token.claim
69101e69-d984-4b16-9439-159548185cf7	emailVerified	user.attribute
69101e69-d984-4b16-9439-159548185cf7	true	id.token.claim
69101e69-d984-4b16-9439-159548185cf7	true	access.token.claim
69101e69-d984-4b16-9439-159548185cf7	email_verified	claim.name
69101e69-d984-4b16-9439-159548185cf7	boolean	jsonType.label
74403339-8e93-41d0-b912-fef70baf2079	formatted	user.attribute.formatted
74403339-8e93-41d0-b912-fef70baf2079	country	user.attribute.country
74403339-8e93-41d0-b912-fef70baf2079	true	introspection.token.claim
74403339-8e93-41d0-b912-fef70baf2079	postal_code	user.attribute.postal_code
74403339-8e93-41d0-b912-fef70baf2079	true	userinfo.token.claim
74403339-8e93-41d0-b912-fef70baf2079	street	user.attribute.street
74403339-8e93-41d0-b912-fef70baf2079	true	id.token.claim
74403339-8e93-41d0-b912-fef70baf2079	region	user.attribute.region
74403339-8e93-41d0-b912-fef70baf2079	true	access.token.claim
74403339-8e93-41d0-b912-fef70baf2079	locality	user.attribute.locality
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	true	introspection.token.claim
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	true	userinfo.token.claim
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	phoneNumber	user.attribute
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	true	id.token.claim
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	true	access.token.claim
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	phone_number	claim.name
0af9d443-e224-4cf4-bbcc-d2688dbd43f9	String	jsonType.label
ff1ed0c2-c026-4534-9a65-5555cda75b4f	true	introspection.token.claim
ff1ed0c2-c026-4534-9a65-5555cda75b4f	true	userinfo.token.claim
ff1ed0c2-c026-4534-9a65-5555cda75b4f	phoneNumberVerified	user.attribute
ff1ed0c2-c026-4534-9a65-5555cda75b4f	true	id.token.claim
ff1ed0c2-c026-4534-9a65-5555cda75b4f	true	access.token.claim
ff1ed0c2-c026-4534-9a65-5555cda75b4f	phone_number_verified	claim.name
ff1ed0c2-c026-4534-9a65-5555cda75b4f	boolean	jsonType.label
025afab5-c210-4c9b-b5fb-a32a72b47311	true	introspection.token.claim
025afab5-c210-4c9b-b5fb-a32a72b47311	true	multivalued
025afab5-c210-4c9b-b5fb-a32a72b47311	foo	user.attribute
025afab5-c210-4c9b-b5fb-a32a72b47311	true	access.token.claim
025afab5-c210-4c9b-b5fb-a32a72b47311	resource_access.${client_id}.roles	claim.name
025afab5-c210-4c9b-b5fb-a32a72b47311	String	jsonType.label
65d3936b-f1ab-4ed6-946e-1f14a26d4294	true	introspection.token.claim
65d3936b-f1ab-4ed6-946e-1f14a26d4294	true	access.token.claim
db7aaddc-fad9-437f-8dca-b1aed3b012ec	true	introspection.token.claim
db7aaddc-fad9-437f-8dca-b1aed3b012ec	true	multivalued
db7aaddc-fad9-437f-8dca-b1aed3b012ec	foo	user.attribute
db7aaddc-fad9-437f-8dca-b1aed3b012ec	true	access.token.claim
db7aaddc-fad9-437f-8dca-b1aed3b012ec	realm_access.roles	claim.name
db7aaddc-fad9-437f-8dca-b1aed3b012ec	String	jsonType.label
5d816024-789b-4cff-883d-b27d236890fa	true	introspection.token.claim
5d816024-789b-4cff-883d-b27d236890fa	true	access.token.claim
8279f684-dd2f-4c52-b4ab-49c70e9de865	true	introspection.token.claim
8279f684-dd2f-4c52-b4ab-49c70e9de865	true	userinfo.token.claim
8279f684-dd2f-4c52-b4ab-49c70e9de865	username	user.attribute
8279f684-dd2f-4c52-b4ab-49c70e9de865	true	id.token.claim
8279f684-dd2f-4c52-b4ab-49c70e9de865	true	access.token.claim
8279f684-dd2f-4c52-b4ab-49c70e9de865	upn	claim.name
8279f684-dd2f-4c52-b4ab-49c70e9de865	String	jsonType.label
947f6c12-45b0-4377-be6a-f93916e4c7b9	true	introspection.token.claim
947f6c12-45b0-4377-be6a-f93916e4c7b9	true	multivalued
947f6c12-45b0-4377-be6a-f93916e4c7b9	foo	user.attribute
947f6c12-45b0-4377-be6a-f93916e4c7b9	true	id.token.claim
947f6c12-45b0-4377-be6a-f93916e4c7b9	true	access.token.claim
947f6c12-45b0-4377-be6a-f93916e4c7b9	groups	claim.name
947f6c12-45b0-4377-be6a-f93916e4c7b9	String	jsonType.label
0639d9e5-781f-4940-936e-db138de0c60f	true	introspection.token.claim
0639d9e5-781f-4940-936e-db138de0c60f	true	id.token.claim
0639d9e5-781f-4940-936e-db138de0c60f	true	access.token.claim
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	true	introspection.token.claim
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	true	userinfo.token.claim
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	locale	user.attribute
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	true	id.token.claim
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	true	access.token.claim
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	locale	claim.name
481f0aad-9d7e-43a4-b108-6ce173fb3fb5	String	jsonType.label
c4de028f-d134-43b6-be5d-ea34f920de29	clientAddress	user.session.note
c4de028f-d134-43b6-be5d-ea34f920de29	true	introspection.token.claim
c4de028f-d134-43b6-be5d-ea34f920de29	true	id.token.claim
c4de028f-d134-43b6-be5d-ea34f920de29	true	access.token.claim
c4de028f-d134-43b6-be5d-ea34f920de29	clientAddress	claim.name
c4de028f-d134-43b6-be5d-ea34f920de29	String	jsonType.label
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	clientHost	user.session.note
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	true	introspection.token.claim
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	true	id.token.claim
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	true	access.token.claim
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	clientHost	claim.name
e0e0d7b4-4b16-4af6-a6c4-1bf6821432e2	String	jsonType.label
ffa2604a-d70e-41fa-8ecb-e73819090a4e	client_id	user.session.note
ffa2604a-d70e-41fa-8ecb-e73819090a4e	true	introspection.token.claim
ffa2604a-d70e-41fa-8ecb-e73819090a4e	true	id.token.claim
ffa2604a-d70e-41fa-8ecb-e73819090a4e	true	access.token.claim
ffa2604a-d70e-41fa-8ecb-e73819090a4e	client_id	claim.name
ffa2604a-d70e-41fa-8ecb-e73819090a4e	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
14123153-d306-4089-b889-95f0e3cfa7cd	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	f1a0e924-2f56-4d8d-9af8-ddaabf39921e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	dfdda666-9547-4c79-860f-9ccd52f0b7f7	636d1946-4356-4f2d-b2d9-c815a5360114	2d24af72-5b4f-41d1-abde-9c3ea3d3a797	8c4ba01d-6001-4c15-8900-cb35c19ed7bb	827a8e8d-fb8f-4aaa-ad4a-7df87631a8d3	2592000	f	900	t	f	d6b9e31c-7f03-49aa-9ae7-ce68e744adf8	0	f	0	0	f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951
178a10d4-4dc3-44fb-86de-1dd2d795c19f	60	300	300	\N	\N	\N	t	f	0	\N	unnoba	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	5f65b4ab-48e4-4048-9183-1fa4f7b260ac	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	aee35d5b-7f57-4b1f-b00c-b6132f941704	c455c0bc-ee80-4793-9d18-4513f20e6358	6998544f-ca4b-4c76-a2f3-cd3936ba3240	59121576-889e-49bd-ae0a-c825a49b0d20	3a26d255-fa37-494f-b434-869de3b8a71d	2592000	f	900	t	f	9439d19b-0869-4496-91fd-8029203ecc60	0	f	0	0	e0f27b45-ca2e-4920-bc94-b53a924304ea
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	14123153-d306-4089-b889-95f0e3cfa7cd	
_browser_header.xContentTypeOptions	14123153-d306-4089-b889-95f0e3cfa7cd	nosniff
_browser_header.referrerPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	no-referrer
_browser_header.xRobotsTag	14123153-d306-4089-b889-95f0e3cfa7cd	none
_browser_header.xFrameOptions	14123153-d306-4089-b889-95f0e3cfa7cd	SAMEORIGIN
_browser_header.contentSecurityPolicy	14123153-d306-4089-b889-95f0e3cfa7cd	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	14123153-d306-4089-b889-95f0e3cfa7cd	1; mode=block
_browser_header.strictTransportSecurity	14123153-d306-4089-b889-95f0e3cfa7cd	max-age=31536000; includeSubDomains
bruteForceProtected	14123153-d306-4089-b889-95f0e3cfa7cd	false
permanentLockout	14123153-d306-4089-b889-95f0e3cfa7cd	false
maxFailureWaitSeconds	14123153-d306-4089-b889-95f0e3cfa7cd	900
minimumQuickLoginWaitSeconds	14123153-d306-4089-b889-95f0e3cfa7cd	60
waitIncrementSeconds	14123153-d306-4089-b889-95f0e3cfa7cd	60
quickLoginCheckMilliSeconds	14123153-d306-4089-b889-95f0e3cfa7cd	1000
maxDeltaTimeSeconds	14123153-d306-4089-b889-95f0e3cfa7cd	43200
failureFactor	14123153-d306-4089-b889-95f0e3cfa7cd	30
realmReusableOtpCode	14123153-d306-4089-b889-95f0e3cfa7cd	false
displayName	14123153-d306-4089-b889-95f0e3cfa7cd	Keycloak
displayNameHtml	14123153-d306-4089-b889-95f0e3cfa7cd	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	14123153-d306-4089-b889-95f0e3cfa7cd	RS256
offlineSessionMaxLifespanEnabled	14123153-d306-4089-b889-95f0e3cfa7cd	false
offlineSessionMaxLifespan	14123153-d306-4089-b889-95f0e3cfa7cd	5184000
_browser_header.contentSecurityPolicyReportOnly	178a10d4-4dc3-44fb-86de-1dd2d795c19f	
_browser_header.xContentTypeOptions	178a10d4-4dc3-44fb-86de-1dd2d795c19f	nosniff
_browser_header.referrerPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	no-referrer
_browser_header.xRobotsTag	178a10d4-4dc3-44fb-86de-1dd2d795c19f	none
_browser_header.xFrameOptions	178a10d4-4dc3-44fb-86de-1dd2d795c19f	SAMEORIGIN
_browser_header.contentSecurityPolicy	178a10d4-4dc3-44fb-86de-1dd2d795c19f	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	178a10d4-4dc3-44fb-86de-1dd2d795c19f	1; mode=block
_browser_header.strictTransportSecurity	178a10d4-4dc3-44fb-86de-1dd2d795c19f	max-age=31536000; includeSubDomains
bruteForceProtected	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
permanentLockout	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
maxFailureWaitSeconds	178a10d4-4dc3-44fb-86de-1dd2d795c19f	900
minimumQuickLoginWaitSeconds	178a10d4-4dc3-44fb-86de-1dd2d795c19f	60
waitIncrementSeconds	178a10d4-4dc3-44fb-86de-1dd2d795c19f	60
quickLoginCheckMilliSeconds	178a10d4-4dc3-44fb-86de-1dd2d795c19f	1000
maxDeltaTimeSeconds	178a10d4-4dc3-44fb-86de-1dd2d795c19f	43200
failureFactor	178a10d4-4dc3-44fb-86de-1dd2d795c19f	30
realmReusableOtpCode	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
defaultSignatureAlgorithm	178a10d4-4dc3-44fb-86de-1dd2d795c19f	RS256
offlineSessionMaxLifespanEnabled	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
offlineSessionMaxLifespan	178a10d4-4dc3-44fb-86de-1dd2d795c19f	5184000
actionTokenGeneratedByAdminLifespan	178a10d4-4dc3-44fb-86de-1dd2d795c19f	43200
actionTokenGeneratedByUserLifespan	178a10d4-4dc3-44fb-86de-1dd2d795c19f	300
oauth2DeviceCodeLifespan	178a10d4-4dc3-44fb-86de-1dd2d795c19f	600
oauth2DevicePollingInterval	178a10d4-4dc3-44fb-86de-1dd2d795c19f	5
webAuthnPolicyRpEntityName	178a10d4-4dc3-44fb-86de-1dd2d795c19f	keycloak
webAuthnPolicySignatureAlgorithms	178a10d4-4dc3-44fb-86de-1dd2d795c19f	ES256
webAuthnPolicyRpId	178a10d4-4dc3-44fb-86de-1dd2d795c19f	
webAuthnPolicyAttestationConveyancePreference	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyAuthenticatorAttachment	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyRequireResidentKey	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyUserVerificationRequirement	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyCreateTimeout	178a10d4-4dc3-44fb-86de-1dd2d795c19f	0
webAuthnPolicyAvoidSameAuthenticatorRegister	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
webAuthnPolicyRpEntityNamePasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	ES256
webAuthnPolicyRpIdPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	
webAuthnPolicyAttestationConveyancePreferencePasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyRequireResidentKeyPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	not specified
webAuthnPolicyCreateTimeoutPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	false
cibaBackchannelTokenDeliveryMode	178a10d4-4dc3-44fb-86de-1dd2d795c19f	poll
cibaExpiresIn	178a10d4-4dc3-44fb-86de-1dd2d795c19f	120
cibaInterval	178a10d4-4dc3-44fb-86de-1dd2d795c19f	5
cibaAuthRequestedUserHint	178a10d4-4dc3-44fb-86de-1dd2d795c19f	login_hint
parRequestUriLifespan	178a10d4-4dc3-44fb-86de-1dd2d795c19f	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
14123153-d306-4089-b889-95f0e3cfa7cd	jboss-logging
178a10d4-4dc3-44fb-86de-1dd2d795c19f	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	14123153-d306-4089-b889-95f0e3cfa7cd
password	password	t	t	178a10d4-4dc3-44fb-86de-1dd2d795c19f
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
859449bf-82bf-4c25-ad48-57536cb76e75	/realms/master/account/*
61ff02ee-6245-4ecd-bd34-b47489aa4f71	/realms/master/account/*
785b9dfb-13bb-4747-8629-befad8b73e33	/admin/master/console/*
31abbace-d518-4094-b320-8ae3c264f262	/realms/unnoba/account/*
44556d33-a0db-49b3-aa13-8d408e5eda99	/realms/unnoba/account/*
e6206f81-3d57-4e7f-9e54-64f93d766ca6	/admin/unnoba/console/*
4112d709-d5c5-48e0-994c-631da6c04c9c	https://oauth.pstmn.io/v1/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b962b652-4dc6-4501-bfc7-5a8a31a88343	VERIFY_EMAIL	Verify Email	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	VERIFY_EMAIL	50
b2a54ee2-fadb-4525-946a-9a44d4d3b651	UPDATE_PROFILE	Update Profile	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	UPDATE_PROFILE	40
006f3adc-6b33-435d-99b0-c9913dc4822b	CONFIGURE_TOTP	Configure OTP	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	CONFIGURE_TOTP	10
d2a81ff4-a7c6-4f82-8ebc-7336f73bdf5d	UPDATE_PASSWORD	Update Password	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	UPDATE_PASSWORD	30
ad902d00-0b7e-4b9a-a21e-13d08a32e5fd	TERMS_AND_CONDITIONS	Terms and Conditions	14123153-d306-4089-b889-95f0e3cfa7cd	f	f	TERMS_AND_CONDITIONS	20
599360c0-6fb3-401f-8bd3-45c8ce1d4940	delete_account	Delete Account	14123153-d306-4089-b889-95f0e3cfa7cd	f	f	delete_account	60
335ff04e-f25e-46b0-acc1-60f82ab533c6	update_user_locale	Update User Locale	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	update_user_locale	1000
6fd83f04-36d0-43fc-865f-47454af5a361	webauthn-register	Webauthn Register	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	webauthn-register	70
a89809b4-b909-49c9-9deb-1904d529a00a	webauthn-register-passwordless	Webauthn Register Passwordless	14123153-d306-4089-b889-95f0e3cfa7cd	t	f	webauthn-register-passwordless	80
e76a03e8-2108-4d9f-b2b4-647dff7779ae	VERIFY_EMAIL	Verify Email	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	VERIFY_EMAIL	50
12868f9d-0aba-407f-9529-7bff7ac7de5e	UPDATE_PROFILE	Update Profile	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	UPDATE_PROFILE	40
cd78cb19-0c7c-485b-9c17-11808514a3ba	CONFIGURE_TOTP	Configure OTP	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	CONFIGURE_TOTP	10
ea1432ef-89ed-4599-8874-7da67ed34ba8	UPDATE_PASSWORD	Update Password	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	UPDATE_PASSWORD	30
5325957a-40ad-48d9-8302-c92c5486560a	TERMS_AND_CONDITIONS	Terms and Conditions	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f	f	TERMS_AND_CONDITIONS	20
f408d7bf-5fa6-4f5c-b6f6-a1fa78337adf	delete_account	Delete Account	178a10d4-4dc3-44fb-86de-1dd2d795c19f	f	f	delete_account	60
b46eecb9-06b7-4348-af26-4eab5c8e66d4	update_user_locale	Update User Locale	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	update_user_locale	1000
c70ba900-c257-44f9-bd43-978927cf8a19	webauthn-register	Webauthn Register	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	webauthn-register	70
8caae491-87bc-4f48-8cc7-fc57fc9c23dc	webauthn-register-passwordless	Webauthn Register Passwordless	178a10d4-4dc3-44fb-86de-1dd2d795c19f	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
61ff02ee-6245-4ecd-bd34-b47489aa4f71	fceab210-d5fe-4fa9-a2da-82174f90f401
61ff02ee-6245-4ecd-bd34-b47489aa4f71	a122e34f-e74b-4bdb-8d02-7299ee55118d
44556d33-a0db-49b3-aa13-8d408e5eda99	d99b2ccf-3e97-4eeb-942d-1a5cb530f1c2
44556d33-a0db-49b3-aa13-8d408e5eda99	e2ef76e5-2a73-467d-89fc-9cb3cd18c2fa
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
f66796ff-500b-4da3-9614-682bd259cc8f	\N	b7c89c33-4210-47a3-9c66-93b7c0a16895	f	t	\N	\N	\N	14123153-d306-4089-b889-95f0e3cfa7cd	admin	1778485927864	\N	0
acf71190-f5f2-4d35-a70e-2f7120371215	\N	a23c6f1d-1391-47e9-a132-0800a889ef0b	f	t	\N	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	service-account-pdyc	1778486069507	4112d709-d5c5-48e0-994c-631da6c04c9c	0
6781ef79-5913-40f5-9c1b-beecf146915e	\N	478d96f1-593c-44ba-aa4b-77239b0c09a5	f	t	\N	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	admin	1779582175680	\N	0
77a4ed03-8c3e-4222-b4ec-5de932f3d7a2	mateo2@gmail.com	mateo2@gmail.com	f	t	\N	Mateo	Rossello	178a10d4-4dc3-44fb-86de-1dd2d795c19f	mateo2	1779584266454	\N	0
943516f1-a0f9-401e-a630-b56f6579dddb	mateo@gmail.com	mateo@gmail.com	f	t	\N	Mateo	Rossello	178a10d4-4dc3-44fb-86de-1dd2d795c19f	mateo	1779584277229	\N	0
9b7a2450-11d5-4c10-bf13-da4080c11135	mateouser4@unnoba.edu.ar	mateouser4@unnoba.edu.ar	f	t	\N	\N	\N	178a10d4-4dc3-44fb-86de-1dd2d795c19f	mateouser4	1779590188120	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
f8f6e7b9-27cc-4dfa-87f3-7ec8ce076951	f66796ff-500b-4da3-9614-682bd259cc8f
d9195ddb-003a-4d7a-bc15-352186b0ea88	f66796ff-500b-4da3-9614-682bd259cc8f
bc58b19f-3645-4dfb-95ff-8665f78e4434	f66796ff-500b-4da3-9614-682bd259cc8f
d8503f7c-ce54-4bb0-aefe-8339498a8f79	f66796ff-500b-4da3-9614-682bd259cc8f
6ab5cd01-0270-4d26-af98-190deb4cb32f	f66796ff-500b-4da3-9614-682bd259cc8f
28ad3c8d-edfb-4d6e-9a50-69700e7dd9f0	f66796ff-500b-4da3-9614-682bd259cc8f
b3313a60-e8cd-4f4a-bd76-4e5ec25e6fed	f66796ff-500b-4da3-9614-682bd259cc8f
cd46d86b-ce1e-4ddb-a599-6898a7057353	f66796ff-500b-4da3-9614-682bd259cc8f
97a465f1-8eb6-4feb-9cf8-02bf6ddb81ec	f66796ff-500b-4da3-9614-682bd259cc8f
81b204f7-4d31-40f6-b3e3-1635a562e769	f66796ff-500b-4da3-9614-682bd259cc8f
ec073602-ee53-481f-8ac8-c18f06d6ff96	f66796ff-500b-4da3-9614-682bd259cc8f
73250174-00b6-4bd7-ae59-0fdb8c89a008	f66796ff-500b-4da3-9614-682bd259cc8f
cd291721-514a-4527-80d9-c7b637b756bb	f66796ff-500b-4da3-9614-682bd259cc8f
5d757976-622f-4b21-b8a5-a8b1768fd2dc	f66796ff-500b-4da3-9614-682bd259cc8f
bd8b4f26-f1ef-4955-9eba-8574fd67e879	f66796ff-500b-4da3-9614-682bd259cc8f
acd3ee3e-5a48-4657-8473-6508be3313a0	f66796ff-500b-4da3-9614-682bd259cc8f
71c55d4b-e0f6-44ea-81a0-3322fcaed27c	f66796ff-500b-4da3-9614-682bd259cc8f
7fe7c264-78d0-4d21-b7a2-f1f89e69e011	f66796ff-500b-4da3-9614-682bd259cc8f
5f9c6940-92a0-4495-b2ba-9d998d0d5d5e	f66796ff-500b-4da3-9614-682bd259cc8f
e0f27b45-ca2e-4920-bc94-b53a924304ea	acf71190-f5f2-4d35-a70e-2f7120371215
14db64e0-eb77-4a18-8b89-e50cab510190	acf71190-f5f2-4d35-a70e-2f7120371215
e0f27b45-ca2e-4920-bc94-b53a924304ea	6781ef79-5913-40f5-9c1b-beecf146915e
d9532c4a-10b5-4ca1-9d19-9382c267b11a	6781ef79-5913-40f5-9c1b-beecf146915e
cda6c5a2-15b0-4074-9fc3-1ad652e8de2f	acf71190-f5f2-4d35-a70e-2f7120371215
c6fcdeb6-422e-46ea-94ad-74e3b3f0569e	acf71190-f5f2-4d35-a70e-2f7120371215
e0f27b45-ca2e-4920-bc94-b53a924304ea	77a4ed03-8c3e-4222-b4ec-5de932f3d7a2
d9532c4a-10b5-4ca1-9d19-9382c267b11a	77a4ed03-8c3e-4222-b4ec-5de932f3d7a2
e0f27b45-ca2e-4920-bc94-b53a924304ea	943516f1-a0f9-401e-a630-b56f6579dddb
d9532c4a-10b5-4ca1-9d19-9382c267b11a	943516f1-a0f9-401e-a630-b56f6579dddb
e0f27b45-ca2e-4920-bc94-b53a924304ea	9b7a2450-11d5-4c10-bf13-da4080c11135
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
785b9dfb-13bb-4747-8629-befad8b73e33	+
e6206f81-3d57-4e7f-9e54-64f93d766ca6	+
4112d709-d5c5-48e0-994c-631da6c04c9c	/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict CJDV8z1Y5UfnvO6Sw8fExFvEeaKRaZg34ghwuaeB3lXMq4yTUOIAsHEgMypIlUA

