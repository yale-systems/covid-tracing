--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 12.2

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

DROP TABLE IF EXISTS public.dummy_data;
DROP TABLE IF EXISTS public.contacts;
DROP TABLE IF EXISTS public.managers;
DROP TABLE IF EXISTS public.volunteers;
DROP TABLE IF EXISTS public.patients;
DROP TABLE IF EXISTS public.events;
DROP TABLE IF EXISTS public.public_users;
DROP TABLE IF EXISTS public.public_users_locations;

CREATE USER apiclient WITH PASSWORD 'testing';

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--



ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';

CREATE TYPE public.contact_type_t AS ENUM (
    'MINIMAL',
    'CLOSE'
);

ALTER TYPE public.contact_type_t OWNER TO apiclient;

--
-- Name: age_demographic_t; Type: TYPE; Schema: public; Owner: apiclient
--

CREATE TYPE public.age_demographic_t AS ENUM (
    'MINOR',
    'ADULT',
    'ELDERLY'
);


ALTER TYPE public.age_demographic_t OWNER TO apiclient;

CREATE TYPE public.contact_call_status_t AS ENUM (
    'HAVE_NOT_NOTIFIED_YET',
    'NO_LEFT_VOICEMAIL',
    'NO_DID_NOT_LEAVE_VOICEMAIL',
    'UNABLE_TO_REACH',
    'UNABLE_TO_REACH_BAD_NUMBER',
    'YES_NOTIFIED_CONTACT',
    'YES_NOTIFIED_FAMILY',
    'YES_NOTIFIED_PROXY'
);

ALTER TYPE public.contact_call_status_t OWNER TO apiclient;

CREATE TYPE public.relationship_t AS ENUM ( 
    'PARENT',
    'GRANDPARENT',
    'CHILD',
    'FRIEND',
    'WORK_COLLEAGUE',
    'OTHER',
    'DONT_WANT_TO_SAY'
);

ALTER TYPE public.relationship_t OWNER TO apiclient;

CREATE TYPE public.language_t AS ENUM (
    'ENGLISH',
    'SPANISH',
    'CHINESE',
    'ARABIC'
);

ALTER TYPE public.language_t OWNER TO apiclient;

CREATE TYPE public.symptomatic_t AS ENUM (
    'TESTED_POSITIVE',
    'SYMPTOMATIC_NOT_TESTED',
    'NO_SYMPTOMS',
    'DONT_KNOW'
);

ALTER TYPE public.symptomatic_t OWNER TO apiclient;

CREATE TYPE public.symptom_t AS ENUM (
    'MILD_FATIGUE',
    'LOW_GRADE_FEVER',
    'COUGH',
    'CHILLS',
    'RUNNY_NOSE',
    'NASAL_CONGESTION',
    'LOSS_OF_TASTE_AND_OR_SMELL',
    'HEADACHE',
    'MUSCLE_AND_JOINT_PAIN',
    'TIGHT_FEELING_IN_CHEST',
    'TROUBLE_BREATHING'
);

ALTER TYPE public.symptom_t OWNER TO apiclient;

CREATE TYPE public.self_isolate_t AS ENUM (
    'YES',
    'YES_BUT_NEED_ASSISTANCE',
    'NO'
);

ALTER TYPE public.self_isolate_t OWNER TO apiclient;

CREATE TYPE public.assistance_t AS ENUM (
    'FOOD_SUPPORT',
    'SHELTER',
    'FINANCIAL_SUPPORT',
    'FINDING_PRIMARY_CARE_PHYSICIAN',
    'HEALTHCARE_SUPPORT',
    'HEALTH_INSURANCE',
    'HOME_CARE_SUPPORT',
    'MEDICATIONS_MEDICAL_SUPPLIES',
    'PERSONAL_CARE_HYGEINE_ITEMS',
    'MENTAL_HEALTH_SUPPORT',
    'CLOTHING',
    'OTHER'
);

ALTER TYPE public.assistance_t OWNER TO apiclient;

CREATE TYPE public.case_call_status_t AS ENUM (
    'HAVE_NOT_CALLED_YET',
    'CALLED_DIDNT_LEAVE_VOICEMAIL',
    'CALLED_LEFT_VOICEMAIL',
    'CALL_AGAIN',
    'DOES_NOT_WANT_INTERVIEW',
    'FAMILY_COMPLETED_INTERVIEW',
    'PARTIAL_COMPLETED_INTERVIEW',
    'PATIENT_COMPLETED_INTERVIEW',
    'UNABLE_TO_REACH',
    'UNABLE_TO_REACH_BAD_NUMBER'
);

ALTER TYPE public.case_call_status_t OWNER TO apiclient;

CREATE TYPE public.preexisting_condition_t AS ENUM (
    'CHRONIC_RESPIRATORY_ILLNESS',
    'CARDIOVASCULAR_DISEASE',
    'DIABETES',
    'CANCER',
    'IMMUNOCOMPROMISED',
    'IMMUNOSUPPRESSED',
    'NONE_INDICATED',
    'OTHER'
);

ALTER TYPE public.preexisting_condition_t OWNER TO apiclient;

CREATE TYPE public.gender_t AS ENUM (
    'FEMALE',
    'MALE',
    'OTHER',
    'PREFER_NOT_TO_DISCLOSE'
);

ALTER TYPE public.gender_t OWNER TO apiclient;

CREATE TYPE public.race_t AS ENUM (
    'AMERICAN_INDIAN_OR_ALASKA_NATIVE',
    'ASIAN',
    'BLACK_OR_AFRICAN_AMERICAN',
    'HISPANIC_OR_LATINO',
    'NATIVE_HAWAIIAN_OR_OTHER_PACIFIC_ISLANDER',
    'WHITE',
    'PREFER_NOT_TO_ANSWER'
);

ALTER TYPE public.race_t OWNER TO apiclient;

CREATE TYPE public.suspected_exposure_t AS ENUM (
    'TRAVEL',
    'HEALTHCARE_WORK',
    'WORK',
    'CLOSE_CONTACT_WITH_CONFIRMED_COVID19',
    'OTHER',
    'DONT_KNOW_UNSURE'
);

ALTER TYPE public.suspected_exposure_t OWNER TO apiclient;

CREATE TYPE public.employment_t AS ENUM (
    'EMPLOYED',
    'STUDENT',
    'VOLUNTEER',
    'STAY_AT_HOME_PARENT',
    'UNEMPLOYED',
    'RETIRED',
    'DISABILITY'
);

ALTER TYPE public.employment_t OWNER TO apiclient;

CREATE TYPE public.saw_doctor_t AS ENUM (
    'YES',
    'NO',
    'DO_NOT_HAVE_ONE'
);

ALTER TYPE public.saw_doctor_t OWNER TO apiclient;

CREATE TYPE public.insurance_t AS ENUM (
    'PRIVATE_INSURANCE',
    'MEDICAID_HUSKY',
    'MEDICARE',
    'YALE_HEALTH_PLAN',
    'COMBINATION_OF_HEALTH_INSURANCES',
    'SELF_PAY_CASH',
    'UNINSURED',
    'DONT_KNOW_REFUSE_TO_SHARE'
);

ALTER TYPE public.insurance_t OWNER TO apiclient;

CREATE TYPE public.reason_flagged_t AS ENUM (
    'MEDICAL_EMERGENCY',
    'RISK_OF_SELF_HARM_OR_HARM_TO_OTHERS',
    'DOMESTIC_VIOLENCE'
);

ALTER TYPE public.reason_flagged_t OWNER TO apiclient;
--
-- Name: select_public_users(timestamp without time zone, integer, public.geometry); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.select_public_users(point_time timestamp without time zone, range integer, point_loc public.geometry)
    LANGUAGE sql
    AS $$
select public.public_users_locations.public_user_id
from public.public_users_locations
where ST_DWITHIN(public.st_transform(public_users_locations.geom, 32618), public.st_transform(point_loc, 32618), range)
AND public.public_users_locations.start_time <= point_time
AND public.public_users_locations.end_time >= point_time;
$$;


ALTER PROCEDURE public.select_public_users(point_time timestamp without time zone, range integer, point_loc public.geometry) OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.contacts (
    contact_id integer NOT NULL,
    first_name text,
    last_name text,
    email text,
    phone_number text,
    age_group public.age_demographic_t,
    household boolean,
    contact_type public.contact_type_t,
    times_called integer,
    contact_call_status public.contact_call_status_t,
    contact_date timestamp without time zone,
    update_date timestamp without time zone,
    relationship public.relationship_t,
    language public.language_t,
    symptomatic public.symptomatic_t,
    symptoms public.symptom_t[],
    self_isolate public.self_isolate_t,
    assistances public.assistance_t[],
    notes text,
    isolated_from_patient boolean,
    healthcare_worker boolean,
    patient_id integer NOT NULL
);


ALTER TABLE public.contacts OWNER TO apiclient;

--
-- Name: contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_contact_id_seq OWNER TO apiclient;

--
-- Name: contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.contacts_contact_id_seq OWNED BY public.contacts.contact_id;

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    mac_address text,
    info text,
    worst_case_rssi text,
    flags text,
    first_contact text,
    last_contact text,
    minutes_of_appr_contact integer
);


ALTER TABLE public.tags OWNER TO apiclient;

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.tags_id_seq OWNER TO apiclient;

--
-- Name: dummy_data; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.dummy_data (
    id integer NOT NULL,
    trace_id integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    confirmed boolean,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.dummy_data OWNER TO apiclient;

--
-- Name: dummy_data_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.dummy_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dummy_data_id_seq OWNER TO apiclient;

--
-- Name: dummy_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.dummy_data_id_seq OWNED BY public.dummy_data.id;


--
-- Name: event_contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_contact (
    event_id integer NOT NULL,
    contact_id integer NOT NULL
);


ALTER TABLE public.event_contact OWNER TO apiclient;

--
-- Name: events; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    patient_id integer NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    confirmed boolean,
    notes text,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.events OWNER TO apiclient;

--
-- Name: managers; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.managers (
    manager_id integer NOT NULL,
    username text,
    password text,
    org_name text
);


ALTER TABLE public.managers OWNER TO apiclient;

--
-- Name: managers_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.managers_id_seq
    AS integer
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.managers_id_seq OWNER TO apiclient;

--
-- Name: managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.managers_id_seq OWNED BY public.managers.manager_id;


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 226
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO apiclient;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.event_id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    username text,
    password text,
    first_name text,
    last_name text,
    language public.language_t,
    diagnosis_date timestamp without time zone,
    onset_date timestamp without time zone,
    last_worked_date timestamp without time zone,
    case_call_status public.case_call_status_t,
    travelled boolean,
    saw_doctor public.saw_doctor_t,
    knows_status boolean,
    insurance public.insurance_t,
    times_called integer,
    phone_number text,
    symptomatic boolean,
    symptoms public.symptom_t[],
    gender public.gender_t,
    race public.race_t,
    self_isolate public.self_isolate_t,
    preexisting_conditions public.preexisting_condition_t[],
    employment public.employment_t,
    suspected_exposures public.suspected_exposure_t[],
    home_location public.geometry(Point,4326),
    housing_insecure boolean,
    shelter_name text,
    assistances public.assistance_t[],
    date_of_birth timestamp without time zone,
    referral boolean,
    flagged boolean,
    reasons_flagged public.reason_flagged_t[],
    requested_interview boolean,
    notes text,
    email text,
    manager_id integer NOT NULL,
    volunteer_id integer
);


ALTER TABLE public.patients OWNER TO apiclient;

--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.patients_id_seq
    AS integer
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patients_id_seq OWNER TO apiclient;

--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.patient_id;


--
-- Name: public_users; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.public_users (
    public_user_id integer NOT NULL,
    username text,
    password text,
    name text,
    email text
);


ALTER TABLE public.public_users OWNER TO apiclient;

--
-- Name: public_users_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.public_users_id_seq
    AS integer
    START WITH 98
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_users_id_seq OWNER TO apiclient;

--
-- Name: public_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.public_users_id_seq OWNED BY public.public_users.public_user_id;


--
-- Name: public_users_locations; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.public_users_locations (
    id integer NOT NULL,
    public_user_id integer NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    confirmed boolean,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.public_users_locations OWNER TO apiclient;

--
-- Name: public_users_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.public_users_locations_id_seq
    AS integer
    START WITH 4651
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_users_locations_id_seq OWNER TO apiclient;

--
-- Name: public_users_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.public_users_locations_id_seq OWNED BY public.public_users_locations.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: apiclient
--

CREATE TABLE public.volunteers (
    volunteer_id integer NOT NULL,
    username text,
    password text,
    first_name text,
    last_name text,
    languages public.language_t[],
    interviewer boolean,
    total_capacity integer,
    remaining_capacity integer,
    current_cases integer,
    completed_cases integer,
    email text,
    manager_id integer NOT NULL
);


ALTER TABLE public.volunteers OWNER TO apiclient;

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: apiclient
--

CREATE SEQUENCE public.volunteers_id_seq
    AS integer
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO apiclient;

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: apiclient
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.volunteer_id;


--
-- Name: contacts contact_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.contacts_contact_id_seq'::regclass);


--
-- Name: dummy_data id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.dummy_data ALTER COLUMN id SET DEFAULT nextval('public.dummy_data_id_seq'::regclass);


--
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: managers manager_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.managers ALTER COLUMN manager_id SET DEFAULT nextval('public.managers_id_seq'::regclass);


--
-- Name: patients patient_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.patients ALTER COLUMN patient_id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: public_users public_user_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.public_users ALTER COLUMN public_user_id SET DEFAULT nextval('public.public_users_id_seq'::regclass);


--
-- Name: public_users_locations id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.public_users_locations ALTER COLUMN id SET DEFAULT nextval('public.public_users_locations_id_seq'::regclass);


--
-- Name: volunteers volunteer_id; Type: DEFAULT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN volunteer_id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.contacts (contact_id, first_name, last_name, email, phone_number, age_group, household, healthcare_worker, patient_id, contact_type, times_called, contact_call_status, contact_date, update_date, relationship, language, symptomatic, self_isolate, notes, isolated_from_patient) FROM stdin;
1	Chantell	Heit	chantellh@gmail.com	111-111-111	MINOR	t	t	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
2	Francesca	Ashman	francescaa@gmail.com	111-111-112	ELDERLY	t	f	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
3	Elfreda	Rizo	er@gmail.com	111-111-113	ADULT	t	t	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
4	Antonina	Jessup	aj@gmail.com	111-111-114	ADULT	f	t	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
5	Verlene	Vivas	av@gmail.com	111-111-115	ELDERLY	t	t	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
6	Bud	Lanctot	bl@gmail.com	111-111-116	ADULT	f	f	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
7	Angelia	Rubino	ar@gmail.com	111-111-117	ADULT	t	t	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
8	Gina	Van	gv@gmail.com	111-111-118	MINOR	t	f	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
9	Danial	Behrens	db@gmail.com	111-111-119	ADULT	t	f	1	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
10	Carlotta	Macken	cm@gmail.com	111-111-1110	MINOR	f	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
11	Doretha	Frost	df@gmail.com	111-111-1111	ADULT	f	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
12	Cedric	Burgin	cb@gmail.com	111-111-1112	MINOR	t	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
13	Lani	Serafino	ls@gmail.com	111-111-1113	ADULT	f	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
14	Katheleen	Homgren	kh@gmail.com	111-111-1114	MINOR	t	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
15	Quinton	Velasquez	qv@gmail.com	111-111-1115	ELDERLY	f	f	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
16	Concetta	Overton	co@gmail.com	111-111-1116	MINOR	t	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
17	Gary	Chrisman	gc@gmail.com	111-111-1117	ELDERLY	t	f	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
18	Farrah	Zeman	fz@gmail.com	111-111-1118	ELDERLY	t	t	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
19	Jonnie	Litt	jl@gmail.com	111-111-1119	ELDERLY	f	f	2	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
20	Kaley	Matheson	km@gmail.com	111-111-1120	ELDERLY	t	t	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
21	Lu	Stubblefield	lus@gmail.com	111-111-1121	ADULT	t	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
22	Arnetta	Hoppe	ah@gmail.com	111-111-1122	ELDERLY	f	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
23	Trisha	Swearengin	ts@gmail.com	111-111-1123	ELDERLY	f	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
24	Tama	Claycomb	tc@gmail.com	111-111-1124	ELDERLY	f	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
25	Agripina	Tenny	at@gmail.com	111-111-1125	ELDERLY	t	t	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
26	Raleigh	Sancho	rs@gmail.com	111-111-1126	ADULT	t	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
27	Roxane	Gwinn	rg@gmail.com	111-111-1127	ELDERLY	t	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
28	Nannette	Harley	nh@gmail.com	111-111-1128	ADULT	f	t	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
29	Rodolfo	Tocco	rt@gmail.com	111-111-1129	ELDERLY	f	f	3	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
30	Avril	Derringer	ad@gmail.com	111-111-1130	MINOR	t	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
31	Ellie	Newbold	en@gmail.com	111-111-1131	ADULT	t	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
32	Rip	Joel	tlou@gmail.com	111-111-1132	ADULT	t	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
33	Ludivina	Duwe	ld@gmail.com	111-111-1133	ADULT	f	f	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
34	Louann	Neale	lon@gmail.com	111-111-1134	MINOR	f	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
35	Tobi	Stansell	tost@gmail.com	111-111-1135	ADULT	f	f	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
36	Deena	Bartsch	deb@gmail.com	111-111-1136	ADULT	t	f	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
37	Bradley	Mortimore	bm@gmail.com	111-111-1137	MINOR	t	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
38	Charlene	Albertini	ca@gmail.com	111-111-1138	ADULT	t	f	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
39	Clay	Wisniewski	cw@gmail.com	111-111-1139	ADULT	f	t	4	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
40	Margarete	Tung	mt@gmail.com	111-111-1140	ADULT	t	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
41	Gary	Philbrick	gp@gmail.com	111-111-1141	MINOR	f	t	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
42	Winifred	Heister	wh@gmail.com	111-111-1142	ELDERLY	t	t	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
43	Nichole	Upton	nu@gmail.com	111-111-1143	ADULT	f	t	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
44	Stella	Pickrell	sp@gmail.com	111-111-1144	ELDERLY	f	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
45	Clemmie	Franz	cf@gmail.com	111-111-1145	ELDERLY	f	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
46	Chelsea	Risch	cr@gmail.com	111-111-1146	MINOR	t	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
47	Libby	Hansen	lh@gmail.com	111-111-1147	MINOR	t	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
48	Wynona	Khan	wk@gmail.com	111-111-1148	ADULT	t	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
49	Dina	Pugsley	dip@gmail.com	111-111-1149	ADULT	f	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
50	Candice	Wagers	cawa@gmail.com	111-111-1150	ADULT	t	f	5	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
51	Vashti	Weisel	vw@gmail.com	111-111-1151	ADULT	t	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
52	Ayesha	Noriega	an@gmail.com	111-111-1152	ELDERLY	t	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
53	Magdalen	Parada	mp@gmail.com	111-111-1153	ELDERLY	f	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
54	Rosemarie	Arnold	ra@gmail.com	111-111-1154	ADULT	t	f	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
55	Shelton	Odoms	so@gmail.com	111-111-1155	ELDERLY	f	f	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
56	Etta	Domingues	etd@gmail.com	111-111-1156	ADULT	f	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
57	Gladis	Moises	gm@gmail.com	111-111-1157	MINOR	t	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
58	Karl	Bank	kb@gmail.com	111-111-1158	ELDERLY	f	f	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
59	Lori	Kennedy	lk@gmail.com	111-111-1159	ADULT	f	t	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
60	Jane	Sweitzer	js@gmail.com	111-111-1160	ELDERLY	f	f	6	MINIMAL	0	HAVE_NOT_NOTIFIED_YET	2020-02-08 01:42:55	2020-02-08 01:42:55	FRIEND	ENGLISH	NO_SYMPTOMS	NO	not called yet	t
\.


--
-- Data for Name: event_contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_contact (event_id, contact_id) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.events (event_id, patient_id, start_time, end_time, confirmed, geom, notes) FROM stdin;
1	1	2008-02-08 01:42:55	2008-02-08 01:44:55	f	0101000020E6100000F91A82E3323A52C056F146E691D54440	met with friend
2	1	2008-02-08 01:46:59	2008-02-08 01:48:59	t	0101000020E6100000223D450E113952C0465F419AB1D24440	met with friend
3	1	2008-02-08 01:47:57	2008-02-08 01:49:57	f	0101000020E6100000501F813FFC3852C0ECC039234AD14440	met with friend
4	1	2008-02-08 01:52:01	2008-02-08 01:54:01	f	0101000020E6100000113CBEBD6B3652C07FF6234564CE4440	met with friend
5	1	2008-02-08 01:52:01	2008-02-08 01:54:01	t	0101000020E6100000113CBEBD6B3652C07FF6234564CE4440	met with friend
6	1	2008-02-08 01:52:59	2008-02-08 01:54:59	t	0101000020E6100000EB7420EBA93552C01B9E5E29CBCE4440	met with friend
7	1	2008-02-08 01:57:03	2008-02-08 01:59:03	t	0101000020E6100000857D3B89083552C0922232ACE2CF4440	met with friend
8	1	2008-02-08 01:58:01	2008-02-08 02:00:01	f	0101000020E610000049FAB48AFE3452C003CFBD874BD04440	met with friend
9	1	2008-02-08 02:23:10	2008-02-08 02:25:10	t	0101000020E6100000A18A1BB7983952C032772D211FD64440	met with friend
10	1	2008-02-08 02:47:49	2008-02-08 02:49:49	t	0101000020E61000006CED7DAA0A3F52C06458C51B99D54440	met with friend
11	1	2008-02-08 02:48:19	2008-02-08 02:50:19	t	0101000020E6100000EC353D28283F52C06458C51B99D54440	met with friend
12	1	2008-02-08 02:52:51	2008-02-08 02:54:51	f	0101000020E61000007DB94F8E024052C00F10CCD1E3D54440	met with friend
13	1	2008-02-08 02:59:28	2008-02-08 03:01:28	t	0101000020E61000004C2025766D1B52C017F19D98F5144540	met with friend
14	1	2008-02-08 02:59:28	2008-02-08 03:01:28	t	0101000020E61000004C2025766D1B52C017F19D98F5144540	met with friend
15	1	2008-02-08 04:00:57	2008-02-08 04:02:57	f	0101000020E610000039D73043E3E355C065AA6054522B3D40	met with friend
16	1	2008-02-08 04:00:57	2008-02-08 04:02:57	t	0101000020E610000039D73043E3E355C065AA6054522B3D40	met with friend
17	1	2008-02-08 10:58:03	2008-02-08 11:00:03	f	0101000020E61000000B12DBDD034052C0EB39E97DE3D54440	met with friend
18	1	2008-02-08 10:58:03	2008-02-08 11:00:03	t	0101000020E61000000B12DBDD034052C0EB39E97DE3D54440	met with friend
19	1	2008-02-08 10:58:16	2008-02-08 11:00:16	f	0101000020E61000000B12DBDD034052C0EB39E97DE3D54440	met with friend
20	1	2008-02-08 11:03:05	2008-02-08 11:05:05	t	0101000020E61000006B4E5E64024052C0E4310395F1D54440	met with friend
21	1	2008-02-08 11:03:18	2008-02-08 11:05:18	t	0101000020E6100000195C7347FF3F52C02BDEC83CF2D54440	met with friend
22	1	2008-02-08 11:08:07	2008-02-08 11:10:07	f	0101000020E6100000D353E410713F52C0516B9A779CD44440	met with friend
23	1	2008-02-08 11:08:19	2008-02-08 11:10:19	t	0101000020E6100000C1E8F2E6703F52C0EEB60BCD75D44440	met with friend
24	1	2008-02-08 11:13:09	2008-02-08 11:15:09	f	0101000020E61000005458A9A0A23C52C0B5E0455F41D44440	met with friend
25	1	2008-02-08 11:13:21	2008-02-08 11:15:21	f	0101000020E6100000ADFBC742743C52C0B5E0455F41D44440	met with friend
26	1	2008-02-08 11:18:10	2008-02-08 11:20:10	t	0101000020E6100000A280ED60C43852C04339D1AE42D44440	met with friend
27	1	2008-02-08 11:18:22	2008-02-08 11:20:22	t	0101000020E61000008678245E9E3852C0670FB40243D44440	met with friend
28	1	2008-02-08 11:23:12	2008-02-08 11:25:12	f	0101000020E6100000576133C0053752C08351499D80D44440	met with friend
29	1	2008-02-08 11:23:24	2008-02-08 11:25:24	t	0101000020E6100000E5B9BE0F073752C0DFA63FFB91D44440	met with friend
30	1	2008-02-08 11:28:13	2008-02-08 11:30:13	f	0101000020E6100000585C1C959B3652C00803CFBD87D54440	met with friend
31	1	2008-02-08 11:28:26	2008-02-08 11:30:26	f	0101000020E6100000585C1C959B3652C00803CFBD87D54440	met with friend
32	1	2008-02-08 11:33:15	2008-02-08 11:35:15	t	0101000020E6100000585C1C959B3652C00803CFBD87D54440	met with friend
33	1	2008-02-08 11:33:27	2008-02-08 11:35:27	f	0101000020E6100000585C1C959B3652C00803CFBD87D54440	met with friend
34	1	2008-02-08 11:38:17	2008-02-08 11:40:17	t	0101000020E6100000238AC91B603652C0257A19C572D54440	met with friend
35	1	2008-02-08 11:38:29	2008-02-08 11:40:29	t	0101000020E6100000238AC91B603652C0257A19C572D54440	met with friend
36	1	2008-02-08 11:43:19	2008-02-08 11:45:19	t	0101000020E6100000238AC91B603652C0257A19C572D54440	met with friend
37	1	2008-02-08 11:43:31	2008-02-08 11:45:31	f	0101000020E6100000238AC91B603652C0257A19C572D54440	met with friend
38	1	2008-02-08 11:48:20	2008-02-08 11:50:20	f	0101000020E6100000E302D0285D3652C002BC051214D54440	met with friend
39	1	2008-02-08 11:52:10	2008-02-08 11:54:10	f	0101000020E61000004A641F64593652C04434BA83D8D34440	met with friend
40	1	2008-02-08 11:53:22	2008-02-08 11:55:22	t	0101000020E61000005CCF108E593652C0F584251E50D44440	met with friend
41	1	2008-02-08 11:57:12	2008-02-08 11:59:12	f	0101000020E610000011B056ED9A3652C0BBF2599E07D54440	met with friend
42	1	2008-02-08 11:58:24	2008-02-08 12:00:24	t	0101000020E6100000BFA085048C3652C0DEAB5626FCD44440	met with friend
43	1	2008-02-08 12:03:26	2008-02-08 12:05:26	t	0101000020E6100000AD527AA6973652C0B9C2BB5CC4D14440	met with friend
44	2	2008-02-02 18:54:28	2008-02-02 18:56:28	t	0101000020E61000003BCD02ED0E3552C0DDD26A48DCD14440	met with friend
45	2	2008-02-02 18:55:52	2008-02-02 18:57:52	t	0101000020E610000009E753C72A3552C04F7ADFF8DAD14440	met with friend
46	2	2008-02-02 19:05:52	2008-02-02 19:07:52	t	0101000020E61000004FB51666A13552C02D26361FD7D04440	met with friend
47	2	2008-02-02 19:15:52	2008-02-02 19:17:52	f	0101000020E6100000238AC91B603452C01B69A9BC1DCF4440	met with friend
48	2	2008-02-02 19:20:21	2008-02-02 19:22:21	f	0101000020E61000001F6E8786C53252C030D80DDB16CF4440	met with friend
49	2	2008-02-02 19:30:21	2008-02-02 19:32:21	f	0101000020E6100000E38E37F92D3452C0D3C1FA3F87CF4440	met with friend
50	2	2008-02-02 19:31:48	2008-02-02 19:33:48	f	0101000020E6100000E06DDE38293452C07DD0B359F5CF4440	met with friend
51	2	2008-02-02 19:41:48	2008-02-02 19:43:48	f	0101000020E610000092EEE714E43152C049111956F1D04440	met with friend
52	2	2008-02-02 19:55:27	2008-02-02 19:57:27	f	0101000020E6100000055262D7F63052C06C26DF6C73D54440	met with friend
53	2	2008-02-02 20:03:57	2008-02-02 20:05:57	t	0101000020E61000009A43520B253152C0A64412BD8CD84440	met with friend
54	2	2008-02-02 20:13:57	2008-02-02 20:15:57	f	0101000020E610000011070951BE3252C00669C6A2E9DA4440	met with friend
55	2	2008-02-02 20:23:57	2008-02-02 20:25:57	t	0101000020E610000038C478CDAB3452C01BD82AC1E2DA4440	met with friend
56	2	2008-02-02 20:33:57	2008-02-02 20:35:57	f	0101000020E6100000513239B5333652C08733BF9A03DA4440	met with friend
57	2	2008-02-02 20:43:57	2008-02-02 20:45:57	t	0101000020E6100000645E471CB23952C0780B24287EDA4440	met with friend
58	2	2008-02-02 20:53:57	2008-02-02 20:55:57	f	0101000020E61000004726E0D7483A52C0EEB1F4A10BDC4440	met with friend
59	2	2008-02-02 21:00:20	2008-02-02 21:02:20	t	0101000020E6100000D8C1C1DEC43A52C00282397AFCDC4440	met with friend
60	2	2008-02-02 21:00:20	2008-02-02 21:02:20	f	0101000020E6100000D8C1C1DEC43A52C00282397AFCDC4440	met with friend
61	2	2008-02-02 21:10:20	2008-02-02 21:12:20	f	0101000020E6100000C5CF7F0F5E3B52C01BD82AC1E2DA4440	met with friend
62	2	2008-02-02 21:20:08	2008-02-02 21:22:08	t	0101000020E6100000AD8C463EAF3A52C01D9430D3F6D94440	met with friend
63	2	2008-02-02 21:30:08	2008-02-02 21:32:08	f	0101000020E61000006FBC3B32563B52C0E544BB0A29DD4440	met with friend
64	2	2008-02-02 21:42:30	2008-02-02 21:44:30	f	0101000020E6100000A35EF0694E3252C027BD6F7CEDDF4440	met with friend
65	2	2008-02-02 21:50:08	2008-02-02 21:52:08	f	0101000020E610000079D2C265153052C0855FEAE74DDF4440	met with friend
66	2	2008-02-02 21:58:58	2008-02-02 22:00:58	t	0101000020E6100000570F98874C2D52C0D1CB28965BDC4440	met with friend
67	2	2008-02-02 22:08:58	2008-02-02 22:10:58	t	0101000020E6100000E836E15E992D52C026581CCEFCD84440	met with friend
68	2	2008-02-02 22:15:38	2008-02-02 22:17:38	f	0101000020E61000004E637B2DE82D52C0C3F0113125D84440	met with friend
69	2	2008-02-02 22:25:38	2008-02-02 22:27:38	f	0101000020E61000006E8C9DF0123052C0D3DEE00B93D74440	met with friend
70	2	2008-02-02 22:34:03	2008-02-02 22:36:03	t	0101000020E6100000BFDA519CA33252C044FAEDEBC0D74440	met with friend
71	2	2008-02-02 22:48:20	2008-02-02 22:50:20	f	0101000020E610000095DA8B683B3252C032B1F9B836D64440	met with friend
72	2	2008-02-02 22:54:03	2008-02-02 22:56:03	t	0101000020E6100000539CA38E8E3152C0555227A089D64440	met with friend
73	2	2008-02-02 23:03:06	2008-02-02 23:05:06	t	0101000020E6100000F1F5B52E353252C0B9196EC0E7D54440	met with friend
74	2	2008-02-02 23:13:07	2008-02-02 23:15:07	t	0101000020E61000006828EE78933152C0FC523F6F2AD44440	met with friend
75	2	2008-02-02 23:15:23	2008-02-02 23:17:23	f	0101000020E61000009EF529C7643152C0CB4A9352D0D34440	met with friend
76	3	2008-02-04 04:59:10	2008-02-04 05:01:10	f	0101000020E6100000D1EE9062801E52C08E23D6E253F24440	met with friend
77	3	2008-02-04 05:04:12	2008-02-04 05:06:12	t	0101000020E61000009CADBCE47F1E52C08E23D6E253F24440	met with friend
78	3	2008-02-04 05:09:14	2008-02-04 05:11:14	t	0101000020E61000000D5531957E1E52C03108AC1C5AF24440	met with friend
79	3	2008-02-04 05:14:16	2008-02-04 05:16:16	f	0101000020E6100000439605137F1E52C05C035B2558F24440	met with friend
80	3	2008-02-04 05:19:18	2008-02-04 05:21:18	f	0101000020E6100000FCE93F6B7E1E52C0C785032159F24440	met with friend
81	3	2008-02-04 05:24:20	2008-02-04 05:26:20	f	0101000020E610000078D7D9907F1E52C04052448655F24440	met with friend
82	3	2008-02-04 05:29:22	2008-02-04 05:31:22	f	0101000020E61000002A064834811E52C05C035B2558F24440	met with friend
83	3	2008-02-04 05:34:24	2008-02-04 05:36:24	f	0101000020E6100000A6F3E159821E52C0382D78D157F24440	met with friend
84	3	2008-02-04 05:39:26	2008-02-04 05:41:26	f	0101000020E610000071B20DDC811E52C03108AC1C5AF24440	met with friend
85	3	2008-02-04 05:44:28	2008-02-04 05:46:28	t	0101000020E610000023E17B7F831E52C04052448655F24440	met with friend
86	3	2008-02-04 05:49:29	2008-02-04 05:51:29	f	0101000020E610000011768A55831E52C0C060376C5BF24440	met with friend
87	3	2008-02-04 05:54:31	2008-02-04 05:56:31	t	0101000020E6100000582250FD831E52C0CEAACFD556F24440	met with friend
88	3	2008-02-04 05:59:33	2008-02-04 06:01:33	t	0101000020E6100000FF0A992B831E52C0382D78D157F24440	met with friend
89	3	2008-02-04 06:04:35	2008-02-04 06:06:35	f	0101000020E610000046B75ED3831E52C0F180B22957F24440	met with friend
90	3	2008-02-04 06:09:37	2008-02-04 06:11:37	t	0101000020E61000009FCE15A5841E52C05C035B2558F24440	met with friend
91	3	2008-02-04 06:14:39	2008-02-04 06:16:39	t	0101000020E610000011768A55831E52C0CEAACFD556F24440	met with friend
92	3	2008-02-04 06:19:41	2008-02-04 06:21:41	t	0101000020E610000046B75ED3831E52C01557957D57F24440	met with friend
93	3	2008-02-04 06:24:43	2008-02-04 06:26:43	f	0101000020E610000011768A55831E52C0CEAACFD556F24440	met with friend
94	3	2008-02-04 06:29:45	2008-02-04 06:31:45	t	0101000020E610000046B75ED3831E52C0382D78D157F24440	met with friend
95	3	2008-02-04 06:34:47	2008-02-04 06:36:47	t	0101000020E610000023E17B7F831E52C05C035B2558F24440	met with friend
96	3	2008-02-04 06:39:49	2008-02-04 06:41:49	f	0101000020E6100000DC34B6D7821E52C05C035B2558F24440	met with friend
97	3	2008-02-04 06:44:51	2008-02-04 06:46:51	f	0101000020E6100000CAC9C4AD821E52C0382D78D157F24440	met with friend
98	3	2008-02-04 06:49:53	2008-02-04 06:51:53	f	0101000020E6100000DC34B6D7821E52C055DE8E705AF24440	met with friend
99	3	2008-02-04 06:54:55	2008-02-04 06:56:55	t	0101000020E6100000ED9FA701831E52C0C060376C5BF24440	met with friend
100	3	2008-02-04 06:59:57	2008-02-04 07:01:57	t	0101000020E6100000A6F3E159821E52C00E32C9C859F24440	met with friend
101	3	2008-02-04 06:59:57	2008-02-04 07:01:57	f	0101000020E6100000A6F3E159821E52C00E32C9C859F24440	met with friend
102	3	2008-02-04 07:04:58	2008-02-04 07:06:58	f	0101000020E6100000DC34B6D7821E52C0632827DA55F24440	met with friend
103	3	2008-02-04 07:10:00	2008-02-04 07:12:00	f	0101000020E610000071B20DDC811E52C08E23D6E253F24440	met with friend
104	3	2008-02-04 07:15:02	2008-02-04 07:17:02	t	0101000020E6100000B85ED383821E52C0C785032159F24440	met with friend
105	3	2008-02-04 07:20:04	2008-02-04 07:22:04	f	0101000020E6100000831DFF05821E52C0D5CF9B8A54F24440	met with friend
106	3	2008-02-04 07:25:06	2008-02-04 07:27:06	t	0101000020E610000071B20DDC811E52C0D5CF9B8A54F24440	met with friend
107	3	2008-02-04 07:30:08	2008-02-04 07:32:08	t	0101000020E61000003C71395E811E52C06A4DF38E53F24440	met with friend
108	3	2008-02-04 07:35:10	2008-02-04 07:37:10	f	0101000020E6100000831DFF05821E52C0F180B22957F24440	met with friend
109	3	2008-02-04 07:40:12	2008-02-04 07:42:12	f	0101000020E61000004DDC2A88811E52C087FE092E56F24440	met with friend
110	3	2008-02-04 07:45:14	2008-02-04 07:47:14	t	0101000020E61000003C71395E811E52C007F0164850F24440	met with friend
111	3	2008-02-04 07:55:18	2008-02-04 07:57:18	f	0101000020E6100000D1EE9062801E52C0E31934F44FF24440	met with friend
112	3	2008-02-04 08:00:20	2008-02-04 08:02:20	f	0101000020E6100000BF839F38801E52C08E23D6E253F24440	met with friend
113	4	2008-02-06 14:36:04	2008-02-06 14:38:04	t	0101000020E61000002A75C938461A52C0EDD808C4EB004540	met with friend
114	4	2008-02-06 14:41:06	2008-02-06 14:43:06	t	0101000020E61000007FC2D9AD651A52C043E7357689004540	met with friend
115	4	2008-02-06 14:48:05	2008-02-06 14:50:05	f	0101000020E6100000912DCBD7651A52C026361FD786004540	met with friend
116	4	2008-02-06 14:58:18	2008-02-06 15:00:18	f	0101000020E6100000912DCBD7651A52C0D8648D7A88004540	met with friend
117	4	2008-02-06 15:07:11	2008-02-06 15:09:11	t	0101000020E61000001A5245F12A1B52C0AD174339D1004540	met with friend
118	4	2008-02-06 15:08:21	2008-02-06 15:10:21	f	0101000020E6100000C200C287121B52C098A8DE1AD8004540	met with friend
119	4	2008-02-06 15:13:22	2008-02-06 15:15:22	f	0101000020E6100000CA1B60E63B1C52C069A9BC1DE1024540	met with friend
120	4	2008-02-06 15:17:14	2008-02-06 15:19:14	t	0101000020E610000013842BA0501D52C0E10B93A982034540	met with friend
121	4	2008-02-06 15:18:23	2008-02-06 15:20:23	t	0101000020E610000013842BA0501D52C0E10B93A982034540	met with friend
122	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
123	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
124	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
125	4	2008-02-06 15:25:22	2008-02-06 15:27:22	f	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
126	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
127	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
128	4	2008-02-06 15:25:22	2008-02-06 15:27:22	f	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
129	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
130	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
131	4	2008-02-06 15:25:22	2008-02-06 15:27:22	f	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
132	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
133	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
134	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
135	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
136	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
137	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
138	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
139	4	2008-02-06 15:25:22	2008-02-06 15:27:22	f	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
140	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
141	4	2008-02-06 15:25:22	2008-02-06 15:27:22	f	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
142	4	2008-02-06 15:25:22	2008-02-06 15:27:22	t	0101000020E610000025EF1CCA501D52C005E275FD82034540	met with friend
143	4	2008-02-08 11:20:51	2008-02-08 11:22:51	f	0101000020E6100000A80183A44F1D52C0E8305F5E80034540	met with friend
144	4	2008-02-08 11:25:43	2008-02-08 11:27:43	f	0101000020E6100000A80183A44F1D52C0E8305F5E80034540	met with friend
145	4	2008-02-08 11:25:53	2008-02-08 11:27:53	f	0101000020E6100000A80183A44F1D52C0E8305F5E80034540	met with friend
146	4	2008-02-08 11:30:54	2008-02-08 11:32:54	t	0101000020E6100000A80183A44F1D52C0E8305F5E80034540	met with friend
147	4	2008-02-08 11:35:47	2008-02-08 11:37:47	t	0101000020E6100000C1AE264F591D52C04C8E3BA583034540	met with friend
148	4	2008-02-08 11:35:56	2008-02-08 11:37:56	t	0101000020E61000001AC6DD205A1D52C06F641EF983034540	met with friend
149	4	2008-02-08 11:40:58	2008-02-08 11:42:58	f	0101000020E6100000F0AD484C501D52C0BD35B05582034540	met with friend
150	4	2008-02-08 11:45:50	2008-02-08 11:47:50	f	0101000020E6100000F0AD484C501D52C0BD35B05582034540	met with friend
151	5	2008-02-06 11:57:21	2008-02-06 11:59:21	f	0101000020E610000024BA675DA33352C04CE0D6DD3CDB4440	met with friend
152	5	2008-02-06 12:00:10	2008-02-06 12:02:10	f	0101000020E610000062C43E01143352C08D7F9F71E1DA4440	met with friend
153	5	2008-02-06 12:02:23	2008-02-06 12:04:23	f	0101000020E6100000DCA337DC473252C0DC85E63A8DDA4440	met with friend
154	5	2008-02-06 12:05:12	2008-02-06 12:07:12	f	0101000020E6100000079FE6E4453252C04772F90FE9D94440	met with friend
155	5	2008-02-06 12:10:13	2008-02-06 12:12:13	f	0101000020E61000006099B7EA3A3252C02FE23B31EBD74440	met with friend
156	5	2008-02-06 12:12:26	2008-02-06 12:14:26	f	0101000020E61000002E5C5661333252C00664AF777FD64440	met with friend
157	5	2008-02-06 12:15:15	2008-02-06 12:17:15	f	0101000020E610000020F5D72B2C3252C074D2FBC6D7D44440	met with friend
158	5	2008-02-06 12:17:28	2008-02-06 12:19:28	t	0101000020E6100000271AA4E0293252C019213CDA38D44440	met with friend
159	5	2008-02-06 12:20:17	2008-02-06 12:22:17	t	0101000020E610000057276728EE3252C00B7BDAE1AFD34440	met with friend
160	5	2008-02-06 12:22:30	2008-02-06 12:24:30	t	0101000020E610000059E36C3A023452C0F0E192E34ED34440	met with friend
161	5	2008-02-06 12:25:18	2008-02-06 12:27:18	t	0101000020E6100000C4651536033452C078F35487DCD24440	met with friend
162	5	2008-02-06 12:27:31	2008-02-06 12:29:31	t	0101000020E6100000A0FEB3E6C73352C0E3AAB2EF8AD24440	met with friend
163	5	2008-02-06 12:30:20	2008-02-06 12:32:20	f	0101000020E6100000F9FD9B17273452C0DCBA9BA73AD24440	met with friend
164	5	2008-02-06 12:32:33	2008-02-06 12:34:33	f	0101000020E6100000AE307DAF213452C001309E4143D14440	met with friend
165	5	2008-02-06 12:35:21	2008-02-06 12:37:21	f	0101000020E6100000F5F928232E3452C08481E7DEC3CF4440	met with friend
166	5	2008-02-06 12:37:35	2008-02-06 12:39:35	t	0101000020E61000006AC2F693313452C0B7627FD93DCF4440	met with friend
167	5	2008-02-06 12:40:23	2008-02-06 12:42:23	f	0101000020E6100000A72897C62F3452C01422E010AACE4440	met with friend
168	5	2008-02-06 12:42:36	2008-02-06 12:44:36	f	0101000020E6100000513239B5333452C09DA223B9FCCD4440	met with friend
169	5	2008-02-06 12:45:25	2008-02-06 12:47:25	t	0101000020E61000005536ACA92C3452C0AA656B7D91CE4440	met with friend
170	6	2008-02-07 20:42:14	2008-02-07 20:44:14	t	0101000020E6100000700ED76A0F3952C0596E693524D84440	met with friend
171	6	2008-02-07 20:47:16	2008-02-07 20:49:16	f	0101000020E6100000F4035779023952C0E96514CB2DDB4440	met with friend
172	6	2008-02-07 20:52:18	2008-02-07 20:54:18	f	0101000020E6100000AA83BC1E4C3852C0105D50DF32DD4440	met with friend
173	6	2008-02-07 20:52:18	2008-02-07 20:54:18	t	0101000020E6100000AA83BC1E4C3852C0105D50DF32DD4440	met with friend
174	6	2008-02-07 20:57:19	2008-02-07 20:59:19	t	0101000020E61000000D772E8CF43252C09E465A2A6FDD4440	met with friend
175	6	2008-02-07 21:02:21	2008-02-07 21:04:21	t	0101000020E61000001CD47E6B273252C04148163081DD4440	met with friend
176	6	2008-02-07 21:07:23	2008-02-07 21:09:23	t	0101000020E6100000FC75A73B4F3452C0BADA8AFD65DD4440	met with friend
177	6	2008-02-07 21:12:24	2008-02-07 21:14:24	t	0101000020E61000006138D730433552C0E353008C67DE4440	met with friend
178	6	2008-02-07 21:17:26	2008-02-07 21:19:26	f	0101000020E61000001AA9F7544E3552C0C45F9335EADF4440	met with friend
179	6	2008-02-07 21:22:27	2008-02-07 21:24:27	t	0101000020E6100000C1745AB7413552C097E7C1DD59DD4440	met with friend
180	6	2008-02-07 21:27:29	2008-02-07 21:29:29	t	0101000020E6100000A3293BFDA03452C0D09B8A5418DD4440	met with friend
181	6	2008-02-07 21:32:31	2008-02-07 21:34:31	f	0101000020E6100000E7E95C514A3452C0D027F224E9DC4440	met with friend
182	6	2008-02-07 21:37:32	2008-02-07 21:39:32	t	0101000020E610000069CC24EA053552C0CF66D5E76ADD4440	met with friend
183	6	2008-02-07 21:42:34	2008-02-07 21:44:34	t	0101000020E6100000B0B2B6291E3552C0F19D98F562DA4440	met with friend
184	6	2008-02-07 21:47:36	2008-02-07 21:49:36	f	0101000020E61000009E0DF967063552C0622D3E05C0D64440	met with friend
185	6	2008-02-07 21:52:37	2008-02-07 21:54:37	f	0101000020E6100000A2116C5CFF3452C0CA54C1A8A4D44440	met with friend
186	6	2008-02-07 21:57:39	2008-02-07 21:59:39	f	0101000020E610000022E692AAED3452C06991ED7C3FD34440	met with friend
187	6	2008-02-07 22:02:41	2008-02-07 22:04:41	t	0101000020E6100000CE02ED0E293252C0618E1EBFB7D34440	met with friend
188	6	2008-02-07 22:07:42	2008-02-07 22:09:42	f	0101000020E6100000FD36C478CD2F52C0FD6A0E10CCD34440	met with friend
189	6	2008-02-07 22:12:44	2008-02-07 22:14:44	f	0101000020E610000001DF6DDE382F52C0695721E527D34440	met with friend
190	6	2008-02-07 22:17:46	2008-02-07 22:19:46	t	0101000020E6100000D6E8D500A52F52C076543541D4D34440	met with friend
191	6	2008-02-07 22:22:47	2008-02-07 22:24:47	t	0101000020E6100000D75240DAFF3052C0F3CD3637A6D54440	met with friend
192	6	2008-02-07 22:27:48	2008-02-07 22:29:48	f	0101000020E6100000D3A57F492A3152C0C2A8A44E40D94440	met with friend
193	6	2008-02-07 22:32:50	2008-02-07 22:34:50	t	0101000020E6100000C8BB2363B53152C0D42B6519E2DA4440	met with friend
194	6	2008-02-07 22:37:51	2008-02-07 22:39:51	t	0101000020E6100000FFD5E3BED53252C0045B25581CDC4440	met with friend
195	6	2008-02-07 22:42:53	2008-02-07 22:44:53	t	0101000020E610000078853E58C63252C0E2AFC91AF5DE4440	met with friend
196	6	2008-02-07 22:47:55	2008-02-07 22:49:55	f	0101000020E610000069925852EE3252C0E7525C55F6DF4440	met with friend
197	6	2008-02-07 22:52:56	2008-02-07 22:54:56	f	0101000020E61000007AE57ADB4C3552C0FC1873D712E04440	met with friend
198	6	2008-02-07 22:57:58	2008-02-07 22:59:58	f	0101000020E61000005A30F147513552C00F62670A9DE14440	met with friend
199	6	2008-02-07 22:57:58	2008-02-07 22:59:58	f	0101000020E61000005A30F147513552C00F62670A9DE14440	met with friend
200	6	2008-02-07 23:03:00	2008-02-07 23:05:00	t	0101000020E6100000A89201A08A3552C02B357BA015E24440	met with friend
201	6	2008-02-07 23:08:01	2008-02-07 23:10:01	f	0101000020E610000065CDC820773552C0B2D7BB3FDEE14440	met with friend
202	6	2008-02-07 23:13:03	2008-02-07 23:15:03	f	0101000020E610000042498105303752C0F37684D382E14440	met with friend
203	6	2008-02-07 23:18:05	2008-02-07 23:20:05	t	0101000020E610000053B4722F303752C017F6B4C35FE14440	met with friend
204	6	2008-02-07 23:23:06	2008-02-07 23:25:06	t	0101000020E610000008CF8426893752C0919BE1067CE04440	met with friend
205	6	2008-02-07 23:29:08	2008-02-07 23:31:08	t	0101000020E610000073C0AE264F3752C09704A8A965E14440	met with friend
206	6	2008-02-07 23:34:10	2008-02-07 23:36:10	f	0101000020E610000009E753C72A3752C033FE7DC685E14440	met with friend
207	6	2008-02-07 23:39:12	2008-02-07 23:41:12	t	0101000020E6100000651F6459303752C01EFE9AAC51E14440	met with friend
208	6	2008-02-07 23:44:13	2008-02-07 23:46:13	f	0101000020E61000000C7C45B75E3752C0DF4F8D976EE04440	met with friend
209	6	2008-02-07 23:49:15	2008-02-07 23:51:15	f	0101000020E6100000C33060C9553652C072F90FE9B7DD4440	met with friend
210	6	2008-02-08 00:27:32	2008-02-08 00:29:32	f	0101000020E610000067BE839F383852C084471B47ACDB4440	met with friend
211	6	2008-02-08 00:32:34	2008-02-08 00:34:34	f	0101000020E610000030DE8FDB2F3952C00ADCBA9BA7DC4440	met with friend
212	6	2008-02-08 00:37:35	2008-02-08 00:39:35	t	0101000020E6100000475B9544F63952C0CA8E8D40BCDC4440	met with friend
213	6	2008-02-08 00:42:37	2008-02-08 00:44:37	f	0101000020E6100000D3191879593952C022E010AAD4DE4440	met with friend
214	6	2008-02-08 00:47:39	2008-02-08 00:49:39	f	0101000020E61000001670CFF3A73752C03CA583F57FE04440	met with friend
215	6	2008-02-08 00:52:40	2008-02-08 00:54:40	f	0101000020E61000007AB0C56E9F3752C004560E2DB2DF4440	met with friend
216	6	2008-02-08 00:57:42	2008-02-08 00:59:42	f	0101000020E6100000BD2363B5F93752C0F3E505D847DD4440	met with friend
217	6	2008-02-08 01:02:44	2008-02-08 01:04:44	t	0101000020E61000006EA983BC1E3852C015E3FC4D28DE4440	met with friend
218	6	2008-02-08 01:07:45	2008-02-08 01:09:45	f	0101000020E61000007AB0C56E9F3952C0F7CC920035DF4440	met with friend
219	6	2008-02-08 01:12:47	2008-02-08 01:14:47	f	0101000020E6100000FF7E315BB23852C0E86A2BF697DF4440	met with friend
220	6	2008-02-08 01:17:49	2008-02-08 01:19:49	t	0101000020E6100000E2EF17B3253752C0CAFD0E4581E04440	met with friend
221	6	2008-02-08 01:22:50	2008-02-08 01:24:50	f	0101000020E6100000591D39D2193652C08E5DA27A6BDE4440	met with friend
222	6	2008-02-08 01:27:52	2008-02-08 01:29:52	f	0101000020E6100000E56723D74D3552C012A5BDC117E04440	met with friend
223	6	2008-02-08 01:32:54	2008-02-08 01:34:54	f	0101000020E61000009FB12FD9783652C073A25D8594E14440	met with friend
224	6	2008-02-08 01:37:55	2008-02-08 01:39:55	f	0101000020E6100000EFCA2E185C3552C0DD41EC4CA1E14440	met with friend
225	6	2008-02-08 01:42:57	2008-02-08 01:44:57	t	0101000020E6100000C33060C9553652C0CEAACFD556DE4440	met with friend
\.


--
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.managers (manager_id, username, password, org_name) FROM stdin;
1	YaleHealth	pw_manager1	Yale Health
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.patients (patient_id, username, password, first_name, last_name, email, manager_id, volunteer_id, language, diagnosis_date, onset_date, last_worked_date, case_call_status, travelled, saw_doctor, knows_status, insurance, times_called, symptomatic, gender, race, self_isolate, employment, home_location, housing_insecure, date_of_birth, referral, flagged, requested_interview, notes) FROM stdin;
1	yokor	patient1.pw	Yoko	Rodriquez	yokor@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E6100000F91A82E3323A52C056F146E691D54440	f	2000-04-11 00:00:00	f	f	f	new haven resident
2	amarrone	patient2.pw	Anneta	Marrone	am@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E6100000113CBEBD6B3652C07FF6234564CE4440	f	2000-04-11 00:00:00	f	f	f	new haven resident
3	fscheller	patient3.pw	Florentino	Scheller	fs@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E61000000B12DBDD034052C0EB39E97DE3D54440	f	2000-04-11 00:00:00	f	f	f	new haven resident
4	lscurlock	patient4.pw	Luciano	Scurlock	lucs@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E6100000C1E8F2E6703F52C0EEB60BCD75D44440	f	2000-04-11 00:00:00	f	f	f	new haven resident
5	kshine	patient5.pw	Kourtney	Shine	ks@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E610000039D73043E3E355C065AA6054522B3D40	f	2000-04-11 00:00:00	f	f	f	new haven resident
6	ccoats	patient6.pw	Chloe	Coats	cc@example.com	1	1	ENGLISH	2020-01-08 00:00:00	2020-01-05 00:00:00	2020-01-08 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E61000000B12DBDD034052C0EB39E97DE3D54440	f	2000-04-11 00:00:00	f	f	f	new haven resident
7	enevels	patient7.pw	Emily	Nevels	en@example.com	1	1	ENGLISH	2020-03-12 00:00:00	2020-03-10 00:00:00	2020-03-12 00:00:00	HAVE_NOT_CALLED_YET	f	YES	t	YALE_HEALTH_PLAN	0	f	MALE	BLACK_OR_AFRICAN_AMERICAN	YES	EMPLOYED	0101000020E61000002B1900AAB83352C0FBAE08FEB7DC4440	f	2000-04-11 00:00:00	f	f	f	new haven resident
\.

--
-- Data for Name: public_users; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.public_users (public_user_id, username, password, name, email) FROM stdin;
1	pub_user1.username	pub_user1.pw	pub_user1.name	pub_user1@public_example.com
2	pub_user2.username	pub_user2.pw	pub_user2.name	pub_user2@public_example.com
3	pub_user3.username	pub_user3.pw	pub_user3.name	pub_user3@public_example.com
4	pub_user4.username	pub_user4.pw	pub_user4.name	pub_user4@public_example.com
5	pub_user5.username	pub_user5.pw	pub_user5.name	pub_user5@public_example.com
6	pub_user6.username	pub_user6.pw	pub_user6.name	pub_user6@public_example.com
7	pub_user7.username	pub_user7.pw	pub_user7.name	pub_user7@public_example.com
8	pub_user8.username	pub_user8.pw	pub_user8.name	pub_user8@public_example.com
9	pub_user9.username	pub_user9.pw	pub_user9.name	pub_user9@public_example.com
10	pub_user10.username	pub_user10.pw	pub_user10.name	pub_user10@public_example.com
11	pub_user11.username	pub_user11.pw	pub_user11.name	pub_user11@public_example.com
12	pub_user12.username	pub_user12.pw	pub_user12.name	pub_user12@public_example.com
13	pub_user13.username	pub_user13.pw	pub_user13.name	pub_user13@public_example.com
14	pub_user14.username	pub_user14.pw	pub_user14.name	pub_user14@public_example.com
15	pub_user15.username	pub_user15.pw	pub_user15.name	pub_user15@public_example.com
16	pub_user16.username	pub_user16.pw	pub_user16.name	pub_user16@public_example.com
17	pub_user17.username	pub_user17.pw	pub_user17.name	pub_user17@public_example.com
18	pub_user18.username	pub_user18.pw	pub_user18.name	pub_user18@public_example.com
19	pub_user19.username	pub_user19.pw	pub_user19.name	pub_user19@public_example.com
20	pub_user20.username	pub_user20.pw	pub_user20.name	pub_user20@public_example.com
21	pub_user21.username	pub_user21.pw	pub_user21.name	pub_user21@public_example.com
22	pub_user22.username	pub_user22.pw	pub_user22.name	pub_user22@public_example.com
23	pub_user23.username	pub_user23.pw	pub_user23.name	pub_user23@public_example.com
24	pub_user24.username	pub_user24.pw	pub_user24.name	pub_user24@public_example.com
25	pub_user25.username	pub_user25.pw	pub_user25.name	pub_user25@public_example.com
26	pub_user26.username	pub_user26.pw	pub_user26.name	pub_user26@public_example.com
27	pub_user27.username	pub_user27.pw	pub_user27.name	pub_user27@public_example.com
28	pub_user28.username	pub_user28.pw	pub_user28.name	pub_user28@public_example.com
29	pub_user29.username	pub_user29.pw	pub_user29.name	pub_user29@public_example.com
30	pub_user30.username	pub_user30.pw	pub_user30.name	pub_user30@public_example.com
31	pub_user31.username	pub_user31.pw	pub_user31.name	pub_user31@public_example.com
32	pub_user32.username	pub_user32.pw	pub_user32.name	pub_user32@public_example.com
33	pub_user33.username	pub_user33.pw	pub_user33.name	pub_user33@public_example.com
34	pub_user34.username	pub_user34.pw	pub_user34.name	pub_user34@public_example.com
35	pub_user35.username	pub_user35.pw	pub_user35.name	pub_user35@public_example.com
36	pub_user36.username	pub_user36.pw	pub_user36.name	pub_user36@public_example.com
37	pub_user37.username	pub_user37.pw	pub_user37.name	pub_user37@public_example.com
38	pub_user38.username	pub_user38.pw	pub_user38.name	pub_user38@public_example.com
39	pub_user39.username	pub_user39.pw	pub_user39.name	pub_user39@public_example.com
40	pub_user40.username	pub_user40.pw	pub_user40.name	pub_user40@public_example.com
41	pub_user41.username	pub_user41.pw	pub_user41.name	pub_user41@public_example.com
42	pub_user42.username	pub_user42.pw	pub_user42.name	pub_user42@public_example.com
43	pub_user43.username	pub_user43.pw	pub_user43.name	pub_user43@public_example.com
44	pub_user44.username	pub_user44.pw	pub_user44.name	pub_user44@public_example.com
45	pub_user45.username	pub_user45.pw	pub_user45.name	pub_user45@public_example.com
46	pub_user46.username	pub_user46.pw	pub_user46.name	pub_user46@public_example.com
47	pub_user47.username	pub_user47.pw	pub_user47.name	pub_user47@public_example.com
48	pub_user48.username	pub_user48.pw	pub_user48.name	pub_user48@public_example.com
49	pub_user49.username	pub_user49.pw	pub_user49.name	pub_user49@public_example.com
50	pub_user50.username	pub_user50.pw	pub_user50.name	pub_user50@public_example.com
51	pub_user51.username	pub_user51.pw	pub_user51.name	pub_user51@public_example.com
52	pub_user52.username	pub_user52.pw	pub_user52.name	pub_user52@public_example.com
53	pub_user53.username	pub_user53.pw	pub_user53.name	pub_user53@public_example.com
54	pub_user54.username	pub_user54.pw	pub_user54.name	pub_user54@public_example.com
55	pub_user55.username	pub_user55.pw	pub_user55.name	pub_user55@public_example.com
56	pub_user56.username	pub_user56.pw	pub_user56.name	pub_user56@public_example.com
57	pub_user57.username	pub_user57.pw	pub_user57.name	pub_user57@public_example.com
58	pub_user58.username	pub_user58.pw	pub_user58.name	pub_user58@public_example.com
59	pub_user59.username	pub_user59.pw	pub_user59.name	pub_user59@public_example.com
60	pub_user60.username	pub_user60.pw	pub_user60.name	pub_user60@public_example.com
61	pub_user61.username	pub_user61.pw	pub_user61.name	pub_user61@public_example.com
62	pub_user62.username	pub_user62.pw	pub_user62.name	pub_user62@public_example.com
63	pub_user63.username	pub_user63.pw	pub_user63.name	pub_user63@public_example.com
64	pub_user64.username	pub_user64.pw	pub_user64.name	pub_user64@public_example.com
65	pub_user65.username	pub_user65.pw	pub_user65.name	pub_user65@public_example.com
66	pub_user66.username	pub_user66.pw	pub_user66.name	pub_user66@public_example.com
67	pub_user67.username	pub_user67.pw	pub_user67.name	pub_user67@public_example.com
68	pub_user68.username	pub_user68.pw	pub_user68.name	pub_user68@public_example.com
69	pub_user69.username	pub_user69.pw	pub_user69.name	pub_user69@public_example.com
70	pub_user70.username	pub_user70.pw	pub_user70.name	pub_user70@public_example.com
71	pub_user71.username	pub_user71.pw	pub_user71.name	pub_user71@public_example.com
72	pub_user72.username	pub_user72.pw	pub_user72.name	pub_user72@public_example.com
73	pub_user73.username	pub_user73.pw	pub_user73.name	pub_user73@public_example.com
74	pub_user74.username	pub_user74.pw	pub_user74.name	pub_user74@public_example.com
75	pub_user75.username	pub_user75.pw	pub_user75.name	pub_user75@public_example.com
76	pub_user76.username	pub_user76.pw	pub_user76.name	pub_user76@public_example.com
77	pub_user77.username	pub_user77.pw	pub_user77.name	pub_user77@public_example.com
78	pub_user78.username	pub_user78.pw	pub_user78.name	pub_user78@public_example.com
79	pub_user79.username	pub_user79.pw	pub_user79.name	pub_user79@public_example.com
80	pub_user80.username	pub_user80.pw	pub_user80.name	pub_user80@public_example.com
81	pub_user81.username	pub_user81.pw	pub_user81.name	pub_user81@public_example.com
82	pub_user82.username	pub_user82.pw	pub_user82.name	pub_user82@public_example.com
83	pub_user83.username	pub_user83.pw	pub_user83.name	pub_user83@public_example.com
84	pub_user84.username	pub_user84.pw	pub_user84.name	pub_user84@public_example.com
85	pub_user85.username	pub_user85.pw	pub_user85.name	pub_user85@public_example.com
86	pub_user86.username	pub_user86.pw	pub_user86.name	pub_user86@public_example.com
87	pub_user87.username	pub_user87.pw	pub_user87.name	pub_user87@public_example.com
88	pub_user88.username	pub_user88.pw	pub_user88.name	pub_user88@public_example.com
89	pub_user89.username	pub_user89.pw	pub_user89.name	pub_user89@public_example.com
90	pub_user90.username	pub_user90.pw	pub_user90.name	pub_user90@public_example.com
91	pub_user91.username	pub_user91.pw	pub_user91.name	pub_user91@public_example.com
92	pub_user92.username	pub_user92.pw	pub_user92.name	pub_user92@public_example.com
93	pub_user93.username	pub_user93.pw	pub_user93.name	pub_user93@public_example.com
94	pub_user94.username	pub_user94.pw	pub_user94.name	pub_user94@public_example.com
95	pub_user95.username	pub_user95.pw	pub_user95.name	pub_user95@public_example.com
96	pub_user96.username	pub_user96.pw	pub_user96.name	pub_user96@public_example.com
97	pub_user97.username	pub_user97.pw	pub_user97.name	pub_user97@public_example.com
\.


--
-- Data for Name: public_users_locations; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.public_users_locations (id, public_user_id, start_time, end_time, confirmed, geom) FROM stdin;
1	1	2008-02-02 23:32:47	2008-02-02 23:34:47	f	0101000020E6100000418864C8B13552C00D37E0F3C3E24440
2	1	2008-02-02 23:37:49	2008-02-02 23:39:49	t	0101000020E6100000D4669C86A83452C0B77F65A549DF4440
3	1	2008-02-02 23:42:51	2008-02-02 23:44:51	t	0101000020E610000006871744A43452C0E757738060DC4440
4	1	2008-02-02 23:45:31	2008-02-02 23:47:31	f	0101000020E61000002B1900AAB83352C0FBAE08FEB7DC4440
5	1	2008-02-02 23:54:02	2008-02-02 23:56:02	t	0101000020E6100000A4AB74779D2F52C085B69C4B71DB4440
6	1	2008-02-02 23:55:34	2008-02-02 23:57:34	t	0101000020E6100000AB44D95BCA2F52C0B0C91AF510DB4440
7	1	2008-02-02 23:59:04	2008-02-03 00:01:04	t	0101000020E61000000AA87004A93052C0726DA818E7D94440
8	1	2008-02-02 23:59:04	2008-02-03 00:01:04	f	0101000020E61000000AA87004A93052C0726DA818E7D94440
9	1	2008-02-03 00:00:36	2008-02-03 00:02:36	f	0101000020E6100000931E8656273152C0F9A067B3EAD94440
10	1	2008-02-03 00:10:39	2008-02-03 00:12:39	f	0101000020E610000039BA4A77D72D52C0D769A4A5F2D84440
11	1	2008-02-03 00:17:24	2008-02-03 00:19:24	t	0101000020E61000006A8D4127842C52C0894160E5D0D84440
12	1	2008-02-03 00:20:43	2008-02-03 00:22:43	t	0101000020E6100000CD988235CE2C52C0DE1FEF552BD94440
13	1	2008-02-03 00:22:24	2008-02-03 00:24:24	t	0101000020E61000007ECC07043A2D52C0494BE5ED08D94440
14	1	2008-02-03 00:27:24	2008-02-03 00:29:24	f	0101000020E61000002F1D739EB12D52C0844C327216DC4440
15	1	2008-02-03 00:35:36	2008-02-03 00:37:36	t	0101000020E6100000DA9596917A2D52C0912749D74CDC4440
16	1	2008-02-03 07:25:13	2008-02-03 07:27:13	f	0101000020E6100000D5F20357792E52C0CC9C2E8B89DB4440
17	1	2008-02-03 07:30:14	2008-02-03 07:32:14	t	0101000020E61000008352B4722F3052C0BC22F8DF4ADC4440
18	1	2008-02-03 07:30:49	2008-02-03 07:32:49	t	0101000020E6100000B503AE2B663052C0207BBDFBE3DB4440
19	1	2008-02-03 07:34:54	2008-02-03 07:36:54	t	0101000020E6100000906CAE9AE73052C0A54E401361DD4440
20	1	2008-02-03 07:35:16	2008-02-03 07:37:16	f	0101000020E610000029EE7893DF3052C09E0C8E9257DD4440
21	1	2008-02-03 07:40:05	2008-02-03 07:42:05	t	0101000020E610000032B2648EE52F52C07F18213CDADA4440
22	1	2008-02-03 07:40:18	2008-02-03 07:42:18	f	0101000020E610000020477364E52F52C030478FDFDBDA4440
23	1	2008-02-03 07:42:39	2008-02-03 07:44:39	t	0101000020E6100000D5D00660033052C029B3412619DB4440
24	1	2008-02-03 07:42:41	2008-02-03 07:44:41	t	0101000020E6100000BC404981053052C07EA99F3715DB4440
25	1	2008-02-03 07:56:42	2008-02-03 07:58:42	f	0101000020E6100000F20D85CFD62752C0D4484BE5EDE64440
26	1	2008-02-03 08:06:46	2008-02-03 08:08:46	f	0101000020E6100000A4C85A43A93152C0999EB0C403D84440
27	1	2008-02-03 08:06:46	2008-02-03 08:08:46	f	0101000020E61000009E819197352752C0E1B4E0455FEB4440
28	1	2008-02-03 08:11:47	2008-02-03 08:13:47	f	0101000020E6100000DACA4BFE272752C00490DAC4C9EB4440
29	1	2008-02-03 08:16:49	2008-02-03 08:18:49	f	0101000020E61000004F07B29E5A2752C0F168E388B5EA4440
30	1	2008-02-03 08:19:44	2008-02-03 08:21:44	f	0101000020E610000077E107E7532752C03333333333E94440
31	1	2008-02-03 08:21:51	2008-02-03 08:23:51	t	0101000020E610000007BCCCB0512852C06C09F9A067E94440
32	1	2008-02-03 08:29:47	2008-02-03 08:31:47	t	0101000020E6100000AD5791D1012B52C00E4A9869FBE54440
33	1	2008-02-03 08:36:56	2008-02-03 08:38:56	t	0101000020E610000067DB696B442C52C0DBDC989EB0E24440
34	1	2008-02-03 08:39:51	2008-02-03 08:41:51	f	0101000020E610000010290648342D52C06BF12900C6E14440
35	1	2008-02-03 08:41:57	2008-02-03 08:43:57	f	0101000020E6100000E775C4211B2E52C09DD7D825AAE14440
36	1	2008-02-03 08:44:52	2008-02-03 08:46:52	f	0101000020E610000086950A2AAA2E52C01FBFB7E9CFE04440
37	1	2008-02-03 08:49:35	2008-02-03 08:51:35	f	0101000020E6100000FFB8FDF2C92E52C0A796ADF545E04440
38	1	2008-02-03 09:00:25	2008-02-03 09:02:25	f	0101000020E61000004C72C0AE262F52C08CF84ECC7ADF4440
39	1	2008-02-03 09:00:25	2008-02-03 09:02:25	f	0101000020E61000004C72C0AE262F52C08CF84ECC7ADF4440
40	1	2008-02-03 09:05:26	2008-02-03 09:07:26	f	0101000020E61000002272FA7ABE2E52C06AA4A5F276DE4440
41	1	2008-02-03 09:07:11	2008-02-03 09:09:11	t	0101000020E6100000884CF910542F52C034F9669B1BDD4440
42	1	2008-02-03 09:10:28	2008-02-03 09:12:28	f	0101000020E6100000558D5E0D503052C03DF20703CFDB4440
43	1	2008-02-03 09:12:12	2008-02-03 09:14:12	t	0101000020E6100000A9C29FE1CD3052C075C8CD7003DC4440
44	1	2008-02-03 09:15:30	2008-02-03 09:17:30	f	0101000020E61000003339B5334C3152C01904560E2DDC4440
45	1	2008-02-03 09:17:14	2008-02-03 09:19:14	f	0101000020E6100000EC6F09C03F3152C04C89247A19DB4440
46	1	2008-02-03 09:25:33	2008-02-03 09:27:33	t	0101000020E6100000063065E0803252C0EDF0D7648DDC4440
47	1	2008-02-03 09:27:17	2008-02-03 09:29:17	t	0101000020E6100000C26F438CD73252C02E3E05C078DC4440
48	1	2008-02-03 09:32:19	2008-02-03 09:34:19	f	0101000020E6100000BDCCB051D63152C0EF7211DF89DB4440
49	1	2008-02-03 09:37:21	2008-02-03 09:39:21	t	0101000020E610000089F546AD303152C01500E31934DA4440
50	1	2008-02-03 09:42:22	2008-02-03 09:44:22	f	0101000020E6100000859A2155143152C05648F949B5D54440
51	1	2008-02-04 00:42:56	2008-02-04 00:44:56	f	0101000020E61000004A810530652852C0B9DFA128D0E94440
52	1	2008-02-04 00:42:56	2008-02-04 00:44:56	t	0101000020E61000004A810530652852C0B9DFA128D0E94440
53	1	2008-02-04 00:47:18	2008-02-04 00:49:18	t	0101000020E6100000373D2828452752C041F67AF7C7E94440
54	1	2008-02-04 00:47:57	2008-02-04 00:49:57	t	0101000020E6100000373D2828452752C041F67AF7C7E94440
55	1	2008-02-04 00:52:18	2008-02-04 00:54:18	t	0101000020E61000009AB7EA3A542752C0DC68006F81EA4440
56	1	2008-02-04 00:52:59	2008-02-04 00:54:59	f	0101000020E61000009AB7EA3A542752C0DC68006F81EA4440
57	1	2008-02-04 00:57:18	2008-02-04 00:59:18	f	0101000020E6100000ECA9D557572752C0A37A6B60ABEA4440
58	1	2008-02-04 00:58:01	2008-02-04 01:00:01	t	0101000020E610000033569BFF572752C0CD920035B5EA4440
59	1	2008-02-04 01:02:19	2008-02-04 01:04:19	t	0101000020E6100000CCD765F84F2752C04512BD8C62EB4440
60	1	2008-02-04 01:02:19	2008-02-04 01:04:19	f	0101000020E6100000CCD765F84F2752C04512BD8C62EB4440
61	1	2008-02-04 01:03:02	2008-02-04 01:05:02	t	0101000020E61000001063D2DF4B2752C0459E245D33EB4440
62	1	2008-02-04 01:07:20	2008-02-04 01:09:20	t	0101000020E610000057D5CBEF342752C03ED00A0C59EB4440
63	1	2008-02-04 01:08:04	2008-02-04 01:10:04	t	0101000020E6100000C94274081C2752C05A9E077767EB4440
64	1	2008-02-04 01:23:09	2008-02-04 01:25:09	f	0101000020E6100000498B3386392752C06C7D91D096E94440
65	1	2008-02-04 01:28:11	2008-02-04 01:30:11	t	0101000020E6100000B976A224242A52C0745E6397A8E44440
66	1	2008-02-04 01:33:12	2008-02-04 01:35:12	f	0101000020E6100000EAB303AE2B2E52C062F8889812DF4440
67	1	2008-02-04 01:38:14	2008-02-04 01:40:14	t	0101000020E61000004F98309A952D52C009C4EBFA05D94440
68	1	2008-02-04 01:43:16	2008-02-04 01:45:16	t	0101000020E61000001063D2DF4B2B52C0817D74EACAD54440
69	1	2008-02-04 01:48:17	2008-02-04 01:50:17	t	0101000020E610000012E0F42EDE2552C0BA313D6189D54440
70	1	2008-02-04 01:53:19	2008-02-04 01:55:19	f	0101000020E610000008431D56B82352C0124E0B5EF4D34440
71	1	2008-02-04 01:55:56	2008-02-04 01:57:56	f	0101000020E6100000920BCEE0EF2352C09BE61DA7E8D24440
72	1	2008-02-04 01:58:21	2008-02-04 02:00:21	f	0101000020E6100000C8D8092FC12352C0310DC347C4D24440
73	1	2008-02-04 02:00:58	2008-02-04 02:02:58	t	0101000020E61000008B558330B72352C084F57F0EF3D34440
74	1	2008-02-04 02:03:22	2008-02-04 02:05:22	t	0101000020E6100000392EE3A6062452C0C9022670EBD44440
75	1	2008-02-04 02:11:01	2008-02-04 02:13:01	t	0101000020E6100000063065E0802652C0247F30F0DCD54440
76	2	2008-02-06 19:12:04	2008-02-06 19:14:04	t	0101000020E6100000610322C4953F52C04DDBBFB2D2D64440
77	2	2008-02-06 19:17:05	2008-02-06 19:19:05	t	0101000020E61000006BA0F99CBB3F52C0B22E6EA301D64440
78	2	2008-02-06 19:22:07	2008-02-06 19:24:07	t	0101000020E6100000A6F3E159823E52C08F53742497D54440
79	2	2008-02-06 19:27:09	2008-02-06 19:29:09	f	0101000020E610000060251FBB0B3C52C01DACFF7398D54440
80	2	2008-02-06 19:32:10	2008-02-06 19:34:10	t	0101000020E61000008FB0A888D33952C0AC048BC399D54440
81	2	2008-02-06 19:37:12	2008-02-06 19:39:12	f	0101000020E61000002524D236FE3852C09D685721E5D94440
82	2	2008-02-06 19:42:14	2008-02-06 19:44:14	f	0101000020E6100000819BC58B853552C0BFF1B56796DA4440
83	2	2008-02-06 19:45:48	2008-02-06 19:47:48	t	0101000020E6100000263CA1D79F3452C0836E2F698CDC4440
84	2	2008-02-06 19:47:15	2008-02-06 19:49:15	f	0101000020E61000004726E0D7483452C0ED478AC8B0DC4440
85	2	2008-02-06 19:51:56	2008-02-06 19:53:56	f	0101000020E610000033CA332F873352C06631B1F9B8DC4440
86	2	2008-02-06 19:52:17	2008-02-06 19:54:17	f	0101000020E6100000C13FA54A943352C0D1B359F5B9DC4440
87	2	2008-02-06 19:56:58	2008-02-06 19:58:58	f	0101000020E61000009F5F94A0BF3452C0AC730CC85EDD4440
88	2	2008-02-06 19:57:19	2008-02-06 19:59:19	f	0101000020E6100000C5CA68E4F33452C065C746205EDD4440
89	2	2008-02-06 20:02:20	2008-02-06 20:04:20	t	0101000020E610000040C23060C93552C0C5E6E3DA50DB4440
90	2	2008-02-06 20:07:22	2008-02-06 20:09:22	t	0101000020E61000003B933655F73452C0F8E461A1D6DA4440
91	2	2008-02-06 20:12:24	2008-02-06 20:14:24	f	0101000020E6100000DAE731CA333152C055A4C2D842DA4440
92	2	2008-02-06 20:15:17	2008-02-06 20:17:17	f	0101000020E6100000ABED26F8A63152C0977329AE2AD94440
93	2	2008-02-06 20:20:19	2008-02-06 20:22:19	f	0101000020E6100000AA6BED7DAA3252C090A0F831E6D84440
94	2	2008-02-06 20:22:27	2008-02-06 20:24:27	f	0101000020E6100000D8C1C1DEC43252C0D9D30E7F4DD84440
95	2	2008-02-06 20:25:20	2008-02-06 20:27:20	f	0101000020E6100000C1745AB7413352C0842A357BA0D74440
96	2	2008-02-06 20:27:28	2008-02-06 20:29:28	t	0101000020E61000002A064834813452C0B610E4A084D74440
97	2	2008-02-06 20:32:30	2008-02-06 20:34:30	f	0101000020E61000008D2E6F0ED73252C00B98C0ADBBD74440
98	2	2008-02-06 20:37:32	2008-02-06 20:39:32	f	0101000020E6100000FEA02E52283152C0EC6987BF26D94440
99	2	2008-02-06 20:37:32	2008-02-06 20:39:32	f	0101000020E6100000FEA02E52283152C0EC6987BF26D94440
100	2	2008-02-06 20:45:41	2008-02-06 20:47:41	t	0101000020E6100000713E75AC523052C01B12F758FADA4440
101	2	2008-02-06 20:47:35	2008-02-06 20:49:35	f	0101000020E61000004BD3A0681E3052C0AA9F3715A9DA4440
102	2	2008-02-06 20:52:37	2008-02-06 20:54:37	t	0101000020E610000045DE72F5632F52C02C2B4D4A41D94440
103	2	2008-02-06 20:57:38	2008-02-06 20:59:38	t	0101000020E6100000284A42226D2F52C0645DDC4603D24440
104	2	2008-02-06 21:01:03	2008-02-06 21:03:03	f	0101000020E61000005B65A6B4FE2E52C01E6D1CB116D14440
105	2	2008-02-06 21:02:40	2008-02-06 21:04:40	t	0101000020E61000006DD097DEFE2E52C0B30C71AC8BD14440
106	2	2008-02-06 21:07:41	2008-02-06 21:09:41	f	0101000020E61000007317618A722F52C0C93CF20703D14440
107	2	2008-02-06 21:11:31	2008-02-06 21:13:31	t	0101000020E61000008A42CBBA7F2E52C07429AE2AFBD04440
108	2	2008-02-06 21:12:42	2008-02-06 21:14:42	t	0101000020E61000004DA7751BD42E52C07B4E7ADFF8D04440
109	2	2008-02-06 21:17:44	2008-02-06 21:19:44	f	0101000020E61000005440DAFF002F52C055C1A8A44ED24440
110	2	2008-02-06 21:21:22	2008-02-06 21:23:22	t	0101000020E6100000DFFE5C34642E52C090831266DAD04440
111	2	2008-02-06 21:22:46	2008-02-06 21:24:46	f	0101000020E6100000C34D4695612E52C04A46CEC29ED04440
112	2	2008-02-06 21:26:23	2008-02-06 21:28:23	f	0101000020E6100000306AF7AB002F52C07480608E1ED14440
113	2	2008-02-06 21:27:47	2008-02-06 21:29:47	t	0101000020E61000003E2828452B2F52C001FBE8D495D14440
114	2	2008-02-06 21:31:50	2008-02-06 21:33:50	f	0101000020E61000004C55DAE21A2F52C02CF697DD93D14440
115	2	2008-02-06 21:32:49	2008-02-06 21:34:49	t	0101000020E6100000D75240DAFF2E52C0DD989EB0C4D14440
116	2	2008-02-06 21:36:52	2008-02-06 21:38:52	t	0101000020E61000003DDBA337DC2F52C0B329577897D14440
117	2	2008-02-06 21:41:53	2008-02-06 21:43:53	f	0101000020E610000078853E58C63052C0535C55F65DD34440
118	2	2008-02-06 21:42:52	2008-02-06 21:44:52	f	0101000020E6100000E5B9BE0F073152C04B598638D6D34440
119	2	2008-02-06 21:46:55	2008-02-06 21:48:55	t	0101000020E61000007CD6355A0E3252C0AEBB79AA43D44440
120	2	2008-02-06 21:47:54	2008-02-06 21:49:54	t	0101000020E6100000927F66101F3252C060EAE74D45D44440
121	2	2008-02-06 21:51:57	2008-02-06 21:53:57	t	0101000020E6100000884CF910543352C0F46C567DAED44440
122	3	2008-02-07 16:37:50	2008-02-07 16:39:50	f	0101000020E6100000865B3E92923E52C06C5B94D920D54440
123	3	2008-02-07 16:42:51	2008-02-07 16:44:51	f	0101000020E61000001497E315883C52C025AFCE3120D54440
124	3	2008-02-07 16:47:53	2008-02-07 16:49:53	f	0101000020E61000008981AE7D013B52C00F45813E91D54440
125	3	2008-02-07 16:52:55	2008-02-07 16:54:55	f	0101000020E610000033C51C041D3952C04F58E20165D54440
126	3	2008-02-07 16:57:57	2008-02-07 16:59:57	t	0101000020E610000006F69848693852C0E0A128D027D44440
127	3	2008-02-07 17:02:58	2008-02-07 17:04:58	f	0101000020E61000008279C8940F3752C0BC22F8DF4AD44440
128	3	2008-02-07 17:08:00	2008-02-07 17:10:00	t	0101000020E610000091BE49D3A03652C09BC937DBDCD24440
129	3	2008-02-07 17:13:02	2008-02-07 17:15:02	t	0101000020E6100000A8E9B303AE3552C0F3AB394030D14440
130	3	2008-02-07 17:16:11	2008-02-07 17:18:11	t	0101000020E6100000A8E9B303AE3552C0F3AB394030D14440
131	3	2008-02-07 17:43:17	2008-02-07 17:45:17	t	0101000020E6100000BA54A52DAE3552C017821C9430D14440
132	3	2008-02-07 17:48:19	2008-02-07 17:50:19	t	0101000020E6100000967EC2D9AD3552C03B58FFE730D14440
133	3	2008-02-07 17:53:20	2008-02-07 17:55:20	t	0101000020E6100000967EC2D9AD3552C03B58FFE730D14440
134	3	2008-02-07 17:58:22	2008-02-07 18:00:22	f	0101000020E610000079EA9106B73552C01EA7E8482ED14440
135	3	2008-02-07 17:58:22	2008-02-07 18:00:22	f	0101000020E610000079EA9106B73552C01EA7E8482ED14440
136	3	2008-02-07 18:03:24	2008-02-07 18:05:24	f	0101000020E6100000306AF7AB003552C091662C9ACED04440
137	3	2008-02-07 18:08:26	2008-02-07 18:10:26	t	0101000020E6100000CD988235CE3052C01FDC9DB5DBD04440
138	3	2008-02-07 18:18:29	2008-02-07 18:20:29	t	0101000020E6100000312B14E97E2E52C0AB21718FA5D54440
139	3	2008-02-07 18:23:31	2008-02-07 18:25:31	t	0101000020E6100000CD7B9C69C22E52C0D9942BBCCBD34440
140	3	2008-02-07 18:28:33	2008-02-07 18:30:33	f	0101000020E61000005A4DD7135D2F52C0F645425BCED34440
141	3	2008-02-07 18:33:35	2008-02-07 18:35:35	f	0101000020E6100000473EAF78EA2F52C0BD00FBE8D4D34440
142	3	2008-02-07 18:38:36	2008-02-07 18:40:36	t	0101000020E61000006D3F19E3C33052C0FE0E45813ED34440
143	3	2008-02-07 18:43:38	2008-02-07 18:45:38	f	0101000020E610000095F77134473052C0FBAE08FEB7D44440
144	3	2008-02-07 18:48:40	2008-02-07 18:50:40	t	0101000020E610000072CADC7C233052C06F2F698CD6D34440
145	3	2008-02-07 18:53:42	2008-02-07 18:55:42	f	0101000020E6100000927A4FE5B43152C08BC3995FCDD34440
146	3	2008-02-07 18:58:44	2008-02-07 19:00:44	f	0101000020E61000003A5E81E8493352C0672C9ACE4ED44440
147	3	2008-02-07 19:03:45	2008-02-07 19:05:45	t	0101000020E6100000D97DC7F0D83352C0433EE8D9ACD44440
148	3	2008-02-07 19:08:46	2008-02-07 19:10:46	t	0101000020E6100000319FAC18AE3452C09E98F56228D54440
149	3	2008-02-07 19:13:48	2008-02-07 19:15:48	f	0101000020E61000007B371614063552C0CD4065FCFBD64440
150	3	2008-02-07 19:18:50	2008-02-07 19:20:50	f	0101000020E6100000BBDBF5D2143552C08FC70C54C6D94440
151	4	2008-02-04 13:47:07	2008-02-04 13:49:07	f	0101000020E6100000DB6E826F9A3052C0D6CA845FEAD94440
152	4	2008-02-04 13:52:10	2008-02-04 13:54:10	t	0101000020E6100000927A4FE5B43152C0DC85E63A8DDA4440
153	4	2008-02-04 13:55:59	2008-02-04 13:57:59	t	0101000020E6100000F5160FEF393252C014D044D8F0DA4440
154	4	2008-02-04 13:57:10	2008-02-04 13:59:10	f	0101000020E610000062FE0A992B3352C0C6E1CCAFE6DA4440
155	4	2008-02-04 14:02:12	2008-02-04 14:04:12	f	0101000020E6100000812C4487C03552C0C6DCB5847CDA4440
156	4	2008-02-04 14:06:02	2008-02-04 14:08:02	t	0101000020E6100000037E8D24413652C0E449D23593DD4440
157	4	2008-02-04 14:07:14	2008-02-04 14:09:14	f	0101000020E61000001506651A4D3652C0A27F828B15DF4440
158	4	2008-02-04 14:12:15	2008-02-04 14:14:15	t	0101000020E610000069AF3E1EFA3652C02DEC6987BFE04440
159	4	2008-02-04 14:16:05	2008-02-04 14:18:05	f	0101000020E6100000132D793C2D3752C066BD18CA89E04440
160	4	2008-02-04 14:22:19	2008-02-04 14:24:19	t	0101000020E610000022382EE3A63852C0917EFB3A70E04440
161	4	2008-02-04 14:26:09	2008-02-04 14:28:09	f	0101000020E6100000E2CD1ABCAF3852C061FD9FC37CDF4440
162	4	2008-02-04 14:27:20	2008-02-04 14:29:20	f	0101000020E6100000420A9E42AE3852C0DBA7E33103DF4440
163	4	2008-02-04 14:32:22	2008-02-04 14:34:22	t	0101000020E6100000D982DE1B433852C0200C3CF71EDC4440
164	4	2008-02-04 14:36:12	2008-02-04 14:38:12	t	0101000020E610000038DC476E4D3852C01A6EC0E787DB4440
165	4	2008-02-04 14:37:24	2008-02-04 14:39:24	f	0101000020E6100000BF49D3A0683852C0454C89247ADB4440
166	4	2008-02-04 14:42:25	2008-02-04 14:44:25	f	0101000020E61000000E8AE6012C3852C04DBED9E6C6DA4440
167	4	2008-02-04 14:46:15	2008-02-04 14:48:15	t	0101000020E6100000B18BA2073E3852C06F4C4F58E2DB4440
168	4	2008-02-04 14:47:27	2008-02-04 14:49:27	t	0101000020E6100000155D177E703852C0C45F9335EADB4440
169	4	2008-02-04 14:52:29	2008-02-04 14:54:29	f	0101000020E6100000A3073E062B3852C0F1A2AF20CDDA4440
170	4	2008-02-04 14:56:18	2008-02-04 14:58:18	f	0101000020E6100000CBC4AD82183852C082E7DEC325D94440
171	4	2008-02-04 14:57:30	2008-02-04 14:59:30	f	0101000020E610000055FCDF11153852C082FFAD64C7D84440
172	4	2008-02-04 15:02:32	2008-02-04 15:04:32	t	0101000020E6100000986F7D586F3652C05F29CB10C7D84440
173	4	2008-02-04 15:06:22	2008-02-04 15:08:22	f	0101000020E610000099C11891283652C05A2A6F4738D74440
174	4	2008-02-04 15:07:34	2008-02-04 15:09:34	t	0101000020E6100000E371512D223652C01B4CC3F011D74440
175	4	2008-02-04 15:12:35	2008-02-04 15:14:35	t	0101000020E6100000D2E4620CAC3552C00E897B2C7DD64440
176	4	2008-02-04 15:16:25	2008-02-04 15:18:25	f	0101000020E6100000503C670B083552C071E6577380D64440
177	4	2008-02-04 15:17:37	2008-02-04 15:19:37	f	0101000020E610000017DA39CD023552C06A300DC347D64440
178	4	2008-02-04 15:22:41	2008-02-04 15:24:41	t	0101000020E610000004B34291EE3552C0166A4DF38ED54440
179	4	2008-02-04 15:26:28	2008-02-04 15:28:28	t	0101000020E61000001CD47E6B273652C07C61325530D84440
180	4	2008-02-04 15:32:42	2008-02-04 15:34:42	f	0101000020E61000008DBAD6DEA73452C07E91D09673DB4440
181	4	2008-02-04 15:36:32	2008-02-04 15:38:32	t	0101000020E61000007880272D5C3452C0850838842ADF4440
182	4	2008-02-04 15:36:32	2008-02-04 15:38:32	t	0101000020E61000007880272D5C3452C0850838842ADF4440
183	4	2008-02-04 15:37:43	2008-02-04 15:39:43	f	0101000020E610000079EFA831213452C005FA449E24DF4440
184	4	2008-02-04 15:42:45	2008-02-04 15:44:45	f	0101000020E6100000ED3026FDBD3452C099F5622827E04440
185	4	2008-02-04 15:46:35	2008-02-04 15:48:35	f	0101000020E610000050E5B4A7E43452C0B3463D44A3E14440
186	4	2008-02-04 15:47:47	2008-02-04 15:49:47	t	0101000020E6100000948D075BEC3452C0CD751A69A9E24440
187	4	2008-02-04 15:52:49	2008-02-04 15:54:49	t	0101000020E61000002DF2EB87D83252C0AB09A2EE03E24440
188	4	2008-02-04 15:56:38	2008-02-04 15:58:38	t	0101000020E6100000749EB12FD93252C06C3EAE0D15E14440
189	5	2008-02-05 16:18:28	2008-02-05 16:20:28	f	0101000020E6100000F83C7FDAA83452C05114E81379DC4440
190	5	2008-02-05 16:22:42	2008-02-05 16:24:42	f	0101000020E6100000B8B585E7A53452C0A852B3075ADB4440
191	5	2008-02-05 16:23:30	2008-02-05 16:25:30	f	0101000020E6100000CA207711A63452C0857CD0B359DB4440
192	5	2008-02-05 16:27:43	2008-02-05 16:29:43	t	0101000020E6100000F69D5F94A03352C03FAE0D15E3DA4440
193	5	2008-02-05 16:28:31	2008-02-05 16:30:31	t	0101000020E6100000CD0C1B65FD3252C014B35E0CE5DA4440
194	5	2008-02-05 16:32:45	2008-02-05 16:34:45	f	0101000020E6100000C55BE7DF2E3152C0C1ADBB79AAD94440
195	5	2008-02-05 16:33:33	2008-02-05 16:35:33	f	0101000020E6100000E51071732A3152C0F4C308E1D1D84440
196	5	2008-02-05 16:37:47	2008-02-05 16:39:47	f	0101000020E61000006C274A42223152C0DBC4C9FD0ED74440
197	5	2008-02-05 16:38:35	2008-02-05 16:40:35	f	0101000020E610000013109370213152C01BD82AC1E2D64440
198	5	2008-02-05 16:39:35	2008-02-05 16:41:35	f	0101000020E6100000B6A2CD716E3152C0A35D85949FD64440
199	5	2008-02-05 16:43:03	2008-02-05 16:45:03	f	0101000020E6100000B61666A19D3152C02BDEC83CF2D54440
200	5	2008-02-05 16:43:36	2008-02-05 16:45:36	f	0101000020E6100000EB573A1F9E3152C05DA79196CAD54440
201	5	2008-02-05 16:47:50	2008-02-05 16:49:50	t	0101000020E6100000A40227DBC03152C0E57E87A240D54440
202	5	2008-02-05 16:48:38	2008-02-05 16:50:38	f	0101000020E610000080A0DCB6EF3152C0BBD573D2FBD44440
203	5	2008-02-05 16:52:52	2008-02-05 16:54:52	f	0101000020E610000063855B3E923252C02DEC6987BFD44440
204	5	2008-02-05 16:57:53	2008-02-05 16:59:53	t	0101000020E6100000E7E44526E03352C0F4E0EEACDDD44440
205	5	2008-02-05 16:58:41	2008-02-05 17:00:41	f	0101000020E610000036B6D782DE3352C01E7233DC80D54440
206	5	2008-02-05 17:02:55	2008-02-05 17:04:55	f	0101000020E61000000092E9D0E93352C070B6B9313DD74440
207	5	2008-02-05 17:03:43	2008-02-05 17:05:43	f	0101000020E6100000440070ECD93352C01A8BA6B393D74440
208	5	2008-02-05 17:07:56	2008-02-05 17:09:56	t	0101000020E6100000927A4FE5B43352C003B2D7BB3FD84440
209	5	2008-02-05 17:08:44	2008-02-05 17:10:44	f	0101000020E61000000F1137A7923352C0D9B628B341D84440
210	5	2008-02-05 17:12:58	2008-02-05 17:14:58	t	0101000020E6100000A18A1BB7983352C081CF0F2384D94440
211	5	2008-02-05 17:13:46	2008-02-05 17:15:46	t	0101000020E61000000B0DC4B2993352C016C1FF56B2D94440
212	5	2008-02-05 17:18:00	2008-02-05 17:20:00	f	0101000020E61000004CAC8C463E3352C079758E01D9D94440
213	5	2008-02-05 17:18:48	2008-02-05 17:20:48	f	0101000020E6100000FAB9A1293B3352C032C9C859D8D94440
214	5	2008-02-05 17:23:01	2008-02-05 17:25:01	f	0101000020E61000005B828C800A3352C048551344DDD94440
215	5	2008-02-05 17:23:01	2008-02-05 17:25:01	f	0101000020E61000005B828C800A3352C048551344DDD94440
216	5	2008-02-05 17:23:49	2008-02-05 17:25:49	f	0101000020E610000049FAB48AFE3252C08F01D9EBDDD94440
217	5	2008-02-05 17:28:03	2008-02-05 17:30:03	f	0101000020E6100000D1EE9062803252C07250C24CDBD94440
218	5	2008-02-05 17:28:51	2008-02-05 17:30:51	t	0101000020E6100000E7E95C514A3252C0DDD26A48DCD94440
219	5	2008-02-05 17:33:07	2008-02-05 17:35:07	f	0101000020E61000001844A4A65D3052C00F10CCD1E3D94440
220	5	2008-02-05 17:33:53	2008-02-05 17:35:53	t	0101000020E6100000D5B32094F72F52C0C03E3A75E5D94440
221	5	2008-02-05 17:38:06	2008-02-05 17:40:06	t	0101000020E6100000D3C26515362F52C0A2629CBF09DB4440
222	5	2008-02-05 17:38:54	2008-02-05 17:40:54	f	0101000020E6100000381B2B31CF2E52C01ADD41EC4CDB4440
223	5	2008-02-05 17:43:11	2008-02-05 17:45:11	f	0101000020E6100000B212F3ACA42D52C0D23AAA9A20DC4440
224	5	2008-02-05 17:43:11	2008-02-05 17:45:11	f	0101000020E6100000B212F3ACA42D52C0D23AAA9A20DC4440
225	5	2008-02-05 17:43:56	2008-02-05 17:45:56	f	0101000020E6100000D370CADC7C2D52C0D1915CFE43DC4440
226	6	2008-02-04 22:01:41	2008-02-04 22:03:41	f	0101000020E61000007A8EC877293752C034D769A4A5E04440
227	6	2008-02-04 22:05:49	2008-02-04 22:07:49	t	0101000020E6100000892AFC19DE3652C018EC866D8BE04440
228	6	2008-02-04 22:06:43	2008-02-04 22:08:43	t	0101000020E61000008D800A47903652C07C4963B48EE04440
229	6	2008-02-04 22:11:45	2008-02-04 22:13:45	t	0101000020E610000014B9E00CFE3652C0603C8386FEDF4440
230	6	2008-02-04 22:15:52	2008-02-04 22:17:52	t	0101000020E6100000A5897780273752C018CFA0A17FE04440
231	6	2008-02-04 22:16:46	2008-02-04 22:18:46	f	0101000020E610000045A4A65D4C3752C0D8648D7A88E04440
232	6	2008-02-04 22:21:48	2008-02-04 22:23:48	t	0101000020E6100000D1285DFA973852C0D105F52D73E04440
233	6	2008-02-04 22:25:55	2008-02-04 22:27:55	t	0101000020E610000096ED43DE723952C0D1D03FC1C5E04440
234	7	2008-02-07 01:59:39	2008-02-07 02:01:39	f	0101000020E610000099F6CDFDD53152C02BDEC83CF2E94440
235	7	2008-02-07 02:14:39	2008-02-07 02:16:39	t	0101000020E61000007620EBA9D53152C0728A8EE4F2E94440
236	7	2008-02-07 02:19:39	2008-02-07 02:21:39	t	0101000020E6100000878BDCD3D53152C0B936548CF3E94440
237	7	2008-02-07 02:24:39	2008-02-07 02:26:39	f	0101000020E6100000878BDCD3D53152C0DD0C37E0F3E94440
238	7	2008-02-07 02:29:39	2008-02-07 02:31:39	t	0101000020E61000007620EBA9D53152C0DD0C37E0F3E94440
239	7	2008-02-07 02:34:39	2008-02-07 02:36:39	f	0101000020E610000064B5F97FD53152C000E31934F4E94440
240	7	2008-02-07 02:44:39	2008-02-07 02:46:39	t	0101000020E610000040DF162CD53152C024B9FC87F4E94440
241	7	2008-02-07 02:49:39	2008-02-07 02:51:39	t	0101000020E610000040DF162CD53152C024B9FC87F4E94440
242	7	2008-02-07 02:49:39	2008-02-07 02:51:39	t	0101000020E610000040DF162CD53152C024B9FC87F4E94440
243	7	2008-02-07 02:54:39	2008-02-07 02:56:39	t	0101000020E610000040DF162CD53152C024B9FC87F4E94440
244	7	2008-02-07 02:59:39	2008-02-07 03:01:39	f	0101000020E6100000A01B9AB2D33152C08E3BA583F5E94440
245	7	2008-02-07 03:09:39	2008-02-07 03:11:39	t	0101000020E61000000B9E42AED43152C08E3BA583F5E94440
246	7	2008-02-07 03:14:39	2008-02-07 03:16:39	f	0101000020E61000002F742502D53152C08E3BA583F5E94440
247	7	2008-02-07 03:19:39	2008-02-07 03:21:39	t	0101000020E6100000524A0856D53152C08E3BA583F5E94440
248	7	2008-02-07 03:24:39	2008-02-07 03:26:39	f	0101000020E610000064B5F97FD53152C06B65C22FF5E94440
249	7	2008-02-07 03:29:39	2008-02-07 03:31:39	t	0101000020E61000007620EBA9D53152C06B65C22FF5E94440
250	7	2008-02-07 03:34:39	2008-02-07 03:36:39	t	0101000020E6100000878BDCD3D53152C0478FDFDBF4E94440
251	7	2008-02-07 03:39:39	2008-02-07 03:41:39	f	0101000020E61000006FFB1EF5D73152C0C05B2041F1E94440
252	7	2008-02-07 03:44:39	2008-02-07 03:46:39	t	0101000020E61000004B253CA1D73152C0DD0C37E0F3E94440
253	7	2008-02-07 03:49:39	2008-02-07 03:51:39	t	0101000020E61000006FFB1EF5D73152C056D97745F0E94440
254	7	2008-02-07 03:54:39	2008-02-07 03:56:39	t	0101000020E6100000B6A7E49CD83152C0EB56CF49EFE94440
255	7	2008-02-07 03:59:39	2008-02-07 04:01:39	f	0101000020E61000008066101FD83152C0392861A6EDE94440
256	7	2008-02-07 04:04:39	2008-02-07 04:06:39	t	0101000020E61000008066101FD83152C0A4AA09A2EEE94440
257	7	2008-02-07 04:09:39	2008-02-07 04:11:39	f	0101000020E61000008066101FD83152C0EB56CF49EFE94440
258	7	2008-02-07 04:14:39	2008-02-07 04:16:39	t	0101000020E61000006FFB1EF5D73152C0EB56CF49EFE94440
259	7	2008-02-07 04:19:39	2008-02-07 04:21:39	f	0101000020E61000004B253CA1D73152C01D9430D3F6E94440
260	7	2008-02-07 04:24:38	2008-02-07 04:26:38	t	0101000020E61000005D902DCBD73152C0D6E76A2BF6E94440
261	7	2008-02-07 04:29:38	2008-02-07 04:31:38	t	0101000020E61000006FFB1EF5D73152C0F9BD4D7FF6E94440
262	7	2008-02-07 04:34:38	2008-02-07 04:36:38	t	0101000020E61000005D902DCBD73152C06B65C22FF5E94440
263	7	2008-02-07 04:39:38	2008-02-07 04:41:38	f	0101000020E610000039BA4A77D73152C0C79DD2C1FAE94440
264	7	2008-02-07 04:44:38	2008-02-07 04:46:38	f	0101000020E6100000CF37A27BD63152C0EB73B515FBE94440
265	7	2008-02-07 04:49:38	2008-02-07 04:51:38	f	0101000020E6100000CF37A27BD63152C0C79DD2C1FAE94440
266	7	2008-02-07 04:54:38	2008-02-07 04:56:38	f	0101000020E6100000CF37A27BD63152C0A4C7EF6DFAE94440
267	7	2008-02-07 04:59:38	2008-02-07 05:01:38	t	0101000020E610000032957EC2D93152C056BC9179E4E94440
268	7	2008-02-07 05:04:38	2008-02-07 05:06:38	f	0101000020E6100000C4F17C06D43152C01D9430D3F6E94440
269	7	2008-02-07 05:09:38	2008-02-07 05:11:38	f	0101000020E6100000F9325184D43152C08E3BA583F5E94440
270	7	2008-02-07 05:14:38	2008-02-07 05:16:38	t	0101000020E61000001D0934D8D43152C08E3BA583F5E94440
271	7	2008-02-07 05:14:38	2008-02-07 05:16:38	t	0101000020E61000001D0934D8D43152C08E3BA583F5E94440
272	7	2008-02-07 05:19:38	2008-02-07 05:21:38	t	0101000020E61000002F742502D53152C024B9FC87F4E94440
273	7	2008-02-07 05:24:38	2008-02-07 05:26:38	t	0101000020E610000040DF162CD53152C000E31934F4E94440
274	7	2008-02-07 05:29:38	2008-02-07 05:31:38	t	0101000020E6100000524A0856D53152C000E31934F4E94440
275	7	2008-02-07 05:34:38	2008-02-07 05:36:38	f	0101000020E610000064B5F97FD53152C024B9FC87F4E94440
276	7	2008-02-07 05:39:38	2008-02-07 05:41:38	t	0101000020E610000064B5F97FD53152C024B9FC87F4E94440
277	7	2008-02-07 05:44:38	2008-02-07 05:46:38	f	0101000020E61000008BAC3594DA3152C0DD0C37E0F3E94440
278	7	2008-02-07 05:49:38	2008-02-07 05:51:38	f	0101000020E6100000FD53AA44D93152C0478FDFDBF4E94440
279	7	2008-02-07 05:54:38	2008-02-07 05:56:38	f	0101000020E6100000202A8D98D93152C024B9FC87F4E94440
280	7	2008-02-07 05:59:38	2008-02-07 06:01:38	f	0101000020E6100000440070ECD93152C000E31934F4E94440
281	7	2008-02-07 06:04:38	2008-02-07 06:06:38	f	0101000020E61000009D1727BEDA3152C0D6E76A2BF6E94440
282	7	2008-02-07 06:09:38	2008-02-07 06:11:38	t	0101000020E610000032957EC2D93152C00708E6E8F1E94440
283	7	2008-02-07 06:14:38	2008-02-07 06:16:38	f	0101000020E61000008066101FD83152C0ABCFD556ECE94440
284	7	2008-02-07 06:19:38	2008-02-07 06:21:38	t	0101000020E61000009D1727BEDA3152C039454772F9E94440
285	7	2008-02-07 06:24:38	2008-02-07 06:26:38	f	0101000020E6100000202A8D98D93152C0DD0C37E0F3E94440
286	7	2008-02-07 06:29:38	2008-02-07 06:31:38	t	0101000020E6100000FD53AA44D93152C02BDEC83CF2E94440
287	7	2008-02-07 06:34:38	2008-02-07 06:36:38	t	0101000020E61000000B9E42AED43152C0A4703D0AD7E94440
288	7	2008-02-07 06:39:38	2008-02-07 06:41:38	f	0101000020E610000032957EC2D93152C0ABECBB22F8E94440
289	7	2008-02-07 06:44:38	2008-02-07 06:46:38	t	0101000020E6100000440070ECD93152C0ABECBB22F8E94440
290	7	2008-02-07 06:49:38	2008-02-07 06:51:38	t	0101000020E610000032957EC2D93152C08716D9CEF7E94440
291	7	2008-02-07 06:54:38	2008-02-07 06:56:38	f	0101000020E6100000202A8D98D93152C06440F67AF7E94440
292	7	2008-02-07 06:59:38	2008-02-07 07:01:38	t	0101000020E61000000FBF9B6ED93152C06440F67AF7E94440
293	7	2008-02-07 07:04:38	2008-02-07 07:06:38	t	0101000020E6100000FD53AA44D93152C06440F67AF7E94440
294	7	2008-02-07 07:09:38	2008-02-07 07:11:38	t	0101000020E6100000FD53AA44D93152C06440F67AF7E94440
295	7	2008-02-07 07:14:38	2008-02-07 07:16:38	t	0101000020E6100000FD53AA44D93152C0406A1327F7E94440
296	7	2008-02-07 07:19:38	2008-02-07 07:21:38	t	0101000020E61000000FBF9B6ED93152C06440F67AF7E94440
297	7	2008-02-07 07:24:38	2008-02-07 07:26:38	t	0101000020E6100000FD53AA44D93152C0406A1327F7E94440
298	7	2008-02-07 07:39:38	2008-02-07 07:41:38	f	0101000020E6100000EBE8B81AD93152C08E3BA583F5E94440
299	7	2008-02-07 07:39:38	2008-02-07 07:41:38	t	0101000020E6100000EBE8B81AD93152C08E3BA583F5E94440
300	7	2008-02-07 07:44:38	2008-02-07 07:46:38	t	0101000020E6100000D97DC7F0D83152C06B65C22FF5E94440
301	8	2008-02-06 12:14:50	2008-02-06 12:16:50	f	0101000020E6100000EDC1A4F8F82A52C047E6913F18E64440
302	8	2008-02-06 12:14:50	2008-02-06 12:16:50	f	0101000020E6100000EDC1A4F8F82A52C047E6913F18E64440
303	8	2008-02-06 12:24:50	2008-02-06 12:26:50	f	0101000020E6100000E11115AA9B2D52C08AC8B08A37E04440
304	8	2008-02-06 12:34:50	2008-02-06 12:36:50	f	0101000020E61000008EB5BFB33D2E52C0404D2D5BEBDD4440
305	8	2008-02-06 12:40:08	2008-02-06 12:42:08	f	0101000020E6100000C5EC65DB692F52C08BA6B393C1DB4440
306	8	2008-02-06 12:50:08	2008-02-06 12:52:08	t	0101000020E6100000A1504F1F813152C0E1EEACDD76DB4440
307	8	2008-02-06 12:52:28	2008-02-06 12:54:28	f	0101000020E6100000360873BB973152C05A47551344DB4440
308	8	2008-02-06 13:02:28	2008-02-06 13:04:28	f	0101000020E61000002A75C938463252C0E50F069E7BDD4440
309	8	2008-02-06 13:12:28	2008-02-06 13:14:28	f	0101000020E6100000DE257156443552C00E32C9C859DE4440
310	8	2008-02-06 13:22:28	2008-02-06 13:24:28	f	0101000020E6100000CBC4AD82183852C0A3CC069964DE4440
311	8	2008-02-06 13:22:28	2008-02-06 13:24:28	t	0101000020E6100000CBC4AD82183852C0A3CC069964DE4440
312	8	2008-02-06 13:23:20	2008-02-06 13:25:20	t	0101000020E610000091B932A8363852C0871BF0F961DE4440
313	8	2008-02-06 13:32:34	2008-02-06 13:34:34	t	0101000020E6100000DD0DA2B5A23952C08481E7DEC3DF4440
314	8	2008-02-06 13:40:07	2008-02-06 13:42:07	t	0101000020E61000008C506C054D3952C0CFF753E3A5DD4440
315	8	2008-02-06 13:50:08	2008-02-06 13:52:08	t	0101000020E6100000B30DDC813A3B52C097395D1613E54440
316	8	2008-02-06 13:50:14	2008-02-06 13:52:14	t	0101000020E6100000B30DDC813A3B52C0DEE522BE13E54440
317	8	2008-02-06 14:00:13	2008-02-06 14:02:13	t	0101000020E610000055E41071733A52C04772F90FE9E14440
318	8	2008-02-06 14:09:28	2008-02-06 14:11:28	f	0101000020E6100000B3D826158D3952C0CAE0287975DC4440
319	8	2008-02-06 14:16:07	2008-02-06 14:18:07	f	0101000020E6100000E758DE550F3852C09EB5DB2E34DD4440
320	8	2008-02-06 14:27:14	2008-02-06 14:29:14	f	0101000020E610000018B83CD68C3452C0F8AA9509BFDE4440
321	8	2008-02-06 14:30:44	2008-02-06 14:32:44	t	0101000020E6100000F5C473B6803452C0B11BB62DCADE4440
322	8	2008-02-06 14:37:13	2008-02-06 14:39:13	f	0101000020E6100000948D075BEC3252C008AC1C5A64DD4440
323	8	2008-02-06 14:47:08	2008-02-06 14:49:08	f	0101000020E6100000A762635E473252C0E99AC937DBDA4440
324	8	2008-02-06 14:57:08	2008-02-06 14:59:08	f	0101000020E6100000D46BB3B1123552C097E2AAB2EFD84440
325	8	2008-02-06 15:03:40	2008-02-06 15:05:40	f	0101000020E6100000BEC282FB013552C079E9263108D64440
326	8	2008-02-06 15:13:39	2008-02-06 15:15:39	f	0101000020E6100000B078EA91063552C0533F6F2A52D74440
327	8	2008-02-06 15:13:39	2008-02-06 15:15:39	t	0101000020E6100000B078EA91063552C0533F6F2A52D74440
328	8	2008-02-06 15:22:43	2008-02-06 15:24:43	t	0101000020E61000006BDAC534D33352C002486DE2E4D84440
329	8	2008-02-06 15:32:43	2008-02-06 15:34:43	t	0101000020E610000039BF61A2413252C0085A8121ABD94440
330	8	2008-02-06 15:42:43	2008-02-06 15:44:43	t	0101000020E610000072CADC7C233652C09374CDE49BD74440
331	8	2008-02-06 15:42:43	2008-02-06 15:44:43	f	0101000020E610000072CADC7C233652C09374CDE49BD74440
332	8	2008-02-06 15:52:43	2008-02-06 15:54:43	t	0101000020E6100000BFBD6BD0973852C02EAD86C43DD44440
333	8	2008-02-06 15:53:06	2008-02-06 15:55:06	t	0101000020E6100000BFBD6BD0973852C0C32ADEC83CD44440
334	8	2008-02-06 16:03:06	2008-02-06 16:05:06	f	0101000020E6100000A9DF85ADD93852C0664E97C5C4D84440
335	8	2008-02-06 16:06:52	2008-02-06 16:08:52	t	0101000020E6100000CF37A27BD63752C0FBCBEEC9C3D84440
336	8	2008-02-06 16:06:52	2008-02-06 16:08:52	t	0101000020E6100000CF37A27BD63752C0FBCBEEC9C3D84440
337	8	2008-02-06 16:15:24	2008-02-06 16:17:24	t	0101000020E6100000A9A5B915C23652C000AE64C746D64440
338	8	2008-02-06 16:25:24	2008-02-06 16:27:24	f	0101000020E61000006A19A9F7543652C059FAD005F5D74440
339	8	2008-02-06 16:35:24	2008-02-06 16:37:24	f	0101000020E6100000D1402C9B393652C058E71890BDD84440
340	8	2008-02-06 16:45:24	2008-02-06 16:47:24	f	0101000020E610000094C7D3F2033552C0C095ECD808D64440
341	8	2008-02-06 16:45:24	2008-02-06 16:47:24	f	0101000020E610000094C7D3F2033552C0C095ECD808D64440
342	8	2008-02-06 16:47:13	2008-02-06 16:49:13	t	0101000020E61000008981AE7D013552C001529B38B9D54440
343	8	2008-02-06 17:00:09	2008-02-06 17:02:09	f	0101000020E6100000E51071732A3952C0481B47ACC5D54440
344	8	2008-02-06 17:10:09	2008-02-06 17:12:09	t	0101000020E6100000441D56B8E53952C043AD69DE71D84440
345	8	2008-02-06 17:12:23	2008-02-06 17:14:23	t	0101000020E6100000A0724C16F73952C0AAB706B64ADA4440
346	8	2008-02-06 17:31:20	2008-02-06 17:33:20	t	0101000020E6100000610322C4953952C0EDD808C4EBD84440
347	8	2008-02-06 17:32:56	2008-02-06 17:34:56	f	0101000020E6100000F37C06D49B3952C0D00A0C59DDD84440
348	8	2008-02-06 17:42:56	2008-02-06 17:44:56	t	0101000020E6100000E7E95C514A3652C0ADFA5C6DC5D84440
349	8	2008-02-06 17:52:57	2008-02-06 17:54:57	f	0101000020E610000010EF39B01C3352C049F4328AE5D84440
350	9	2008-02-06 14:53:29	2008-02-06 14:55:29	f	0101000020E61000000344C18C293252C0D812F241CFD44440
351	9	2008-02-06 14:58:31	2008-02-06 15:00:31	f	0101000020E61000001CBCAFCA853052C059C0046EDDD34440
352	9	2008-02-06 15:03:33	2008-02-06 15:05:33	f	0101000020E61000002125766D6F2F52C0DBE1AFC91AD34440
353	9	2008-02-06 15:08:35	2008-02-06 15:10:35	t	0101000020E61000002997C62FBC3052C0BF0E9C33A2D24440
354	9	2008-02-06 15:13:36	2008-02-06 15:15:36	t	0101000020E61000006B4E5E64023252C071033E3F8CD24440
355	9	2008-02-06 15:13:36	2008-02-06 15:15:36	f	0101000020E61000006B4E5E64023252C071033E3F8CD24440
356	9	2008-02-06 15:23:39	2008-02-06 15:25:39	t	0101000020E61000009C73F04C683252C08FAA2688BACD4440
357	9	2008-02-06 15:28:41	2008-02-06 15:30:41	f	0101000020E6100000B4942C27A13252C0257A19C572CD4440
358	9	2008-02-06 15:33:42	2008-02-06 15:35:42	t	0101000020E6100000AABD88B6633252C0651EF98381CD4440
359	9	2008-02-06 15:38:44	2008-02-06 15:40:44	f	0101000020E61000003F58C6866E3252C006A3923A01CF4440
360	9	2008-02-06 15:43:46	2008-02-06 15:45:46	t	0101000020E6100000A81E69705B3352C058E71890BDD04440
361	9	2008-02-06 15:48:48	2008-02-06 15:50:48	f	0101000020E6100000738BF9B9A13552C07BA52C431CD14440
362	9	2008-02-06 15:53:50	2008-02-06 15:55:50	t	0101000020E6100000079FE6E4453652C06DAD2F12DAD04440
363	9	2008-02-06 15:58:51	2008-02-06 16:00:51	t	0101000020E6100000738BF9B9A13552C058AD4CF8A5D04440
364	9	2008-02-06 16:08:55	2008-02-06 16:10:55	f	0101000020E6100000738BF9B9A13552C017F19D98F5D04440
365	9	2008-02-06 16:13:57	2008-02-06 16:15:57	t	0101000020E610000056DAE21A9F3552C0E757738060D04440
366	9	2008-02-06 16:18:59	2008-02-06 16:20:59	f	0101000020E6100000CC9D9960383552C0AFCE31207BCF4440
367	9	2008-02-06 16:24:00	2008-02-06 16:26:00	f	0101000020E610000081D591239D3552C0EE5F596952D04440
368	9	2008-02-06 16:29:02	2008-02-06 16:31:02	f	0101000020E6100000DD990986733752C0587380608ED04440
369	9	2008-02-06 16:34:04	2008-02-06 16:36:04	f	0101000020E6100000C5E74EB0FF3A52C035B56CAD2FD04440
370	9	2008-02-06 16:39:06	2008-02-06 16:41:06	f	0101000020E6100000C044BC75FE3B52C063B48EAA26D24440
371	9	2008-02-06 16:44:08	2008-02-06 16:46:08	f	0101000020E6100000D197DEFE5C3C52C052616C21C8D34440
372	9	2008-02-06 16:49:09	2008-02-06 16:51:09	f	0101000020E61000009054DFF9453B52C04E2844C021D24440
373	9	2008-02-06 16:54:11	2008-02-06 16:56:11	t	0101000020E6100000EE7DAA0A0D3A52C04772F90FE9D14440
374	9	2008-02-06 16:59:13	2008-02-06 17:01:13	f	0101000020E61000000214234BE63A52C0FA2CCF83BBD14440
375	9	2008-02-06 17:04:15	2008-02-06 17:06:15	t	0101000020E61000009D6ED921FE3B52C095826E2F69D24440
376	10	2008-02-03 13:01:29	2008-02-03 13:03:29	t	0101000020E61000009D2FF65E7C3752C09981CAF8F7DB4440
377	10	2008-02-03 13:05:49	2008-02-03 13:07:49	t	0101000020E61000000E8AE6012C3852C0AA9F3715A9DA4440
378	10	2008-02-03 13:06:31	2008-02-03 13:08:31	f	0101000020E61000000E6D0036203852C0721B0DE02DDA4440
379	10	2008-02-03 13:10:50	2008-02-03 13:12:50	t	0101000020E61000001CF16437333852C05804FF5BC9D84440
380	10	2008-02-03 13:11:32	2008-02-03 13:13:32	t	0101000020E6100000F58AA71E693852C0C286A757CAD84440
381	10	2008-02-03 13:15:52	2008-02-03 13:17:52	f	0101000020E610000030A4C343183952C0F6622827DAD74440
382	10	2008-02-03 13:43:57	2008-02-03 13:45:57	t	0101000020E6100000F4E159828C3A52C07C9BFEEC47D04440
383	10	2008-02-03 13:47:05	2008-02-03 13:49:05	t	0101000020E6100000D44ECDE5063B52C07BA52C431CD14440
384	10	2008-02-03 13:48:58	2008-02-03 13:50:58	f	0101000020E6100000C26F438CD73A52C0209DBAF259D04440
385	10	2008-02-03 13:52:07	2008-02-03 13:54:07	f	0101000020E610000082E84999D43A52C08B6CE7FBA9CF4440
386	10	2008-02-03 13:54:00	2008-02-03 13:56:00	f	0101000020E6100000DBFF006BD53A52C01B2FDD2406CF4440
387	10	2008-02-03 13:57:08	2008-02-03 13:59:08	f	0101000020E610000006871744A43A52C0E50AEF7211CD4440
388	10	2008-02-03 13:59:02	2008-02-03 14:01:02	f	0101000020E61000000349D8B7933A52C043CA4FAA7DCC4440
389	10	2008-02-03 14:02:10	2008-02-03 14:04:10	t	0101000020E6100000D527B9C3263A52C0BBD573D2FBCC4440
390	10	2008-02-03 14:04:03	2008-02-03 14:06:03	f	0101000020E61000000A698D41273A52C0A5660FB402CD4440
391	10	2008-02-03 14:07:12	2008-02-03 14:09:12	t	0101000020E61000000A698D41273A52C0A5660FB402CD4440
392	10	2008-02-03 14:12:13	2008-02-03 14:14:13	f	0101000020E61000000A698D41273A52C0A5660FB402CD4440
393	10	2008-02-03 14:14:07	2008-02-03 14:16:07	t	0101000020E61000000A698D41273A52C0A5660FB402CD4440
394	10	2008-02-03 14:17:15	2008-02-03 14:19:15	t	0101000020E6100000C88157CB9D3952C07BC2120F28CD4440
395	10	2008-02-03 14:19:08	2008-02-03 14:21:08	t	0101000020E61000004DE141B3EB3852C091B8C7D287CC4440
396	10	2008-02-03 14:24:10	2008-02-03 14:26:10	t	0101000020E6100000242E008DD23952C0D00F238447CD4440
397	10	2008-02-03 14:27:18	2008-02-03 14:29:18	f	0101000020E6100000278E3C10593A52C0FBB31F2922CD4440
398	10	2008-02-03 14:29:12	2008-02-03 14:31:12	t	0101000020E61000009015FC36C43A52C08716D9CEF7CD4440
399	10	2008-02-03 14:29:12	2008-02-03 14:31:12	t	0101000020E61000009015FC36C43A52C08716D9CEF7CD4440
400	10	2008-02-03 14:32:20	2008-02-03 14:34:20	t	0101000020E6100000568847E2E53952C0A08EC70C54D04440
401	10	2008-02-03 14:37:22	2008-02-03 14:39:22	f	0101000020E6100000DBE21A9FC93652C066BD18CA89D04440
402	10	2008-02-03 14:39:15	2008-02-03 14:41:15	t	0101000020E6100000B785E7A5623552C09F93DE37BED04440
403	10	2008-02-03 14:42:23	2008-02-03 14:44:23	f	0101000020E610000082053065E03252C090F7AA9509D14440
404	10	2008-02-03 14:44:17	2008-02-03 14:46:17	t	0101000020E6100000286728EE783152C0C2DD59BBEDD04440
405	10	2008-02-03 14:47:24	2008-02-03 14:49:24	t	0101000020E6100000310E2E1D733052C0BF823463D1D24440
406	10	2008-02-03 14:49:17	2008-02-03 14:51:17	t	0101000020E61000000D03965CC53052C011C7BAB88DD44440
407	10	2008-02-03 14:52:26	2008-02-03 14:54:26	f	0101000020E61000006828EE78933152C098512CB7B4D44440
408	10	2008-02-03 14:54:19	2008-02-03 14:56:19	t	0101000020E6100000479561DC0D3252C0D812F241CFD44440
409	10	2008-02-03 14:59:21	2008-02-03 15:01:21	t	0101000020E6100000F724B039073152C074982F2FC0D44440
410	10	2008-02-03 15:02:29	2008-02-03 15:04:29	f	0101000020E61000008981AE7D013152C0A04FE449D2D34440
411	10	2008-02-03 15:04:22	2008-02-03 15:06:22	t	0101000020E610000016191D90843152C03DF20703CFD34440
412	10	2008-02-03 15:07:31	2008-02-03 15:09:31	t	0101000020E61000002A7AE063B03252C0DA5A5F24B4D34440
413	10	2008-02-03 15:09:24	2008-02-03 15:11:24	t	0101000020E6100000339067976F3352C021938C9C85D34440
414	10	2008-02-03 15:12:32	2008-02-03 15:14:32	f	0101000020E61000007C67B455493452C02927DA5548D34440
415	10	2008-02-03 15:38:37	2008-02-03 15:40:37	t	0101000020E6100000EAD500A5A13652C0836E2F698CD04440
416	10	2008-02-03 15:41:46	2008-02-03 15:43:46	f	0101000020E6100000687FA0DCB63752C0836E2F698CD04440
417	10	2008-02-03 15:43:38	2008-02-03 15:45:38	f	0101000020E6100000DF3829CC7B3852C0DF89592F86D04440
418	10	2008-02-03 15:46:48	2008-02-03 15:48:48	t	0101000020E6100000E3546B61163A52C00ABFD4CF9BD04440
419	10	2008-02-03 15:48:40	2008-02-03 15:50:40	t	0101000020E610000012548D5E0D3A52C0BBF2599E07D14440
420	10	2008-02-03 15:51:49	2008-02-03 15:53:49	t	0101000020E610000012548D5E0D3A52C0BBF2599E07D14440
421	11	2008-02-06 15:37:06	2008-02-06 15:39:06	f	0101000020E610000084DE1B43003652C0B003E78C28DB4440
422	11	2008-02-06 15:38:13	2008-02-06 15:40:13	f	0101000020E610000000581D39D23552C0CEE49B6D6EDA4440
423	11	2008-02-06 15:42:08	2008-02-06 15:44:08	f	0101000020E6100000408D7BF31B3652C08EE9094B3CD64440
424	11	2008-02-06 15:43:15	2008-02-06 15:45:15	f	0101000020E61000008739419B1C3652C03B014D840DD54440
425	11	2008-02-06 15:47:10	2008-02-06 15:49:10	t	0101000020E61000005F81E849993652C0C8073D9B55D14440
426	11	2008-02-06 15:48:16	2008-02-06 15:50:16	f	0101000020E6100000515436ACA93652C06EA301BC05D04440
427	11	2008-02-06 15:52:11	2008-02-06 15:54:11	f	0101000020E61000004FB51666A13552C03815A930B6CE4440
428	11	2008-02-06 15:53:18	2008-02-06 15:55:18	t	0101000020E6100000E415889E943552C0EA04341136CE4440
429	11	2008-02-06 15:57:13	2008-02-06 15:59:13	f	0101000020E610000037035C902D3552C048FE60E0B9CD4440
430	11	2008-02-06 15:57:13	2008-02-06 15:59:13	f	0101000020E610000037035C902D3552C048FE60E0B9CD4440
431	11	2008-02-06 16:02:15	2008-02-06 16:04:15	f	0101000020E610000066A6B4FE963452C01C5F7B6649CE4440
432	11	2008-02-06 16:03:21	2008-02-06 16:05:21	t	0101000020E61000000D207C28D13452C0C7681D554DCE4440
433	11	2008-02-06 16:07:16	2008-02-06 16:09:16	f	0101000020E610000015CC9882353452C0DBE1AFC91ACF4440
434	11	2008-02-06 16:08:23	2008-02-06 16:10:23	f	0101000020E61000008A7780272D3452C0F7CC920035CF4440
435	11	2008-02-06 16:12:18	2008-02-06 16:14:18	f	0101000020E610000055DFF945093452C01E5036E50AD14440
436	11	2008-02-06 16:13:25	2008-02-06 16:15:25	f	0101000020E61000006DCB80B3943452C02D431CEBE2D04440
437	11	2008-02-06 16:17:20	2008-02-06 16:19:20	t	0101000020E61000001653E9279C3552C0A779C7293AD04440
438	11	2008-02-06 16:18:26	2008-02-06 16:20:26	t	0101000020E61000004B94BDA59C3552C06E179AEB34D04440
439	11	2008-02-06 16:22:21	2008-02-06 16:24:21	f	0101000020E610000064247B849A3552C00A11700855D04440
440	11	2008-02-06 16:28:23	2008-02-06 16:30:23	f	0101000020E6100000BEA59C2FF63452C081CF0F2384D14440
441	11	2008-02-06 16:36:31	2008-02-06 16:38:31	t	0101000020E6100000BDAFCA85CA3352C01C08C90226D24440
442	11	2008-02-06 16:37:37	2008-02-06 16:39:37	t	0101000020E61000004131B2648E3352C0A33B889D29D24440
443	11	2008-02-06 16:46:34	2008-02-06 16:48:34	f	0101000020E6100000DA78B0C56E3352C0BF9F1A2FDDD24440
444	11	2008-02-06 16:51:36	2008-02-06 16:53:36	f	0101000020E6100000043FAA61BF3352C0857CD0B359D34440
445	11	2008-02-06 16:52:42	2008-02-06 16:54:42	f	0101000020E61000006CB8C83D5D3352C08C15359886D34440
446	11	2008-02-06 16:56:37	2008-02-06 16:58:37	f	0101000020E61000009228B4ACFB3352C0FB912232ACD44440
447	11	2008-02-06 16:57:44	2008-02-06 16:59:44	f	0101000020E6100000558D5E0D503452C083A8FB00A4D44440
448	11	2008-02-06 17:01:39	2008-02-06 17:03:39	f	0101000020E61000006A19A9F7543452C0EF5A423EE8D34440
449	11	2008-02-06 17:02:46	2008-02-06 17:04:46	f	0101000020E61000001102F225543452C00CEA5BE674D34440
450	11	2008-02-06 17:06:41	2008-02-06 17:08:41	f	0101000020E6100000BC97FBE4283452C023F8DF4A76D24440
451	12	2008-02-07 15:22:42	2008-02-07 15:24:42	f	0101000020E61000007AABAE43353952C0DA20938C9CE34440
452	12	2008-02-07 15:23:56	2008-02-07 15:25:56	t	0101000020E6100000D622A298BC3752C0AE9E93DE37E44440
453	12	2008-02-07 15:26:27	2008-02-07 15:28:27	f	0101000020E61000000EDC813AE53552C04CFDBCA948E34440
454	12	2008-02-07 15:27:44	2008-02-07 15:29:44	f	0101000020E6100000DD990986733552C05C72DC291DE24440
455	12	2008-02-07 15:28:58	2008-02-07 15:30:58	t	0101000020E610000025986A662D3552C0C190D5AD9EE14440
456	13	2008-02-02 17:35:29	2008-02-02 17:37:29	t	0101000020E61000000FD76A0F7B3752C0F12E17F19DE24440
457	13	2008-02-02 17:36:21	2008-02-02 17:38:21	f	0101000020E6100000AC798EC8773752C05CB1BFEC9EE24440
458	13	2008-02-02 17:36:24	2008-02-02 17:38:24	t	0101000020E6100000A1336953753752C038DBDC989EE24440
459	13	2008-02-02 17:36:27	2008-02-02 17:38:27	t	0101000020E610000061AC6F60723752C0462575029AE24440
460	13	2008-02-02 17:36:40	2008-02-02 17:38:40	f	0101000020E610000045DE72F5633752C023DBF97E6AE24440
461	13	2008-02-02 17:38:01	2008-02-02 17:40:01	f	0101000020E61000007E23BA675D3752C06CB2463D44E14440
462	13	2008-02-02 17:38:04	2008-02-02 17:40:04	t	0101000020E61000002F52280B5F3752C009556AF640E14440
463	13	2008-02-02 17:38:15	2008-02-02 17:40:15	t	0101000020E6100000BAA64066673752C07ADFF8DA33E14440
464	13	2008-02-02 17:39:04	2008-02-02 17:41:04	t	0101000020E61000003694DA8B683752C0105D50DF32E14440
465	13	2008-02-02 17:40:36	2008-02-02 17:42:36	t	0101000020E6100000BA37BF61A22F52C0E3E47E87A2D64440
466	13	2008-02-02 17:40:36	2008-02-02 17:42:36	t	0101000020E6100000BA37BF61A22F52C0E3E47E87A2D64440
467	13	2008-02-02 17:40:36	2008-02-02 17:42:36	t	0101000020E6100000BA37BF61A22F52C0E3E47E87A2D64440
468	13	2008-02-02 17:41:11	2008-02-02 17:43:11	f	0101000020E61000001D959BA8A53752C06D904946CEE04440
469	13	2008-02-02 17:41:15	2008-02-02 17:43:15	t	0101000020E6100000BD581822A73752C0914946CEC2E04440
470	13	2008-02-02 17:42:45	2008-02-02 17:44:45	f	0101000020E6100000080951BEA03752C01FD7868A71E04440
471	13	2008-02-02 17:42:48	2008-02-02 17:44:48	t	0101000020E610000061200890A13752C0917EFB3A70E04440
472	13	2008-02-02 17:42:52	2008-02-02 17:44:52	t	0101000020E61000002BDF3312A13752C02E211FF46CE04440
473	13	2008-02-02 17:45:55	2008-02-02 17:47:55	t	0101000020E6100000080951BEA03752C0EFC9C342ADDF4440
474	13	2008-02-02 17:46:34	2008-02-02 17:48:34	f	0101000020E6100000B9C83D5DDD3752C05A2F8672A2DF4440
475	13	2008-02-02 17:46:41	2008-02-02 17:48:41	f	0101000020E61000004F469561DC3752C0FDF675E09CDF4440
476	13	2008-02-02 17:47:17	2008-02-02 17:49:17	f	0101000020E6100000202A8D98D93752C076C3B64599DF4440
477	13	2008-02-02 17:47:20	2008-02-02 17:49:20	t	0101000020E610000039BA4A77D73752C076C3B64599DF4440
478	13	2008-02-02 17:47:59	2008-02-02 17:49:59	t	0101000020E6100000FDC22B499E3752C0363CBD5296DF4440
479	13	2008-02-02 17:48:02	2008-02-02 17:50:02	f	0101000020E6100000A4AB74779D3752C0FDD98F1491DF4440
480	13	2008-02-02 17:48:14	2008-02-02 17:50:14	f	0101000020E610000021990E9D9E3752C0A86F99D365DF4440
481	13	2008-02-02 17:48:17	2008-02-02 17:50:17	t	0101000020E6100000AFF199EC9F3752C061A6ED5F59DF4440
482	13	2008-02-02 17:48:25	2008-02-02 17:50:25	f	0101000020E6100000080951BEA03752C0F7E978CC40DF4440
483	13	2008-02-02 17:48:44	2008-02-02 17:50:44	f	0101000020E61000004FB51666A13752C0B7627FD93DDF4440
484	13	2008-02-02 17:50:03	2008-02-02 17:52:03	f	0101000020E6100000F37C06D49B3752C00664AF777FDE4440
485	13	2008-02-02 17:53:21	2008-02-02 17:55:21	t	0101000020E610000093239D81913752C0F3599E0777DD4440
486	13	2008-02-02 17:54:01	2008-02-02 17:56:01	t	0101000020E6100000C86471FF913752C0DE76A1B94EDD4440
487	13	2008-02-02 17:54:04	2008-02-02 17:56:04	t	0101000020E61000009D69C2F6933752C0501E166A4DDD4440
488	13	2008-02-02 17:56:10	2008-02-02 17:58:10	f	0101000020E6100000B8EA3A54533852C0DE3CD52137DD4440
489	13	2008-02-02 17:56:20	2008-02-02 17:58:20	f	0101000020E610000063F4DC42573852C073BA2C2636DD4440
490	13	2008-02-02 17:56:43	2008-02-02 17:58:43	f	0101000020E61000008E0C7217613852C07ADFF8DA33DD4440
491	13	2008-02-02 17:56:43	2008-02-02 17:58:43	t	0101000020E61000008E0C7217613852C07ADFF8DA33DD4440
492	13	2008-02-02 17:57:22	2008-02-02 17:59:22	t	0101000020E6100000DF3829CC7B3852C03B3B191C25DD4440
493	13	2008-02-02 17:58:23	2008-02-02 18:00:23	f	0101000020E6100000462BF702B33852C026581CCEFCDC4440
494	13	2008-02-02 18:01:02	2008-02-02 18:03:02	f	0101000020E610000034A83638113952C05F0CE544BBDC4440
495	13	2008-02-02 18:01:33	2008-02-02 18:03:33	t	0101000020E61000004C72C0AE263952C02DB29DEFA7DC4440
496	13	2008-02-02 18:01:33	2008-02-02 18:03:33	t	0101000020E61000004C72C0AE263952C02DB29DEFA7DC4440
497	13	2008-02-02 18:01:42	2008-02-02 18:03:42	t	0101000020E61000002CBD361B2B3952C0B4C876BE9FDC4440
498	13	2008-02-02 18:02:36	2008-02-02 18:04:36	t	0101000020E610000033FFE89B343952C0C3D8429083DC4440
499	13	2008-02-02 18:02:48	2008-02-02 18:04:48	f	0101000020E610000009043A93363952C0D105F52D73DC4440
500	13	2008-02-02 18:03:11	2008-02-02 18:05:11	f	0101000020E6100000B0EC82C1353952C09886E12362DC4440
501	13	2008-02-02 18:03:35	2008-02-02 18:05:35	f	0101000020E610000029B9C326323952C0D9D30E7F4DDC4440
502	13	2008-02-02 18:04:39	2008-02-02 18:06:39	t	0101000020E6100000227711A6283952C0124E0B5EF4DB4440
503	13	2008-02-02 18:05:27	2008-02-02 18:07:27	t	0101000020E61000004C72C0AE263952C0C442AD69DEDB4440
504	13	2008-02-02 18:05:45	2008-02-02 18:07:45	f	0101000020E6100000E2EF17B3253952C0D26F5F07CEDB4440
505	13	2008-02-02 18:06:51	2008-02-02 18:08:51	f	0101000020E6100000F35A09DD253952C07D3F355EBADB4440
506	13	2008-02-02 18:07:09	2008-02-02 18:09:09	f	0101000020E6100000E2EF17B3253952C021EA3E00A9DB4440
507	13	2008-02-02 18:09:10	2008-02-02 18:11:10	t	0101000020E6100000DECEBEF2203952C00612143FC6DA4440
508	13	2008-02-02 18:23:22	2008-02-02 18:25:22	f	0101000020E6100000507633A31F3952C0310DC347C4DA4440
509	13	2008-02-02 18:23:37	2008-02-02 18:25:37	f	0101000020E6100000C21DA8531E3952C0B1E1E995B2DA4440
510	13	2008-02-02 18:23:59	2008-02-02 18:25:59	t	0101000020E61000009E47C5FF1D3952C0BF0E9C33A2DA4440
511	13	2008-02-02 18:24:30	2008-02-02 18:26:30	f	0101000020E6100000DECEBEF2203952C0A35D85949FDA4440
512	13	2008-02-02 18:26:02	2008-02-02 18:28:02	f	0101000020E6100000DDF0BBE9963952C0B7627FD93DDB4440
513	13	2008-02-02 18:26:34	2008-02-02 18:28:34	f	0101000020E6100000929735B1C03952C07732384A5EDB4440
514	13	2008-02-02 18:27:23	2008-02-02 18:29:23	f	0101000020E610000056A52DAEF13952C02849D74CBEDB4440
515	13	2008-02-02 18:28:09	2008-02-02 18:30:09	t	0101000020E6100000DC12B9E00C3A52C06E3480B740DC4440
516	13	2008-02-02 18:28:12	2008-02-02 18:30:12	f	0101000020E6100000F5A276BF0A3A52C035EF384547DC4440
517	13	2008-02-02 18:28:15	2008-02-02 18:30:15	t	0101000020E6100000392EE3A6063A52C0E71DA7E848DC4440
518	13	2008-02-02 18:28:18	2008-02-02 18:30:18	t	0101000020E610000059E36C3A023A52C060EAE74D45DC4440
519	13	2008-02-02 18:28:26	2008-02-02 18:30:26	f	0101000020E610000080BDC282FB3952C0A75CE15D2EDC4440
520	13	2008-02-02 18:28:29	2008-02-02 18:30:29	t	0101000020E6100000B5FE9600FC3952C092D0967329DC4440
521	13	2008-02-02 18:29:31	2008-02-02 18:31:31	t	0101000020E6100000EE48F59D5F3A52C0042159C004DC4440
522	13	2008-02-02 18:29:40	2008-02-02 18:31:40	f	0101000020E610000026AB22DC643A52C0999EB0C403DC4440
523	13	2008-02-02 18:30:29	2008-02-02 18:32:29	f	0101000020E6100000F8AB00DF6D3A52C0E76F422102DC4440
524	13	2008-02-02 18:30:29	2008-02-02 18:32:29	f	0101000020E6100000F8AB00DF6D3A52C0E76F422102DC4440
525	13	2008-02-02 18:30:43	2008-02-02 18:32:43	f	0101000020E61000008A25E5EE733A52C03641D47D00DC4440
526	13	2008-02-02 18:31:18	2008-02-02 18:33:18	f	0101000020E61000005BB741EDB73A52C0D908C4EBFADB4440
527	13	2008-02-02 18:31:21	2008-02-02 18:33:21	t	0101000020E6100000B4CEF8BEB83A52C0841266DAFEDB4440
528	13	2008-02-02 18:31:45	2008-02-02 18:33:45	t	0101000020E610000034DDEBA4BE3A52C02063EE5A42DC4440
529	14	2008-02-03 14:36:36	2008-02-03 14:38:36	t	0101000020E610000066E08096AE3252C07F6ABC7493D64440
530	14	2008-02-03 14:41:36	2008-02-03 14:43:36	t	0101000020E610000018F2086EA43252C0546F0D6C95D64440
531	14	2008-02-03 14:46:36	2008-02-03 14:48:36	t	0101000020E6100000B11C2103793252C032207BBDFBD54440
532	14	2008-02-03 14:51:36	2008-02-03 14:53:36	f	0101000020E6100000FB40F2CEA13252C064AF777FBCD54440
533	14	2008-02-03 14:56:36	2008-02-03 14:58:36	t	0101000020E61000008D63247B843252C01D9430D3F6D54440
534	14	2008-02-03 15:01:36	2008-02-03 15:03:36	t	0101000020E61000004AF086342A3252C017D4B7CCE9D44440
535	14	2008-02-03 15:06:36	2008-02-03 15:08:36	t	0101000020E6100000778A5583303152C00AF9A067B3D44440
536	14	2008-02-03 15:11:36	2008-02-03 15:13:36	f	0101000020E61000009F996038D73052C0912749D74CD44440
537	14	2008-02-03 15:21:36	2008-02-03 15:23:36	t	0101000020E6100000642992AF043252C0F5673F5244D44440
538	14	2008-02-03 15:26:36	2008-02-03 15:28:36	f	0101000020E61000007998F6CDFD3152C0419FC893A4D14440
539	14	2008-02-03 15:31:36	2008-02-03 15:33:36	f	0101000020E6100000B82407EC6A3252C0850838842ACF4440
540	14	2008-02-03 15:36:36	2008-02-03 15:38:36	f	0101000020E610000008EC6AF2943352C0BE4D7FF623CF4440
541	14	2008-02-03 15:41:36	2008-02-03 15:43:36	f	0101000020E61000003985950A2A3452C0D200DE0209D04440
542	14	2008-02-03 15:41:36	2008-02-03 15:43:36	t	0101000020E61000003985950A2A3452C0D200DE0209D04440
543	14	2008-02-03 15:46:36	2008-02-03 15:48:36	t	0101000020E6100000A7457D923B3652C07C6649809AD04440
544	14	2008-02-03 15:51:36	2008-02-03 15:53:36	t	0101000020E61000001E90847D3B3752C08CA19C6857D34440
545	14	2008-02-03 15:56:36	2008-02-03 15:58:36	f	0101000020E6100000CEC82077113852C05AF5B9DA8AD34440
546	14	2008-02-03 16:01:36	2008-02-03 16:03:36	f	0101000020E6100000A0AC18AE0E3852C0AF08FEB792D34440
547	14	2008-02-03 16:06:36	2008-02-03 16:08:36	t	0101000020E610000024BF7E880D3852C0DA03ADC090D34440
548	14	2008-02-03 16:11:34	2008-02-03 16:13:34	f	0101000020E6100000197959130B3852C06F8104C58FD34440
549	14	2008-02-03 16:16:36	2008-02-03 16:18:36	t	0101000020E61000004EBA2D910B3852C09357E71890D34440
550	14	2008-02-03 16:21:36	2008-02-03 16:23:36	f	0101000020E610000075B169A5103852C03D61890794D34440
551	14	2008-02-03 16:26:36	2008-02-03 16:28:36	f	0101000020E610000027E0D748123852C06F8104C58FD34440
552	14	2008-02-03 16:31:36	2008-02-03 16:33:36	f	0101000020E6100000C482FB010F3852C0685C381092D34440
553	14	2008-02-03 16:41:36	2008-02-03 16:43:36	f	0101000020E610000054AF5B04C63652C0BD8C62B9A5D34440
554	14	2008-02-03 16:46:36	2008-02-03 16:48:36	f	0101000020E6100000BCEEAD484C3652C06440F67AF7D14440
555	14	2008-02-03 16:51:36	2008-02-03 16:53:36	t	0101000020E6100000D57E6B274A3652C001FBE8D495D14440
556	14	2008-02-03 16:56:36	2008-02-03 16:58:36	f	0101000020E6100000134F7633A33552C097CADB114ED14440
557	14	2008-02-03 17:01:36	2008-02-03 17:03:36	f	0101000020E610000084F6EAE3A13552C074EFE192E3D04440
558	14	2008-02-03 17:06:09	2008-02-03 17:08:09	f	0101000020E61000004FB51666A13552C0D8D825AAB7D04440
559	14	2008-02-03 17:06:30	2008-02-03 17:08:30	t	0101000020E61000004FB51666A13552C0D8D825AAB7D04440
560	14	2008-02-03 17:11:35	2008-02-03 17:13:35	f	0101000020E6100000790C8FFD2C3452C08BABCABE2BD04440
561	14	2008-02-03 17:16:35	2008-02-03 17:18:35	f	0101000020E6100000DC4C8578243452C0232D95B723D24440
562	14	2008-02-03 17:21:35	2008-02-03 17:23:35	f	0101000020E6100000FA6706F1813352C0DAC9E02879D34440
563	14	2008-02-03 17:26:35	2008-02-03 17:28:35	f	0101000020E6100000B959BC58183252C03DB83B6BB7D34440
564	14	2008-02-03 17:31:35	2008-02-03 17:33:35	f	0101000020E610000046B75ED3833052C00B293FA9F6D34440
565	14	2008-02-03 17:36:35	2008-02-03 17:38:35	t	0101000020E61000006C274A42223152C0992F2FC03ED84440
566	14	2008-02-03 17:41:35	2008-02-03 17:43:35	t	0101000020E610000071CFF3A78D3052C0C2DD59BBEDD84440
567	14	2008-02-03 17:51:35	2008-02-03 17:53:35	f	0101000020E610000045DE72F5632F52C006D847A7AED64440
568	14	2008-02-03 17:56:35	2008-02-03 17:58:35	t	0101000020E610000099309A95ED2F52C061C8EA56CFD34440
569	14	2008-02-03 18:06:35	2008-02-03 18:08:35	t	0101000020E6100000541EDD088B3252C0A12DE7525CD34440
570	14	2008-02-03 18:06:35	2008-02-03 18:08:35	t	0101000020E6100000541EDD088B3252C0A12DE7525CD34440
571	14	2008-02-03 18:11:35	2008-02-03 18:13:35	f	0101000020E61000006C9BE271513352C08D9C853DEDD24440
572	14	2008-02-03 18:16:35	2008-02-03 18:18:35	f	0101000020E61000008F76DCF0BB3352C0EBE74D452AD24440
573	14	2008-02-03 18:21:35	2008-02-03 18:23:35	f	0101000020E610000024111AC1C63352C0DC68006F81D24440
574	14	2008-02-03 18:26:35	2008-02-03 18:28:35	f	0101000020E6100000C00F0709513452C0E96514CB2DD34440
575	14	2008-02-03 18:31:35	2008-02-03 18:33:35	t	0101000020E61000008548861C5B3552C03E963E7441D34440
576	14	2008-02-03 18:36:35	2008-02-03 18:38:35	t	0101000020E610000094196F2BBD3652C0CC0BB08F4ED34440
577	14	2008-02-03 18:41:35	2008-02-03 18:43:35	t	0101000020E610000053B4722F303752C029965B5A0DD34440
578	14	2008-02-03 18:46:35	2008-02-03 18:48:35	f	0101000020E610000013DBDD03743752C00C76C3B645D34440
579	14	2008-02-03 18:51:35	2008-02-03 18:53:35	f	0101000020E6100000EE9A90D6183652C07E1D386744D34440
580	14	2008-02-03 18:56:35	2008-02-03 18:58:35	t	0101000020E61000008CBFED09123552C0BE874B8E3BD34440
581	14	2008-02-03 19:06:35	2008-02-03 19:08:35	f	0101000020E6100000AA83BC1E4C3252C0A83AE466B8D34440
582	14	2008-02-03 19:11:35	2008-02-03 19:13:35	t	0101000020E6100000A2BAB9F8DB3052C0191C25AFCED34440
583	14	2008-02-03 19:16:35	2008-02-03 19:18:35	t	0101000020E6100000CBF962EFC52F52C03EB324404DD34440
584	14	2008-02-03 19:21:35	2008-02-03 19:23:35	f	0101000020E61000007D5D86FF742F52C07D5C1B2AC6D34440
585	14	2008-02-03 19:26:35	2008-02-03 19:28:35	f	0101000020E610000054758F6CAE2E52C0EF2076A6D0D34440
586	14	2008-02-03 19:31:35	2008-02-03 19:33:35	f	0101000020E6100000F85965A6B42E52C0841266DAFED34440
587	14	2008-02-03 19:36:35	2008-02-03 19:38:35	f	0101000020E61000001F34BBEEAD2E52C052F2EA1C03D44440
588	15	2008-02-08 16:01:22	2008-02-08 16:03:22	f	0101000020E61000001E1CEC4D0C2752C0FC743C66A0D84440
589	14	2008-02-03 19:41:35	2008-02-03 19:43:35	f	0101000020E6100000C61C041DAD2E52C0999EB0C403D44440
590	14	2008-02-03 19:46:35	2008-02-03 19:48:35	t	0101000020E6100000180FEF39B02E52C04BCD1E6805D44440
591	14	2008-02-03 19:51:35	2008-02-03 19:53:35	f	0101000020E6100000D887F546AD2E52C04BCD1E6805D44440
592	14	2008-02-03 19:56:35	2008-02-03 19:58:35	f	0101000020E6100000265987A3AB2E52C027F73B1405D44440
593	14	2008-02-03 20:01:35	2008-02-03 20:03:35	f	0101000020E61000006D054D4BAC2E52C03D8386FE09D44440
594	14	2008-02-03 20:06:35	2008-02-03 20:08:35	f	0101000020E6100000180FEF39B02E52C0605969520AD44440
595	14	2008-02-03 20:11:35	2008-02-03 20:13:35	f	0101000020E6100000A6677A89B12E52C0A7052FFA0AD44440
596	14	2008-02-03 20:16:35	2008-02-03 20:18:35	t	0101000020E61000002A7AE063B02E52C0605969520AD44440
597	14	2008-02-03 20:21:35	2008-02-03 20:23:35	f	0101000020E61000004D50C3B7B02E52C08B54185B08D44440
598	14	2008-02-03 20:26:35	2008-02-03 20:28:35	f	0101000020E61000004D50C3B7B02E52C0D200DE0209D44440
599	14	2008-02-03 20:31:35	2008-02-03 20:33:35	t	0101000020E61000003BE5D18DB02E52C08B54185B08D44440
600	14	2008-02-03 20:31:35	2008-02-03 20:33:35	t	0101000020E61000003BE5D18DB02E52C08B54185B08D44440
601	14	2008-02-03 20:36:35	2008-02-03 20:38:35	f	0101000020E61000002A7AE063B02E52C08B54185B08D44440
602	16	2008-02-05 20:00:51	2008-02-05 20:02:51	t	0101000020E610000048E2E5E95C3D52C0C6A70018CFEA4440
603	16	2008-02-05 20:00:56	2008-02-05 20:02:56	f	0101000020E610000048E2E5E95C3D52C0C6A70018CFEA4440
604	16	2008-02-05 20:01:01	2008-02-05 20:03:01	t	0101000020E61000005A4DD7135D3D52C0A2D11DC4CEEA4440
605	16	2008-02-05 20:01:06	2008-02-05 20:03:06	t	0101000020E61000005A4DD7135D3D52C0A2D11DC4CEEA4440
606	16	2008-02-05 20:01:11	2008-02-05 20:03:11	f	0101000020E6100000F7EFFACC593D52C078D66EBBD0EA4440
607	16	2008-02-05 20:01:16	2008-02-05 20:03:16	t	0101000020E6100000A1DCB6EF513D52C0698CD651D5EA4440
608	16	2008-02-05 20:01:21	2008-02-05 20:03:21	f	0101000020E6100000E86B96CB463D52C030478FDFDBEA4440
609	16	2008-02-05 20:01:26	2008-02-05 20:03:26	t	0101000020E6100000498B3386393D52C06284F068E3EA4440
610	16	2008-02-05 20:01:31	2008-02-05 20:03:31	f	0101000020E610000062FE0A992B3D52C0DB6D179AEBEA4440
611	16	2008-02-05 20:01:46	2008-02-05 20:03:46	t	0101000020E6100000825CE2C8033D52C0DBA7E33103EB4440
612	16	2008-02-05 20:01:51	2008-02-05 20:03:51	t	0101000020E61000004DFE277FF73C52C0E90E62670AEB4440
613	16	2008-02-05 20:04:16	2008-02-05 20:06:16	f	0101000020E6100000640795B88E3B52C066834C3272EC4440
614	16	2008-02-05 20:04:21	2008-02-05 20:06:21	t	0101000020E61000009306B7B5853B52C0C3D8429083EC4440
615	16	2008-02-05 20:04:31	2008-02-05 20:06:31	f	0101000020E6100000C80DBF9B6E3B52C06D1CB1169FEC4440
616	16	2008-02-05 20:04:36	2008-02-05 20:06:36	t	0101000020E6100000AC3FC230603B52C0BB0A293FA9EC4440
617	16	2008-02-05 20:04:41	2008-02-05 20:06:41	f	0101000020E610000025EF1CCA503B52C09F76F86BB2EC4440
618	16	2008-02-05 20:04:46	2008-02-05 20:06:46	t	0101000020E6100000D3DF4BE1413B52C0A6B8AAECBBEC4440
619	16	2008-02-05 20:04:51	2008-02-05 20:06:51	f	0101000020E6100000FEBD141E343B52C04278B471C4EC4440
620	16	2008-02-05 20:04:56	2008-02-05 20:06:56	f	0101000020E61000001731EC30263B52C0020EA14ACDEC4440
621	16	2008-02-05 20:05:01	2008-02-05 20:07:01	f	0101000020E6100000C5211B48173B52C0095053CBD6EC4440
622	16	2008-02-05 20:05:06	2008-02-05 20:07:06	f	0101000020E6100000857D3B89083B52C0EDBB22F8DFEC4440
623	16	2008-02-05 20:05:16	2008-02-05 20:07:16	f	0101000020E6100000D7187442E83A52C0F41ABB44F5EC4440
624	16	2008-02-05 20:05:21	2008-02-05 20:07:21	f	0101000020E61000003417B83CD63A52C0170E846401ED4440
625	16	2008-02-05 20:05:26	2008-02-05 20:07:26	t	0101000020E61000006D3F19E3C33A52C0D07EA4880CED4440
626	16	2008-02-05 20:05:36	2008-02-05 20:07:36	f	0101000020E6100000F1FACC599F3A52C0D0B8702024ED4440
627	16	2008-02-05 20:05:41	2008-02-05 20:07:41	t	0101000020E6100000CAE6AA798E3A52C0427DCB9C2EED4440
628	16	2008-02-05 20:05:56	2008-02-05 20:07:56	t	0101000020E610000086E7A562633A52C06CCF2C0950ED4440
629	16	2008-02-05 20:06:01	2008-02-05 20:08:01	t	0101000020E6100000FF9600FC533A52C090C2F5285CED4440
630	16	2008-02-05 20:06:06	2008-02-05 20:08:06	f	0101000020E610000043058717443A52C01E38674469ED4440
631	16	2008-02-05 20:06:11	2008-02-05 20:08:11	f	0101000020E610000087730D33343A52C0FA7E6ABC74ED4440
632	16	2008-02-05 20:06:16	2008-02-05 20:08:16	f	0101000020E610000095A0BFD0233A52C02CBCCB457CED4440
633	16	2008-02-05 20:06:21	2008-02-05 20:08:21	f	0101000020E6100000D90E46EC133A52C0651EF98381ED4440
634	16	2008-02-05 20:06:26	2008-02-05 20:08:26	t	0101000020E61000006B4E5E64023A52C09D8026C286ED4440
635	16	2008-02-05 20:06:31	2008-02-05 20:08:31	t	0101000020E6100000CB6DFB1EF53952C001DE02098AED4440
636	16	2008-02-05 20:06:36	2008-02-05 20:08:36	f	0101000020E6100000B2C05774EB3952C0B30C71AC8BED4440
637	16	2008-02-05 20:06:41	2008-02-05 20:08:41	f	0101000020E610000004965CC5E23952C0DD0720B589ED4440
638	16	2008-02-05 20:06:46	2008-02-05 20:08:46	t	0101000020E610000060B1868BDC3952C02597FF907EED4440
639	16	2008-02-05 20:06:51	2008-02-05 20:08:51	f	0101000020E61000007620EBA9D53952C0A56B26DF6CED4440
640	16	2008-02-05 20:06:56	2008-02-05 20:08:56	f	0101000020E6100000327898F6CD3952C09E0C8E9257ED4440
641	16	2008-02-05 20:07:01	2008-02-05 20:09:01	t	0101000020E6100000B98E71C5C53952C073D712F241ED4440
642	16	2008-02-05 20:07:06	2008-02-05 20:09:06	f	0101000020E61000002F3A596ABD3952C049A297512CED4440
643	16	2008-02-05 20:07:11	2008-02-05 20:09:11	f	0101000020E6100000A4E5400FB53952C0FB96395D16ED4440
644	16	2008-02-05 20:07:16	2008-02-05 20:09:16	f	0101000020E610000072A8DF85AD3952C0A5660FB402ED4440
645	16	2008-02-05 20:07:26	2008-02-05 20:09:26	f	0101000020E6100000330400C79E3952C05F6397A8DEEC4440
646	16	2008-02-05 20:07:31	2008-02-05 20:09:31	t	0101000020E6100000BA1AD995963952C009336DFFCAEC4440
647	16	2008-02-05 20:07:36	2008-02-05 20:09:36	t	0101000020E6100000F35F2008903952C0ADDD76A1B9EC4440
648	16	2008-02-05 20:07:41	2008-02-05 20:09:41	t	0101000020E6100000CC68E4F38A3952C04A63B48EAAEC4440
649	16	2008-02-05 20:07:46	2008-02-05 20:09:46	t	0101000020E6100000FA84ECBC8D3952C0ADA3AA09A2EC4440
650	16	2008-02-07 20:32:26	2008-02-07 20:34:26	f	0101000020E61000003A984D80613952C08F53742497F54440
651	16	2008-02-07 20:32:31	2008-02-07 20:34:31	t	0101000020E6100000282D5C56613952C08F53742497F54440
652	16	2008-02-07 20:32:36	2008-02-07 20:34:36	t	0101000020E6100000282D5C56613952C08F53742497F54440
653	16	2008-02-07 20:32:41	2008-02-07 20:34:41	t	0101000020E6100000282D5C56613952C08F53742497F54440
654	16	2008-02-07 20:32:46	2008-02-07 20:34:46	t	0101000020E6100000282D5C56613952C08F53742497F54440
655	16	2008-02-07 20:32:51	2008-02-07 20:34:51	f	0101000020E610000017C26A2C613952C08F53742497F54440
656	16	2008-02-07 20:32:56	2008-02-07 20:34:56	t	0101000020E610000017C26A2C613952C0B329577897F54440
657	16	2008-02-07 20:32:56	2008-02-07 20:34:56	f	0101000020E610000017C26A2C613952C0B329577897F54440
658	16	2008-02-07 20:33:01	2008-02-07 20:35:01	t	0101000020E610000017C26A2C613952C0B329577897F54440
659	16	2008-02-07 20:33:01	2008-02-07 20:35:01	f	0101000020E610000017C26A2C613952C0B329577897F54440
660	16	2008-02-07 20:33:06	2008-02-07 20:35:06	f	0101000020E610000017C26A2C613952C0B329577897F54440
661	16	2008-02-07 20:33:11	2008-02-07 20:35:11	t	0101000020E610000017C26A2C613952C08F53742497F54440
662	16	2008-02-07 20:33:16	2008-02-07 20:35:16	t	0101000020E610000017C26A2C613952C08F53742497F54440
663	16	2008-02-07 20:33:21	2008-02-07 20:35:21	f	0101000020E610000017C26A2C613952C08F53742497F54440
664	16	2008-02-07 20:33:26	2008-02-07 20:35:26	f	0101000020E610000005577902613952C08F53742497F54440
665	16	2008-02-07 20:33:31	2008-02-07 20:35:31	f	0101000020E610000005577902613952C08F53742497F54440
666	16	2008-02-07 20:33:36	2008-02-07 20:35:36	t	0101000020E610000005577902613952C08F53742497F54440
667	16	2008-02-07 20:33:41	2008-02-07 20:35:41	f	0101000020E610000017C26A2C613952C08F53742497F54440
668	16	2008-02-07 20:33:46	2008-02-07 20:35:46	t	0101000020E610000017C26A2C613952C06C7D91D096F54440
669	16	2008-02-07 20:33:51	2008-02-07 20:35:51	t	0101000020E6100000282D5C56613952C06C7D91D096F54440
670	16	2008-02-07 20:33:56	2008-02-07 20:35:56	t	0101000020E61000004C033FAA613952C06C7D91D096F54440
671	16	2008-02-07 20:34:01	2008-02-07 20:36:01	f	0101000020E61000004C033FAA613952C06C7D91D096F54440
672	16	2008-02-07 20:34:06	2008-02-07 20:36:06	f	0101000020E61000004C033FAA613952C06C7D91D096F54440
673	16	2008-02-07 20:34:11	2008-02-07 20:36:11	t	0101000020E61000004C033FAA613952C06C7D91D096F54440
674	16	2008-02-07 20:34:16	2008-02-07 20:36:16	f	0101000020E61000005E6E30D4613952C06C7D91D096F54440
675	16	2008-02-07 20:34:21	2008-02-07 20:36:21	t	0101000020E61000006FD921FE613952C06C7D91D096F54440
676	16	2008-02-07 20:34:26	2008-02-07 20:36:26	f	0101000020E610000081441328623952C06C7D91D096F54440
677	16	2008-02-07 20:34:31	2008-02-07 20:36:31	f	0101000020E610000093AF0452623952C06C7D91D096F54440
678	16	2008-02-07 20:34:36	2008-02-07 20:36:36	f	0101000020E6100000A51AF67B623952C06C7D91D096F54440
679	16	2008-02-07 20:34:41	2008-02-07 20:36:41	t	0101000020E610000093AF0452623952C06C7D91D096F54440
680	16	2008-02-07 20:34:46	2008-02-07 20:36:46	t	0101000020E610000093AF0452623952C048A7AE7C96F54440
681	16	2008-02-07 20:34:51	2008-02-07 20:36:51	t	0101000020E610000093AF0452623952C048A7AE7C96F54440
682	16	2008-02-07 20:34:56	2008-02-07 20:36:56	t	0101000020E6100000A51AF67B623952C048A7AE7C96F54440
683	16	2008-02-07 20:35:01	2008-02-07 20:37:01	t	0101000020E6100000B785E7A5623952C024D1CB2896F54440
684	16	2008-02-07 20:35:06	2008-02-07 20:37:06	f	0101000020E6100000C8F0D8CF623952C024D1CB2896F54440
685	16	2008-02-07 20:35:11	2008-02-07 20:37:11	f	0101000020E6100000DA5BCAF9623952C001FBE8D495F54440
686	16	2008-02-07 20:35:16	2008-02-07 20:37:16	t	0101000020E6100000ECC6BB23633952C001FBE8D495F54440
687	16	2008-02-07 20:35:21	2008-02-07 20:37:21	f	0101000020E6100000FE31AD4D633952C001FBE8D495F54440
688	16	2008-02-07 20:35:26	2008-02-07 20:37:26	f	0101000020E6100000FE31AD4D633952C001FBE8D495F54440
689	16	2008-02-07 20:35:31	2008-02-07 20:37:31	f	0101000020E6100000ECC6BB23633952C024D1CB2896F54440
690	16	2008-02-07 20:35:36	2008-02-07 20:37:36	t	0101000020E6100000DA5BCAF9623952C024D1CB2896F54440
691	16	2008-02-07 20:35:41	2008-02-07 20:37:41	t	0101000020E6100000B785E7A5623952C048A7AE7C96F54440
692	16	2008-02-07 20:35:46	2008-02-07 20:37:46	f	0101000020E6100000A51AF67B623952C048A7AE7C96F54440
693	16	2008-02-07 20:35:51	2008-02-07 20:37:51	f	0101000020E6100000A51AF67B623952C048A7AE7C96F54440
694	16	2008-02-07 20:35:56	2008-02-07 20:37:56	t	0101000020E6100000A51AF67B623952C06C7D91D096F54440
695	16	2008-02-07 20:36:01	2008-02-07 20:38:01	t	0101000020E6100000B785E7A5623952C06C7D91D096F54440
696	16	2008-02-07 20:36:06	2008-02-07 20:38:06	t	0101000020E6100000B785E7A5623952C06C7D91D096F54440
697	16	2008-02-07 20:36:11	2008-02-07 20:38:11	f	0101000020E6100000C8F0D8CF623952C06C7D91D096F54440
698	16	2008-02-07 20:36:16	2008-02-07 20:38:16	f	0101000020E6100000B785E7A5623952C06C7D91D096F54440
699	16	2008-02-07 20:36:21	2008-02-07 20:38:21	f	0101000020E6100000B785E7A5623952C048A7AE7C96F54440
700	16	2008-02-07 20:36:26	2008-02-07 20:38:26	t	0101000020E6100000A51AF67B623952C048A7AE7C96F54440
701	16	2008-02-07 20:36:31	2008-02-07 20:38:31	f	0101000020E6100000A51AF67B623952C048A7AE7C96F54440
702	16	2008-02-07 20:36:36	2008-02-07 20:38:36	f	0101000020E610000093AF0452623952C048A7AE7C96F54440
703	16	2008-02-07 20:36:41	2008-02-07 20:38:41	f	0101000020E61000006FD921FE613952C024D1CB2896F54440
704	16	2008-02-07 20:36:46	2008-02-07 20:38:46	f	0101000020E61000003A984D80613952C001FBE8D495F54440
705	16	2008-02-07 20:36:51	2008-02-07 20:38:51	f	0101000020E61000003A984D80613952C0DD24068195F54440
706	16	2008-02-07 20:36:56	2008-02-07 20:38:56	t	0101000020E61000004C033FAA613952C001FBE8D495F54440
707	16	2008-02-07 20:37:01	2008-02-07 20:39:01	t	0101000020E61000005E6E30D4613952C001FBE8D495F54440
708	16	2008-02-07 20:37:06	2008-02-07 20:39:06	f	0101000020E61000001A575C1C952F52C024D1CB2896F54440
709	16	2008-02-07 20:37:06	2008-02-07 20:39:06	t	0101000020E61000001A575C1C952F52C024D1CB2896F54440
710	16	2008-02-07 20:37:11	2008-02-07 20:39:11	f	0101000020E61000005E6E30D4613952C024D1CB2896F54440
711	16	2008-02-07 20:37:16	2008-02-07 20:39:16	f	0101000020E61000006FD921FE613952C001FBE8D495F54440
712	16	2008-02-07 20:37:21	2008-02-07 20:39:21	f	0101000020E610000081441328623952C024D1CB2896F54440
713	16	2008-02-07 20:37:26	2008-02-07 20:39:26	f	0101000020E610000093AF0452623952C001FBE8D495F54440
714	16	2008-02-07 20:37:31	2008-02-07 20:39:31	t	0101000020E6100000A51AF67B623952C001FBE8D495F54440
715	16	2008-02-07 20:37:36	2008-02-07 20:39:36	t	0101000020E6100000A51AF67B623952C001FBE8D495F54440
716	16	2008-02-07 20:37:41	2008-02-07 20:39:41	f	0101000020E6100000A51AF67B623952C001FBE8D495F54440
717	16	2008-02-07 20:37:46	2008-02-07 20:39:46	t	0101000020E6100000B785E7A5623952C0DD24068195F54440
718	16	2008-02-07 20:37:46	2008-02-07 20:39:46	t	0101000020E6100000B785E7A5623952C0DD24068195F54440
719	16	2008-02-07 20:37:51	2008-02-07 20:39:51	t	0101000020E6100000C8F0D8CF623952C0DD24068195F54440
720	16	2008-02-07 20:37:51	2008-02-07 20:39:51	f	0101000020E6100000C8F0D8CF623952C0DD24068195F54440
721	16	2008-02-07 20:37:56	2008-02-07 20:39:56	t	0101000020E6100000DA5BCAF9623952C0BA4E232D95F54440
722	16	2008-02-07 20:38:01	2008-02-07 20:40:01	f	0101000020E6100000DA5BCAF9623952C0BA4E232D95F54440
723	17	2008-02-08 10:23:22	2008-02-08 10:25:22	t	0101000020E61000006D5CFFAECF3452C029B3412619DF4440
724	17	2008-02-08 10:28:22	2008-02-08 10:30:22	t	0101000020E61000004665C39ACA3452C0CC7A319413DF4440
725	17	2008-02-08 10:33:22	2008-02-08 10:35:22	t	0101000020E6100000C656D0B4C43452C0456458C51BDF4440
726	17	2008-02-08 10:38:22	2008-02-08 10:40:22	f	0101000020E6100000943655F7C83452C0F05014E813DF4440
727	17	2008-02-08 10:43:22	2008-02-08 10:45:22	t	0101000020E6100000943655F7C83452C037FDD98F14DF4440
728	17	2008-02-08 10:48:22	2008-02-08 10:50:22	t	0101000020E610000082CB63CDC83452C05BD3BCE314DF4440
729	17	2008-02-08 10:48:22	2008-02-08 10:50:22	f	0101000020E610000082CB63CDC83452C05BD3BCE314DF4440
730	17	2008-02-08 10:53:22	2008-02-08 10:55:22	f	0101000020E6100000706072A3C83452C0E92B483316DF4440
731	17	2008-02-08 10:58:22	2008-02-08 11:00:22	t	0101000020E6100000EDD973999A3452C0B858518369DE4440
732	17	2008-02-08 11:03:22	2008-02-08 11:05:22	f	0101000020E61000008D9DF0129C3452C0691D554D10DB4440
733	17	2008-02-08 11:08:22	2008-02-08 11:10:22	t	0101000020E61000000366BE839F3452C08DF337A110DB4440
734	17	2008-02-08 11:13:22	2008-02-08 11:15:22	f	0101000020E6100000513750E09D3452C0A27F828B15DB4440
735	17	2008-02-08 11:18:22	2008-02-08 11:20:22	t	0101000020E6100000513750E09D3452C01427F73B14DB4440
736	17	2008-02-08 11:23:22	2008-02-08 11:25:22	t	0101000020E6100000513750E09D3452C01427F73B14DB4440
737	17	2008-02-08 11:28:22	2008-02-08 11:30:22	t	0101000020E61000003FCC5EB69D3452C0F05014E813DB4440
738	17	2008-02-08 11:33:22	2008-02-08 11:35:22	t	0101000020E61000003FCC5EB69D3452C01427F73B14DB4440
739	17	2008-02-08 11:38:22	2008-02-08 11:40:22	f	0101000020E61000003FCC5EB69D3452C01427F73B14DB4440
740	17	2008-02-08 11:43:22	2008-02-08 11:45:22	t	0101000020E61000003FCC5EB69D3452C037FDD98F14DB4440
741	17	2008-02-08 11:48:22	2008-02-08 11:50:22	t	0101000020E61000003FCC5EB69D3452C01427F73B14DB4440
742	17	2008-02-08 11:53:22	2008-02-08 11:55:22	f	0101000020E61000003FCC5EB69D3452C01427F73B14DB4440
743	17	2008-02-08 11:58:22	2008-02-08 12:00:22	f	0101000020E61000003FCC5EB69D3452C0F05014E813DB4440
744	17	2008-02-08 12:03:22	2008-02-08 12:05:22	t	0101000020E61000003FCC5EB69D3452C0F05014E813DB4440
745	17	2008-02-08 12:08:21	2008-02-08 12:10:21	t	0101000020E61000002D616D8C9D3452C0CC7A319413DB4440
746	17	2008-02-08 12:13:21	2008-02-08 12:15:21	t	0101000020E61000002D616D8C9D3452C0CC7A319413DB4440
747	17	2008-02-08 12:18:21	2008-02-08 12:20:21	t	0101000020E61000003FCC5EB69D3452C0CC7A319413DB4440
748	17	2008-02-08 12:23:21	2008-02-08 12:25:21	t	0101000020E61000003FCC5EB69D3452C0CC7A319413DB4440
749	17	2008-02-08 12:28:21	2008-02-08 12:30:21	f	0101000020E61000003FCC5EB69D3452C0A9A44E4013DB4440
750	17	2008-02-08 12:33:21	2008-02-08 12:35:21	t	0101000020E61000003FCC5EB69D3452C085CE6BEC12DB4440
751	17	2008-02-08 12:38:21	2008-02-08 12:40:21	t	0101000020E61000003FCC5EB69D3452C0A9A44E4013DB4440
752	18	2008-02-05 16:53:04	2008-02-05 16:55:04	f	0101000020E6100000545DC0CB0C2F52C021CD58349DD74440
753	18	2008-02-05 16:53:05	2008-02-05 16:55:05	f	0101000020E610000042F2CEA10C2F52C0D3FBC6D79ED74440
754	18	2008-02-05 16:53:06	2008-02-05 16:55:06	f	0101000020E610000042F2CEA10C2F52C0A80018CFA0D74440
755	18	2008-02-05 16:53:07	2008-02-05 16:55:07	t	0101000020E61000003087DD770C2F52C07D0569C6A2D74440
756	18	2008-02-05 16:53:08	2008-02-05 16:55:08	f	0101000020E61000001E1CEC4D0C2F52C076E09C11A5D74440
757	18	2008-02-05 16:53:09	2008-02-05 16:55:09	t	0101000020E61000001E1CEC4D0C2F52C06FBBD05CA7D74440
758	18	2008-02-05 16:53:10	2008-02-05 16:55:10	t	0101000020E61000001E1CEC4D0C2F52C0689604A8A9D74440
759	18	2008-02-05 16:53:11	2008-02-05 16:55:11	f	0101000020E61000000CB1FA230C2F52C03D9B559FABD74440
760	18	2008-02-05 18:48:37	2008-02-05 18:50:37	f	0101000020E6100000F7EFFACC593B52C0FB912232ACD44440
761	18	2008-02-05 18:48:38	2008-02-05 18:50:38	f	0101000020E61000004F07B29E5A3B52C0FB912232ACD44440
762	18	2008-02-05 18:48:39	2008-02-05 18:50:39	f	0101000020E6100000A81E69705B3B52C0FB912232ACD44440
763	18	2008-02-05 18:48:40	2008-02-05 18:50:40	f	0101000020E6100000013620425C3B52C0FB912232ACD44440
764	18	2008-02-05 18:48:41	2008-02-05 18:50:41	f	0101000020E61000005A4DD7135D3B52C0D8BB3FDEABD44440
765	18	2008-02-05 18:48:42	2008-02-05 18:50:42	f	0101000020E6100000B3648EE55D3B52C0FB912232ACD44440
766	18	2008-02-05 18:48:43	2008-02-05 18:50:43	t	0101000020E61000001EE736E15E3B52C0FB912232ACD44440
767	18	2008-02-05 18:48:44	2008-02-05 18:50:44	t	0101000020E61000008869DFDC5F3B52C01F680586ACD44440
768	18	2008-02-05 18:48:45	2008-02-05 18:50:45	t	0101000020E610000005577902613B52C01F680586ACD44440
769	18	2008-02-05 18:48:51	2008-02-05 18:50:51	f	0101000020E61000001AE3C3EC653B52C0910F7A36ABD44440
770	18	2008-02-05 18:48:53	2008-02-05 18:50:53	t	0101000020E6100000DE7C23BA673B52C0DFE00B93A9D44440
771	18	2008-02-05 18:48:54	2008-02-05 18:50:54	f	0101000020E61000003694DA8B683B52C0745E6397A8D44440
772	18	2008-02-05 18:48:57	2008-02-05 18:50:57	f	0101000020E6100000D65757056A3B52C0F44F70B1A2D44440
773	18	2008-02-05 18:48:58	2008-02-05 18:50:58	f	0101000020E6100000E8C2482F6A3B52C0D89E5912A0D44440
774	18	2008-02-05 18:48:59	2008-02-05 18:50:59	f	0101000020E61000000C992B836A3B52C0BCED42739DD44440
775	18	2008-02-05 18:49:00	2008-02-05 18:51:00	f	0101000020E61000002F6F0ED76A3B52C07C6649809AD44440
776	18	2008-02-05 18:49:01	2008-02-05 18:51:01	f	0101000020E610000041DAFF006B3B52C03CDF4F8D97D44440
777	18	2008-02-05 18:49:02	2008-02-05 18:51:02	t	0101000020E610000065B0E2546B3B52C0D881734694D44440
778	18	2008-02-05 18:49:03	2008-02-05 18:51:03	f	0101000020E6100000761BD47E6B3B52C098FA795391D44440
779	18	2008-02-05 18:49:04	2008-02-05 18:51:04	t	0101000020E61000009AF1B6D26B3B52C0359D9D0C8ED44440
780	18	2008-02-05 18:49:05	2008-02-05 18:51:05	f	0101000020E6100000BEC799266C3B52C0F515A4198BD44440
781	18	2008-02-05 18:49:06	2008-02-05 18:51:06	t	0101000020E610000005745FCE6C3B52C0D8648D7A88D44440
782	18	2008-02-05 18:49:07	2008-02-05 18:51:07	t	0101000020E61000003AB5334C6D3B52C098DD938785D44440
783	18	2008-02-05 18:49:08	2008-02-05 18:51:08	t	0101000020E61000008161F9F36D3B52C09F02603C83D44440
784	18	2008-02-05 18:49:10	2008-02-05 18:51:10	t	0101000020E6100000339067976F3B52C0AE4CF8A57ED44440
785	18	2008-02-05 18:49:12	2008-02-05 18:51:12	f	0101000020E6100000E5BED53A713B52C02619390B7BD44440
786	18	2008-02-05 18:49:14	2008-02-05 18:51:14	t	0101000020E610000096ED43DE723B52C0E6913F1878D44440
787	18	2008-02-05 18:49:15	2008-02-05 18:51:15	f	0101000020E61000000170ECD9733B52C05839B4C876D44440
788	18	2008-02-05 18:49:16	2008-02-05 18:51:16	t	0101000020E61000006CF294D5743B52C0CAE0287975D44440
789	18	2008-02-05 18:49:17	2008-02-05 18:51:17	t	0101000020E6100000FA4A2025763B52C05F5E807D74D44440
790	18	2008-02-05 18:49:18	2008-02-05 18:51:18	t	0101000020E61000007638BA4A773B52C0D105F52D73D44440
791	18	2008-02-05 18:49:19	2008-02-05 18:51:19	t	0101000020E61000000591459A783B52C066834C3272D44440
792	18	2008-02-05 18:49:20	2008-02-05 18:51:20	f	0101000020E610000093E9D0E9793B52C0FC00A43671D44440
793	18	2008-02-05 18:49:21	2008-02-05 18:51:21	f	0101000020E610000021425C397B3B52C06EA818E76FD44440
794	18	2008-02-05 18:49:22	2008-02-05 18:51:22	t	0101000020E6100000AF9AE7887C3B52C0032670EB6ED44440
795	18	2008-02-05 18:49:23	2008-02-05 18:51:23	t	0101000020E61000002C8881AE7D3B52C098A3C7EF6DD44440
796	18	2008-02-05 18:49:24	2008-02-05 18:51:24	f	0101000020E6100000960A2AAA7E3B52C02E211FF46CD44440
797	18	2008-02-05 18:49:27	2008-02-05 18:51:27	t	0101000020E61000004839984D803B52C05F419AB168D44440
798	18	2008-02-05 18:49:34	2008-02-05 18:51:34	f	0101000020E61000008FE55DF5803B52C0CAA65CE15DD44440
799	18	2008-02-05 18:49:37	2008-02-05 18:51:37	f	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
800	18	2008-02-05 18:49:38	2008-02-05 18:51:38	f	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
801	18	2008-02-05 18:49:40	2008-02-05 18:51:40	f	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
802	18	2008-02-05 18:49:41	2008-02-05 18:51:41	t	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
803	18	2008-02-05 18:49:42	2008-02-05 18:51:42	t	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
804	18	2008-02-05 18:49:43	2008-02-05 18:51:43	t	0101000020E6100000B3BB4049813B52C0A7D0798D5DD44440
805	18	2008-02-05 18:49:52	2008-02-05 18:51:52	f	0101000020E6100000C5263273813B52C051BD35B055D44440
806	18	2008-02-05 18:49:54	2008-02-05 18:51:54	f	0101000020E6100000A1504F1F813B52C083DDB06D51D44440
807	18	2008-02-05 18:49:55	2008-02-05 18:51:55	t	0101000020E61000008FE55DF5803B52C0AED85F764FD44440
808	18	2008-02-05 18:49:56	2008-02-05 18:51:56	f	0101000020E61000007D7A6CCB803B52C0D9D30E7F4DD44440
809	18	2008-02-05 18:49:59	2008-02-05 18:51:59	t	0101000020E61000006C0F7BA1803B52C059C51B9947D44440
810	18	2008-02-05 18:50:01	2008-02-05 18:52:01	f	0101000020E61000005AA48977803B52C0F5673F5244D44440
811	18	2008-02-05 18:50:02	2008-02-05 18:52:02	f	0101000020E61000005AA48977803B52C0670FB40243D44440
812	18	2008-02-05 18:50:22	2008-02-05 18:52:22	f	0101000020E610000045183F8D7B3B52C07C61325530D44440
813	18	2008-02-05 18:50:23	2008-02-05 18:52:23	t	0101000020E6100000B6BFB33D7A3B52C0EE08A7052FD44440
814	18	2008-02-05 18:50:24	2008-02-05 18:52:24	f	0101000020E6100000286728EE783B52C060B01BB62DD44440
815	18	2008-02-05 18:50:25	2008-02-05 18:52:25	f	0101000020E6100000AC798EC8773B52C08BABCABE2BD44440
816	18	2008-02-05 18:50:30	2008-02-05 18:52:30	t	0101000020E6100000858252B4723B52C0AE64C74620D44440
817	18	2008-02-05 18:50:36	2008-02-05 18:52:36	f	0101000020E61000000FBA84436F3B52C0E78C28ED0DD44440
818	18	2008-02-05 18:50:40	2008-02-05 18:52:40	t	0101000020E6100000284A42226D3B52C0841266DAFED34440
819	18	2008-02-05 18:50:41	2008-02-05 18:52:41	f	0101000020E6100000E19D7C7A6C3B52C0D908C4EBFAD34440
820	18	2008-02-05 18:50:42	2008-02-05 18:52:42	t	0101000020E6100000AC5CA8FC6B3B52C02EFF21FDF6D34440
821	18	2008-02-05 18:50:43	2008-02-05 18:52:43	t	0101000020E6100000761BD47E6B3B52C084F57F0EF3D34440
822	18	2008-02-05 18:50:43	2008-02-05 18:52:43	f	0101000020E6100000761BD47E6B3B52C084F57F0EF3D34440
823	18	2008-02-05 18:50:44	2008-02-05 18:52:44	f	0101000020E610000041DAFF006B3B52C0FDC1C073EFD34440
824	18	2008-02-05 18:50:44	2008-02-05 18:52:44	f	0101000020E610000041DAFF006B3B52C0FDC1C073EFD34440
825	18	2008-02-05 18:50:45	2008-02-05 18:52:45	t	0101000020E61000001E041DAD6A3B52C0768E01D9EBD34440
826	18	2008-02-05 18:50:45	2008-02-05 18:52:45	f	0101000020E61000001E041DAD6A3B52C0768E01D9EBD34440
827	19	2008-02-06 03:33:21	2008-02-06 03:35:21	f	0101000020E6100000ABD0402C9B2952C099D87C5C1BC04440
828	19	2008-02-06 03:43:20	2008-02-06 03:45:20	t	0101000020E6100000ABD0402C9B2952C0BCAE5FB01BC04440
829	19	2008-02-06 03:53:20	2008-02-06 03:55:20	f	0101000020E6100000CFA623809B2952C0E08442041CC04440
830	19	2008-02-06 04:03:20	2008-02-06 04:05:20	t	0101000020E610000004E8F7FD9B2952C05951836918C04440
831	19	2008-02-06 04:13:20	2008-02-06 04:15:20	t	0101000020E61000001653E9279C2952C0A0FD481119C04440
832	19	2008-02-06 04:33:21	2008-02-06 04:35:21	t	0101000020E6100000C460FE0A992952C0FC3559A31EC04440
833	19	2008-02-06 04:43:20	2008-02-06 04:45:20	f	0101000020E6100000BD3B32569B2952C0609335EA21C04440
834	19	2008-02-06 04:53:20	2008-02-06 04:55:20	f	0101000020E6100000CFA623809B2952C0BCAE5FB01BC04440
835	19	2008-02-06 05:03:20	2008-02-06 05:05:20	f	0101000020E6100000ABD0402C9B2952C0045B25581CC04440
836	19	2008-02-06 05:13:20	2008-02-06 05:15:20	t	0101000020E6100000ABD0402C9B2952C075029A081BC04440
837	19	2008-02-06 05:23:20	2008-02-06 05:25:20	f	0101000020E6100000AFF199EC9F2952C0D95F764F1EC04440
838	19	2008-02-06 05:43:20	2008-02-06 05:45:20	t	0101000020E61000005DFFAECF9C2952C0D95F764F1EC04440
839	19	2008-02-06 05:43:20	2008-02-06 05:45:20	f	0101000020E61000005DFFAECF9C2952C0D95F764F1EC04440
840	19	2008-02-06 05:53:20	2008-02-06 05:55:20	f	0101000020E61000006F6AA0F99C2952C0FC3559A31EC04440
841	19	2008-02-06 06:03:20	2008-02-06 06:05:20	t	0101000020E6100000BD3B32569B2952C0B58993FB1DC04440
842	19	2008-02-06 06:13:21	2008-02-06 06:15:21	t	0101000020E6100000FDC22B499E2952C019E76F4221C04440
843	19	2008-02-06 06:23:21	2008-02-06 06:25:21	f	0101000020E61000001653E9279C2952C03CBD529621C04440
844	19	2008-02-06 06:33:20	2008-02-06 06:35:20	t	0101000020E61000005DFFAECF9C2952C0596E693524C04440
845	19	2008-02-06 06:43:20	2008-02-06 06:45:20	t	0101000020E61000002FE3A6069A2952C08B8EE4F21FC04440
846	19	2008-02-06 06:53:20	2008-02-06 06:55:20	f	0101000020E61000009A654F029B2952C0AE64C74620C04440
847	19	2008-02-06 07:03:20	2008-02-06 07:05:20	f	0101000020E6100000CFA623809B2952C0D23AAA9A20C04440
848	19	2008-02-06 07:13:20	2008-02-06 07:15:20	t	0101000020E6100000E11115AA9B2952C0AE64C74620C04440
849	19	2008-02-06 07:23:20	2008-02-06 07:25:20	t	0101000020E610000064247B849A2952C0E08442041CC04440
850	19	2008-02-06 07:33:20	2008-02-06 07:35:20	f	0101000020E61000001A7442E8A02952C0CA4FAA7D3AC04440
851	19	2008-02-06 07:43:20	2008-02-06 07:45:20	t	0101000020E6100000330400C79E2952C03CBD529621C04440
852	19	2008-02-06 08:13:20	2008-02-06 08:15:20	t	0101000020E610000028BEDA519C2952C0609335EA21C04440
853	19	2008-02-06 08:23:20	2008-02-06 08:25:20	f	0101000020E61000003A29CC7B9C2952C03CBD529621C04440
854	19	2008-02-06 08:33:19	2008-02-06 08:35:19	f	0101000020E610000028BEDA519C2952C019E76F4221C04440
855	19	2008-02-06 08:43:19	2008-02-06 08:45:19	t	0101000020E61000001C7DCC07042A52C034D769A4A5C04440
856	19	2008-02-06 08:53:19	2008-02-06 08:55:19	f	0101000020E610000051FD8348862C52C054C6BFCFB8C64440
857	19	2008-02-06 09:03:19	2008-02-06 09:05:19	t	0101000020E610000057B8E523292D52C05305A3923AC74440
858	19	2008-02-06 09:13:20	2008-02-06 09:15:20	t	0101000020E610000057B8E523292D52C077DB85E63AC74440
859	19	2008-02-06 09:23:20	2008-02-06 09:25:20	t	0101000020E61000006923D74D292D52C077DB85E63AC74440
860	19	2008-02-06 09:33:19	2008-02-06 09:35:19	t	0101000020E61000006923D74D292D52C077DB85E63AC74440
861	19	2008-02-06 09:43:19	2008-02-06 09:45:19	f	0101000020E6100000DEEBA4BE2C2D52C05305A3923AC74440
862	19	2008-02-06 09:53:19	2008-02-06 09:55:19	f	0101000020E61000007A8EC877292D52C0A2D634EF38C74440
863	19	2008-02-06 10:03:19	2008-02-06 10:05:19	f	0101000020E610000053B4722F302D52C05BB6D61709C74440
864	19	2008-02-06 10:14:08	2008-02-06 10:16:08	f	0101000020E6100000B7F468AA272D52C0B0E600C11CC74440
865	19	2008-02-06 10:24:08	2008-02-06 10:26:08	t	0101000020E61000007620EBA9D52952C076ABE7A4F7CF4440
866	19	2008-02-06 10:34:08	2008-02-06 10:36:08	f	0101000020E6100000D40FEA22852C52C024F3C81F0CE24440
867	19	2008-02-06 10:42:58	2008-02-06 10:44:58	t	0101000020E6100000F0E2FDB8FD2652C0E84D452A8CEB4440
868	19	2008-02-06 10:42:58	2008-02-06 10:44:58	f	0101000020E6100000F0E2FDB8FD2652C0E84D452A8CEB4440
869	19	2008-02-06 10:52:58	2008-02-06 10:54:58	t	0101000020E610000098C62FBC922C52C08716D9CEF7E14440
870	19	2008-02-06 11:02:58	2008-02-06 11:04:58	t	0101000020E61000004CAC8C463E2B52C06FD8B628B3D74440
871	19	2008-02-06 11:12:58	2008-02-06 11:14:58	f	0101000020E610000071B20DDC812C52C0CA71A774B0D84440
872	19	2008-02-06 11:22:58	2008-02-06 11:24:58	t	0101000020E61000003A29CC7B9C2B52C05B25581CCED64440
873	19	2008-02-06 14:41:10	2008-02-06 14:43:10	t	0101000020E6100000CFA623809B2952C08B71FE2614C04440
874	19	2008-02-06 14:51:10	2008-02-06 14:53:10	t	0101000020E610000028BEDA519C2952C0679B1BD313C04440
875	19	2008-02-06 15:01:10	2008-02-06 15:03:10	t	0101000020E61000004B94BDA59C2952C08369183E22C04440
876	19	2008-02-06 15:11:11	2008-02-06 15:13:11	t	0101000020E61000002FE3A6069A2952C0359886E123C04440
877	19	2008-02-06 15:21:11	2008-02-06 15:23:11	t	0101000020E6100000768F6CAE9A2952C019E76F4221C04440
878	19	2008-02-06 15:31:10	2008-02-06 15:33:10	t	0101000020E610000053B9895A9A2952C0A01A2FDD24C04440
879	19	2008-02-06 16:01:10	2008-02-06 16:03:10	t	0101000020E610000053B9895A9A2952C00B80F10C1AC04440
880	19	2008-02-06 16:11:10	2008-02-06 16:13:10	f	0101000020E6100000414E98309A2952C00B80F10C1AC04440
881	19	2008-02-06 16:21:10	2008-02-06 16:23:10	f	0101000020E6100000414E98309A2952C02E56D4601AC04440
882	19	2008-02-06 16:31:10	2008-02-06 16:33:10	t	0101000020E610000053B9895A9A2952C00B80F10C1AC04440
883	19	2008-02-06 16:51:10	2008-02-06 16:53:10	t	0101000020E6100000A03D97A9493052C09A7CB3CD8DC34440
884	19	2008-02-06 17:01:10	2008-02-06 17:03:10	f	0101000020E61000007E7555A0163152C03AAFB14B54C54440
885	19	2008-02-06 17:11:10	2008-02-06 17:13:10	t	0101000020E610000049348122163152C0C1E270E657C54440
886	19	2008-02-06 17:21:10	2008-02-06 17:23:10	f	0101000020E61000009705137F143152C03ACC971760C54440
887	19	2008-02-06 17:31:09	2008-02-06 17:33:09	t	0101000020E6100000859A2155143152C0F31FD26F5FC54440
888	19	2008-02-06 17:41:09	2008-02-06 17:43:09	t	0101000020E61000009705137F143152C0D049EF1B5FC54440
889	19	2008-02-06 17:51:10	2008-02-06 17:53:10	t	0101000020E6100000A97004A9143152C0D049EF1B5FC54440
890	19	2008-02-06 18:01:09	2008-02-06 18:03:09	t	0101000020E6100000BBDBF5D2143152C0889D29745EC54440
891	19	2008-02-06 18:11:10	2008-02-06 18:13:10	t	0101000020E6100000F01CCA50153152C041F163CC5DC54440
892	20	2008-02-05 13:27:22	2008-02-05 13:29:22	t	0101000020E610000088DD770C8F3352C0E813799274D34440
893	20	2008-02-05 13:32:16	2008-02-05 13:34:16	t	0101000020E610000054AF5B04C63452C0BEA4315A47D34440
894	20	2008-02-05 13:32:23	2008-02-05 13:34:23	f	0101000020E610000054AF5B04C63452C0BEA4315A47D34440
895	20	2008-02-05 13:37:18	2008-02-05 13:39:18	t	0101000020E61000006BA0F99CBB3552C01AC05B2041D34440
896	20	2008-02-05 13:37:25	2008-02-05 13:39:25	t	0101000020E61000000B815CE2C83552C08542041C42D34440
897	20	2008-02-05 13:42:19	2008-02-05 13:44:19	f	0101000020E61000008D800A47903652C0DFA63FFB91D44440
898	20	2008-02-05 13:42:27	2008-02-05 13:44:27	t	0101000020E610000018B83CD68C3652C0E605D847A7D44440
899	20	2008-02-05 13:47:21	2008-02-05 13:49:21	t	0101000020E6100000F802B342913652C0B5C35F9335D44440
900	20	2008-02-05 13:47:28	2008-02-05 13:49:28	f	0101000020E6100000541EDD088B3652C08AC8B08A37D44440
901	20	2008-02-05 13:52:23	2008-02-05 13:54:23	f	0101000020E6100000126C5CFFAE3552C0917EFB3A70D44440
902	21	2008-02-04 09:40:31	2008-02-04 09:42:31	t	0101000020E61000002F008DD2A53952C0ACFF73982FCD4440
903	21	2008-02-04 09:45:31	2008-02-04 09:47:31	t	0101000020E61000002F008DD2A53952C0ACFF73982FCD4440
904	21	2008-02-04 09:50:31	2008-02-04 09:52:31	t	0101000020E61000002F008DD2A53952C0892991442FCD4440
905	21	2008-02-04 10:00:31	2008-02-04 10:02:31	t	0101000020E6100000416B7EFCA53952C0892991442FCD4440
906	21	2008-02-04 10:05:31	2008-02-04 10:07:31	t	0101000020E6100000416B7EFCA53952C0892991442FCD4440
907	21	2008-02-04 10:10:31	2008-02-04 10:12:31	t	0101000020E6100000881744A4A63952C049A297512CCD4440
908	21	2008-02-04 10:15:31	2008-02-04 10:17:31	t	0101000020E61000009A8235CEA63952C06C787AA52CCD4440
909	21	2008-02-04 10:20:31	2008-02-04 10:22:31	t	0101000020E61000009661DC0DA23952C0892991442FCD4440
910	21	2008-02-04 10:25:31	2008-02-04 10:27:31	f	0101000020E61000001670CFF3A73952C06C787AA52CCD4440
911	21	2008-02-04 10:30:31	2008-02-04 10:32:31	t	0101000020E6100000F299EC9FA73952C0D7FA22A12DCD4440
912	21	2008-02-04 10:35:31	2008-02-04 10:37:31	t	0101000020E6100000E12EFB75A73952C0D7FA22A12DCD4440
913	21	2008-02-04 10:40:31	2008-02-04 10:42:31	t	0101000020E6100000E853C72AA53952C05E2EE23B31CD4440
914	21	2008-02-04 10:45:31	2008-02-04 10:47:31	t	0101000020E6100000E853C72AA53952C0EC866D8B32CD4440
915	21	2008-02-04 10:50:31	2008-02-04 10:52:31	t	0101000020E6100000CFC3094CA73952C01EA7E8482ECD4440
916	21	2008-02-04 10:55:31	2008-02-04 10:57:31	f	0101000020E61000002F008DD2A53952C0427DCB9C2ECD4440
917	21	2008-02-04 11:00:31	2008-02-04 11:02:31	f	0101000020E61000000B2AAA7EA53952C0FBD005F52DCD4440
918	21	2008-02-04 11:05:31	2008-02-04 11:07:31	f	0101000020E6100000E853C72AA53952C01EA7E8482ECD4440
919	21	2008-02-04 11:10:31	2008-02-04 11:12:31	t	0101000020E6100000D6E8D500A53952C06553AEF02ECD4440
920	21	2008-02-04 11:15:31	2008-02-04 11:17:31	t	0101000020E6100000D6E8D500A53952C0427DCB9C2ECD4440
921	21	2008-02-04 11:20:31	2008-02-04 11:22:31	t	0101000020E61000000B2AAA7EA53952C0B324404D2DCD4440
922	21	2008-02-04 11:25:31	2008-02-04 11:27:31	t	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
923	21	2008-02-04 11:30:31	2008-02-04 11:32:31	f	0101000020E6100000FABEB854A53952C0FBD005F52DCD4440
924	21	2008-02-04 11:35:31	2008-02-04 11:37:31	t	0101000020E6100000FABEB854A53952C01EA7E8482ECD4440
925	21	2008-02-04 11:35:31	2008-02-04 11:37:31	t	0101000020E6100000FABEB854A53952C01EA7E8482ECD4440
926	21	2008-02-04 11:40:30	2008-02-04 11:42:30	f	0101000020E6100000FABEB854A53952C01EA7E8482ECD4440
927	21	2008-02-04 11:45:30	2008-02-04 11:47:30	f	0101000020E6100000FABEB854A53952C01EA7E8482ECD4440
928	21	2008-02-04 11:50:30	2008-02-04 11:52:30	f	0101000020E6100000FABEB854A53952C0427DCB9C2ECD4440
929	21	2008-02-04 11:55:30	2008-02-04 11:57:30	f	0101000020E6100000FABEB854A53952C0427DCB9C2ECD4440
930	21	2008-02-04 12:00:30	2008-02-04 12:02:30	f	0101000020E6100000FABEB854A53952C0427DCB9C2ECD4440
931	21	2008-02-04 12:05:30	2008-02-04 12:07:30	f	0101000020E6100000C47DE4D6A43952C06C787AA52CCD4440
932	21	2008-02-04 12:07:18	2008-02-04 12:09:18	t	0101000020E61000007AABAE43353952C0255D33F966CD4440
933	21	2008-02-04 12:10:31	2008-02-04 12:12:31	f	0101000020E6100000E12EFB75A73952C0D7DD3CD521CD4440
934	21	2008-02-04 12:15:30	2008-02-04 12:17:30	f	0101000020E61000002F008DD2A53952C0C26ED8B628CD4440
935	21	2008-02-04 12:20:30	2008-02-04 12:22:30	t	0101000020E6100000FABEB854A53952C0B324404D2DCD4440
936	21	2008-02-04 12:25:30	2008-02-04 12:27:30	f	0101000020E61000000B2AAA7EA53952C025CCB4FD2BCD4440
937	21	2008-02-04 12:30:30	2008-02-04 12:32:30	t	0101000020E6100000E853C72AA53952C049A297512CCD4440
938	21	2008-02-04 12:35:30	2008-02-04 12:37:30	f	0101000020E6100000E853C72AA53952C06C787AA52CCD4440
939	21	2008-02-04 12:40:30	2008-02-04 12:42:30	t	0101000020E6100000FABEB854A53952C0904E5DF92CCD4440
940	21	2008-02-04 12:45:30	2008-02-04 12:47:30	t	0101000020E6100000FABEB854A53952C0904E5DF92CCD4440
941	21	2008-02-04 12:50:30	2008-02-04 12:52:30	t	0101000020E6100000FABEB854A53952C0B324404D2DCD4440
942	21	2008-02-04 12:55:30	2008-02-04 12:57:30	f	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
943	21	2008-02-04 13:00:30	2008-02-04 13:02:30	t	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
944	21	2008-02-04 13:05:30	2008-02-04 13:07:30	f	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
945	21	2008-02-04 13:10:30	2008-02-04 13:12:30	t	0101000020E61000000B2AAA7EA53952C0FBD005F52DCD4440
946	21	2008-02-04 13:15:30	2008-02-04 13:17:30	t	0101000020E61000000B2AAA7EA53952C0FBD005F52DCD4440
947	21	2008-02-04 13:20:30	2008-02-04 13:22:30	f	0101000020E61000000B2AAA7EA53952C0FBD005F52DCD4440
948	21	2008-02-04 13:25:30	2008-02-04 13:27:30	t	0101000020E61000000B2AAA7EA53952C0FBD005F52DCD4440
949	21	2008-02-04 13:30:30	2008-02-04 13:32:30	f	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
950	21	2008-02-04 13:35:30	2008-02-04 13:37:30	f	0101000020E61000000B2AAA7EA53952C0D7FA22A12DCD4440
951	21	2008-02-04 13:40:30	2008-02-04 13:42:30	f	0101000020E6100000BA37BF61A23952C050AA7D3A1ECD4440
952	21	2008-02-04 13:45:30	2008-02-04 13:47:30	f	0101000020E6100000BD581822A73952C0427DCB9C2ECD4440
953	21	2008-02-04 13:55:30	2008-02-04 13:57:30	f	0101000020E6100000CFC3094CA73952C0427DCB9C2ECD4440
954	21	2008-02-04 14:00:30	2008-02-04 14:02:30	t	0101000020E6100000CFC3094CA73952C0427DCB9C2ECD4440
955	21	2008-02-04 14:00:30	2008-02-04 14:02:30	t	0101000020E6100000CFC3094CA73952C0427DCB9C2ECD4440
956	21	2008-02-04 14:05:30	2008-02-04 14:07:30	t	0101000020E6100000CFC3094CA73952C01EA7E8482ECD4440
957	21	2008-02-04 14:10:30	2008-02-04 14:12:30	t	0101000020E6100000CFC3094CA73952C0FBD005F52DCD4440
958	21	2008-02-04 14:15:30	2008-02-04 14:17:30	f	0101000020E6100000CFC3094CA73952C0D7FA22A12DCD4440
959	21	2008-02-04 14:20:30	2008-02-04 14:22:30	t	0101000020E6100000BD581822A73952C0B324404D2DCD4440
960	21	2008-02-04 14:25:30	2008-02-04 14:27:30	f	0101000020E6100000CFC3094CA73952C0B324404D2DCD4440
961	21	2008-02-04 14:30:30	2008-02-04 14:32:30	f	0101000020E6100000BD581822A73952C0B324404D2DCD4440
962	21	2008-02-04 14:35:30	2008-02-04 14:37:30	t	0101000020E6100000BA54A52DAE3952C0102384471BCD4440
963	21	2008-02-04 14:40:30	2008-02-04 14:42:30	f	0101000020E6100000E12EFB75A73952C050C763062ACD4440
964	21	2008-02-04 14:45:30	2008-02-04 14:47:30	t	0101000020E6100000BD581822A73952C0977329AE2ACD4440
965	21	2008-02-04 14:50:30	2008-02-04 14:52:30	t	0101000020E6100000E853C72AA53952C0892991442FCD4440
966	21	2008-02-04 14:55:30	2008-02-04 14:57:30	f	0101000020E6100000FABEB854A53952C0427DCB9C2ECD4440
967	22	2008-02-03 07:04:30	2008-02-03 07:06:30	f	0101000020E610000056A52DAEF14552C0617138F3ABC34440
968	22	2008-02-03 07:04:30	2008-02-03 07:06:30	f	0101000020E610000056A52DAEF14552C0617138F3ABC34440
969	22	2008-02-03 07:05:00	2008-02-03 07:07:00	f	0101000020E610000067101FD8F14552C0617138F3ABC34440
970	22	2008-02-03 07:05:30	2008-02-03 07:07:30	t	0101000020E610000067101FD8F14552C0617138F3ABC34440
971	22	2008-02-03 07:06:00	2008-02-03 07:08:00	f	0101000020E610000067101FD8F14552C0617138F3ABC34440
972	22	2008-02-03 07:06:30	2008-02-03 07:08:30	t	0101000020E610000067101FD8F14552C0617138F3ABC34440
973	22	2008-02-03 07:07:00	2008-02-03 07:09:00	f	0101000020E610000067101FD8F14552C0617138F3ABC34440
974	22	2008-02-03 07:07:30	2008-02-03 07:09:30	f	0101000020E610000067101FD8F14552C0617138F3ABC34440
975	22	2008-02-03 07:08:00	2008-02-03 07:10:00	t	0101000020E610000067101FD8F14552C0617138F3ABC34440
976	22	2008-02-03 07:08:30	2008-02-03 07:10:30	t	0101000020E610000067101FD8F14552C0617138F3ABC34440
977	22	2008-02-07 08:40:16	2008-02-07 08:42:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
978	22	2008-02-07 08:40:46	2008-02-07 08:42:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
979	22	2008-02-07 08:41:16	2008-02-07 08:43:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
980	22	2008-02-07 08:41:46	2008-02-07 08:43:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
981	22	2008-02-07 08:42:16	2008-02-07 08:44:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
982	22	2008-02-07 08:42:46	2008-02-07 08:44:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
983	22	2008-02-07 08:43:16	2008-02-07 08:45:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
984	22	2008-02-07 08:43:46	2008-02-07 08:45:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
985	22	2008-02-07 08:44:16	2008-02-07 08:46:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
986	22	2008-02-07 08:44:46	2008-02-07 08:46:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
987	22	2008-02-07 08:45:16	2008-02-07 08:47:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
988	22	2008-02-07 08:45:46	2008-02-07 08:47:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
989	22	2008-02-07 08:46:16	2008-02-07 08:48:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
990	22	2008-02-07 08:46:46	2008-02-07 08:48:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
991	22	2008-02-07 08:47:16	2008-02-07 08:49:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
992	22	2008-02-07 08:47:16	2008-02-07 08:49:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
993	22	2008-02-07 08:47:46	2008-02-07 08:49:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
994	22	2008-02-07 08:48:16	2008-02-07 08:50:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
995	22	2008-02-07 08:48:46	2008-02-07 08:50:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
996	22	2008-02-07 08:49:16	2008-02-07 08:51:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
997	22	2008-02-07 08:49:46	2008-02-07 08:51:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
998	22	2008-02-07 08:50:16	2008-02-07 08:52:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
999	22	2008-02-07 08:50:46	2008-02-07 08:52:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1000	22	2008-02-07 08:51:16	2008-02-07 08:53:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1001	22	2008-02-07 08:51:46	2008-02-07 08:53:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1002	22	2008-02-07 08:52:16	2008-02-07 08:54:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1003	22	2008-02-07 08:52:46	2008-02-07 08:54:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1004	22	2008-02-07 08:53:16	2008-02-07 08:55:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1005	22	2008-02-07 08:53:46	2008-02-07 08:55:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1006	22	2008-02-07 08:54:16	2008-02-07 08:56:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1007	22	2008-02-07 08:54:46	2008-02-07 08:56:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1008	22	2008-02-07 08:55:16	2008-02-07 08:57:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1009	22	2008-02-07 08:55:46	2008-02-07 08:57:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1010	22	2008-02-07 08:56:16	2008-02-07 08:58:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1011	22	2008-02-07 08:56:46	2008-02-07 08:58:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1012	22	2008-02-07 08:57:16	2008-02-07 08:59:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1013	22	2008-02-07 08:57:46	2008-02-07 08:59:46	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1014	22	2008-02-07 08:58:16	2008-02-07 09:00:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1015	22	2008-02-07 08:58:46	2008-02-07 09:00:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1016	22	2008-02-07 08:59:16	2008-02-07 09:01:16	t	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1017	22	2008-02-07 08:59:46	2008-02-07 09:01:46	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1018	22	2008-02-07 09:00:16	2008-02-07 09:02:16	f	0101000020E610000060EB5223F44552C0AF42CA4FAAC34440
1019	22	2008-02-07 09:00:46	2008-02-07 09:02:46	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1020	22	2008-02-07 09:01:16	2008-02-07 09:03:16	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1021	22	2008-02-07 09:01:46	2008-02-07 09:03:46	f	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1022	22	2008-02-07 09:01:46	2008-02-07 09:03:46	f	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1023	22	2008-02-07 09:02:16	2008-02-07 09:04:16	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1024	22	2008-02-07 09:02:46	2008-02-07 09:04:46	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1025	22	2008-02-07 09:03:16	2008-02-07 09:05:16	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1026	22	2008-02-07 09:03:46	2008-02-07 09:05:46	t	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1027	22	2008-02-07 09:04:16	2008-02-07 09:06:16	f	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1028	22	2008-02-07 09:04:46	2008-02-07 09:06:46	f	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1029	22	2008-02-07 09:05:16	2008-02-07 09:07:16	f	0101000020E61000007256444DF44552C0AF42CA4FAAC34440
1030	22	2008-02-07 09:05:46	2008-02-07 09:07:46	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1031	22	2008-02-07 09:06:46	2008-02-07 09:08:46	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1032	22	2008-02-07 09:07:16	2008-02-07 09:09:16	t	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1033	22	2008-02-07 09:07:46	2008-02-07 09:09:46	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1034	22	2008-02-07 09:08:16	2008-02-07 09:10:16	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1035	22	2008-02-07 09:08:46	2008-02-07 09:10:46	t	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1036	22	2008-02-07 09:09:16	2008-02-07 09:11:16	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1037	22	2008-02-07 09:09:46	2008-02-07 09:11:46	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1038	22	2008-02-07 09:10:16	2008-02-07 09:12:16	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1039	22	2008-02-07 09:10:46	2008-02-07 09:12:46	t	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1040	22	2008-02-07 09:11:16	2008-02-07 09:13:16	f	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1041	22	2008-02-07 09:11:46	2008-02-07 09:13:46	t	0101000020E61000007256444DF44552C0D318ADA3AAC34440
1042	23	2008-02-03 08:57:21	2008-02-03 08:59:21	t	0101000020E6100000B251D66F262E52C060E5D022DBC74440
1043	23	2008-02-03 09:02:21	2008-02-03 09:04:21	f	0101000020E6100000B2868BDCD32F52C0DB5031CEDFCA4440
1044	23	2008-02-03 09:03:10	2008-02-03 09:05:10	t	0101000020E610000067D65240DA2F52C03FCBF3E0EECA4440
1045	23	2008-02-03 09:08:10	2008-02-03 09:10:10	f	0101000020E61000008DBAD6DEA72E52C0894160E5D0C84440
1046	23	2008-02-03 09:13:10	2008-02-03 09:15:10	t	0101000020E61000009DC0745AB72D52C0D6E253008CC54440
1047	23	2008-02-03 09:14:34	2008-02-03 09:16:34	t	0101000020E61000002E05A4FD0F2E52C05EA27A6B60C54440
1048	23	2008-02-03 09:19:34	2008-02-03 09:21:34	f	0101000020E6100000BC97FBE4282E52C084BBB376DBC74440
1049	23	2008-02-03 09:31:12	2008-02-03 09:33:12	t	0101000020E6100000661A4D2EC63252C0601F9DBAF2CB4440
1050	23	2008-02-03 09:36:12	2008-02-03 09:38:12	t	0101000020E61000007AC8940F413752C03DF20703CFCB4440
1051	23	2008-02-03 09:38:20	2008-02-03 09:40:20	f	0101000020E6100000B959BC58183852C0598638D6C5CB4440
1052	24	2008-02-07 15:34:55	2008-02-07 15:36:55	t	0101000020E6100000B0B2B6291E3152C00E897B2C7DD64440
1053	24	2008-02-07 15:38:41	2008-02-07 15:40:41	t	0101000020E6100000986F7D586F3052C02315C61682D24440
1054	24	2008-02-07 15:39:57	2008-02-07 15:41:57	t	0101000020E61000009588F02F823052C0DE59BBED42D14440
1055	24	2008-02-07 15:44:59	2008-02-07 15:46:59	t	0101000020E610000079D2C265153052C0876D8B321BD24440
1056	24	2008-02-07 15:48:45	2008-02-07 15:50:45	f	0101000020E6100000BE19355F252F52C07AC7293A92D14440
1057	24	2008-02-07 15:50:00	2008-02-07 15:52:00	t	0101000020E6100000DECEBEF2202F52C09D9D0C8E92D14440
1058	24	2008-02-07 15:55:02	2008-02-07 15:57:02	t	0101000020E6100000FE497CEE042F52C09413ED2AA4D24440
1059	24	2008-02-07 15:58:48	2008-02-07 16:00:48	f	0101000020E61000003E9CC0745A2F52C09E6340F67AD54440
1060	24	2008-02-07 16:00:04	2008-02-07 16:02:04	f	0101000020E6100000E14BE141B32F52C072F90FE9B7D54440
1061	24	2008-02-07 16:05:05	2008-02-07 16:07:05	f	0101000020E610000002A08A1BB73052C09CFEEC478AD64440
1062	24	2008-02-07 16:08:51	2008-02-07 16:10:51	t	0101000020E6100000C2FBAA5CA83052C0F31FD26F5FD54440
1063	24	2008-02-07 16:10:07	2008-02-07 16:12:07	f	0101000020E61000009C560A815C3052C073DC291DACD54440
1064	24	2008-02-07 16:15:09	2008-02-07 16:17:09	t	0101000020E61000009DA38E8EAB2F52C0B571C45A7CD44440
1065	24	2008-02-07 16:18:55	2008-02-07 16:20:55	t	0101000020E6100000EB961DE21F3052C0DF4F8D976ED44440
1066	24	2008-02-07 16:20:10	2008-02-07 16:22:10	f	0101000020E6100000D5D00660033052C0919BE1067CD44440
1067	24	2008-02-07 16:25:12	2008-02-07 16:27:12	f	0101000020E610000016FC36C4783152C0D9942BBCCBD34440
1068	24	2008-02-07 16:28:58	2008-02-07 16:30:58	f	0101000020E610000060B69DB6463252C05951836918D44440
1069	24	2008-02-07 16:30:14	2008-02-07 16:32:14	f	0101000020E6100000790C8FFD2C3252C0E700C11C3DD44440
1070	24	2008-02-07 16:35:15	2008-02-07 16:37:15	f	0101000020E6100000ECDE8AC4043152C04850FC1873D54440
1071	24	2008-02-07 16:37:01	2008-02-07 16:39:01	t	0101000020E6100000DBA84E07B23052C0FA7E6ABC74D54440
1072	24	2008-02-07 16:39:01	2008-02-07 16:41:01	t	0101000020E6100000ED6AF294D53052C0327216F6B4D54440
1073	24	2008-02-07 16:40:25	2008-02-07 16:42:25	t	0101000020E6100000B7D782DE1B3152C04D4F58E201D74440
1074	24	2008-02-07 16:45:19	2008-02-07 16:47:19	t	0101000020E610000013329067973152C0EB1C03B2D7D94440
1075	24	2008-02-07 16:49:05	2008-02-07 16:51:05	t	0101000020E610000026B03907CF3052C088DC0C37E0D94440
1076	24	2008-02-07 16:50:20	2008-02-07 16:52:20	f	0101000020E6100000FFD0CC936B3052C0A48D23D6E2D94440
1077	24	2008-02-07 16:55:22	2008-02-07 16:57:22	t	0101000020E610000013BEF737682F52C0BFD4CF9B8ADA4440
1078	24	2008-02-07 16:55:22	2008-02-07 16:57:22	f	0101000020E610000013BEF737682F52C0BFD4CF9B8ADA4440
1079	24	2008-02-07 16:59:08	2008-02-07 17:01:08	t	0101000020E6100000A1168387692F52C0FB5C6DC5FED84440
1080	24	2008-02-07 17:00:24	2008-02-07 17:02:24	f	0101000020E61000008FAB915D692F52C05778978BF8D84440
1081	24	2008-02-07 17:05:25	2008-02-07 17:07:25	f	0101000020E6100000761BD47E6B2F52C0D3D9C9E028D74440
1082	24	2008-02-07 17:10:27	2008-02-07 17:12:27	f	0101000020E61000000C992B836A2F52C0963E74417DD54440
1083	24	2008-02-07 17:15:29	2008-02-07 17:17:29	t	0101000020E61000006BA0F99CBB2F52C058569A9482D44440
1084	24	2008-02-07 17:19:14	2008-02-07 17:21:14	f	0101000020E6100000DA78B0C56E2F52C076711B0DE0D34440
1085	24	2008-02-07 17:20:30	2008-02-07 17:22:30	f	0101000020E61000009EF529C7642F52C0B493C151F2D44440
1086	24	2008-02-07 17:25:32	2008-02-07 17:27:32	f	0101000020E6100000BEC799266C2F52C037C8242367DB4440
1087	24	2008-02-07 17:29:18	2008-02-07 17:31:18	t	0101000020E61000000B2FC1A90F3252C02CBCCB457CDD4440
1088	24	2008-02-07 17:29:18	2008-02-07 17:31:18	t	0101000020E61000000B2FC1A90F3252C02CBCCB457CDD4440
1089	24	2008-02-07 17:30:33	2008-02-07 17:32:33	t	0101000020E610000042F2CEA10C3352C04F75C8CD70DD4440
1090	24	2008-02-07 17:35:35	2008-02-07 17:37:35	t	0101000020E610000091A16307953452C0FE60E0B9F7DE4440
1091	24	2008-02-07 17:39:21	2008-02-07 17:41:21	t	0101000020E6100000D22346CF2D3452C023F8DF4A76DE4440
1092	24	2008-02-07 17:40:37	2008-02-07 17:42:37	t	0101000020E610000078D7D9907F3452C09CC420B072DE4440
1093	24	2008-02-07 17:45:38	2008-02-07 17:47:38	t	0101000020E61000003F58C6866E3652C07A19C5724BDD4440
1094	24	2008-02-07 17:49:24	2008-02-07 17:51:24	t	0101000020E61000008CF9B9A1293952C06E861BF0F9DB4440
1095	24	2008-02-07 17:50:40	2008-02-07 17:52:40	t	0101000020E6100000297FF78E1A3952C0718FA50F5DDA4440
1096	24	2008-02-07 17:55:42	2008-02-07 17:57:42	t	0101000020E61000002AE96168753A52C02849D74CBED74440
1097	24	2008-02-07 17:59:28	2008-02-07 18:01:28	t	0101000020E6100000B5E6C75F5A3C52C012DA722EC5D74440
1098	24	2008-02-07 18:00:43	2008-02-07 18:02:43	t	0101000020E61000007447FFCBB53C52C06744696FF0D74440
1099	24	2008-02-07 18:05:45	2008-02-07 18:07:45	f	0101000020E61000001C9AB2D30F3C52C0CB2DAD86C4D74440
1100	24	2008-02-07 18:30:04	2008-02-07 18:32:04	f	0101000020E61000003777F4BF5C3552C08738D6C56DD64440
1101	24	2008-02-07 18:31:51	2008-02-07 18:33:51	f	0101000020E610000049179B560A3552C0876D8B321BD64440
1102	24	2008-02-07 18:35:05	2008-02-07 18:37:05	t	0101000020E6100000DE770C8FFD3452C0B4E55C8AABD44440
1103	24	2008-02-07 18:40:07	2008-02-07 18:42:07	t	0101000020E6100000D89FC4E74E3452C01F4B1FBAA0D44440
1104	24	2008-02-07 18:41:54	2008-02-07 18:43:54	t	0101000020E61000009D340D8AE63352C02DB29DEFA7D44440
1105	24	2008-02-07 18:45:09	2008-02-07 18:47:09	t	0101000020E6100000570A815CE23252C0D8D825AAB7D44440
1106	24	2008-02-07 18:50:10	2008-02-07 18:52:10	t	0101000020E6100000D292C7D3F23152C08AEAAD81ADD44440
1107	24	2008-02-07 18:51:58	2008-02-07 18:53:58	f	0101000020E61000005E514A08563152C0DFFDF15EB5D44440
1108	24	2008-02-07 18:55:15	2008-02-07 18:57:15	f	0101000020E61000001BDEACC1FB3052C0DFC325C79DD44440
1109	24	2008-02-07 19:00:16	2008-02-07 19:02:16	t	0101000020E6100000C2189128B43052C0166A4DF38ED54440
1110	24	2008-02-07 19:04:01	2008-02-07 19:06:01	t	0101000020E6100000E5DBBB067D2F52C0A4FCA4DAA7D54440
1111	24	2008-02-07 19:05:18	2008-02-07 19:07:18	t	0101000020E6100000D353E410712F52C0DE59BBED42D54440
1112	24	2008-02-07 19:10:20	2008-02-07 19:12:20	f	0101000020E6100000E11115AA9B2F52C06EFAB31F29D44440
1113	24	2008-02-07 19:15:21	2008-02-07 19:17:21	t	0101000020E6100000ACAE4335253152C0D9B11188D7D34440
1114	24	2008-02-07 19:20:23	2008-02-07 19:22:23	t	0101000020E61000007BFD497CEE3052C011018750A5D44440
1115	24	2008-02-07 19:20:23	2008-02-07 19:22:23	t	0101000020E61000007BFD497CEE3052C011018750A5D44440
1116	24	2008-02-07 19:24:08	2008-02-07 19:26:08	f	0101000020E610000085B70721203152C052448655BCD74440
1117	25	2008-02-06 06:23:47	2008-02-06 06:25:47	t	0101000020E610000059350873BB2352C045F5D6C0560B4540
1118	25	2008-02-06 06:23:52	2008-02-06 06:25:52	f	0101000020E610000059350873BB2352C0211FF46C560B4540
1119	25	2008-02-06 06:23:57	2008-02-06 06:25:57	t	0101000020E610000059350873BB2352C0FE481119560B4540
1120	25	2008-02-06 06:24:02	2008-02-06 06:26:02	t	0101000020E610000059350873BB2352C0FE481119560B4540
1121	25	2008-02-06 06:24:07	2008-02-06 06:26:07	f	0101000020E610000059350873BB2352C0DA722EC5550B4540
1122	25	2008-02-06 06:24:12	2008-02-06 06:26:12	f	0101000020E610000059350873BB2352C0B79C4B71550B4540
1123	25	2008-02-06 06:24:17	2008-02-06 06:26:17	f	0101000020E610000048CA1649BB2352C093C6681D550B4540
1124	25	2008-02-06 06:24:22	2008-02-06 06:26:22	f	0101000020E610000048CA1649BB2352C070F085C9540B4540
1125	25	2008-02-06 06:24:32	2008-02-06 06:26:32	t	0101000020E6100000365F251FBB2352C04C1AA375540B4540
1126	25	2008-02-06 06:24:37	2008-02-06 06:26:37	f	0101000020E610000024F433F5BA2352C02844C021540B4540
1127	15	2008-02-03 20:09:40	2008-02-03 20:11:40	t	0101000020E610000007483481223452C0AD342905DDD04440
1128	15	2008-02-03 20:09:43	2008-02-03 20:11:43	f	0101000020E61000005519C6DD203452C02D26361FD7D04440
1129	15	2008-02-03 20:10:05	2008-02-03 20:12:05	t	0101000020E6100000801475E61E3452C051A5660FB4D04440
1130	15	2008-02-03 20:10:51	2008-02-03 20:12:51	f	0101000020E61000006EA983BC1E3452C04A0C022B87D04440
1131	15	2008-02-03 20:11:10	2008-02-03 20:13:10	f	0101000020E61000006EA983BC1E3452C07C2C7DE882D04440
1132	15	2008-02-03 20:12:16	2008-02-03 20:14:16	t	0101000020E6100000A3EA573A1F3452C027A5A0DB4BD04440
1133	15	2008-02-03 20:12:16	2008-02-03 20:14:16	f	0101000020E6100000A3EA573A1F3452C027A5A0DB4BD04440
1134	15	2008-02-03 20:12:53	2008-02-03 20:14:53	f	0101000020E61000001592CCEA1D3452C0C347C49448D04440
1135	15	2008-02-03 20:13:08	2008-02-03 20:15:08	t	0101000020E61000008B5A9A5B213452C00ABABDA431D04440
1136	15	2008-02-03 20:13:11	2008-02-03 20:15:11	t	0101000020E6100000E371512D223452C012DF89592FD04440
1137	15	2008-02-03 20:13:18	2008-02-03 20:15:18	t	0101000020E61000001CD47E6B273452C0AE81AD122CD04440
1138	15	2008-02-03 20:13:24	2008-02-03 20:15:24	f	0101000020E61000005536ACA92C3452C0FC523F6F2AD04440
1139	15	2008-02-03 20:13:33	2008-02-03 20:15:33	f	0101000020E610000075081C09343452C0B58993FB1DD04440
1140	15	2008-02-03 20:13:55	2008-02-03 20:15:55	t	0101000020E6100000B5ACFBC7423452C0B54FC76306D04440
1141	15	2008-02-03 20:14:00	2008-02-03 20:16:00	t	0101000020E61000002A75C938463452C00B46257502D04440
1142	15	2008-02-03 20:14:03	2008-02-03 20:16:03	t	0101000020E6100000A762635E473452C0A7E8482EFFCF4440
1143	15	2008-02-03 20:14:29	2008-02-03 20:16:29	t	0101000020E61000006E3A02B8593452C0672783A3E4CF4440
1144	15	2008-02-03 20:14:40	2008-02-03 20:16:40	f	0101000020E61000008AEB18575C3452C03D0FEECEDACF4440
1145	15	2008-02-03 20:14:48	2008-02-03 20:16:48	t	0101000020E6100000D197DEFE5C3452C02FA86F99D3CF4440
1146	15	2008-02-03 20:15:09	2008-02-03 20:17:09	f	0101000020E610000055AA44D95B3452C02883A3E4D5CF4440
1147	15	2008-02-03 20:15:17	2008-02-03 20:17:17	t	0101000020E6100000C751B9895A3452C0B6F81400E3CF4440
1148	15	2008-02-03 20:15:25	2008-02-03 20:17:25	f	0101000020E6100000E706431D563452C09964E42CECCF4440
1149	15	2008-02-03 20:15:43	2008-02-03 20:17:43	t	0101000020E61000001102F225543452C0FDC1C073EFCF4440
1150	15	2008-02-03 20:15:49	2008-02-03 20:17:49	t	0101000020E6100000AEA415DF503452C0124E0B5EF4CF4440
1151	15	2008-02-03 20:16:45	2008-02-03 20:18:45	f	0101000020E61000003260C9552C3452C0F52D73BA2CD04440
1152	15	2008-02-03 20:16:48	2008-02-03 20:18:48	t	0101000020E6100000A3073E062B3452C01904560E2DD04440
1153	15	2008-02-03 20:17:47	2008-02-03 20:19:47	t	0101000020E610000095A0BFD0233452C060B01BB62DD04440
1154	15	2008-02-03 20:17:51	2008-02-03 20:19:51	f	0101000020E61000005519C6DD203452C02E90A0F831D04440
1155	15	2008-02-03 20:17:54	2008-02-03 20:19:54	f	0101000020E6100000C7C03A8E1F3452C0D274763238D04440
1156	15	2008-02-03 20:18:38	2008-02-03 20:20:38	t	0101000020E6100000E775C4211B3452C01092054CE0D04440
1157	15	2008-02-03 20:18:41	2008-02-03 20:20:41	t	0101000020E6100000AE1397E3153452C0096D3997E2D04440
1158	15	2008-02-03 20:18:56	2008-02-03 20:20:56	t	0101000020E61000001D60E63BF83352C02D431CEBE2D04440
1159	15	2008-02-03 20:19:06	2008-02-03 20:21:06	t	0101000020E61000006B1492CCEA3352C097E2AAB2EFD04440
1160	15	2008-02-03 20:21:35	2008-02-03 20:23:35	t	0101000020E6100000D0B9DBF5D23252C0C217265305D14440
1161	15	2008-02-03 20:22:02	2008-02-03 20:24:02	f	0101000020E6100000DFE68D93C23252C009C4EBFA05D14440
1162	15	2008-02-03 20:22:02	2008-02-03 20:24:02	f	0101000020E6100000DFE68D93C23252C009C4EBFA05D14440
1163	15	2008-02-03 20:23:13	2008-02-03 20:25:13	f	0101000020E610000006871744A43252C0BBF2599E07D14440
1164	15	2008-02-03 20:24:00	2008-02-03 20:26:00	t	0101000020E6100000B4942C27A13252C0BBF2599E07D14440
1165	15	2008-02-03 20:24:10	2008-02-03 20:26:10	t	0101000020E61000005F81E849993252C0744694F606D14440
1166	15	2008-02-03 20:25:34	2008-02-03 20:27:34	f	0101000020E61000000D5531957E3252C057957D5704D14440
1167	15	2008-02-03 20:25:39	2008-02-03 20:27:39	f	0101000020E61000006D91B41B7D3252C0ED12D55B03D14440
1168	15	2008-02-03 20:25:42	2008-02-03 20:27:42	t	0101000020E6100000030F0C207C3252C04209336DFFD04440
1169	15	2008-02-03 20:26:36	2008-02-03 20:28:36	f	0101000020E6100000469A7807783252C0D82AC1E270D04440
1170	15	2008-02-03 20:26:52	2008-02-03 20:28:52	t	0101000020E6100000469A7807783252C02E211FF46CD04440
1171	15	2008-02-03 20:26:52	2008-02-03 20:28:52	f	0101000020E6100000469A7807783252C02E211FF46CD04440
1172	15	2008-02-03 20:27:15	2008-02-03 20:29:15	t	0101000020E6100000ED82C135773252C0994C158C4AD04440
1173	15	2008-02-03 20:27:59	2008-02-03 20:29:59	t	0101000020E6100000CAACDEE1763252C0431CEBE236D04440
1174	15	2008-02-03 20:29:32	2008-02-03 20:31:32	f	0101000020E6100000BF66B96C743252C0BD1DE1B4E0CF4440
1175	15	2008-02-03 20:30:23	2008-02-03 20:32:23	t	0101000020E6100000664F029B733252C0C49448A297CF4440
1176	15	2008-02-03 20:30:59	2008-02-03 20:32:59	f	0101000020E6100000664F029B733252C0C49448A297CF4440
1177	15	2008-02-03 20:31:20	2008-02-03 20:33:20	t	0101000020E6100000B52094F7713252C09A99999999CF4440
1178	15	2008-02-03 20:31:40	2008-02-03 20:33:40	f	0101000020E6100000EA616875723252C021240B98C0CF4440
1179	15	2008-02-03 20:31:40	2008-02-03 20:33:40	t	0101000020E6100000EA616875723252C021240B98C0CF4440
1180	15	2008-02-03 20:31:43	2008-02-03 20:33:43	f	0101000020E6100000914AB1A3713252C0D252793BC2CF4440
1181	15	2008-02-03 20:31:43	2008-02-03 20:33:43	t	0101000020E6100000914AB1A3713252C0D252793BC2CF4440
1182	15	2008-02-03 20:31:46	2008-02-03 20:33:46	f	0101000020E6100000AADA6E826F3252C03DD52137C3CF4440
1183	15	2008-02-03 20:31:59	2008-02-03 20:33:59	f	0101000020E6100000B80721205F3252C03DD52137C3CF4440
1184	15	2008-02-03 20:32:02	2008-02-03 20:34:02	t	0101000020E610000007D9B27C5D3252C0F6285C8FC2CF4440
1185	15	2008-02-03 20:32:42	2008-02-03 20:34:42	t	0101000020E6100000EE48F59D5F3252C0A857CA32C4CF4440
1186	15	2008-02-03 20:32:52	2008-02-03 20:34:52	t	0101000020E6100000EE65DB696B3252C03DD52137C3CF4440
1187	15	2008-02-03 20:32:57	2008-02-03 20:34:57	f	0101000020E6100000EA616875723252C0A857CA32C4CF4440
1188	15	2008-02-03 20:33:00	2008-02-03 20:35:00	t	0101000020E61000008A25E5EE733252C0BDE3141DC9CF4440
1189	15	2008-02-03 20:33:40	2008-02-03 20:35:40	f	0101000020E61000003C545392753252C0BCAE5FB01BD04440
1190	15	2008-02-03 20:34:27	2008-02-03 20:36:27	t	0101000020E61000004DBF44BC753252C019E76F4221D04440
1191	15	2008-02-03 20:35:04	2008-02-03 20:37:04	f	0101000020E6100000FFEDB25F773252C083FA96395DD04440
1192	15	2008-02-08 16:00:24	2008-02-08 16:02:24	f	0101000020E61000002D0FD253E42652C0AD69DE718AD84440
1193	15	2008-02-08 16:00:35	2008-02-08 16:02:35	t	0101000020E61000002D0FD253E42652C08A93FB1D8AD84440
1194	15	2008-02-08 16:00:52	2008-02-08 16:02:52	f	0101000020E610000086268925E52652C07B832F4CA6D84440
1195	15	2008-02-08 16:00:55	2008-02-08 16:02:55	f	0101000020E61000003755F7C8E62652C02DB29DEFA7D84440
1196	15	2008-02-08 16:01:17	2008-02-08 16:03:17	f	0101000020E6100000DB73999A042752C0CA54C1A8A4D84440
1197	15	2008-02-08 16:01:29	2008-02-08 16:03:29	t	0101000020E61000009E2ADF33122752C066DAFE9595D84440
1198	15	2008-02-08 16:01:42	2008-02-08 16:03:42	t	0101000020E61000000288BB7A152752C011AAD4EC81D84440
1199	15	2008-02-08 16:01:48	2008-02-08 16:03:48	t	0101000020E61000003EEE5BAD132752C09FE5797077D84440
1200	15	2008-02-08 16:01:54	2008-02-08 16:03:54	f	0101000020E610000034A83638112752C0A7ED5F5969D84440
1201	26	2008-02-05 00:50:42	2008-02-05 00:52:42	t	0101000020E6100000EFCA2E185C2F52C06A520ABABDDA4440
1202	26	2008-02-05 00:54:28	2008-02-05 00:56:28	f	0101000020E6100000EFCA2E185C2F52C01B81785DBFDA4440
1203	26	2008-02-05 00:55:44	2008-02-05 00:57:44	f	0101000020E6100000EFCA2E185C2F52C01B81785DBFDA4440
1204	26	2008-02-05 01:00:45	2008-02-05 01:02:45	t	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1205	26	2008-02-05 01:04:31	2008-02-05 01:06:31	f	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1206	26	2008-02-05 01:05:47	2008-02-05 01:07:47	t	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1207	26	2008-02-05 01:10:49	2008-02-05 01:12:49	t	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1208	26	2008-02-05 01:14:35	2008-02-05 01:16:35	t	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1209	26	2008-02-05 01:15:50	2008-02-05 01:17:50	f	0101000020E6100000EFCA2E185C2F52C05B087250C2DA4440
1210	26	2008-02-05 01:20:52	2008-02-05 01:22:52	f	0101000020E61000001E041DAD6A2F52C0BD8C62B9A5D74440
1211	26	2008-02-05 01:24:38	2008-02-05 01:26:38	f	0101000020E61000007A59130B7C2F52C0639CBF0985D64440
1212	26	2008-02-05 01:25:54	2008-02-05 01:27:54	t	0101000020E61000007A59130B7C2F52C0639CBF0985D64440
1213	26	2008-02-05 01:30:55	2008-02-05 01:32:55	t	0101000020E610000048FFCBB5682F52C05665DF15C1D54440
1214	26	2008-02-05 01:40:59	2008-02-05 01:42:59	t	0101000020E6100000375A0EF4502F52C037FDD98F14D34440
1215	26	2008-02-05 01:44:45	2008-02-05 01:46:45	f	0101000020E61000000C7C45B75E2F52C010971C774AD54440
1216	26	2008-02-05 01:46:00	2008-02-05 01:48:00	t	0101000020E6100000414E98309A2F52C048FE60E0B9D54440
1217	26	2008-02-05 01:51:02	2008-02-05 01:53:02	t	0101000020E6100000AE872F13453252C0B3632310AFD54440
1218	26	2008-02-05 01:51:02	2008-02-05 01:53:02	t	0101000020E6100000AE872F13453252C0B3632310AFD54440
1219	26	2008-02-05 01:54:48	2008-02-05 01:56:48	f	0101000020E61000008A08FF22683452C04165FCFB8CD54440
1220	26	2008-02-05 01:56:04	2008-02-05 01:58:04	t	0101000020E61000007F703E75AC3452C0ACE7A4F78DD54440
1221	26	2008-02-05 02:01:05	2008-02-05 02:03:05	f	0101000020E61000008B5A9A5B213852C06458C51B99D54440
1222	26	2008-02-05 02:04:51	2008-02-05 02:06:51	t	0101000020E61000002BC24D46953952C00F62670A9DD54440
1223	26	2008-02-05 07:34:58	2008-02-05 07:36:58	t	0101000020E6100000C122BF7E883B52C0AED85F764FD84440
1224	26	2008-02-05 07:39:51	2008-02-05 07:41:51	t	0101000020E61000001AC6DD205A3B52C06CB2463D44D94440
1225	26	2008-02-05 07:40:00	2008-02-05 07:42:00	f	0101000020E6100000DE5F3DEE5B3B52C0650113B875D94440
1226	26	2008-02-05 07:45:01	2008-02-05 07:47:01	f	0101000020E6100000F85965A6B43852C0F20703CFBDD94440
1227	26	2008-02-05 07:50:03	2008-02-05 07:52:03	t	0101000020E610000087562767283652C0249C16BCE8D94440
1228	26	2008-02-05 07:55:05	2008-02-05 07:57:05	f	0101000020E6100000D23B1570CF3552C07DB3CD8DE9DB4440
1229	26	2008-02-05 07:59:58	2008-02-05 08:01:58	t	0101000020E6100000A5C343183F3552C05F6397A8DEDC4440
1230	26	2008-02-05 08:00:06	2008-02-05 08:02:06	t	0101000020E6100000ACE80FCD3C3552C05F29CB10C7DC4440
1231	26	2008-02-05 08:05:08	2008-02-05 08:07:08	t	0101000020E6100000A2681EC0223552C07F18213CDADA4440
1232	26	2008-02-05 08:10:01	2008-02-05 08:12:01	t	0101000020E6100000653C4A253C3152C094A46B26DFDA4440
1233	26	2008-02-05 08:20:05	2008-02-05 08:22:05	t	0101000020E6100000F69D5F94A03152C0BABDA4315AD54440
1234	26	2008-02-05 08:20:13	2008-02-05 08:22:13	f	0101000020E61000001A7442E8A03152C017D9CEF753D54440
1235	26	2008-02-05 08:25:15	2008-02-05 08:27:15	f	0101000020E6100000339067976F2F52C03A7AFCDEA6D54440
1236	26	2008-02-05 08:30:08	2008-02-05 08:32:08	f	0101000020E61000003A984D80612F52C03641D47D00D84440
1237	26	2008-02-05 08:30:16	2008-02-05 08:32:16	f	0101000020E610000017C26A2C612F52C02E73BA2C26D84440
1238	26	2008-02-05 08:40:19	2008-02-05 08:42:19	t	0101000020E610000034FAD170CA2E52C025CCB4FD2BDD4440
1239	26	2008-02-05 08:45:20	2008-02-05 08:47:20	t	0101000020E610000034FAD170CA2E52C025CCB4FD2BDD4440
1240	26	2008-02-05 08:50:14	2008-02-05 08:52:14	f	0101000020E61000004969368FC32E52C07BC2120F28DD4440
1241	26	2008-02-05 08:50:22	2008-02-05 08:52:22	t	0101000020E61000001B4D2EC6C02E52C0A5BDC11726DD4440
1242	26	2008-02-05 08:55:24	2008-02-05 08:57:24	t	0101000020E610000020BB0B94143052C0FCC6D79E59DC4440
1243	26	2008-02-05 09:00:17	2008-02-05 09:02:17	f	0101000020E6100000706072A3C83052C0857CD0B359DB4440
1244	26	2008-02-05 09:00:25	2008-02-05 09:02:25	f	0101000020E6100000706072A3C83052C0857CD0B359DB4440
1245	26	2008-02-05 09:05:27	2008-02-05 09:07:27	t	0101000020E6100000661A4D2EC63052C0D34D621058DB4440
1246	26	2008-02-05 09:10:29	2008-02-05 09:12:29	f	0101000020E6100000661A4D2EC63052C0D34D621058DB4440
1247	26	2008-02-05 09:15:30	2008-02-05 09:17:30	f	0101000020E6100000661A4D2EC63052C0D34D621058DB4440
1248	26	2008-02-05 09:20:23	2008-02-05 09:22:23	t	0101000020E61000001F69705B5B3052C0B4C876BE9FDC4440
1249	26	2008-02-05 09:20:23	2008-02-05 09:22:23	f	0101000020E61000001F69705B5B3052C0B4C876BE9FDC4440
1250	26	2008-02-05 09:20:32	2008-02-05 09:22:32	f	0101000020E610000031D461855B3052C0D89E5912A0DC4440
1251	26	2008-02-05 09:25:33	2008-02-05 09:27:33	f	0101000020E61000008D63247B843052C01E166A4DF3DC4440
1252	26	2008-02-05 09:30:27	2008-02-05 09:32:27	f	0101000020E61000005649641F643152C019ADA3AA09E04440
1253	26	2008-02-05 09:30:35	2008-02-05 09:32:35	f	0101000020E610000065EAAEEC823152C0D200DE0209E04440
1254	26	2008-02-05 09:35:37	2008-02-05 09:37:37	f	0101000020E6100000C9258E3C103352C03411363CBDE04440
1255	26	2008-02-05 09:40:30	2008-02-05 09:42:30	t	0101000020E6100000394BC972123252C03D49BA66F2DF4440
1256	26	2008-02-05 09:45:40	2008-02-05 09:47:40	f	0101000020E610000066321CCF673252C069AED3484BDF4440
1257	26	2008-02-05 09:50:33	2008-02-05 09:52:33	f	0101000020E6100000B6DC9909863152C0ACADD85F76DD4440
1258	26	2008-02-05 09:50:42	2008-02-05 09:52:42	t	0101000020E61000008FC87729753152C0DEEA39E97DDD4440
1259	26	2008-02-05 09:55:43	2008-02-05 09:57:43	t	0101000020E61000005649641F642F52C0EC8B84B69CD94440
1260	26	2008-02-05 10:00:45	2008-02-05 10:02:45	t	0101000020E6100000E19D7C7A6C2F52C024624A24D1D54440
1261	26	2008-02-05 10:05:47	2008-02-05 10:07:47	f	0101000020E61000005E34643C4A2F52C001C11C3D7ED54440
1262	26	2008-02-05 10:10:40	2008-02-05 10:12:40	f	0101000020E610000097B377465B2F52C01C7C613255D64440
1263	26	2008-02-05 10:10:48	2008-02-05 10:12:48	t	0101000020E6100000013620425C2F52C05C3D27BD6FD64440
1264	26	2008-02-05 10:15:50	2008-02-05 10:17:50	t	0101000020E610000093CCEA1D6E2F52C04DDBBFB2D2D64440
1265	26	2008-02-05 10:20:43	2008-02-05 10:22:43	f	0101000020E6100000F611F8C3CF2F52C01D774A07EBD54440
1266	27	2008-02-03 00:13:28	2008-02-03 00:15:28	t	0101000020E6100000541EDD088B3252C0704221020EE74440
1267	27	2008-02-03 00:15:32	2008-02-03 00:17:32	t	0101000020E6100000ADFBC742743252C04AB54FC763E84440
1268	27	2008-02-03 00:18:29	2008-02-03 00:20:29	f	0101000020E6100000312B14E97E3252C05D38109205EA4440
1269	27	2008-02-03 00:18:29	2008-02-03 00:20:29	t	0101000020E6100000312B14E97E3252C05D38109205EA4440
1270	27	2008-02-03 00:23:31	2008-02-03 00:25:31	t	0101000020E61000007FE4D6A4DB3252C086032159C0EA4440
1271	27	2008-02-03 00:25:35	2008-02-03 00:27:35	f	0101000020E610000051FD8348863252C0E99AC937DBEA4440
1272	27	2008-02-03 00:28:33	2008-02-03 00:30:33	f	0101000020E6100000956B0A64763252C0184339D1AEE84440
1273	27	2008-02-03 00:30:37	2008-02-03 00:32:37	t	0101000020E6100000189B560A813252C0454772F90FE74440
1274	27	2008-02-03 00:33:34	2008-02-03 00:35:34	f	0101000020E61000002012BEF7373252C06B9A779CA2E54440
1275	27	2008-02-03 00:35:38	2008-02-03 00:37:38	f	0101000020E61000000AA359D93E3252C05A4C6C3EAEE34440
1276	28	2008-02-05 16:28:56	2008-02-05 16:30:56	f	0101000020E6100000BA54A52DAE3552C0C8293A92CBD94440
1277	28	2008-02-05 16:34:01	2008-02-05 16:36:01	f	0101000020E6100000DA5BCAF9623552C090831266DAD84440
1278	28	2008-02-05 16:35:00	2008-02-05 16:37:00	t	0101000020E6100000FE31AD4D633552C0DF54A4C2D8D84440
1279	28	2008-02-05 16:39:01	2008-02-05 16:41:01	t	0101000020E610000052DB8651103452C0C9E53FA4DFD84440
1280	28	2008-02-05 16:40:01	2008-02-05 16:42:01	f	0101000020E61000004FD2FC31AD3352C074EFE192E3D84440
1281	28	2008-02-05 16:44:04	2008-02-05 16:46:04	t	0101000020E6100000A1F99CBB5D3352C0E162450DA6D74440
1282	28	2008-02-05 16:45:03	2008-02-05 16:47:03	f	0101000020E6100000935852EE3E3352C08C4F01309ED74440
1283	28	2008-02-05 16:45:03	2008-02-05 16:47:03	t	0101000020E6100000935852EE3E3352C08C4F01309ED74440
1284	28	2008-02-05 16:49:05	2008-02-05 16:51:05	t	0101000020E6100000FBEE5696E83252C0C04351A04FD64440
1285	28	2008-02-05 16:50:05	2008-02-05 16:52:05	f	0101000020E61000000D5A48C0E83252C0DDEF5014E8D54440
1286	28	2008-02-05 16:54:09	2008-02-05 16:56:09	t	0101000020E61000003F3BE0BA623252C016A4198BA6D54440
1287	28	2008-02-05 16:55:06	2008-02-05 16:57:06	f	0101000020E6100000D65C6E30D43152C0C1ADBB79AAD54440
1288	28	2008-02-05 16:59:08	2008-02-05 17:01:08	t	0101000020E6100000FEA02E52283152C0DE59BBED42D54440
1289	28	2008-02-05 17:00:08	2008-02-05 17:02:08	f	0101000020E6100000026BD5AE093152C0A6F27684D3D44440
1290	28	2008-02-05 17:04:11	2008-02-05 17:06:11	t	0101000020E6100000C6909C4CDC3052C0E5F21FD26FD54440
1291	28	2008-02-05 17:09:11	2008-02-05 17:11:11	t	0101000020E61000009CADBCE47F3052C04F0647C9ABD54440
1292	28	2008-02-05 17:10:11	2008-02-05 17:12:11	f	0101000020E6100000BCEEAD484C3052C06B9A779CA2D54440
1293	28	2008-02-05 17:14:14	2008-02-05 17:16:14	f	0101000020E61000005C43A9BD883052C0F3936A9F8ED54440
1294	28	2008-02-05 17:15:13	2008-02-05 17:17:13	t	0101000020E6100000C6C551B9893052C0CFBD874B8ED54440
1295	28	2008-02-05 17:19:15	2008-02-05 17:21:15	f	0101000020E6100000297FF78E1A3152C02332ACE28DD64440
1296	28	2008-02-05 17:20:15	2008-02-05 17:22:15	t	0101000020E6100000B0B2B6291E3152C01427F73B14D74440
1297	28	2008-02-05 17:24:17	2008-02-05 17:26:17	f	0101000020E6100000FEA02E52283152C02DEC6987BFD84440
1298	28	2008-02-05 17:25:16	2008-02-05 17:27:16	f	0101000020E61000007A8EC877293152C025CCB4FD2BD94440
1299	28	2008-02-05 17:29:18	2008-02-05 17:31:18	t	0101000020E61000002563B5F97F3152C06A4DF38E53DA4440
1300	28	2008-02-05 17:30:18	2008-02-05 17:32:18	t	0101000020E61000004BCE893DB43152C063B9A5D590DA4440
1301	28	2008-02-05 17:34:21	2008-02-05 17:36:21	f	0101000020E610000044A9BD88B63152C0A2EE0390DADA4440
1302	28	2008-02-05 17:35:20	2008-02-05 17:37:20	f	0101000020E610000044A9BD88B63152C0A2EE0390DADA4440
1303	28	2008-02-05 17:39:21	2008-02-05 17:41:21	t	0101000020E6100000F77B629D2A3152C0895E46B1DCD84440
1304	28	2008-02-05 17:40:21	2008-02-05 17:42:21	t	0101000020E6100000E51071732A3152C03546EBA86AD84440
1305	28	2008-02-05 17:44:24	2008-02-05 17:46:24	t	0101000020E61000004E11E0F42E3252C092CB7F48BFD74440
1306	28	2008-02-05 17:45:23	2008-02-05 17:47:23	t	0101000020E61000003148FAB48A3252C0E19C11A5BDD74440
1307	28	2008-02-05 17:49:25	2008-02-05 17:51:25	t	0101000020E6100000128942CBBA3352C0E86A2BF697D74440
1308	28	2008-02-05 17:50:25	2008-02-05 17:52:25	t	0101000020E610000060251FBB0B3452C08CF84ECC7AD74440
1309	28	2008-02-05 17:54:30	2008-02-05 17:56:30	f	0101000020E6100000582250FD833452C063F3716DA8D64440
1310	28	2008-02-05 17:55:26	2008-02-05 17:57:26	f	0101000020E61000006A8D4127843452C006BB61DBA2D64440
1311	28	2008-02-05 17:59:28	2008-02-05 18:01:28	f	0101000020E61000009470218FE03452C0E38DCC237FD64440
1312	28	2008-02-05 18:00:28	2008-02-05 18:02:28	t	0101000020E61000001BDEACC1FB3452C0DC68006F81D64440
1313	28	2008-02-05 18:09:31	2008-02-05 18:11:31	f	0101000020E61000003BB01C21033552C0B3632310AFD54440
1314	28	2008-02-05 18:10:31	2008-02-05 18:12:31	f	0101000020E61000003BB01C21033552C0B3632310AFD54440
1315	28	2008-02-05 18:15:33	2008-02-05 18:17:33	f	0101000020E610000090A67A32FF3452C03468E89FE0D44440
1316	28	2008-02-05 18:19:35	2008-02-05 18:21:35	f	0101000020E610000049FAB48AFE3452C0D1B359F5B9D44440
1317	28	2008-02-05 18:20:35	2008-02-05 18:22:35	f	0101000020E61000005B65A6B4FE3452C0D8D825AAB7D44440
1318	28	2008-02-05 18:24:37	2008-02-05 18:26:37	t	0101000020E610000014B9E00CFE3452C067F2CD3637D44440
1319	28	2008-02-05 18:25:36	2008-02-05 18:27:36	t	0101000020E6100000856055BDFC3452C0CBDB114E0BD44440
1320	28	2008-02-05 18:29:38	2008-02-05 18:31:38	t	0101000020E6100000DE770C8FFD3452C0C503CAA65CD34440
1321	28	2008-02-05 18:30:38	2008-02-05 18:32:38	f	0101000020E61000002524D236FE3452C09B94826E2FD34440
1322	28	2008-02-05 18:34:41	2008-02-05 18:36:41	t	0101000020E610000018D522A2983452C01CD3139678D24440
1323	28	2008-02-05 18:35:40	2008-02-05 18:37:40	t	0101000020E610000026AB22DC643452C0553541D47DD24440
1324	28	2008-02-05 18:39:41	2008-02-05 18:41:41	f	0101000020E61000006784B707213452C057CF49EF1BD14440
1325	28	2008-02-05 18:40:41	2008-02-05 18:42:41	t	0101000020E61000003968AF3E1E3452C051A04FE449D04440
1326	28	2008-02-05 18:44:44	2008-02-05 18:46:44	t	0101000020E6100000A003CB11323452C05A2F8672A2CF4440
1327	28	2008-02-05 18:45:43	2008-02-05 18:47:43	t	0101000020E6100000590053060E3452C076ABE7A4F7CF4440
1328	28	2008-02-05 18:49:45	2008-02-05 18:51:45	t	0101000020E610000061AC6F60723352C00B9DD7D825D04440
1329	28	2008-02-05 18:50:45	2008-02-05 18:52:45	f	0101000020E6100000C443183F8D3352C012DF89592FD04440
1330	28	2008-02-05 18:50:45	2008-02-05 18:52:45	t	0101000020E6100000C443183F8D3352C012DF89592FD04440
1331	28	2008-02-05 18:54:52	2008-02-05 18:56:52	t	0101000020E61000009167976F7D3452C012143FC6DCCF4440
1332	28	2008-02-05 18:55:46	2008-02-05 18:57:46	f	0101000020E6100000742A1900AA3452C068D0D03FC1CF4440
1333	28	2008-02-05 18:59:48	2008-02-05 19:01:48	f	0101000020E610000099C11891283452C0202922C32AD04440
1334	28	2008-02-05 19:00:48	2008-02-05 19:02:48	f	0101000020E610000075CE4F711C3452C0D9D30E7F4DD04440
1335	28	2008-02-05 19:04:50	2008-02-05 19:06:50	t	0101000020E61000004AF086342A3252C0F4FDD478E9D04440
1336	28	2008-02-05 19:05:50	2008-02-05 19:07:50	f	0101000020E6100000018DD2A57F3152C0C2DD59BBEDD04440
1337	28	2008-02-05 19:09:51	2008-02-05 19:11:51	t	0101000020E6100000193F8D7BF32F52C073A25D8594D14440
1338	28	2008-02-05 19:10:51	2008-02-05 19:12:51	f	0101000020E6100000CFE0EF17B32F52C0967840D994D14440
1339	28	2008-02-05 19:15:02	2008-02-05 19:17:02	t	0101000020E6100000AABD88B6632E52C05760C8EA56D14440
1340	28	2008-02-05 19:15:02	2008-02-05 19:17:02	f	0101000020E6100000AABD88B6632E52C05760C8EA56D14440
1341	29	2008-02-02 13:45:23	2008-02-02 13:47:23	t	0101000020E6100000E73BF889032052C0EACF7EA488E24440
1342	29	2008-02-02 13:45:23	2008-02-02 13:47:23	t	0101000020E6100000E73BF889032052C0EACF7EA488E24440
1343	29	2008-02-02 13:50:23	2008-02-02 13:52:23	f	0101000020E6100000E73BF889032052C0EACF7EA488E24440
1344	29	2008-02-02 13:55:23	2008-02-02 13:57:23	t	0101000020E6100000E73BF889032052C0C6F99B5088E24440
1345	29	2008-02-02 14:00:23	2008-02-02 14:02:23	f	0101000020E6100000E73BF889032052C0C6F99B5088E24440
1346	29	2008-02-02 14:05:23	2008-02-02 14:07:23	f	0101000020E6100000E73BF889032052C0C6F99B5088E24440
1347	29	2008-02-02 14:10:23	2008-02-02 14:12:23	t	0101000020E6100000E73BF889032052C0EACF7EA488E24440
1348	29	2008-02-02 14:20:23	2008-02-02 14:22:23	t	0101000020E6100000E73BF889032052C00DA661F888E24440
1349	29	2008-02-02 14:25:22	2008-02-02 14:27:22	t	0101000020E6100000E73BF889032052C00DA661F888E24440
1350	29	2008-02-02 14:30:22	2008-02-02 14:32:22	f	0101000020E6100000E73BF889032052C00DA661F888E24440
1351	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1352	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1353	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1354	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1355	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1356	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1357	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1358	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1359	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1360	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1361	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1362	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1363	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1364	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1365	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1366	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1367	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1368	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1369	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1370	30	2008-02-03 01:27:56	2008-02-03 01:29:56	t	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1371	30	2008-02-03 01:27:56	2008-02-03 01:29:56	f	0101000020E61000000B0DC4B2993552C0BD6F7CED99D34440
1372	30	2008-02-03 10:15:00	2008-02-03 10:17:00	f	0101000020E6100000768F6CAE9A3552C09A99999999D34440
1373	30	2008-02-03 10:20:02	2008-02-03 10:22:02	t	0101000020E6100000BD3B32569B3552C08C4F01309ED34440
1374	30	2008-02-03 10:20:11	2008-02-03 10:22:11	t	0101000020E61000009A654F029B3552C068791EDC9DD34440
1375	30	2008-02-03 10:25:03	2008-02-03 10:27:03	t	0101000020E6100000126C5CFFAE3552C09279E40F06D44440
1376	30	2008-02-03 10:30:05	2008-02-03 10:32:05	f	0101000020E6100000B22FD978B03552C08A3C49BA66D44440
1377	30	2008-02-03 10:40:08	2008-02-03 10:42:08	t	0101000020E6100000590053060E3652C0DC4B1AA375D64440
1378	30	2008-02-03 10:40:25	2008-02-03 10:42:25	t	0101000020E6100000DC2F9FAC183652C0EA5BE67459D64440
1379	30	2008-02-03 10:45:10	2008-02-03 10:47:10	t	0101000020E6100000F56DC1525D3652C0ADA8C1340CD54440
1380	30	2008-02-03 10:50:11	2008-02-03 10:52:11	t	0101000020E6100000ECDE8AC4043752C0C2FA3F87F9D44440
1381	30	2008-02-03 10:53:30	2008-02-03 10:55:30	t	0101000020E61000003B765089EB3652C04356B77A4ED44440
1382	30	2008-02-03 10:55:13	2008-02-03 10:57:13	f	0101000020E6100000CAE6AA798E3652C0431CEBE236D44440
1383	30	2008-02-03 10:58:32	2008-02-03 11:00:32	t	0101000020E61000008A5FB1868B3652C0FBCBEEC9C3D44440
1384	30	2008-02-03 11:03:33	2008-02-03 11:05:33	t	0101000020E6100000AEC1FBAA5C3652C0E0DBF4673FD44440
1385	30	2008-02-03 11:05:16	2008-02-03 11:07:16	f	0101000020E610000087CABF96573652C06F9EEA909BD34440
1386	30	2008-02-03 11:10:18	2008-02-03 11:12:18	t	0101000020E61000002C836A83133752C045F5D6C056D34440
1387	30	2008-02-03 11:15:20	2008-02-03 11:17:20	f	0101000020E610000055C72AA5673652C0139B8F6B43D34440
1388	30	2008-02-03 11:19:37	2008-02-03 11:21:37	t	0101000020E610000083C64CA25E3652C0E1EEACDD76D34440
1389	30	2008-02-03 11:20:21	2008-02-03 11:22:21	t	0101000020E6100000715B5B785E3652C005E275FD82D34440
1390	30	2008-02-03 11:24:38	2008-02-03 11:26:38	f	0101000020E610000063BA10AB3F3652C09391B3B0A7D34440
1391	30	2008-02-03 11:25:23	2008-02-03 11:27:23	t	0101000020E61000006EA983BC1E3652C044C02154A9D34440
1392	30	2008-02-03 11:25:23	2008-02-03 11:27:23	f	0101000020E61000006EA983BC1E3652C044C02154A9D34440
1393	30	2008-02-03 11:30:25	2008-02-03 11:32:25	t	0101000020E61000003DBEBD6BD03552C0E0A128D027D44440
1394	30	2008-02-03 11:35:12	2008-02-03 11:37:12	t	0101000020E61000008413D1AFAD3552C005FF5BC98ED34440
1395	30	2008-02-03 11:35:12	2008-02-03 11:37:12	f	0101000020E61000008413D1AFAD3552C005FF5BC98ED34440
1396	30	2008-02-03 11:40:27	2008-02-03 11:42:27	f	0101000020E6100000B1A888D3493652C0A110018750D34440
1397	30	2008-02-03 11:46:46	2008-02-03 11:48:46	f	0101000020E6100000FB97A432C53652C0213CDA3862D34440
1398	30	2008-02-03 11:50:30	2008-02-03 11:52:30	f	0101000020E6100000E298654F023752C05322895E46D34440
1399	30	2008-02-03 12:15:02	2008-02-03 12:17:02	f	0101000020E6100000F9E0B54B1B3852C0C05B2041F1CD4440
1400	30	2008-02-03 12:20:04	2008-02-03 12:22:04	f	0101000020E61000009566F3380C3852C079AF5A99F0CD4440
1401	30	2008-02-03 12:25:06	2008-02-03 12:27:06	f	0101000020E6100000157AFD497C3852C03FAE0D15E3CE4440
1402	30	2008-02-03 12:30:07	2008-02-03 12:32:07	t	0101000020E6100000DE94F25A093952C023DBF97E6AD24440
1403	30	2008-02-03 12:35:09	2008-02-03 12:37:09	f	0101000020E6100000BB10AB3FC23852C059A835CD3BD44440
1404	30	2008-02-03 12:40:11	2008-02-03 12:42:11	f	0101000020E610000075081C09343852C0E700C11C3DD44440
1405	30	2008-02-03 12:41:38	2008-02-03 12:43:38	t	0101000020E6100000CA552C7E533852C00AF4893C49D44440
1406	30	2008-02-03 12:45:12	2008-02-03 12:47:12	t	0101000020E6100000E758DE550F3852C0AD86C43D96D44440
1407	30	2008-02-03 12:50:14	2008-02-03 12:52:14	f	0101000020E610000040FCFCF7E03752C0A08EC70C54D44440
1408	30	2008-02-03 12:55:16	2008-02-03 12:57:16	f	0101000020E6100000E2B54B1B0E3752C0BC22F8DF4AD44440
1409	30	2008-02-03 12:56:43	2008-02-03 12:58:43	t	0101000020E6100000D76F26A60B3752C0B5E0455F41D44440
1410	30	2008-02-03 13:00:17	2008-02-03 13:02:17	t	0101000020E61000004EF4F928233652C0433EE8D9ACD44440
1411	30	2008-02-03 13:03:56	2008-02-03 13:05:56	f	0101000020E6100000F9156BB8C83552C0B398D87C5CD54440
1412	30	2008-02-03 13:05:19	2008-02-03 13:07:19	f	0101000020E6100000D605BCCCB03552C05726FC523FD54440
1413	30	2008-02-03 13:08:57	2008-02-03 13:10:57	f	0101000020E6100000F6BA4560AC3552C0664E97C5C4D44440
1414	30	2008-02-03 13:10:20	2008-02-03 13:12:20	t	0101000020E61000000B47904AB13552C02DCF83BBB3D44440
1415	30	2008-02-03 13:13:58	2008-02-03 13:15:58	t	0101000020E61000002BE44A3D0B3652C0C286A757CAD44440
1416	31	2008-02-04 03:10:09	2008-02-04 03:12:09	t	0101000020E610000080F78E1A132652C041D9942BBCD54440
1417	31	2008-02-04 03:13:06	2008-02-04 03:15:06	t	0101000020E610000022ACC612D62452C0C85EEFFE78D54440
1418	31	2008-02-04 03:15:10	2008-02-04 03:17:10	t	0101000020E6100000AB9B8BBFED2352C0037D224F92D44440
1419	31	2008-02-04 03:18:08	2008-02-04 03:20:08	t	0101000020E610000006DEC9A7C72252C07E74EACA67D34440
1420	31	2008-02-04 03:20:12	2008-02-04 03:22:12	t	0101000020E6100000A055664AEB2152C0EA211ADD41D24440
1421	31	2008-02-04 03:23:10	2008-02-04 03:25:10	f	0101000020E6100000B021382EE32052C05070B1A206D14440
1422	31	2008-02-04 03:25:13	2008-02-04 03:27:13	f	0101000020E6100000A2630795B82052C010E9B7AF03D14440
1423	31	2008-02-04 03:30:15	2008-02-04 03:32:15	f	0101000020E6100000EAF2E670AD2052C0AD6EF59CF4D04440
1424	31	2008-02-04 03:33:13	2008-02-04 03:35:13	f	0101000020E6100000778A5583301F52C0D23AAA9A20D04440
1425	31	2008-02-04 03:35:17	2008-02-04 03:37:17	f	0101000020E61000006BF7AB00DF1D52C0452FA3586ECF4440
1426	32	2008-02-03 15:24:40	2008-02-03 15:26:40	t	0101000020E6100000D2066003223052C0BC79AA436EDC4440
1427	32	2008-02-03 15:24:43	2008-02-03 15:26:43	t	0101000020E61000003C8908FF223052C0DF4F8D976EDC4440
1428	32	2008-02-03 15:25:51	2008-02-03 15:27:51	t	0101000020E61000005891D101493052C018096D3997DC4440
1429	32	2008-02-03 15:26:55	2008-02-03 15:28:55	f	0101000020E61000006B317898F62F52C0CB15DEE522DC4440
1430	32	2008-02-03 15:27:25	2008-02-03 15:29:25	t	0101000020E610000020477364E52F52C0842F4CA60ADC4440
1431	32	2008-02-03 15:27:55	2008-02-03 15:29:55	t	0101000020E610000000581D39D22F52C0F69CF4BEF1DB4440
1432	32	2008-02-03 15:27:58	2008-02-03 15:29:58	t	0101000020E6100000DD813AE5D12F52C052B81E85EBDB4440
1433	32	2008-02-03 15:28:02	2008-02-03 15:30:02	t	0101000020E6100000D65C6E30D42F52C06F4C4F58E2DB4440
1434	32	2008-02-03 15:28:05	2008-02-03 15:30:05	f	0101000020E6100000A43CF372D82F52C0C442AD69DEDB4440
1435	32	2008-02-03 15:28:09	2008-02-03 15:30:09	t	0101000020E6100000598CBAD6DE2F52C00BEF7211DFDB4440
1436	32	2008-02-03 15:28:12	2008-02-03 15:30:12	f	0101000020E6100000BDE9961DE22F52C08BFD65F7E4DB4440
1437	32	2008-02-03 15:28:15	2008-02-03 15:30:15	t	0101000020E6100000CF548847E22F52C0E010AAD4ECDB4440
1438	32	2008-02-03 15:28:18	2008-02-03 15:30:18	t	0101000020E6100000C40E63D2DF2F52C0124E0B5EF4DB4440
1439	32	2008-02-03 15:33:08	2008-02-03 15:35:08	f	0101000020E61000001BFB928D072D52C01E5036E50AE14440
1440	32	2008-02-03 15:33:15	2008-02-03 15:35:15	t	0101000020E6100000626D8C9DF02C52C0508D976E12E14440
1441	32	2008-02-03 15:33:21	2008-02-03 15:35:21	t	0101000020E610000026CD1FD3DA2C52C0D07EA4880CE14440
1442	32	2008-02-03 15:33:27	2008-02-03 15:35:27	f	0101000020E61000004D8A8F4FC82C52C097FF907EFBE04440
1443	32	2008-02-03 15:36:03	2008-02-03 15:38:03	f	0101000020E6100000C5263273812B52C0B936548CF3DD4440
1444	32	2008-02-03 15:37:17	2008-02-03 15:39:17	t	0101000020E6100000D388997D1E2B52C0B51A12F758DC4440
1445	32	2008-02-03 15:37:33	2008-02-03 15:39:33	f	0101000020E610000010EF39B01C2B52C0753C66A032DC4440
1446	32	2008-02-03 15:38:25	2008-02-03 15:40:25	f	0101000020E610000030A4C343182B52C02E73BA2C26DC4440
1447	32	2008-02-03 15:38:28	2008-02-03 15:40:28	t	0101000020E61000009705137F142B52C02E73BA2C26DC4440
1448	32	2008-02-03 15:38:48	2008-02-03 15:40:48	t	0101000020E61000009BCFB9DBF52A52C0753C66A032DC4440
1449	32	2008-02-03 15:38:51	2008-02-03 15:40:51	t	0101000020E610000090899466F32A52C0D99942E735DC4440
1450	32	2008-02-03 15:38:54	2008-02-03 15:40:54	f	0101000020E61000006DB3B112F32A52C0528369183EDC4440
1451	32	2008-02-03 15:39:27	2008-02-03 15:41:27	t	0101000020E61000004D1B0E4B032B52C0265305A392DC4440
1452	32	2008-02-03 15:39:38	2008-02-03 15:41:38	f	0101000020E6100000DE770C8FFD2A52C018265305A3DC4440
1453	32	2008-02-03 15:40:34	2008-02-03 15:42:34	t	0101000020E610000002F73C7FDA2A52C02D7DE882FADC4440
1454	32	2008-02-03 15:40:38	2008-02-03 15:42:38	t	0101000020E6100000ED6AF294D52A52C090DAC4C9FDDC4440
1455	32	2008-02-03 15:41:55	2008-02-03 15:43:55	t	0101000020E6100000A35EF0694E2A52C002BC051214DD4440
1456	32	2008-02-03 15:43:19	2008-02-03 15:45:19	t	0101000020E6100000EE43DE72F52952C0DEE522BE13DD4440
1457	32	2008-02-03 15:43:42	2008-02-03 15:45:42	t	0101000020E61000003DF88903E82952C0508D976E12DD4440
1458	32	2008-02-03 15:45:15	2008-02-03 15:47:15	f	0101000020E6100000DAB27C5D862952C0508D976E12DD4440
1459	32	2008-02-03 15:45:19	2008-02-03 15:47:19	t	0101000020E6100000DAB27C5D862952C0508D976E12DD4440
1460	32	2008-02-03 15:46:23	2008-02-03 15:48:23	f	0101000020E6100000FA6706F1812952C0DEE522BE13DD4440
1461	32	2008-02-03 15:46:23	2008-02-03 15:48:23	t	0101000020E6100000FA6706F1812952C0DEE522BE13DD4440
1462	32	2008-02-03 15:49:48	2008-02-03 15:51:48	t	0101000020E6100000D17AF832512852C06688635DDCDC4440
1463	32	2008-02-03 15:49:51	2008-02-03 15:51:51	f	0101000020E6100000D17AF832512852C018B7D100DEDC4440
1464	32	2008-02-03 15:49:54	2008-02-03 15:51:54	t	0101000020E6100000B8EA3A54532852C05F6397A8DEDC4440
1465	32	2008-02-03 15:50:09	2008-02-03 15:52:09	t	0101000020E61000001C48179B562852C0F4E0EEACDDDC4440
1466	32	2008-02-03 15:53:27	2008-02-03 15:55:27	t	0101000020E6100000598CBAD6DE2952C07B88467710DD4440
1467	32	2008-02-03 15:54:24	2008-02-03 15:56:24	f	0101000020E6100000F22A6B9BE22952C0E50AEF7211DD4440
1468	32	2008-02-03 15:54:27	2008-02-03 15:56:27	f	0101000020E61000004B42226DE32952C07B88467710DD4440
1469	32	2008-02-03 15:54:55	2008-02-03 15:56:55	t	0101000020E6100000AE9FFEB3E62952C0D07EA4880CDD4440
1470	32	2008-02-03 15:58:19	2008-02-03 16:00:19	f	0101000020E6100000B9E52329E92952C00E677E3507DA4440
1471	32	2008-02-03 15:58:22	2008-02-03 16:00:22	f	0101000020E6100000473EAF78EA2952C0B22E6EA301DA4440
1472	32	2008-02-03 15:58:26	2008-02-03 16:00:26	t	0101000020E61000005DCAF962EF2952C04ED1915CFED94440
1473	32	2008-02-03 15:58:38	2008-02-03 16:00:38	t	0101000020E6100000674AEB6F092A52C0EB73B515FBD94440
1474	32	2008-02-03 15:58:43	2008-02-03 16:00:43	t	0101000020E6100000BC5D2F4D112A52C0D6E76A2BF6D94440
1475	32	2008-02-03 16:00:16	2008-02-03 16:02:16	t	0101000020E610000054E9279CDD2A52C039454772F9D94440
1476	32	2008-02-03 16:01:08	2008-02-03 16:03:08	t	0101000020E6100000C578CDAB3A2B52C06440F67AF7D94440
1477	32	2008-02-03 16:01:18	2008-02-03 16:03:18	t	0101000020E610000025D236FE442B52C0D6E76A2BF6D94440
1478	32	2008-02-03 16:01:21	2008-02-03 16:03:21	t	0101000020E6100000F0906280442B52C0B936548CF3D94440
1479	32	2008-02-03 16:01:24	2008-02-03 16:03:24	f	0101000020E6100000C1745AB7412B52C0728A8EE4F2D94440
1480	32	2008-02-03 16:01:27	2008-02-03 16:03:27	t	0101000020E610000057F2B1BB402B52C000E31934F4D94440
1481	32	2008-02-03 16:01:32	2008-02-03 16:03:32	t	0101000020E610000057F2B1BB402B52C000E31934F4D94440
1482	32	2008-02-03 16:01:55	2008-02-03 16:03:55	f	0101000020E610000053D158FB3B2B52C00708E6E8F1D94440
1483	32	2008-02-03 16:02:27	2008-02-03 16:04:27	f	0101000020E6100000F0FFE384092B52C0D6E76A2BF6D94440
1484	32	2008-02-03 16:02:32	2008-02-03 16:04:32	f	0101000020E610000062A75835082B52C08716D9CEF7D94440
1485	32	2008-02-03 16:02:35	2008-02-03 16:04:35	t	0101000020E610000014D6C6D8092B52C0CEC29E76F8D94440
1486	32	2008-02-03 16:03:03	2008-02-03 16:05:03	t	0101000020E6100000416667D13B2B52C06440F67AF7D94440
1487	32	2008-02-03 16:03:18	2008-02-03 16:05:18	t	0101000020E6100000A1BFD023462B52C0C79DD2C1FAD94440
1488	32	2008-02-03 16:03:21	2008-02-03 16:05:21	t	0101000020E6100000C595B377462B52C00000000000DA4440
1489	32	2008-02-03 16:03:53	2008-02-03 16:05:53	f	0101000020E61000001063D2DF4B2B52C05C035B2558DA4440
1490	32	2008-02-03 16:03:56	2008-02-03 16:05:56	t	0101000020E61000009796917A4F2B52C02AE3DF675CDA4440
1491	33	2008-02-03 22:51:46	2008-02-03 22:53:46	f	0101000020E610000056DAE21A9F2F52C0170E846401D94440
1492	33	2008-02-03 22:56:46	2008-02-03 22:58:46	f	0101000020E6100000F1FACC599F3052C066C22FF5F3D84440
1493	33	2008-02-03 23:01:08	2008-02-03 23:03:08	t	0101000020E610000082221631EC2C52C0EA95B20C71E24440
1494	33	2008-02-03 23:01:47	2008-02-03 23:03:47	f	0101000020E6100000BEFC4E93193152C0E31934F44FD64440
1495	33	2008-02-03 23:06:46	2008-02-03 23:08:46	t	0101000020E61000009E47C5FF1D3152C0E0D6DD3CD5D34440
1496	33	2008-02-03 23:11:46	2008-02-03 23:13:46	t	0101000020E61000005E177E703E3352C08C4F01309ED34440
1497	33	2008-02-03 23:21:46	2008-02-03 23:23:46	f	0101000020E6100000AADA6E826F3452C00E897B2C7DD24440
1498	33	2008-02-03 23:26:46	2008-02-03 23:28:46	t	0101000020E6100000BEA59C2FF63452C0F7AFAC3429D34440
1499	33	2008-02-03 23:31:46	2008-02-03 23:33:46	f	0101000020E610000069AF3E1EFA3452C0B58EAA2688D44440
1500	33	2008-02-03 23:36:46	2008-02-03 23:38:46	f	0101000020E6100000ABED26F8A63552C07C4963B48ED44440
1501	34	2008-02-05 18:39:36	2008-02-05 18:41:36	t	0101000020E610000044572250FD3B52C0577DAEB662D54440
1502	34	2008-02-05 18:40:11	2008-02-05 18:42:11	f	0101000020E6100000B5FE9600FC3B52C02CF697DD93D54440
1503	34	2008-02-05 18:40:16	2008-02-05 18:42:16	t	0101000020E6100000A0724C16F73B52C024D1CB2896D54440
1504	34	2008-02-05 18:40:34	2008-02-05 18:42:34	f	0101000020E61000008FB0A888D33B52C0BA4E232D95D54440
1505	34	2008-02-05 18:41:08	2008-02-05 18:43:08	t	0101000020E6100000596FD40AD33B52C0DD24068195D54440
1506	34	2008-02-05 18:41:08	2008-02-05 18:43:08	f	0101000020E6100000596FD40AD33B52C0DD24068195D54440
1507	34	2008-02-05 18:41:54	2008-02-05 18:43:54	t	0101000020E6100000AF7D01BD703B52C07AC7293A92D54440
1508	34	2008-02-05 18:42:36	2008-02-05 18:44:36	t	0101000020E61000009A7D1EA33C3B52C00820B58993D54440
1509	34	2008-02-05 18:42:39	2008-02-05 18:44:39	f	0101000020E6100000416667D13B3B52C056F146E691D54440
1510	34	2008-02-05 18:43:48	2008-02-05 18:45:48	f	0101000020E6100000C2525DC0CB3A52C0ACE7A4F78DD54440
1511	34	2008-02-05 18:44:04	2008-02-05 18:46:04	f	0101000020E6100000693BA6EECA3A52C056B77A4E7AD54440
1512	34	2008-02-05 18:44:07	2008-02-05 18:46:07	f	0101000020E610000058D0B4C4CA3A52C02597FF907ED54440
1513	34	2008-02-05 18:44:11	2008-02-05 18:46:11	f	0101000020E6100000693BA6EECA3A52C0CFA0A17F82D54440
1514	34	2008-02-05 18:45:48	2008-02-05 18:47:48	f	0101000020E610000034FAD170CA3A52C01D3D7E6FD3D54440
1515	34	2008-02-05 18:46:15	2008-02-05 18:48:15	t	0101000020E61000005FF58079C83A52C087F9F202ECD54440
1516	34	2008-02-05 18:47:15	2008-02-05 18:49:15	t	0101000020E6100000113CBEBD6B3A52C0C05B2041F1D54440
1517	34	2008-02-05 18:48:20	2008-02-05 18:50:20	t	0101000020E6100000A7D1E4620C3A52C00F2DB29DEFD54440
1518	34	2008-02-05 18:48:53	2008-02-05 18:50:53	f	0101000020E610000000E99B340D3A52C08F1EBFB7E9D54440
1519	34	2008-02-05 18:49:12	2008-02-05 18:51:12	f	0101000020E610000024BF7E880D3A52C01D3D7E6FD3D54440
1520	34	2008-02-05 18:49:48	2008-02-05 18:51:48	t	0101000020E6100000DC12B9E00C3A52C016FBCBEEC9D54440
1521	34	2008-02-05 18:50:22	2008-02-05 18:52:22	t	0101000020E6100000A7D1E4620C3A52C02B8716D9CED54440
1522	34	2008-02-05 18:50:27	2008-02-05 18:52:27	t	0101000020E6100000A7D1E4620C3A52C0D690B8C7D2D54440
1523	34	2008-02-05 18:51:38	2008-02-05 18:53:38	f	0101000020E6100000590053060E3A52C08EE9094B3CD64440
1524	34	2008-02-05 18:52:18	2008-02-05 18:54:18	f	0101000020E61000002BE44A3D0B3A52C0151DC9E53FD64440
1525	34	2008-02-05 18:52:25	2008-02-05 18:54:25	t	0101000020E6100000197959130B3A52C07155D97745D64440
1526	34	2008-02-05 18:52:32	2008-02-05 18:54:32	t	0101000020E6100000729010E50B3A52C01C7C613255D64440
1527	34	2008-02-05 18:53:12	2008-02-05 18:55:12	f	0101000020E6100000D2CC936B0A3A52C0386C5B94D9D64440
1528	34	2008-02-05 18:53:22	2008-02-05 18:55:22	f	0101000020E6100000E0162CD5053A52C08D9C853DEDD64440
1529	34	2008-02-05 18:56:56	2008-02-05 18:58:56	f	0101000020E610000004D0285DFA3952C078D66EBBD0DA4440
1530	34	2008-02-05 18:57:00	2008-02-05 18:59:00	t	0101000020E6100000C4482F6AF73952C0BF823463D1DA4440
1531	34	2008-02-05 18:57:12	2008-02-05 18:59:12	t	0101000020E6100000121AC1C6F53952C0A297512CB7DA4440
1532	34	2008-02-05 18:57:15	2008-02-05 18:59:15	t	0101000020E61000002ECBD765F83952C0AABC1DE1B4DA4440
1533	34	2008-02-05 18:57:39	2008-02-05 18:59:39	f	0101000020E6100000605FEB52233A52C0FFEC478AC8DA4440
1534	34	2008-02-05 18:57:57	2008-02-05 18:59:57	t	0101000020E6100000605FEB52233A52C02237C30DF8DA4440
1535	34	2008-02-05 18:58:00	2008-02-05 19:00:00	f	0101000020E6100000FC010F0C203A52C0CD4065FCFBDA4440
1536	34	2008-02-05 18:58:11	2008-02-05 19:00:11	t	0101000020E6100000394BC972123A52C0D46531B1F9DA4440
1537	34	2008-02-05 18:58:15	2008-02-05 19:00:15	f	0101000020E610000040709527103A52C00DAB7823F3DA4440
1538	34	2008-02-05 18:59:11	2008-02-05 19:01:11	f	0101000020E6100000729010E50B3A52C06B9F8EC70CDA4440
1539	34	2008-02-05 18:59:26	2008-02-05 19:01:26	t	0101000020E61000001CD47E6B273A52C072C45A7C0ADA4440
1540	34	2008-02-05 18:59:59	2008-02-05 19:01:59	f	0101000020E61000005891D101493A52C01DCEFC6A0EDA4440
1541	34	2008-02-05 19:00:47	2008-02-05 19:02:47	t	0101000020E61000002350FD83483A52C0DD4603780BDA4440
1542	34	2008-02-05 19:01:24	2008-02-05 19:03:24	t	0101000020E61000004474081C093A52C00E677E3507DA4440
1543	34	2008-02-05 19:01:40	2008-02-05 19:03:40	f	0101000020E6100000BC404981053A52C039EE940ED6D94440
1544	34	2008-02-05 19:01:58	2008-02-05 19:03:58	t	0101000020E61000002EE8BD31043A52C05D6DC5FEB2D94440
1545	34	2008-02-05 19:02:36	2008-02-05 19:04:36	t	0101000020E61000004E9D47C5FF3952C0F31FD26F5FD94440
1546	34	2008-02-05 19:02:49	2008-02-05 19:04:49	f	0101000020E6100000E03312A1113A52C0D049EF1B5FD94440
1547	34	2008-02-05 19:04:03	2008-02-05 19:06:03	t	0101000020E610000079D2C265153A52C090C2F5285CD94440
1548	34	2008-02-05 19:04:22	2008-02-05 19:06:22	t	0101000020E61000009D6ED921FE3952C025404D2D5BD94440
1549	34	2008-02-05 19:06:39	2008-02-05 19:08:39	t	0101000020E610000044572250FD3952C0D49FFD4811D74440
1550	34	2008-02-05 19:06:43	2008-02-05 19:08:43	t	0101000020E6100000C044BC75FE3952C0704221020ED74440
1551	34	2008-02-05 19:07:52	2008-02-05 19:09:52	f	0101000020E6100000672D05A4FD3952C0B7D100DE02D74440
1552	34	2008-02-05 19:08:46	2008-02-05 19:10:46	t	0101000020E6100000F37C06D49B3952C0462575029AD64440
1553	34	2008-02-05 19:08:53	2008-02-05 19:10:53	t	0101000020E61000009A654F029B3952C07120240B98D64440
1554	34	2008-02-05 19:09:22	2008-02-05 19:11:22	f	0101000020E61000002FE3A6069A3952C080BC57AD4CD64440
1555	34	2008-02-05 19:09:25	2008-02-05 19:11:25	f	0101000020E6100000A4AB74779D3952C087E123624AD64440
1556	34	2008-02-05 19:10:18	2008-02-05 19:12:18	t	0101000020E610000000CCB568013A52C040355EBA49D64440
1557	34	2008-02-05 19:11:54	2008-02-05 19:13:54	t	0101000020E61000006A368FC3603A52C06A300DC347D64440
1558	34	2008-02-05 19:12:28	2008-02-05 19:14:28	t	0101000020E6100000310E2E1D733A52C06A300DC347D64440
1559	34	2008-02-05 19:13:33	2008-02-05 19:15:33	f	0101000020E6100000FF7E315BB23A52C0D5B2B5BE48D64440
1560	34	2008-02-05 19:14:15	2008-02-05 19:16:15	f	0101000020E6100000DFC9A7C7B63A52C08E06F01648D64440
1561	34	2008-02-05 19:14:26	2008-02-05 19:16:26	t	0101000020E6100000E60B5A48C03A52C06A300DC347D64440
1562	34	2008-02-05 19:15:21	2008-02-05 19:17:21	f	0101000020E61000005FF58079C83A52C02AA913D044D64440
1563	34	2008-02-05 19:15:48	2008-02-05 19:17:48	f	0101000020E6100000DBE21A9FC93A52C08716D9CEF7D54440
1564	34	2008-02-05 19:16:48	2008-02-05 19:18:48	t	0101000020E610000026B03907CF3A52C09DBAF2599ED54440
1565	34	2008-02-05 19:16:51	2008-02-05 19:18:51	t	0101000020E6100000C673B680D03A52C0560E2DB29DD54440
1566	35	2008-02-05 11:04:18	2008-02-05 11:06:18	t	0101000020E61000003CFA5FAE45A667C0FAD005F52D33FC3F
1567	35	2008-02-05 12:01:01	2008-02-05 12:03:01	t	0101000020E610000029B4ACFBC73452C0CC9717601FDF4440
1568	35	2008-02-05 12:07:01	2008-02-05 12:09:01	f	0101000020E610000054AF5B04C63452C07C2C7DE882DC4440
1569	35	2008-02-05 12:16:07	2008-02-05 12:18:07	t	0101000020E610000054AF5B04C63452C07C2C7DE882DC4440
1570	35	2008-02-05 12:22:08	2008-02-05 12:24:08	f	0101000020E6100000174ED2FC313552C0193E22A644DC4440
1571	35	2008-02-05 12:28:47	2008-02-05 12:30:47	f	0101000020E6100000FAD687F5463552C017821C9430DD4440
1572	35	2008-02-05 12:34:47	2008-02-05 12:36:47	f	0101000020E6100000A762635E473452C002D4D4B2B5DC4440
1573	35	2008-02-05 12:40:47	2008-02-05 12:42:47	t	0101000020E6100000C39FE1CD1A3452C0825660C8EADC4440
1574	35	2008-02-05 12:52:47	2008-02-05 12:54:47	f	0101000020E61000000F80B8AB573552C010B4024356DD4440
1575	35	2008-02-05 12:59:40	2008-02-05 13:01:40	t	0101000020E610000043226DE34F3652C045696FF085DF4440
1576	36	2008-02-03 21:41:16	2008-02-03 21:43:16	f	0101000020E6100000420FB56D183552C0809F71E140D24440
1577	36	2008-02-03 21:42:07	2008-02-03 21:44:07	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1578	36	2008-02-03 21:42:41	2008-02-03 21:44:41	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1579	36	2008-02-03 21:43:41	2008-02-03 21:45:41	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1580	36	2008-02-03 21:44:42	2008-02-03 21:46:42	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1581	36	2008-02-03 21:45:08	2008-02-03 21:47:08	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1582	36	2008-02-03 21:45:58	2008-02-03 21:47:58	t	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1583	36	2008-02-03 21:46:42	2008-02-03 21:48:42	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1584	36	2008-02-03 21:47:43	2008-02-03 21:49:43	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1585	36	2008-02-03 21:48:43	2008-02-03 21:50:43	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1586	36	2008-02-03 21:49:29	2008-02-03 21:51:29	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1587	36	2008-02-03 21:50:19	2008-02-03 21:52:19	t	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1588	36	2008-02-03 21:50:44	2008-02-03 21:52:44	f	0101000020E6100000420FB56D183552C05CC98E8D40D24440
1589	36	2008-02-03 21:51:44	2008-02-03 21:53:44	t	0101000020E6100000775089EB183552C0A375543541D24440
1590	36	2008-02-03 21:52:45	2008-02-03 21:54:45	t	0101000020E6100000775089EB183552C0A375543541D24440
1591	36	2008-02-03 21:53:45	2008-02-03 21:55:45	f	0101000020E6100000775089EB183552C0A375543541D24440
1592	36	2008-02-03 21:53:45	2008-02-03 21:55:45	f	0101000020E6100000775089EB183552C0A375543541D24440
1593	36	2008-02-03 21:53:51	2008-02-03 21:55:51	f	0101000020E6100000775089EB183552C0A375543541D24440
1594	36	2008-02-03 21:53:51	2008-02-03 21:55:51	t	0101000020E6100000775089EB183552C0A375543541D24440
1595	36	2008-02-03 21:54:45	2008-02-03 21:56:45	t	0101000020E6100000775089EB183552C0A375543541D24440
1596	36	2008-02-03 21:55:46	2008-02-03 21:57:46	t	0101000020E6100000775089EB183552C0A375543541D24440
1597	36	2008-02-03 21:56:46	2008-02-03 21:58:46	t	0101000020E6100000775089EB183552C0A375543541D24440
1598	36	2008-02-03 21:57:46	2008-02-03 21:59:46	f	0101000020E6100000775089EB183552C0A375543541D24440
1599	36	2008-02-03 21:58:42	2008-02-03 22:00:42	f	0101000020E6100000F33D23111A3552C0C74B378941D24440
1600	36	2008-02-03 21:59:33	2008-02-03 22:01:33	f	0101000020E6100000171406651A3552C0EA211ADD41D24440
1601	36	2008-02-03 21:59:47	2008-02-03 22:01:47	f	0101000020E6100000171406651A3552C0EA211ADD41D24440
1602	36	2008-02-03 22:00:47	2008-02-03 22:02:47	t	0101000020E61000004C55DAE21A3552C0EA211ADD41D24440
1603	36	2008-02-03 22:01:48	2008-02-03 22:03:48	t	0101000020E61000004C55DAE21A3552C0EA211ADD41D24440
1604	36	2008-02-03 22:02:48	2008-02-03 22:04:48	f	0101000020E61000004C55DAE21A3552C0EA211ADD41D24440
1605	36	2008-02-03 22:03:34	2008-02-03 22:05:34	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1606	36	2008-02-03 22:04:24	2008-02-03 22:06:24	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1607	36	2008-02-03 22:04:49	2008-02-03 22:06:49	t	0101000020E6100000702BBD361B3552C0809F71E140D24440
1608	36	2008-02-03 22:05:05	2008-02-03 22:07:05	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1609	36	2008-02-03 22:05:55	2008-02-03 22:07:55	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1610	36	2008-02-03 22:06:50	2008-02-03 22:08:50	t	0101000020E6100000702BBD361B3552C0809F71E140D24440
1611	36	2008-02-03 22:07:15	2008-02-03 22:09:15	t	0101000020E6100000702BBD361B3552C0809F71E140D24440
1612	36	2008-02-03 22:08:07	2008-02-03 22:10:07	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1613	36	2008-02-03 22:08:36	2008-02-03 22:10:36	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1614	36	2008-02-03 22:09:26	2008-02-03 22:11:26	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1615	36	2008-02-03 22:09:51	2008-02-03 22:11:51	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1616	36	2008-02-03 22:10:26	2008-02-03 22:12:26	f	0101000020E6100000702BBD361B3552C0809F71E140D24440
1617	36	2008-02-03 22:11:17	2008-02-03 22:13:17	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1618	36	2008-02-03 22:11:51	2008-02-03 22:13:51	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1619	36	2008-02-03 22:12:17	2008-02-03 22:14:17	f	0101000020E61000008296AE601B3552C0809F71E140D24440
1620	36	2008-02-03 22:13:08	2008-02-03 22:15:08	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1621	36	2008-02-03 22:13:08	2008-02-03 22:15:08	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1622	36	2008-02-03 22:13:52	2008-02-03 22:15:52	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1623	36	2008-02-03 22:14:38	2008-02-03 22:16:38	t	0101000020E61000008296AE601B3552C0809F71E140D24440
1624	36	2008-02-03 22:15:53	2008-02-03 22:17:53	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1625	36	2008-02-03 22:16:53	2008-02-03 22:18:53	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1626	36	2008-02-03 22:16:59	2008-02-03 22:18:59	t	0101000020E6100000702BBD361B3552C0A375543541D24440
1627	36	2008-02-03 22:17:53	2008-02-03 22:19:53	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1628	36	2008-02-03 22:17:53	2008-02-03 22:19:53	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1629	36	2008-02-03 22:18:54	2008-02-03 22:20:54	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1630	36	2008-02-03 22:19:50	2008-02-03 22:21:50	f	0101000020E6100000702BBD361B3552C0A375543541D24440
1631	36	2008-02-03 22:20:40	2008-02-03 22:22:40	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1632	36	2008-02-03 22:20:54	2008-02-03 22:22:54	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1633	36	2008-02-03 22:21:55	2008-02-03 22:23:55	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1634	36	2008-02-03 22:22:41	2008-02-03 22:24:41	t	0101000020E6100000702BBD361B3552C0A375543541D24440
1635	36	2008-02-03 22:23:31	2008-02-03 22:25:31	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1636	36	2008-02-03 22:23:56	2008-02-03 22:25:56	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1637	36	2008-02-03 22:25:56	2008-02-03 22:27:56	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1638	36	2008-02-03 22:26:02	2008-02-03 22:28:02	t	0101000020E6100000702BBD361B3552C0A375543541D24440
1639	36	2008-02-03 22:26:57	2008-02-03 22:28:57	f	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1640	36	2008-02-03 22:27:57	2008-02-03 22:29:57	t	0101000020E61000005EC0CB0C1B3552C0A375543541D24440
1641	36	2008-02-07 18:22:45	2008-02-07 18:24:45	t	0101000020E610000028DBC01DA83352C072FE261422D24440
1642	36	2008-02-07 18:23:45	2008-02-07 18:25:45	t	0101000020E610000028DBC01DA83352C072FE261422D24440
1643	36	2008-02-07 18:24:45	2008-02-07 18:26:45	t	0101000020E610000028DBC01DA83352C072FE261422D24440
1644	36	2008-02-07 18:25:46	2008-02-07 18:27:46	t	0101000020E610000028DBC01DA83352C072FE261422D24440
1645	36	2008-02-07 18:26:46	2008-02-07 18:28:46	t	0101000020E610000028DBC01DA83352C072FE261422D24440
1646	36	2008-02-07 18:35:14	2008-02-07 18:37:14	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1647	36	2008-02-07 18:36:12	2008-02-07 18:38:12	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1648	36	2008-02-07 18:36:55	2008-02-07 18:38:55	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1649	36	2008-02-07 18:36:55	2008-02-07 18:38:55	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1650	36	2008-02-07 18:37:45	2008-02-07 18:39:45	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1651	36	2008-02-07 18:38:13	2008-02-07 18:40:13	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1652	36	2008-02-07 18:38:17	2008-02-07 18:40:17	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1653	36	2008-02-07 18:39:13	2008-02-07 18:41:13	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1654	36	2008-02-07 18:40:06	2008-02-07 18:42:06	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1655	36	2008-02-07 18:40:56	2008-02-07 18:42:56	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1656	36	2008-02-07 18:41:14	2008-02-07 18:43:14	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1657	36	2008-02-07 18:41:56	2008-02-07 18:43:56	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1658	36	2008-02-07 18:42:47	2008-02-07 18:44:47	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1659	36	2008-02-07 18:43:15	2008-02-07 18:45:15	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1660	36	2008-02-07 18:44:15	2008-02-07 18:46:15	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1661	36	2008-02-07 18:44:17	2008-02-07 18:46:17	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1662	36	2008-02-07 18:45:15	2008-02-07 18:47:15	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1663	36	2008-02-07 18:46:16	2008-02-07 18:48:16	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1664	36	2008-02-07 18:46:38	2008-02-07 18:48:38	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1665	36	2008-02-07 18:46:38	2008-02-07 18:48:38	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1666	36	2008-02-07 18:47:28	2008-02-07 18:49:28	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1667	36	2008-02-07 18:48:16	2008-02-07 18:50:16	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1668	36	2008-02-07 18:49:17	2008-02-07 18:51:17	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1669	36	2008-02-07 18:49:29	2008-02-07 18:51:29	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1670	36	2008-02-07 18:50:19	2008-02-07 18:52:19	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1671	36	2008-02-07 18:51:18	2008-02-07 18:53:18	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1672	36	2008-02-07 18:52:18	2008-02-07 18:54:18	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1673	36	2008-02-07 18:52:20	2008-02-07 18:54:20	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1674	36	2008-02-07 18:53:18	2008-02-07 18:55:18	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1675	36	2008-02-07 18:53:18	2008-02-07 18:55:18	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1676	36	2008-02-07 18:53:18	2008-02-07 18:55:18	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1677	36	2008-02-07 18:54:19	2008-02-07 18:56:19	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1678	36	2008-02-07 18:55:19	2008-02-07 18:57:19	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1679	36	2008-02-07 18:55:41	2008-02-07 18:57:41	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1680	36	2008-02-07 18:56:32	2008-02-07 18:58:32	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1681	36	2008-02-07 18:57:20	2008-02-07 18:59:20	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1682	36	2008-02-07 18:58:20	2008-02-07 19:00:20	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1683	36	2008-02-07 18:59:02	2008-02-07 19:01:02	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1684	36	2008-02-07 18:59:53	2008-02-07 19:01:53	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1685	36	2008-02-07 19:00:21	2008-02-07 19:02:21	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1686	36	2008-02-07 19:01:21	2008-02-07 19:03:21	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1687	36	2008-02-07 19:02:21	2008-02-07 19:04:21	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1688	36	2008-02-07 19:02:54	2008-02-07 19:04:54	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1689	36	2008-02-07 19:03:44	2008-02-07 19:05:44	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1690	36	2008-02-07 19:04:22	2008-02-07 19:06:22	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1691	36	2008-02-07 19:05:23	2008-02-07 19:07:23	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1692	36	2008-02-07 19:06:23	2008-02-07 19:08:23	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1693	36	2008-02-07 19:06:45	2008-02-07 19:08:45	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1694	36	2008-02-07 19:07:36	2008-02-07 19:09:36	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1695	36	2008-02-07 19:08:24	2008-02-07 19:10:24	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1696	36	2008-02-07 19:09:24	2008-02-07 19:11:24	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1697	36	2008-02-07 19:10:24	2008-02-07 19:12:24	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1698	36	2008-02-07 19:11:07	2008-02-07 19:13:07	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1699	36	2008-02-07 19:11:57	2008-02-07 19:13:57	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1700	36	2008-02-07 19:12:25	2008-02-07 19:14:25	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1701	36	2008-02-07 19:13:25	2008-02-07 19:15:25	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1702	36	2008-02-07 19:14:26	2008-02-07 19:16:26	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1703	36	2008-02-07 19:15:26	2008-02-07 19:17:26	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1704	36	2008-02-07 19:15:28	2008-02-07 19:17:28	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1705	36	2008-02-07 19:16:26	2008-02-07 19:18:26	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1706	36	2008-02-07 19:17:27	2008-02-07 19:19:27	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1707	36	2008-02-07 19:18:27	2008-02-07 19:20:27	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1708	36	2008-02-07 19:19:27	2008-02-07 19:21:27	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1709	36	2008-02-07 19:20:20	2008-02-07 19:22:20	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1710	36	2008-02-07 19:21:10	2008-02-07 19:23:10	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1711	36	2008-02-07 19:21:28	2008-02-07 19:23:28	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1712	36	2008-02-07 19:22:21	2008-02-07 19:24:21	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1713	36	2008-02-07 19:22:29	2008-02-07 19:24:29	t	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1714	36	2008-02-07 19:23:29	2008-02-07 19:25:29	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1715	36	2008-02-07 19:24:29	2008-02-07 19:26:29	f	0101000020E61000009A8235CEA63352C015E3FC4D28D24440
1716	37	2008-02-04 17:18:36	2008-02-04 17:20:36	t	0101000020E61000009E9E7763413752C0F05014E813BF4440
1717	37	2008-02-04 17:22:29	2008-02-04 17:24:29	t	0101000020E61000009E819197353752C0A297512CB7BE4440
1718	37	2008-02-04 17:23:38	2008-02-04 17:25:38	t	0101000020E6100000E52D573F363752C0B16D516683BE4440
1719	37	2008-02-04 17:27:31	2008-02-04 17:29:31	f	0101000020E610000026766D6FB73652C0EB1C03B2D7BD4440
1720	37	2008-02-04 17:28:40	2008-02-04 17:30:40	f	0101000020E6100000278E3C10593652C04F5DF92CCFBD4440
1721	37	2008-02-04 17:32:33	2008-02-04 17:34:33	f	0101000020E61000007D0BEBC6BB3352C0BA88EFC4ACBD4440
1722	37	2008-02-04 17:33:41	2008-02-04 17:35:41	f	0101000020E610000082CB63CDC83252C0C1ADBB79AABD4440
1723	37	2008-02-04 17:37:34	2008-02-04 17:39:34	t	0101000020E610000080315BB22A3052C0AA7D3A1E33BE4440
1724	37	2008-02-04 17:39:58	2008-02-04 17:41:58	f	0101000020E61000003E0B42791F2F52C079AF5A99F0BD4440
1725	37	2008-02-04 17:42:37	2008-02-04 17:44:37	f	0101000020E6100000E3546B61162E52C0AF997CB3CDBB4440
1726	38	2008-02-05 20:20:14	2008-02-05 20:22:14	f	0101000020E6100000A9C7B60C383152C01DCEFC6A0ECA4440
1727	38	2008-02-05 20:25:14	2008-02-05 20:27:14	f	0101000020E61000002D0FD253E43052C08FE4F21FD2C94440
1728	38	2008-02-05 20:30:14	2008-02-05 20:32:14	t	0101000020E6100000C26F438CD73052C050FC1873D7C84440
1729	38	2008-02-05 20:35:14	2008-02-05 20:37:14	f	0101000020E610000026B03907CF3052C09031772D21CD4440
1730	38	2008-02-05 20:40:14	2008-02-05 20:42:14	t	0101000020E61000007E40A033693152C0BB270F0BB5C84440
1731	38	2008-02-05 20:45:14	2008-02-05 20:47:14	f	0101000020E6100000E0BF7971E23152C04FE960FD9FC94440
1732	38	2008-02-05 20:50:14	2008-02-05 20:52:14	f	0101000020E6100000D2066003223252C081608E1EBFC94440
1733	39	2008-02-03 19:59:07	2008-02-03 20:01:07	f	0101000020E61000009835B1C0573652C0F52D73BA2CD44440
1734	38	2008-02-05 20:55:14	2008-02-05 20:57:14	t	0101000020E6100000EEB776A2243252C074EFE192E3C84440
1735	38	2008-02-05 21:00:14	2008-02-05 21:02:14	f	0101000020E61000006AA510C8253252C0C30DF8FC30C84440
1736	38	2008-02-05 21:05:14	2008-02-05 21:07:14	t	0101000020E610000007483481223252C0EC51B81E85C94440
1737	38	2008-02-05 21:10:14	2008-02-05 21:12:14	f	0101000020E6100000EEB776A2243252C041F163CC5DC94440
1738	38	2008-02-05 21:15:14	2008-02-05 21:17:14	t	0101000020E610000072CADC7C233252C009FEB7921DC94440
1739	38	2008-02-05 21:20:14	2008-02-05 21:22:14	f	0101000020E6100000EEB776A2243252C01F2E39EE94C84440
1740	38	2008-02-05 21:25:14	2008-02-05 21:27:14	f	0101000020E6100000B976A224243252C0FCE3BD6A65C84440
1741	38	2008-02-05 21:30:14	2008-02-05 21:32:14	t	0101000020E610000047CF2D74253252C0FB3F87F9F2C84440
1742	38	2008-02-05 21:30:14	2008-02-05 21:32:14	t	0101000020E610000047CF2D74253252C0FB3F87F9F2C84440
1743	38	2008-02-05 21:35:14	2008-02-05 21:37:14	t	0101000020E6100000CAE1934E243252C09F1F46088FC84440
1744	38	2008-02-05 21:40:14	2008-02-05 21:42:14	f	0101000020E6100000B976A224243252C05114E81379C84440
1745	38	2008-02-05 21:45:14	2008-02-05 21:47:14	t	0101000020E6100000002368CC243252C0115839B4C8C84440
1746	38	2008-02-05 21:50:14	2008-02-05 21:52:14	t	0101000020E610000072CADC7C233252C07B88467710C94440
1747	38	2008-02-05 21:55:14	2008-02-05 21:57:14	t	0101000020E61000003C8908FF223252C0AB60545227CA4440
1748	38	2008-02-05 22:00:14	2008-02-05 22:02:14	t	0101000020E61000006AA510C8253252C066A032FE7DC84440
1749	38	2008-02-05 22:05:14	2008-02-05 22:07:14	f	0101000020E610000023F94A20253252C001309E4143CD4440
1750	38	2008-02-05 22:10:14	2008-02-05 22:12:14	t	0101000020E6100000B976A224243252C05726FC523FC94440
1751	38	2008-02-05 22:15:14	2008-02-05 22:17:14	f	0101000020E61000006AA510C8253252C082E7DEC325C94440
1752	38	2008-02-05 22:20:14	2008-02-05 22:22:14	t	0101000020E61000004EF4F928233252C04F7ADFF8DAC94440
1753	38	2008-02-05 22:25:14	2008-02-05 22:27:14	f	0101000020E61000002B1E17D5223252C06C43C5387FC94440
1754	38	2008-02-05 22:30:14	2008-02-05 22:32:14	f	0101000020E610000072CADC7C233252C0B3EF8AE07FC94440
1755	38	2008-02-05 22:35:14	2008-02-05 22:37:14	t	0101000020E610000072CADC7C233252C0F3599E0777C94440
1756	38	2008-02-05 22:40:14	2008-02-05 22:42:14	f	0101000020E61000003C8908FF223252C0BA4E232D95C94440
1757	38	2008-02-05 22:45:14	2008-02-05 22:47:14	t	0101000020E61000003C8908FF223252C016359886E1C94440
1758	38	2008-02-05 22:50:14	2008-02-05 22:52:14	t	0101000020E6100000E371512D223252C0D52137C30DCA4440
1759	38	2008-02-05 22:55:14	2008-02-05 22:57:14	t	0101000020E610000019B325AB223252C0994C158C4AC84440
1760	38	2008-02-05 23:00:14	2008-02-05 23:02:14	f	0101000020E6100000E371512D223252C08109DCBA9BC94440
1761	38	2008-02-05 23:05:13	2008-02-05 23:07:13	f	0101000020E610000072CADC7C233252C090A50F5D50CD4440
1762	38	2008-02-05 23:15:13	2008-02-05 23:17:13	f	0101000020E6100000CAE1934E243252C0DE76A1B94ECD4440
1763	38	2008-02-05 23:20:13	2008-02-05 23:22:13	t	0101000020E610000072CADC7C233252C0CAC342AD69C84440
1764	38	2008-02-05 23:25:13	2008-02-05 23:27:13	f	0101000020E61000008335CEA6233252C0CA54C1A8A4C84440
1765	38	2008-02-05 23:30:13	2008-02-05 23:32:13	t	0101000020E61000002B1E17D5223252C01FD7868A71C84440
1766	38	2008-02-05 23:35:13	2008-02-05 23:37:13	f	0101000020E61000003C8908FF223252C0AEBB79AA43C84440
1767	38	2008-02-05 23:40:13	2008-02-05 23:42:13	t	0101000020E610000023F94A20253252C0273108AC1CC84440
1768	38	2008-02-05 23:45:13	2008-02-05 23:47:13	t	0101000020E61000004EF4F928233252C0115839B4C8C84440
1769	38	2008-02-05 23:50:13	2008-02-05 23:52:13	f	0101000020E6100000CAE1934E243252C09296CADB11C84440
1770	38	2008-02-05 23:55:13	2008-02-05 23:57:13	f	0101000020E61000002B1E17D5223252C03BAA9A20EAC84440
1771	38	2008-02-05 23:55:13	2008-02-05 23:57:13	t	0101000020E61000002B1E17D5223252C03BAA9A20EAC84440
1772	38	2008-02-06 00:00:13	2008-02-06 00:02:13	f	0101000020E6100000A70BB1FA233252C0265305A392C84440
1773	38	2008-02-06 00:00:13	2008-02-06 00:02:13	t	0101000020E6100000A70BB1FA233252C0265305A392C84440
1774	38	2008-02-06 00:05:13	2008-02-06 00:07:13	f	0101000020E61000004EF4F928233252C0FC3A70CE88C84440
1775	38	2008-02-06 00:10:13	2008-02-06 00:12:13	t	0101000020E6100000A70BB1FA233252C066F7E461A1C84440
1776	38	2008-02-06 00:15:13	2008-02-06 00:17:13	t	0101000020E6100000A70BB1FA233252C0A01A2FDD24C84440
1777	38	2008-02-06 00:25:13	2008-02-06 00:27:13	t	0101000020E610000019B325AB223252C08AB0E1E995C84440
1778	38	2008-02-06 00:30:13	2008-02-06 00:32:13	t	0101000020E610000072CADC7C233252C06DFFCA4A93C84440
1779	38	2008-02-06 00:35:13	2008-02-06 00:37:13	f	0101000020E6100000CAE1934E243252C090A50F5D50CD4440
1780	38	2008-02-06 00:40:13	2008-02-06 00:42:13	f	0101000020E610000072CADC7C233252C0DF89592F86C84440
1781	38	2008-02-06 00:45:13	2008-02-06 00:47:13	t	0101000020E6100000EEB776A2243252C0A5315A4755CD4440
1782	38	2008-02-06 00:50:13	2008-02-06 00:52:13	t	0101000020E610000095A0BFD0233252C04833164D67CD4440
1783	38	2008-02-06 01:00:13	2008-02-06 01:02:13	t	0101000020E610000095A0BFD0233252C083A3E4D539C84440
1784	38	2008-02-06 01:05:13	2008-02-06 01:07:13	t	0101000020E6100000C3BCC799263252C06C7D91D096C94440
1785	38	2008-02-06 01:10:13	2008-02-06 01:12:13	f	0101000020E6100000DC4C8578243252C033A7CB6262CD4440
1786	38	2008-02-06 01:15:13	2008-02-06 01:17:13	f	0101000020E6100000128E59F6243252C0FC3A70CE88C84440
1787	38	2008-02-06 01:25:13	2008-02-06 01:27:13	t	0101000020E6100000B251D66F263252C0D942908312C84440
1788	38	2008-02-06 01:30:13	2008-02-06 01:32:13	f	0101000020E6100000E792AAED263252C05FD218ADA3CC4440
1789	38	2008-02-06 01:35:13	2008-02-06 01:37:13	f	0101000020E6100000B251D66F263252C0088F368E58CD4440
1790	38	2008-02-06 01:40:13	2008-02-06 01:42:13	f	0101000020E6100000D527B9C3263252C01FF98381E7C84440
1791	38	2008-02-06 01:45:13	2008-02-06 01:47:13	t	0101000020E61000008E7BF31B263252C04A0C022B87C84440
1792	40	2008-02-02 20:19:56	2008-02-02 20:21:56	f	0101000020E610000084F6EAE3A13752C0AFF02E17F1E74440
1793	40	2008-02-02 20:20:32	2008-02-02 20:22:32	f	0101000020E6100000647B2DE8BD3752C0D25790662CE84440
1794	40	2008-02-02 20:25:34	2008-02-02 20:27:34	t	0101000020E6100000852BA0504F3752C049111956F1E84440
1795	40	2008-02-02 20:29:59	2008-02-02 20:31:59	f	0101000020E6100000B45A608F893652C0906B43C538E94440
1796	40	2008-02-02 20:40:03	2008-02-02 20:42:03	t	0101000020E6100000BE70E7C2483552C049BF7D1D38E94440
1797	40	2008-02-02 20:45:41	2008-02-02 20:47:41	t	0101000020E6100000A32424D2363652C00F7F4DD6A8E94440
1798	40	2008-02-03 09:55:42	2008-02-03 09:57:42	f	0101000020E6100000792975C9383652C08F705AF0A2E94440
1799	40	2008-02-03 09:58:33	2008-02-03 10:00:33	t	0101000020E6100000792975C9383652C08F705AF0A2E94440
1800	40	2008-02-03 09:58:33	2008-02-03 10:00:33	f	0101000020E6100000792975C9383652C08F705AF0A2E94440
1801	40	2008-02-03 10:03:35	2008-02-03 10:05:35	f	0101000020E6100000E2CD1ABCAF3652C0ACFF73982FE94440
1802	39	2008-02-03 19:39:00	2008-02-03 19:41:00	f	0101000020E6100000E3934E24983452C0B2F4A10BEAD14440
1803	39	2008-02-03 19:39:19	2008-02-03 19:41:19	f	0101000020E61000009B3E3BE0BA3452C0726DA818E7D14440
1804	39	2008-02-03 19:44:02	2008-02-03 19:46:02	t	0101000020E6100000579BFF571D3552C0390B7BDAE1D14440
1805	39	2008-02-03 19:44:21	2008-02-03 19:46:21	t	0101000020E61000003E0B42791F3552C0A48D23D6E2D14440
1806	39	2008-02-03 19:49:03	2008-02-03 19:51:03	t	0101000020E61000007CF31B261A3652C008B13385CED14440
1807	39	2008-02-03 19:49:22	2008-02-03 19:51:22	t	0101000020E610000043058717443652C0F224E99AC9D14440
1808	39	2008-02-03 19:54:05	2008-02-03 19:56:05	t	0101000020E6100000C00F0709513652C0FE9AAC510FD34440
1809	39	2008-02-03 19:54:24	2008-02-03 19:56:24	t	0101000020E6100000C00F0709513652C0454772F90FD34440
1810	39	2008-02-03 19:59:26	2008-02-03 20:01:26	f	0101000020E61000004A641F64593652C07C61325530D44440
1811	39	2008-02-03 20:04:08	2008-02-03 20:06:08	t	0101000020E6100000FC928D075B3652C0D847A7AE7CD44440
1812	39	2008-02-03 20:04:27	2008-02-03 20:06:27	t	0101000020E610000038F92D3A593652C03CA583F57FD44440
1813	39	2008-02-03 20:09:10	2008-02-03 20:11:10	t	0101000020E6100000433F53AF5B3652C0E57E87A240D54440
1814	39	2008-02-03 20:09:29	2008-02-03 20:11:29	f	0101000020E6100000AEC1FBAA5C3652C05001309E41D54440
1815	39	2008-02-03 20:14:12	2008-02-03 20:16:12	f	0101000020E6100000B8CD5488473652C07311DF8959D54440
1816	39	2008-02-03 20:19:13	2008-02-03 20:21:13	f	0101000020E6100000F56DC1525D3652C049DC63E943D54440
1817	39	2008-02-03 20:24:15	2008-02-03 20:26:15	t	0101000020E6100000D8BCAAB35A3652C016FBCBEEC9D54440
1818	39	2008-02-03 20:29:17	2008-02-03 20:31:17	f	0101000020E61000001271732A193652C031F0DC7BB8D64440
1819	39	2008-02-03 20:34:18	2008-02-03 20:36:18	f	0101000020E61000002B1E17D5223652C00AF4893C49D84440
1820	39	2008-02-03 20:38:26	2008-02-03 20:40:26	t	0101000020E6100000E56723D74D3552C0DF718A8EE4D84440
1821	39	2008-02-03 20:39:20	2008-02-03 20:41:20	f	0101000020E61000009EBB5D2F4D3552C0BB9BA73AE4D84440
1822	39	2008-02-03 20:43:28	2008-02-03 20:45:28	t	0101000020E61000001AC6DD205A3552C0DD0720B589D94440
1823	39	2008-02-03 20:44:22	2008-02-03 20:46:22	f	0101000020E6100000AF433525593552C016DEE522BED94440
1824	39	2008-02-03 20:48:30	2008-02-03 20:50:30	f	0101000020E6100000E1F42EDE8F3552C0F9669B1BD3D94440
1825	39	2008-02-03 20:49:23	2008-02-03 20:51:23	t	0101000020E61000007AB0C56E9F3552C0F9669B1BD3D94440
1826	39	2008-02-03 20:53:31	2008-02-03 20:55:31	t	0101000020E61000000AFA0B3D623652C0809A5AB6D6D94440
1827	39	2008-02-03 20:54:25	2008-02-03 20:56:25	f	0101000020E610000003F22554703652C01C08C90226DA4440
1828	39	2008-02-03 20:59:26	2008-02-03 21:01:26	f	0101000020E61000005345F12A6B3752C0304CA60A46DB4440
1829	39	2008-02-03 21:02:40	2008-02-03 21:04:40	f	0101000020E6100000A32424D2363852C0BD8C62B9A5DB4440
1830	39	2008-02-03 21:04:28	2008-02-03 21:06:28	f	0101000020E61000002012BEF7373852C07D5C1B2AC6DB4440
1831	39	2008-02-03 21:09:30	2008-02-03 21:11:30	f	0101000020E610000040C7478B333852C0A1F31ABB44DB4440
1832	39	2008-02-03 21:14:31	2008-02-03 21:16:31	f	0101000020E61000001731EC30263752C0C156091687D94440
1833	39	2008-02-03 21:17:46	2008-02-03 21:19:46	f	0101000020E6100000B3BB4049813552C05C94D92093DA4440
1834	39	2008-02-03 21:19:33	2008-02-03 21:21:33	f	0101000020E61000007A0261A7583552C0CD920035B5DA4440
1835	39	2008-02-03 21:24:35	2008-02-03 21:26:35	f	0101000020E610000023DC6454193452C0E3FC4D2844DA4440
1836	39	2008-02-03 21:28:25	2008-02-03 21:30:25	t	0101000020E6100000ABD0402C9B3352C0C173EFE192D94440
1837	39	2008-02-03 21:29:36	2008-02-03 21:31:36	f	0101000020E61000008F1F2A8D983352C0DEEA39E97DD94440
1838	39	2008-02-03 21:29:36	2008-02-03 21:31:36	t	0101000020E61000008F1F2A8D983352C0DEEA39E97DD94440
1839	39	2008-02-03 21:33:27	2008-02-03 21:35:27	f	0101000020E61000009A8235CEA63352C09BC937DBDCDA4440
1840	39	2008-02-03 21:34:38	2008-02-03 21:36:38	f	0101000020E61000003D4A253CA13352C0F701486DE2DA4440
1841	39	2008-02-03 21:39:40	2008-02-03 21:41:40	t	0101000020E61000004C033FAA613352C00FD1E80E62DD4440
1842	39	2008-02-03 21:43:30	2008-02-03 21:45:30	t	0101000020E610000077C4211B483152C0EBC5504EB4DD4440
1843	39	2008-02-03 21:43:30	2008-02-03 21:45:30	f	0101000020E610000077C4211B483152C0EBC5504EB4DD4440
1844	39	2008-02-03 21:44:40	2008-02-03 21:46:40	f	0101000020E610000022C9ACDEE13052C03EE8D9ACFADE4440
1845	39	2008-02-03 21:48:31	2008-02-03 21:50:31	t	0101000020E610000016DF50F86C2F52C013D55B035BE34440
1846	39	2008-02-03 21:49:42	2008-02-03 21:51:42	f	0101000020E610000063D7F6764B2E52C0B0777FBC57E34440
1847	39	2008-02-03 21:53:32	2008-02-03 21:55:32	t	0101000020E61000000A51BEA0852C52C04E62105839E24440
1848	39	2008-02-03 21:54:44	2008-02-03 21:56:44	t	0101000020E6100000479561DC0D2C52C00DE544BB0AE34440
1849	39	2008-02-03 21:58:34	2008-02-03 22:00:34	t	0101000020E610000062A75835082B52C000A94D9CDCE54440
1850	39	2008-02-03 21:58:34	2008-02-03 22:00:34	f	0101000020E610000062A75835082B52C000A94D9CDCE54440
1851	39	2008-02-03 21:59:45	2008-02-03 22:01:45	f	0101000020E610000029B4ACFBC72A52C0E23B31EBC5E64440
1852	39	2008-02-03 22:03:35	2008-02-03 22:05:35	t	0101000020E61000003694DA8B682952C04F5DF92CCFE94440
1853	39	2008-02-03 22:04:47	2008-02-03 22:06:47	f	0101000020E61000009E9E7763412952C0C53D963E74EB4440
1854	39	2008-02-03 22:08:37	2008-02-03 22:10:37	t	0101000020E6100000C9EBC1A4F82852C0BF9F1A2FDDEE4440
1855	39	2008-02-03 22:09:49	2008-02-03 22:11:49	t	0101000020E6100000140B7C45B72852C0A03715A930F04440
1856	39	2008-02-03 22:13:39	2008-02-03 22:15:39	t	0101000020E6100000CDCD37A27B2652C05F984C158CF04440
1857	39	2008-02-03 22:14:50	2008-02-03 22:16:50	t	0101000020E6100000A8CCCD37A22552C03580B74082F04440
1858	39	2008-02-03 22:18:40	2008-02-03 22:20:40	f	0101000020E6100000304D11E0F42252C07C0F971C77F04440
1859	39	2008-02-03 22:19:52	2008-02-03 22:21:52	t	0101000020E61000008BAC3594DA2152C0AEBB79AA43F04440
1860	39	2008-02-03 22:23:42	2008-02-03 22:25:42	f	0101000020E6100000DA092FC1A91F52C0ACCABE2B82F14440
1861	39	2008-02-03 22:24:54	2008-02-03 22:26:54	t	0101000020E6100000912DCBD7651E52C057CF49EF1BF14440
1862	39	2008-02-03 22:28:44	2008-02-03 22:30:44	t	0101000020E610000044A9BD88B61B52C0E10B93A982F34440
1863	39	2008-02-03 22:29:55	2008-02-03 22:31:55	f	0101000020E61000007FE4D6A4DB1A52C09981CAF8F7F34440
1864	39	2008-02-03 22:33:45	2008-02-03 22:35:45	t	0101000020E6100000BA54A52DAE1952C09FC893A46BF44440
1865	39	2008-02-03 22:34:57	2008-02-03 22:36:57	f	0101000020E61000002BFC19DEAC1952C02E211FF46CF44440
1866	41	2008-02-06 17:24:17	2008-02-06 17:26:17	t	0101000020E6100000E4A6069ACF3552C0E02D90A0F8DB4440
1867	41	2008-02-06 17:28:13	2008-02-06 17:30:13	f	0101000020E610000087FF7403053652C0E6D022DBF9DC4440
1868	41	2008-02-06 17:42:30	2008-02-06 17:44:30	t	0101000020E61000008FB0A888D33552C03C31EBC550DC4440
1869	41	2008-02-06 17:47:32	2008-02-06 17:49:32	t	0101000020E61000004C8FA67A323752C0838B153598DC4440
1870	41	2008-02-06 17:52:34	2008-02-06 17:54:34	t	0101000020E6100000EEB776A2243852C0BA83D89942DD4440
1871	41	2008-02-06 17:57:36	2008-02-06 17:59:36	f	0101000020E61000002468CC24EA3752C02A00C63368DE4440
1872	41	2008-02-06 18:02:37	2008-02-06 18:04:37	f	0101000020E6100000A18A1BB7983752C0290AF4893CDF4440
1873	41	2008-02-06 18:07:39	2008-02-06 18:09:39	t	0101000020E6100000F1DDE68D933452C0F1A2AF20CDDE4440
1874	41	2008-02-06 18:07:39	2008-02-06 18:09:39	t	0101000020E6100000F1DDE68D933452C0F1A2AF20CDDE4440
1875	41	2008-02-06 18:12:41	2008-02-06 18:14:41	t	0101000020E6100000043FAA61BF3352C046D3D9C9E0DA4440
1876	41	2008-02-06 18:17:43	2008-02-06 18:19:43	f	0101000020E6100000469A7807783252C09609BFD4CFD94440
1877	41	2008-02-06 18:22:45	2008-02-06 18:24:45	t	0101000020E6100000962710768A3152C048551344DDD94440
1878	41	2008-02-06 18:27:46	2008-02-06 18:29:46	t	0101000020E610000099BC0166BE2F52C0B9196EC0E7D94440
1879	41	2008-02-06 18:32:48	2008-02-06 18:34:48	f	0101000020E61000005FD89AADBC2E52C0CD5D4BC807DB4440
1880	41	2008-02-06 18:37:50	2008-02-06 18:39:50	t	0101000020E6100000545DC0CB0C2F52C0C2FA3F87F9D84440
1881	41	2008-02-06 18:42:52	2008-02-06 18:44:52	t	0101000020E6100000D3191879592F52C021CD58349DD74440
1882	41	2008-02-06 18:47:53	2008-02-06 18:49:53	t	0101000020E61000009AF1B6D26B2F52C0F75D11FC6FD34440
1883	41	2008-02-06 18:52:55	2008-02-06 18:54:55	f	0101000020E610000065ABCB29012F52C07238F3AB39D24440
1884	41	2008-02-06 18:57:57	2008-02-06 18:59:57	t	0101000020E6100000812C4487C02F52C0DD291DACFFD14440
1885	41	2008-02-06 19:02:59	2008-02-06 19:04:59	t	0101000020E610000027E0D748123052C0DE1FEF552BD14440
1886	41	2008-02-06 19:08:00	2008-02-06 19:10:00	t	0101000020E6100000C07E880D163052C07862D68BA1D24440
1887	41	2008-02-06 19:13:02	2008-02-06 19:15:02	f	0101000020E610000055E41071733052C00DFD135CACD24440
1888	41	2008-02-06 19:18:04	2008-02-06 19:20:04	f	0101000020E61000009AD4D006603152C0E1B9F770C9D34440
1889	41	2008-02-06 19:23:06	2008-02-06 19:25:06	t	0101000020E61000002C6B9BE2712F52C0FD6A0E10CCD34440
1890	41	2008-02-06 19:28:08	2008-02-06 19:30:08	t	0101000020E6100000757CB438632E52C063F3716DA8D24440
1891	41	2008-02-06 19:33:09	2008-02-06 19:35:09	f	0101000020E61000003833FAD1702C52C01EE1B4E045D14440
1892	41	2008-02-06 19:38:11	2008-02-06 19:40:11	f	0101000020E6100000D8A4DB12B92C52C02E3E05C078D04440
1893	41	2008-02-06 19:43:13	2008-02-06 19:45:13	t	0101000020E6100000DFE17668582E52C0FF959526A5D24440
1894	41	2008-02-06 19:48:15	2008-02-06 19:50:15	f	0101000020E61000005CECF659652E52C00E897B2C7DD24440
1895	41	2008-02-06 19:53:16	2008-02-06 19:55:16	f	0101000020E6100000CC113290672F52C0AD6EF59CF4D04440
1896	41	2008-02-06 19:58:17	2008-02-06 20:00:17	f	0101000020E6100000F5A78DEA743052C0F0DC7BB8E4CE4440
1897	41	2008-02-06 20:03:19	2008-02-06 20:05:19	f	0101000020E61000009167976F7D3052C01D2098A3C7CD4440
1898	41	2008-02-06 20:14:24	2008-02-06 20:16:24	f	0101000020E6100000EA0AB6114F3052C0040473F4F8CB4440
1899	41	2008-02-06 20:19:26	2008-02-06 20:21:26	f	0101000020E6100000C17971E2AB2F52C0263B3602F1CC4440
1900	41	2008-02-06 20:24:28	2008-02-06 20:26:28	f	0101000020E6100000DDD8EC48F52F52C0FE60E0B9F7CE4440
1901	41	2008-02-06 20:29:29	2008-02-06 20:31:29	t	0101000020E6100000066A3178983052C04339D1AE42D04440
1902	41	2008-02-06 20:34:31	2008-02-06 20:36:31	t	0101000020E6100000BE361B2B313152C00AA2EE0390D04440
1903	41	2008-02-06 20:39:33	2008-02-06 20:41:33	t	0101000020E6100000107BA180ED3052C0B5E0455F41D04440
1904	41	2008-02-06 20:44:34	2008-02-06 20:46:34	t	0101000020E61000000956D5CBEF3052C01C2AC6F99BD24440
1905	41	2008-02-06 20:49:35	2008-02-06 20:51:35	f	0101000020E61000000E384BC9722E52C0A35D85949FD24440
1906	41	2008-02-06 20:54:37	2008-02-06 20:56:37	f	0101000020E6100000890D164ED22C52C04F0647C9ABD14440
1907	41	2008-02-06 20:59:39	2008-02-06 21:01:39	f	0101000020E6100000A03D97A9492C52C08B37328FFCCF4440
1908	41	2008-02-06 21:04:41	2008-02-06 21:06:41	t	0101000020E6100000B44291EEE72C52C0096D3997E2D04440
1909	41	2008-02-06 21:09:43	2008-02-06 21:11:43	t	0101000020E6100000E6284014CC2C52C03A7AFCDEA6D14440
1910	41	2008-02-06 21:14:44	2008-02-06 21:16:44	t	0101000020E6100000DF72F563932E52C00E677E3507D24440
1911	41	2008-02-06 21:24:48	2008-02-06 21:26:48	f	0101000020E6100000B76801DA562D52C03B3602F1BAD44440
1912	41	2008-02-06 21:29:50	2008-02-06 21:31:50	t	0101000020E610000030D978B0C52C52C0A583F57F0ED54440
1913	41	2008-02-06 21:34:51	2008-02-06 21:36:51	f	0101000020E6100000DD813AE5D12D52C06614CB2DADD44440
1914	41	2008-02-06 21:39:53	2008-02-06 21:41:53	f	0101000020E610000039BA4A77D72F52C05E11FC6F25D54440
1915	41	2008-02-06 21:44:55	2008-02-06 21:46:55	f	0101000020E61000002CBD361B2B3152C06CEC12D55BD94440
1916	41	2008-02-06 21:49:57	2008-02-06 21:51:57	t	0101000020E6100000AD3594DA8B3452C022FDF675E0DA4440
1917	41	2008-02-06 21:49:57	2008-02-06 21:51:57	t	0101000020E6100000AD3594DA8B3452C022FDF675E0DA4440
1918	41	2008-02-06 22:00:00	2008-02-06 22:02:00	f	0101000020E61000005EA3E5400F3752C09B728577B9DA4440
1919	41	2008-02-06 22:05:02	2008-02-06 22:07:02	f	0101000020E6100000FA84ECBC8D3752C02C2B4D4A41DD4440
1920	41	2008-02-06 22:10:04	2008-02-06 22:12:04	f	0101000020E6100000C122BF7E883952C003ECA35357DC4440
1921	41	2008-02-06 22:15:06	2008-02-06 22:17:06	t	0101000020E610000066FD6662BA3A52C0685C381092DB4440
1922	41	2008-02-06 22:20:07	2008-02-06 22:22:07	t	0101000020E61000000B815CE2C83952C0431CEBE236DC4440
1923	41	2008-02-06 22:25:09	2008-02-06 22:27:09	f	0101000020E61000007256444DF43752C07AFCDEA63FDD4440
1924	41	2008-02-06 22:30:11	2008-02-06 22:32:11	f	0101000020E6100000A1DCB6EF513352C0CF66D5E76ADD4440
1925	41	2008-02-06 22:35:14	2008-02-06 22:37:14	f	0101000020E6100000210890A1632F52C029B3412619DB4440
1926	41	2008-02-06 22:40:14	2008-02-06 22:42:14	f	0101000020E6100000E64526E0D72E52C08351499D80D84440
1927	41	2008-02-06 22:50:18	2008-02-06 22:52:18	f	0101000020E6100000FF9B1727BE3052C0CF31207BBDD54440
1928	41	2008-02-06 22:55:20	2008-02-06 22:57:20	f	0101000020E6100000DB56B3CEF83052C0032670EB6ED44440
1929	41	2008-02-06 23:00:22	2008-02-06 23:02:22	t	0101000020E610000079B5DC99093252C03C1405FA44D44440
1930	41	2008-02-06 23:05:23	2008-02-06 23:07:23	t	0101000020E610000077FEEDB25F3352C0975643E21ED54440
1931	41	2008-02-06 23:10:25	2008-02-06 23:12:25	t	0101000020E61000005E6E30D4613352C0963E74417DD54440
1932	41	2008-02-06 23:15:27	2008-02-06 23:17:27	t	0101000020E610000048A81952453152C0BAA0BE654ED54440
1933	41	2008-02-06 23:20:29	2008-02-06 23:22:29	t	0101000020E6100000C5CA68E4F33052C018B2BAD573D44440
1934	41	2008-02-06 23:25:30	2008-02-06 23:27:30	t	0101000020E6100000A41F0DA7CC3152C0427DCB9C2ED54440
1935	41	2008-02-06 23:30:32	2008-02-06 23:32:32	f	0101000020E6100000DF550F98873052C04F0647C9ABD54440
1936	41	2008-02-06 23:35:34	2008-02-06 23:37:34	t	0101000020E6100000A2116C5CFF3052C08672A25D85D64440
1937	41	2008-02-06 23:40:36	2008-02-06 23:42:36	f	0101000020E6100000EB9106B7B53152C0F73B1405FADA4440
1938	41	2008-02-06 23:45:37	2008-02-06 23:47:37	f	0101000020E6100000904FC8CEDB3252C0809F71E140DE4440
1939	41	2008-02-06 23:50:39	2008-02-06 23:52:39	f	0101000020E61000003B1F9E25C83252C05D1B2AC6F9E14440
1940	41	2008-02-06 23:55:41	2008-02-06 23:57:41	f	0101000020E610000091F3FE3F4E3252C0FA0AD28C45E14440
1941	42	2008-02-06 17:52:53	2008-02-06 17:54:53	t	0101000020E6100000DFE17668583052C02C9FE57970D54440
1942	42	2008-02-06 18:02:53	2008-02-06 18:04:53	f	0101000020E6100000A9DF85ADD92E52C0C408E1D1C6D34440
1943	42	2008-02-06 18:02:53	2008-02-06 18:04:53	t	0101000020E6100000A9DF85ADD92E52C0C408E1D1C6D34440
1944	42	2008-02-06 18:12:53	2008-02-06 18:14:53	f	0101000020E610000094E4B9BE0F3152C0992A1895D4D34440
1945	42	2008-02-06 18:22:53	2008-02-06 18:24:53	t	0101000020E61000005DE2C803913152C0F3C81F0C3CD54440
1946	42	2008-02-06 18:32:53	2008-02-06 18:34:53	t	0101000020E6100000AFF199EC9F3152C0BFB7E9CF7ED64440
1947	42	2008-02-06 18:42:53	2008-02-06 18:44:53	f	0101000020E6100000C19657AEB73152C0A228D027F2DA4440
1948	42	2008-02-06 18:52:53	2008-02-06 18:54:53	f	0101000020E6100000277156444D3252C0F241CF66D5D94440
1949	42	2008-02-06 19:02:53	2008-02-06 19:04:53	t	0101000020E61000002E793C2D3F3252C05F807D74EAD84440
1950	42	2008-02-06 19:12:53	2008-02-06 19:14:53	t	0101000020E6100000969BA8A5B93152C04356B77A4EDC4440
1951	43	2008-02-03 20:38:37	2008-02-03 20:40:37	f	0101000020E61000006845D4449F3B52C05D33F9669BD54440
1952	43	2008-02-03 20:43:37	2008-02-03 20:45:37	f	0101000020E6100000975CC5E2373D52C06458C51B99D54440
1953	43	2008-02-03 20:48:24	2008-02-03 20:50:24	t	0101000020E6100000416B7EFCA53152C01C25AFCE31D24440
1954	43	2008-02-03 20:48:37	2008-02-03 20:50:37	t	0101000020E61000001B4D2EC6C03E52C0AC048BC399D54440
1955	43	2008-02-03 20:53:37	2008-02-03 20:55:37	t	0101000020E61000001CB7989F1B4052C08F53742497D54440
1956	43	2008-02-03 20:58:37	2008-02-03 21:00:37	f	0101000020E610000097CB46E7FC4052C0BEA4315A47D74440
1957	43	2008-02-03 21:03:37	2008-02-03 21:05:37	f	0101000020E6100000DE770C8FFD4052C036B05582C5D74440
1958	43	2008-02-03 21:08:37	2008-02-03 21:10:37	t	0101000020E6100000D9B79388F04152C09FE5797077D84440
1959	43	2008-02-03 21:13:37	2008-02-03 21:15:37	f	0101000020E6100000B6F97FD5914152C0359886E123D84440
1960	43	2008-02-03 21:18:37	2008-02-03 21:20:37	f	0101000020E61000002A5DFA97A44052C0D1CB28965BD84440
1961	43	2008-02-04 00:26:03	2008-02-04 00:28:03	t	0101000020E6100000DF3829CC7B3A52C024287E8CB9C54440
1962	43	2008-02-04 00:31:03	2008-02-04 00:33:03	f	0101000020E6100000F1A31AF67B3A52C0AB3E575BB1C54440
1963	43	2008-02-04 00:36:02	2008-02-04 00:38:02	t	0101000020E6100000A3D288997D3A52C072F90FE9B7C54440
1964	43	2008-02-04 00:41:02	2008-02-04 00:43:02	t	0101000020E6100000030F0C207C3A52C01DE6CB0BB0C54440
1965	43	2008-02-04 00:46:02	2008-02-04 00:48:02	t	0101000020E61000005C26C3F17C3A52C07A1EDC9DB5C54440
1966	43	2008-02-04 00:51:02	2008-02-04 00:53:02	f	0101000020E61000004ABBD1C77C3A52C0327216F6B4C54440
1967	43	2008-02-04 00:56:02	2008-02-04 00:58:02	f	0101000020E61000004ABBD1C77C3A52C0327216F6B4C54440
1968	43	2008-02-04 01:01:02	2008-02-04 01:03:02	f	0101000020E61000003850E09D7C3A52C0C8EF6DFAB3C54440
1969	43	2008-02-04 01:06:02	2008-02-04 01:08:02	f	0101000020E610000026E5EE737C3A52C08143A852B3C54440
1970	43	2008-02-04 01:11:02	2008-02-04 01:13:02	t	0101000020E610000026E5EE737C3A52C05D6DC5FEB2C54440
1971	43	2008-02-04 01:16:02	2008-02-04 01:18:02	t	0101000020E610000026E5EE737C3A52C03A97E2AAB2C54440
1972	43	2008-02-04 01:21:02	2008-02-04 01:23:02	t	0101000020E61000009167976F7D3A52C0D656EC2FBBC54440
1973	43	2008-02-04 01:26:02	2008-02-04 01:28:02	f	0101000020E6100000BC6246787B3A52C03A97E2AAB2C54440
1974	43	2008-02-04 01:31:02	2008-02-04 01:33:02	t	0101000020E6100000AAF7544E7B3A52C05D6DC5FEB2C54440
1975	43	2008-02-04 01:36:02	2008-02-04 01:38:02	t	0101000020E61000005C26C3F17C3A52C041D9942BBCC54440
1976	43	2008-02-04 01:41:02	2008-02-04 01:43:02	f	0101000020E6100000F1A31AF67B3A52C096CFF23CB8C54440
1977	43	2008-02-04 01:41:02	2008-02-04 01:43:02	t	0101000020E6100000F1A31AF67B3A52C096CFF23CB8C54440
1978	43	2008-02-04 01:46:02	2008-02-04 01:48:02	t	0101000020E6100000DF3829CC7B3A52C0E4A08499B6C54440
1979	43	2008-02-04 01:51:02	2008-02-04 01:53:02	t	0101000020E6100000DF3829CC7B3A52C0087767EDB6C54440
1980	43	2008-02-04 01:56:02	2008-02-04 01:58:02	f	0101000020E6100000DF3829CC7B3A52C0087767EDB6C54440
1981	43	2008-02-04 02:01:02	2008-02-04 02:03:02	t	0101000020E6100000DF3829CC7B3A52C048FE60E0B9C54440
1982	43	2008-02-04 02:11:02	2008-02-04 02:13:02	f	0101000020E6100000F1A31AF67B3A52C0FA2CCF83BBC54440
1983	43	2008-02-04 02:16:02	2008-02-04 02:18:02	f	0101000020E6100000F1A31AF67B3A52C0FA2CCF83BBC54440
1984	43	2008-02-04 02:21:02	2008-02-04 02:23:02	t	0101000020E6100000F1A31AF67B3A52C0D656EC2FBBC54440
1985	43	2008-02-04 02:26:02	2008-02-04 02:28:02	f	0101000020E6100000DF3829CC7B3A52C0D656EC2FBBC54440
1986	43	2008-02-04 02:31:02	2008-02-04 02:33:02	f	0101000020E6100000DF3829CC7B3A52C0B28009DCBAC54440
1987	43	2008-02-04 02:36:02	2008-02-04 02:38:02	t	0101000020E6100000DF3829CC7B3A52C0B28009DCBAC54440
1988	43	2008-02-04 02:41:02	2008-02-04 02:43:02	t	0101000020E6100000DF3829CC7B3A52C0B28009DCBAC54440
1989	43	2008-02-04 02:46:02	2008-02-04 02:48:02	f	0101000020E6100000DF3829CC7B3A52C08FAA2688BAC54440
1990	43	2008-02-04 02:51:02	2008-02-04 02:53:02	f	0101000020E6100000DF3829CC7B3A52C06BD44334BAC54440
1991	43	2008-02-04 02:56:02	2008-02-04 02:58:02	t	0101000020E6100000BC6246787B3A52C08FAA2688BAC54440
1992	43	2008-02-04 03:01:02	2008-02-04 03:03:02	t	0101000020E6100000BC6246787B3A52C08FAA2688BAC54440
1993	43	2008-02-04 03:06:02	2008-02-04 03:08:02	t	0101000020E6100000D1D1AA96743A52C096CFF23CB8C54440
1994	43	2008-02-04 03:11:02	2008-02-04 03:13:02	f	0101000020E6100000E33C9CC0743A52C096CFF23CB8C54440
1995	43	2008-02-04 03:16:01	2008-02-04 03:18:01	t	0101000020E6100000634B8FA67A3A52C0C8EF6DFAB3C54440
1996	43	2008-02-04 03:21:01	2008-02-04 03:23:01	f	0101000020E6100000F1A31AF67B3A52C06BD44334BAC54440
1997	43	2008-02-04 03:26:01	2008-02-04 03:28:01	f	0101000020E610000026E5EE737C3A52C04F232D95B7C54440
1998	43	2008-02-04 03:31:01	2008-02-04 03:33:01	f	0101000020E61000003850E09D7C3A52C0087767EDB6C54440
1999	43	2008-02-04 03:36:01	2008-02-04 03:38:01	f	0101000020E61000004ABBD1C77C3A52C0E4A08499B6C54440
2000	43	2008-02-04 03:41:01	2008-02-04 03:43:01	f	0101000020E61000003850E09D7C3A52C0C1CAA145B6C54440
2001	43	2008-02-04 03:46:01	2008-02-04 03:48:01	t	0101000020E61000003850E09D7C3A52C07A1EDC9DB5C54440
2002	43	2008-02-04 03:51:01	2008-02-04 03:53:01	f	0101000020E61000003850E09D7C3A52C0327216F6B4C54440
2003	43	2008-02-04 03:56:01	2008-02-04 03:58:01	f	0101000020E61000003850E09D7C3A52C00F9C33A2B4C54440
2004	43	2008-02-04 04:01:01	2008-02-04 04:03:01	f	0101000020E61000003850E09D7C3A52C0327216F6B4C54440
2005	43	2008-02-04 04:06:01	2008-02-04 04:08:01	t	0101000020E61000004ABBD1C77C3A52C05648F949B5C54440
2006	43	2008-02-04 04:06:01	2008-02-04 04:08:01	t	0101000020E61000004ABBD1C77C3A52C05648F949B5C54440
2007	43	2008-02-04 04:11:01	2008-02-04 04:13:01	t	0101000020E61000004ABBD1C77C3A52C05648F949B5C54440
2008	43	2008-02-04 04:16:01	2008-02-04 04:18:01	f	0101000020E61000005C26C3F17C3A52C07A1EDC9DB5C54440
2009	43	2008-02-04 04:21:01	2008-02-04 04:23:01	t	0101000020E61000005C26C3F17C3A52C09DF4BEF1B5C54440
2010	43	2008-02-04 04:26:01	2008-02-04 04:28:01	f	0101000020E61000005C26C3F17C3A52C0C1CAA145B6C54440
2011	43	2008-02-04 04:31:01	2008-02-04 04:33:01	f	0101000020E61000005C26C3F17C3A52C0E4A08499B6C54440
2012	43	2008-02-04 04:36:01	2008-02-04 04:38:01	f	0101000020E61000006D91B41B7D3A52C0087767EDB6C54440
2013	43	2008-02-04 04:41:01	2008-02-04 04:43:01	t	0101000020E61000006D91B41B7D3A52C0087767EDB6C54440
2014	43	2008-02-04 04:46:01	2008-02-04 04:48:01	t	0101000020E61000006D91B41B7D3A52C0087767EDB6C54440
2015	43	2008-02-04 04:51:01	2008-02-04 04:53:01	f	0101000020E61000006D91B41B7D3A52C02B4D4A41B7C54440
2016	44	2008-02-04 02:51:35	2008-02-04 02:53:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2017	44	2008-02-04 02:56:35	2008-02-04 02:58:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2018	44	2008-02-04 03:01:35	2008-02-04 03:03:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2019	44	2008-02-04 03:06:35	2008-02-04 03:08:35	f	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2020	44	2008-02-04 03:11:35	2008-02-04 03:13:35	f	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2021	44	2008-02-04 03:16:35	2008-02-04 03:18:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2022	44	2008-02-04 03:21:35	2008-02-04 03:23:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2023	44	2008-02-04 03:26:35	2008-02-04 03:28:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2024	44	2008-02-04 03:31:35	2008-02-04 03:33:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2025	44	2008-02-04 03:36:35	2008-02-04 03:38:35	t	0101000020E6100000A01B9AB2D32B52C0D578E92631DE4440
2026	45	2008-02-02 19:13:58	2008-02-02 19:15:58	f	0101000020E61000003CC3D4963A2E52C059349D9D0CC84440
2027	45	2008-02-02 19:13:58	2008-02-02 19:15:58	t	0101000020E61000003CC3D4963A2E52C059349D9D0CC84440
2028	45	2008-02-02 19:20:38	2008-02-02 19:22:38	t	0101000020E6100000AABD88B6632E52C003ECA35357C84440
2029	45	2008-02-02 19:30:38	2008-02-02 19:32:38	f	0101000020E6100000568330B77B2D52C0E7525C55F6C74440
2030	45	2008-02-02 19:30:51	2008-02-02 19:32:51	t	0101000020E6100000FE4E93196F2D52C06F2F698CD6C74440
2031	45	2008-02-02 19:40:38	2008-02-02 19:42:38	f	0101000020E6100000C908A870042D52C0384F75C8CDC64440
2032	45	2008-02-02 19:50:38	2008-02-02 19:52:38	t	0101000020E6100000CF37A27BD62B52C004E78C28EDC74440
2033	45	2008-02-02 20:00:38	2008-02-02 20:02:38	t	0101000020E610000020477364E52952C0CB2DAD86C4C34440
2034	45	2008-02-02 20:10:38	2008-02-02 20:12:38	t	0101000020E610000027A60BB1FA2952C00B0C59DDEAC34440
2035	45	2008-02-02 20:16:00	2008-02-02 20:18:00	t	0101000020E610000081441328622B52C0F96BB2463DC64440
2036	45	2008-02-02 20:26:00	2008-02-02 20:28:00	t	0101000020E61000003833FAD1702C52C055FB743C66CA4440
2037	45	2008-02-02 20:46:00	2008-02-02 20:48:00	t	0101000020E6100000E819FB928D3152C0B493C151F2D04440
2038	45	2008-02-02 20:56:00	2008-02-02 20:58:00	t	0101000020E61000008A7C9752973652C04AEF1B5F7BD44440
2039	45	2008-02-02 21:06:00	2008-02-02 21:08:00	f	0101000020E61000007A59130B7C3752C08811C2A38DD54440
2040	45	2008-02-02 21:14:39	2008-02-02 21:16:39	f	0101000020E6100000CF37A27BD63552C0651EF98381D54440
2041	45	2008-02-02 21:16:00	2008-02-02 21:18:00	t	0101000020E6100000418864C8B13552C050C763062AD54440
2042	45	2008-02-02 21:26:00	2008-02-02 21:28:00	f	0101000020E6100000E870ADF6B03552C00A11700855D44440
2043	45	2008-02-02 21:36:00	2008-02-02 21:38:00	t	0101000020E6100000FA2D3A596A3552C0FE0E45813ED34440
2044	45	2008-02-02 21:46:00	2008-02-02 21:48:00	t	0101000020E6100000F802B342913252C076FD82DDB0D34440
2045	45	2008-02-02 21:56:00	2008-02-02 21:58:00	f	0101000020E61000002B53CC41D02F52C0713D0AD7A3D24440
2046	45	2008-02-02 21:59:11	2008-02-02 22:01:11	t	0101000020E6100000D353E410712F52C064CC5D4BC8D14440
2047	45	2008-02-02 22:09:11	2008-02-02 22:11:11	f	0101000020E61000003968AF3E1E2C52C09EEFA7C64BC94440
2048	45	2008-02-02 22:19:11	2008-02-02 22:21:11	t	0101000020E6100000E2B54B1B0E2D52C0CDCCCCCCCCC64440
2049	45	2008-02-02 22:29:11	2008-02-02 22:31:11	f	0101000020E61000003B3C84F1D32C52C06A87BF266BC64440
2050	45	2008-02-02 22:39:11	2008-02-02 22:41:11	t	0101000020E6100000BD2363B5F92952C086C954C1A8C24440
2051	45	2008-02-02 22:49:11	2008-02-02 22:51:11	t	0101000020E6100000FE0FB056ED2852C0D5EC815660C24440
2052	45	2008-02-02 22:59:11	2008-02-02 23:01:11	t	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2053	45	2008-02-02 23:09:11	2008-02-02 23:11:11	f	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2054	45	2008-02-02 23:19:11	2008-02-02 23:21:11	t	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2055	45	2008-02-02 23:29:11	2008-02-02 23:31:11	t	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2056	45	2008-02-02 23:39:11	2008-02-02 23:41:11	f	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2057	45	2008-02-02 23:49:11	2008-02-02 23:51:11	f	0101000020E6100000B763EAAEEC2852C0B1169F0260C24440
2058	45	2008-02-02 23:59:11	2008-02-03 00:01:11	f	0101000020E6100000B763EAAEEC2852C0B1169F0260C24440
2059	45	2008-02-02 23:59:11	2008-02-03 00:01:11	f	0101000020E6100000B763EAAEEC2852C0B1169F0260C24440
2060	45	2008-02-03 00:09:11	2008-02-03 00:11:11	t	0101000020E6100000B763EAAEEC2852C0B1169F0260C24440
2061	45	2008-02-03 00:19:11	2008-02-03 00:21:11	t	0101000020E6100000B763EAAEEC2852C0B1169F0260C24440
2062	45	2008-02-03 00:29:11	2008-02-03 00:31:11	f	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2063	45	2008-02-03 00:39:11	2008-02-03 00:41:11	f	0101000020E6100000B763EAAEEC2852C08E40BCAE5FC24440
2064	45	2008-02-03 00:49:11	2008-02-03 00:51:11	t	0101000020E6100000B763EAAEEC2852C06A6AD95A5FC24440
2065	45	2008-02-03 00:59:11	2008-02-03 01:01:11	f	0101000020E6100000FBEE5696E82852C04EB9C2BB5CC24440
2066	45	2008-02-03 01:19:11	2008-02-03 01:21:11	f	0101000020E610000006357C0BEB2852C04EB9C2BB5CC24440
2067	45	2008-02-03 01:29:11	2008-02-03 01:31:11	t	0101000020E610000017A06D35EB2852C04EB9C2BB5CC24440
2068	45	2008-02-03 01:39:11	2008-02-03 01:41:11	f	0101000020E610000017A06D35EB2852C04EB9C2BB5CC24440
2069	45	2008-02-03 01:49:11	2008-02-03 01:51:11	f	0101000020E6100000290B5F5FEB2852C04EB9C2BB5CC24440
2070	45	2008-02-03 01:59:11	2008-02-03 02:01:11	t	0101000020E61000003B765089EB2852C04EB9C2BB5CC24440
2071	45	2008-02-03 02:19:10	2008-02-03 02:21:10	f	0101000020E61000004DE141B3EB2852C0956588635DC24440
2072	45	2008-02-03 02:29:10	2008-02-03 02:31:10	f	0101000020E61000005E4C33DDEB2852C0956588635DC24440
2073	45	2008-02-03 02:39:10	2008-02-03 02:41:10	f	0101000020E61000005E4C33DDEB2852C0B83B6BB75DC24440
2074	45	2008-02-03 02:49:10	2008-02-03 02:51:10	t	0101000020E61000005E4C33DDEB2852C0DC114E0B5EC24440
2075	45	2008-02-03 02:59:10	2008-02-03 03:01:10	f	0101000020E61000005E4C33DDEB2852C000E8305F5EC24440
2076	45	2008-02-03 03:09:10	2008-02-03 03:11:10	f	0101000020E610000070B72407EC2852C000E8305F5EC24440
2077	45	2008-02-03 03:19:10	2008-02-03 03:21:10	t	0101000020E610000070B72407EC2852C000E8305F5EC24440
2078	45	2008-02-03 03:39:10	2008-02-03 03:41:10	f	0101000020E610000082221631EC2852C000E8305F5EC24440
2079	45	2008-02-03 03:59:10	2008-02-03 04:01:10	f	0101000020E610000082221631EC2852C0DC114E0B5EC24440
2080	45	2008-02-03 04:09:10	2008-02-03 04:11:10	f	0101000020E6100000C9CEDBD8EC2852C0C785032159C24440
2081	45	2008-02-03 04:19:10	2008-02-03 04:21:10	t	0101000020E6100000DB39CD02ED2852C0C060376C5BC24440
2082	45	2008-02-03 04:29:10	2008-02-03 04:31:10	t	0101000020E6100000DB39CD02ED2852C0070DFD135CC24440
2083	45	2008-02-03 04:39:10	2008-02-03 04:41:10	f	0101000020E6100000DB39CD02ED2852C02AE3DF675CC24440
2084	45	2008-02-03 04:49:10	2008-02-03 04:51:10	t	0101000020E6100000948D075BEC2852C000E8305F5EC24440
2085	45	2008-02-03 04:49:10	2008-02-03 04:51:10	f	0101000020E6100000948D075BEC2852C000E8305F5EC24440
2086	45	2008-02-03 04:49:10	2008-02-03 04:51:10	f	0101000020E6100000948D075BEC2852C000E8305F5EC24440
2087	45	2008-02-03 04:49:10	2008-02-03 04:51:10	f	0101000020E6100000948D075BEC2852C000E8305F5EC24440
2088	45	2008-02-03 04:59:10	2008-02-03 05:01:10	f	0101000020E6100000948D075BEC2852C000E8305F5EC24440
2089	45	2008-02-03 05:09:10	2008-02-03 05:11:10	t	0101000020E610000070B72407EC2852C023BE13B35EC24440
2090	45	2008-02-03 05:19:10	2008-02-03 05:21:10	t	0101000020E610000070B72407EC2852C023BE13B35EC24440
2091	46	2008-02-05 09:19:02	2008-02-05 09:21:02	t	0101000020E6100000B45F77BAF32C52C03D61890794D74440
2092	46	2008-02-05 09:29:02	2008-02-05 09:31:02	f	0101000020E6100000B7BA9C12102D52C089EFC4AC17D94440
2093	46	2008-02-05 09:34:02	2008-02-05 09:36:02	f	0101000020E6100000DDD3D51D8B2D52C0EDF5EE8FF7D84440
2094	46	2008-02-05 09:39:02	2008-02-05 09:41:02	t	0101000020E6100000284A42226D2F52C026AAB706B6D84440
2095	46	2008-02-05 09:44:02	2008-02-05 09:46:02	f	0101000020E61000005649641F642F52C0555227A089D64440
2096	46	2008-02-05 09:49:02	2008-02-05 09:51:02	f	0101000020E610000035BBEEAD483052C087FE092E56D64440
2097	46	2008-02-05 09:54:02	2008-02-05 09:56:02	f	0101000020E610000022E692AAED3052C0CF31207BBDD54440
2098	46	2008-02-05 09:59:02	2008-02-05 10:01:02	f	0101000020E610000026766D6FB73052C038842A357BD64440
2099	46	2008-02-05 10:04:02	2008-02-05 10:06:02	t	0101000020E6100000A83B4F3C672F52C087F9F202ECD54440
2100	46	2008-02-05 10:04:02	2008-02-05 10:06:02	t	0101000020E6100000A83B4F3C672F52C087F9F202ECD54440
2101	47	2008-02-05 17:57:54	2008-02-05 17:59:54	f	0101000020E6100000408D7BF31B3852C041F67AF7C7E54440
2102	47	2008-02-05 18:17:54	2008-02-05 18:19:54	f	0101000020E61000009AB7EA3A543752C05EBA490C02E54440
2103	47	2008-02-05 18:27:54	2008-02-05 18:29:54	t	0101000020E6100000055262D7F63452C0894160E5D0E04440
2104	47	2008-02-05 18:37:54	2008-02-05 18:39:54	t	0101000020E6100000DFACC1FBAA3452C070F085C954DB4440
2105	47	2008-02-05 18:47:54	2008-02-05 18:49:54	f	0101000020E61000007B71E2AB1D3552C0B1506B9A77DA4440
2106	47	2008-02-05 18:57:54	2008-02-05 18:59:54	f	0101000020E610000034FAD170CA3452C08E23D6E253DA4440
2107	47	2008-02-05 19:07:54	2008-02-05 19:09:54	t	0101000020E6100000F4E670ADF63452C095D920938CDA4440
2108	47	2008-02-05 19:17:54	2008-02-05 19:19:54	t	0101000020E610000048904AB1A33552C00F62670A9DD94440
2109	47	2008-02-05 19:20:37	2008-02-05 19:22:37	t	0101000020E6100000121AC1C6F53552C097900F7A36D94440
2110	47	2008-02-05 19:30:32	2008-02-05 19:32:32	f	0101000020E6100000732F302B143552C0C190D5AD9ED94440
2111	47	2008-02-05 19:33:41	2008-02-05 19:35:41	t	0101000020E6100000DB1CE736E13452C091662C9ACED84440
2112	47	2008-02-05 19:42:01	2008-02-05 19:44:01	f	0101000020E6100000983AC8EBC13452C0473D44A33BD64440
2113	47	2008-02-05 19:43:41	2008-02-05 19:45:41	t	0101000020E6100000A6F3E159823452C0CE531D7233D64440
2114	47	2008-02-05 19:53:41	2008-02-05 19:55:41	f	0101000020E6100000EE43DE72F53552C09E7B0F971CD94440
2115	47	2008-02-05 19:53:41	2008-02-05 19:55:41	f	0101000020E6100000EE43DE72F53552C09E7B0F971CD94440
2116	47	2008-02-05 20:03:41	2008-02-05 20:05:41	f	0101000020E61000001A5245F12A3752C0BD9179E40FDC4440
2117	47	2008-02-05 20:04:51	2008-02-05 20:06:51	f	0101000020E6100000F7EFFACC593752C02EE7525C55DC4440
2118	47	2008-02-05 20:14:51	2008-02-05 20:16:51	f	0101000020E6100000FF4465C39A3852C01CF0F96184DA4440
2119	47	2008-02-05 20:17:10	2008-02-05 20:19:10	f	0101000020E6100000171406651A3952C093C6681D55DB4440
2120	47	2008-02-05 20:25:59	2008-02-05 20:27:59	f	0101000020E610000073C0AE264F3952C0AB2688BA0FDE4440
2121	47	2008-02-05 20:38:00	2008-02-05 20:40:00	f	0101000020E61000005DE2C803913752C02315C61682DE4440
2122	47	2008-02-05 20:48:00	2008-02-05 20:50:00	f	0101000020E610000048904AB1A33752C09FE5797077E04440
2123	47	2008-02-05 20:50:51	2008-02-05 20:52:51	f	0101000020E6100000738BF9B9A13752C0757632384AE04440
2124	47	2008-02-05 21:10:51	2008-02-05 21:12:51	f	0101000020E610000039A27BD6353252C0B56CAD2F12E44440
2125	47	2008-02-05 21:16:02	2008-02-05 21:18:02	t	0101000020E6100000D605BCCCB03152C031EBC5504EE64440
2126	47	2008-02-05 21:20:51	2008-02-05 21:22:51	t	0101000020E610000043E8A04B383252C01DC9E53FA4E54440
2127	47	2008-02-05 21:30:51	2008-02-05 21:32:51	f	0101000020E6100000C0D53A71393252C07FA4880CABDE4440
2128	47	2008-02-05 21:44:53	2008-02-05 21:46:53	f	0101000020E61000007256444DF43152C08AC8B08A37DC4440
2129	47	2008-02-05 21:44:53	2008-02-05 21:46:53	t	0101000020E61000007256444DF43152C08AC8B08A37DC4440
2130	47	2008-02-05 21:54:53	2008-02-05 21:56:53	f	0101000020E610000059350873BB3152C068E89FE062DB4440
2131	47	2008-02-05 21:57:43	2008-02-05 21:59:43	f	0101000020E610000012AB3FC2303252C05B0D897B2CDB4440
2132	47	2008-02-05 22:07:43	2008-02-05 22:09:43	f	0101000020E6100000C0F2203D453252C03A234A7B83DD4440
2133	47	2008-02-05 22:16:48	2008-02-05 22:18:48	f	0101000020E61000003F3BE0BA623852C06C7D91D096DD4440
2134	47	2008-02-05 22:17:47	2008-02-05 22:19:47	t	0101000020E61000006AC2F693313852C0C8B5A1629CDD4440
2135	47	2008-02-05 22:27:02	2008-02-05 22:29:02	f	0101000020E6100000182CD505BC3A52C0E7A90EB919DC4440
2136	47	2008-02-05 22:37:02	2008-02-05 22:39:02	t	0101000020E6100000BA4F8E02443952C018EC866D8BDC4440
2137	47	2008-02-05 22:39:38	2008-02-05 22:41:38	t	0101000020E6100000EC353D28283952C0EF0390DAC4DB4440
2138	47	2008-02-05 22:47:02	2008-02-05 22:49:02	f	0101000020E6100000729010E50B3A52C0070DFD135CDA4440
2139	47	2008-02-05 22:49:38	2008-02-05 22:51:38	f	0101000020E6100000988C63247B3A52C08DD13AAA9ADA4440
2140	47	2008-02-05 22:59:38	2008-02-05 23:01:38	f	0101000020E61000009ED32CD0EE3852C0B97020240BDE4440
2141	47	2008-02-05 23:02:41	2008-02-05 23:04:41	f	0101000020E61000007B4FE5B4A73852C0003ACC9717DE4440
2142	47	2008-02-05 23:12:41	2008-02-05 23:14:41	t	0101000020E6100000A6BE2CEDD43652C078280AF489DE4440
2143	47	2008-02-05 23:17:30	2008-02-05 23:19:30	f	0101000020E6100000C639EAE8B83652C00057B26323DE4440
2144	47	2008-02-05 23:27:30	2008-02-05 23:29:30	t	0101000020E6100000D7FB8D76DC3252C06CB2463D44E14440
2145	47	2008-02-05 23:29:02	2008-02-05 23:31:02	f	0101000020E6100000BE361B2B313352C0105D50DF32E14440
2146	47	2008-02-05 23:37:30	2008-02-05 23:39:30	f	0101000020E6100000B45A608F893252C01E38674469E14440
2147	47	2008-02-05 23:39:02	2008-02-05 23:41:02	f	0101000020E61000001FDD088B8A3252C0083D9B559FE14440
2148	47	2008-02-05 23:49:02	2008-02-05 23:51:02	t	0101000020E6100000F05696E82C3352C0DFFDF15EB5DC4440
2149	47	2008-02-05 23:56:54	2008-02-05 23:58:54	f	0101000020E610000063F4DC42573452C08C4AEA0434DB4440
2150	47	2008-02-06 00:03:52	2008-02-06 00:05:52	t	0101000020E61000009566F3380C3252C0072AE3DF67DA4440
2151	47	2008-02-06 00:13:52	2008-02-06 00:15:52	f	0101000020E61000006C0F7BA1803552C0787FBC57ADDA4440
2152	47	2008-02-06 00:23:52	2008-02-06 00:25:52	f	0101000020E61000005AA48977803552C031D3F6AFACDA4440
2153	47	2008-02-06 00:33:52	2008-02-06 00:35:52	t	0101000020E61000007D7A6CCB803552C0787FBC57ADDA4440
2154	47	2008-02-06 00:43:52	2008-02-06 00:45:52	f	0101000020E61000007D7A6CCB803552C09B559FABADDA4440
2155	47	2008-02-06 00:53:52	2008-02-06 00:55:52	f	0101000020E61000007D7A6CCB803552C09B559FABADDA4440
2156	47	2008-02-06 01:03:52	2008-02-06 01:05:52	t	0101000020E61000008FE55DF5803552C09B559FABADDA4440
2157	47	2008-02-06 01:13:51	2008-02-06 01:15:51	t	0101000020E61000008FE55DF5803552C0BF2B82FFADDA4440
2158	47	2008-02-06 01:23:51	2008-02-06 01:25:51	f	0101000020E6100000A1504F1F813552C0BF2B82FFADDA4440
2159	47	2008-02-06 01:33:51	2008-02-06 01:35:51	t	0101000020E6100000A1504F1F813552C0BF2B82FFADDA4440
2160	47	2008-02-06 01:43:51	2008-02-06 01:45:51	f	0101000020E6100000D691239D813552C0F14BFDBCA9DA4440
2161	47	2008-02-06 02:03:51	2008-02-06 02:05:51	t	0101000020E61000002563B5F97F3552C0715AF0A2AFDA4440
2162	47	2008-02-06 02:13:51	2008-02-06 02:15:51	t	0101000020E61000005AA48977803552C02AAE2AFBAEDA4440
2163	47	2008-02-06 02:23:51	2008-02-06 02:25:51	f	0101000020E61000005AA48977803552C02AAE2AFBAEDA4440
2164	47	2008-02-06 02:43:51	2008-02-06 02:45:51	t	0101000020E61000006C0F7BA1803552C0E3016553AEDA4440
2165	47	2008-02-06 02:53:51	2008-02-06 02:55:51	t	0101000020E6100000D691239D813552C04D840D4FAFDA4440
2166	48	2008-02-04 10:42:50	2008-02-04 10:44:50	f	0101000020E610000095BDA59C2F3452C03D44A33B88DF4440
2167	48	2008-02-04 10:47:50	2008-02-04 10:49:50	f	0101000020E61000004E11E0F42E3452C0CC9C2E8B89DF4440
2168	48	2008-02-04 10:52:50	2008-02-04 10:54:50	f	0101000020E61000006B882AFC193452C05A4C6C3EAEDF4440
2169	48	2008-02-04 10:57:50	2008-02-04 10:59:50	f	0101000020E6100000590053060E3452C0623255302ADF4440
2170	48	2008-02-04 11:02:50	2008-02-04 11:04:50	t	0101000020E6100000236DE34F543452C00F10CCD1E3DD4440
2171	48	2008-02-04 11:12:50	2008-02-04 11:14:50	f	0101000020E6100000D527B9C3263452C0058BC3995FDF4440
2172	48	2008-02-04 11:25:54	2008-02-04 11:27:54	f	0101000020E61000008E0C7217613252C026E4839ECDE04440
2173	48	2008-02-04 11:27:10	2008-02-04 11:29:10	t	0101000020E6100000233317B83C3252C05F46B1DCD2E04440
2174	48	2008-02-04 11:31:55	2008-02-04 11:33:55	t	0101000020E6100000E37668588C3252C02506819543E14440
2175	48	2008-02-04 11:36:55	2008-02-04 11:38:55	f	0101000020E61000000D3D62F4DC3252C0752497FF90E04440
2176	49	2008-02-05 14:05:34	2008-02-05 14:07:34	f	0101000020E6100000B98E71C5C53352C04CA60A4625CF4440
2177	49	2008-02-05 14:08:51	2008-02-05 14:10:51	t	0101000020E610000012AB3FC2303452C0F758FAD005CF4440
2178	49	2008-02-05 14:10:36	2008-02-05 14:12:36	t	0101000020E6100000C3D9AD65323452C0CEC29E76F8CD4440
2179	49	2008-02-05 14:15:37	2008-02-05 14:17:37	t	0101000020E6100000D0D6C1C1DE3452C06D1CB1169FCC4440
2180	49	2008-02-05 14:18:54	2008-02-05 14:20:54	f	0101000020E6100000570A815CE23452C0CA37DBDC98CC4440
2181	49	2008-02-05 14:20:39	2008-02-05 14:22:39	t	0101000020E610000082919735B13452C09FE5797077CC4440
2182	49	2008-02-05 14:25:41	2008-02-05 14:27:41	t	0101000020E6100000A020B1DD3D3452C0AC048BC399CD4440
2183	49	2008-02-05 14:28:57	2008-02-05 14:30:57	f	0101000020E610000035812216313452C05B7C0A80F1CE4440
2184	49	2008-02-05 14:30:42	2008-02-05 14:32:42	t	0101000020E610000012AB3FC2303452C0DBC4C9FD0ECF4440
2185	49	2008-02-05 14:35:44	2008-02-05 14:37:44	t	0101000020E610000019B325AB223452C0740CC85EEFD04440
2186	49	2008-02-05 15:00:35	2008-02-05 15:02:35	t	0101000020E610000031BC92E4B93652C0F246E6913FCE4440
2187	49	2008-02-05 15:01:11	2008-02-05 15:03:11	f	0101000020E6100000D3DF4BE1413752C0876D8B321BCE4440
2188	49	2008-02-05 15:05:37	2008-02-05 15:07:37	t	0101000020E610000074124A5F083952C0C74B378941D24440
2189	49	2008-02-05 15:11:15	2008-02-05 15:13:15	f	0101000020E6100000058C2E6F0E3952C0E8DEC325C7D74440
2190	49	2008-02-05 15:15:40	2008-02-05 15:17:40	t	0101000020E61000004F0CC9C9C43952C0C4EBFA05BBD74440
2191	49	2008-02-05 15:20:42	2008-02-05 15:22:42	f	0101000020E6100000E853C72AA53952C055185B0872DA4440
2192	49	2008-02-05 15:21:18	2008-02-05 15:23:18	f	0101000020E6100000373D2828453952C0079964E42CDA4440
2193	49	2008-02-05 15:25:44	2008-02-05 15:27:44	t	0101000020E6100000AA143B1A873652C0087767EDB6D94440
2194	49	2008-02-05 15:30:45	2008-02-05 15:32:45	f	0101000020E6100000EE43DE72F53552C03AAFB14B54D94440
2195	49	2008-02-05 15:31:21	2008-02-05 15:33:21	f	0101000020E61000004E8061F9F33552C04209336DFFD84440
2196	49	2008-02-05 15:35:47	2008-02-05 15:37:47	t	0101000020E610000040AA61BF273652C09947FE60E0D74440
2197	49	2008-02-05 15:40:49	2008-02-05 15:42:49	f	0101000020E6100000128E59F6243652C0E813799274D74440
2198	49	2008-02-05 15:41:25	2008-02-05 15:43:25	t	0101000020E6100000B976A224243652C02FA3586E69D74440
2199	49	2008-02-05 15:45:50	2008-02-05 15:47:50	f	0101000020E6100000521553E9273652C05F7B664980D44440
2200	49	2008-02-05 15:50:52	2008-02-05 15:52:52	f	0101000020E61000004BCE893DB43552C018265305A3D04440
2201	49	2008-02-05 15:51:28	2008-02-05 15:53:28	f	0101000020E61000005EFA97A4323552C0664E97C5C4D04440
2202	49	2008-02-05 15:55:54	2008-02-05 15:57:54	f	0101000020E61000004E8578245E3452C066DAFE9595D04440
2203	49	2008-02-05 16:00:55	2008-02-05 16:02:55	t	0101000020E610000009AD872F133352C0F437A11001D14440
2204	49	2008-02-05 16:06:23	2008-02-05 16:08:23	f	0101000020E6100000C734D3BD4E3252C03CDA38622DD04440
2205	49	2008-02-05 16:06:23	2008-02-05 16:08:23	t	0101000020E6100000C734D3BD4E3252C03CDA38622DD04440
2206	49	2008-02-05 16:10:58	2008-02-05 16:12:58	f	0101000020E61000003226FDBD143252C035B56CAD2FD04440
2207	49	2008-02-05 16:16:00	2008-02-05 16:18:00	f	0101000020E610000034349E08E23052C0022B8716D9D04440
2208	49	2008-02-05 16:21:02	2008-02-05 16:23:02	t	0101000020E610000099BC0166BE2F52C08221AB5B3DD14440
2209	49	2008-02-05 16:21:02	2008-02-05 16:23:02	t	0101000020E610000099BC0166BE2F52C08221AB5B3DD14440
2210	49	2008-02-05 16:21:38	2008-02-05 16:23:38	t	0101000020E610000028158DB5BF2F52C033C4B12E6ED14440
2211	49	2008-02-05 16:26:03	2008-02-05 16:28:03	f	0101000020E610000032CF4A5AF12F52C024D1CB2896D14440
2212	49	2008-02-05 16:31:05	2008-02-05 16:33:05	t	0101000020E6100000278E3C10593052C0247F30F0DCD14440
2213	49	2008-02-05 16:31:41	2008-02-05 16:33:41	t	0101000020E6100000278E3C10593052C0247F30F0DCD14440
2214	49	2008-02-05 16:36:07	2008-02-05 16:38:07	t	0101000020E6100000CBBF9657AE2F52C00DE02D90A0D24440
2215	49	2008-02-05 16:41:08	2008-02-05 16:43:08	f	0101000020E61000000F9D9E77632F52C0BB7EC16ED8D44440
2216	49	2008-02-05 16:41:44	2008-02-05 16:43:44	t	0101000020E6100000C8F0D8CF622F52C048E17A14AED54440
2217	49	2008-02-05 16:46:10	2008-02-05 16:48:10	f	0101000020E61000004839984D802F52C0C347C49448D84440
2218	49	2008-02-05 16:51:12	2008-02-05 16:53:12	f	0101000020E610000056664AEB6F2F52C0BBB88D06F0D84440
2219	49	2008-02-05 16:51:48	2008-02-05 16:53:48	f	0101000020E610000056664AEB6F2F52C0BBB88D06F0D84440
2220	49	2008-02-05 17:01:15	2008-02-05 17:03:15	f	0101000020E610000073FA7ABE662D52C0032670EB6EE04440
2221	49	2008-02-05 17:01:51	2008-02-05 17:03:51	f	0101000020E6100000CD0C1B65FD2C52C06553AEF02EE14440
2222	49	2008-02-05 17:06:17	2008-02-05 17:08:17	t	0101000020E610000093CCEA1D6E2952C09E7B0F971CE54440
2223	49	2008-02-05 17:11:18	2008-02-05 17:13:18	t	0101000020E6100000A9AAD0402C2752C03B014D840DE94440
2224	49	2008-02-05 17:11:54	2008-02-05 17:13:54	t	0101000020E610000081ED60C43E2752C0E4310395F1E94440
2225	49	2008-02-05 17:16:20	2008-02-05 17:18:20	f	0101000020E6100000D700A5A1462752C0D313967840EB4440
2226	49	2008-02-05 17:21:22	2008-02-05 17:23:22	f	0101000020E6100000479561DC0D2852C046CEC29E76E64440
2227	49	2008-02-05 17:26:23	2008-02-05 17:28:23	f	0101000020E610000063687572862A52C0DF32A7CB62E44440
2228	49	2008-02-05 17:31:25	2008-02-05 17:33:25	f	0101000020E6100000274F594DD72D52C0598638D6C5DF4440
2229	49	2008-02-05 17:32:00	2008-02-05 17:34:00	f	0101000020E6100000003B376DC62D52C03D2CD49AE6DF4440
2230	49	2008-02-05 17:36:26	2008-02-05 17:38:26	f	0101000020E6100000610322C4952D52C05743E21E4BDD4440
2231	49	2008-02-05 17:41:27	2008-02-05 17:43:27	t	0101000020E6100000EE60C43E012E52C092054CE0D6DB4440
2232	49	2008-02-05 17:42:03	2008-02-05 17:44:03	t	0101000020E6100000D90E46EC132E52C0B6BE4868CBDB4440
2233	49	2008-02-05 17:46:29	2008-02-05 17:48:29	f	0101000020E6100000AC915D69192F52C01444DD0720DB4440
2234	49	2008-02-05 17:51:31	2008-02-05 17:53:31	f	0101000020E61000000F80B8AB572F52C00686AC6EF5DA4440
2235	49	2008-02-05 17:56:32	2008-02-05 17:58:32	t	0101000020E61000004ED7135D173052C02BC1E270E6D94440
2236	49	2008-02-05 18:01:34	2008-02-05 18:03:34	f	0101000020E6100000A3EA573A1F3052C08B71FE2614D84440
2237	49	2008-02-05 18:02:10	2008-02-05 18:04:10	f	0101000020E6100000B55549641F3052C07D0569C6A2D74440
2238	49	2008-02-05 18:06:36	2008-02-05 18:08:36	t	0101000020E61000007F8D2441B83052C0CD751A69A9D64440
2239	49	2008-02-05 18:12:13	2008-02-05 18:14:13	f	0101000020E610000057444DF4F93052C04F232D95B7D54440
2240	49	2008-02-05 18:16:39	2008-02-05 18:18:39	f	0101000020E610000034DDEBA4BE3252C016A4198BA6D54440
2241	50	2008-02-03 15:01:15	2008-02-03 15:03:15	f	0101000020E6100000227711A6283752C08B71FE2614C84440
2242	50	2008-02-03 15:01:18	2008-02-03 15:03:18	t	0101000020E610000009E753C72A3752C03CA06CCA15C84440
2243	50	2008-02-03 15:01:48	2008-02-03 15:03:48	f	0101000020E6100000D73A71395E3752C0C4D32B6519C84440
2244	50	2008-02-03 15:02:14	2008-02-03 15:04:14	f	0101000020E6100000817EDFBF793752C03CA06CCA15C84440
2245	50	2008-02-03 15:02:22	2008-02-03 15:04:22	t	0101000020E6100000CC4BFE277F3752C00B80F10C1AC84440
2246	50	2008-02-03 15:02:25	2008-02-03 15:04:25	t	0101000020E6100000733447567E3752C0045B25581CC84440
2247	50	2008-02-03 15:03:23	2008-02-03 15:05:23	t	0101000020E6100000F35A09DD253752C03CC269C18BC84440
2248	50	2008-02-03 15:03:26	2008-02-03 15:05:26	t	0101000020E610000030C1A90F243752C011C7BAB88DC84440
2249	50	2008-02-03 15:03:31	2008-02-03 15:05:31	t	0101000020E610000090FD2C96223752C00AA2EE0390C84440
2250	50	2008-02-03 15:05:24	2008-02-03 15:07:24	f	0101000020E610000082CB63CDC83652C009C4EBFA05C94440
2251	51	2008-02-02 19:32:01	2008-02-02 19:34:01	t	0101000020E61000003EB48F15FC2652C0BFD4CF9B8AEA4440
2252	51	2008-02-02 19:32:02	2008-02-02 19:34:02	f	0101000020E61000003EB48F15FC2652C0BFD4CF9B8AEA4440
2253	51	2008-02-02 19:32:04	2008-02-02 19:34:04	t	0101000020E61000003EB48F15FC2652C0BFD4CF9B8AEA4440
2254	51	2008-02-02 19:32:05	2008-02-02 19:34:05	t	0101000020E61000002D499EEBFB2652C09CFEEC478AEA4440
2255	51	2008-02-02 19:32:06	2008-02-02 19:34:06	f	0101000020E61000002D499EEBFB2652C09CFEEC478AEA4440
2256	51	2008-02-02 19:32:08	2008-02-02 19:34:08	f	0101000020E61000001BDEACC1FB2652C09CFEEC478AEA4440
2257	51	2008-02-02 19:32:09	2008-02-02 19:34:09	t	0101000020E61000001BDEACC1FB2652C09CFEEC478AEA4440
2258	51	2008-02-02 19:32:10	2008-02-02 19:34:10	t	0101000020E61000001BDEACC1FB2652C09CFEEC478AEA4440
2259	51	2008-02-02 19:32:11	2008-02-02 19:34:11	t	0101000020E61000001BDEACC1FB2652C09CFEEC478AEA4440
2260	51	2008-02-02 19:32:13	2008-02-02 19:34:13	f	0101000020E61000002D499EEBFB2652C0555227A089EA4440
2261	51	2008-02-02 19:32:14	2008-02-02 19:34:14	f	0101000020E61000002D499EEBFB2652C0555227A089EA4440
2262	51	2008-02-02 19:32:23	2008-02-02 19:34:23	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2263	51	2008-02-02 19:32:25	2008-02-02 19:34:25	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2264	51	2008-02-02 19:32:27	2008-02-02 19:34:27	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2265	51	2008-02-02 19:32:28	2008-02-02 19:34:28	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2266	51	2008-02-02 19:32:29	2008-02-02 19:34:29	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2267	51	2008-02-02 19:32:30	2008-02-02 19:34:30	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2268	51	2008-02-02 19:32:31	2008-02-02 19:34:31	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2269	51	2008-02-02 19:32:33	2008-02-02 19:34:33	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2270	51	2008-02-02 19:32:35	2008-02-02 19:34:35	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2271	51	2008-02-02 19:32:36	2008-02-02 19:34:36	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2272	51	2008-02-02 19:32:37	2008-02-02 19:34:37	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2273	51	2008-02-02 19:32:39	2008-02-02 19:34:39	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2274	51	2008-02-02 19:32:40	2008-02-02 19:34:40	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2275	51	2008-02-02 19:32:41	2008-02-02 19:34:41	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2276	51	2008-02-02 19:32:43	2008-02-02 19:34:43	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2277	51	2008-02-02 19:32:44	2008-02-02 19:34:44	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2278	51	2008-02-02 19:32:45	2008-02-02 19:34:45	t	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2279	51	2008-02-02 19:32:47	2008-02-02 19:34:47	f	0101000020E61000003EB48F15FC2652C00DA661F888EA4440
2280	51	2008-02-02 19:34:22	2008-02-02 19:36:22	t	0101000020E61000002D499EEBFB2652C00DA661F888EA4440
2281	51	2008-02-02 19:34:22	2008-02-02 19:36:22	f	0101000020E61000002D499EEBFB2652C00DA661F888EA4440
2282	51	2008-02-02 19:34:37	2008-02-02 19:36:37	t	0101000020E6100000D431E719FB2652C00DA661F888EA4440
2283	51	2008-02-02 19:34:52	2008-02-02 19:36:52	f	0101000020E61000000973BB97FB2652C038A1100187EA4440
2284	51	2008-02-02 19:35:08	2008-02-02 19:37:08	t	0101000020E61000002D499EEBFB2652C0FF3EE3C281EA4440
2285	51	2008-02-02 19:35:20	2008-02-02 19:37:20	t	0101000020E6100000F724B039072752C071E6577380EA4440
2286	51	2008-02-02 19:35:27	2008-02-02 19:37:27	t	0101000020E6100000FB4509FA0B2752C0BFB7E9CF7EEA4440
2287	51	2008-02-02 19:35:29	2008-02-02 19:37:29	f	0101000020E610000065C8B1F50C2752C00664AF777FEA4440
2288	51	2008-02-02 19:35:31	2008-02-02 19:37:31	t	0101000020E6100000BEDF68C70D2752C071E6577380EA4440
2289	51	2008-02-02 19:35:32	2008-02-02 19:37:32	f	0101000020E6100000E2B54B1B0E2752C095BC3AC780EA4440
2290	51	2008-02-02 19:35:33	2008-02-02 19:37:33	t	0101000020E6100000058C2E6F0E2752C0B8921D1B81EA4440
2291	51	2008-02-02 19:35:34	2008-02-02 19:37:34	t	0101000020E61000003BCD02ED0E2752C0FF3EE3C281EA4440
2292	51	2008-02-02 19:35:35	2008-02-02 19:37:35	t	0101000020E61000004C38F4160F2752C06AC18BBE82EA4440
2293	51	2008-02-02 19:35:36	2008-02-02 19:37:36	t	0101000020E61000005EA3E5400F2752C0F819170E84EA4440
2294	51	2008-02-02 19:35:37	2008-02-02 19:37:37	f	0101000020E61000005EA3E5400F2752C0AA4885B185EA4440
2295	51	2008-02-02 19:35:38	2008-02-02 19:37:38	t	0101000020E61000005EA3E5400F2752C05C77F35487EA4440
2296	51	2008-02-02 19:35:40	2008-02-02 19:37:40	f	0101000020E61000008279C8940F2752C02A5778978BEA4440
2297	51	2008-02-02 19:35:41	2008-02-02 19:37:41	f	0101000020E6100000A54FABE80F2752C046088F368EEA4440
2298	51	2008-02-02 19:35:42	2008-02-02 19:37:42	t	0101000020E6100000C9258E3C102752C063B9A5D590EA4440
2299	51	2008-02-02 19:35:43	2008-02-02 19:37:43	f	0101000020E6100000ECFB7090102752C0A3409FC893EA4440
2300	51	2008-02-02 19:35:44	2008-02-02 19:37:44	t	0101000020E610000010D253E4102752C0E3C798BB96EA4440
2301	51	2008-02-02 19:35:45	2008-02-02 19:37:45	f	0101000020E610000034A83638112752C0234F92AE99EA4440
2302	51	2008-02-02 19:35:46	2008-02-02 19:37:46	t	0101000020E6100000577E198C112752C063D68BA19CEA4440
2303	51	2008-02-02 19:35:47	2008-02-02 19:37:47	f	0101000020E610000069E90AB6112752C07F87A2409FEA4440
2304	51	2008-02-02 19:35:48	2008-02-02 19:37:48	f	0101000020E61000008CBFED09122752C07862D68BA1EA4440
2305	51	2008-02-02 19:35:50	2008-02-02 19:37:50	t	0101000020E6100000B095D05D122752C08DEE2076A6EA4440
2306	51	2008-02-02 19:35:50	2008-02-02 19:37:50	t	0101000020E6100000B095D05D122752C08DEE2076A6EA4440
2307	51	2008-02-02 19:35:51	2008-02-02 19:37:51	f	0101000020E6100000C200C287122752C063F3716DA8EA4440
2308	51	2008-02-02 19:35:52	2008-02-02 19:37:52	t	0101000020E6100000C200C287122752C038F8C264AAEA4440
2309	51	2008-02-02 19:35:53	2008-02-02 19:37:53	f	0101000020E61000009E2ADF33122752C00DFD135CACEA4440
2310	51	2008-02-02 19:35:54	2008-02-02 19:37:54	f	0101000020E610000069E90AB6112752C0E3016553AEEA4440
2311	51	2008-02-02 19:35:55	2008-02-02 19:37:55	f	0101000020E610000010D253E4102752C0DBDC989EB0EA4440
2312	51	2008-02-02 19:35:57	2008-02-02 19:37:57	t	0101000020E61000005EA3E5400F2752C0AABC1DE1B4EA4440
2313	51	2008-02-02 19:35:58	2008-02-02 19:37:58	f	0101000020E6100000058C2E6F0E2752C07FC16ED8B6EA4440
2314	51	2008-02-02 19:36:00	2008-02-02 19:38:00	t	0101000020E610000065C8B1F50C2752C04DA1F31ABBEA4440
2315	51	2008-02-02 19:36:01	2008-02-02 19:38:01	f	0101000020E61000003087DD770C2752C06A520ABABDEA4440
2316	51	2008-02-02 19:36:02	2008-02-02 19:38:02	t	0101000020E61000000CB1FA230C2752C0622D3E05C0EA4440
2317	51	2008-02-02 19:36:03	2008-02-02 19:38:03	f	0101000020E6100000FB4509FA0B2752C07FDE54A4C2EA4440
2318	51	2008-02-02 19:36:04	2008-02-02 19:38:04	t	0101000020E61000000CB1FA230C2752C09B8F6B43C5EA4440
2319	51	2008-02-02 19:36:05	2008-02-02 19:38:05	t	0101000020E61000003087DD770C2752C0DB166536C8EA4440
2320	51	2008-02-02 19:36:06	2008-02-02 19:38:06	t	0101000020E610000042F2CEA10C2752C0F8C77BD5CAEA4440
2321	51	2008-02-02 19:36:13	2008-02-02 19:38:13	f	0101000020E6100000296211C30E2752C0386C5B94D9EA4440
2322	51	2008-02-02 19:36:16	2008-02-02 19:38:16	f	0101000020E610000045132862112752C0541D7233DCEA4440
2323	51	2008-02-02 19:36:18	2008-02-02 19:38:18	f	0101000020E61000001B187959132752C030478FDFDBEA4440
2324	51	2008-02-02 19:36:19	2008-02-02 19:38:19	f	0101000020E6100000859A2155142752C030478FDFDBEA4440
2325	51	2008-02-02 19:36:20	2008-02-02 19:38:20	t	0101000020E6100000DEB1D826152752C00D71AC8BDBEA4440
2326	52	2008-02-08 08:45:22	2008-02-08 08:47:22	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2327	52	2008-02-08 08:45:28	2008-02-08 08:47:28	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2328	52	2008-02-08 08:45:32	2008-02-08 08:47:32	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2329	52	2008-02-08 08:45:38	2008-02-08 08:47:38	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2330	52	2008-02-08 08:45:42	2008-02-08 08:47:42	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2331	52	2008-02-08 08:45:48	2008-02-08 08:47:48	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2332	52	2008-02-08 08:45:52	2008-02-08 08:47:52	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2333	52	2008-02-08 08:45:58	2008-02-08 08:47:58	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2334	52	2008-02-08 08:46:02	2008-02-08 08:48:02	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2335	52	2008-02-08 08:46:08	2008-02-08 08:48:08	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2336	52	2008-02-08 08:46:12	2008-02-08 08:48:12	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2337	52	2008-02-08 08:46:18	2008-02-08 08:48:18	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2338	52	2008-02-08 08:46:22	2008-02-08 08:48:22	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2339	52	2008-02-08 08:46:28	2008-02-08 08:48:28	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2340	52	2008-02-08 08:46:32	2008-02-08 08:48:32	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2341	52	2008-02-08 08:46:38	2008-02-08 08:48:38	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2342	52	2008-02-08 08:46:42	2008-02-08 08:48:42	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2343	52	2008-02-08 08:46:48	2008-02-08 08:48:48	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2344	52	2008-02-08 08:46:52	2008-02-08 08:48:52	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2345	52	2008-02-08 08:46:58	2008-02-08 08:48:58	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2346	52	2008-02-08 08:47:02	2008-02-08 08:49:02	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2347	52	2008-02-08 08:47:08	2008-02-08 08:49:08	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2348	52	2008-02-08 08:47:12	2008-02-08 08:49:12	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2349	52	2008-02-08 08:47:18	2008-02-08 08:49:18	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2350	52	2008-02-08 08:47:22	2008-02-08 08:49:22	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2351	52	2008-02-08 08:47:28	2008-02-08 08:49:28	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2352	52	2008-02-08 08:47:32	2008-02-08 08:49:32	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2353	52	2008-02-08 08:47:32	2008-02-08 08:49:32	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2354	52	2008-02-08 08:47:38	2008-02-08 08:49:38	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2355	52	2008-02-08 08:47:38	2008-02-08 08:49:38	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2356	52	2008-02-08 08:47:42	2008-02-08 08:49:42	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2357	52	2008-02-08 08:47:48	2008-02-08 08:49:48	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2358	52	2008-02-08 08:47:52	2008-02-08 08:49:52	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2359	52	2008-02-08 08:47:58	2008-02-08 08:49:58	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2360	52	2008-02-08 08:48:02	2008-02-08 08:50:02	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2361	52	2008-02-08 08:48:08	2008-02-08 08:50:08	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2362	52	2008-02-08 08:48:12	2008-02-08 08:50:12	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2363	52	2008-02-08 08:48:18	2008-02-08 08:50:18	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2364	52	2008-02-08 08:48:22	2008-02-08 08:50:22	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2365	52	2008-02-08 08:48:28	2008-02-08 08:50:28	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2366	52	2008-02-08 08:48:32	2008-02-08 08:50:32	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2367	52	2008-02-08 08:48:38	2008-02-08 08:50:38	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2368	52	2008-02-08 08:48:42	2008-02-08 08:50:42	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2369	52	2008-02-08 08:48:48	2008-02-08 08:50:48	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2370	52	2008-02-08 08:48:52	2008-02-08 08:50:52	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2371	52	2008-02-08 08:48:58	2008-02-08 08:50:58	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2372	52	2008-02-08 08:49:02	2008-02-08 08:51:02	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2373	52	2008-02-08 08:49:08	2008-02-08 08:51:08	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2374	52	2008-02-08 08:49:12	2008-02-08 08:51:12	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2375	52	2008-02-08 08:49:18	2008-02-08 08:51:18	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2376	52	2008-02-08 08:49:22	2008-02-08 08:51:22	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2377	52	2008-02-08 08:49:28	2008-02-08 08:51:28	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2378	52	2008-02-08 08:49:32	2008-02-08 08:51:32	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2379	52	2008-02-08 08:49:38	2008-02-08 08:51:38	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2380	52	2008-02-08 08:49:42	2008-02-08 08:51:42	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2381	52	2008-02-08 08:49:48	2008-02-08 08:51:48	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2382	52	2008-02-08 08:49:52	2008-02-08 08:51:52	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2383	52	2008-02-08 08:49:58	2008-02-08 08:51:58	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2384	52	2008-02-08 08:50:02	2008-02-08 08:52:02	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2385	52	2008-02-08 08:50:08	2008-02-08 08:52:08	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2386	52	2008-02-08 08:50:12	2008-02-08 08:52:12	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2387	52	2008-02-08 08:50:18	2008-02-08 08:52:18	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2388	52	2008-02-08 08:50:22	2008-02-08 08:52:22	f	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2389	52	2008-02-08 08:50:28	2008-02-08 08:52:28	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2390	52	2008-02-08 08:50:32	2008-02-08 08:52:32	t	0101000020E61000007BE063B0E24852C0D8F50B76C3BC4440
2391	53	2008-02-05 22:26:34	2008-02-05 22:28:34	t	0101000020E6100000D2E97937163852C07C7E18213CD44440
2392	53	2008-02-05 22:31:25	2008-02-05 22:33:25	f	0101000020E61000006AC70DBF9B3652C0C993A46B26D14440
2393	53	2008-02-05 22:31:35	2008-02-05 22:33:35	t	0101000020E6100000DF8FDB2F9F3652C0BBB88D06F0D04440
2394	53	2008-02-05 22:36:37	2008-02-05 22:38:37	f	0101000020E6100000AEC1FBAA5C3252C0D07EA4880CD14440
2395	53	2008-02-05 22:41:29	2008-02-05 22:43:29	t	0101000020E61000000FBA84436F2F52C01E166A4DF3D04440
2396	53	2008-02-05 22:41:38	2008-02-05 22:43:38	f	0101000020E610000017C26A2C612F52C089981249F4D04440
2397	53	2008-02-05 22:46:40	2008-02-05 22:48:40	t	0101000020E610000027FDBD141E2C52C074D2FBC6D7D04440
2398	53	2008-02-05 22:51:33	2008-02-05 22:53:33	t	0101000020E610000033C51C041D2B52C0944DB9C2BBCE4440
2399	53	2008-02-05 22:51:42	2008-02-05 22:53:42	f	0101000020E610000037ACA92C0A2B52C0AA9F3715A9CE4440
2400	53	2008-02-05 22:56:44	2008-02-05 22:58:44	t	0101000020E610000009CA6DFB1E2952C08FDFDBF467CD4440
2401	54	2008-02-02 19:18:06	2008-02-02 19:20:06	f	0101000020E6100000516C054D4B2C52C006A3923A01E34440
2402	54	2008-02-02 19:23:06	2008-02-02 19:25:06	f	0101000020E6100000400114234B2C52C006A3923A01E34440
2403	54	2008-02-02 19:28:05	2008-02-02 19:30:05	t	0101000020E61000005EDDB1D8262D52C04243FF0417E14440
2404	54	2008-02-02 19:33:06	2008-02-02 19:35:06	f	0101000020E6100000FAA1D288992D52C0E96514CB2DDF4440
2405	54	2008-02-02 19:38:06	2008-02-02 19:40:06	f	0101000020E61000005C3E92921E2E52C02B4D4A41B7DD4440
2406	54	2008-02-02 19:38:06	2008-02-02 19:40:06	f	0101000020E61000005C3E92921E2E52C02B4D4A41B7DD4440
2407	54	2008-02-02 19:43:06	2008-02-02 19:45:06	f	0101000020E61000000D772E8CF42E52C0FC57569A94DC4440
2408	54	2008-02-02 19:48:06	2008-02-02 19:50:06	t	0101000020E610000017BD5301F72E52C03E963E7441DB4440
2409	54	2008-02-02 19:53:06	2008-02-02 19:55:06	t	0101000020E61000001FFAEE56962E52C063EE5A423EDA4440
2410	54	2008-02-02 19:58:06	2008-02-02 20:00:06	f	0101000020E6100000658EE55DF52E52C08CA19C6857DB4440
2411	54	2008-02-02 20:03:06	2008-02-02 20:05:06	f	0101000020E6100000E27B7F83F62E52C0B7627FD93DDB4440
2412	54	2008-02-02 20:08:06	2008-02-02 20:10:06	f	0101000020E61000003BC8EBC1A42E52C0DE3CD52137D94440
2413	54	2008-02-02 20:13:06	2008-02-02 20:15:06	f	0101000020E6100000CE76853E582E52C0D4BCE3141DD74440
2414	54	2008-02-02 20:18:06	2008-02-02 20:20:06	f	0101000020E61000008A25E5EE732E52C0CEC29E76F8D54440
2415	54	2008-02-02 20:23:05	2008-02-02 20:25:05	f	0101000020E6100000709F55664A2F52C023BE13B35ED64440
2416	54	2008-02-02 20:28:05	2008-02-02 20:30:05	f	0101000020E610000023A7AFE76B3052C0F8A57EDE54D64440
2417	54	2008-02-02 20:33:05	2008-02-02 20:35:05	f	0101000020E61000002810768A553152C072F90FE9B7D54440
2418	54	2008-02-02 20:38:06	2008-02-02 20:40:06	f	0101000020E6100000CF37A27BD63152C03A97E2AAB2D54440
2419	54	2008-02-02 20:43:04	2008-02-02 20:45:04	t	0101000020E61000005501F73C7F3252C039EE940ED6D54440
2420	54	2008-02-02 20:48:05	2008-02-02 20:50:05	f	0101000020E6100000AF0E80B8AB3152C0548CF337A1D64440
2421	54	2008-02-02 20:53:05	2008-02-02 20:55:05	t	0101000020E610000010EF39B01C3152C0AFD3484BE5D74440
2422	54	2008-02-02 20:58:05	2008-02-02 21:00:05	t	0101000020E61000002194F771343152C01D774A07EBD94440
2423	54	2008-02-02 21:03:05	2008-02-02 21:05:05	t	0101000020E610000088342A70B23152C08E588B4F01DA4440
2424	54	2008-02-02 21:08:05	2008-02-02 21:10:05	f	0101000020E6100000937538BA4A3152C04F92AE997CD94440
2425	54	2008-02-02 21:13:05	2008-02-02 21:15:05	f	0101000020E610000065C8B1F50C3152C0F41ABB44F5D84440
2426	54	2008-02-02 21:18:05	2008-02-02 21:20:05	f	0101000020E6100000B0B2B6291E3152C0546F0D6C95D64440
2427	54	2008-02-02 21:23:05	2008-02-02 21:25:05	t	0101000020E610000048567E198C3152C09DF4BEF1B5D54440
2428	54	2008-02-02 21:33:05	2008-02-02 21:35:05	f	0101000020E6100000A3EA573A1F3252C09DD7D825AAD54440
2429	54	2008-02-02 21:38:04	2008-02-02 21:40:04	f	0101000020E61000007FFCA5457D3252C04772F90FE9D54440
2430	54	2008-02-02 21:43:05	2008-02-02 21:45:05	t	0101000020E6100000C2189128B43252C0B58993FB1DD84440
2431	54	2008-02-02 21:48:05	2008-02-02 21:50:05	t	0101000020E61000001B6A1492CC3252C0AA4885B185DA4440
2432	54	2008-02-02 21:53:05	2008-02-02 21:55:05	f	0101000020E6100000B0045262D73252C026C79DD2C1DC4440
2433	54	2008-02-02 21:58:05	2008-02-02 22:00:05	t	0101000020E6100000373811FDDA3252C07E00529B38DF4440
2434	54	2008-02-02 22:03:04	2008-02-02 22:05:04	t	0101000020E61000001041D5E8D53252C024F3C81F0CE24440
2435	54	2008-02-02 22:03:04	2008-02-02 22:05:04	t	0101000020E61000001041D5E8D53252C024F3C81F0CE24440
2436	54	2008-02-02 22:08:05	2008-02-02 22:10:05	f	0101000020E610000002F73C7FDA3252C0DEAB5626FCE04440
2437	54	2008-02-02 22:13:05	2008-02-02 22:15:05	t	0101000020E61000007CD6355A0E3452C06F4C4F58E2DF4440
2438	54	2008-02-02 22:18:05	2008-02-02 22:20:05	t	0101000020E61000003C71395E813452C04A41B79734E04440
2439	54	2008-02-02 22:43:20	2008-02-02 22:45:20	t	0101000020E610000058D0B4C4CA3252C0293FA9F6E9DA4440
2440	54	2008-02-02 22:48:04	2008-02-02 22:50:04	f	0101000020E6100000AD3AAB05F63252C0CBBE2B82FFDB4440
2441	54	2008-02-02 22:53:04	2008-02-02 22:55:04	t	0101000020E6100000A9FC6B79E53052C0C6FEB27BF2DA4440
2442	54	2008-02-02 22:58:05	2008-02-02 23:00:05	f	0101000020E61000009EF529C7642F52C09D8026C286D94440
2443	54	2008-02-02 23:03:05	2008-02-02 23:05:05	t	0101000020E61000003D32569BFF2D52C05053CBD6FAD84440
2444	54	2008-02-02 23:08:04	2008-02-02 23:10:04	t	0101000020E61000001098874CF92C52C0ACC5A70018D94440
2445	54	2008-02-02 23:13:05	2008-02-02 23:15:05	t	0101000020E6100000F64BC45BE72D52C042EC4CA1F3D84440
2446	54	2008-02-02 23:18:05	2008-02-02 23:20:05	f	0101000020E61000003BB01C21032F52C075CDE49B6DD84440
2447	54	2008-02-02 23:23:05	2008-02-02 23:25:05	t	0101000020E6100000E0BF7971E22F52C0EFACDD76A1D74440
2448	54	2008-02-02 23:28:05	2008-02-02 23:30:05	t	0101000020E610000047EC1340313052C0FC1873D712D84440
2449	54	2008-02-02 23:33:05	2008-02-02 23:35:05	f	0101000020E610000048E2E5E95C2F52C08ECC237F30DA4440
2450	54	2008-02-02 23:38:05	2008-02-02 23:40:05	t	0101000020E61000003182C64CA22E52C084640113B8DB4440
2451	54	2008-02-02 23:43:04	2008-02-02 23:45:04	f	0101000020E61000005BF10D85CF2E52C0950ED6FF39DE4440
2452	54	2008-02-02 23:48:05	2008-02-02 23:50:05	t	0101000020E61000007B1A3048FA2E52C030478FDFDBDE4440
2453	54	2008-02-02 23:53:04	2008-02-02 23:55:04	f	0101000020E610000095F77134472E52C0D4F19881CADE4440
2454	54	2008-02-02 23:58:05	2008-02-03 00:00:05	t	0101000020E61000004C033FAA612F52C0A04FE449D2DB4440
2455	54	2008-02-03 00:03:05	2008-02-03 00:05:05	t	0101000020E61000009D4CDC2A882F52C0E12879758EDB4440
2456	54	2008-02-03 00:08:04	2008-02-03 00:10:04	f	0101000020E61000004DA7751BD42E52C02BDEC83CF2DD4440
2457	54	2008-02-03 00:13:05	2008-02-03 00:15:05	t	0101000020E610000080315BB22A2E52C0126BF12900E04440
2458	54	2008-02-03 00:13:18	2008-02-03 00:15:18	t	0101000020E610000032EC3026FD2954C0B4EA73B515EF3A40
2459	54	2008-02-03 00:18:05	2008-02-03 00:20:05	t	0101000020E61000008D852172FA2E52C0064CE0D6DDDE4440
2460	54	2008-02-03 00:23:05	2008-02-03 00:25:05	f	0101000020E6100000D8D9907F662E52C0E8FBA9F1D2DF4440
2461	54	2008-02-03 00:28:05	2008-02-03 00:30:05	f	0101000020E6100000039B73F04C2E52C0179F02603CE14440
2462	54	2008-02-03 00:33:04	2008-02-03 00:35:04	t	0101000020E61000004AF59D5F942E52C085251E5036DF4440
2463	54	2008-02-03 00:38:04	2008-02-03 00:40:04	t	0101000020E61000006689CE328B2E52C041D47D0052DD4440
2464	54	2008-02-03 00:43:04	2008-02-03 00:45:04	t	0101000020E6100000D5B32094F72D52C01F4B1FBAA0D84440
2465	54	2008-02-03 00:53:04	2008-02-03 00:55:04	t	0101000020E6100000B9AB5791D12F52C084BBB376DBD74440
2466	55	2008-02-06 14:36:02	2008-02-06 14:38:02	f	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2467	55	2008-02-06 14:41:02	2008-02-06 14:43:02	f	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2468	55	2008-02-06 14:53:03	2008-02-06 14:55:03	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2469	55	2008-02-06 14:58:04	2008-02-06 15:00:04	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2470	55	2008-02-06 15:04:33	2008-02-06 15:06:33	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2471	55	2008-02-06 15:14:34	2008-02-06 15:16:34	f	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2472	55	2008-02-06 15:40:03	2008-02-06 15:42:03	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2473	55	2008-02-06 15:45:04	2008-02-06 15:47:04	f	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2474	55	2008-02-06 16:00:03	2008-02-06 16:02:03	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2475	55	2008-02-06 16:06:33	2008-02-06 16:08:33	t	0101000020E61000000F1137A7922B52C0DDB5847CD0C14440
2476	56	2008-02-04 23:04:36	2008-02-04 23:06:36	t	0101000020E6100000E46C3A02B83552C080828B1535F24440
2477	56	2008-02-05 09:50:55	2008-02-05 09:52:55	f	0101000020E6100000200DA7CCCD3552C0D55B035B25F24440
2478	56	2008-02-05 09:55:58	2008-02-05 09:57:58	f	0101000020E6100000D76F26A60B3752C08E7A884677F24440
2479	56	2008-02-05 10:00:00	2008-02-05 10:02:00	f	0101000020E61000006E8C9DF0123852C0653BDF4F8DF14440
2480	56	2008-02-05 10:01:40	2008-02-05 10:03:40	t	0101000020E61000003911FDDAFA3752C04BEA043411F04440
2481	56	2008-02-05 10:06:40	2008-02-05 10:08:40	t	0101000020E610000088C09140833752C01895D40968EC4440
2482	56	2008-02-05 10:08:41	2008-02-05 10:10:41	f	0101000020E6100000113CBEBD6B3852C08AC8B08A37EC4440
2483	56	2008-02-05 10:09:49	2008-02-05 10:11:49	f	0101000020E610000015234BE6583852C0E19C11A5BDEB4440
2484	56	2008-02-05 10:10:25	2008-02-05 10:12:25	t	0101000020E61000007C67B455493852C0931D1B8178EB4440
2485	56	2008-02-05 10:34:00	2008-02-05 10:36:00	f	0101000020E61000007C67B455493852C05396218E75EB4440
2486	56	2008-02-05 10:37:27	2008-02-05 10:39:27	f	0101000020E610000038E15E99B73852C0BFF1B56796EA4440
2487	56	2008-02-05 10:42:41	2008-02-05 10:44:41	f	0101000020E6100000757CB438633652C0209DBAF259E44440
2488	56	2008-02-05 10:42:41	2008-02-05 10:44:41	t	0101000020E6100000757CB438633652C0209DBAF259E44440
2489	56	2008-02-05 10:43:21	2008-02-05 10:45:21	f	0101000020E6100000C7C03A8E1F3652C0E0F8DA334BE44440
2490	56	2008-02-05 10:43:42	2008-02-05 10:45:42	t	0101000020E6100000C39FE1CD1A3652C0FCA9F1D24DE44440
2491	56	2008-02-05 10:48:48	2008-02-05 10:50:48	f	0101000020E6100000F96C1D1CEC3552C00A11700855E44440
2492	56	2008-02-05 10:53:48	2008-02-05 10:55:48	f	0101000020E6100000EAF2E670AD3252C01E38674469E54440
2493	56	2008-02-05 10:54:49	2008-02-05 10:56:49	f	0101000020E6100000F5160FEF393252C0EC8B84B69CE54440
2494	56	2008-02-05 10:56:31	2008-02-05 10:58:31	t	0101000020E610000019D00B772E3252C055A4C2D842E64440
2495	56	2008-02-05 11:01:31	2008-02-05 11:03:31	t	0101000020E6100000AB9B8BBFED3152C09C33A2B437E64440
2496	56	2008-02-05 11:02:15	2008-02-05 11:04:15	f	0101000020E61000002A75C938463252C0A375543541E64440
2497	56	2008-02-05 11:03:48	2008-02-05 11:05:48	f	0101000020E61000000361A758353252C0B4EA73B515E54440
2498	56	2008-02-05 11:04:56	2008-02-05 11:06:56	t	0101000020E610000091B932A8363252C09FCDAACFD5E44440
2499	56	2008-02-05 11:07:23	2008-02-05 11:09:23	t	0101000020E610000091F3FE3F4E3252C06A183E22A6E24440
2500	56	2008-02-05 11:10:19	2008-02-05 11:12:19	f	0101000020E61000007C4ACE893D3252C0AC5626FC52E14440
2501	56	2008-02-05 11:11:16	2008-02-05 11:13:16	t	0101000020E6100000EAEDCF45433252C0894160E5D0E04440
2502	56	2008-02-05 11:13:12	2008-02-05 11:15:12	t	0101000020E6100000AA49F086343252C0BB61DBA2CCE04440
2503	56	2008-02-05 11:15:22	2008-02-05 11:17:22	f	0101000020E6100000AB44D95BCA3152C065FCFB8C0BE14440
2504	56	2008-02-05 11:17:06	2008-02-05 11:19:06	t	0101000020E61000000B815CE2C83152C097E2AAB2EFE04440
2505	56	2008-02-05 11:17:21	2008-02-05 11:19:21	f	0101000020E6100000522D228AC93152C0020EA14ACDE04440
2506	56	2008-02-05 11:26:19	2008-02-05 11:28:19	f	0101000020E6100000D23B1570CF3152C0D1B359F5B9E04440
2507	56	2008-02-05 11:27:02	2008-02-05 11:29:02	t	0101000020E6100000B269A510C83152C0431CEBE236E04440
2508	56	2008-02-05 11:27:07	2008-02-05 11:29:07	t	0101000020E6100000D63F8864C83152C0276BD44334E04440
2509	56	2008-02-05 11:28:50	2008-02-05 11:30:50	f	0101000020E6100000733447567E3152C0841266DAFEDF4440
2510	56	2008-02-05 11:32:53	2008-02-05 11:34:53	t	0101000020E6100000530B2593533152C0F3B0506B9ADD4440
2511	56	2008-02-05 11:37:56	2008-02-05 11:39:56	t	0101000020E6100000BAC32632732F52C02FC03E3A75DB4440
2512	56	2008-02-05 11:39:12	2008-02-05 11:41:12	f	0101000020E610000044C6A354C22F52C0DB334B02D4DA4440
2513	56	2008-02-05 11:40:14	2008-02-05 11:42:14	f	0101000020E610000000068200193052C0DBF97E6ABCDA4440
2514	56	2008-02-05 11:43:39	2008-02-05 11:45:39	t	0101000020E6100000F2BBE9961D3052C06C09F9A067D94440
2515	56	2008-02-05 11:44:41	2008-02-05 11:46:41	f	0101000020E6100000F2BBE9961D3052C0D7A3703D0AD94440
2516	56	2008-02-05 11:45:45	2008-02-05 11:47:45	f	0101000020E6100000C7C03A8E1F3052C08B8EE4F21FD84440
2517	56	2008-02-05 11:46:36	2008-02-05 11:48:36	t	0101000020E6100000801475E61E3052C012A5BDC117D84440
2518	56	2008-02-05 11:47:35	2008-02-05 11:49:35	t	0101000020E61000000A34D8D4793052C044C5387F13D84440
2519	56	2008-02-05 11:48:00	2008-02-05 11:50:00	f	0101000020E6100000F5C473B6803052C08B71FE2614D84440
2520	56	2008-02-05 11:50:07	2008-02-05 11:52:07	f	0101000020E6100000FC0626378A3052C01FF98381E7D84440
2521	56	2008-02-05 11:54:23	2008-02-05 11:56:23	f	0101000020E610000010B56D18053152C09626A5A0DBD94440
2522	56	2008-02-05 11:55:25	2008-02-05 11:57:25	t	0101000020E610000071B20DDC813052C00F10CCD1E3D94440
2523	56	2008-02-05 11:58:24	2008-02-05 12:00:24	t	0101000020E6100000FE4E93196F2F52C0DDEF5014E8D94440
2524	56	2008-02-05 12:00:20	2008-02-05 12:02:20	t	0101000020E61000007E23BA675D2F52C006BB61DBA2DA4440
2525	56	2008-02-05 12:05:14	2008-02-05 12:07:14	f	0101000020E6100000E8A562635E2F52C0E9B7AF03E7DA4440
2526	56	2008-02-05 12:10:14	2008-02-05 12:12:14	f	0101000020E610000006871744A43052C0F4716DA818DD4440
2527	56	2008-02-05 12:11:40	2008-02-05 12:13:40	f	0101000020E61000008D852172FA3052C088F4DBD781DD4440
2528	56	2008-02-05 12:16:40	2008-02-05 12:18:40	f	0101000020E610000034FAD170CA3252C0257A19C572DD4440
2529	56	2008-02-05 12:21:40	2008-02-05 12:23:40	t	0101000020E61000002A75C938463652C0014D840D4FDD4440
2530	56	2008-02-05 12:25:58	2008-02-05 12:27:58	f	0101000020E6100000C39FE1CD1A3852C0D6FF39CC97DD4440
2531	56	2008-02-05 12:27:00	2008-02-05 12:29:00	t	0101000020E6100000F2BBE9961D3852C0481B47ACC5DD4440
2532	56	2008-02-05 12:27:04	2008-02-05 12:29:04	f	0101000020E6100000F2BBE9961D3852C08FC70C54C6DD4440
2533	56	2008-02-05 12:29:25	2008-02-05 12:31:25	t	0101000020E610000027FDBD141E3852C0E31934F44FDE4440
2534	56	2008-02-05 12:30:00	2008-02-05 12:32:00	f	0101000020E610000000CCB568013852C04794F6065FDE4440
2535	56	2008-02-05 12:30:31	2008-02-05 12:32:31	t	0101000020E61000005D7347FFCB3752C0F19D98F562DE4440
2536	56	2008-02-05 12:41:34	2008-02-05 12:43:34	t	0101000020E61000005D7347FFCB3752C0EA78CC4065DE4440
2537	56	2008-02-05 12:42:03	2008-02-05 12:44:03	t	0101000020E6100000C88157CB9D3752C0FF04172B6ADE4440
2538	56	2008-02-05 12:43:20	2008-02-05 12:45:20	f	0101000020E6100000F68079C8943752C07F6ABC7493DE4440
2539	56	2008-02-05 12:44:04	2008-02-05 12:46:04	t	0101000020E6100000DDF0BBE9963752C05B7C0A80F1DE4440
2540	56	2008-02-05 12:45:11	2008-02-05 12:47:11	f	0101000020E6100000F37C06D49B3752C01366DAFE95DF4440
2541	57	2008-02-04 06:50:37	2008-02-04 06:52:37	f	0101000020E610000028158DB5BF2F52C08A07944DB9D84440
2542	57	2008-02-04 07:00:37	2008-02-04 07:02:37	f	0101000020E6100000FDDF1115AA2F52C0E240481630D74440
2543	57	2008-02-04 07:10:37	2008-02-04 07:12:37	t	0101000020E610000026E5EE737C2C52C00EF8FC3042D64440
2544	57	2008-02-04 07:20:37	2008-02-04 07:22:37	f	0101000020E61000001CD47E6B272C52C086E63A8DB4D64440
2545	57	2008-02-04 07:30:37	2008-02-04 07:32:37	t	0101000020E6100000ECC6BB23632F52C0F25EB532E1D94440
2546	57	2008-02-04 07:50:37	2008-02-04 07:52:37	f	0101000020E610000053EE3EC7472D52C0D1B359F5B9DC4440
2547	57	2008-02-04 08:00:37	2008-02-04 08:02:37	t	0101000020E6100000375A0EF4502D52C0923F1878EEDB4440
2548	57	2008-02-04 08:10:37	2008-02-04 08:12:37	f	0101000020E6100000B173D3669C2C52C06FBBD05CA7DB4440
2549	57	2008-02-04 08:20:36	2008-02-04 08:22:36	f	0101000020E6100000FF7E315BB22C52C00C24287E8CDB4440
2550	57	2008-02-04 08:30:36	2008-02-04 08:32:36	t	0101000020E6100000ED134031B22C52C02FFA0AD28CDB4440
2551	58	2008-02-04 04:48:39	2008-02-04 04:50:39	t	0101000020E6100000F629C764713552C03D44A33B88C74440
2552	58	2008-02-04 04:53:39	2008-02-04 04:55:39	f	0101000020E6100000F629C764713552C03D44A33B88C74440
2553	58	2008-02-04 04:58:39	2008-02-04 05:00:39	f	0101000020E6100000F629C764713552C03D44A33B88C74440
2554	58	2008-02-04 05:03:39	2008-02-04 05:05:39	f	0101000020E6100000F629C764713552C03D44A33B88C74440
2555	58	2008-02-04 05:08:39	2008-02-04 05:10:39	f	0101000020E6100000F629C764713552C03D44A33B88C74440
2556	58	2008-02-04 05:13:39	2008-02-04 05:15:39	f	0101000020E6100000E5BED53A713552C03D44A33B88C74440
2557	58	2008-02-04 05:13:39	2008-02-04 05:15:39	t	0101000020E6100000E5BED53A713552C03D44A33B88C74440
2558	58	2008-02-04 05:18:39	2008-02-04 05:20:39	t	0101000020E6100000E5BED53A713552C03D44A33B88C74440
2559	58	2008-02-04 05:23:39	2008-02-04 05:25:39	f	0101000020E6100000E5BED53A713552C03D44A33B88C74440
2560	58	2008-02-04 05:28:38	2008-02-04 05:30:38	t	0101000020E6100000D353E410713552C03D44A33B88C74440
2561	58	2008-02-04 05:33:38	2008-02-04 05:35:38	t	0101000020E6100000D353E410713552C03D44A33B88C74440
2562	58	2008-02-04 05:38:38	2008-02-04 05:40:38	t	0101000020E6100000D353E410713552C03D44A33B88C74440
2563	58	2008-02-04 05:43:38	2008-02-04 05:45:38	f	0101000020E6100000C1E8F2E6703552C03D44A33B88C74440
2564	58	2008-02-04 05:48:38	2008-02-04 05:50:38	t	0101000020E6100000C1E8F2E6703552C03D44A33B88C74440
2565	58	2008-02-04 05:53:38	2008-02-04 05:55:38	f	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2566	58	2008-02-04 05:58:38	2008-02-04 06:00:38	f	0101000020E61000009E121093703552C03D44A33B88C74440
2567	58	2008-02-04 06:03:38	2008-02-04 06:05:38	f	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2568	58	2008-02-04 06:08:38	2008-02-04 06:10:38	f	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2569	58	2008-02-04 06:13:38	2008-02-04 06:15:38	t	0101000020E61000009E121093703552C03D44A33B88C74440
2570	58	2008-02-04 06:18:38	2008-02-04 06:20:38	t	0101000020E61000009E121093703552C03D44A33B88C74440
2571	58	2008-02-04 06:23:38	2008-02-04 06:25:38	f	0101000020E61000009E121093703552C03D44A33B88C74440
2572	58	2008-02-04 06:28:39	2008-02-04 06:30:39	t	0101000020E61000009E121093703552C03D44A33B88C74440
2573	58	2008-02-04 06:33:39	2008-02-04 06:35:39	t	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2574	58	2008-02-04 06:38:39	2008-02-04 06:40:39	t	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2575	58	2008-02-04 06:43:39	2008-02-04 06:45:39	t	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2576	58	2008-02-04 06:53:38	2008-02-04 06:55:38	f	0101000020E6100000AF7D01BD703552C03D44A33B88C74440
2577	58	2008-02-04 06:58:38	2008-02-04 07:00:38	f	0101000020E61000009E121093703552C03D44A33B88C74440
2578	58	2008-02-04 07:03:38	2008-02-04 07:05:38	t	0101000020E61000009E121093703552C03D44A33B88C74440
2579	58	2008-02-04 07:08:38	2008-02-04 07:10:38	t	0101000020E61000009E121093703552C03D44A33B88C74440
2580	58	2008-02-04 07:13:38	2008-02-04 07:15:38	t	0101000020E61000009E121093703552C01A6EC0E787C74440
2581	58	2008-02-04 07:18:38	2008-02-04 07:20:38	t	0101000020E61000009E121093703552C01A6EC0E787C74440
2582	58	2008-02-04 07:23:38	2008-02-04 07:25:38	f	0101000020E61000009E121093703552C01A6EC0E787C74440
2583	58	2008-02-04 07:28:38	2008-02-04 07:30:38	t	0101000020E61000009E121093703552C01A6EC0E787C74440
2584	58	2008-02-04 07:33:38	2008-02-04 07:35:38	t	0101000020E61000009E121093703552C01A6EC0E787C74440
2585	58	2008-02-04 07:38:38	2008-02-04 07:40:38	t	0101000020E6100000AF7D01BD703552C01A6EC0E787C74440
2586	58	2008-02-04 07:38:38	2008-02-04 07:40:38	f	0101000020E6100000AF7D01BD703552C01A6EC0E787C74440
2587	58	2008-02-04 07:43:38	2008-02-04 07:45:38	t	0101000020E6100000AF7D01BD703552C0F697DD9387C74440
2588	58	2008-02-04 07:48:38	2008-02-04 07:50:38	t	0101000020E61000009E121093703552C0F697DD9387C74440
2589	58	2008-02-04 07:53:38	2008-02-04 07:55:38	f	0101000020E61000009E121093703552C0D3C1FA3F87C74440
2590	58	2008-02-04 07:58:38	2008-02-04 08:00:38	f	0101000020E61000009E121093703552C0D3C1FA3F87C74440
2591	58	2008-02-04 08:03:38	2008-02-04 08:05:38	f	0101000020E61000009E121093703552C0D3C1FA3F87C74440
2592	58	2008-02-04 08:08:38	2008-02-04 08:10:38	f	0101000020E61000009E121093703552C0F697DD9387C74440
2593	58	2008-02-04 08:13:38	2008-02-04 08:15:38	t	0101000020E61000009E121093703552C0F697DD9387C74440
2594	58	2008-02-04 08:18:38	2008-02-04 08:20:38	t	0101000020E61000005D7347FFCB3552C07E6FD39FFDC64440
2595	58	2008-02-04 08:23:38	2008-02-04 08:25:38	f	0101000020E6100000BE5301F73C3552C077BE9F1A2FC74440
2596	58	2008-02-04 08:28:38	2008-02-04 08:30:38	f	0101000020E61000008413D1AFAD3352C027A5A0DB4BC84440
2597	58	2008-02-04 08:33:38	2008-02-04 08:35:38	f	0101000020E6100000F05696E82C3352C0331B649291C94440
2598	58	2008-02-04 08:38:38	2008-02-04 08:40:38	t	0101000020E61000001A6F2BBD363352C062105839B4CA4440
2599	58	2008-02-04 08:43:38	2008-02-04 08:45:38	f	0101000020E61000005B48C0E8F23252C09F3C2CD49ACC4440
2600	58	2008-02-04 08:53:38	2008-02-04 08:55:38	f	0101000020E61000000B2AAA7EA53352C0A37A6B60ABD24440
2601	58	2008-02-04 08:58:38	2008-02-04 09:00:38	t	0101000020E610000071B20DDC813452C0AAF1D24D62D24440
2602	58	2008-02-04 09:03:37	2008-02-04 09:05:37	f	0101000020E610000001E48409A33352C0CE70033E3FD24440
2603	58	2008-02-04 09:08:38	2008-02-04 09:10:38	f	0101000020E6100000D84D29AF953252C0EFC9C342ADD34440
2604	58	2008-02-04 09:13:38	2008-02-04 09:15:38	t	0101000020E610000016014EEFE23152C0D1915CFE43D44440
2605	58	2008-02-04 09:18:38	2008-02-04 09:20:38	t	0101000020E6100000D7C6D8092F3152C0CB67791EDCD34440
2606	58	2008-02-04 09:23:37	2008-02-04 09:25:37	t	0101000020E610000019B325AB223252C0271422E010D44440
2607	58	2008-02-04 09:28:38	2008-02-04 09:30:38	t	0101000020E6100000D5449F8F323252C0BB61DBA2CCD44440
2608	58	2008-02-04 09:33:38	2008-02-04 09:35:38	f	0101000020E610000063F4DC42573252C03C1405FA44D44440
2609	58	2008-02-04 09:38:38	2008-02-04 09:40:38	f	0101000020E6100000C8F0D8CF623152C06D567DAEB6D44440
2610	58	2008-02-04 09:43:37	2008-02-04 09:45:37	f	0101000020E6100000297FF78E1A3152C0E3AAB2EF8AD64440
2611	58	2008-02-04 09:48:38	2008-02-04 09:50:38	f	0101000020E61000005440DAFF003152C02D431CEBE2D84440
2612	58	2008-02-04 09:53:38	2008-02-04 09:55:38	f	0101000020E61000006D3F19E3C33052C03CBD529621D84440
2613	58	2008-02-04 09:58:38	2008-02-04 10:00:38	f	0101000020E6100000B3D826158D2F52C03C1405FA44D84440
2614	58	2008-02-04 10:03:38	2008-02-04 10:05:38	f	0101000020E6100000765AB741ED2F52C01AA88C7F9FD74440
2615	58	2008-02-04 10:03:38	2008-02-04 10:05:38	t	0101000020E6100000765AB741ED2F52C01AA88C7F9FD74440
2616	59	2008-02-03 17:07:48	2008-02-03 17:09:48	f	0101000020E61000006ADFDC5F3D2E52C0E7A90EB919E04440
2617	59	2008-02-03 17:10:36	2008-02-03 17:12:36	t	0101000020E6100000325BB22AC22D52C099D87C5C1BE04440
2618	59	2008-02-03 17:12:50	2008-02-03 17:14:50	t	0101000020E6100000C460FE0A992D52C09A99999999DF4440
2619	59	2008-02-03 17:15:37	2008-02-03 17:17:37	t	0101000020E6100000C460FE0A992D52C0F19D98F562DE4440
2620	59	2008-02-03 17:17:51	2008-02-03 17:19:51	f	0101000020E6100000FD19DEACC12D52C0D55B035B25DE4440
2621	59	2008-02-03 17:22:53	2008-02-03 17:24:53	f	0101000020E61000003243E389202E52C045696FF085DF4440
2622	59	2008-02-03 17:25:41	2008-02-03 17:27:41	t	0101000020E6100000763DD175E12D52C046088F368EDE4440
2623	59	2008-02-03 17:27:55	2008-02-03 17:29:55	f	0101000020E610000060420587172E52C0C0EC9E3C2CDE4440
2624	59	2008-02-03 17:27:55	2008-02-03 17:29:55	t	0101000020E610000060420587172E52C0C0EC9E3C2CDE4440
2625	59	2008-02-03 17:30:42	2008-02-03 17:32:42	f	0101000020E6100000F707CA6DFB2E52C0C3F5285C8FDC4440
2626	60	2008-02-02 23:39:38	2008-02-02 23:41:38	f	0101000020E6100000002368CC243652C0C32FF5F3A6D84440
2627	60	2008-02-02 23:44:40	2008-02-02 23:46:40	f	0101000020E6100000CC4BFE277F3752C0E65C8AABCAD84440
2628	60	2008-02-02 23:44:40	2008-02-02 23:46:40	f	0101000020E6100000CC4BFE277F3752C0E65C8AABCAD84440
2629	60	2008-02-02 23:49:29	2008-02-02 23:51:29	t	0101000020E6100000859F38807E3952C009336DFFCAD84440
2630	60	2008-02-02 23:49:29	2008-02-02 23:51:29	t	0101000020E6100000859F38807E3952C009336DFFCAD84440
2631	60	2008-02-02 23:49:42	2008-02-02 23:51:42	f	0101000020E6100000EB573A1F9E3952C049BA66F2CDD84440
2632	60	2008-02-02 23:54:43	2008-02-02 23:56:43	f	0101000020E6100000330400C79E3952C0A6F27684D3D84440
2633	60	2008-02-02 23:59:32	2008-02-03 00:01:32	t	0101000020E6100000420A9E42AE3A52C092CB7F48BFD74440
2634	60	2008-02-02 23:59:45	2008-02-03 00:01:45	t	0101000020E6100000420A9E42AE3A52C092CB7F48BFD74440
2635	60	2008-02-03 00:04:46	2008-02-03 00:06:46	f	0101000020E6100000FDAA5CA8FC3B52C0F0F96184F0D64440
2636	60	2008-02-03 00:09:36	2008-02-03 00:11:36	f	0101000020E6100000CF6C57E8833B52C04B02D4D4B2D74440
2637	60	2008-02-03 00:09:48	2008-02-03 00:11:48	f	0101000020E61000000895B88E713B52C0EFACDD76A1D74440
2638	60	2008-02-03 00:14:50	2008-02-03 00:16:50	f	0101000020E61000006D96CB46E73852C0BDA94885B1D74440
2639	60	2008-02-03 00:19:39	2008-02-03 00:21:39	t	0101000020E61000008AEB18575C3652C0A1DB4B1AA3D74440
2640	60	2008-02-03 00:19:51	2008-02-03 00:21:51	t	0101000020E61000000EE198654F3652C0CCD6FA22A1D74440
2641	60	2008-02-03 00:24:53	2008-02-03 00:26:53	t	0101000020E6100000A56C91B41B3552C009336DFFCAD84440
2642	60	2008-02-03 00:29:55	2008-02-03 00:31:55	f	0101000020E6100000026BD5AE093352C0D74CBED9E6D84440
2643	60	2008-02-03 00:34:56	2008-02-03 00:36:56	t	0101000020E61000008B20CEC3093252C000A94D9CDCD94440
2644	60	2008-02-03 00:39:46	2008-02-03 00:41:46	t	0101000020E6100000E7AF90B9323252C08F01D9EBDDD94440
2645	60	2008-02-03 00:39:58	2008-02-03 00:41:58	t	0101000020E610000019EDF1423A3252C06B2BF697DDD94440
2646	60	2008-02-03 00:45:00	2008-02-03 00:47:00	f	0101000020E61000002BC24D46953352C0F224E99AC9D94440
2647	60	2008-02-03 00:49:49	2008-02-03 00:51:49	f	0101000020E6100000E2D231E7193552C042959A3DD0D84440
2648	60	2008-02-03 00:50:01	2008-02-03 00:52:01	f	0101000020E61000006C6116DA393552C0988BF84ECCD84440
2649	60	2008-02-03 00:55:03	2008-02-03 00:57:03	t	0101000020E6100000F6BA4560AC3552C00647C9AB73D64440
2650	60	2008-02-03 00:59:52	2008-02-03 01:01:52	f	0101000020E6100000852BA0504F3552C098FA795391D44440
2651	60	2008-02-03 01:00:05	2008-02-03 01:02:05	t	0101000020E610000013109370213552C06DFFCA4A93D44440
2652	60	2008-02-03 01:05:06	2008-02-03 01:07:06	f	0101000020E6100000D23B1570CF3352C0FF3EE3C281D24440
2653	60	2008-02-03 01:09:56	2008-02-03 01:11:56	t	0101000020E6100000B5C9E1934E3452C0E25817B7D1D24440
2654	60	2008-02-03 01:10:08	2008-02-03 01:12:08	f	0101000020E6100000B5C9E1934E3452C0BF823463D1D24440
2655	60	2008-02-03 01:15:10	2008-02-03 01:17:10	f	0101000020E610000045D95BCAF93452C0618907944DD34440
2656	60	2008-02-03 01:19:59	2008-02-03 01:21:59	f	0101000020E6100000B66D1805C13352C0D42B6519E2D24440
2657	60	2008-02-03 01:20:11	2008-02-03 01:22:11	f	0101000020E6100000A8406667D13352C046D3D9C9E0D24440
2658	60	2008-02-03 01:25:13	2008-02-03 01:27:13	f	0101000020E61000001653E9279C3552C0377172BF43D34440
2659	60	2008-02-03 01:30:02	2008-02-03 01:32:02	t	0101000020E6100000F2643733FA3752C0700D6C9560D34440
2660	60	2008-02-03 01:30:15	2008-02-03 01:32:15	f	0101000020E6100000F9A6E9B3033852C0FE65F7E461D34440
2661	60	2008-02-03 01:35:16	2008-02-03 01:37:16	t	0101000020E61000008B389D64AB3552C0CC7F48BF7DD34440
2662	60	2008-02-03 01:40:06	2008-02-03 01:42:06	t	0101000020E6100000085BECF6593552C0CA54C1A8A4D44440
2663	60	2008-02-03 01:45:20	2008-02-03 01:47:20	f	0101000020E61000002D499EEBFB3452C059DDEA39E9D34440
2664	60	2008-02-03 01:50:21	2008-02-03 01:52:21	t	0101000020E61000000826378AAC3552C07CD5CA845FD44440
2665	60	2008-02-03 01:50:21	2008-02-03 01:52:21	f	0101000020E61000000826378AAC3552C07CD5CA845FD44440
2666	60	2008-02-03 01:55:23	2008-02-03 01:57:23	f	0101000020E610000097CB46E7FC3452C0A1F831E6AED34440
2667	60	2008-02-03 01:59:12	2008-02-03 02:01:12	f	0101000020E6100000501F813FFC3452C0367689EAADD34440
2668	60	2008-02-03 02:31:23	2008-02-03 02:33:23	f	0101000020E6100000A54FABE80F3552C0DF89592F86D44440
2669	60	2008-02-03 02:38:26	2008-02-03 02:40:26	t	0101000020E61000000C5F5FEB523552C068D0D03FC1D34440
2670	60	2008-02-03 02:39:25	2008-02-03 02:41:25	f	0101000020E610000082B3942C273552C03DB83B6BB7D34440
2671	60	2008-02-03 02:41:26	2008-02-03 02:43:26	f	0101000020E610000082B3942C273552C03DB83B6BB7D34440
2672	60	2008-02-03 04:18:12	2008-02-03 04:20:12	t	0101000020E61000006923D74D293552C0554D10751FAE4440
2673	60	2008-02-03 04:18:12	2008-02-03 04:20:12	t	0101000020E61000006923D74D293552C0554D10751FAE4440
2674	60	2008-02-03 09:25:02	2008-02-03 09:27:02	t	0101000020E6100000FEA02E52283552C03DB83B6BB7D34440
2675	60	2008-02-03 09:30:04	2008-02-03 09:32:04	t	0101000020E6100000931E8656273552C0A11518B2BAD34440
2676	60	2008-02-03 09:30:52	2008-02-03 09:32:52	f	0101000020E6100000DAE731CA333552C07D3F355EBAD34440
2677	60	2008-02-03 09:35:06	2008-02-03 09:37:06	t	0101000020E6100000611BF164373552C01AE25817B7D34440
2678	60	2008-02-03 09:40:07	2008-02-03 09:42:07	t	0101000020E6100000CEB051D66F3452C0616C21C841D34440
2679	60	2008-02-03 09:45:09	2008-02-03 09:47:09	t	0101000020E6100000E8887C97523352C09A7CB3CD8DD34440
2680	60	2008-02-03 09:50:11	2008-02-03 09:52:11	f	0101000020E610000004AE2B66843152C0B6BE4868CBD34440
2681	60	2008-02-03 09:50:59	2008-02-03 09:52:59	f	0101000020E61000003755F7C8E63052C059A31EA2D1D34440
2682	60	2008-02-03 09:55:12	2008-02-03 09:57:12	t	0101000020E6100000A554C2137A3152C02ECA6C9049D44440
2683	60	2008-02-03 10:00:14	2008-02-03 10:02:14	f	0101000020E6100000400114234B3252C0914946CEC2D44440
2684	60	2008-02-03 10:01:02	2008-02-03 10:03:02	t	0101000020E6100000B52094F7713252C051C24CDBBFD44440
2685	60	2008-02-03 10:05:16	2008-02-03 10:07:16	f	0101000020E61000000214234BE63252C03B3602F1BAD44440
2686	60	2008-02-03 10:11:05	2008-02-03 10:13:05	f	0101000020E61000008B3DB48F153452C00820B58993D54440
2687	60	2008-02-03 10:11:05	2008-02-03 10:13:05	f	0101000020E61000008B3DB48F153452C00820B58993D54440
2688	60	2008-02-03 10:15:19	2008-02-03 10:17:19	t	0101000020E6100000C122BF7E883552C081ECF5EE8FD54440
2689	60	2008-02-03 10:20:21	2008-02-03 10:22:21	t	0101000020E610000087562767283652C05F984C158CD84440
2690	60	2008-02-03 10:21:09	2008-02-03 10:23:09	f	0101000020E61000003260C9552C3652C010E9B7AF03D94440
2691	61	2008-02-08 17:08:25	2008-02-08 17:10:25	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2692	61	2008-02-08 17:08:53	2008-02-08 17:10:53	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2693	61	2008-02-08 17:10:33	2008-02-08 17:12:33	f	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2694	61	2008-02-08 17:13:27	2008-02-08 17:15:27	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2695	61	2008-02-08 17:13:55	2008-02-08 17:15:55	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2696	61	2008-02-08 17:14:55	2008-02-08 17:16:55	f	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2697	61	2008-02-08 17:18:29	2008-02-08 17:20:29	f	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2698	61	2008-02-08 17:18:56	2008-02-08 17:20:56	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2699	61	2008-02-08 17:19:47	2008-02-08 17:21:47	f	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2700	61	2008-02-08 17:23:31	2008-02-08 17:25:31	t	0101000020E610000092EEE714E42952C0CEDF844204BA4440
2701	62	2008-02-02 23:06:01	2008-02-02 23:08:01	f	0101000020E61000001B87FA5DD83252C0605969520AD04440
2702	62	2008-02-02 23:06:01	2008-02-02 23:08:01	t	0101000020E61000001B87FA5DD83252C0605969520AD04440
2703	62	2008-02-02 23:06:06	2008-02-02 23:08:06	t	0101000020E6100000A6DB12B9E03252C0EE7C3F355ED04440
2704	62	2008-02-02 23:06:16	2008-02-02 23:08:16	t	0101000020E610000050029B73F03252C0F38E537424D14440
2705	62	2008-02-02 23:06:21	2008-02-02 23:08:21	f	0101000020E610000070D40AD3F73252C0088F368E58D14440
2706	62	2008-02-02 23:06:26	2008-02-02 23:08:26	f	0101000020E61000005B65A6B4FE3252C0CD3B4ED191D24440
2707	62	2008-02-02 23:06:31	2008-02-02 23:08:31	f	0101000020E61000009E0DF967063352C0CCEEC9C342D34440
2708	62	2008-02-02 23:06:36	2008-02-02 23:08:36	t	0101000020E6100000BEDF68C70D3352C0931D1B8178D34440
2709	62	2008-02-02 23:06:41	2008-02-02 23:08:41	f	0101000020E61000000288BB7A153352C00D71AC8BDBCE4440
2710	62	2008-02-02 23:06:46	2008-02-02 23:08:46	t	0101000020E610000033C51C041D3352C07FFB3A70CECE4440
2711	62	2008-02-02 23:06:51	2008-02-02 23:08:51	t	0101000020E610000065027E8D243352C09BC937DBDCCE4440
2712	62	2008-02-02 23:06:56	2008-02-02 23:08:56	t	0101000020E610000062FE0A992B3352C077F86BB246CF4440
2713	62	2008-02-02 23:07:01	2008-02-02 23:09:01	f	0101000020E610000005E3E0D2313352C0530ABABDA4CF4440
2714	62	2008-02-02 23:07:06	2008-02-02 23:09:06	f	0101000020E6100000134A5F08393352C01895D40968D04440
2715	62	2008-02-02 23:07:11	2008-02-02 23:09:11	t	0101000020E6100000935852EE3E3352C0A5A0DB4B1AD14440
2716	62	2008-02-02 23:07:16	2008-02-02 23:09:16	f	0101000020E6100000B009698D413352C0514EB4AB90D04440
2717	62	2008-02-02 23:07:31	2008-02-02 23:09:31	f	0101000020E610000045A4A65D4C3352C0B70BCD751ACF4440
2718	62	2008-02-02 23:07:36	2008-02-02 23:09:36	t	0101000020E6100000C19140834D3352C085CE6BEC12CF4440
2719	62	2008-02-02 23:07:41	2008-02-02 23:09:41	f	0101000020E6100000C19140834D3352C0BED9E6C6F4CE4440
2720	62	2008-02-02 23:08:06	2008-02-02 23:10:06	f	0101000020E61000007AE57ADB4C3352C08DD13AAA9ACE4440
2721	62	2008-02-02 23:08:11	2008-02-02 23:10:11	f	0101000020E61000008C506C054D3352C0B18A37328FCE4440
2722	62	2008-02-02 23:08:16	2008-02-02 23:10:16	f	0101000020E61000008C506C054D3352C0F836FDD98FCE4440
2723	62	2008-02-02 23:08:21	2008-02-02 23:10:21	t	0101000020E61000009EBB5D2F4D3352C0AA2B9FE579CE4440
2724	62	2008-02-02 23:08:26	2008-02-02 23:10:26	f	0101000020E61000009EBB5D2F4D3352C0B8AF03E78CCE4440
2725	62	2008-02-02 23:08:31	2008-02-02 23:10:31	t	0101000020E6100000B0264F594D3352C095D920938CCE4440
2726	62	2008-02-02 23:08:36	2008-02-02 23:10:36	t	0101000020E61000009EBB5D2F4D3352C0D54334BA83CE4440
2727	62	2008-02-02 23:08:41	2008-02-02 23:10:41	f	0101000020E61000009EBB5D2F4D3352C0F1F44A5986CE4440
2728	62	2008-02-02 23:08:46	2008-02-02 23:10:46	f	0101000020E6100000B0264F594D3352C08DD13AAA9ACE4440
2729	62	2008-02-02 23:08:51	2008-02-02 23:10:51	f	0101000020E61000009EBB5D2F4D3352C0B1C403CAA6CE4440
2730	62	2008-02-02 23:08:56	2008-02-02 23:10:56	t	0101000020E61000007AE57ADB4C3352C038F8C264AACE4440
2731	62	2008-02-02 23:09:01	2008-02-02 23:11:01	f	0101000020E61000007AE57ADB4C3352C0B8E9CF7EA4CE4440
2732	62	2008-02-02 23:09:06	2008-02-02 23:11:06	t	0101000020E61000009EBB5D2F4D3352C006BB61DBA2CE4440
2733	62	2008-02-02 23:09:11	2008-02-02 23:11:11	t	0101000020E6100000D3FC31AD4D3352C01B47ACC5A7CE4440
2734	62	2008-02-02 23:09:16	2008-02-02 23:11:16	f	0101000020E61000009796917A4F3352C08D0B0742B2CE4440
2735	62	2008-02-02 23:09:21	2008-02-02 23:11:21	f	0101000020E6100000FAF36DC1523352C0236C787AA5CE4440
2736	62	2008-02-02 23:09:26	2008-02-02 23:11:26	f	0101000020E61000006FBC3B32563352C00C0742B280D34440
2737	62	2008-02-02 23:09:31	2008-02-02 23:11:31	f	0101000020E61000004F07B29E5A3352C0B13385CE6BD24440
2738	62	2008-02-02 23:09:36	2008-02-02 23:11:36	f	0101000020E6100000C5CF7F0F5E3352C049A297512CD14440
2739	62	2008-02-02 23:09:41	2008-02-02 23:11:41	f	0101000020E610000077FEEDB25F3352C05B25581CCED24440
2740	62	2008-02-02 23:09:46	2008-02-02 23:11:46	f	0101000020E61000008869DFDC5F3352C038F8C264AAD24440
2741	62	2008-02-02 23:09:51	2008-02-02 23:11:51	f	0101000020E6100000AC3FC230603352C0DD989EB0C4D14440
2742	62	2008-02-02 23:09:56	2008-02-02 23:11:56	t	0101000020E610000017C26A2C613352C06BBC749318D24440
2743	62	2008-02-02 23:10:01	2008-02-02 23:12:01	f	0101000020E6100000282D5C56613352C06ADE718A8ED24440
2744	62	2008-02-02 23:10:06	2008-02-02 23:12:06	t	0101000020E6100000282D5C56613352C0DDB5847CD0D14440
2745	62	2008-02-02 23:10:11	2008-02-02 23:12:11	t	0101000020E610000005577902613352C0753C66A032D04440
2746	62	2008-02-02 23:10:16	2008-02-02 23:12:16	t	0101000020E6100000E18096AE603352C06FF59CF4BED34440
2747	62	2008-02-02 23:10:21	2008-02-02 23:12:21	f	0101000020E6100000AC3FC230603352C032B1F9B836D24440
2748	62	2008-02-02 23:10:26	2008-02-02 23:12:26	f	0101000020E61000006593FC885F3352C0577DAEB662D14440
2749	62	2008-02-02 23:10:31	2008-02-02 23:12:31	t	0101000020E61000006593FC885F3352C01D9430D3F6D14440
2750	62	2008-02-02 23:10:36	2008-02-02 23:12:36	t	0101000020E61000006593FC885F3352C0C8D2872EA8D14440
2751	62	2008-02-02 23:10:46	2008-02-02 23:12:46	f	0101000020E61000001EE736E15E3352C038DBDC989ED24440
2752	62	2008-02-02 23:10:46	2008-02-02 23:12:46	f	0101000020E61000001EE736E15E3352C038DBDC989ED24440
2753	62	2008-02-02 23:10:51	2008-02-02 23:12:51	f	0101000020E61000002F52280B5F3352C0BEA4315A47D34440
2754	62	2008-02-02 23:10:51	2008-02-02 23:12:51	f	0101000020E61000002F52280B5F3352C0BEA4315A47D34440
2755	62	2008-02-02 23:10:56	2008-02-02 23:12:56	t	0101000020E610000005577902613352C0CD751A69A9CE4440
2756	62	2008-02-02 23:11:01	2008-02-02 23:13:01	f	0101000020E61000001AE3C3EC653352C06EDDCD531DD04440
2757	62	2008-02-02 23:11:06	2008-02-02 23:13:06	f	0101000020E6100000CF328B506C3352C01DACFF7398D14440
2758	62	2008-02-02 23:11:16	2008-02-02 23:13:16	f	0101000020E61000003DF372D87D3352C0B7D100DE02D34440
2759	62	2008-02-02 23:11:21	2008-02-02 23:13:21	f	0101000020E6100000D38DB0A8883352C0B745990D32D34440
2760	62	2008-02-02 23:11:26	2008-02-02 23:13:26	t	0101000020E61000008BFED0CC933352C0E10B93A982D34440
2761	62	2008-02-02 23:11:51	2008-02-02 23:13:51	t	0101000020E610000028158DB5BF3352C005FF5BC98ED34440
2762	62	2008-02-02 23:12:51	2008-02-02 23:14:51	t	0101000020E610000027FDBD141E3452C0B2A206D330D24440
2763	62	2008-02-02 23:12:56	2008-02-02 23:14:56	f	0101000020E61000000E8AE6012C3452C00EF8FC3042D24440
2764	62	2008-02-02 23:13:01	2008-02-02 23:15:01	f	0101000020E610000019EDF1423A3452C08D62B9A5D5CE4440
2765	62	2008-02-02 23:13:06	2008-02-02 23:15:06	t	0101000020E610000011E50B5A483452C05B423EE8D9D24440
2766	62	2008-02-03 00:10:21	2008-02-03 00:12:21	t	0101000020E610000002BD70E7C23652C0BC79AA436ECC4440
2767	62	2008-02-03 00:10:26	2008-02-03 00:12:26	f	0101000020E6100000C23577F4BF3652C09F1F46088FCC4440
2768	62	2008-02-03 00:10:46	2008-02-03 00:12:46	f	0101000020E61000008A997D1EA33652C0DBF97E6ABCCE4440
2769	62	2008-02-03 00:10:51	2008-02-03 00:12:51	t	0101000020E61000002D616D8C9D3652C0E0F8DA334BCC4440
2770	62	2008-02-03 00:10:56	2008-02-03 00:12:56	t	0101000020E6100000C3DEC4909C3652C014799274CDCE4440
2771	62	2008-02-03 00:11:01	2008-02-03 00:13:01	t	0101000020E61000003CFA5FAE45A667C0FAD005F52D33FC3F
2772	62	2008-02-03 00:11:56	2008-02-03 00:13:56	t	0101000020E61000007447FFCBB53652C02B1895D409D24440
2773	62	2008-02-03 00:12:01	2008-02-03 00:14:01	f	0101000020E6100000C2189128B43652C0DFC325C79DD04440
2774	62	2008-02-03 00:12:06	2008-02-03 00:14:06	f	0101000020E610000034C005D9B23652C00BEF7211DFCF4440
2775	62	2008-02-03 00:12:11	2008-02-03 00:14:11	t	0101000020E610000082919735B13652C0A1F831E6AECF4440
2776	63	2008-02-08 03:52:00	2008-02-08 03:54:00	t	0101000020E6100000B5C9E1934E3452C0431CEBE236CC4440
2777	63	2008-02-08 03:57:00	2008-02-08 03:59:00	f	0101000020E610000091F3FE3F4E3452C0276BD44334CC4440
2778	63	2008-02-08 04:07:00	2008-02-08 04:09:00	f	0101000020E610000038DC476E4D3452C0D99942E735CC4440
2779	63	2008-02-08 04:12:00	2008-02-08 04:14:00	t	0101000020E6100000039B73F04C3452C0AE9E93DE37CC4440
2780	63	2008-02-08 04:12:00	2008-02-08 04:14:00	f	0101000020E6100000039B73F04C3452C0AE9E93DE37CC4440
2781	63	2008-02-08 04:17:00	2008-02-08 04:19:00	f	0101000020E61000005CB22AC24D3452C092ED7C3F35CC4440
2782	63	2008-02-08 04:17:00	2008-02-08 04:19:00	f	0101000020E61000005CB22AC24D3452C092ED7C3F35CC4440
2783	63	2008-02-08 04:22:00	2008-02-08 04:24:00	f	0101000020E610000038DC476E4D3452C08AC8B08A37CC4440
2784	63	2008-02-08 04:27:00	2008-02-08 04:29:00	f	0101000020E6100000B5C9E1934E3452C0D274763238CC4440
2785	63	2008-02-08 04:32:00	2008-02-08 04:34:00	t	0101000020E610000091F3FE3F4E3452C067F2CD3637CC4440
2786	63	2008-02-08 04:37:00	2008-02-08 04:39:00	t	0101000020E61000006E1D1CEC4D3452C0AE9E93DE37CC4440
2787	63	2008-02-08 04:42:00	2008-02-08 04:44:00	f	0101000020E6100000D89FC4E74E3452C0F54A598638CC4440
2788	63	2008-02-08 04:47:00	2008-02-08 04:49:00	t	0101000020E6100000A35EF0694E3452C067F2CD3637CC4440
2789	63	2008-02-08 04:51:59	2008-02-08 04:53:59	t	0101000020E610000080880D164E3452C0431CEBE236CC4440
2790	63	2008-02-08 04:56:59	2008-02-08 04:58:59	t	0101000020E6100000B5C9E1934E3452C0AE9E93DE37CC4440
2791	63	2008-02-08 05:01:59	2008-02-08 05:03:59	f	0101000020E6100000C734D3BD4E3452C03CF71E2E39CC4440
2792	63	2008-02-08 05:06:59	2008-02-08 05:08:59	t	0101000020E6100000B5C9E1934E3452C03CF71E2E39CC4440
2793	63	2008-02-08 05:11:59	2008-02-08 05:13:59	t	0101000020E6100000204C8A8F4F3452C0431CEBE236CC4440
2794	63	2008-02-08 05:16:59	2008-02-08 05:18:59	f	0101000020E6100000A35EF0694E3452C0D274763238CC4440
2795	63	2008-02-08 05:21:59	2008-02-08 05:23:59	t	0101000020E61000006E1D1CEC4D3452C0431CEBE236CC4440
2796	63	2008-02-08 05:26:59	2008-02-08 05:28:59	f	0101000020E6100000204C8A8F4F3452C019213CDA38CC4440
2797	63	2008-02-08 05:31:59	2008-02-08 05:33:59	f	0101000020E6100000C00F0709513452C0991249F432CC4440
2798	63	2008-02-08 05:36:59	2008-02-08 05:38:59	f	0101000020E610000031B77BB94F3452C0431CEBE236CC4440
2799	63	2008-02-08 05:41:59	2008-02-08 05:43:59	t	0101000020E6100000B5C9E1934E3452C0431CEBE236CC4440
2800	63	2008-02-08 05:46:59	2008-02-08 05:48:59	t	0101000020E6100000FC75A73B4F3452C06E179AEB34CC4440
2801	63	2008-02-08 05:51:59	2008-02-08 05:53:59	f	0101000020E6100000FC75A73B4F3452C0FC6F253B36CC4440
2802	63	2008-02-08 05:56:59	2008-02-08 05:58:59	t	0101000020E610000091F3FE3F4E3452C06E179AEB34CC4440
2803	63	2008-02-08 06:01:59	2008-02-08 06:03:59	t	0101000020E610000091F3FE3F4E3452C092ED7C3F35CC4440
2804	63	2008-02-08 06:06:59	2008-02-08 06:08:59	f	0101000020E610000067F84F37503452C0991249F432CC4440
2805	63	2008-02-08 06:11:59	2008-02-08 06:13:59	f	0101000020E6100000204C8A8F4F3452C0431CEBE236CC4440
2806	63	2008-02-08 06:16:59	2008-02-08 06:18:59	f	0101000020E6100000FC75A73B4F3452C0FC6F253B36CC4440
2807	63	2008-02-08 06:21:59	2008-02-08 06:23:59	t	0101000020E610000091F3FE3F4E3452C06E179AEB34CC4440
2808	63	2008-02-08 06:26:59	2008-02-08 06:28:59	t	0101000020E610000091F3FE3F4E3452C067F2CD3637CC4440
2809	63	2008-02-08 06:31:59	2008-02-08 06:33:59	f	0101000020E6100000A35EF0694E3452C04A41B79734CC4440
2810	63	2008-02-08 06:36:59	2008-02-08 06:38:59	t	0101000020E610000080880D164E3452C092ED7C3F35CC4440
2811	63	2008-02-08 06:41:59	2008-02-08 06:43:59	t	0101000020E61000006E1D1CEC4D3452C00395F1EF33CC4440
2812	63	2008-02-08 06:41:59	2008-02-08 06:43:59	f	0101000020E61000006E1D1CEC4D3452C00395F1EF33CC4440
2813	63	2008-02-08 06:46:59	2008-02-08 06:48:59	f	0101000020E61000004A4739984D3452C06E179AEB34CC4440
2814	63	2008-02-08 06:51:59	2008-02-08 06:53:59	t	0101000020E610000080880D164E3452C04A41B79734CC4440
2815	63	2008-02-08 06:56:59	2008-02-08 06:58:59	f	0101000020E6100000B5C9E1934E3452C08AC8B08A37CC4440
2816	63	2008-02-08 07:01:59	2008-02-08 07:03:59	f	0101000020E6100000D89FC4E74E3452C092ED7C3F35CC4440
2817	63	2008-02-08 07:06:59	2008-02-08 07:08:59	f	0101000020E6100000D89FC4E74E3452C08AC8B08A37CC4440
2818	63	2008-02-08 07:11:59	2008-02-08 07:13:59	f	0101000020E61000000EE198654F3452C0AE9E93DE37CC4440
2819	63	2008-02-08 07:16:59	2008-02-08 07:18:59	t	0101000020E610000031B77BB94F3452C0AE9E93DE37CC4440
2820	63	2008-02-08 07:21:59	2008-02-08 07:23:59	f	0101000020E6100000A35EF0694E3452C067F2CD3637CC4440
2821	63	2008-02-08 07:26:59	2008-02-08 07:28:59	f	0101000020E610000031B77BB94F3452C0BCE82B4833CC4440
2822	63	2008-02-08 07:31:59	2008-02-08 07:33:59	t	0101000020E6100000FC75A73B4F3452C0D99942E735CC4440
2823	63	2008-02-08 07:36:59	2008-02-08 07:38:59	t	0101000020E610000043226DE34F3452C0E0BE0E9C33CC4440
2824	63	2008-02-08 07:41:59	2008-02-08 07:43:59	t	0101000020E6100000FC75A73B4F3452C067F2CD3637CC4440
2825	63	2008-02-08 07:46:59	2008-02-08 07:48:59	f	0101000020E6100000A35EF0694E3452C0B5C35F9335CC4440
2826	63	2008-02-08 07:51:59	2008-02-08 07:53:59	t	0101000020E610000080880D164E3452C0B5C35F9335CC4440
2827	63	2008-02-08 07:56:59	2008-02-08 07:58:59	t	0101000020E6100000D89FC4E74E3452C04A41B79734CC4440
2828	63	2008-02-08 08:01:59	2008-02-08 08:03:59	t	0101000020E6100000A35EF0694E3452C0276BD44334CC4440
2829	63	2008-02-08 08:06:59	2008-02-08 08:08:59	t	0101000020E6100000A35EF0694E3452C06E179AEB34CC4440
2830	63	2008-02-08 08:11:59	2008-02-08 08:13:59	f	0101000020E610000038DC476E4D3452C00395F1EF33CC4440
2831	63	2008-02-08 08:16:59	2008-02-08 08:18:59	t	0101000020E610000091F3FE3F4E3452C0B5C35F9335CC4440
2832	63	2008-02-08 08:21:59	2008-02-08 08:23:59	f	0101000020E610000038DC476E4D3452C092ED7C3F35CC4440
2833	63	2008-02-08 08:26:59	2008-02-08 08:28:59	t	0101000020E6100000277156444D3452C0D99942E735CC4440
2834	63	2008-02-08 08:31:59	2008-02-08 08:33:59	f	0101000020E61000004A4739984D3452C04A41B79734CC4440
2835	63	2008-02-08 08:36:59	2008-02-08 08:38:59	f	0101000020E61000001506651A4D3452C0B5C35F9335CC4440
2836	63	2008-02-08 08:41:59	2008-02-08 08:43:59	f	0101000020E6100000B5C9E1934E3452C0276BD44334CC4440
2837	63	2008-02-08 08:46:59	2008-02-08 08:48:59	f	0101000020E6100000277156444D3452C0B5C35F9335CC4440
2838	63	2008-02-08 08:51:59	2008-02-08 08:53:59	f	0101000020E6100000204C8A8F4F3452C0276BD44334CC4440
2839	63	2008-02-08 08:56:58	2008-02-08 08:58:58	t	0101000020E6100000C734D3BD4E3452C0BCE82B4833CC4440
2840	64	2008-02-03 09:24:56	2008-02-03 09:26:56	f	0101000020E61000007941446ADA4B52C072FE261422AE4440
2841	64	2008-02-03 09:25:06	2008-02-03 09:27:06	f	0101000020E61000008BAC3594DA4B52C095D4096822AE4440
2842	64	2008-02-03 09:25:16	2008-02-03 09:27:16	f	0101000020E61000008BAC3594DA4B52C095D4096822AE4440
2843	64	2008-02-03 09:25:21	2008-02-03 09:27:21	f	0101000020E61000009D1727BEDA4B52C095D4096822AE4440
2844	64	2008-02-03 09:25:26	2008-02-03 09:27:26	t	0101000020E61000009D1727BEDA4B52C095D4096822AE4440
2845	64	2008-02-03 09:25:36	2008-02-03 09:27:36	f	0101000020E61000009D1727BEDA4B52C095D4096822AE4440
2846	64	2008-02-03 09:25:41	2008-02-03 09:27:41	f	0101000020E6100000AF8218E8DA4B52C0B9AAECBB22AE4440
2847	64	2008-02-03 09:26:06	2008-02-03 09:28:06	t	0101000020E6100000D258FB3BDB4B52C0DC80CF0F23AE4440
2848	64	2008-02-03 09:26:11	2008-02-03 09:28:11	t	0101000020E6100000D258FB3BDB4B52C0DC80CF0F23AE4440
2849	64	2008-02-03 09:26:26	2008-02-03 09:28:26	f	0101000020E6100000C0ED0912DB4B52C0B9AAECBB22AE4440
2850	64	2008-02-03 09:26:31	2008-02-03 09:28:31	t	0101000020E6100000C0ED0912DB4B52C0B9AAECBB22AE4440
2851	64	2008-02-08 10:18:22	2008-02-08 10:20:22	f	0101000020E61000005A4DD7135D4B52C047205ED72FAE4440
2852	64	2008-02-08 10:18:27	2008-02-08 10:20:27	t	0101000020E61000006CB8C83D5D4B52C06BF6402B30AE4440
2853	64	2008-02-08 10:18:32	2008-02-08 10:20:32	f	0101000020E61000007E23BA675D4B52C08ECC237F30AE4440
2854	64	2008-02-08 10:18:37	2008-02-08 10:20:37	f	0101000020E61000007E23BA675D4B52C0B2A206D330AE4440
2855	64	2008-02-08 10:18:42	2008-02-08 10:20:42	t	0101000020E61000006CB8C83D5D4B52C0B2A206D330AE4440
2856	64	2008-02-08 10:18:47	2008-02-08 10:20:47	t	0101000020E61000006CB8C83D5D4B52C0B2A206D330AE4440
2857	64	2008-02-08 10:18:52	2008-02-08 10:20:52	t	0101000020E61000005A4DD7135D4B52C0B2A206D330AE4440
2858	64	2008-02-08 10:18:57	2008-02-08 10:20:57	t	0101000020E61000005A4DD7135D4B52C08ECC237F30AE4440
2859	64	2008-02-08 10:19:02	2008-02-08 10:21:02	t	0101000020E61000005A4DD7135D4B52C08ECC237F30AE4440
2860	64	2008-02-08 10:19:07	2008-02-08 10:21:07	t	0101000020E61000005A4DD7135D4B52C08ECC237F30AE4440
2861	64	2008-02-08 10:19:12	2008-02-08 10:21:12	t	0101000020E61000005A4DD7135D4B52C08ECC237F30AE4440
2862	64	2008-02-08 10:19:17	2008-02-08 10:21:17	t	0101000020E61000005A4DD7135D4B52C08ECC237F30AE4440
2863	64	2008-02-08 10:19:22	2008-02-08 10:21:22	f	0101000020E61000006CB8C83D5D4B52C06BF6402B30AE4440
2864	64	2008-02-08 10:19:22	2008-02-08 10:21:22	f	0101000020E61000006CB8C83D5D4B52C06BF6402B30AE4440
2865	64	2008-02-08 10:19:27	2008-02-08 10:21:27	t	0101000020E61000007E23BA675D4B52C06BF6402B30AE4440
2866	64	2008-02-08 10:19:27	2008-02-08 10:21:27	t	0101000020E61000007E23BA675D4B52C06BF6402B30AE4440
2867	64	2008-02-08 10:19:32	2008-02-08 10:21:32	f	0101000020E6100000B3648EE55D4B52C06BF6402B30AE4440
2868	64	2008-02-08 10:19:37	2008-02-08 10:21:37	f	0101000020E6100000D73A71395E4B52C06BF6402B30AE4440
2869	64	2008-02-08 10:19:42	2008-02-08 10:21:42	f	0101000020E6100000E8A562635E4B52C08ECC237F30AE4440
2870	64	2008-02-08 10:19:47	2008-02-08 10:21:47	t	0101000020E6100000FA10548D5E4B52C08ECC237F30AE4440
2871	64	2008-02-08 10:19:52	2008-02-08 10:21:52	t	0101000020E6100000FA10548D5E4B52C0B2A206D330AE4440
2872	64	2008-02-08 10:19:57	2008-02-08 10:21:57	f	0101000020E6100000E8A562635E4B52C0B2A206D330AE4440
2873	64	2008-02-08 10:20:02	2008-02-08 10:22:02	f	0101000020E6100000D73A71395E4B52C08ECC237F30AE4440
2874	64	2008-02-08 10:20:07	2008-02-08 10:22:07	f	0101000020E6100000C5CF7F0F5E4B52C08ECC237F30AE4440
2875	64	2008-02-08 10:20:12	2008-02-08 10:22:12	t	0101000020E6100000B3648EE55D4B52C06BF6402B30AE4440
2876	64	2008-02-08 10:20:17	2008-02-08 10:22:17	f	0101000020E6100000A1F99CBB5D4B52C047205ED72FAE4440
2877	64	2008-02-08 10:20:22	2008-02-08 10:22:22	f	0101000020E6100000A1F99CBB5D4B52C047205ED72FAE4440
2878	64	2008-02-08 10:20:27	2008-02-08 10:22:27	f	0101000020E6100000A1F99CBB5D4B52C047205ED72FAE4440
2879	64	2008-02-08 10:20:32	2008-02-08 10:22:32	f	0101000020E6100000A1F99CBB5D4B52C047205ED72FAE4440
2880	64	2008-02-08 10:20:37	2008-02-08 10:22:37	f	0101000020E6100000B3648EE55D4B52C047205ED72FAE4440
2881	64	2008-02-08 10:20:42	2008-02-08 10:22:42	f	0101000020E6100000C5CF7F0F5E4B52C047205ED72FAE4440
2882	64	2008-02-08 10:20:47	2008-02-08 10:22:47	f	0101000020E6100000C5CF7F0F5E4B52C047205ED72FAE4440
2883	64	2008-02-08 10:20:52	2008-02-08 10:22:52	t	0101000020E6100000C5CF7F0F5E4B52C047205ED72FAE4440
2884	64	2008-02-08 10:20:57	2008-02-08 10:22:57	t	0101000020E6100000D73A71395E4B52C047205ED72FAE4440
2885	64	2008-02-08 10:21:02	2008-02-08 10:23:02	f	0101000020E6100000D73A71395E4B52C06BF6402B30AE4440
2886	64	2008-02-08 10:21:07	2008-02-08 10:23:07	t	0101000020E6100000D73A71395E4B52C08ECC237F30AE4440
2887	64	2008-02-08 10:21:12	2008-02-08 10:23:12	f	0101000020E6100000B3648EE55D4B52C0D578E92631AE4440
2888	64	2008-02-08 10:21:17	2008-02-08 10:23:17	f	0101000020E61000008F8EAB915D4B52C01C25AFCE31AE4440
2889	64	2008-02-08 10:21:22	2008-02-08 10:23:22	f	0101000020E61000007E23BA675D4B52C01C25AFCE31AE4440
2890	64	2008-02-08 10:21:32	2008-02-08 10:23:32	t	0101000020E61000006CB8C83D5D4B52C0D578E92631AE4440
2891	64	2008-02-08 10:21:37	2008-02-08 10:23:37	f	0101000020E61000007E23BA675D4B52C0B2A206D330AE4440
2892	64	2008-02-08 10:21:42	2008-02-08 10:23:42	f	0101000020E61000008F8EAB915D4B52C08ECC237F30AE4440
2893	64	2008-02-08 10:21:47	2008-02-08 10:23:47	f	0101000020E6100000A1F99CBB5D4B52C08ECC237F30AE4440
2894	64	2008-02-08 10:21:52	2008-02-08 10:23:52	f	0101000020E6100000A1F99CBB5D4B52C06BF6402B30AE4440
2895	64	2008-02-08 10:21:57	2008-02-08 10:23:57	t	0101000020E6100000B3648EE55D4B52C06BF6402B30AE4440
2896	64	2008-02-08 10:22:02	2008-02-08 10:24:02	f	0101000020E6100000C5CF7F0F5E4B52C06BF6402B30AE4440
2897	64	2008-02-08 10:22:07	2008-02-08 10:24:07	t	0101000020E6100000D73A71395E4B52C06BF6402B30AE4440
2898	64	2008-02-08 10:22:12	2008-02-08 10:24:12	f	0101000020E6100000E8A562635E4B52C08ECC237F30AE4440
2899	64	2008-02-08 10:22:17	2008-02-08 10:24:17	f	0101000020E6100000FA10548D5E4B52C08ECC237F30AE4440
2900	64	2008-02-08 10:22:22	2008-02-08 10:24:22	f	0101000020E6100000FA10548D5E4B52C0B2A206D330AE4440
2901	64	2008-02-08 10:22:27	2008-02-08 10:24:27	f	0101000020E6100000E8A562635E4B52C0B2A206D330AE4440
2902	64	2008-02-08 10:22:32	2008-02-08 10:24:32	f	0101000020E6100000E8A562635E4B52C0B2A206D330AE4440
2903	64	2008-02-08 10:22:37	2008-02-08 10:24:37	f	0101000020E6100000E8A562635E4B52C0B2A206D330AE4440
2904	64	2008-02-08 10:22:42	2008-02-08 10:24:42	f	0101000020E6100000FA10548D5E4B52C0B2A206D330AE4440
2905	64	2008-02-08 10:22:47	2008-02-08 10:24:47	f	0101000020E6100000FA10548D5E4B52C08ECC237F30AE4440
2906	64	2008-02-08 10:22:52	2008-02-08 10:24:52	f	0101000020E6100000FA10548D5E4B52C08ECC237F30AE4440
2907	64	2008-02-08 10:22:57	2008-02-08 10:24:57	f	0101000020E61000000C7C45B75E4B52C08ECC237F30AE4440
2908	64	2008-02-08 10:23:02	2008-02-08 10:25:02	t	0101000020E61000000C7C45B75E4B52C08ECC237F30AE4440
2909	64	2008-02-08 10:23:07	2008-02-08 10:25:07	t	0101000020E61000000C7C45B75E4B52C06BF6402B30AE4440
2910	64	2008-02-08 10:23:12	2008-02-08 10:25:12	f	0101000020E61000000C7C45B75E4B52C06BF6402B30AE4440
2911	64	2008-02-08 10:23:17	2008-02-08 10:25:17	t	0101000020E6100000FA10548D5E4B52C06BF6402B30AE4440
2912	64	2008-02-08 10:23:22	2008-02-08 10:25:22	f	0101000020E6100000B3648EE55D4B52C08ECC237F30AE4440
2913	64	2008-02-08 10:23:27	2008-02-08 10:25:27	f	0101000020E6100000EFCA2E185C4B52C040FB912232AE4440
2914	64	2008-02-08 10:23:32	2008-02-08 10:25:32	t	0101000020E61000006172A3C85A4B52C040FB912232AE4440
2915	65	2008-02-07 07:08:47	2008-02-07 07:10:47	t	0101000020E610000034A83638113552C002D4D4B2B5C84440
2916	65	2008-02-07 07:13:47	2008-02-07 07:15:47	t	0101000020E610000034A83638113552C002D4D4B2B5C84440
2917	65	2008-02-07 07:18:47	2008-02-07 07:20:47	t	0101000020E6100000223D450E113552C0DFFDF15EB5C84440
2918	65	2008-02-07 07:23:47	2008-02-07 07:25:47	f	0101000020E6100000223D450E113552C0DFFDF15EB5C84440
2919	65	2008-02-07 07:33:47	2008-02-07 07:35:47	f	0101000020E6100000223D450E113552C0BB270F0BB5C84440
2920	65	2008-02-07 07:38:47	2008-02-07 07:40:47	f	0101000020E6100000223D450E113552C0BB270F0BB5C84440
2921	65	2008-02-07 07:43:47	2008-02-07 07:45:47	t	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2922	65	2008-02-07 07:53:47	2008-02-07 07:55:47	t	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2923	65	2008-02-07 07:58:46	2008-02-07 08:00:46	f	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2924	65	2008-02-07 08:03:46	2008-02-07 08:05:46	f	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2925	65	2008-02-07 08:03:46	2008-02-07 08:05:46	t	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2926	65	2008-02-07 08:08:46	2008-02-07 08:10:46	f	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2927	65	2008-02-07 08:13:46	2008-02-07 08:15:46	t	0101000020E610000010D253E4103552C0DFFDF15EB5C84440
2928	65	2008-02-07 08:18:46	2008-02-07 08:20:46	t	0101000020E6100000FE6662BA103552C0DFFDF15EB5C84440
2929	65	2008-02-07 08:23:46	2008-02-07 08:25:46	t	0101000020E6100000FE6662BA103552C0DFFDF15EB5C84440
2930	65	2008-02-07 08:28:46	2008-02-07 08:30:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2931	65	2008-02-07 08:33:46	2008-02-07 08:35:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2932	65	2008-02-07 08:38:46	2008-02-07 08:40:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2933	65	2008-02-07 08:43:46	2008-02-07 08:45:46	t	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2934	65	2008-02-07 08:48:46	2008-02-07 08:50:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2935	65	2008-02-07 08:53:46	2008-02-07 08:55:46	t	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2936	65	2008-02-07 08:58:46	2008-02-07 09:00:46	t	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2937	65	2008-02-07 09:03:46	2008-02-07 09:05:46	t	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2938	65	2008-02-07 09:08:46	2008-02-07 09:10:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2939	65	2008-02-07 09:13:46	2008-02-07 09:15:46	f	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2940	65	2008-02-07 09:18:46	2008-02-07 09:20:46	t	0101000020E6100000FE6662BA103552C002D4D4B2B5C84440
2941	65	2008-02-07 09:23:46	2008-02-07 09:25:46	t	0101000020E6100000ECFB7090103552C002D4D4B2B5C84440
2942	65	2008-02-07 09:28:46	2008-02-07 09:30:46	t	0101000020E6100000ECFB7090103552C002D4D4B2B5C84440
2943	65	2008-02-07 09:33:46	2008-02-07 09:35:46	f	0101000020E6100000ECFB7090103552C002D4D4B2B5C84440
2944	65	2008-02-07 09:38:46	2008-02-07 09:40:46	f	0101000020E6100000ECFB7090103552C002D4D4B2B5C84440
2945	65	2008-02-07 09:43:46	2008-02-07 09:45:46	t	0101000020E6100000ECFB7090103552C0DFFDF15EB5C84440
2946	65	2008-02-07 09:48:46	2008-02-07 09:50:46	f	0101000020E6100000DB907F66103552C0DFFDF15EB5C84440
2947	65	2008-02-07 09:53:46	2008-02-07 09:55:46	t	0101000020E6100000DB907F66103552C0DFFDF15EB5C84440
2948	65	2008-02-07 09:58:46	2008-02-07 10:00:46	t	0101000020E6100000DB907F66103552C0DFFDF15EB5C84440
2949	65	2008-02-07 10:03:46	2008-02-07 10:05:46	f	0101000020E6100000DB907F66103552C0DFFDF15EB5C84440
2950	65	2008-02-07 10:04:43	2008-02-07 10:06:43	t	0101000020E6100000DB907F66103552C0BB270F0BB5C84440
2951	65	2008-02-07 10:04:43	2008-02-07 10:06:43	f	0101000020E6100000DB907F66103552C0BB270F0BB5C84440
2952	65	2008-02-07 10:08:47	2008-02-07 10:10:47	t	0101000020E610000094E4B9BE0F3552C0D8D825AAB7C84440
2953	65	2008-02-07 10:13:46	2008-02-07 10:15:46	f	0101000020E610000010D253E4103552C0912C6002B7C84440
2954	65	2008-02-07 10:18:46	2008-02-07 10:20:46	f	0101000020E6100000223D450E113552C0BB270F0BB5C84440
2955	65	2008-02-07 10:23:46	2008-02-07 10:25:46	t	0101000020E6100000223D450E113552C0747B4963B4C84440
2956	65	2008-02-07 10:28:46	2008-02-07 10:30:46	t	0101000020E610000010D253E4103552C051A5660FB4C84440
2957	65	2008-02-07 10:28:46	2008-02-07 10:30:46	f	0101000020E610000010D253E4103552C051A5660FB4C84440
2958	65	2008-02-07 10:33:46	2008-02-07 10:35:46	t	0101000020E610000010D253E4103552C051A5660FB4C84440
2959	65	2008-02-07 10:38:46	2008-02-07 10:40:46	f	0101000020E610000010D253E4103552C0747B4963B4C84440
2960	65	2008-02-07 10:43:46	2008-02-07 10:45:46	f	0101000020E610000010D253E4103552C0747B4963B4C84440
2961	65	2008-02-07 10:48:45	2008-02-07 10:50:45	t	0101000020E610000010D253E4103552C0747B4963B4C84440
2962	65	2008-02-07 10:53:45	2008-02-07 10:55:45	f	0101000020E6100000DB907F66103552C01F85EB51B8C84440
2963	65	2008-02-07 10:58:45	2008-02-07 11:00:45	f	0101000020E6100000DB907F66103552C0B4024356B7C84440
2964	65	2008-02-07 11:03:45	2008-02-07 11:05:45	t	0101000020E610000047CF2D74253652C0630B410E4ACA4440
2965	65	2008-02-07 11:08:45	2008-02-07 11:10:45	t	0101000020E6100000E6284014CC3652C05BF0A2AF20CB4440
2966	65	2008-02-07 11:13:26	2008-02-07 11:15:26	t	0101000020E6100000ED4D0CC9C93652C07E1D386744CB4440
2967	65	2008-02-08 05:20:54	2008-02-08 05:22:54	f	0101000020E6100000058C2E6F0E3552C0DFFDF15EB5C84440
2968	65	2008-02-08 05:25:53	2008-02-08 05:27:53	f	0101000020E6100000DB907F66103552C058CA32C4B1C84440
2969	65	2008-02-08 05:30:53	2008-02-08 05:32:53	t	0101000020E6100000C9258E3C103552C0E622BE13B3C84440
2970	65	2008-02-08 05:35:53	2008-02-08 05:37:53	t	0101000020E6100000B7BA9C12103552C051A5660FB4C84440
2971	65	2008-02-08 05:40:53	2008-02-08 05:42:53	t	0101000020E6100000B7BA9C12103552C0747B4963B4C84440
2972	65	2008-02-08 05:45:53	2008-02-08 05:47:53	f	0101000020E6100000B7BA9C12103552C0BB270F0BB5C84440
2973	65	2008-02-08 05:50:53	2008-02-08 05:52:53	f	0101000020E6100000B7BA9C12103552C0BB270F0BB5C84440
2974	65	2008-02-08 05:55:53	2008-02-08 05:57:53	t	0101000020E6100000B7BA9C12103552C0BB270F0BB5C84440
2975	65	2008-02-08 06:00:53	2008-02-08 06:02:53	t	0101000020E6100000A54FABE80F3552C0BB270F0BB5C84440
2976	65	2008-02-08 06:05:53	2008-02-08 06:07:53	f	0101000020E6100000A54FABE80F3552C0BB270F0BB5C84440
2977	65	2008-02-08 06:10:53	2008-02-08 06:12:53	t	0101000020E6100000A54FABE80F3552C0BB270F0BB5C84440
2978	65	2008-02-08 06:15:53	2008-02-08 06:17:53	f	0101000020E6100000A54FABE80F3552C0BB270F0BB5C84440
2979	65	2008-02-08 06:20:53	2008-02-08 06:22:53	f	0101000020E610000094E4B9BE0F3552C0BB270F0BB5C84440
2980	65	2008-02-08 06:25:53	2008-02-08 06:27:53	f	0101000020E61000003087DD770C3552C09F76F86BB2C84440
2981	65	2008-02-08 06:30:53	2008-02-08 06:32:53	t	0101000020E6100000545DC0CB0C3552C0E622BE13B3C84440
2982	65	2008-02-08 06:35:53	2008-02-08 06:37:53	f	0101000020E6100000AC74779D0D3552C00AF9A067B3C84440
2983	65	2008-02-08 06:40:53	2008-02-08 06:42:53	f	0101000020E6100000D04A5AF10D3552C00AF9A067B3C84440
2984	65	2008-02-08 06:45:53	2008-02-08 06:47:53	t	0101000020E61000003BCD02ED0E3552C0C24CDBBFB2C84440
2985	65	2008-02-08 06:50:53	2008-02-08 06:52:53	t	0101000020E610000017F71F990E3552C09F76F86BB2C84440
2986	65	2008-02-08 06:55:53	2008-02-08 06:57:53	t	0101000020E610000017F71F990E3552C07BA01518B2C84440
2987	65	2008-02-08 07:00:53	2008-02-08 07:02:53	t	0101000020E6100000058C2E6F0E3552C09F76F86BB2C84440
2988	65	2008-02-08 07:05:52	2008-02-08 07:07:52	f	0101000020E610000017F71F990E3552C0C24CDBBFB2C84440
2989	65	2008-02-08 07:10:52	2008-02-08 07:12:52	f	0101000020E610000017F71F990E3552C00AF9A067B3C84440
2990	66	2008-02-06 16:33:50	2008-02-06 16:35:50	t	0101000020E6100000A3410A9E422852C09B8F6B43C5EA4440
2991	66	2008-02-06 16:33:55	2008-02-06 16:35:55	t	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
2992	66	2008-02-06 16:34:00	2008-02-06 16:36:00	f	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
2993	66	2008-02-06 16:34:05	2008-02-06 16:36:05	t	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
2994	66	2008-02-06 16:34:10	2008-02-06 16:36:10	f	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
2995	66	2008-02-06 16:34:15	2008-02-06 16:36:15	f	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
2996	66	2008-02-06 16:34:20	2008-02-06 16:36:20	f	0101000020E6100000A3410A9E422852C09B8F6B43C5EA4440
2997	66	2008-02-06 16:34:25	2008-02-06 16:36:25	f	0101000020E6100000A3410A9E422852C09B8F6B43C5EA4440
2998	66	2008-02-06 16:34:30	2008-02-06 16:36:30	t	0101000020E6100000A3410A9E422852C09B8F6B43C5EA4440
2999	66	2008-02-06 16:34:35	2008-02-06 16:36:35	t	0101000020E6100000A3410A9E422852C09B8F6B43C5EA4440
3000	66	2008-02-06 16:34:40	2008-02-06 16:36:40	f	0101000020E6100000A3410A9E422852C0BF654E97C5EA4440
3001	67	2008-02-03 07:48:09	2008-02-03 07:50:09	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3002	67	2008-02-03 07:48:14	2008-02-03 07:50:14	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3003	67	2008-02-03 07:48:19	2008-02-03 07:50:19	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3004	67	2008-02-03 07:48:24	2008-02-03 07:50:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3005	67	2008-02-03 07:48:29	2008-02-03 07:50:29	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3006	67	2008-02-03 07:48:39	2008-02-03 07:50:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3007	67	2008-02-03 07:48:44	2008-02-03 07:50:44	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3008	67	2008-02-03 07:48:49	2008-02-03 07:50:49	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3009	67	2008-02-03 07:48:54	2008-02-03 07:50:54	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3010	67	2008-02-03 07:48:59	2008-02-03 07:50:59	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3011	67	2008-02-03 07:49:04	2008-02-03 07:51:04	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3012	67	2008-02-03 07:49:09	2008-02-03 07:51:09	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3013	67	2008-02-03 07:49:19	2008-02-03 07:51:19	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3014	67	2008-02-03 07:49:24	2008-02-03 07:51:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3015	67	2008-02-03 07:49:34	2008-02-03 07:51:34	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3016	67	2008-02-03 07:49:39	2008-02-03 07:51:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3017	67	2008-02-03 07:49:44	2008-02-03 07:51:44	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3018	67	2008-02-03 07:49:49	2008-02-03 07:51:49	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3019	67	2008-02-03 07:49:54	2008-02-03 07:51:54	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3020	67	2008-02-03 07:49:59	2008-02-03 07:51:59	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3021	67	2008-02-03 07:50:04	2008-02-03 07:52:04	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3022	67	2008-02-03 07:50:09	2008-02-03 07:52:09	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3023	67	2008-02-03 07:50:14	2008-02-03 07:52:14	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3024	67	2008-02-03 07:50:24	2008-02-03 07:52:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3025	67	2008-02-03 07:50:28	2008-02-03 07:52:28	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3026	67	2008-02-03 07:50:34	2008-02-03 07:52:34	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3027	67	2008-02-03 07:50:39	2008-02-03 07:52:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3028	67	2008-02-03 07:50:49	2008-02-03 07:52:49	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3029	67	2008-02-03 07:50:59	2008-02-03 07:52:59	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3030	67	2008-02-03 07:51:04	2008-02-03 07:53:04	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3031	67	2008-02-03 07:51:09	2008-02-03 07:53:09	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3032	67	2008-02-03 07:51:14	2008-02-03 07:53:14	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3033	67	2008-02-03 07:51:19	2008-02-03 07:53:19	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3034	67	2008-02-03 07:51:24	2008-02-03 07:53:24	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3035	67	2008-02-03 07:51:34	2008-02-03 07:53:34	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3036	67	2008-02-03 07:51:39	2008-02-03 07:53:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3037	67	2008-02-03 07:51:44	2008-02-03 07:53:44	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3038	67	2008-02-03 07:51:49	2008-02-03 07:53:49	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3039	67	2008-02-03 07:51:54	2008-02-03 07:53:54	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3040	67	2008-02-03 07:51:59	2008-02-03 07:53:59	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3041	67	2008-02-03 07:52:04	2008-02-03 07:54:04	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3042	67	2008-02-03 07:52:08	2008-02-03 07:54:08	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3043	67	2008-02-03 07:52:14	2008-02-03 07:54:14	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3044	67	2008-02-03 07:52:19	2008-02-03 07:54:19	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3045	67	2008-02-03 07:52:24	2008-02-03 07:54:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3046	67	2008-02-03 07:52:29	2008-02-03 07:54:29	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3047	67	2008-02-03 07:52:34	2008-02-03 07:54:34	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3048	67	2008-02-03 07:52:39	2008-02-03 07:54:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3049	67	2008-02-03 07:52:44	2008-02-03 07:54:44	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3050	67	2008-02-03 07:52:44	2008-02-03 07:54:44	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3051	67	2008-02-03 07:52:49	2008-02-03 07:54:49	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3052	67	2008-02-03 07:52:49	2008-02-03 07:54:49	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3053	67	2008-02-03 07:52:58	2008-02-03 07:54:58	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3054	67	2008-02-03 07:53:09	2008-02-03 07:55:09	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3055	67	2008-02-03 07:53:14	2008-02-03 07:55:14	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3056	67	2008-02-03 07:53:19	2008-02-03 07:55:19	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3057	67	2008-02-03 07:53:24	2008-02-03 07:55:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3058	67	2008-02-03 07:53:34	2008-02-03 07:55:34	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3059	67	2008-02-03 07:53:39	2008-02-03 07:55:39	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3060	67	2008-02-03 07:53:44	2008-02-03 07:55:44	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3061	67	2008-02-03 07:53:48	2008-02-03 07:55:48	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3062	67	2008-02-03 07:54:09	2008-02-03 07:56:09	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3063	67	2008-02-03 07:54:14	2008-02-03 07:56:14	t	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3064	67	2008-02-03 07:54:24	2008-02-03 07:56:24	f	0101000020E6100000E224CD1FD33452C0BA4E232D95C94440
3065	67	2008-02-03 11:55:46	2008-02-03 11:57:46	f	0101000020E6100000D59B51F3553452C0A7AE7C96E7D34440
3066	67	2008-02-03 11:55:52	2008-02-03 11:57:52	t	0101000020E61000009F5A7D75553452C0527E52EDD3D34440
3067	67	2008-02-03 11:55:56	2008-02-03 11:57:56	t	0101000020E61000009F5A7D75553452C0598638D6C5D34440
3068	67	2008-02-03 11:56:02	2008-02-03 11:58:02	f	0101000020E61000009F5A7D75553452C04B02D4D4B2D34440
3069	67	2008-02-03 11:56:06	2008-02-03 11:58:06	f	0101000020E6100000B1C56E9F553452C0CBF3E0EEACD34440
3070	67	2008-02-03 11:56:12	2008-02-03 11:58:12	f	0101000020E6100000C33060C9553452C0A81DFE9AACD34440
3071	67	2008-02-03 11:56:16	2008-02-03 11:58:16	t	0101000020E6100000C33060C9553452C0CBF3E0EEACD34440
3072	67	2008-02-03 11:56:22	2008-02-03 11:58:22	f	0101000020E6100000C33060C9553452C0CBF3E0EEACD34440
3073	67	2008-02-03 11:56:26	2008-02-03 11:58:26	t	0101000020E6100000B1C56E9F553452C084471B47ACD34440
3074	67	2008-02-03 11:56:36	2008-02-03 11:58:36	f	0101000020E61000009F5A7D75553452C084471B47ACD34440
3075	67	2008-02-03 11:56:42	2008-02-03 11:58:42	t	0101000020E61000009F5A7D75553452C0DA3D7958A8D34440
3076	67	2008-02-03 11:56:46	2008-02-03 11:58:46	f	0101000020E61000009F5A7D75553452C0F6D1A92B9FD34440
3077	67	2008-02-03 11:56:52	2008-02-03 11:58:52	t	0101000020E61000009F5A7D75553452C0EF7211DF89D34440
3078	67	2008-02-03 11:56:56	2008-02-03 11:58:56	f	0101000020E61000007C849A21553452C068226C787AD34440
3079	67	2008-02-03 11:57:02	2008-02-03 11:59:02	t	0101000020E61000007C849A21553452C0287E8CB96BD34440
3080	67	2008-02-03 11:57:06	2008-02-03 11:59:06	t	0101000020E61000006A19A9F7543452C0CC457C2766D34440
3081	67	2008-02-03 11:57:12	2008-02-03 11:59:12	t	0101000020E61000007C849A21553452C08599B67F65D34440
3082	67	2008-02-03 11:57:22	2008-02-03 11:59:22	t	0101000020E610000058AEB7CD543452C01A170E8464D34440
3083	67	2008-02-03 11:57:26	2008-02-03 11:59:26	t	0101000020E610000058AEB7CD543452C01A170E8464D34440
3084	67	2008-02-03 11:57:32	2008-02-03 11:59:32	t	0101000020E610000058AEB7CD543452C01A170E8464D34440
3085	67	2008-02-03 11:57:36	2008-02-03 11:59:36	f	0101000020E610000058AEB7CD543452C01A170E8464D34440
3086	67	2008-02-03 11:57:42	2008-02-03 11:59:42	t	0101000020E610000058AEB7CD543452C01A170E8464D34440
3087	67	2008-02-03 11:57:46	2008-02-03 11:59:46	f	0101000020E610000058AEB7CD543452C01A170E8464D34440
3088	67	2008-02-03 11:57:52	2008-02-03 11:59:52	f	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3089	67	2008-02-03 11:57:56	2008-02-03 11:59:56	f	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3090	67	2008-02-03 11:58:02	2008-02-03 12:00:02	f	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3091	67	2008-02-03 11:58:06	2008-02-03 12:00:06	t	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3092	67	2008-02-03 11:58:12	2008-02-03 12:00:12	t	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3093	67	2008-02-03 11:58:16	2008-02-03 12:00:16	t	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3094	67	2008-02-03 11:58:22	2008-02-03 12:00:22	f	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3095	67	2008-02-03 11:58:26	2008-02-03 12:00:26	t	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3096	67	2008-02-03 11:58:32	2008-02-03 12:00:32	t	0101000020E610000058AEB7CD543452C03EEDF0D764D34440
3097	67	2008-02-03 11:58:42	2008-02-03 12:00:42	t	0101000020E61000004743C6A3543452C07732384A5ED34440
3098	67	2008-02-03 11:58:46	2008-02-03 12:00:46	t	0101000020E6100000FF9600FC533452C061A6ED5F59D34440
3099	67	2008-02-03 11:58:52	2008-02-03 12:00:52	t	0101000020E6100000FF9600FC533452C0378E588B4FD34440
3100	67	2008-02-03 11:58:56	2008-02-03 12:00:56	t	0101000020E6100000EE2B0FD2533452C0BEA4315A47D34440
3101	67	2008-02-03 11:59:02	2008-02-03 12:01:02	t	0101000020E6100000236DE34F543452C05A2A6F4738D34440
3102	67	2008-02-03 11:59:06	2008-02-03 12:01:06	f	0101000020E61000001102F225543452C09B94826E2FD34440
3103	68	2008-02-02 18:13:49	2008-02-02 18:15:49	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
3104	67	2008-02-03 11:59:12	2008-02-03 12:01:12	f	0101000020E6100000FF9600FC533452C01444DD0720D34440
3105	67	2008-02-03 11:59:16	2008-02-03 12:01:16	t	0101000020E6100000DCC01DA8533452C0E2067C7E18D34440
3106	67	2008-02-03 11:59:16	2008-02-03 12:01:16	t	0101000020E6100000DCC01DA8533452C0E2067C7E18D34440
3107	67	2008-02-03 12:01:45	2008-02-03 12:03:45	f	0101000020E610000023F94A20253452C023A12DE752D24440
3108	67	2008-02-03 12:01:47	2008-02-03 12:03:47	f	0101000020E6100000EEB776A2243452C0E31934F44FD24440
3109	67	2008-02-03 12:01:51	2008-02-03 12:03:51	f	0101000020E6100000EEB776A2243452C0EA3E00A94DD24440
3110	67	2008-02-03 12:01:57	2008-02-03 12:03:57	f	0101000020E6100000EEB776A2243452C0F988981249D24440
3111	67	2008-02-03 12:02:01	2008-02-03 12:04:01	f	0101000020E6100000128E59F6243452C0B9019F1F46D24440
3112	67	2008-02-03 12:02:07	2008-02-03 12:04:07	f	0101000020E6100000002368CC243452C0F246E6913FD24440
3113	67	2008-02-03 12:02:21	2008-02-03 12:04:21	f	0101000020E6100000DC4C8578243452C0C72E51BD35D24440
3114	67	2008-02-03 12:02:41	2008-02-03 12:04:41	f	0101000020E6100000002368CC243452C0D578E92631D24440
3115	67	2008-02-03 12:02:47	2008-02-03 12:04:47	t	0101000020E6100000002368CC243452C0D578E92631D24440
3116	67	2008-02-03 12:02:51	2008-02-03 12:04:51	t	0101000020E610000023F94A20253452C00074982F2FD24440
3117	67	2008-02-03 12:02:57	2008-02-03 12:04:57	f	0101000020E610000023F94A20253452C05C8FC2F528D24440
3118	67	2008-02-03 12:03:01	2008-02-03 12:05:01	f	0101000020E6100000128E59F6243452C0D55B035B25D24440
3119	67	2008-02-03 12:03:07	2008-02-03 12:05:07	t	0101000020E6100000128E59F6243452C0C7F484251ED24440
3120	67	2008-02-03 12:03:11	2008-02-03 12:05:11	f	0101000020E6100000002368CC243452C02410AFEB17D24440
3121	67	2008-02-03 12:10:25	2008-02-03 12:12:25	f	0101000020E6100000D22346CF2D3452C0CCD1E3F736CF4440
3122	67	2008-02-03 12:10:26	2008-02-03 12:12:26	t	0101000020E6100000D22346CF2D3452C0D3F6AFAC34CF4440
3123	67	2008-02-03 12:10:32	2008-02-03 12:12:32	f	0101000020E61000005536ACA92C3452C03E5C72DC29CF4440
3124	67	2008-02-03 12:10:36	2008-02-03 12:12:36	f	0101000020E6100000B5722F302B3452C029D027F224CF4440
3125	67	2008-02-03 12:10:42	2008-02-03 12:12:42	f	0101000020E610000075EB353D283452C062156F641ECF4440
3126	67	2008-02-03 12:10:46	2008-02-03 12:12:46	f	0101000020E610000007483481223452C01B69A9BC1DCF4440
3127	67	2008-02-03 12:10:52	2008-02-03 12:12:52	t	0101000020E61000009583D904183452C0FEB7921D1BCF4440
3128	67	2008-02-03 12:10:56	2008-02-03 12:12:56	f	0101000020E61000003C6C2233173452C0B70BCD751ACF4440
3129	67	2008-02-03 12:11:02	2008-02-03 12:13:02	t	0101000020E6100000E3546B61163452C09435EA211ACF4440
3130	67	2008-02-03 12:11:06	2008-02-03 12:13:06	f	0101000020E61000005C21ACC6123452C0705F07CE19CF4440
3131	67	2008-02-03 12:11:06	2008-02-03 12:13:06	f	0101000020E61000005C21ACC6123452C0705F07CE19CF4440
3132	67	2008-02-03 12:11:12	2008-02-03 12:13:12	t	0101000020E610000055DFF945093452C005DD5ED218CF4440
3133	67	2008-02-03 12:11:16	2008-02-03 12:13:16	t	0101000020E6100000EE60C43E013452C0BE30992A18CF4440
3134	67	2008-02-03 12:11:22	2008-02-03 12:13:22	f	0101000020E610000000AFCF9CF53352C07784D38217CF4440
3135	67	2008-02-03 12:11:26	2008-02-03 12:13:26	t	0101000020E6100000CE716E13EE3352C07784D38217CF4440
3136	67	2008-02-03 12:11:42	2008-02-03 12:13:42	f	0101000020E6100000EFEC2B0FD23352C005DD5ED218CF4440
3137	67	2008-02-03 12:11:46	2008-02-03 12:13:46	f	0101000020E6100000FD36C478CD3352C029B3412619CF4440
3138	67	2008-02-03 12:11:52	2008-02-03 12:13:52	f	0101000020E6100000C0B33D7AC33352C0DBE1AFC91ACF4440
3139	67	2008-02-03 12:12:02	2008-02-03 12:14:02	f	0101000020E6100000967EC2D9AD3352C0DBE1AFC91ACF4440
3140	67	2008-02-03 12:12:06	2008-02-03 12:14:06	t	0101000020E6100000738BF9B9A13352C0693A3B191CCF4440
3141	67	2008-02-05 02:46:34	2008-02-05 02:48:34	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3142	67	2008-02-05 02:46:39	2008-02-05 02:48:39	f	0101000020E61000002810768A553352C0AC90F2936ACD4440
3143	67	2008-02-05 02:46:44	2008-02-05 02:48:44	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3144	67	2008-02-05 02:46:49	2008-02-05 02:48:49	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3145	67	2008-02-05 02:46:54	2008-02-05 02:48:54	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3146	67	2008-02-05 02:46:59	2008-02-05 02:48:59	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3147	67	2008-02-05 02:47:09	2008-02-05 02:49:09	f	0101000020E61000002810768A553352C0AC90F2936ACD4440
3148	67	2008-02-05 02:47:14	2008-02-05 02:49:14	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3149	67	2008-02-05 02:47:19	2008-02-05 02:49:19	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3150	67	2008-02-05 02:47:24	2008-02-05 02:49:24	t	0101000020E61000002810768A553352C0AC90F2936ACD4440
3151	67	2008-02-05 02:47:29	2008-02-05 02:49:29	f	0101000020E61000002810768A553352C0AC90F2936ACD4440
3152	67	2008-02-07 10:28:20	2008-02-07 10:30:20	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3153	67	2008-02-07 10:28:24	2008-02-07 10:30:24	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3154	67	2008-02-07 10:28:30	2008-02-07 10:30:30	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3155	67	2008-02-07 10:28:34	2008-02-07 10:30:34	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3156	67	2008-02-07 10:28:40	2008-02-07 10:30:40	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3157	67	2008-02-07 10:28:44	2008-02-07 10:30:44	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3158	67	2008-02-07 10:28:44	2008-02-07 10:30:44	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3159	67	2008-02-07 10:28:50	2008-02-07 10:30:50	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3160	67	2008-02-07 10:28:50	2008-02-07 10:30:50	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3161	67	2008-02-07 10:28:54	2008-02-07 10:30:54	f	0101000020E610000097B377465B3352C0503BFC3559CD4440
3162	67	2008-02-07 10:29:00	2008-02-07 10:31:00	t	0101000020E610000097B377465B3352C0503BFC3559CD4440
3163	67	2008-02-07 10:29:04	2008-02-07 10:31:04	f	0101000020E610000097B377465B3352C0503BFC3559CD4440
3164	67	2008-02-07 10:29:10	2008-02-07 10:31:10	t	0101000020E610000097B377465B3352C0503BFC3559CD4440
3165	67	2008-02-07 10:29:14	2008-02-07 10:31:14	f	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3166	67	2008-02-07 10:29:20	2008-02-07 10:31:20	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3167	67	2008-02-07 10:29:24	2008-02-07 10:31:24	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3168	67	2008-02-07 10:29:30	2008-02-07 10:31:30	f	0101000020E610000097B377465B3352C0503BFC3559CD4440
3169	67	2008-02-07 10:29:34	2008-02-07 10:31:34	t	0101000020E610000097B377465B3352C0503BFC3559CD4440
3170	67	2008-02-07 10:29:40	2008-02-07 10:31:40	t	0101000020E6100000A81E69705B3352C0503BFC3559CD4440
3171	67	2008-02-07 10:29:44	2008-02-07 10:31:44	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3172	67	2008-02-07 10:29:50	2008-02-07 10:31:50	f	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3173	67	2008-02-07 10:30:00	2008-02-07 10:32:00	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3174	67	2008-02-07 10:30:10	2008-02-07 10:32:10	f	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3175	67	2008-02-07 10:30:30	2008-02-07 10:32:30	t	0101000020E6100000BA895A9A5B3352C0088F368E58CD4440
3176	67	2008-02-07 10:30:34	2008-02-07 10:32:34	t	0101000020E6100000BA895A9A5B3352C0088F368E58CD4440
3177	67	2008-02-07 10:30:40	2008-02-07 10:32:40	t	0101000020E6100000BA895A9A5B3352C0088F368E58CD4440
3178	67	2008-02-07 10:30:44	2008-02-07 10:32:44	t	0101000020E6100000BA895A9A5B3352C02C6519E258CD4440
3179	67	2008-02-07 10:30:50	2008-02-07 10:32:50	f	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3180	67	2008-02-07 10:30:54	2008-02-07 10:32:54	f	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3181	67	2008-02-07 10:31:00	2008-02-07 10:33:00	f	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3182	67	2008-02-07 10:31:04	2008-02-07 10:33:04	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3183	67	2008-02-07 10:31:10	2008-02-07 10:33:10	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3184	67	2008-02-07 10:31:14	2008-02-07 10:33:14	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3185	67	2008-02-07 10:31:20	2008-02-07 10:33:20	t	0101000020E6100000A81E69705B3352C02C6519E258CD4440
3186	67	2008-02-07 10:31:24	2008-02-07 10:33:24	t	0101000020E6100000013620425C3352C0BABDA4315ACD4440
3187	67	2008-02-07 10:31:34	2008-02-07 10:33:34	t	0101000020E61000003777F4BF5C3352C090C2F5285CCD4440
3188	67	2008-02-07 10:31:40	2008-02-07 10:33:40	f	0101000020E6100000250C03965C3352C0B398D87C5CCD4440
3189	67	2008-02-07 10:31:44	2008-02-07 10:33:44	f	0101000020E610000013A1116C5C3352C0481630815BCD4440
3190	67	2008-02-07 10:31:50	2008-02-07 10:33:50	t	0101000020E6100000EFCA2E185C3352C07311DF8959CD4440
3191	67	2008-02-07 10:32:10	2008-02-07 10:34:10	t	0101000020E6100000013620425C3352C0503BFC3559CD4440
3192	67	2008-02-07 10:32:14	2008-02-07 10:34:14	f	0101000020E6100000013620425C3352C0503BFC3559CD4440
3193	67	2008-02-07 10:32:24	2008-02-07 10:34:24	f	0101000020E610000013A1116C5C3352C02C6519E258CD4440
3194	67	2008-02-07 10:32:30	2008-02-07 10:34:30	f	0101000020E610000013A1116C5C3352C02C6519E258CD4440
3195	67	2008-02-07 10:32:34	2008-02-07 10:34:34	f	0101000020E610000013A1116C5C3352C0088F368E58CD4440
3196	67	2008-02-07 10:32:40	2008-02-07 10:34:40	f	0101000020E610000013A1116C5C3352C0088F368E58CD4440
3197	67	2008-02-07 10:32:44	2008-02-07 10:34:44	t	0101000020E6100000250C03965C3352C0088F368E58CD4440
3198	67	2008-02-07 10:32:50	2008-02-07 10:34:50	f	0101000020E610000013A1116C5C3352C0E5B8533A58CD4440
3199	67	2008-02-07 10:32:54	2008-02-07 10:34:54	f	0101000020E610000013A1116C5C3352C0E5B8533A58CD4440
3200	67	2008-02-07 10:33:00	2008-02-07 10:35:00	t	0101000020E610000013A1116C5C3352C0C1E270E657CD4440
3201	67	2008-02-07 10:33:04	2008-02-07 10:35:04	t	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3202	67	2008-02-07 10:33:10	2008-02-07 10:35:10	t	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3203	67	2008-02-07 10:33:14	2008-02-07 10:35:14	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3204	67	2008-02-07 10:33:20	2008-02-07 10:35:20	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3205	67	2008-02-07 10:33:24	2008-02-07 10:35:24	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3206	67	2008-02-07 10:33:30	2008-02-07 10:35:30	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3207	67	2008-02-07 10:33:34	2008-02-07 10:35:34	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3208	67	2008-02-07 10:33:40	2008-02-07 10:35:40	t	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3209	67	2008-02-07 10:33:40	2008-02-07 10:35:40	t	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3210	67	2008-02-07 10:33:50	2008-02-07 10:35:50	t	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3211	67	2008-02-07 10:33:54	2008-02-07 10:35:54	f	0101000020E610000013A1116C5C3352C0C1E270E657CD4440
3212	67	2008-02-07 10:34:00	2008-02-07 10:36:00	f	0101000020E610000013A1116C5C3352C0C1E270E657CD4440
3213	67	2008-02-07 10:34:04	2008-02-07 10:36:04	f	0101000020E610000013A1116C5C3352C0C1E270E657CD4440
3214	67	2008-02-07 10:34:10	2008-02-07 10:36:10	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3215	67	2008-02-07 10:34:14	2008-02-07 10:36:14	f	0101000020E610000013A1116C5C3352C09E0C8E9257CD4440
3216	67	2008-02-07 10:47:04	2008-02-07 10:49:04	f	0101000020E61000004CE658DE553352C04F58E20165CD4440
3217	67	2008-02-07 10:47:10	2008-02-07 10:49:10	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3218	67	2008-02-07 10:47:14	2008-02-07 10:49:14	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3219	67	2008-02-07 10:47:20	2008-02-07 10:49:20	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3220	67	2008-02-07 10:47:24	2008-02-07 10:49:24	f	0101000020E61000004CE658DE553352C04F58E20165CD4440
3221	67	2008-02-07 10:47:30	2008-02-07 10:49:30	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3222	67	2008-02-07 10:47:34	2008-02-07 10:49:34	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3223	67	2008-02-07 10:47:40	2008-02-07 10:49:40	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3224	67	2008-02-07 10:47:44	2008-02-07 10:49:44	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3225	67	2008-02-07 10:47:50	2008-02-07 10:49:50	t	0101000020E61000004CE658DE553352C04F58E20165CD4440
3226	67	2008-02-07 10:47:54	2008-02-07 10:49:54	f	0101000020E61000004CE658DE553352C04F58E20165CD4440
3227	67	2008-02-08 10:53:45	2008-02-08 10:55:45	t	0101000020E610000003D53F88643A52C06F9EEA909BCB4440
3228	67	2008-02-08 10:53:49	2008-02-08 10:55:49	f	0101000020E6100000F1694E5E643A52C0EF7211DF89CB4440
3229	67	2008-02-08 10:53:55	2008-02-08 10:55:55	t	0101000020E6100000CE936B0A643A52C0774F1E166ACB4440
3230	67	2008-02-08 10:53:59	2008-02-08 10:55:59	t	0101000020E6100000BC287AE0633A52C0BEDEFDF15ECB4440
3231	67	2008-02-08 10:54:05	2008-02-08 10:56:05	t	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3232	67	2008-02-08 10:54:09	2008-02-08 10:56:09	t	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3233	67	2008-02-08 10:54:15	2008-02-08 10:56:15	f	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3234	67	2008-02-08 10:54:19	2008-02-08 10:56:19	t	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3235	67	2008-02-08 10:54:25	2008-02-08 10:56:25	t	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3236	67	2008-02-08 10:54:29	2008-02-08 10:56:29	t	0101000020E6100000CE936B0A643A52C07E5704FF5BCB4440
3237	67	2008-02-08 10:54:35	2008-02-08 10:56:35	f	0101000020E610000051A6D1E4623A52C0378E588B4FCB4440
3238	67	2008-02-08 10:54:39	2008-02-08 10:56:39	f	0101000020E610000051A6D1E4623A52C05A643BDF4FCB4440
3239	67	2008-02-08 10:54:45	2008-02-08 10:56:45	f	0101000020E6100000F1694E5E643A52C0535C55F65DCB4440
3240	67	2008-02-08 10:54:49	2008-02-08 10:56:49	f	0101000020E6100000DFFE5C34643A52C0535C55F65DCB4440
3241	67	2008-02-08 10:54:55	2008-02-08 10:56:55	f	0101000020E6100000CE936B0A643A52C068CBB91457CB4440
3242	67	2008-02-08 10:54:59	2008-02-08 10:56:59	t	0101000020E610000086E7A562633A52C0855FEAE74DCB4440
3243	67	2008-02-08 10:55:05	2008-02-08 10:57:05	f	0101000020E61000002ED0EE90623A52C0137EA99F37CB4440
3244	67	2008-02-08 10:55:09	2008-02-08 10:57:09	t	0101000020E61000001C65FD66623A52C029D027F224CB4440
3245	67	2008-02-08 10:55:15	2008-02-08 10:57:15	f	0101000020E6100000F88E1A13623A52C0DBC4C9FD0ECB4440
3246	67	2008-02-08 10:55:19	2008-02-08 10:57:19	t	0101000020E6100000E72329E9613A52C029965B5A0DCB4440
3247	67	2008-02-08 10:55:25	2008-02-08 10:57:25	f	0101000020E6100000D5B837BF613A52C005C078060DCB4440
3248	67	2008-02-08 10:55:45	2008-02-08 10:57:45	t	0101000020E6100000D5B837BF613A52C005C078060DCB4440
3249	67	2008-02-08 10:56:15	2008-02-08 10:58:15	f	0101000020E61000009F776341613A52C0DBA7E33103CB4440
3250	67	2008-02-08 10:56:45	2008-02-08 10:58:45	t	0101000020E61000005FF0694E5E3A52C0EACF7EA488CA4440
3251	67	2008-02-08 10:56:49	2008-02-08 10:58:49	t	0101000020E61000002AAF95D05D3A52C01CD3139678CA4440
3252	67	2008-02-08 10:56:55	2008-02-08 10:58:55	f	0101000020E61000001844A4A65D3A52C047B1DCD26ACA4440
3253	67	2008-02-08 10:56:59	2008-02-08 10:58:59	t	0101000020E61000001844A4A65D3A52C0072AE3DF67CA4440
3254	67	2008-02-08 10:57:05	2008-02-08 10:59:05	f	0101000020E61000003C1A87FA5D3A52C0EA78CC4065CA4440
3255	67	2008-02-08 10:57:09	2008-02-08 10:59:09	t	0101000020E61000003C1A87FA5D3A52C06A6AD95A5FCA4440
3256	67	2008-02-08 10:57:15	2008-02-08 10:59:15	f	0101000020E6100000E302D0285D3A52C09C6D6E4C4FCA4440
3257	67	2008-02-08 10:57:19	2008-02-08 10:59:19	f	0101000020E6100000AEC1FBAA5C3A52C0151DC9E53FCA4440
3258	67	2008-02-08 10:57:25	2008-02-08 10:59:25	f	0101000020E61000007880272D5C3A52C0CE3637A627CA4440
3259	67	2008-02-08 10:57:29	2008-02-08 10:59:29	f	0101000020E61000008AEB18575C3A52C0B2683A3B19CA4440
3260	67	2008-02-08 10:57:35	2008-02-08 10:59:35	f	0101000020E61000007880272D5C3A52C0C7BAB88D06CA4440
3261	67	2008-02-08 10:57:39	2008-02-08 10:59:39	f	0101000020E6100000671536035C3A52C01D9430D3F6C94440
3262	67	2008-02-08 10:57:45	2008-02-08 10:59:45	f	0101000020E610000031D461855B3A52C0C05B2041F1C94440
3263	67	2008-02-08 10:57:49	2008-02-08 10:59:49	t	0101000020E6100000E302D0285D3A52C056D97745F0C94440
3264	67	2008-02-08 10:57:55	2008-02-08 10:59:55	f	0101000020E610000051A6D1E4623A52C0C05B2041F1C94440
3265	67	2008-02-08 10:57:59	2008-02-08 10:59:59	f	0101000020E610000066321CCF673A52C0E4310395F1C94440
3266	67	2008-02-08 10:58:19	2008-02-08 11:00:19	f	0101000020E6100000511A6A14923A52C05DFE43FAEDC94440
3267	67	2008-02-08 10:58:25	2008-02-08 11:00:25	t	0101000020E6100000DF8FDB2F9F3A52C080D4264EEEC94440
3268	67	2008-02-08 10:58:29	2008-02-08 11:00:29	t	0101000020E610000058790261A73A52C080D4264EEEC94440
3269	67	2008-02-08 10:58:35	2008-02-08 11:00:35	t	0101000020E61000006A01DA56B33A52C0C780ECF5EEC94440
3270	67	2008-02-08 10:58:39	2008-02-08 11:00:39	t	0101000020E6100000182CD505BC3A52C024B9FC87F4C94440
3271	67	2008-02-08 10:58:45	2008-02-08 11:00:45	t	0101000020E6100000182CD505BC3A52C024B9FC87F4C94440
3272	67	2008-02-08 10:58:49	2008-02-08 11:00:49	t	0101000020E6100000518E0244C13A52C08E3BA583F5C94440
3273	67	2008-02-08 10:58:55	2008-02-08 11:00:55	t	0101000020E61000000D03965CC53A52C0C05B2041F1C94440
3274	67	2008-02-08 10:58:59	2008-02-08 11:00:59	f	0101000020E61000000D03965CC53A52C0C05B2041F1C94440
3275	67	2008-02-08 10:59:05	2008-02-08 11:01:05	t	0101000020E61000000D03965CC53A52C09D853DEDF0C94440
3276	67	2008-02-08 10:59:09	2008-02-08 11:01:09	t	0101000020E61000000D03965CC53A52C09D853DEDF0C94440
3277	67	2008-02-08 10:59:15	2008-02-08 11:01:15	t	0101000020E61000001F6E8786C53A52C09D853DEDF0C94440
3278	67	2008-02-08 10:59:19	2008-02-08 11:01:19	f	0101000020E61000001F6E8786C53A52C09D853DEDF0C94440
3279	67	2008-02-08 10:59:25	2008-02-08 11:01:25	t	0101000020E61000001F6E8786C53A52C09D853DEDF0C94440
3280	67	2008-02-08 10:59:29	2008-02-08 11:01:29	t	0101000020E61000009015FC36C43A52C079AF5A99F0C94440
3281	67	2008-02-08 10:59:35	2008-02-08 11:01:35	t	0101000020E61000009B3E3BE0BA3A52C056D97745F0C94440
3282	67	2008-02-08 10:59:39	2008-02-08 11:01:39	t	0101000020E6100000B1AD9FFEB33A52C056D97745F0C94440
3283	67	2008-02-08 10:59:45	2008-02-08 11:01:45	t	0101000020E6100000782E8CF4A23A52C00F2DB29DEFC94440
3284	67	2008-02-08 10:59:49	2008-02-08 11:01:49	t	0101000020E61000003BAB05F6983A52C0EB56CF49EFC94440
3285	67	2008-02-08 10:59:55	2008-02-08 11:01:55	f	0101000020E6100000EA9B340D8A3A52C05DFE43FAEDC94440
3286	67	2008-02-08 10:59:59	2008-02-08 11:01:59	t	0101000020E6100000666CE8667F3A52C0C780ECF5EEC94440
3287	67	2008-02-08 11:00:05	2008-02-08 11:02:05	f	0101000020E6100000AADA6E826F3A52C096607138F3C94440
3288	67	2008-02-08 11:00:09	2008-02-08 11:02:09	f	0101000020E6100000C66E9F55663A52C0DD0C37E0F3C94440
3289	67	2008-02-08 11:00:15	2008-02-08 11:02:15	f	0101000020E6100000238AC91B603A52C024B9FC87F4C94440
3290	67	2008-02-08 11:00:19	2008-02-08 11:02:19	t	0101000020E6100000715B5B785E3A52C024B9FC87F4C94440
3291	69	2008-02-05 18:46:31	2008-02-05 18:48:31	t	0101000020E61000008E2958E36C3852C001A4367172E54440
3292	69	2008-02-05 18:50:57	2008-02-05 18:52:57	f	0101000020E6100000DDD8EC48F53752C047ACC5A700E64440
3293	69	2008-02-05 18:55:58	2008-02-05 18:57:58	f	0101000020E61000006CB8C83D5D3752C0736891ED7CE54440
3294	69	2008-02-05 18:56:35	2008-02-05 18:58:35	t	0101000020E61000005A4DD7135D3752C09E465A2A6FE54440
3295	69	2008-02-05 19:01:36	2008-02-05 19:03:36	f	0101000020E61000003260C9552C3852C0F69CF4BEF1E74440
3296	69	2008-02-05 19:06:02	2008-02-05 19:08:02	t	0101000020E61000004C72C0AE263752C071E6577380E64440
3297	69	2008-02-05 19:06:38	2008-02-05 19:08:38	t	0101000020E6100000C53E0114233752C00DC347C494E64440
3298	69	2008-02-05 19:11:03	2008-02-05 19:13:03	f	0101000020E6100000030F0C207C3652C09AB67F65A5E74440
3299	69	2008-02-05 19:11:40	2008-02-05 19:13:40	t	0101000020E610000026E5EE737C3652C061545227A0E74440
3300	69	2008-02-05 19:16:05	2008-02-05 19:18:05	f	0101000020E6100000BDCCB051D63752C0C39E76F86BE84440
3301	69	2008-02-05 19:16:41	2008-02-05 19:18:41	t	0101000020E6100000440070ECD93752C0FCE3BD6A65E84440
3302	70	2008-02-02 14:16:23	2008-02-02 14:18:23	f	0101000020E6100000DDBB067DE93752C0624F3BFC35D34440
3303	70	2008-02-02 14:21:23	2008-02-02 14:23:23	f	0101000020E610000059A9A0A2EA3752C0CCD1E3F736D34440
3304	70	2008-02-02 14:31:23	2008-02-02 14:33:23	f	0101000020E610000084A44FABE83752C0C5AC174339D34440
3305	70	2008-02-02 14:36:23	2008-02-02 14:38:23	t	0101000020E610000072395E81E83752C0BE874B8E3BD34440
3306	70	2008-02-02 14:41:23	2008-02-02 14:43:23	f	0101000020E6100000DDBB067DE93752C0D3F6AFAC34D34440
3307	70	2008-02-02 14:51:23	2008-02-02 14:53:23	f	0101000020E6100000DDBB067DE93752C0C5AC174339D34440
3308	70	2008-02-02 14:56:23	2008-02-02 14:58:23	f	0101000020E6100000A77A32FFE83752C0F7CC920035D34440
3309	70	2008-02-02 15:06:23	2008-02-02 15:08:23	f	0101000020E6100000960F41D5E83752C0F7CC920035D34440
3310	70	2008-02-02 15:11:23	2008-02-02 15:13:23	f	0101000020E61000000EF96706F13752C09352D0ED25D34440
3311	70	2008-02-02 15:16:23	2008-02-02 15:18:23	f	0101000020E610000060CE6C57E83752C0DA1B7C6132D34440
3312	70	2008-02-02 15:21:23	2008-02-02 15:23:23	t	0101000020E610000060CE6C57E83752C08C4AEA0434D34440
3313	70	2008-02-02 15:26:23	2008-02-02 15:28:23	f	0101000020E61000002B8D98D9E73752C01AA3755435D34440
3314	70	2008-02-02 15:31:23	2008-02-02 15:33:23	t	0101000020E610000084A44FABE83752C0936FB6B931D34440
3315	70	2008-02-02 15:36:23	2008-02-02 15:38:23	t	0101000020E61000003DF88903E83752C022C8410933D34440
3316	70	2008-02-02 15:36:23	2008-02-02 15:38:23	f	0101000020E61000003DF88903E83752C022C8410933D34440
3317	70	2008-02-02 15:41:23	2008-02-02 15:43:23	f	0101000020E6100000A77A32FFE83752C0FEF15EB532D34440
3318	70	2008-02-02 15:51:23	2008-02-02 15:53:23	f	0101000020E610000007B7B585E73752C0459E245D33D34440
3319	70	2008-02-02 15:56:23	2008-02-02 15:58:23	f	0101000020E610000072395E81E83752C0F7CC920035D34440
3320	70	2008-02-02 16:01:22	2008-02-02 16:03:22	t	0101000020E6100000DDBB067DE93752C03E7958A835D34440
3321	70	2008-02-02 16:06:22	2008-02-02 16:08:22	f	0101000020E6100000CB501553E93752C05A2A6F4738D34440
3322	70	2008-02-02 16:11:23	2008-02-02 16:13:23	t	0101000020E610000036D3BD4EEA3752C0A2D634EF38D34440
3323	70	2008-02-02 16:16:22	2008-02-02 16:18:22	t	0101000020E61000002468CC24EA3752C0E982FA9639D34440
3324	70	2008-02-02 16:21:22	2008-02-02 16:23:22	f	0101000020E6100000EE26F8A6E93752C05305A3923AD34440
3325	70	2008-02-02 16:26:22	2008-02-02 16:28:22	t	0101000020E610000060CE6C57E83752C0302FC03E3AD34440
3326	70	2008-02-02 16:31:22	2008-02-02 16:33:22	t	0101000020E61000002468CC24EA3752C0BE874B8E3BD34440
3327	70	2008-02-02 16:36:22	2008-02-02 16:38:22	t	0101000020E61000004E637B2DE83752C0BE874B8E3BD34440
3328	70	2008-02-02 16:41:22	2008-02-02 16:43:22	t	0101000020E6100000F64BC45BE73752C05305A3923AD34440
3329	70	2008-02-02 16:46:22	2008-02-02 16:48:22	f	0101000020E6100000A77A32FFE83752C0290AF4893CD34440
3330	70	2008-02-02 16:51:22	2008-02-02 16:53:22	t	0101000020E61000000092E9D0E93752C0616C21C841D34440
3331	70	2008-02-02 16:56:22	2008-02-02 16:58:22	t	0101000020E61000009D340D8AE63752C0053411363CD34440
3332	70	2008-02-02 17:00:52	2008-02-02 17:02:52	t	0101000020E6100000AE9FFEB3E63752C00C59DDEA39D34440
3333	70	2008-02-02 17:01:12	2008-02-02 17:03:12	f	0101000020E6100000AE9FFEB3E63752C00C59DDEA39D34440
3334	70	2008-02-02 17:06:22	2008-02-02 17:08:22	t	0101000020E61000002B8D98D9E73752C0697407B133D34440
3335	70	2008-02-02 17:11:22	2008-02-02 17:13:22	t	0101000020E610000060CE6C57E83752C08C4AEA0434D34440
3336	70	2008-02-02 17:16:22	2008-02-02 17:18:22	t	0101000020E610000012FDDAFAE93752C0459E245D33D34440
3337	70	2008-02-02 17:21:22	2008-02-02 17:23:22	f	0101000020E610000060CE6C57E83752C08C4AEA0434D34440
3338	70	2008-02-02 17:26:22	2008-02-02 17:28:22	f	0101000020E61000000092E9D0E93752C0FEF15EB532D34440
3339	70	2008-02-02 17:31:22	2008-02-02 17:33:22	f	0101000020E610000036D3BD4EEA3752C0DA1B7C6132D34440
3340	70	2008-02-02 17:36:22	2008-02-02 17:38:22	t	0101000020E6100000B9E52329E93752C022C8410933D34440
3341	70	2008-02-02 17:46:22	2008-02-02 17:48:22	f	0101000020E610000060CE6C57E83752C08C4AEA0434D34440
3342	70	2008-02-02 17:51:22	2008-02-02 17:53:22	t	0101000020E6100000070E68E90A3852C0D313967840D34440
3343	70	2008-02-02 17:52:21	2008-02-02 17:54:21	f	0101000020E6100000568847E2E53752C04C1AA37554D34440
3344	70	2008-02-02 18:21:32	2008-02-02 18:23:32	t	0101000020E6100000D1622992AF2E52C0849ECDAACFD34440
3345	70	2008-02-02 18:36:11	2008-02-02 18:38:11	f	0101000020E6100000D73A71395E2F52C0BA313D6189D54440
3346	70	2008-02-02 18:42:04	2008-02-02 18:44:04	f	0101000020E6100000CF328B506C2F52C0744694F606D54440
3347	70	2008-02-02 18:46:10	2008-02-02 18:48:10	t	0101000020E6100000E4FDB8FDF22F52C0A071E14048D44440
3348	70	2008-02-02 18:51:10	2008-02-02 18:53:10	f	0101000020E6100000C5094CA7752F52C03DD52137C3D34440
3349	70	2008-02-02 18:56:10	2008-02-02 18:58:10	t	0101000020E61000002125766D6F2F52C0EA263108ACD24440
3350	70	2008-02-02 19:01:10	2008-02-02 19:03:10	t	0101000020E6100000249D8191972F52C0967840D994D14440
3351	70	2008-02-02 19:06:10	2008-02-02 19:08:10	f	0101000020E6100000B3BB4049812F52C00A68226C78D04440
3352	70	2008-02-02 20:49:28	2008-02-02 20:51:28	t	0101000020E6100000F66393FC882152C08B71FE2614D44440
3353	70	2008-02-02 20:54:28	2008-02-02 20:56:28	f	0101000020E61000002BFC19DEAC2152C0DFFDF15EB5D44440
3354	70	2008-02-02 20:59:28	2008-02-02 21:01:28	t	0101000020E6100000C639EAE8B82252C07BBDFBE3BDD44440
3355	70	2008-02-02 21:09:28	2008-02-02 21:11:28	f	0101000020E6100000D9F15F20082452C06C26DF6C73D54440
3356	70	2008-02-02 21:14:28	2008-02-02 21:16:28	t	0101000020E61000004B42226DE32552C064AF777FBCD54440
3357	70	2008-02-02 21:19:28	2008-02-02 21:21:28	t	0101000020E6100000DF205A2BDA2652C0EB39E97DE3D54440
3358	70	2008-02-02 21:24:28	2008-02-02 21:26:28	t	0101000020E6100000FD19DEACC12752C05D38109205D64440
3359	70	2008-02-02 21:24:28	2008-02-02 21:26:28	f	0101000020E6100000FD19DEACC12752C05D38109205D64440
3360	70	2008-02-02 21:29:28	2008-02-02 21:31:28	f	0101000020E6100000F893313ECC2852C09D685721E5D54440
3361	70	2008-02-02 21:34:28	2008-02-02 21:36:28	f	0101000020E610000042D5E8D5002B52C0726DA818E7D54440
3362	70	2008-02-02 21:39:28	2008-02-02 21:41:28	f	0101000020E61000008A25E5EE732C52C041BCAE5FB0D54440
3363	70	2008-02-02 21:44:28	2008-02-02 21:46:28	t	0101000020E610000088FA5DD89A2D52C002F1BA7EC1D44440
3364	70	2008-02-02 21:49:28	2008-02-02 21:51:28	t	0101000020E6100000D1622992AF2E52C0CBA145B6F3D34440
3365	70	2008-02-02 21:50:50	2008-02-02 21:52:50	f	0101000020E610000030F65E7CD12E52C06F1283C0CAD34440
3366	71	2008-02-04 14:45:07	2008-02-04 14:47:07	t	0101000020E6100000FB62EFC5172352C0079964E42CDA4440
3367	71	2008-02-04 14:50:07	2008-02-04 14:52:07	t	0101000020E6100000BEFC4E93192352C0C7D79E5912DA4440
3368	71	2008-02-04 14:55:07	2008-02-04 14:57:07	f	0101000020E6100000BEFC4E93192352C0C7D79E5912DA4440
3369	71	2008-02-04 15:00:07	2008-02-04 15:02:07	f	0101000020E6100000BEFC4E93192352C0F180B22957DA4440
3370	71	2008-02-04 15:05:07	2008-02-04 15:07:07	f	0101000020E6100000BEFC4E93192352C0F180B22957DA4440
3371	71	2008-02-04 15:10:07	2008-02-04 15:12:07	t	0101000020E61000000288BB7A152352C06A1327F73BDA4440
3372	71	2008-02-04 15:15:07	2008-02-04 15:17:07	f	0101000020E6100000702BBD361B2352C00E15E3FC4DDA4440
3373	71	2008-02-04 15:20:07	2008-02-04 15:22:07	t	0101000020E61000001E39D219182352C05CE674594CDA4440
3374	71	2008-02-04 15:25:07	2008-02-04 15:27:07	t	0101000020E6100000537AA697182352C055C1A8A44EDA4440
3375	71	2008-02-04 15:35:07	2008-02-04 15:37:07	f	0101000020E61000009B266C3F192352C09548A29751DA4440
3376	71	2008-02-04 15:40:07	2008-02-04 15:42:07	f	0101000020E6100000BEFC4E93192352C000CB4A9352DA4440
3377	72	2008-02-04 21:44:11	2008-02-04 21:46:11	f	0101000020E610000033E719FB922D52C00AF9A067B3D84440
3378	72	2008-02-04 21:54:11	2008-02-04 21:56:11	t	0101000020E61000002E793C2D3F3252C034F44F70B1E04440
3379	72	2008-02-04 21:54:11	2008-02-04 21:56:11	f	0101000020E61000002E793C2D3F3252C034F44F70B1E04440
3380	72	2008-02-04 21:59:10	2008-02-04 22:01:10	t	0101000020E6100000EEF1423A3C3252C09B38B9DFA1E24440
3381	72	2008-02-04 22:04:10	2008-02-04 22:06:10	t	0101000020E61000002AE96168753252C0658D7A8846E14440
3382	72	2008-02-04 22:09:10	2008-02-04 22:11:10	f	0101000020E610000068B96C74CE3152C0E78C28ED0DE04440
3383	72	2008-02-04 22:27:34	2008-02-04 22:29:34	t	0101000020E6100000D97DC7F0D82D52C0EE42739D46DC4440
3384	72	2008-02-04 22:29:10	2008-02-04 22:31:10	f	0101000020E61000004A0D6D00362E52C08B89CDC7B5DB4440
3385	72	2008-02-04 22:34:10	2008-02-04 22:36:10	f	0101000020E610000024111AC1C62F52C09BC937DBDCDA4440
3386	72	2008-02-04 22:39:10	2008-02-04 22:41:10	t	0101000020E610000026B03907CF3052C056BC9179E4D94440
3387	72	2008-02-04 22:49:10	2008-02-04 22:51:10	t	0101000020E6100000EF5BAD13972F52C0B9196EC0E7D94440
3388	72	2008-02-04 22:59:10	2008-02-04 23:01:10	t	0101000020E61000008F93C2BCC72D52C0FDD98F1491D74440
3389	72	2008-02-04 23:04:10	2008-02-04 23:06:10	t	0101000020E61000003339B5334C2B52C05A4C6C3EAED74440
3390	72	2008-02-04 23:09:10	2008-02-04 23:11:10	t	0101000020E61000006906F1811D2952C0F60B76C3B6D74440
3391	72	2008-02-04 23:14:10	2008-02-04 23:16:10	f	0101000020E6100000255E9ECE152752C09B8F6B43C5D64440
3392	72	2008-02-04 23:19:10	2008-02-04 23:21:10	f	0101000020E6100000CAE6AA798E2652C08DD13AAA9AD64440
3393	72	2008-02-04 23:24:10	2008-02-04 23:26:10	t	0101000020E6100000ADC612D6C62652C0F8A57EDE54D64440
3394	72	2008-02-04 23:29:10	2008-02-04 23:31:10	t	0101000020E610000042446ADAC52652C080D93D7958D64440
3395	72	2008-02-04 23:34:10	2008-02-04 23:36:10	f	0101000020E610000078853E58C62652C087FE092E56D64440
3396	72	2008-02-04 23:39:10	2008-02-04 23:41:10	t	0101000020E610000042446ADAC52652C0A3AF20CD58D64440
3397	72	2008-02-04 23:44:10	2008-02-04 23:46:10	f	0101000020E61000009B5B21ACC62652C04052448655D64440
3398	72	2008-02-04 23:54:10	2008-02-04 23:56:10	f	0101000020E6100000BF310400C72652C0C7681D554DD64440
3399	72	2008-02-04 23:59:10	2008-02-05 00:01:10	t	0101000020E6100000E207E753C72652C09548A29751D64440
3400	72	2008-02-05 00:04:10	2008-02-05 00:06:10	t	0101000020E610000078853E58C62652C0B81E85EB51D64440
3401	72	2008-02-05 00:09:10	2008-02-05 00:11:10	t	0101000020E6100000A280ED60C42652C0EA5BE67459D64440
3402	72	2008-02-05 00:14:10	2008-02-05 00:16:10	f	0101000020E6100000C656D0B4C42652C0A3AF20CD58D64440
3403	72	2008-02-05 00:19:10	2008-02-05 00:21:10	f	0101000020E61000009015FC36C42652C0F180B22957D64440
3404	72	2008-02-05 00:19:10	2008-02-05 00:21:10	f	0101000020E61000009015FC36C42652C0F180B22957D64440
3405	72	2008-02-05 00:24:10	2008-02-05 00:26:10	t	0101000020E61000001F6E8786C52652C0D5CF9B8A54D64440
3406	72	2008-02-05 00:29:10	2008-02-05 00:31:10	t	0101000020E610000042446ADAC52652C087FE092E56D64440
3407	72	2008-02-05 00:34:10	2008-02-05 00:36:10	t	0101000020E6100000BF310400C72652C0F180B22957D64440
3408	72	2008-02-05 00:39:10	2008-02-05 00:41:10	f	0101000020E61000009B5B21ACC62652C08E23D6E253D64440
3409	72	2008-02-05 00:44:10	2008-02-05 00:46:10	f	0101000020E6100000C656D0B4C42652C0B1F9B83654D64440
3410	72	2008-02-05 00:49:10	2008-02-05 00:51:10	f	0101000020E6100000B4EBDE8AC42652C06A4DF38E53D64440
3411	72	2008-02-05 00:54:10	2008-02-05 00:56:10	f	0101000020E6100000B4EBDE8AC42652C08E23D6E253D64440
3412	72	2008-02-05 00:59:10	2008-02-05 01:01:10	t	0101000020E61000000D03965CC52652C000CB4A9352D64440
3413	72	2008-02-05 01:04:10	2008-02-05 01:06:10	t	0101000020E61000006D3F19E3C32652C04777103B53D64440
3414	72	2008-02-05 01:09:10	2008-02-05 01:11:10	t	0101000020E6100000FB97A432C52652C023A12DE752D64440
3415	72	2008-02-05 01:14:09	2008-02-05 01:16:09	f	0101000020E61000001F6E8786C52652C000CB4A9352D64440
3416	72	2008-02-05 01:19:09	2008-02-05 01:21:09	t	0101000020E61000000D03965CC52652C031EBC5504ED64440
3417	72	2008-02-05 01:24:09	2008-02-05 01:26:09	t	0101000020E6100000661A4D2EC62652C079978BF84ED64440
3418	72	2008-02-05 01:29:09	2008-02-05 01:31:09	f	0101000020E61000001F6E8786C52652C09C6D6E4C4FD64440
3419	72	2008-02-05 01:34:09	2008-02-05 01:36:09	f	0101000020E6100000C656D0B4C42652C023A12DE752D64440
3420	72	2008-02-05 01:39:09	2008-02-05 01:41:09	t	0101000020E6100000A280ED60C42652C0DCF4673F52D64440
3421	72	2008-02-05 01:54:09	2008-02-05 01:56:09	t	0101000020E6100000A280ED60C42652C06A4DF38E53D64440
3422	72	2008-02-05 01:59:09	2008-02-05 02:01:09	t	0101000020E610000054AF5B04C62652C04777103B53D64440
3423	72	2008-02-05 02:04:09	2008-02-05 02:06:09	t	0101000020E6100000661A4D2EC62652C08E23D6E253D64440
3424	72	2008-02-05 02:39:09	2008-02-05 02:41:09	t	0101000020E61000006D3F19E3C32652C007F0164850D64440
3425	72	2008-02-05 02:44:09	2008-02-05 02:46:09	t	0101000020E61000002693533BC32652C09C6D6E4C4FD64440
3426	72	2008-02-05 02:49:09	2008-02-05 02:51:09	t	0101000020E6100000D8C1C1DEC42652C08E23D6E253D64440
3427	72	2008-02-05 02:54:09	2008-02-05 02:56:09	t	0101000020E61000009015FC36C42652C04E9CDCEF50D64440
3428	72	2008-02-05 02:59:09	2008-02-05 03:01:09	f	0101000020E610000002BD70E7C22652C0F8A57EDE54D64440
3429	72	2008-02-05 03:04:09	2008-02-05 03:06:09	f	0101000020E6100000FB97A432C52652C080D93D7958D64440
3430	72	2008-02-05 03:09:09	2008-02-05 03:11:09	t	0101000020E6100000D8C1C1DEC42652C00E32C9C859D64440
3431	72	2008-02-05 03:14:09	2008-02-05 03:16:09	f	0101000020E6100000E92CB308C52652C05C035B2558D64440
3432	72	2008-02-05 03:19:09	2008-02-05 03:21:09	t	0101000020E6100000E92CB308C52652C0C785032159D64440
3433	72	2008-02-05 03:24:09	2008-02-05 03:26:09	f	0101000020E61000004969368FC32652C0B83B6BB75DD64440
3434	72	2008-02-05 03:29:09	2008-02-05 03:31:09	t	0101000020E6100000FB97A432C52652C05C035B2558D64440
3435	72	2008-02-05 03:34:09	2008-02-05 03:36:09	t	0101000020E6100000E92CB308C52652C0EA5BE67459D64440
3436	72	2008-02-05 03:39:09	2008-02-05 03:41:09	f	0101000020E6100000E92CB308C52652C0AAD4EC8156D64440
3437	72	2008-02-05 03:44:09	2008-02-05 03:46:09	t	0101000020E610000054AF5B04C62652C03108AC1C5AD64440
3438	72	2008-02-05 03:49:09	2008-02-05 03:51:09	f	0101000020E610000030D978B0C52652C01C7C613255D64440
3439	72	2008-02-05 03:54:09	2008-02-05 03:56:09	t	0101000020E6100000D09CF529C72652C00E32C9C859D64440
3440	72	2008-02-05 03:59:09	2008-02-05 04:01:09	f	0101000020E61000001F6E8786C52652C02AC6F99B50D64440
3441	72	2008-02-06 12:30:04	2008-02-06 12:32:04	t	0101000020E61000001B355F251F3152C03FC6DCB584D64440
3442	72	2008-02-06 12:35:04	2008-02-06 12:37:04	t	0101000020E6100000A4AB74779D2F52C0240B98C0ADD54440
3443	72	2008-02-06 12:40:04	2008-02-06 12:42:04	f	0101000020E6100000F33D23111A2F52C073DC291DACD54440
3444	72	2008-02-06 12:45:04	2008-02-06 12:47:04	f	0101000020E61000009AD4D006602F52C0C785032159D64440
3445	72	2008-02-06 12:50:04	2008-02-06 12:52:04	f	0101000020E610000032CF4A5AF12F52C05E9D6340F6D84440
3446	72	2008-02-06 12:55:04	2008-02-06 12:57:04	t	0101000020E61000007E923B6C223152C009A7052FFAD84440
3447	72	2008-02-06 13:00:04	2008-02-06 13:02:04	f	0101000020E6100000E58409A3593152C0E4A08499B6D54440
3448	72	2008-02-06 13:05:04	2008-02-06 13:07:04	f	0101000020E61000008548861C5B3352C0560E2DB29DD54440
3449	72	2008-02-06 13:10:04	2008-02-06 13:12:04	f	0101000020E6100000BEA59C2FF63452C0653BDF4F8DD54440
3450	72	2008-02-06 13:15:04	2008-02-06 13:17:04	t	0101000020E6100000319A95ED433652C075CDE49B6DD44440
3451	72	2008-02-06 13:20:56	2008-02-06 13:22:56	t	0101000020E6100000F13499F1B63852C0CA4FAA7D3AD44440
3452	73	2008-02-03 10:55:25	2008-02-03 10:57:25	t	0101000020E610000077FEEDB25F3B52C0CCEEC9C342D34440
3453	73	2008-02-03 11:00:25	2008-02-03 11:02:25	f	0101000020E610000004AE2B66843B52C07715527E52D34440
3454	73	2008-02-03 11:05:25	2008-02-03 11:07:25	t	0101000020E61000009CE271512D3C52C0BDA94885B1D34440
3455	73	2008-02-03 11:10:25	2008-02-03 11:12:25	f	0101000020E6100000E67ADB4C853C52C059C51B9947D44440
3456	73	2008-02-03 11:15:25	2008-02-03 11:17:25	t	0101000020E610000039A27BD6353A52C0670FB40243D44440
3457	73	2008-02-03 11:20:25	2008-02-03 11:22:25	f	0101000020E6100000E72329E9613852C0E7A90EB919D44440
3458	73	2008-02-03 11:25:25	2008-02-03 11:27:25	f	0101000020E6100000EE48F59D5F3852C0429AB1683AD54440
3459	73	2008-02-03 11:25:25	2008-02-03 11:27:25	t	0101000020E6100000EE48F59D5F3852C0429AB1683AD54440
3460	73	2008-02-03 11:30:25	2008-02-03 11:32:25	f	0101000020E6100000742A1900AA3852C00F7F4DD6A8D54440
3461	73	2008-02-03 11:35:25	2008-02-03 11:37:25	f	0101000020E6100000A0FEB3E6C73952C0E99AC937DBD64440
3462	73	2008-02-03 11:40:25	2008-02-03 11:42:25	t	0101000020E610000059C6866EF63952C0FFEC478AC8DA4440
3463	73	2008-02-03 11:45:25	2008-02-03 11:47:25	f	0101000020E6100000310E2E1D733A52C024F3C81F0CDA4440
3464	73	2008-02-03 11:50:25	2008-02-03 11:52:25	f	0101000020E61000009A9A046F483952C0DC9DB5DB2EDA4440
3465	73	2008-02-03 11:55:25	2008-02-03 11:57:25	f	0101000020E6100000F5A78DEA743652C024287E8CB9D94440
3466	73	2008-02-03 12:00:25	2008-02-03 12:02:25	t	0101000020E6100000DC519CA38E3652C09E4143FF04D94440
3467	73	2008-02-03 12:05:25	2008-02-03 12:07:25	t	0101000020E6100000E94999D4D03652C0BA1457957DD94440
3468	73	2008-02-03 12:10:25	2008-02-03 12:12:25	t	0101000020E61000004B7CEE04FB3552C01D2098A3C7D94440
3469	73	2008-02-03 12:15:25	2008-02-03 12:17:25	f	0101000020E61000005C785E2A363652C0355EBA490CDC4440
3470	73	2008-02-03 12:25:25	2008-02-03 12:27:25	f	0101000020E61000003720425C393552C00E6C956071DE4440
3471	73	2008-02-03 12:35:25	2008-02-03 12:37:25	t	0101000020E6100000433F53AF5B3452C0A874B0FECFDF4440
3472	73	2008-02-03 12:40:25	2008-02-03 12:42:25	t	0101000020E6100000A0E6E445263452C01AE25817B7DF4440
3473	73	2008-02-03 12:45:25	2008-02-03 12:47:25	f	0101000020E61000008352B4722F3452C07F130A1170DE4440
3474	73	2008-02-03 12:50:25	2008-02-03 12:52:25	t	0101000020E610000097AE601BF13252C0FDC1C073EFDF4440
3475	73	2008-02-03 12:55:25	2008-02-03 12:57:25	t	0101000020E6100000EC353D28283152C0DA5A5F24B4DF4440
3476	73	2008-02-03 13:00:25	2008-02-03 13:02:25	f	0101000020E610000064416150A62F52C006F52D73BADE4440
3477	73	2008-02-03 13:05:25	2008-02-03 13:07:25	t	0101000020E6100000E2D231E7192F52C08A027D224FDC4440
3478	73	2008-02-03 13:10:25	2008-02-03 13:12:25	t	0101000020E6100000DD0DA2B5A22F52C0535C55F65DDB4440
3479	73	2008-02-03 13:15:25	2008-02-03 13:17:25	f	0101000020E6100000121AC1C6F52F52C00C3CF71E2EDB4440
3480	73	2008-02-03 13:20:25	2008-02-03 13:22:25	f	0101000020E6100000E0162CD5053052C04CE0D6DD3CDB4440
3481	73	2008-02-03 13:25:25	2008-02-03 13:27:25	t	0101000020E610000027C3F17C063052C0FE0E45813EDB4440
3482	73	2008-02-03 13:30:25	2008-02-03 13:32:25	t	0101000020E6100000AEF6B0170A3052C0E9BCC62E51DB4440
3483	73	2008-02-03 13:35:25	2008-02-03 13:37:25	t	0101000020E61000004474081C093052C045D8F0F44ADB4440
3484	68	2008-02-02 18:13:50	2008-02-02 18:15:50	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
3485	73	2008-02-03 13:40:25	2008-02-03 13:42:25	t	0101000020E6100000320917F2083052C070D39FFD48DB4440
3486	73	2008-02-03 13:45:25	2008-02-03 13:47:25	f	0101000020E61000004474081C093052C070D39FFD48DB4440
3487	73	2008-02-03 13:50:24	2008-02-03 13:52:24	t	0101000020E61000004474081C093052C04CFDBCA948DB4440
3488	73	2008-02-03 13:50:24	2008-02-03 13:52:24	f	0101000020E61000004474081C093052C04CFDBCA948DB4440
3489	73	2008-02-03 13:55:24	2008-02-03 13:57:24	f	0101000020E61000004474081C093052C02927DA5548DB4440
3490	73	2008-02-03 14:00:24	2008-02-03 14:02:24	t	0101000020E6100000320917F2083052C02927DA5548DB4440
3491	73	2008-02-03 14:05:24	2008-02-03 14:07:24	t	0101000020E6100000320917F2083052C02927DA5548DB4440
3492	73	2008-02-03 14:10:24	2008-02-03 14:12:24	f	0101000020E6100000209E25C8083052C04CFDBCA948DB4440
3493	73	2008-02-03 14:15:24	2008-02-03 14:17:24	t	0101000020E6100000FCC74274083052C093A9825149DB4440
3494	73	2008-02-03 14:20:24	2008-02-03 14:22:24	f	0101000020E6100000729010E50B3052C08C67D0D03FDB4440
3495	73	2008-02-03 14:25:24	2008-02-03 14:27:24	f	0101000020E6100000C061A2410A3052C0139B8F6B43DB4440
3496	73	2008-02-03 14:30:24	2008-02-03 14:32:24	f	0101000020E61000008B20CEC3093052C05A47551344DB4440
3497	73	2008-02-03 14:35:24	2008-02-03 14:37:24	t	0101000020E610000079B5DC99093052C07E1D386744DB4440
3498	73	2008-02-03 14:40:24	2008-02-03 14:42:24	f	0101000020E610000079B5DC99093052C07E1D386744DB4440
3499	73	2008-02-03 14:45:24	2008-02-03 14:47:24	t	0101000020E6100000F2811DFF053052C0DA5548F949DB4440
3500	73	2008-02-03 14:50:24	2008-02-03 14:52:24	f	0101000020E61000004B99D4D0063052C06991ED7C3FDB4440
3501	73	2008-02-03 14:55:24	2008-02-03 14:57:24	t	0101000020E61000005C04C6FA063052C0616C21C841DB4440
3502	73	2008-02-03 15:00:24	2008-02-03 15:02:24	t	0101000020E61000005C04C6FA063052C0A918E76F42DB4440
3503	73	2008-02-03 15:05:24	2008-02-03 15:07:24	f	0101000020E61000005C04C6FA063052C0CCEEC9C342DB4440
3504	73	2008-02-03 15:10:24	2008-02-03 15:12:24	f	0101000020E6100000CEAB3AAB053052C069AED3484BDB4440
3505	73	2008-02-03 15:15:24	2008-02-03 15:17:24	t	0101000020E61000004B99D4D0063052C0618907944DDB4440
3506	73	2008-02-03 15:20:24	2008-02-03 15:22:24	f	0101000020E6100000FCC74274083052C08C84B69C4BDB4440
3507	73	2008-02-03 15:25:24	2008-02-03 15:27:24	t	0101000020E61000004474081C093052C0F7065F984CDB4440
3508	73	2008-02-03 15:30:24	2008-02-03 15:32:24	f	0101000020E6100000320917F2083052C0D3307C444CDB4440
3509	73	2008-02-03 15:35:24	2008-02-03 15:37:24	f	0101000020E61000006E6FB724073052C077F86BB246DB4440
3510	73	2008-02-03 15:40:24	2008-02-03 15:42:24	t	0101000020E610000080DAA84E073052C09ACE4E0647DB4440
3511	73	2008-02-03 15:45:24	2008-02-03 15:47:24	f	0101000020E6100000E0162CD5053052C08C84B69C4BDB4440
3512	73	2008-02-03 15:50:24	2008-02-03 15:52:24	f	0101000020E610000080DAA84E073052C0BEA4315A47DB4440
3513	73	2008-02-03 15:55:24	2008-02-03 15:57:24	t	0101000020E6100000A4B08BA2073052C0E17A14AE47DB4440
3514	73	2008-02-03 16:00:24	2008-02-03 16:02:24	t	0101000020E6100000B51B7DCC073052C00551F70148DB4440
3515	73	2008-02-03 16:05:24	2008-02-03 16:07:24	f	0101000020E6100000B51B7DCC073052C00551F70148DB4440
3516	73	2008-02-03 16:10:24	2008-02-03 16:12:24	f	0101000020E6100000C7866EF6073052C02927DA5548DB4440
3517	74	2008-02-03 22:06:22	2008-02-03 22:08:22	t	0101000020E6100000BFA085048C3852C0DB8AFD65F7E24440
3518	74	2008-02-03 22:11:22	2008-02-03 22:13:22	t	0101000020E61000004BB1A371A83952C0910F7A36ABE44440
3519	74	2008-02-03 22:16:22	2008-02-03 22:18:22	f	0101000020E6100000BA54A52DAE3952C0D89E5912A0E44440
3520	74	2008-02-03 22:21:22	2008-02-03 22:23:22	f	0101000020E61000009BE7887C973852C013D55B035BE34440
3521	74	2008-02-03 22:26:22	2008-02-03 22:28:22	f	0101000020E6100000D09CF529C73852C03A92CB7F48E14440
3522	74	2008-02-03 22:31:22	2008-02-03 22:33:22	f	0101000020E6100000CBA2B08BA23752C0E757738060E04440
3523	74	2008-02-03 22:36:22	2008-02-03 22:38:22	t	0101000020E6100000767286E28E3752C078D1579066DE4440
3524	74	2008-02-03 22:41:22	2008-02-03 22:43:22	t	0101000020E6100000278925E5EE3752C0F3E505D847DD4440
3525	74	2008-02-03 22:46:22	2008-02-03 22:48:22	t	0101000020E6100000D89FC4E74E3852C0113B53E8BCDC4440
3526	74	2008-02-03 22:51:22	2008-02-03 22:53:22	f	0101000020E610000075CE4F711C3852C00F2DB29DEFD94440
3527	74	2008-02-03 22:56:22	2008-02-03 22:58:22	t	0101000020E61000000F2E1D739E3752C0257A19C572D94440
3528	75	2008-02-05 12:25:12	2008-02-05 12:27:12	f	0101000020E6100000DCC01DA8533652C03B8DB454DEE04440
3529	75	2008-02-05 12:44:29	2008-02-05 12:46:29	t	0101000020E61000000ADD2571563652C04209336DFFE04440
3530	75	2008-02-05 12:47:19	2008-02-05 12:49:19	t	0101000020E6100000F91A82E3323652C0335019FF3EE14440
3531	75	2008-02-05 17:59:44	2008-02-05 18:01:44	t	0101000020E61000002012BEF7373652C025E99AC937E14440
3532	75	2008-02-05 18:00:12	2008-02-05 18:02:12	t	0101000020E61000002012BEF7373652C025E99AC937E14440
3533	75	2008-02-05 18:04:45	2008-02-05 18:06:45	f	0101000020E6100000A37BD6355A3652C0DECD531D72E14440
3534	75	2008-02-05 18:05:13	2008-02-05 18:07:13	f	0101000020E61000008EB5BFB33D3652C0166A4DF38EE14440
3535	75	2008-02-05 18:10:15	2008-02-05 18:12:15	f	0101000020E61000003B1F9E25C83452C02F8B89CDC7DF4440
3536	75	2008-02-05 18:21:23	2008-02-05 18:23:23	t	0101000020E6100000C6A86BED7D3452C03FA9F6E978DE4440
3537	75	2008-02-05 18:21:23	2008-02-05 18:23:23	t	0101000020E6100000C6A86BED7D3452C03FA9F6E978DE4440
3538	75	2008-02-05 18:35:36	2008-02-05 18:37:36	f	0101000020E61000001CBCAFCA853452C0B16D516683DE4440
3539	75	2008-02-05 18:39:28	2008-02-05 18:41:28	t	0101000020E610000099C11891283452C0A9DE1AD82ADF4440
3540	75	2008-02-05 18:40:38	2008-02-05 18:42:38	f	0101000020E61000002AAF95D05D3452C0850838842ADF4440
3541	75	2008-02-05 18:44:30	2008-02-05 18:46:30	t	0101000020E6100000B4CEF8BEB83452C01AE25817B7DF4440
3542	75	2008-02-05 18:45:40	2008-02-05 18:47:40	f	0101000020E6100000833AE5D18D3452C040FB912232DE4440
3543	75	2008-02-05 18:49:32	2008-02-05 18:51:32	t	0101000020E6100000EAD0E979373652C0FA27B85851DD4440
3544	75	2008-02-05 18:50:41	2008-02-05 18:52:41	t	0101000020E6100000FF9600FC533652C0AD342905DDDC4440
3545	75	2008-02-05 18:54:33	2008-02-05 18:56:33	f	0101000020E6100000231631EC303652C04F401361C3D94440
3546	75	2008-02-05 18:55:43	2008-02-05 18:57:43	f	0101000020E6100000DC696B44303652C0DD24068195D94440
3547	75	2008-02-05 18:55:43	2008-02-05 18:57:43	t	0101000020E6100000DC696B44303652C0DD24068195D94440
3548	75	2008-02-05 18:59:35	2008-02-05 19:01:35	t	0101000020E61000000A698D41273652C0BD57AD4CF8D74440
3549	75	2008-02-05 19:05:46	2008-02-05 19:07:46	f	0101000020E61000005519C6DD203652C06475ABE7A4D54440
3550	75	2008-02-05 19:09:38	2008-02-05 19:11:38	t	0101000020E6100000BC7F2C44873652C01FBAA0BE65D44440
3551	75	2008-02-05 19:10:48	2008-02-05 19:12:48	f	0101000020E6100000CCD765F84F3752C0AED85F764FD44440
3552	75	2008-02-05 19:14:40	2008-02-05 19:16:40	t	0101000020E610000095145800533852C0F5BEF1B567D44440
3553	75	2008-02-05 19:15:50	2008-02-05 19:17:50	t	0101000020E6100000BC0B9414583852C0BC22F8DF4AD44440
3554	75	2008-02-05 19:19:42	2008-02-05 19:21:42	f	0101000020E6100000E2B54B1B0E3952C0813E912749D54440
3555	75	2008-02-05 19:24:43	2008-02-05 19:26:43	f	0101000020E6100000CF6C57E8833752C0A5C2D84290D54440
3556	75	2008-02-05 19:24:43	2008-02-05 19:26:43	t	0101000020E6100000CF6C57E8833752C0A5C2D84290D54440
3557	75	2008-02-05 19:25:53	2008-02-05 19:27:53	t	0101000020E610000036B1C057743752C09D2E8B89CDD54440
3558	75	2008-02-05 19:29:45	2008-02-05 19:31:45	f	0101000020E61000007D5D86FF743752C088687407B1D54440
3559	75	2008-02-05 19:30:55	2008-02-05 19:32:55	t	0101000020E61000000CB6114F763752C0DC2E34D769D64440
3560	75	2008-02-05 19:34:47	2008-02-05 19:36:47	f	0101000020E610000014622EA9DA3652C069A9BC1DE1D64440
3561	75	2008-02-05 19:35:56	2008-02-05 19:37:56	t	0101000020E6100000E3934E24983652C0CD4065FCFBD64440
3562	75	2008-02-05 19:39:48	2008-02-05 19:41:48	t	0101000020E6100000E775C4211B3652C04D4F58E201D74440
3563	75	2008-02-05 19:40:58	2008-02-05 19:42:58	f	0101000020E61000008335CEA6233652C0D9CEF753E3D74440
3564	75	2008-02-05 19:44:50	2008-02-05 19:46:50	t	0101000020E610000095A0BFD0233652C0C0266BD443DA4440
3565	75	2008-02-05 19:46:00	2008-02-05 19:48:00	f	0101000020E6100000639D2ADF333652C0EFACDD76A1DB4440
3566	75	2008-02-05 19:49:52	2008-02-05 19:51:52	f	0101000020E6100000E1BA6246783752C017BCE82B48DD4440
3567	75	2008-02-05 19:51:01	2008-02-05 19:53:01	t	0101000020E610000035F5BA45603852C0BA66F2CD36DD4440
3568	75	2008-02-05 19:54:53	2008-02-05 19:56:53	f	0101000020E610000001016BD5AE3952C0CDAFE600C1DE4440
3569	75	2008-02-05 19:56:03	2008-02-05 19:58:03	f	0101000020E6100000689C86A8C23952C09279E40F06E04440
3570	75	2008-02-05 19:59:55	2008-02-05 20:01:55	f	0101000020E6100000784B72C0AE3A52C0598638D6C5E34440
3571	75	2008-02-05 20:01:05	2008-02-05 20:03:05	t	0101000020E610000049DDCEBEF23A52C0751F80D426E44440
3572	75	2008-02-05 20:04:57	2008-02-05 20:06:57	t	0101000020E61000002A5DFA97A43A52C0E0F8DA334BE44440
3573	75	2008-02-05 20:06:06	2008-02-05 20:08:06	t	0101000020E6100000F9E0B54B1B3A52C0BCB376DB85E44440
3574	75	2008-02-05 20:09:58	2008-02-05 20:11:58	f	0101000020E6100000A7457D923B3A52C066A032FE7DE44440
3575	75	2008-02-05 20:11:08	2008-02-05 20:13:08	f	0101000020E6100000E6D18DB0A83A52C00AF4893C49E44440
3576	75	2008-02-05 20:16:00	2008-02-05 20:18:00	t	0101000020E61000002602D53F883A52C020B58993FBE34440
3577	75	2008-02-05 20:16:10	2008-02-05 20:18:10	t	0101000020E6100000863E58C6863A52C067614F3BFCE34440
3578	75	2008-02-05 20:21:02	2008-02-05 20:23:02	t	0101000020E6100000FB5DD89AAD3A52C0205ED72FD8E34440
3579	75	2008-02-05 20:21:11	2008-02-05 20:23:11	f	0101000020E6100000225514AFB23A52C0B6DB2E34D7E34440
3580	75	2008-02-05 20:26:04	2008-02-05 20:28:04	f	0101000020E6100000FADB9E20B13952C091F2936A9FE44440
3581	75	2008-02-05 20:26:13	2008-02-05 20:28:13	f	0101000020E6100000FADB9E20B13952C091F2936A9FE44440
3582	75	2008-02-05 20:31:05	2008-02-05 20:33:05	f	0101000020E6100000FEBD141E343B52C067B8019F1FE44440
3583	75	2008-02-05 20:31:15	2008-02-05 20:33:15	t	0101000020E6100000E146CA16493B52C06EDDCD531DE44440
3584	75	2008-02-05 20:36:07	2008-02-05 20:38:07	t	0101000020E61000004131B2648E3B52C0B5C35F9335E44440
3585	75	2008-02-05 20:36:16	2008-02-05 20:38:16	t	0101000020E61000000CF0DDE68D3B52C0E0BE0E9C33E44440
3586	75	2008-02-05 20:41:09	2008-02-05 20:43:09	f	0101000020E6100000AA6BED7DAA3A52C0E17F2BD9B1E34440
3587	75	2008-02-05 20:46:10	2008-02-05 20:48:10	f	0101000020E6100000A8406667D13952C0A88C7F9F71DF4440
3588	75	2008-02-05 20:46:20	2008-02-05 20:48:20	f	0101000020E6100000A1E1CD1ABC3952C0132C0E677EDF4440
3589	75	2008-02-05 20:51:12	2008-02-05 20:53:12	f	0101000020E6100000CDEA1D6E873652C06FD8B628B3DF4440
3590	75	2008-02-05 20:51:21	2008-02-05 20:53:21	f	0101000020E6100000DC17D00B773652C02F51BD35B0DF4440
3591	75	2008-02-05 20:56:23	2008-02-05 20:58:23	f	0101000020E6100000B58F15FC363652C06CB2463D44E14440
3592	76	2008-02-06 18:54:11	2008-02-06 18:56:11	t	0101000020E6100000C4B7B06EBC2F52C085F068E388CB4440
3593	76	2008-02-06 18:59:11	2008-02-06 19:01:11	t	0101000020E6100000967EC2D9AD2F52C0BA66F2CD36CD4440
3594	76	2008-02-06 19:04:10	2008-02-06 19:06:10	t	0101000020E6100000DDD8EC48F52F52C0460DA661F8CE4440
3595	76	2008-02-06 19:09:10	2008-02-06 19:11:10	f	0101000020E6100000D292C7D3F23152C03012DA722ECF4440
3596	76	2008-02-06 19:14:10	2008-02-06 19:16:10	f	0101000020E6100000B6334C6DA93552C05B5F24B4E5CE4440
3597	76	2008-02-06 19:19:10	2008-02-06 19:21:10	t	0101000020E610000044352559873552C03C4ED1915CD04440
3598	76	2008-02-06 19:29:10	2008-02-06 19:31:10	f	0101000020E61000005AC16F438C3552C068CBB91457CF4440
3599	76	2008-02-06 19:34:10	2008-02-06 19:36:10	t	0101000020E6100000CC290131093552C0F54A598638D04440
3600	76	2008-02-06 19:39:10	2008-02-06 19:41:10	f	0101000020E610000097AE601BF13452C0965B5A0D89D14440
3601	76	2008-02-06 19:44:10	2008-02-06 19:46:10	t	0101000020E61000000D941458003552C09C8A54185BD24440
3602	76	2008-02-06 19:49:10	2008-02-06 19:51:10	t	0101000020E6100000CC68E4F38A3552C0C6E1CCAFE6D24440
3603	77	2008-02-04 11:23:52	2008-02-04 11:25:52	f	0101000020E610000090A67A32FF3A52C0BC22F8DF4AD84440
3604	77	2008-02-04 11:28:53	2008-02-04 11:30:53	f	0101000020E61000008D463EAF783A52C0D2C6116BF1D74440
3605	77	2008-02-04 11:32:45	2008-02-04 11:34:45	f	0101000020E6100000B8D26BB3B13A52C0F69CF4BEF1D74440
3606	77	2008-02-04 11:42:01	2008-02-04 11:44:01	f	0101000020E6100000225514AFB23A52C0AFF02E17F1D74440
3607	77	2008-02-04 11:47:03	2008-02-04 11:49:03	t	0101000020E61000004BB1A371A83952C01FA2D11DC4D84440
3608	77	2008-02-04 11:50:55	2008-02-04 11:52:55	t	0101000020E610000031F14751673852C0D1D03FC1C5D84440
3609	77	2008-02-04 11:52:05	2008-02-04 11:54:05	t	0101000020E6100000C07E880D163852C06D3997E2AAD84440
3610	77	2008-02-04 11:55:57	2008-02-04 11:57:57	t	0101000020E61000009D69C2F6933752C061376C5B94D74440
3611	77	2008-02-04 11:57:06	2008-02-04 11:59:06	t	0101000020E610000045300E2E1D3752C0A1BE654E97D74440
3612	77	2008-02-04 12:00:58	2008-02-04 12:02:58	t	0101000020E61000002EB308C5563652C0A80018CFA0D74440
3613	77	2008-02-04 12:02:08	2008-02-04 12:04:08	f	0101000020E6100000CA552C7E533652C028D53E1D8FD74440
3614	77	2008-02-04 12:06:00	2008-02-04 12:08:00	t	0101000020E6100000865B3E92923652C06F693524EED74440
3615	77	2008-02-04 12:07:10	2008-02-04 12:09:10	f	0101000020E6100000DF72F563933652C05266834C32D84440
3616	77	2008-02-04 12:11:02	2008-02-04 12:13:02	f	0101000020E61000003AEFFFE3843752C0E700C11C3DD84440
3617	77	2008-02-04 12:12:11	2008-02-04 12:14:11	t	0101000020E61000007DB43863983752C0A054FB743CD84440
3618	77	2008-02-04 12:16:03	2008-02-04 12:18:03	t	0101000020E6100000EB793716143852C07BBDFBE3BDD84440
3619	77	2008-02-04 12:17:13	2008-02-04 12:19:13	t	0101000020E610000079D2C265153852C0164D672783D94440
3620	77	2008-02-04 12:21:05	2008-02-04 12:23:05	f	0101000020E6100000DC696B44303852C0F08AE07F2BDB4440
3621	77	2008-02-04 12:22:15	2008-02-04 12:24:15	f	0101000020E61000003CC3D4963A3852C0C408E1D1C6DB4440
3622	77	2008-02-04 12:26:07	2008-02-04 12:28:07	t	0101000020E6100000C6A86BED7D3852C090F7AA9509DD4440
3623	77	2008-02-04 12:27:16	2008-02-04 12:29:16	t	0101000020E6100000831DFF05823852C074637AC212DD4440
3624	77	2008-02-04 12:31:08	2008-02-04 12:33:08	f	0101000020E6100000DCC01DA8533852C0D2A92B9FE5DB4440
3625	77	2008-02-04 12:32:18	2008-02-04 12:34:18	f	0101000020E6100000CA207711A63852C09964E42CECDB4440
3626	77	2008-02-04 12:36:10	2008-02-04 12:38:10	f	0101000020E61000009E47C5FF1D3952C006F52D73BADA4440
3627	77	2008-02-04 12:37:20	2008-02-04 12:39:20	f	0101000020E6100000D06740BD193952C06BB75D68AED94440
3628	77	2008-02-04 12:41:12	2008-02-04 12:43:12	f	0101000020E6100000225A2BDA1C3952C04B598638D6D74440
3629	77	2008-02-04 12:42:21	2008-02-04 12:44:21	f	0101000020E6100000100C207C283952C0E8DEC325C7D74440
3630	77	2008-02-04 12:52:29	2008-02-04 12:54:29	t	0101000020E61000004E8061F9F33952C03DB83B6BB7D74440
3631	77	2008-02-04 12:55:20	2008-02-04 12:57:20	f	0101000020E61000009B0986730D3B52C0F6285C8FC2D74440
3632	77	2008-02-04 12:57:30	2008-02-04 12:59:30	f	0101000020E6100000C00AF0DDE63B52C0E8DEC325C7D74440
3633	77	2008-02-04 13:00:22	2008-02-04 13:02:22	t	0101000020E61000004E9D47C5FF3B52C0A11518B2BAD74440
3634	77	2008-02-04 13:02:32	2008-02-04 13:04:32	t	0101000020E6100000F9A6E9B3033C52C0A20BEA5BE6D64440
3635	77	2008-02-04 13:02:32	2008-02-04 13:04:32	t	0101000020E6100000F9A6E9B3033C52C0A20BEA5BE6D64440
3636	77	2008-02-04 13:05:24	2008-02-04 13:07:24	f	0101000020E6100000AA83BC1E4C3C52C09AD36531B1D74440
3637	77	2008-02-04 13:07:34	2008-02-04 13:09:34	t	0101000020E6100000D5D51D8B6D3C52C061C8EA56CFD74440
3638	77	2008-02-04 13:12:41	2008-02-04 13:14:41	t	0101000020E610000023E17B7F833C52C0191C25AFCED74440
3639	77	2008-02-04 13:15:27	2008-02-04 13:17:27	t	0101000020E61000004743C6A3543C52C0EFE6A90EB9D74440
3640	77	2008-02-04 13:17:43	2008-02-04 13:19:43	t	0101000020E6100000B6503239B53B52C00473F4F8BDD74440
3641	77	2008-02-04 13:20:28	2008-02-04 13:22:28	f	0101000020E6100000D8C1C1DEC43A52C036E50AEF72D74440
3642	77	2008-02-04 13:22:45	2008-02-04 13:24:45	f	0101000020E6100000F893313ECC3A52C0EBCA67791ED64440
3643	77	2008-02-04 13:25:30	2008-02-04 13:27:30	f	0101000020E61000009F7C7A6CCB3A52C0CFF753E3A5D54440
3644	77	2008-02-04 13:27:46	2008-02-04 13:29:46	f	0101000020E6100000E6284014CC3A52C0AB21718FA5D54440
3645	77	2008-02-04 13:27:46	2008-02-04 13:29:46	t	0101000020E6100000E6284014CC3A52C0AB21718FA5D54440
3646	77	2008-02-04 13:30:32	2008-02-04 13:32:32	f	0101000020E6100000E6284014CC3A52C0AB21718FA5D54440
3647	77	2008-02-04 13:32:48	2008-02-04 13:34:48	t	0101000020E61000004BD3A0681E3A52C08F53742497D54440
3648	77	2008-02-04 13:35:33	2008-02-04 13:37:33	t	0101000020E6100000F60CE198653952C0C173EFE192D54440
3649	77	2008-02-04 13:37:49	2008-02-04 13:39:49	f	0101000020E6100000775089EB183952C00FD1E80E62D54440
3650	77	2008-02-04 13:40:35	2008-02-04 13:42:35	f	0101000020E6100000B3B6291E173952C03E3F8C101ED34440
3651	77	2008-02-04 13:42:51	2008-02-04 13:44:51	f	0101000020E6100000B3D30FEA223952C07FA4880CABD24440
3652	77	2008-02-04 13:45:37	2008-02-04 13:47:37	t	0101000020E6100000B7114F76333952C08E23D6E253D24440
3653	77	2008-02-04 13:47:53	2008-02-04 13:49:53	f	0101000020E610000053978C63243952C0EAEC647094D24440
3654	77	2008-02-04 13:50:38	2008-02-04 13:52:38	t	0101000020E6100000C8D3F203573952C0FF21FDF675D24440
3655	77	2008-02-04 13:52:54	2008-02-04 13:54:54	t	0101000020E61000006B6B44300E3A52C0F9DA334B02D24440
3656	77	2008-02-04 13:55:40	2008-02-04 13:57:40	t	0101000020E610000060420587173A52C0433EE8D9ACD04440
3657	77	2008-02-04 13:55:40	2008-02-04 13:57:40	f	0101000020E610000060420587173A52C0433EE8D9ACD04440
3658	77	2008-02-04 13:57:56	2008-02-04 13:59:56	t	0101000020E6100000A0AC18AE0E3A52C082AD122C0ED14440
3659	77	2008-02-04 14:03:01	2008-02-04 14:05:01	t	0101000020E6100000A7D1E4620C3A52C0EB39E97DE3D14440
3660	77	2008-02-04 14:04:43	2008-02-04 14:06:43	t	0101000020E6100000F1A31AF67B3A52C00F7F4DD6A8D14440
3661	77	2008-02-04 14:08:02	2008-02-04 14:10:02	f	0101000020E6100000299CDD5A263B52C08FC70C54C6D14440
3662	77	2008-02-04 14:09:45	2008-02-04 14:11:45	f	0101000020E610000057F2B1BB403B52C05CC98E8D40D24440
3663	77	2008-02-04 14:13:04	2008-02-04 14:15:04	f	0101000020E61000009A6038D7303B52C0B6A1629CBFD34440
3664	77	2008-02-04 14:14:46	2008-02-04 14:16:46	t	0101000020E61000002DD505BCCC3A52C0A089B0E1E9D34440
3665	77	2008-02-04 14:18:06	2008-02-04 14:20:06	t	0101000020E610000052DB8651103A52C012FC6F253BD44440
3666	77	2008-02-04 14:19:48	2008-02-04 14:21:48	f	0101000020E61000004C38F4160F3952C03CBD529621D44440
3667	78	2008-02-03 16:16:49	2008-02-03 16:18:49	f	0101000020E61000000EC4B299432852C0CD920035B5EA4440
3668	78	2008-02-03 16:21:49	2008-02-03 16:23:49	t	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3669	78	2008-02-03 16:26:49	2008-02-03 16:28:49	t	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3670	78	2008-02-03 16:31:49	2008-02-03 16:33:49	t	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3671	78	2008-02-03 16:36:49	2008-02-03 16:38:49	f	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3672	78	2008-02-03 16:41:49	2008-02-03 16:43:49	t	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3673	78	2008-02-03 16:46:49	2008-02-03 16:48:49	f	0101000020E61000000EC4B299432852C0AABC1DE1B4EA4440
3674	78	2008-02-03 16:51:49	2008-02-03 16:53:49	t	0101000020E61000000EC4B299432852C086E63A8DB4EA4440
3675	78	2008-02-03 16:56:49	2008-02-03 16:58:49	f	0101000020E61000000EC4B299432852C086E63A8DB4EA4440
3676	78	2008-02-03 17:01:49	2008-02-03 17:03:49	t	0101000020E61000000EC4B299432852C086E63A8DB4EA4440
3677	78	2008-02-03 17:06:49	2008-02-03 17:08:49	t	0101000020E61000000EC4B299432852C086E63A8DB4EA4440
3678	79	2008-02-07 15:28:06	2008-02-07 15:30:06	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3679	79	2008-02-07 15:28:10	2008-02-07 15:30:10	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3680	79	2008-02-07 15:28:16	2008-02-07 15:30:16	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3681	79	2008-02-07 15:28:20	2008-02-07 15:30:20	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3682	79	2008-02-07 15:28:26	2008-02-07 15:30:26	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3683	79	2008-02-07 15:28:26	2008-02-07 15:30:26	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3684	79	2008-02-07 15:28:30	2008-02-07 15:30:30	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3685	79	2008-02-07 15:28:30	2008-02-07 15:30:30	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3686	79	2008-02-07 15:28:36	2008-02-07 15:30:36	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3687	79	2008-02-07 15:28:40	2008-02-07 15:30:40	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3688	79	2008-02-07 15:28:46	2008-02-07 15:30:46	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3689	79	2008-02-07 15:28:50	2008-02-07 15:30:50	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3690	79	2008-02-07 15:28:56	2008-02-07 15:30:56	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3691	79	2008-02-07 15:29:00	2008-02-07 15:31:00	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3692	79	2008-02-07 15:29:06	2008-02-07 15:31:06	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3693	79	2008-02-07 15:29:10	2008-02-07 15:31:10	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3694	79	2008-02-07 15:29:16	2008-02-07 15:31:16	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3695	79	2008-02-07 15:29:20	2008-02-07 15:31:20	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3696	79	2008-02-07 15:29:26	2008-02-07 15:31:26	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3697	79	2008-02-07 15:29:30	2008-02-07 15:31:30	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3698	79	2008-02-07 15:29:36	2008-02-07 15:31:36	f	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3699	79	2008-02-07 15:29:40	2008-02-07 15:31:40	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3700	79	2008-02-07 15:29:46	2008-02-07 15:31:46	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3701	79	2008-02-07 15:29:50	2008-02-07 15:31:50	t	0101000020E6100000026BD5AE093F52C0693A3B191CAF4440
3702	79	2008-02-07 15:29:56	2008-02-07 15:31:56	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3703	79	2008-02-07 15:30:00	2008-02-07 15:32:00	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3704	79	2008-02-07 15:30:06	2008-02-07 15:32:06	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3705	79	2008-02-07 15:30:10	2008-02-07 15:32:10	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3706	79	2008-02-07 15:30:16	2008-02-07 15:32:16	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3707	79	2008-02-07 15:30:20	2008-02-07 15:32:20	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3708	79	2008-02-07 15:30:26	2008-02-07 15:32:26	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3709	79	2008-02-07 15:30:30	2008-02-07 15:32:30	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3710	79	2008-02-07 15:30:36	2008-02-07 15:32:36	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3711	79	2008-02-07 15:30:40	2008-02-07 15:32:40	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3712	79	2008-02-07 15:30:46	2008-02-07 15:32:46	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3713	79	2008-02-07 15:30:50	2008-02-07 15:32:50	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3714	79	2008-02-07 15:30:56	2008-02-07 15:32:56	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3715	79	2008-02-07 15:31:00	2008-02-07 15:33:00	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3716	79	2008-02-07 15:31:06	2008-02-07 15:33:06	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3717	79	2008-02-07 15:31:10	2008-02-07 15:33:10	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3718	79	2008-02-07 15:31:16	2008-02-07 15:33:16	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3719	79	2008-02-07 15:31:20	2008-02-07 15:33:20	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3720	79	2008-02-07 15:31:26	2008-02-07 15:33:26	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3721	79	2008-02-07 15:31:30	2008-02-07 15:33:30	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3722	79	2008-02-07 15:31:36	2008-02-07 15:33:36	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3723	79	2008-02-07 15:31:40	2008-02-07 15:33:40	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3724	79	2008-02-07 15:31:50	2008-02-07 15:33:50	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3725	79	2008-02-07 15:31:56	2008-02-07 15:33:56	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3726	79	2008-02-07 15:32:00	2008-02-07 15:34:00	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3727	79	2008-02-07 15:32:06	2008-02-07 15:34:06	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3728	79	2008-02-07 15:32:10	2008-02-07 15:34:10	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3729	79	2008-02-07 15:32:16	2008-02-07 15:34:16	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3730	79	2008-02-07 15:32:20	2008-02-07 15:34:20	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3731	79	2008-02-07 15:32:26	2008-02-07 15:34:26	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3732	79	2008-02-07 15:32:30	2008-02-07 15:34:30	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3733	79	2008-02-07 15:32:36	2008-02-07 15:34:36	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3734	79	2008-02-07 15:32:40	2008-02-07 15:34:40	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3735	79	2008-02-07 15:32:46	2008-02-07 15:34:46	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3736	79	2008-02-07 15:32:50	2008-02-07 15:34:50	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3737	79	2008-02-07 15:32:56	2008-02-07 15:34:56	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3738	79	2008-02-07 15:33:01	2008-02-07 15:35:01	t	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3739	79	2008-02-07 15:33:05	2008-02-07 15:35:05	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3740	79	2008-02-07 15:33:11	2008-02-07 15:35:11	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3741	79	2008-02-07 15:33:15	2008-02-07 15:35:15	f	0101000020E6100000026BD5AE093F52C08C101E6D1CAF4440
3742	79	2008-02-08 02:54:51	2008-02-08 02:56:51	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3743	79	2008-02-08 02:54:56	2008-02-08 02:56:56	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3744	79	2008-02-08 02:55:01	2008-02-08 02:57:01	t	0101000020E610000047787B10024652C0D4F19881CAB64440
3745	79	2008-02-08 02:55:06	2008-02-08 02:57:06	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3746	79	2008-02-08 02:55:11	2008-02-08 02:57:11	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3747	79	2008-02-08 02:55:16	2008-02-08 02:57:16	t	0101000020E610000047787B10024652C0D4F19881CAB64440
3748	79	2008-02-08 02:55:21	2008-02-08 02:57:21	t	0101000020E610000047787B10024652C0D4F19881CAB64440
3749	79	2008-02-08 02:55:26	2008-02-08 02:57:26	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3750	79	2008-02-08 02:55:31	2008-02-08 02:57:31	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3751	79	2008-02-08 02:55:36	2008-02-08 02:57:36	t	0101000020E610000047787B10024652C0D4F19881CAB64440
3752	79	2008-02-08 02:55:41	2008-02-08 02:57:41	f	0101000020E610000047787B10024652C0D4F19881CAB64440
3753	80	2008-02-07 15:33:46	2008-02-07 15:35:46	t	0101000020E6100000D3AA9674942752C053E8BCC62ED74440
3754	80	2008-02-07 15:33:49	2008-02-07 15:35:49	f	0101000020E61000005DE2C803912752C0C58F31772DD74440
3755	80	2008-02-07 15:34:16	2008-02-07 15:36:16	f	0101000020E61000006FF607CA6D2752C0BE6A65C22FD74440
3756	80	2008-02-07 15:34:19	2008-02-07 15:36:19	t	0101000020E61000006FF607CA6D2752C07099D36531D74440
3757	80	2008-02-07 15:34:23	2008-02-07 15:36:23	f	0101000020E61000008161F9F36D2752C022C8410933D74440
3758	80	2008-02-07 15:34:26	2008-02-07 15:36:26	f	0101000020E61000008161F9F36D2752C0697407B133D74440
3759	80	2008-02-07 15:34:29	2008-02-07 15:36:29	f	0101000020E61000004C2025766D2752C085251E5036D74440
3760	80	2008-02-07 15:34:32	2008-02-07 15:36:32	f	0101000020E6100000CF328B506C2752C0F0A7C64B37D74440
3761	80	2008-02-07 15:34:35	2008-02-07 15:36:35	t	0101000020E61000009AF1B6D26B2752C0053411363CD74440
3762	80	2008-02-07 15:34:41	2008-02-07 15:36:41	f	0101000020E61000009AF1B6D26B2752C0CCEEC9C342D74440
3763	80	2008-02-07 15:34:49	2008-02-07 15:36:49	t	0101000020E61000009AF1B6D26B2752C0378E588B4FD74440
3764	80	2008-02-07 15:35:12	2008-02-07 15:37:12	t	0101000020E6100000BEC799266C2752C0B0777FBC57D74440
3765	80	2008-02-07 15:35:16	2008-02-07 15:37:16	f	0101000020E61000002125766D6F2752C0CC28965B5AD74440
3766	80	2008-02-07 15:35:24	2008-02-07 15:37:24	t	0101000020E61000002125766D6F2752C0CC28965B5AD74440
3767	80	2008-02-07 15:35:36	2008-02-07 15:37:36	t	0101000020E61000008161F9F36D2752C01AFA27B858D74440
3768	80	2008-02-07 15:35:55	2008-02-07 15:37:55	t	0101000020E610000065B0E2546B2752C029ED0DBE30D74440
3769	80	2008-02-07 15:35:58	2008-02-07 15:37:58	t	0101000020E61000009AF1B6D26B2752C05B0D897B2CD74440
3770	80	2008-02-07 15:36:03	2008-02-07 15:38:03	t	0101000020E61000009AF1B6D26B2752C0FED478E926D74440
3771	80	2008-02-07 15:36:06	2008-02-07 15:38:06	t	0101000020E6100000F3086EA46C2752C0B003E78C28D74440
3772	80	2008-02-07 15:36:12	2008-02-07 15:38:12	f	0101000020E6100000A537DC476E2752C0623255302AD74440
3773	80	2008-02-07 15:37:21	2008-02-07 15:39:21	f	0101000020E6100000E4E0D231E72752C0DBFE959526D74440
3774	80	2008-02-07 15:37:24	2008-02-07 15:39:24	f	0101000020E610000060CE6C57E82752C01444DD0720D74440
3775	80	2008-02-07 15:38:10	2008-02-07 15:40:10	t	0101000020E61000005DE7DF2EFB2752C00DC347C494D64440
3776	80	2008-02-07 15:38:10	2008-02-07 15:40:10	f	0101000020E61000005DE7DF2EFB2752C00DC347C494D64440
3777	80	2008-02-07 15:38:41	2008-02-07 15:40:41	t	0101000020E6100000E41A9FC9FE2752C0CD3B4ED191D64440
3778	80	2008-02-07 15:38:45	2008-02-07 15:40:45	f	0101000020E610000024A298BC012852C0F836FDD98FD64440
3779	80	2008-02-07 15:38:48	2008-02-07 15:40:48	f	0101000020E610000087FF7403052852C01C0DE02D90D64440
3780	80	2008-02-07 15:40:38	2008-02-07 15:42:38	f	0101000020E610000017838769DF2852C05BEB8B84B6D64440
3781	80	2008-02-07 15:40:56	2008-02-07 15:42:56	f	0101000020E6100000105EBBB4E12852C09B559FABADD64440
3782	80	2008-02-07 15:41:04	2008-02-07 15:43:04	f	0101000020E6100000D7187442E82852C0FFB27BF2B0D64440
3783	80	2008-02-07 15:41:24	2008-02-07 15:43:24	f	0101000020E61000006DD097DEFE2852C05BEB8B84B6D64440
3784	80	2008-02-07 15:41:40	2008-02-07 15:43:40	f	0101000020E61000000288BB7A152952C0F168E388B5D64440
3785	80	2008-02-07 15:43:02	2008-02-07 15:45:02	t	0101000020E6100000F69D5F94A02952C0B1E1E995B2D64440
3786	80	2008-02-07 15:43:02	2008-02-07 15:45:02	t	0101000020E6100000F69D5F94A02952C0B1E1E995B2D64440
3787	80	2008-02-07 15:44:31	2008-02-07 15:46:31	f	0101000020E61000004391EEE7142A52C08D28ED0DBED64440
3788	80	2008-02-07 15:44:34	2008-02-07 15:46:34	f	0101000020E61000009CA8A5B9152A52C0E960FD9FC3D64440
3789	80	2008-02-07 15:44:59	2008-02-07 15:46:59	f	0101000020E6100000AE1397E3152A52C01B2FDD2406D74440
3790	80	2008-02-07 15:45:11	2008-02-07 15:47:11	t	0101000020E61000004BD3A0681E2A52C0CC9717601FD74440
3791	80	2008-02-07 15:46:01	2008-02-07 15:48:01	t	0101000020E610000020D8F15F202A52C05A2F8672A2D74440
3792	80	2008-02-07 15:46:04	2008-02-07 15:48:04	f	0101000020E6100000801475E61E2A52C076E09C11A5D74440
3793	80	2008-02-07 15:46:15	2008-02-07 15:48:15	f	0101000020E61000001575E61E122A52C0B6679604A8D74440
3794	80	2008-02-07 15:46:43	2008-02-07 15:48:43	f	0101000020E61000005C9544F6412A52C0DA3D7958A8D74440
3795	80	2008-02-07 15:47:12	2008-02-07 15:49:12	t	0101000020E6100000DF550F98872A52C05327A089B0D74440
3796	80	2008-02-07 15:48:01	2008-02-07 15:50:01	t	0101000020E61000000288BB7A152B52C004560E2DB2D74440
3797	80	2008-02-07 15:48:55	2008-02-07 15:50:55	f	0101000020E6100000A24B38F4162B52C0E17F2BD9B1D74440
3798	80	2008-02-07 15:49:45	2008-02-07 15:51:45	f	0101000020E6100000414E98309A2B52C01AC5724BABD74440
3799	80	2008-02-07 15:49:57	2008-02-07 15:51:57	t	0101000020E6100000128942CBBA2B52C09374CDE49BD74440
3800	80	2008-02-07 15:50:07	2008-02-07 15:52:07	t	0101000020E6100000522D228AC92B52C09374CDE49BD74440
3801	80	2008-02-07 15:52:07	2008-02-07 15:54:07	f	0101000020E6100000F8C8E6AA792C52C09374CDE49BD74440
3802	80	2008-02-07 15:52:34	2008-02-07 15:54:34	f	0101000020E6100000E6284014CC2C52C0E1455F419AD74440
3803	80	2008-02-07 15:52:34	2008-02-07 15:54:34	t	0101000020E6100000E6284014CC2C52C0E1455F419AD74440
3804	80	2008-02-07 15:54:34	2008-02-07 15:56:34	f	0101000020E6100000B3B6291E172D52C02F17F19D98D74440
3805	80	2008-02-07 15:55:24	2008-02-07 15:57:24	t	0101000020E61000002FC6C03A8E2D52C0E1455F419AD74440
3806	80	2008-02-07 15:55:27	2008-02-07 15:57:27	t	0101000020E61000003A0CE6AF902D52C061545227A0D74440
3807	80	2008-02-07 15:56:36	2008-02-07 15:58:36	t	0101000020E6100000ACB35A608F2D52C0D0ED258DD1D84440
3808	80	2008-02-07 15:57:04	2008-02-07 15:59:04	t	0101000020E6100000BD1E4C8A8F2D52C0DF718A8EE4D84440
3809	80	2008-02-07 15:57:41	2008-02-07 15:59:41	f	0101000020E61000001636035C902D52C0098A1F63EED84440
3810	80	2008-02-07 15:57:44	2008-02-07 15:59:44	t	0101000020E61000000F1137A7922D52C0B493C151F2D84440
3811	80	2008-02-07 15:57:59	2008-02-07 15:59:59	f	0101000020E61000007AB0C56E9F2D52C034A2B437F8D84440
3812	80	2008-02-07 15:58:04	2008-02-07 16:00:04	f	0101000020E6100000A8CCCD37A22D52C010CCD1E3F7D84440
3813	80	2008-02-07 15:58:41	2008-02-07 16:00:41	t	0101000020E6100000BDAFCA85CA2D52C05E9D6340F6D84440
3814	80	2008-02-07 15:58:50	2008-02-07 16:00:50	t	0101000020E6100000BDAFCA85CA2D52C05E9D6340F6D84440
3815	80	2008-02-07 15:59:19	2008-02-07 16:01:19	t	0101000020E6100000960F41D5E82D52C05E9D6340F6D84440
3816	80	2008-02-07 16:00:12	2008-02-07 16:02:12	f	0101000020E610000012FDDAFAE92D52C0B493C151F2D84440
3817	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3818	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3819	81	2008-02-08 16:48:12	2008-02-08 16:50:12	f	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3820	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3821	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3822	81	2008-02-08 16:48:12	2008-02-08 16:50:12	f	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3823	81	2008-02-08 16:48:12	2008-02-08 16:50:12	f	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3824	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3825	81	2008-02-08 16:48:12	2008-02-08 16:50:12	t	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3826	81	2008-02-08 16:48:12	2008-02-08 16:50:12	f	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3827	81	2008-02-08 16:48:12	2008-02-08 16:50:12	f	0101000020E6100000BD0166BE833152C071033E3F8CCE4440
3828	82	2008-02-05 00:12:48	2008-02-05 00:14:48	t	0101000020E6100000A9DF85ADD93252C09ACE4E0647CF4440
3829	82	2008-02-05 00:17:48	2008-02-05 00:19:48	f	0101000020E610000097749483D93252C0CCEEC9C342CF4440
3830	82	2008-02-05 00:22:48	2008-02-05 00:24:48	f	0101000020E610000097749483D93252C0CCEEC9C342CF4440
3831	82	2008-02-05 00:32:48	2008-02-05 00:34:48	f	0101000020E610000002F73C7FDA3252C08542041C42CF4440
3832	82	2008-02-05 00:37:48	2008-02-05 00:39:48	t	0101000020E6100000665419C6DD3252C00C76C3B645CF4440
3833	82	2008-02-05 00:47:49	2008-02-05 00:49:49	f	0101000020E61000008609A359D93252C0A918E76F42CF4440
3834	82	2008-02-05 00:52:49	2008-02-05 00:54:49	f	0101000020E61000006233C005D93252C09ACE4E0647CF4440
3835	82	2008-02-05 00:57:49	2008-02-05 00:59:49	f	0101000020E610000097749483D93252C08C67D0D03FCF4440
3836	82	2008-02-05 00:57:49	2008-02-05 00:59:49	f	0101000020E610000097749483D93252C08C67D0D03FCF4440
3837	82	2008-02-05 01:02:49	2008-02-05 01:04:49	t	0101000020E6100000CDB56801DA3252C08542041C42CF4440
3838	82	2008-02-05 01:12:48	2008-02-05 01:14:48	f	0101000020E6100000904FC8CEDB3252C0F7E978CC40CF4440
3839	82	2008-02-05 01:17:48	2008-02-05 01:19:48	f	0101000020E6100000373811FDDA3252C03E963E7441CF4440
3840	82	2008-02-05 01:27:48	2008-02-05 01:29:48	t	0101000020E610000014622EA9DA3252C045BB0A293FCF4440
3841	82	2008-02-05 01:37:48	2008-02-05 01:39:48	t	0101000020E61000001B87FA5DD83252C00C76C3B645CF4440
3842	82	2008-02-05 01:42:48	2008-02-05 01:44:48	f	0101000020E610000002F73C7FDA3252C0FED478E926CF4440
3843	82	2008-02-05 01:47:48	2008-02-05 01:49:48	f	0101000020E610000097749483D93252C0BEA4315A47CF4440
3844	82	2008-02-05 01:52:48	2008-02-05 01:54:48	f	0101000020E61000009B95ED43DE3252C07EE36BCF2CCF4440
3845	82	2008-02-05 01:57:48	2008-02-05 01:59:48	f	0101000020E61000000D3D62F4DC3252C08C67D0D03FCF4440
3846	82	2008-02-05 02:32:47	2008-02-05 02:34:47	f	0101000020E61000003B3C84F1D33252C08C84B69C4BCF4440
3847	82	2008-02-05 02:47:48	2008-02-05 02:49:48	t	0101000020E610000017838769DF3252C0F0C4AC1743CF4440
3848	82	2008-02-05 02:52:48	2008-02-05 02:54:48	f	0101000020E610000017838769DF3252C0F0C4AC1743CF4440
3849	82	2008-02-05 02:57:48	2008-02-05 02:59:48	f	0101000020E610000017838769DF3252C0F0C4AC1743CF4440
3850	82	2008-02-05 03:02:48	2008-02-05 03:04:48	t	0101000020E610000097749483D93252C05322895E46CF4440
3851	82	2008-02-05 03:07:47	2008-02-05 03:09:47	t	0101000020E610000097749483D93252C00C76C3B645CF4440
3852	82	2008-02-05 03:12:47	2008-02-05 03:14:47	t	0101000020E6100000B74604E3E03252C06991ED7C3FCF4440
3853	82	2008-02-05 03:17:47	2008-02-05 03:19:47	t	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3854	82	2008-02-05 03:22:47	2008-02-05 03:24:47	f	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3855	82	2008-02-05 03:22:47	2008-02-05 03:24:47	t	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3856	82	2008-02-05 03:27:47	2008-02-05 03:29:47	t	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3857	82	2008-02-05 03:32:47	2008-02-05 03:34:47	f	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3858	82	2008-02-05 03:37:47	2008-02-05 03:39:47	f	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3859	82	2008-02-05 03:42:47	2008-02-05 03:44:47	f	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3860	82	2008-02-05 03:47:48	2008-02-05 03:49:48	f	0101000020E6100000665419C6DD3252C0B745990D32CF4440
3861	82	2008-02-05 03:52:48	2008-02-05 03:54:48	f	0101000020E61000009F996038D73252C062156F641ECF4440
3862	82	2008-02-05 03:57:48	2008-02-05 03:59:48	t	0101000020E610000097749483D93252C0695721E527CF4440
3863	82	2008-02-05 04:02:48	2008-02-05 04:04:48	t	0101000020E6100000A9DF85ADD93252C08C2D043928CF4440
3864	82	2008-02-05 04:07:47	2008-02-05 04:09:47	f	0101000020E6100000A9DF85ADD93252C08C2D043928CF4440
3865	82	2008-02-05 04:12:47	2008-02-05 04:14:47	f	0101000020E6100000A9DF85ADD93252C08C2D043928CF4440
3866	82	2008-02-05 04:17:47	2008-02-05 04:19:47	t	0101000020E6100000A6DB12B9E03252C005C58F3177CF4440
3867	82	2008-02-05 04:22:47	2008-02-05 04:24:47	f	0101000020E610000082053065E03252C0B6F3FDD478CF4440
3868	82	2008-02-05 04:27:47	2008-02-05 04:29:47	t	0101000020E6100000749EB12FD93252C00C3CF71E2ECF4440
3869	82	2008-02-05 04:32:47	2008-02-05 04:34:47	t	0101000020E610000049A30227DB3252C0CCD1E3F736CF4440
3870	82	2008-02-05 04:37:47	2008-02-05 04:39:47	f	0101000020E61000009F996038D73252C09ACE4E0647CF4440
3871	82	2008-02-05 04:42:47	2008-02-05 04:44:47	f	0101000020E6100000091C0934D83252C00551F70148CF4440
3872	82	2008-02-05 04:47:47	2008-02-05 04:49:47	t	0101000020E6100000091C0934D83252C00551F70148CF4440
3873	82	2008-02-05 04:52:47	2008-02-05 04:54:47	f	0101000020E61000008D2E6F0ED73252C061C3D32B65CF4440
3874	82	2008-02-05 04:57:47	2008-02-05 04:59:47	f	0101000020E61000008D2E6F0ED73252C061C3D32B65CF4440
3875	82	2008-02-05 05:02:47	2008-02-05 05:04:47	t	0101000020E6100000FBD170CADC3252C0FE2B2B4D4ACF4440
3876	82	2008-02-05 05:07:47	2008-02-05 05:09:47	t	0101000020E61000006233C005D93252C04C1AA37554CF4440
3877	82	2008-02-05 05:12:47	2008-02-05 05:14:47	t	0101000020E61000008609A359D93252C0378E588B4FCF4440
3878	82	2008-02-05 05:17:47	2008-02-05 05:19:47	t	0101000020E61000003F5DDDB1D83252C0F0FE78AF5ACF4440
3879	82	2008-02-05 05:22:47	2008-02-05 05:24:47	t	0101000020E6100000A9DF85ADD93252C037AB3E575BCF4440
3880	82	2008-02-05 05:27:47	2008-02-05 05:29:47	t	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3881	82	2008-02-05 05:32:47	2008-02-05 05:34:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3882	82	2008-02-05 05:37:47	2008-02-05 05:39:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3883	82	2008-02-05 05:42:47	2008-02-05 05:44:47	t	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3884	82	2008-02-05 05:47:47	2008-02-05 05:49:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3885	82	2008-02-05 05:47:47	2008-02-05 05:49:47	t	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3886	82	2008-02-05 05:52:47	2008-02-05 05:54:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3887	82	2008-02-05 05:57:47	2008-02-05 05:59:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3888	82	2008-02-05 06:02:47	2008-02-05 06:04:47	t	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3889	82	2008-02-05 06:07:47	2008-02-05 06:09:47	t	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3890	82	2008-02-05 06:12:47	2008-02-05 06:14:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3891	82	2008-02-05 06:17:47	2008-02-05 06:19:47	f	0101000020E610000022ACC612D63252C0A2D634EF38CF4440
3892	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3893	83	2008-02-02 21:30:44	2008-02-02 21:32:44	t	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3894	83	2008-02-02 21:30:44	2008-02-02 21:32:44	t	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3895	83	2008-02-02 21:30:44	2008-02-02 21:32:44	t	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3896	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3897	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3898	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3899	83	2008-02-02 21:30:44	2008-02-02 21:32:44	t	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3900	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3901	83	2008-02-02 21:30:44	2008-02-02 21:32:44	t	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3902	83	2008-02-02 21:30:44	2008-02-02 21:32:44	f	0101000020E610000069925852EE3452C0581CCEFC6AD04440
3903	84	2008-02-06 00:05:14	2008-02-06 00:07:14	f	0101000020E6100000C504357C0B3352C0892991442FF54440
3904	84	2008-02-06 00:06:24	2008-02-06 00:08:24	f	0101000020E6100000C504357C0B3352C0ACFF73982FF54440
3905	84	2008-02-06 00:10:16	2008-02-06 00:12:16	f	0101000020E610000086CFD6C1C13252C0D734EF3845F54440
3906	84	2008-02-06 00:11:26	2008-02-06 00:13:26	t	0101000020E6100000C673B680D03252C0C060376C5BF64440
3907	84	2008-02-06 00:15:18	2008-02-06 00:17:18	f	0101000020E61000001EFF0582003352C0EAB298D87CFA4440
3908	84	2008-02-06 00:16:27	2008-02-06 00:18:27	f	0101000020E6100000ED9FA701833252C0EF3D5C72DCFB4440
3909	84	2008-02-06 00:20:19	2008-02-06 00:22:19	f	0101000020E6100000C74CA25EF03152C075C8CD7003FC4440
3910	84	2008-02-06 00:21:29	2008-02-06 00:23:29	f	0101000020E6100000A77A32FFE83152C07DB3CD8DE9FB4440
3911	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3912	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3913	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3914	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3915	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3916	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3917	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3918	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3919	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3920	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3921	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3922	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3923	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3924	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3925	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3926	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3927	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3928	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3929	84	2008-02-06 00:28:27	2008-02-06 00:30:27	f	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3930	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3931	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3932	84	2008-02-06 00:28:27	2008-02-06 00:30:27	t	0101000020E6100000DDBB067DE93152C0A089B0E1E9FB4440
3933	84	2008-02-06 10:22:04	2008-02-06 10:24:04	t	0101000020E6100000C42B499EEB3152C0360708E6E8FB4440
3934	84	2008-02-06 10:23:54	2008-02-06 10:25:54	f	0101000020E61000008EEA7420EB3152C06002B7EEE6FB4440
3935	84	2008-02-06 10:27:05	2008-02-06 10:29:05	t	0101000020E61000000092E9D0E93152C0A089B0E1E9FB4440
3936	84	2008-02-06 10:28:56	2008-02-06 10:30:56	t	0101000020E6100000CB501553E93152C012312592E8FB4440
3937	84	2008-02-06 10:32:07	2008-02-06 10:34:07	f	0101000020E610000036D3BD4EEA3152C0D2A92B9FE5FB4440
3938	84	2008-02-06 10:33:57	2008-02-06 10:35:57	t	0101000020E6100000DDBB067DE93152C012312592E8FB4440
3939	84	2008-02-06 10:37:09	2008-02-06 10:39:09	f	0101000020E6100000473EAF78EA3152C07DB3CD8DE9FB4440
3940	84	2008-02-06 10:38:59	2008-02-06 10:40:59	f	0101000020E610000059A9A0A2EA3152C052B81E85EBFB4440
3941	84	2008-02-06 10:42:10	2008-02-06 10:44:10	f	0101000020E6100000473EAF78EA3152C059DDEA39E9FB4440
3942	84	2008-02-06 10:44:00	2008-02-06 10:46:00	t	0101000020E61000000092E9D0E93152C0EF5A423EE8FB4440
3943	84	2008-02-06 10:47:12	2008-02-06 10:49:12	t	0101000020E610000059A9A0A2EA3152C07DB3CD8DE9FB4440
3944	84	2008-02-06 10:49:02	2008-02-06 10:51:02	f	0101000020E6100000B2C05774EB3152C0EF5A423EE8FB4440
3945	84	2008-02-06 10:54:04	2008-02-06 10:56:04	f	0101000020E61000006B1492CCEA3152C084D89942E7FB4440
3946	84	2008-02-06 10:57:15	2008-02-06 10:59:15	f	0101000020E6100000729010E50B3252C06F4C4F58E2FB4440
3947	84	2008-02-06 10:59:05	2008-02-06 11:01:05	f	0101000020E6100000B408C556D03252C04D327216F6FA4440
3948	84	2008-02-06 11:02:17	2008-02-06 11:04:17	f	0101000020E61000007FE4D6A4DB3252C0F0C4AC1743F74440
3949	84	2008-02-06 11:02:17	2008-02-06 11:04:17	f	0101000020E61000007FE4D6A4DB3252C0F0C4AC1743F74440
3950	84	2008-02-06 11:04:07	2008-02-06 11:06:07	f	0101000020E6100000BF6BD097DE3252C039D6C56D34F64440
3951	84	2008-02-06 11:07:18	2008-02-06 11:09:18	f	0101000020E6100000A9C29FE1CD3252C0B3463D44A3F54440
3952	84	2008-02-06 11:09:09	2008-02-06 11:11:09	t	0101000020E610000098C62FBC923252C083A3E4D539F44440
3953	84	2008-02-06 11:12:20	2008-02-06 11:14:20	t	0101000020E61000007811A628973252C0AE64C74620F04440
3954	84	2008-02-06 11:14:10	2008-02-06 11:16:10	t	0101000020E6100000EDBC8DCD8E3252C0E370E65773EE4440
3955	84	2008-02-06 11:17:22	2008-02-06 11:19:22	t	0101000020E6100000F8C8E6AA793252C068791EDC9DEB4440
3956	84	2008-02-06 11:19:12	2008-02-06 11:21:12	t	0101000020E610000063A2410A9E3252C05A643BDF4FEB4440
3957	84	2008-02-06 11:22:23	2008-02-06 11:24:23	f	0101000020E610000066C39ACAA23252C0E99AC937DBEA4440
3958	84	2008-02-06 11:27:25	2008-02-06 11:29:25	t	0101000020E61000000366BE839F3252C0FF43FAEDEBEA4440
3959	84	2008-02-06 11:29:15	2008-02-06 11:31:15	f	0101000020E61000002602D53F883252C08D62B9A5D5EA4440
3960	84	2008-02-06 11:32:27	2008-02-06 11:34:27	f	0101000020E61000008D63247B843252C039B9DFA128EA4440
3961	84	2008-02-06 11:34:17	2008-02-06 11:36:17	f	0101000020E6100000862172FA7A3252C0091B9E5E29E94440
3962	84	2008-02-06 11:37:28	2008-02-06 11:39:28	f	0101000020E6100000B841EDB7763252C070CE88D2DEE64440
3963	84	2008-02-06 11:42:30	2008-02-06 11:44:30	t	0101000020E6100000CA552C7E533252C095F1EF332EE64440
3964	84	2008-02-06 11:44:20	2008-02-06 11:46:20	f	0101000020E61000008D463EAF783252C0DD41EC4CA1E54440
3965	84	2008-02-06 11:47:32	2008-02-06 11:49:32	f	0101000020E61000006E57E883653252C0F38E537424E54440
3966	84	2008-02-06 11:49:22	2008-02-06 11:51:22	t	0101000020E6100000A398BC01663252C0EC6987BF26E54440
3967	85	2008-02-02 18:45:09	2008-02-02 18:47:09	f	0101000020E6100000DCDD03745F3252C077103B53E8DA4440
3968	85	2008-02-02 18:50:09	2008-02-02 18:52:09	f	0101000020E6100000202FA4C3433052C0F0C4AC1743DB4440
3969	85	2008-02-02 18:55:09	2008-02-02 18:57:09	t	0101000020E6100000422C9B39242D52C01FF98381E7E04440
3970	85	2008-02-02 19:00:09	2008-02-02 19:02:09	t	0101000020E61000001EE21FB6F42852C0EC17EC866DE54440
3971	85	2008-02-02 19:05:09	2008-02-02 19:07:09	f	0101000020E61000001EAD6A49472752C0F8C264AA60EA4440
3972	85	2008-02-02 19:07:43	2008-02-02 19:09:43	f	0101000020E6100000D75240DAFF2652C0DA5A5F24B4EB4440
3973	85	2008-02-02 19:12:43	2008-02-02 19:14:43	f	0101000020E6100000E56723D74D2752C0079964E42CEA4440
3974	85	2008-02-02 19:17:43	2008-02-02 19:19:43	t	0101000020E61000008E0C7217612852C07958A835CDE94440
3975	85	2008-02-02 19:22:43	2008-02-02 19:24:43	t	0101000020E61000000D7217618A2852C0C7BFCFB870EA4440
3976	85	2008-02-02 19:27:43	2008-02-02 19:29:43	t	0101000020E61000003CFDA02E522852C07194BC3AC7EA4440
3977	85	2008-02-02 19:32:43	2008-02-02 19:34:43	t	0101000020E61000001827BEDA512852C00612143FC6EA4440
3978	86	2008-02-06 04:02:28	2008-02-06 04:04:28	t	0101000020E610000016DF50F86C3752C0E813799274D74440
3979	86	2008-02-06 04:07:30	2008-02-06 04:09:30	t	0101000020E610000022037976F93652C0DA03ADC090D74440
3980	86	2008-02-06 04:07:30	2008-02-06 04:09:30	f	0101000020E610000022037976F93652C0DA03ADC090D74440
3981	86	2008-02-06 04:22:36	2008-02-06 04:24:36	f	0101000020E6100000A6677A89B13452C07C6649809AD44440
3982	86	2008-02-06 04:37:42	2008-02-06 04:39:42	f	0101000020E6100000A16D35EB8C2D52C0BB7EC16ED8D84440
3983	86	2008-02-06 04:42:44	2008-02-06 04:44:44	t	0101000020E6100000B5722F302B2A52C0CE531D7233DA4440
3984	86	2008-02-06 04:47:46	2008-02-06 04:49:46	f	0101000020E61000000F85CFD6C12952C0FF78AF5A99DA4440
3985	86	2008-02-06 04:52:48	2008-02-06 04:54:48	f	0101000020E61000004A2A53CC412852C0EEB1F4A10BDC4440
3986	86	2008-02-06 04:57:50	2008-02-06 04:59:50	f	0101000020E61000005C9544F6412852C0F5D6C05609DC4440
3987	86	2008-02-06 05:02:52	2008-02-06 05:04:52	t	0101000020E61000005C9544F6412852C0F5D6C05609DC4440
3988	86	2008-02-06 05:07:54	2008-02-06 05:09:54	f	0101000020E6100000F039B01C212752C0EA4317D4B7DE4440
3989	86	2008-02-06 05:12:56	2008-02-06 05:14:56	t	0101000020E61000005ADE550F982352C08B89CDC7B5DF4440
3990	86	2008-02-06 05:17:58	2008-02-06 05:19:58	t	0101000020E61000006F6AA0F99C2152C016A4198BA6E14440
3991	86	2008-02-06 05:23:00	2008-02-06 05:25:00	t	0101000020E6100000B9B06EBC3B2252C04CE0D6DD3CE74440
3992	86	2008-02-06 05:28:02	2008-02-06 05:30:02	f	0101000020E61000008D9DF0129C2252C001529B38B9ED4440
3993	86	2008-02-06 05:33:04	2008-02-06 05:35:04	f	0101000020E6100000C07E880D162252C0A7B393C151F04440
3994	86	2008-02-06 05:43:08	2008-02-06 05:45:08	f	0101000020E6100000225514AFB21A52C02E39EE940EF44440
3995	86	2008-02-06 05:48:10	2008-02-06 05:50:10	t	0101000020E61000006D96CB46E71652C097E2AAB2EFF44440
3996	86	2008-02-06 05:53:12	2008-02-06 05:55:12	t	0101000020E610000078465B95441252C04243FF0417F54440
3997	86	2008-02-06 05:58:14	2008-02-06 06:00:14	f	0101000020E6100000C482FB010F0E52C044C5387F13F44440
3998	86	2008-02-06 06:03:16	2008-02-06 06:05:16	t	0101000020E610000007B7B585E70D52C022A64412BDF24440
3999	86	2008-02-06 06:08:18	2008-02-06 06:10:18	t	0101000020E61000001D3EE944820B52C05327A089B0F34440
4000	86	2008-02-06 06:13:20	2008-02-06 06:15:20	t	0101000020E6100000225A2BDA1C0752C0B54FC76306F44440
4001	86	2008-02-06 06:18:22	2008-02-06 06:20:22	f	0101000020E610000063F4DC42570452C0C24CDBBFB2F44440
4002	86	2008-02-06 06:23:24	2008-02-06 06:25:24	f	0101000020E610000083E3326E6A0252C0605969520AF84440
4003	86	2008-02-06 06:28:25	2008-02-06 06:30:25	f	0101000020E61000006AC70DBF9B0452C0936FB6B931F74440
4004	86	2008-02-06 06:33:27	2008-02-06 06:35:27	t	0101000020E6100000200DA7CCCD0552C09F5912A0A6F44440
4005	86	2008-02-06 06:38:29	2008-02-06 06:40:29	t	0101000020E61000005EC0CB0C1B0952C0CB32C4B12EF44440
4006	86	2008-02-06 06:43:31	2008-02-06 06:45:31	t	0101000020E610000011EA2285B20C52C0401878EE3DF24440
4007	86	2008-02-06 06:48:33	2008-02-06 06:50:33	t	0101000020E6100000D86A0F7BA10C52C00118CFA0A1F14440
4008	86	2008-02-06 06:53:35	2008-02-06 06:55:35	f	0101000020E6100000C6FF1D51A10C52C048C49448A2F14440
4009	86	2008-02-06 06:58:37	2008-02-06 07:00:37	t	0101000020E6100000C6FF1D51A10C52C0B3463D44A3F14440
4010	86	2008-02-06 07:03:39	2008-02-06 07:05:39	t	0101000020E6100000C6FF1D51A10C52C00118CFA0A1F14440
4011	86	2008-02-06 07:08:41	2008-02-06 07:10:41	t	0101000020E6100000EAD500A5A10C52C048C49448A2F14440
4012	86	2008-02-06 07:13:43	2008-02-06 07:15:43	t	0101000020E6100000C6FF1D51A10C52C0969526A5A0F14440
4013	86	2008-02-06 07:18:45	2008-02-06 07:20:45	f	0101000020E6100000B4942C27A10C52C0BA6B09F9A0F14440
4014	86	2008-02-06 07:23:47	2008-02-06 07:25:47	f	0101000020E6100000B4942C27A10C52C024EEB1F4A1F14440
4015	86	2008-02-06 07:28:49	2008-02-06 07:30:49	t	0101000020E6100000A3293BFDA00C52C048C49448A2F14440
4016	86	2008-02-06 07:33:51	2008-02-06 07:35:51	f	0101000020E6100000C6FF1D51A10C52C024EEB1F4A1F14440
4017	86	2008-02-06 07:38:53	2008-02-06 07:40:53	f	0101000020E6100000FB40F2CEA10C52C06B9A779CA2F14440
4018	86	2008-02-06 07:43:55	2008-02-06 07:45:55	f	0101000020E6100000FB40F2CEA10C52C048C49448A2F14440
4019	86	2008-02-06 07:48:57	2008-02-06 07:50:57	f	0101000020E6100000EAD500A5A10C52C05D50DF32A7F14440
4020	86	2008-02-06 07:48:57	2008-02-06 07:50:57	t	0101000020E6100000EAD500A5A10C52C05D50DF32A7F14440
4021	86	2008-02-06 07:53:59	2008-02-06 07:55:59	t	0101000020E6100000D86A0F7BA10C52C048C49448A2F14440
4022	86	2008-02-06 07:59:01	2008-02-06 08:01:01	t	0101000020E61000001F17D522A20C52C024EEB1F4A1F14440
4023	86	2008-02-06 08:04:02	2008-02-06 08:06:02	t	0101000020E61000001F17D522A20C52C06B9A779CA2F14440
4024	86	2008-02-06 08:09:04	2008-02-06 08:11:04	t	0101000020E610000066C39ACAA20C52C0D61C2098A3F14440
4025	86	2008-02-06 08:14:06	2008-02-06 08:16:06	t	0101000020E61000009B046F48A30C52C0AB21718FA5F14440
4026	86	2008-02-06 08:19:08	2008-02-06 08:21:08	f	0101000020E610000043EDB776A20C52C0D61C2098A3F14440
4027	86	2008-02-06 08:24:10	2008-02-06 08:26:10	f	0101000020E6100000C6FF1D51A10C52C0B3463D44A3F14440
4028	86	2008-02-06 08:29:12	2008-02-06 08:31:12	t	0101000020E6100000D86A0F7BA10C52C0FAF202ECA3F14440
4029	86	2008-02-06 08:34:14	2008-02-06 08:36:14	t	0101000020E6100000D86A0F7BA10C52C0419FC893A4F14440
4030	86	2008-02-06 08:39:16	2008-02-06 08:41:16	f	0101000020E6100000FB40F2CEA10C52C0FAF202ECA3F14440
4031	86	2008-02-06 08:44:18	2008-02-06 08:46:18	t	0101000020E6100000B4942C27A10C52C0D61C2098A3F14440
4032	86	2008-02-06 08:49:20	2008-02-06 08:51:20	f	0101000020E6100000C6FF1D51A10C52C08F705AF0A2F14440
4033	86	2008-02-06 08:54:22	2008-02-06 08:56:22	f	0101000020E6100000C6FF1D51A10C52C06B9A779CA2F14440
4034	86	2008-02-06 08:59:24	2008-02-06 09:01:24	f	0101000020E6100000D86A0F7BA10C52C01DC9E53FA4F14440
4035	86	2008-02-06 09:04:26	2008-02-06 09:06:26	t	0101000020E6100000B4942C27A10C52C0AB21718FA5F14440
4036	86	2008-02-06 09:09:28	2008-02-06 09:11:28	t	0101000020E61000005B7D7555A00C52C00118CFA0A1F14440
4037	86	2008-02-06 09:19:32	2008-02-06 09:21:32	t	0101000020E6100000A3293BFDA00C52C06B9A779CA2F14440
4038	86	2008-02-06 09:24:34	2008-02-06 09:26:34	f	0101000020E6100000D86A0F7BA10C52C08F705AF0A2F14440
4039	86	2008-02-06 09:29:36	2008-02-06 09:31:36	t	0101000020E6100000B4942C27A10C52C06B9A779CA2F14440
4040	86	2008-02-06 09:34:38	2008-02-06 09:36:38	f	0101000020E6100000EAD500A5A10C52C0FAF202ECA3F14440
4041	86	2008-02-06 09:39:39	2008-02-06 09:41:39	f	0101000020E61000000DACE3F8A10C52C08F705AF0A2F14440
4042	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4043	87	2008-02-08 15:08:31	2008-02-08 15:10:31	f	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4044	87	2008-02-08 15:08:31	2008-02-08 15:10:31	f	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4045	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4046	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4047	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4048	87	2008-02-08 15:08:31	2008-02-08 15:10:31	f	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4049	87	2008-02-08 15:08:31	2008-02-08 15:10:31	f	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4050	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4051	87	2008-02-08 15:08:31	2008-02-08 15:10:31	t	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4052	87	2008-02-08 15:08:31	2008-02-08 15:10:31	f	0101000020E6100000AB44D95BCA3352C02861A6ED5FD34440
4053	88	2008-02-04 14:09:27	2008-02-04 14:11:27	f	0101000020E6100000BE5301F73C2D52C0A4C7EF6DFAD54440
4054	88	2008-02-04 14:09:57	2008-02-04 14:11:57	t	0101000020E6100000BE5301F73C2D52C0A4C7EF6DFAD54440
4055	88	2008-02-04 14:10:27	2008-02-04 14:12:27	t	0101000020E6100000ACE80FCD3C2D52C0C79DD2C1FAD54440
4056	88	2008-02-04 14:10:57	2008-02-04 14:12:57	t	0101000020E6100000ACE80FCD3C2D52C0C79DD2C1FAD54440
4057	88	2008-02-04 14:11:27	2008-02-04 14:13:27	t	0101000020E6100000ACE80FCD3C2D52C0C79DD2C1FAD54440
4058	88	2008-02-04 14:11:57	2008-02-04 14:13:57	f	0101000020E61000009A7D1EA33C2D52C0EB73B515FBD54440
4059	88	2008-02-04 14:12:27	2008-02-04 14:14:27	f	0101000020E61000009A7D1EA33C2D52C0EB73B515FBD54440
4060	88	2008-02-04 14:12:57	2008-02-04 14:14:57	t	0101000020E61000009A7D1EA33C2D52C0EB73B515FBD54440
4061	88	2008-02-04 14:13:24	2008-02-04 14:15:24	t	0101000020E610000089122D793C2D52C00E4A9869FBD54440
4062	88	2008-02-04 14:13:54	2008-02-04 14:15:54	t	0101000020E61000009A7D1EA33C2D52C0EB73B515FBD54440
4063	88	2008-02-04 14:14:24	2008-02-04 14:16:24	t	0101000020E6100000C1745AB7412D52C087F9F202ECD54440
4064	88	2008-02-04 14:14:54	2008-02-04 14:16:54	t	0101000020E610000089122D793C2D52C00E4A9869FBD54440
4065	88	2008-02-04 14:14:54	2008-02-04 14:16:54	t	0101000020E610000089122D793C2D52C00E4A9869FBD54440
4066	88	2008-02-04 14:15:24	2008-02-04 14:17:24	t	0101000020E610000089122D793C2D52C0EB73B515FBD54440
4067	88	2008-02-04 14:15:54	2008-02-04 14:17:54	t	0101000020E610000077A73B4F3C2D52C032207BBDFBD54440
4068	88	2008-02-04 14:16:24	2008-02-04 14:18:24	t	0101000020E610000077A73B4F3C2D52C032207BBDFBD54440
4069	88	2008-02-04 14:16:54	2008-02-04 14:18:54	f	0101000020E610000077A73B4F3C2D52C056F65D11FCD54440
4070	88	2008-02-04 14:17:24	2008-02-04 14:19:24	f	0101000020E6100000653C4A253C2D52C079CC4065FCD54440
4071	88	2008-02-04 14:17:54	2008-02-04 14:19:54	f	0101000020E610000053D158FB3B2D52C09DA223B9FCD54440
4072	88	2008-02-04 14:18:24	2008-02-04 14:20:24	f	0101000020E61000003A419B1C3E2D52C00708E6E8F1D54440
4073	88	2008-02-04 14:18:54	2008-02-04 14:20:54	f	0101000020E6100000C578CDAB3A2D52C0F9DA334B02D64440
4074	88	2008-02-04 14:19:24	2008-02-04 14:21:24	t	0101000020E6100000C578CDAB3A2D52C0D50451F701D64440
4075	88	2008-02-04 14:19:54	2008-02-04 14:21:54	t	0101000020E6100000C578CDAB3A2D52C0D50451F701D64440
4076	88	2008-02-04 14:20:24	2008-02-04 14:22:24	f	0101000020E6100000C578CDAB3A2D52C0F9DA334B02D64440
4077	88	2008-02-04 14:20:54	2008-02-04 14:22:54	t	0101000020E6100000C578CDAB3A2D52C0D50451F701D64440
4078	88	2008-02-04 14:21:24	2008-02-04 14:23:24	t	0101000020E6100000C578CDAB3A2D52C0D50451F701D64440
4079	88	2008-02-04 14:21:54	2008-02-04 14:23:54	t	0101000020E61000009037F92D3A2D52C05DFE43FAEDD54440
4080	88	2008-02-04 14:22:24	2008-02-04 14:24:24	f	0101000020E61000007ECC07043A2D52C0ABECBB22F8D54440
4081	88	2008-02-04 14:22:54	2008-02-04 14:24:54	f	0101000020E61000009037F92D3A2D52C0ABECBB22F8D54440
4082	88	2008-02-04 14:23:24	2008-02-04 14:25:24	f	0101000020E61000009037F92D3A2D52C0CEC29E76F8D54440
4083	88	2008-02-04 14:23:54	2008-02-04 14:25:54	f	0101000020E6100000E129E44A3D2D52C0809A5AB6D6D54440
4084	88	2008-02-04 14:24:24	2008-02-04 14:26:24	f	0101000020E61000007ECC07043A2D52C0406A1327F7D54440
4085	88	2008-02-04 14:24:54	2008-02-04 14:26:54	t	0101000020E6100000A1A2EA573A2D52C0B21188D7F5D54440
4086	88	2008-02-04 14:25:24	2008-02-04 14:27:24	t	0101000020E61000009037F92D3A2D52C04F5DF92CCFD54440
4087	88	2008-02-04 14:25:54	2008-02-04 14:27:54	t	0101000020E6100000F394D5743D2D52C016359886E1D54440
4088	88	2008-02-04 14:26:24	2008-02-04 14:28:24	f	0101000020E6100000F394D5743D2D52C016359886E1D54440
4089	88	2008-02-04 14:26:54	2008-02-04 14:28:54	t	0101000020E61000004587C091402D52C0F9669B1BD3D54440
4090	88	2008-02-04 14:27:24	2008-02-04 14:29:24	f	0101000020E61000002CF702B3422D52C08FE4F21FD2D54440
4091	88	2008-02-04 14:27:37	2008-02-04 14:29:37	t	0101000020E6100000375A0EF4502D52C06B0E10CCD1D54440
4092	88	2008-02-04 14:28:07	2008-02-04 14:30:07	t	0101000020E61000006172A3C85A2D52C0800EF3E505D64440
4093	88	2008-02-04 14:29:07	2008-02-04 14:31:07	f	0101000020E61000002BC24D46952D52C0A4E4D53906D64440
4094	88	2008-02-04 14:29:37	2008-02-04 14:31:37	t	0101000020E6100000C47DE4D6A42D52C01D5A643BDFD54440
4095	88	2008-02-04 14:30:07	2008-02-04 14:32:07	t	0101000020E6100000F6BA4560AC2D52C056F146E691D54440
4096	88	2008-02-04 14:30:37	2008-02-04 14:32:37	t	0101000020E6100000E4326E6AA02D52C06CCF2C0950D54440
4097	88	2008-02-04 14:31:07	2008-02-04 14:33:07	t	0101000020E610000004E8F7FD9B2D52C03A75E5B33CD54440
4098	88	2008-02-04 14:31:37	2008-02-04 14:33:37	t	0101000020E610000081B8AB57912D52C025AFCE3120D54440
4099	88	2008-02-04 14:32:07	2008-02-04 14:34:07	f	0101000020E6100000610322C4952D52C0A69BC420B0D44440
4100	88	2008-02-04 14:32:37	2008-02-04 14:34:37	f	0101000020E610000084D90418962D52C075B0FECF61D44440
4101	88	2008-02-04 14:33:07	2008-02-04 14:35:07	f	0101000020E6100000414E98309A2D52C0448B6CE7FBD34440
4102	88	2008-02-04 14:33:37	2008-02-04 14:35:37	f	0101000020E6100000F611F8C3CF2D52C012DA722EC5D34440
4103	88	2008-02-04 14:34:07	2008-02-04 14:36:07	t	0101000020E610000040C7478B332E52C061AB048BC3D34440
4104	88	2008-02-04 14:34:37	2008-02-04 14:36:37	t	0101000020E61000000ADD2571562E52C08481E7DEC3D34440
4105	88	2008-02-04 14:35:07	2008-02-04 14:37:07	f	0101000020E61000000AFA0B3D622E52C08B6CE7FBA9D34440
4106	88	2008-02-04 14:35:37	2008-02-04 14:37:37	t	0101000020E6100000154031B2642E52C06F9EEA909BD34440
4107	88	2008-02-04 14:35:45	2008-02-04 14:37:45	f	0101000020E6100000154031B2642E52C06F9EEA909BD34440
4108	88	2008-02-04 14:36:45	2008-02-04 14:38:45	t	0101000020E61000009F776341612E52C0053411363CD34440
4109	88	2008-02-04 14:37:15	2008-02-04 14:39:15	f	0101000020E610000035F5BA45602E52C02F51BD35B0D34440
4110	88	2008-02-04 14:37:15	2008-02-04 14:39:15	t	0101000020E610000035F5BA45602E52C02F51BD35B0D34440
4111	88	2008-02-04 14:37:45	2008-02-04 14:39:45	f	0101000020E6100000EE48F59D5F2E52C092CB7F48BFD34440
4112	88	2008-02-04 14:38:15	2008-02-04 14:40:15	t	0101000020E610000038161406652E52C0A132FE7DC6D34440
4113	88	2008-02-04 14:38:45	2008-02-04 14:40:45	f	0101000020E61000008D63247B842E52C0D9942BBCCBD34440
4114	88	2008-02-04 14:39:15	2008-02-04 14:41:15	f	0101000020E6100000E6B4A7E49C2E52C08BC3995FCDD34440
4115	88	2008-02-04 14:39:45	2008-02-04 14:41:45	t	0101000020E6100000D14543C6A32E52C0FD6A0E10CCD34440
4116	88	2008-02-04 14:40:15	2008-02-04 14:42:15	t	0101000020E6100000D14543C6A32E52C0FD6A0E10CCD34440
4117	88	2008-02-06 00:01:54	2008-02-06 00:03:54	f	0101000020E6100000A2D79FC4E70452C0E0A128D027F44440
4118	88	2008-02-06 00:02:24	2008-02-06 00:04:24	f	0101000020E6100000A2D79FC4E70452C0BCCB457C27F44440
4119	88	2008-02-06 00:02:54	2008-02-06 00:04:54	t	0101000020E6100000906CAE9AE70452C0BCCB457C27F44440
4120	88	2008-02-06 00:03:24	2008-02-06 00:05:24	f	0101000020E6100000906CAE9AE70452C099F5622827F44440
4121	88	2008-02-06 00:03:54	2008-02-06 00:05:54	t	0101000020E6100000906CAE9AE70452C099F5622827F44440
4122	88	2008-02-06 00:04:24	2008-02-06 00:06:24	f	0101000020E6100000906CAE9AE70452C099F5622827F44440
4123	88	2008-02-06 00:04:54	2008-02-06 00:06:54	t	0101000020E6100000906CAE9AE70452C0751F80D426F44440
4124	88	2008-02-06 00:04:54	2008-02-06 00:06:54	t	0101000020E6100000906CAE9AE70452C0751F80D426F44440
4125	88	2008-02-06 00:05:24	2008-02-06 00:07:24	f	0101000020E6100000906CAE9AE70452C0751F80D426F44440
4126	88	2008-02-06 00:05:24	2008-02-06 00:07:24	f	0101000020E6100000906CAE9AE70452C0751F80D426F44440
4127	88	2008-02-06 00:05:54	2008-02-06 00:07:54	f	0101000020E6100000906CAE9AE70452C0751F80D426F44440
4128	68	2008-02-02 18:12:50	2008-02-02 18:14:50	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4129	68	2008-02-02 18:12:53	2008-02-02 18:14:53	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4130	68	2008-02-02 18:12:54	2008-02-02 18:14:54	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4131	68	2008-02-02 18:13:00	2008-02-02 18:15:00	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4132	68	2008-02-02 18:13:01	2008-02-02 18:15:01	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4133	68	2008-02-02 18:13:02	2008-02-02 18:15:02	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4134	68	2008-02-02 18:13:03	2008-02-02 18:15:03	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4135	68	2008-02-02 18:13:04	2008-02-02 18:15:04	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4136	68	2008-02-02 18:13:05	2008-02-02 18:15:05	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4137	68	2008-02-02 18:13:06	2008-02-02 18:15:06	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4138	68	2008-02-02 18:13:07	2008-02-02 18:15:07	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4139	68	2008-02-02 18:13:08	2008-02-02 18:15:08	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4140	68	2008-02-02 18:13:09	2008-02-02 18:15:09	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4141	68	2008-02-02 18:13:12	2008-02-02 18:15:12	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4142	68	2008-02-02 18:13:13	2008-02-02 18:15:13	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4143	68	2008-02-02 18:13:14	2008-02-02 18:15:14	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4144	68	2008-02-02 18:13:16	2008-02-02 18:15:16	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4145	68	2008-02-02 18:13:17	2008-02-02 18:15:17	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4146	68	2008-02-02 18:13:18	2008-02-02 18:15:18	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4147	68	2008-02-02 18:13:19	2008-02-02 18:15:19	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4148	68	2008-02-02 18:13:20	2008-02-02 18:15:20	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4149	68	2008-02-02 18:13:21	2008-02-02 18:15:21	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4150	68	2008-02-02 18:13:22	2008-02-02 18:15:22	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4151	68	2008-02-02 18:13:23	2008-02-02 18:15:23	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4152	68	2008-02-02 18:13:24	2008-02-02 18:15:24	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4153	68	2008-02-02 18:13:25	2008-02-02 18:15:25	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4154	68	2008-02-02 18:13:26	2008-02-02 18:15:26	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4155	68	2008-02-02 18:13:27	2008-02-02 18:15:27	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4156	68	2008-02-02 18:13:28	2008-02-02 18:15:28	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4157	68	2008-02-02 18:13:29	2008-02-02 18:15:29	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4158	68	2008-02-02 18:13:30	2008-02-02 18:15:30	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4159	68	2008-02-02 18:13:31	2008-02-02 18:15:31	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4160	68	2008-02-02 18:13:32	2008-02-02 18:15:32	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4161	68	2008-02-02 18:13:36	2008-02-02 18:15:36	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4162	68	2008-02-02 18:13:37	2008-02-02 18:15:37	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4163	68	2008-02-02 18:13:38	2008-02-02 18:15:38	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4164	68	2008-02-02 18:13:40	2008-02-02 18:15:40	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4165	68	2008-02-02 18:13:42	2008-02-02 18:15:42	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4166	68	2008-02-02 18:13:43	2008-02-02 18:15:43	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4167	68	2008-02-02 18:13:45	2008-02-02 18:15:45	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4168	68	2008-02-02 18:13:46	2008-02-02 18:15:46	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4169	68	2008-02-02 18:13:46	2008-02-02 18:15:46	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4170	68	2008-02-02 18:13:51	2008-02-02 18:15:51	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4171	68	2008-02-02 18:13:55	2008-02-02 18:15:55	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4172	68	2008-02-02 18:13:56	2008-02-02 18:15:56	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4173	68	2008-02-02 18:13:58	2008-02-02 18:15:58	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4174	68	2008-02-02 18:14:00	2008-02-02 18:16:00	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4175	68	2008-02-02 18:14:03	2008-02-02 18:16:03	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4176	68	2008-02-02 18:14:04	2008-02-02 18:16:04	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4177	68	2008-02-02 18:14:05	2008-02-02 18:16:05	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4178	68	2008-02-02 18:14:06	2008-02-02 18:16:06	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4179	68	2008-02-02 18:14:08	2008-02-02 18:16:08	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4180	68	2008-02-02 18:14:09	2008-02-02 18:16:09	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4181	68	2008-02-02 18:14:10	2008-02-02 18:16:10	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4182	68	2008-02-02 18:14:11	2008-02-02 18:16:11	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4183	68	2008-02-02 18:14:12	2008-02-02 18:16:12	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4184	68	2008-02-02 18:14:13	2008-02-02 18:16:13	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4185	68	2008-02-02 18:14:14	2008-02-02 18:16:14	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4186	68	2008-02-02 18:14:15	2008-02-02 18:16:15	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4187	68	2008-02-02 18:14:16	2008-02-02 18:16:16	t	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4188	68	2008-02-02 18:14:17	2008-02-02 18:16:17	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4189	68	2008-02-02 18:14:18	2008-02-02 18:16:18	f	0101000020E61000006FF607CA6D2152C0B0AC342905CB4440
4190	68	2008-02-05 21:08:34	2008-02-05 21:10:34	t	0101000020E610000041A03369532352C027A089B0E1CB4440
4191	68	2008-02-05 21:08:35	2008-02-05 21:10:35	t	0101000020E610000041A03369532352C027A089B0E1CB4440
4192	68	2008-02-05 21:08:36	2008-02-05 21:10:36	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4193	68	2008-02-05 21:08:37	2008-02-05 21:10:37	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4194	68	2008-02-05 21:08:38	2008-02-05 21:10:38	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4195	68	2008-02-05 21:08:39	2008-02-05 21:10:39	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4196	68	2008-02-05 21:08:40	2008-02-05 21:10:40	t	0101000020E610000041A03369532352C027A089B0E1CB4440
4197	68	2008-02-05 21:08:41	2008-02-05 21:10:41	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4198	68	2008-02-05 21:08:42	2008-02-05 21:10:42	t	0101000020E610000041A03369532352C027A089B0E1CB4440
4199	68	2008-02-05 21:08:43	2008-02-05 21:10:43	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4200	68	2008-02-05 21:08:44	2008-02-05 21:10:44	f	0101000020E610000041A03369532352C027A089B0E1CB4440
4201	89	2008-02-08 05:10:28	2008-02-08 05:12:28	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4202	89	2008-02-08 05:15:30	2008-02-08 05:17:30	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4203	89	2008-02-08 05:20:32	2008-02-08 05:22:32	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4204	89	2008-02-08 05:25:34	2008-02-08 05:27:34	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4205	89	2008-02-08 05:30:36	2008-02-08 05:32:36	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4206	89	2008-02-08 05:35:37	2008-02-08 05:37:37	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4207	89	2008-02-08 05:40:39	2008-02-08 05:42:39	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4208	89	2008-02-08 05:45:41	2008-02-08 05:47:41	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4209	89	2008-02-08 05:50:43	2008-02-08 05:52:43	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4210	89	2008-02-08 05:55:44	2008-02-08 05:57:44	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4211	89	2008-02-08 06:00:46	2008-02-08 06:02:46	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4212	89	2008-02-08 06:05:48	2008-02-08 06:07:48	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4213	89	2008-02-08 06:10:50	2008-02-08 06:12:50	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4214	89	2008-02-08 06:15:52	2008-02-08 06:17:52	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4215	89	2008-02-08 06:20:53	2008-02-08 06:22:53	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4216	89	2008-02-08 06:25:55	2008-02-08 06:27:55	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4217	89	2008-02-08 06:30:57	2008-02-08 06:32:57	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4218	89	2008-02-08 06:35:59	2008-02-08 06:37:59	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4219	89	2008-02-08 06:41:01	2008-02-08 06:43:01	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4220	89	2008-02-08 06:46:02	2008-02-08 06:48:02	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4221	89	2008-02-08 06:51:04	2008-02-08 06:53:04	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4222	89	2008-02-08 06:56:06	2008-02-08 06:58:06	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4223	89	2008-02-08 07:01:08	2008-02-08 07:03:08	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4224	89	2008-02-08 07:06:10	2008-02-08 07:08:10	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4225	89	2008-02-08 07:06:10	2008-02-08 07:08:10	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4226	89	2008-02-08 07:11:11	2008-02-08 07:13:11	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4227	89	2008-02-08 07:16:13	2008-02-08 07:18:13	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4228	89	2008-02-08 07:21:15	2008-02-08 07:23:15	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4229	89	2008-02-08 07:26:17	2008-02-08 07:28:17	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4230	89	2008-02-08 07:31:18	2008-02-08 07:33:18	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4231	89	2008-02-08 07:36:20	2008-02-08 07:38:20	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4232	89	2008-02-08 07:41:22	2008-02-08 07:43:22	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4233	89	2008-02-08 07:46:24	2008-02-08 07:48:24	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4234	89	2008-02-08 07:51:26	2008-02-08 07:53:26	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4235	89	2008-02-08 07:56:27	2008-02-08 07:58:27	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4236	89	2008-02-08 08:01:28	2008-02-08 08:03:28	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4237	89	2008-02-08 08:06:30	2008-02-08 08:08:30	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4238	89	2008-02-08 08:11:32	2008-02-08 08:13:32	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4239	89	2008-02-08 08:16:34	2008-02-08 08:18:34	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4240	89	2008-02-08 08:21:35	2008-02-08 08:23:35	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4241	89	2008-02-08 08:26:37	2008-02-08 08:28:37	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4242	89	2008-02-08 08:31:39	2008-02-08 08:33:39	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4243	89	2008-02-08 08:36:41	2008-02-08 08:38:41	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4244	89	2008-02-08 08:41:42	2008-02-08 08:43:42	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4245	89	2008-02-08 08:46:44	2008-02-08 08:48:44	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4246	89	2008-02-08 08:51:46	2008-02-08 08:53:46	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4247	89	2008-02-08 08:56:48	2008-02-08 08:58:48	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4248	89	2008-02-08 09:01:50	2008-02-08 09:03:50	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4249	89	2008-02-08 09:06:51	2008-02-08 09:08:51	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4250	89	2008-02-08 09:06:51	2008-02-08 09:08:51	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4251	89	2008-02-08 09:11:53	2008-02-08 09:13:53	t	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4252	89	2008-02-08 09:16:55	2008-02-08 09:18:55	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4253	89	2008-02-08 09:21:57	2008-02-08 09:23:57	f	0101000020E6100000B7D782DE1B4952C085251E5036AB4440
4254	89	2008-02-08 09:26:59	2008-02-08 09:28:59	f	0101000020E6100000E2D231E7194952C0D3F6AFAC34AB4440
4255	89	2008-02-08 09:32:00	2008-02-08 09:34:00	t	0101000020E6100000FE0FB056ED4852C0DC9DB5DB2EAE4440
4256	89	2008-02-08 09:37:02	2008-02-08 09:39:02	f	0101000020E610000032EC3026FD4752C0815B77F354B54440
4257	89	2008-02-08 09:42:04	2008-02-08 09:44:04	f	0101000020E61000000EDC813AE54552C08811C2A38DBD4440
4258	89	2008-02-08 09:47:06	2008-02-08 09:49:06	t	0101000020E61000007CBE66B96C4252C04A809A5AB6C44440
4259	89	2008-02-08 09:52:07	2008-02-08 09:54:07	f	0101000020E610000050EACBD24E3F52C0A12DE7525CCB4440
4260	89	2008-02-08 09:57:09	2008-02-08 09:59:09	f	0101000020E61000000D03965CC53C52C067614F3BFCCF4440
4261	89	2008-02-08 10:02:11	2008-02-08 10:04:11	t	0101000020E6100000346953758F3852C0693A3B191CD34440
4262	89	2008-02-08 10:07:13	2008-02-08 10:09:13	t	0101000020E6100000348639419B3652C0C8293A92CBD14440
4263	89	2008-02-08 10:12:15	2008-02-08 10:14:15	t	0101000020E61000008F3C1059A43552C057CF49EF1BD14440
4264	89	2008-02-08 10:17:16	2008-02-08 10:19:16	f	0101000020E610000006F69848693652C024456458C5D14440
4265	90	2008-02-08 06:43:19	2008-02-08 06:45:19	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4266	90	2008-02-08 06:43:26	2008-02-08 06:45:26	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4267	90	2008-02-08 06:48:21	2008-02-08 06:50:21	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4268	90	2008-02-08 06:48:27	2008-02-08 06:50:27	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4269	90	2008-02-08 06:53:23	2008-02-08 06:55:23	t	0101000020E610000042498105301F52C07CB8E4B853F84440
4270	90	2008-02-08 06:53:29	2008-02-08 06:55:29	t	0101000020E610000042498105301F52C07CB8E4B853F84440
4271	90	2008-02-08 06:58:25	2008-02-08 07:00:25	t	0101000020E610000042498105301F52C07CB8E4B853F84440
4272	90	2008-02-08 06:58:31	2008-02-08 07:00:31	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4273	90	2008-02-08 07:03:26	2008-02-08 07:05:26	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4274	90	2008-02-08 07:03:33	2008-02-08 07:05:33	t	0101000020E610000042498105301F52C07CB8E4B853F84440
4275	90	2008-02-08 07:08:27	2008-02-08 07:10:27	f	0101000020E610000042498105301F52C07CB8E4B853F84440
4276	91	2008-02-02 17:17:59	2008-02-02 17:19:59	f	0101000020E6100000D57E6B274A3252C0FE60E0B9F7DA4440
4277	91	2008-02-02 17:17:59	2008-02-02 17:19:59	t	0101000020E6100000D57E6B274A3252C0FE60E0B9F7DA4440
4278	91	2008-02-02 17:21:04	2008-02-02 17:23:04	t	0101000020E610000075EB353D283252C043FF04172BDC4440
4279	91	2008-02-02 17:23:00	2008-02-02 17:25:00	t	0101000020E61000008A7780272D3252C00ABFD4CF9BDC4440
4280	91	2008-02-02 17:26:06	2008-02-02 17:28:06	t	0101000020E6100000914AB1A3713252C06DE7FBA9F1DC4440
4281	91	2008-02-02 17:28:02	2008-02-02 17:30:02	f	0101000020E6100000317DAF21383252C042EC4CA1F3DC4440
4282	91	2008-02-02 17:31:08	2008-02-02 17:33:08	f	0101000020E6100000A471A8DF853152C0F3599E0777DD4440
4283	91	2008-02-02 17:33:04	2008-02-02 17:35:04	t	0101000020E61000006689CE328B3052C03485CE6BECDC4440
4284	91	2008-02-02 17:36:10	2008-02-02 17:38:10	f	0101000020E6100000D926158DB52F52C02FA86F99D3DB4440
4285	91	2008-02-02 17:38:06	2008-02-02 17:40:06	t	0101000020E610000041DAFF006B2F52C07E1D386744DB4440
4286	91	2008-02-02 17:41:11	2008-02-02 17:43:11	f	0101000020E6100000F2D3B837BF2F52C0F8E461A1D6DA4440
4287	91	2008-02-02 17:43:08	2008-02-02 17:45:08	f	0101000020E610000065B0E2546B2F52C04D2D5BEB8BDA4440
4288	91	2008-02-02 17:48:09	2008-02-02 17:50:09	f	0101000020E610000087C5A86BED2F52C066C22FF5F3D84440
4289	91	2008-02-02 17:53:11	2008-02-02 17:55:11	f	0101000020E610000054E9279CDD3052C0740CC85EEFD84440
4290	91	2008-02-02 17:56:17	2008-02-02 17:58:17	f	0101000020E61000008CA2073E063152C0026553AEF0D84440
4291	91	2008-02-02 17:58:13	2008-02-02 18:00:13	t	0101000020E6100000CC46E7FC143152C0BBB88D06F0D84440
4292	91	2008-02-02 18:03:15	2008-02-02 18:05:15	f	0101000020E6100000E914E467233152C04CE0D6DD3CD74440
4293	91	2008-02-02 18:06:20	2008-02-02 18:08:20	f	0101000020E610000030185C73473152C0C63368E89FD64440
4294	91	2008-02-02 18:06:20	2008-02-02 18:08:20	f	0101000020E610000030185C73473152C0C63368E89FD64440
4295	91	2008-02-02 18:08:17	2008-02-02 18:10:17	f	0101000020E61000004E9D47C5FF3152C0EA094B3CA0D64440
4296	91	2008-02-02 18:11:22	2008-02-02 18:13:22	f	0101000020E6100000790C8FFD2C3252C00DE02D90A0D64440
4297	91	2008-02-02 18:13:18	2008-02-02 18:15:18	t	0101000020E6100000513239B5333252C072FE261422D64440
4298	91	2008-02-02 18:18:20	2008-02-02 18:20:20	t	0101000020E61000001FA8531EDD3252C0884B8E3BA5D54440
4299	91	2008-02-02 18:21:26	2008-02-02 18:23:26	t	0101000020E610000041BD19355F3352C0EC8B84B69CD54440
4300	91	2008-02-02 18:23:22	2008-02-02 18:25:22	t	0101000020E610000093239D81913352C01DACFF7398D54440
4301	91	2008-02-02 18:26:28	2008-02-02 18:28:28	f	0101000020E6100000F94F3750E03352C08A07944DB9D44440
4302	91	2008-02-02 18:28:24	2008-02-02 18:30:24	f	0101000020E61000000EA7CCCD373452C04A63B48EAAD44440
4303	91	2008-02-02 18:31:29	2008-02-02 18:33:29	t	0101000020E6100000F56DC1525D3452C0971C774A07D54440
4304	91	2008-02-02 18:33:26	2008-02-02 18:35:26	t	0101000020E61000008D63247B843452C0977329AE2AD54440
4305	91	2008-02-02 18:36:31	2008-02-02 18:38:31	t	0101000020E61000009B0986730D3552C0FBB31F2922D54440
4306	91	2008-02-02 18:38:27	2008-02-02 18:40:27	t	0101000020E61000003E9CC0745A3552C083A8FB00A4D44440
4307	91	2008-02-02 18:43:29	2008-02-02 18:45:29	t	0101000020E6100000013620425C3552C026C79DD2C1D44440
4308	91	2008-02-02 18:46:35	2008-02-02 18:48:35	t	0101000020E61000004C5AF10D853552C0265305A392D44440
4309	91	2008-02-02 18:48:31	2008-02-02 18:50:31	f	0101000020E6100000F9E0B54B1B3652C0422619390BD54440
4310	91	2008-02-02 18:51:37	2008-02-02 18:53:37	t	0101000020E61000006EA983BC1E3652C09DD7D825AAD54440
4311	91	2008-02-02 18:53:33	2008-02-02 18:55:33	f	0101000020E61000005C3E92921E3652C0320395F1EFD54440
4312	91	2008-02-02 18:56:38	2008-02-02 18:58:38	t	0101000020E6100000A3EA573A1F3652C0696FF085C9D64440
4313	91	2008-02-02 18:58:35	2008-02-02 19:00:35	t	0101000020E61000001C9AB2D30F3652C0F0C4AC1743D74440
4314	91	2008-02-02 19:01:40	2008-02-02 19:03:40	t	0101000020E610000099C11891283652C03580B74082D84440
4315	91	2008-02-02 19:06:42	2008-02-02 19:08:42	t	0101000020E61000004C2025766D3552C0AA9F3715A9DA4440
4316	91	2008-02-02 19:08:38	2008-02-02 19:10:38	t	0101000020E61000008DBAD6DEA73452C0EF552B137EDB4440
4317	91	2008-02-02 19:11:44	2008-02-02 19:13:44	f	0101000020E6100000AABD88B6633452C0745E6397A8DC4440
4318	91	2008-02-02 19:13:40	2008-02-02 19:15:40	t	0101000020E6100000317DAF21383452C0ADC090D5ADDC4440
4319	91	2008-02-02 19:16:45	2008-02-02 19:18:45	f	0101000020E610000091D61874423452C0F46C567DAEDC4440
4320	91	2008-02-02 19:18:42	2008-02-02 19:20:42	t	0101000020E6100000E46C3A02B83352C098512CB7B4DC4440
4321	91	2008-02-02 19:21:47	2008-02-02 19:23:47	t	0101000020E6100000EB961DE21F3452C0922232ACE2DB4440
4322	91	2008-02-02 19:23:44	2008-02-02 19:25:44	t	0101000020E6100000AEA415DF503452C085D382177DDB4440
4323	91	2008-02-02 19:26:49	2008-02-02 19:28:49	t	0101000020E61000002D7E5358A93452C0E78C28ED0DDC4440
4324	91	2008-02-02 19:28:45	2008-02-02 19:30:45	f	0101000020E61000007ECC07043A3552C0D1B359F5B9DC4440
4325	91	2008-02-02 19:31:51	2008-02-02 19:33:51	f	0101000020E6100000CCBA7F2C443552C080D93D7958DE4440
4326	91	2008-02-02 19:33:47	2008-02-02 19:35:47	t	0101000020E610000017889E94493552C00E6C956071DE4440
4327	91	2008-02-02 19:36:53	2008-02-02 19:38:53	f	0101000020E6100000DD990986733552C0BE30992A18DF4440
4328	91	2008-02-02 19:38:49	2008-02-02 19:40:49	t	0101000020E6100000B32AC24D463552C0B18A37328FDE4440
4329	91	2008-02-02 19:41:54	2008-02-02 19:43:54	f	0101000020E61000008886C5A86B3552C03AAFB14B54DD4440
4330	91	2008-02-02 19:43:51	2008-02-02 19:45:51	f	0101000020E61000001575E61E123652C0B37BF2B050DD4440
4331	91	2008-02-02 19:46:56	2008-02-02 19:48:56	t	0101000020E6100000F1F5B52E353652C08CF84ECC7ADB4440
4332	91	2008-02-02 19:48:53	2008-02-02 19:50:53	t	0101000020E6100000A32424D2363652C0AB436E861BDA4440
4333	91	2008-02-02 19:51:58	2008-02-02 19:53:58	f	0101000020E61000003C376DC6693652C0323D618907DA4440
4334	91	2008-02-02 19:53:54	2008-02-02 19:55:54	t	0101000020E61000003C71395E813652C0E3FC4D2844DA4440
4335	91	2008-02-02 19:57:00	2008-02-02 19:59:00	f	0101000020E61000008886C5A86B3752C00551F70148DB4440
4336	91	2008-02-02 19:58:56	2008-02-02 20:00:56	t	0101000020E610000056A01683873752C05A643BDF4FDB4440
4337	91	2008-02-02 20:02:02	2008-02-02 20:04:02	f	0101000020E61000009CFF571D393852C0FD304278B4DB4440
4338	91	2008-02-02 20:03:58	2008-02-02 20:05:58	t	0101000020E61000000B4CA7751B3852C09964E42CECDB4440
4339	91	2008-02-02 20:07:03	2008-02-02 20:09:03	f	0101000020E61000007C67B455493852C058569A9482DC4440
4340	92	2008-02-04 14:07:48	2008-02-04 14:09:48	t	0101000020E61000009B266C3F193752C0446E861BF0D34440
4341	92	2008-02-04 14:16:22	2008-02-04 14:18:22	t	0101000020E610000030A4C343183752C0EF3D5C72DCD34440
4342	92	2008-02-04 14:17:51	2008-02-04 14:19:51	t	0101000020E6100000FE8348861C3752C092054CE0D6D34440
4343	92	2008-02-04 14:21:24	2008-02-04 14:23:24	f	0101000020E61000007B71E2AB1D3752C019390B7BDAD34440
4344	92	2008-02-04 14:22:53	2008-02-04 14:24:53	f	0101000020E610000045300E2E1D3752C0F6622827DAD34440
4345	92	2008-02-04 14:26:25	2008-02-04 14:28:25	t	0101000020E6100000D78C0C72173752C03D0FEECEDAD34440
4346	92	2008-02-04 14:31:27	2008-02-04 14:33:27	t	0101000020E610000002A5A146213752C0FD87F4DBD7D34440
4347	92	2008-02-04 14:32:56	2008-02-04 14:34:56	f	0101000020E6100000579BFF571D3752C06F2F698CD6D34440
4348	92	2008-02-04 14:36:29	2008-02-04 14:38:29	t	0101000020E6100000B7D782DE1B3752C0AFB6627FD9D34440
4349	92	2008-02-04 14:37:58	2008-02-04 14:39:58	f	0101000020E61000007B71E2AB1D3752C0F6622827DAD34440
4350	92	2008-02-04 14:41:30	2008-02-04 14:43:30	t	0101000020E6100000702BBD361B3752C06F2F698CD6D34440
4351	93	2008-02-05 07:21:40	2008-02-05 07:23:40	t	0101000020E6100000121AC1C6F51B52C0CD920035B5D64440
4352	93	2008-02-05 07:22:10	2008-02-05 07:24:10	t	0101000020E6100000121AC1C6F51B52C0CD920035B5D64440
4353	93	2008-02-05 07:22:40	2008-02-05 07:24:40	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4354	93	2008-02-05 07:23:40	2008-02-05 07:25:40	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4355	93	2008-02-05 07:24:10	2008-02-05 07:26:10	f	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4356	93	2008-02-05 07:24:40	2008-02-05 07:26:40	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4357	93	2008-02-05 07:25:40	2008-02-05 07:27:40	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4358	93	2008-02-05 07:26:10	2008-02-05 07:28:10	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4359	93	2008-02-05 07:27:10	2008-02-05 07:29:10	t	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4360	93	2008-02-05 07:27:40	2008-02-05 07:29:40	f	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4361	93	2008-02-05 07:28:10	2008-02-05 07:30:10	f	0101000020E61000002485B2F0F51B52C0CD920035B5D64440
4362	93	2008-02-05 07:29:10	2008-02-05 07:31:10	t	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4363	93	2008-02-05 07:29:40	2008-02-05 07:31:40	t	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4364	93	2008-02-05 07:30:40	2008-02-05 07:32:40	f	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4365	93	2008-02-05 07:31:10	2008-02-05 07:33:10	f	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4366	93	2008-02-05 07:31:40	2008-02-05 07:33:40	t	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4367	93	2008-02-05 07:32:10	2008-02-05 07:34:10	t	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4368	93	2008-02-05 07:32:40	2008-02-05 07:34:40	f	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4369	93	2008-02-05 07:34:10	2008-02-05 07:36:10	f	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4370	93	2008-02-05 07:34:10	2008-02-05 07:36:10	f	0101000020E610000035F0A31AF61B52C0AABC1DE1B4D64440
4371	93	2008-02-05 07:34:40	2008-02-05 07:36:40	f	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4372	93	2008-02-05 07:35:10	2008-02-05 07:37:10	f	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4373	93	2008-02-05 07:35:40	2008-02-05 07:37:40	t	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4374	93	2008-02-05 07:36:10	2008-02-05 07:38:10	f	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4375	93	2008-02-05 07:36:40	2008-02-05 07:38:40	t	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4376	93	2008-02-05 07:37:10	2008-02-05 07:39:10	t	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4377	93	2008-02-05 07:37:40	2008-02-05 07:39:40	t	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4378	93	2008-02-05 07:38:10	2008-02-05 07:40:10	f	0101000020E610000035F0A31AF61B52C086E63A8DB4D64440
4379	93	2008-02-05 07:39:09	2008-02-05 07:41:09	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4380	93	2008-02-05 07:39:39	2008-02-05 07:41:39	t	0101000020E610000035F0A31AF61B52C062105839B4D64440
4381	93	2008-02-05 07:40:09	2008-02-05 07:42:09	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4382	93	2008-02-05 07:40:39	2008-02-05 07:42:39	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4383	93	2008-02-05 07:41:09	2008-02-05 07:43:09	t	0101000020E610000035F0A31AF61B52C062105839B4D64440
4384	93	2008-02-05 07:41:39	2008-02-05 07:43:39	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4385	93	2008-02-05 07:42:09	2008-02-05 07:44:09	t	0101000020E610000035F0A31AF61B52C062105839B4D64440
4386	93	2008-02-05 07:42:39	2008-02-05 07:44:39	t	0101000020E610000035F0A31AF61B52C062105839B4D64440
4387	93	2008-02-05 07:43:09	2008-02-05 07:45:09	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4388	93	2008-02-05 07:43:39	2008-02-05 07:45:39	t	0101000020E610000035F0A31AF61B52C062105839B4D64440
4389	93	2008-02-05 07:44:09	2008-02-05 07:46:09	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4390	93	2008-02-05 07:44:39	2008-02-05 07:46:39	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4391	93	2008-02-05 07:45:09	2008-02-05 07:47:09	f	0101000020E610000035F0A31AF61B52C062105839B4D64440
4392	93	2008-02-05 07:45:39	2008-02-05 07:47:39	t	0101000020E610000035F0A31AF61B52C03F3A75E5B3D64440
4393	93	2008-02-05 07:46:09	2008-02-05 07:48:09	f	0101000020E610000035F0A31AF61B52C03F3A75E5B3D64440
4394	93	2008-02-05 07:46:39	2008-02-05 07:48:39	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4395	93	2008-02-05 07:47:09	2008-02-05 07:49:09	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4396	93	2008-02-05 07:47:39	2008-02-05 07:49:39	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4397	93	2008-02-05 07:48:09	2008-02-05 07:50:09	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4398	93	2008-02-05 07:48:39	2008-02-05 07:50:39	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4399	93	2008-02-05 07:48:39	2008-02-05 07:50:39	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4400	93	2008-02-05 07:49:10	2008-02-05 07:51:10	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4401	93	2008-02-05 07:49:39	2008-02-05 07:51:39	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4402	93	2008-02-05 07:50:09	2008-02-05 07:52:09	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4403	93	2008-02-05 07:50:39	2008-02-05 07:52:39	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4404	93	2008-02-05 07:51:09	2008-02-05 07:53:09	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4405	93	2008-02-05 07:51:39	2008-02-05 07:53:39	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4406	93	2008-02-05 07:52:09	2008-02-05 07:54:09	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4407	93	2008-02-05 07:52:39	2008-02-05 07:54:39	t	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4408	93	2008-02-05 07:53:09	2008-02-05 07:55:09	f	0101000020E6100000475B9544F61B52C01B649291B3D64440
4409	93	2008-02-05 07:53:39	2008-02-05 07:55:39	f	0101000020E6100000475B9544F61B52C01B649291B3D64440
4410	93	2008-02-05 07:54:09	2008-02-05 07:56:09	f	0101000020E6100000475B9544F61B52C01B649291B3D64440
4411	93	2008-02-05 07:55:09	2008-02-05 07:57:09	t	0101000020E6100000475B9544F61B52C01B649291B3D64440
4412	93	2008-02-05 07:56:09	2008-02-05 07:58:09	f	0101000020E6100000475B9544F61B52C03F3A75E5B3D64440
4413	93	2008-02-05 07:56:39	2008-02-05 07:58:39	f	0101000020E610000059C6866EF61B52C03F3A75E5B3D64440
4414	93	2008-02-05 07:57:09	2008-02-05 07:59:09	f	0101000020E610000059C6866EF61B52C03F3A75E5B3D64440
4415	93	2008-02-07 18:47:31	2008-02-07 18:49:31	f	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4416	93	2008-02-07 18:48:01	2008-02-07 18:50:01	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4417	93	2008-02-07 18:48:31	2008-02-07 18:50:31	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4418	93	2008-02-07 18:49:01	2008-02-07 18:51:01	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4419	93	2008-02-07 18:49:31	2008-02-07 18:51:31	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4420	93	2008-02-07 18:50:01	2008-02-07 18:52:01	f	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4421	93	2008-02-07 18:50:31	2008-02-07 18:52:31	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4422	93	2008-02-07 18:51:01	2008-02-07 18:53:01	f	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4423	93	2008-02-07 18:51:31	2008-02-07 18:53:31	f	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4424	93	2008-02-07 18:51:31	2008-02-07 18:53:31	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4425	93	2008-02-07 18:52:01	2008-02-07 18:54:01	t	0101000020E610000078F4BF5C8B2C52C0734BAB2171D14440
4426	94	2008-02-05 11:38:01	2008-02-05 11:40:01	f	0101000020E6100000A41F0DA7CC2F52C012FC6F253BD84440
4427	94	2008-02-05 11:38:31	2008-02-05 11:40:31	f	0101000020E610000016C78157CB2F52C06007CE1951D84440
4428	94	2008-02-05 11:39:01	2008-02-05 11:41:01	f	0101000020E61000004B0856D5CB2F52C08A592F8672D84440
4429	94	2008-02-05 11:39:31	2008-02-05 11:41:31	t	0101000020E6100000399D64ABCB2F52C066834C3272D84440
4430	94	2008-02-05 11:40:01	2008-02-05 11:42:01	f	0101000020E6100000F2F09E03CB2F52C0AE2F12DA72D84440
4431	94	2008-02-05 11:40:31	2008-02-05 11:42:31	t	0101000020E6100000045C902DCB2F52C066834C3272D84440
4432	94	2008-02-05 11:41:01	2008-02-05 11:43:01	t	0101000020E6100000045C902DCB2F52C066834C3272D84440
4433	94	2008-02-05 11:41:31	2008-02-05 11:43:31	f	0101000020E6100000045C902DCB2F52C08A592F8672D84440
4434	94	2008-02-05 11:42:01	2008-02-05 11:44:01	t	0101000020E6100000E085ADD9CA2F52C066834C3272D84440
4435	94	2008-02-05 11:42:31	2008-02-05 11:44:31	t	0101000020E6100000E085ADD9CA2F52C08A592F8672D84440
4436	94	2008-02-05 11:43:01	2008-02-05 11:45:01	f	0101000020E6100000CF1ABCAFCA2F52C066834C3272D84440
4437	94	2008-02-05 11:43:31	2008-02-05 11:45:31	f	0101000020E6100000CF1ABCAFCA2F52C066834C3272D84440
4438	94	2008-02-05 11:44:01	2008-02-05 11:46:01	t	0101000020E6100000CF1ABCAFCA2F52C066834C3272D84440
4439	94	2008-02-05 11:44:31	2008-02-05 11:46:31	t	0101000020E6100000399D64ABCB2F52C0A0ABADD85FD84440
4440	94	2008-02-05 11:45:01	2008-02-05 11:47:01	t	0101000020E6100000A1E1CD1ABC2F52C0A779C7293AD84440
4441	94	2008-02-05 11:45:31	2008-02-05 11:47:31	f	0101000020E61000000CF0DDE68D2F52C08AE5965643D84440
4442	94	2008-02-05 11:45:31	2008-02-05 11:47:31	t	0101000020E61000000CF0DDE68D2F52C08AE5965643D84440
4443	94	2008-02-05 11:46:01	2008-02-05 11:48:01	f	0101000020E610000041DAFF006B2F52C04B24D1CB28D84440
4444	94	2008-02-05 11:46:31	2008-02-05 11:48:31	f	0101000020E61000006CD5AE09692F52C07D3F355EBAD74440
4445	94	2008-02-05 11:47:01	2008-02-05 11:49:01	t	0101000020E6100000ECC6BB23632F52C0A06CCA15DED74440
4446	94	2008-02-05 11:47:31	2008-02-05 11:49:31	f	0101000020E610000017C26A2C612F52C04356B77A4ED84440
4447	94	2008-02-05 11:48:01	2008-02-05 11:50:01	t	0101000020E6100000284A42226D2F52C0F584251E50D84440
4448	94	2008-02-05 11:48:19	2008-02-05 11:50:19	t	0101000020E6100000E18096AE602F52C08A07944DB9D84440
4449	94	2008-02-05 11:48:49	2008-02-05 11:50:49	f	0101000020E61000005649641F642F52C0ED9E3C2CD4D84440
4450	94	2008-02-05 11:49:19	2008-02-05 11:51:19	f	0101000020E61000000153060E682F52C06766666666D84440
4451	94	2008-02-05 11:49:49	2008-02-05 11:51:49	f	0101000020E61000000CF0DDE68D2F52C06E5166834CD84440
4452	94	2008-02-05 11:50:19	2008-02-05 11:52:19	t	0101000020E6100000B6503239B52F52C0D1915CFE43D84440
4453	94	2008-02-05 11:50:19	2008-02-05 11:52:19	t	0101000020E6100000B6503239B52F52C0D1915CFE43D84440
4454	94	2008-02-05 11:50:49	2008-02-05 11:52:49	f	0101000020E6100000F6D72B2CB82F52C0920A630B41D84440
4455	94	2008-02-05 11:51:19	2008-02-05 11:53:19	t	0101000020E6100000689C86A8C22F52C04339D1AE42D84440
4456	94	2008-02-05 11:51:49	2008-02-05 11:53:49	f	0101000020E61000004F0CC9C9C42F52C0670FB40243D84440
4457	94	2008-02-05 11:52:19	2008-02-05 11:54:19	t	0101000020E6100000A41F0DA7CC2F52C03CBD529621D84440
4458	94	2008-02-05 11:53:13	2008-02-05 11:55:13	t	0101000020E6100000AF65321CCF2F52C052F2EA1C03D84440
4459	94	2008-02-05 11:53:43	2008-02-05 11:55:43	t	0101000020E6100000AF65321CCF2F52C09964E42CECD74440
4460	94	2008-02-05 11:54:13	2008-02-05 11:56:13	t	0101000020E610000079245E9ECE2F52C0D9CEF753E3D74440
4461	94	2008-02-05 11:54:21	2008-02-05 11:56:21	f	0101000020E61000008B8F4FC8CE2F52C0527E52EDD3D74440
4462	94	2008-02-05 11:54:51	2008-02-05 11:56:51	f	0101000020E6100000E085ADD9CA2F52C0CBF3E0EEACD74440
4463	94	2008-02-05 11:55:21	2008-02-05 11:57:21	t	0101000020E6100000F2F09E03CB2F52C0CBF3E0EEACD74440
4464	94	2008-02-05 11:55:51	2008-02-05 11:57:51	t	0101000020E6100000E12EFB75A72F52C044A33B889DD74440
4465	94	2008-02-05 11:56:21	2008-02-05 11:58:21	f	0101000020E6100000C5EC65DB692F52C021B0726891D74440
4466	94	2008-02-05 11:56:51	2008-02-05 11:58:51	t	0101000020E6100000AC5CA8FC6B2F52C0616C21C841D74440
4467	94	2008-02-05 11:57:21	2008-02-05 11:59:21	t	0101000020E6100000CF328B506C2F52C037A6272CF1D64440
4468	94	2008-02-05 11:57:51	2008-02-05 11:59:51	f	0101000020E6100000D65757056A2F52C0317C444C89D64440
4469	94	2008-02-05 11:58:21	2008-02-05 12:00:21	t	0101000020E61000000153060E682F52C0EBE74D452AD64440
4470	94	2008-02-05 11:58:51	2008-02-05 12:00:51	t	0101000020E61000005A6ABDDF682F52C05D55F65D11D64440
4471	94	2008-02-05 11:59:51	2008-02-05 12:01:51	t	0101000020E61000002F6F0ED76A2F52C04F5DF92CCFD54440
4472	94	2008-02-05 12:00:21	2008-02-05 12:02:21	t	0101000020E61000007E40A033692F52C02C137EA99FD54440
4473	94	2008-02-05 12:00:51	2008-02-05 12:02:51	f	0101000020E61000002529E961682F52C0A56B26DF6CD54440
4474	94	2008-02-05 12:01:21	2008-02-05 12:03:21	t	0101000020E61000007E40A033692F52C082CAF8F719D54440
4475	94	2008-02-05 12:01:51	2008-02-05 12:03:51	t	0101000020E610000016DF50F86C2F52C0894160E5D0D44440
4476	94	2008-02-05 12:02:21	2008-02-05 12:04:21	t	0101000020E6100000F3086EA46C2F52C0ED0DBE3099D44440
4477	94	2008-02-05 12:02:51	2008-02-05 12:04:51	t	0101000020E6100000BE70E7C2482F52C07BA01518B2D44440
4478	94	2008-02-05 12:03:21	2008-02-05 12:05:21	t	0101000020E6100000BBBE0F07092F52C00AF9A067B3D44440
4479	94	2008-02-05 12:03:51	2008-02-05 12:05:51	f	0101000020E6100000503C670B082F52C0D82AC1E270D44440
4480	94	2008-02-05 12:04:21	2008-02-05 12:06:21	t	0101000020E61000000990A163072F52C07CB8E4B853D44440
4481	94	2008-02-05 12:04:51	2008-02-05 12:06:51	f	0101000020E6100000E5B9BE0F072F52C0CA89761552D44440
4482	94	2008-02-05 12:04:51	2008-02-05 12:06:51	t	0101000020E6100000E5B9BE0F072F52C0CA89761552D44440
4483	94	2008-02-05 12:04:52	2008-02-05 12:06:52	t	0101000020E6100000C2E3DBBB062F52C03C31EBC550D44440
4484	94	2008-02-05 12:04:52	2008-02-05 12:06:52	f	0101000020E6100000C2E3DBBB062F52C03C31EBC550D44440
4485	94	2008-02-05 12:05:22	2008-02-05 12:07:22	f	0101000020E6100000AC74779D0D2F52C0FC8C0B0742D44440
4486	94	2008-02-05 12:05:52	2008-02-05 12:07:52	t	0101000020E6100000C94274081C2F52C083C0CAA145D44440
4487	94	2008-02-05 12:06:22	2008-02-05 12:08:22	t	0101000020E6100000C94274081C2F52C083C0CAA145D44440
4488	94	2008-02-05 12:06:52	2008-02-05 12:08:52	t	0101000020E610000085B70721202F52C0D1915CFE43D44440
4489	94	2008-02-05 12:07:22	2008-02-05 12:09:22	f	0101000020E61000005E34643C4A2F52C0AEBB79AA43D44440
4490	94	2008-02-07 01:16:07	2008-02-07 01:18:07	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4491	94	2008-02-07 01:16:37	2008-02-07 01:18:37	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4492	94	2008-02-07 01:17:07	2008-02-07 01:19:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4493	94	2008-02-07 01:17:37	2008-02-07 01:19:37	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4494	94	2008-02-07 01:18:07	2008-02-07 01:20:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4495	94	2008-02-07 01:18:37	2008-02-07 01:20:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4496	94	2008-02-07 01:19:07	2008-02-07 01:21:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4497	94	2008-02-07 01:19:37	2008-02-07 01:21:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4498	94	2008-02-07 01:20:07	2008-02-07 01:22:07	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4499	94	2008-02-07 01:20:37	2008-02-07 01:22:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4500	94	2008-02-07 01:21:07	2008-02-07 01:23:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4501	94	2008-02-07 01:21:37	2008-02-07 01:23:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4502	94	2008-02-07 01:22:07	2008-02-07 01:24:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4503	94	2008-02-07 01:22:37	2008-02-07 01:24:37	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4504	94	2008-02-07 01:22:37	2008-02-07 01:24:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4505	94	2008-02-07 01:23:07	2008-02-07 01:25:07	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4506	94	2008-02-07 01:23:37	2008-02-07 01:25:37	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4507	94	2008-02-07 01:24:07	2008-02-07 01:26:07	f	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4508	94	2008-02-07 01:24:37	2008-02-07 01:26:37	t	0101000020E610000015CC9882352C52C03FAE0D15E3E24440
4509	94	2008-02-07 01:25:07	2008-02-07 01:27:07	t	0101000020E61000008A9466F3382C52C0BFBC00FBE8E24440
4510	94	2008-02-07 01:25:37	2008-02-07 01:27:37	t	0101000020E610000067BE839F382C52C077103B53E8E24440
4511	94	2008-02-07 01:26:07	2008-02-07 01:28:07	t	0101000020E610000027378AAC352C52C0DB5031CEDFE24440
4512	94	2008-02-07 01:26:37	2008-02-07 01:28:37	t	0101000020E610000027378AAC352C52C0FF261422E0E24440
4513	94	2008-02-07 01:27:07	2008-02-07 01:29:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4514	94	2008-02-07 01:27:37	2008-02-07 01:29:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4515	94	2008-02-07 01:28:07	2008-02-07 01:30:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4516	94	2008-02-07 01:28:37	2008-02-07 01:30:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4517	94	2008-02-07 01:29:07	2008-02-07 01:31:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4518	94	2008-02-07 01:30:07	2008-02-07 01:32:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4519	94	2008-02-07 01:30:37	2008-02-07 01:32:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4520	94	2008-02-07 01:31:07	2008-02-07 01:33:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4521	94	2008-02-07 01:31:37	2008-02-07 01:33:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4522	94	2008-02-07 01:32:07	2008-02-07 01:34:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4523	94	2008-02-07 01:32:37	2008-02-07 01:34:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4524	94	2008-02-07 01:33:07	2008-02-07 01:35:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4525	94	2008-02-07 01:33:37	2008-02-07 01:35:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4526	94	2008-02-07 01:34:07	2008-02-07 01:36:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4527	94	2008-02-07 01:34:37	2008-02-07 01:36:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4528	94	2008-02-07 01:35:07	2008-02-07 01:37:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4529	94	2008-02-07 01:35:37	2008-02-07 01:37:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4530	94	2008-02-07 01:36:07	2008-02-07 01:38:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4531	94	2008-02-07 01:36:37	2008-02-07 01:38:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4532	94	2008-02-07 01:37:07	2008-02-07 01:39:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4533	94	2008-02-07 01:37:07	2008-02-07 01:39:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4534	94	2008-02-07 01:37:37	2008-02-07 01:39:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4535	94	2008-02-07 01:38:07	2008-02-07 01:40:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4536	94	2008-02-07 01:38:37	2008-02-07 01:40:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4537	94	2008-02-07 01:39:37	2008-02-07 01:41:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4538	94	2008-02-07 01:40:07	2008-02-07 01:42:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4539	94	2008-02-07 01:40:37	2008-02-07 01:42:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4540	94	2008-02-07 01:41:07	2008-02-07 01:43:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4541	94	2008-02-07 01:41:37	2008-02-07 01:43:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4542	94	2008-02-07 01:42:07	2008-02-07 01:44:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4543	94	2008-02-07 01:42:37	2008-02-07 01:44:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4544	94	2008-02-07 01:43:07	2008-02-07 01:45:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4545	94	2008-02-07 01:43:37	2008-02-07 01:45:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4546	94	2008-02-07 01:44:37	2008-02-07 01:46:37	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4547	94	2008-02-07 01:45:07	2008-02-07 01:47:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4548	94	2008-02-07 01:45:37	2008-02-07 01:47:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4549	94	2008-02-07 01:46:07	2008-02-07 01:48:07	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4550	94	2008-02-07 01:46:37	2008-02-07 01:48:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4551	94	2008-02-07 01:47:07	2008-02-07 01:49:07	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4552	94	2008-02-07 01:47:37	2008-02-07 01:49:37	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4553	94	2008-02-07 01:48:38	2008-02-07 01:50:38	f	0101000020E610000027378AAC352C52C022FDF675E0E24440
4554	94	2008-02-07 01:49:08	2008-02-07 01:51:08	t	0101000020E610000027378AAC352C52C022FDF675E0E24440
4555	94	2008-02-07 01:50:08	2008-02-07 01:52:08	t	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4556	94	2008-02-07 01:50:38	2008-02-07 01:52:38	f	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4557	94	2008-02-07 01:51:38	2008-02-07 01:53:38	t	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4558	94	2008-02-07 01:51:38	2008-02-07 01:53:38	t	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4559	94	2008-02-07 01:52:38	2008-02-07 01:54:38	f	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4560	94	2008-02-07 01:53:08	2008-02-07 01:55:08	f	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4561	94	2008-02-07 01:53:38	2008-02-07 01:55:38	t	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4562	94	2008-02-07 01:54:38	2008-02-07 01:56:38	f	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4563	94	2008-02-07 01:55:08	2008-02-07 01:57:08	t	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4564	94	2008-02-07 01:55:38	2008-02-07 01:57:38	f	0101000020E610000027378AAC352C52C046D3D9C9E0E24440
4565	95	2008-02-03 19:14:17	2008-02-03 19:16:17	f	0101000020E6100000823FFCFCF72E52C08A7615527EDC4440
4566	95	2008-02-03 19:15:09	2008-02-03 19:17:09	t	0101000020E6100000EDC1A4F8F82E52C01F11532289DC4440
4567	95	2008-02-03 19:16:18	2008-02-03 19:18:18	t	0101000020E610000034349E08E22E52C08A07944DB9DC4440
4568	95	2008-02-03 19:17:18	2008-02-03 19:19:18	t	0101000020E6100000CD24EA059F2E52C0AC1C5A643BDD4440
4569	95	2008-02-03 19:17:40	2008-02-03 19:19:40	t	0101000020E61000005F81E849992E52C073D712F241DD4440
4570	95	2008-02-03 19:18:00	2008-02-03 19:20:00	f	0101000020E61000005F81E849992E52C073D712F241DD4440
4571	95	2008-02-03 19:18:51	2008-02-03 19:20:51	t	0101000020E61000005F81E849992E52C073D712F241DD4440
4572	95	2008-02-03 19:19:19	2008-02-03 19:21:19	t	0101000020E6100000541EDD088B2E52C0A5315A4755DD4440
4573	95	2008-02-03 19:20:19	2008-02-03 19:22:19	f	0101000020E610000043E8A04B382E52C0E4DA5031CEDD4440
4574	95	2008-02-03 19:20:51	2008-02-03 19:22:51	t	0101000020E61000004B99D4D0062E52C072F90FE9B7DD4440
4575	95	2008-02-03 19:21:43	2008-02-03 19:23:43	t	0101000020E610000024D74D29AF2D52C0FA2CCF83BBDD4440
4576	96	2008-02-03 02:51:46	2008-02-03 02:53:46	t	0101000020E6100000EFEC2B0FD23152C00F10CCD1E3D94440
4577	96	2008-02-03 02:52:16	2008-02-03 02:54:16	f	0101000020E61000000BF5F411F83152C0EB39E97DE3D94440
4578	96	2008-02-03 02:52:46	2008-02-03 02:54:46	t	0101000020E61000001C7DCC07043252C0CF88D2DEE0D94440
4579	96	2008-02-03 02:53:14	2008-02-03 02:55:14	t	0101000020E6100000E050F86C1D3252C0390B7BDAE1D94440
4580	96	2008-02-03 02:53:44	2008-02-03 02:55:44	f	0101000020E6100000EEF1423A3C3252C0F25EB532E1D94440
4581	96	2008-02-03 02:54:14	2008-02-03 02:56:14	f	0101000020E6100000233317B83C3252C0CF88D2DEE0D94440
4582	96	2008-02-03 02:54:44	2008-02-03 02:56:44	f	0101000020E6100000C717EDF1423252C0D673D2FBC6D94440
4583	96	2008-02-03 02:55:14	2008-02-03 02:57:14	f	0101000020E610000099FBE428403252C0815B77F354D94440
4584	96	2008-02-03 02:55:44	2008-02-03 02:57:44	t	0101000020E6100000E7CC76853E3252C0DEAB5626FCD84440
4585	96	2008-02-03 02:56:14	2008-02-03 02:58:14	t	0101000020E6100000F93768AF3E3252C0187D0569C6D84440
4586	96	2008-02-03 02:56:44	2008-02-03 02:58:44	f	0101000020E6100000E7CC76853E3252C0A03715A930D84440
4587	96	2008-02-03 02:57:14	2008-02-03 02:59:14	f	0101000020E6100000D561855B3E3252C03CDA38622DD84440
4588	96	2008-02-03 02:57:29	2008-02-03 02:59:29	f	0101000020E6100000D561855B3E3252C060B01BB62DD84440
4589	96	2008-02-03 02:57:59	2008-02-03 02:59:59	f	0101000020E6100000D1402C9B393252C036EA211ADDD74440
4590	96	2008-02-03 02:59:59	2008-02-03 03:01:59	f	0101000020E610000097749483D93252C0CD4065FCFBD64440
4591	96	2008-02-03 03:00:29	2008-02-03 03:02:29	f	0101000020E61000005F2F4D11E03252C0CD4065FCFBD64440
4592	96	2008-02-03 03:00:59	2008-02-03 03:02:59	t	0101000020E610000006357C0BEB3252C0A2B437F8C2D64440
4593	96	2008-02-03 03:01:29	2008-02-03 03:03:29	f	0101000020E610000069925852EE3252C03FE3C28190D64440
4594	96	2008-02-03 03:01:59	2008-02-03 03:03:59	t	0101000020E61000005B9A5B21AC3252C0E3C798BB96D64440
4595	96	2008-02-03 03:02:29	2008-02-03 03:04:29	f	0101000020E6100000A30C5531953252C038BEF6CC92D64440
4596	96	2008-02-03 03:02:59	2008-02-03 03:04:59	t	0101000020E610000043791F47733252C04E9CDCEF50D64440
4597	96	2008-02-03 03:03:29	2008-02-03 03:05:29	f	0101000020E61000005F2A36E6753252C0B22E6EA301D64440
4598	96	2008-02-03 03:03:59	2008-02-03 03:05:59	f	0101000020E6100000B11C2103793252C08F01D9EBDDD54440
4599	96	2008-02-03 03:04:29	2008-02-03 03:06:29	f	0101000020E6100000664F029B733252C0401361C3D3D54440
4600	96	2008-02-03 03:04:59	2008-02-03 03:06:59	t	0101000020E6100000F88E1A13623252C02BA4FCA4DAD54440
4601	96	2008-02-03 03:05:29	2008-02-03 03:07:29	t	0101000020E6100000DFE17668583252C08FE4F21FD2D54440
4602	96	2008-02-03 03:05:59	2008-02-03 03:07:59	f	0101000020E61000004EA25EF0693252C0F9669B1BD3D54440
4603	96	2008-02-03 03:06:29	2008-02-03 03:08:29	f	0101000020E6100000E3AB1DC5393252C0406A1327F7D54440
4604	96	2008-02-03 03:06:59	2008-02-03 03:08:59	f	0101000020E610000040C7478B333252C0ABECBB22F8D54440
4605	96	2008-02-03 03:07:29	2008-02-03 03:09:29	t	0101000020E61000008352B4722F3252C080D93D7958D64440
4606	96	2008-02-03 03:07:29	2008-02-03 03:09:29	t	0101000020E61000008352B4722F3252C080D93D7958D64440
4607	96	2008-02-03 03:07:59	2008-02-03 03:09:59	f	0101000020E6100000F29E03CB113252C0462575029AD64440
4608	96	2008-02-03 03:08:29	2008-02-03 03:10:29	t	0101000020E61000006E6FB724073252C0F853E3A59BD64440
4609	96	2008-02-03 03:08:59	2008-02-03 03:10:59	t	0101000020E6100000A4E5400FB53152C0AA8251499DD64440
4610	96	2008-02-03 03:09:29	2008-02-03 03:11:29	f	0101000020E610000061200890A13152C0A96A82A8FBD64440
4611	96	2008-02-03 03:09:59	2008-02-03 03:11:59	t	0101000020E61000000B2AAA7EA53152C070F085C954D74440
4612	96	2008-02-03 03:10:59	2008-02-03 03:12:59	t	0101000020E61000009037F92D3A3152C02849D74CBED74440
4613	96	2008-02-03 03:11:29	2008-02-03 03:13:29	t	0101000020E61000000214234BE63052C00473F4F8BDD74440
4614	96	2008-02-03 03:11:59	2008-02-03 03:13:59	f	0101000020E6100000B4EBDE8AC43052C0D235936FB6D74440
4615	96	2008-02-03 03:12:29	2008-02-03 03:14:29	f	0101000020E610000029B4ACFBC73052C01AC5724BABD74440
4616	96	2008-02-03 03:12:29	2008-02-03 03:14:29	f	0101000020E610000029B4ACFBC73052C01AC5724BABD74440
4617	96	2008-02-03 03:12:59	2008-02-03 03:14:59	t	0101000020E61000003B1F9E25C83052C0D318ADA3AAD74440
4618	96	2008-02-03 03:13:29	2008-02-03 03:15:29	f	0101000020E610000066FD6662BA3052C08B37328FFCD74440
4619	96	2008-02-03 03:13:59	2008-02-03 03:15:59	f	0101000020E610000078F4BF5C8B3052C06EC0E78711D84440
4620	96	2008-02-03 03:14:29	2008-02-03 03:16:29	f	0101000020E6100000CDEA1D6E873052C0EE42739D46D84440
4621	96	2008-02-03 03:14:59	2008-02-03 03:16:59	t	0101000020E61000002602D53F883052C043739D465AD84440
4622	96	2008-02-03 03:15:29	2008-02-03 03:17:29	t	0101000020E610000063687572863052C04A0C022B87D84440
4623	96	2008-02-03 03:15:59	2008-02-03 03:17:59	t	0101000020E6100000E65DF580793052C0BBB88D06F0D84440
4624	96	2008-02-03 03:16:29	2008-02-03 03:18:29	t	0101000020E6100000A0E6E445263052C0DF8E705AF0D84440
4625	96	2008-02-03 03:16:59	2008-02-03 03:18:59	f	0101000020E610000043AED4B3203052C0740CC85EEFD84440
4626	96	2008-02-03 03:17:29	2008-02-03 03:19:29	t	0101000020E6100000D50AD3F71A3052C0F3AB394030D94440
4627	96	2008-02-03 03:17:59	2008-02-03 03:19:59	f	0101000020E61000006B882AFC193052C02CF697DD93D94440
4628	96	2008-02-03 03:18:29	2008-02-03 03:20:29	f	0101000020E61000002E05A4FD0F3052C0799274CDE4D94440
4629	96	2008-02-03 03:18:59	2008-02-03 03:20:59	f	0101000020E6100000C89E3D97A92F52C0B9196EC0E7D94440
4630	96	2008-02-03 03:19:29	2008-02-03 03:21:29	t	0101000020E61000003AB5334C6D2F52C0249C16BCE8D94440
4631	96	2008-02-03 03:19:59	2008-02-03 03:21:59	t	0101000020E61000000C7C45B75E2F52C0EBE74D452ADA4440
4632	96	2008-02-03 03:20:29	2008-02-03 03:22:29	f	0101000020E6100000A1F99CBB5D2F52C0BF4868CBB9DA4440
4633	96	2008-02-03 03:20:59	2008-02-03 03:22:59	t	0101000020E61000000C7C45B75E2F52C0293FA9F6E9DA4440
4634	96	2008-02-03 03:21:29	2008-02-03 03:23:29	f	0101000020E61000000C7C45B75E2F52C00669C6A2E9DA4440
4635	96	2008-02-03 03:21:59	2008-02-03 03:23:59	t	0101000020E61000001EE736E15E2F52C094DE37BEF6DA4440
4636	96	2008-02-03 03:22:29	2008-02-03 03:24:29	t	0101000020E61000000FBA84436F2F52C0A8A9656B7DDB4440
4637	96	2008-02-03 03:22:59	2008-02-03 03:24:59	t	0101000020E61000007E23BA675D2F52C092054CE0D6DB4440
4638	96	2008-02-03 03:23:29	2008-02-03 03:25:29	f	0101000020E6100000DEEBA4BE2C2F52C0A75CE15D2EDC4440
4639	96	2008-02-03 03:23:59	2008-02-03 03:25:59	t	0101000020E6100000CC63CDC8202F52C0D1915CFE43DC4440
4640	97	2008-02-05 00:26:10	2008-02-05 00:28:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4641	97	2008-02-05 00:31:10	2008-02-05 00:33:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4642	97	2008-02-05 00:36:10	2008-02-05 00:38:10	f	0101000020E61000005E86FF74031952C02927DA5548CF4440
4643	97	2008-02-05 00:41:10	2008-02-05 00:43:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4644	97	2008-02-05 00:46:10	2008-02-05 00:48:10	f	0101000020E61000005E86FF74031952C02927DA5548CF4440
4645	97	2008-02-05 00:51:10	2008-02-05 00:53:10	f	0101000020E61000005E86FF74031952C02927DA5548CF4440
4646	97	2008-02-05 00:56:10	2008-02-05 00:58:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4647	97	2008-02-05 01:01:10	2008-02-05 01:03:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4648	97	2008-02-05 01:06:10	2008-02-05 01:08:10	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4649	97	2008-02-05 01:16:11	2008-02-05 01:18:11	t	0101000020E61000005E86FF74031952C02927DA5548CF4440
4650	97	2008-02-05 01:31:11	2008-02-05 01:33:11	f	0101000020E610000070F1F09E031952C02927DA5548CF4440
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.tags (tag_id, mac_address, info, worst_case_rssi, flags, minutes_of_appr_contact) FROM stdin;
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: apiclient
--

COPY public.volunteers (volunteer_id, username, password, first_name, last_name, email, manager_id, interviewer, total_capacity, remaining_capacity, current_cases, completed_cases, languages) FROM stdin;
1	johnsmith	volunteer1.pw	John	Smith	john.smith@health_example.com	1	t	6	3	3	3	{ENGLISH, SPANISH}
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.





--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: contacts_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.contacts_contact_id_seq', 500, true);


--
-- Name: dummy_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.dummy_data_id_seq', 9000, true);


--
-- Name: managers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.managers_id_seq', 2, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.events_id_seq', 226, false);


--
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.patients_id_seq', 8, false);


--
-- Name: public_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.public_users_id_seq', 98, false);


--
-- Name: public_users_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.public_users_locations_id_seq', 4651, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: apiclient
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 2, false);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: dummy_data dummy_data_pkey; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.dummy_data
    ADD CONSTRAINT dummy_data_pkey PRIMARY KEY (id);


--
-- Name: event_contact event_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_contact
    ADD CONSTRAINT event_contact_pkey PRIMARY KEY (event_id, contact_id);


--
-- Name: managers managers_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT managers_pk PRIMARY KEY (manager_id);


--
-- Name: events events_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pk PRIMARY KEY (event_id);


--
-- Name: patients patients_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pk PRIMARY KEY (patient_id);


--
-- Name: public_users_locations public_users_locations_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.public_users_locations
    ADD CONSTRAINT public_users_locations_pk PRIMARY KEY (id);


--
-- Name: public_users public_users_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.public_users
    ADD CONSTRAINT public_users_pk PRIMARY KEY (public_user_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: volunteers volunteers_pk; Type: CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pk PRIMARY KEY (volunteer_id);


--
-- Name: events_geom_index; Type: INDEX; Schema: public; Owner: apiclient
--

CREATE INDEX events_geom_index ON public.events USING gist (public.st_transform(geom, 32618));


--
-- Name: public_users_locations_geom_index; Type: INDEX; Schema: public; Owner: apiclient
--

CREATE INDEX public_users_locations_geom_index ON public.public_users_locations USING gist (public.st_transform(geom, 32618));


--
-- Name: contacts contacts_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: event_contact event_contact_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_contact
    ADD CONSTRAINT event_contact_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(contact_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: event_contact event_contact_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_contact
    ADD CONSTRAINT event_contact_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: events events_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: patients patients_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.managers(manager_id);


--
-- Name: patients patients_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteers(volunteer_id);


--
-- Name: public_users_locations public_users_locations_public_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.public_users_locations
    ADD CONSTRAINT public_users_locations_public_user_id_fkey FOREIGN KEY (public_user_id) REFERENCES public.public_users(public_user_id);


--
-- Name: volunteers volunteers_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: apiclient
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.managers(manager_id);


--
-- PostgreSQL database dump complete
--

