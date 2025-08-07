--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2025-08-07 19:08:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 215 (class 1259 OID 589454)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 589619)
-- Name: buildings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buildings (
    id integer NOT NULL,
    address character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE public.buildings OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 589618)
-- Name: buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.buildings_id_seq OWNER TO postgres;

--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 216
-- Name: buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buildings_id_seq OWNED BY public.buildings.id;


--
-- TOC entry 219 (class 1259 OID 589626)
-- Name: economic_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.economic_activities (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    parent_id integer
);


ALTER TABLE public.economic_activities OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 589625)
-- Name: economic_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.economic_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.economic_activities_id_seq OWNER TO postgres;

--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 218
-- Name: economic_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.economic_activities_id_seq OWNED BY public.economic_activities.id;


--
-- TOC entry 222 (class 1259 OID 589650)
-- Name: organization_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization_activities (
    activity_id integer NOT NULL,
    organization_id integer NOT NULL
);


ALTER TABLE public.organization_activities OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 589667)
-- Name: organization_phones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization_phones (
    id integer NOT NULL,
    phone character varying(20) NOT NULL,
    organization_id integer NOT NULL
);


ALTER TABLE public.organization_phones OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 589666)
-- Name: organization_phones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organization_phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organization_phones_id_seq OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 223
-- Name: organization_phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organization_phones_id_seq OWNED BY public.organization_phones.id;


--
-- TOC entry 221 (class 1259 OID 589638)
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations (
    id integer NOT NULL,
    tittle character varying(255) NOT NULL,
    building_id integer NOT NULL
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 589637)
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizations_id_seq OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 220
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- TOC entry 3226 (class 2604 OID 589622)
-- Name: buildings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buildings ALTER COLUMN id SET DEFAULT nextval('public.buildings_id_seq'::regclass);


--
-- TOC entry 3227 (class 2604 OID 589629)
-- Name: economic_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economic_activities ALTER COLUMN id SET DEFAULT nextval('public.economic_activities_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 589670)
-- Name: organization_phones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_phones ALTER COLUMN id SET DEFAULT nextval('public.organization_phones_id_seq'::regclass);


--
-- TOC entry 3228 (class 2604 OID 589641)
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- TOC entry 3388 (class 0 OID 589454)
-- Dependencies: 215
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
cc8d1590d062
\.


--
-- TOC entry 3390 (class 0 OID 589619)
-- Dependencies: 217
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buildings (id, address, latitude, longitude) FROM stdin;
1	Москва, ул, Красная, д. 21	55	55
\.


--
-- TOC entry 3392 (class 0 OID 589626)
-- Dependencies: 219
-- Data for Name: economic_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.economic_activities (id, name, parent_id) FROM stdin;
1	Еда	\N
2	Молочка	1
3	Мясо	1
4	Авто	\N
5	Грузовые	4
6	Легковые	4
7	Запчасти	6
8	Аксессуары	6
9	Побрякушки	8
\.


--
-- TOC entry 3395 (class 0 OID 589650)
-- Dependencies: 222
-- Data for Name: organization_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization_activities (activity_id, organization_id) FROM stdin;
1	1
2	1
3	1
7	2
\.


--
-- TOC entry 3397 (class 0 OID 589667)
-- Dependencies: 224
-- Data for Name: organization_phones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization_phones (id, phone, organization_id) FROM stdin;
1	880005553535	1
2	880022233213	1
3	123456789012	2
\.


--
-- TOC entry 3394 (class 0 OID 589638)
-- Dependencies: 221
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizations (id, tittle, building_id) FROM stdin;
1	Рога и коптыта	1
2	Революция навылет	1
\.


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 216
-- Name: buildings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buildings_id_seq', 1, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 218
-- Name: economic_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.economic_activities_id_seq', 9, true);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 223
-- Name: organization_phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organization_phones_id_seq', 3, true);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 220
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organizations_id_seq', 2, true);


--
-- TOC entry 3231 (class 2606 OID 589458)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 3233 (class 2606 OID 589624)
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (id);


--
-- TOC entry 3235 (class 2606 OID 589631)
-- Name: economic_activities economic_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economic_activities
    ADD CONSTRAINT economic_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 589672)
-- Name: organization_phones organization_phones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_phones
    ADD CONSTRAINT organization_phones_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 589643)
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 589743)
-- Name: economic_activities economic_activities_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economic_activities
    ADD CONSTRAINT economic_activities_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.economic_activities(id);


--
-- TOC entry 3242 (class 2606 OID 589759)
-- Name: organization_activities organization_activities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_activities
    ADD CONSTRAINT organization_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.economic_activities(id) ON DELETE CASCADE;


--
-- TOC entry 3243 (class 2606 OID 589764)
-- Name: organization_activities organization_activities_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_activities
    ADD CONSTRAINT organization_activities_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- TOC entry 3244 (class 2606 OID 589713)
-- Name: organization_phones organization_phones_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_phones
    ADD CONSTRAINT organization_phones_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- TOC entry 3241 (class 2606 OID 589688)
-- Name: organizations organizations_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.buildings(id);


-- Completed on 2025-08-07 19:08:52

--
-- PostgreSQL database dump complete
--

