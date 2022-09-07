--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Name: equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipment (
    id_equipment integer NOT NULL,
    id_client integer,
    id_tipo integer,
    model character varying(100) NOT NULL,
    brand character varying(100) NOT NULL,
    photo character varying(100) NOT NULL,
    create_at date,
    update_at date
);


ALTER TABLE public.equipment OWNER TO postgres;

--
-- Name: equipment_id_equipment_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipment_id_equipment_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipment_id_equipment_seq OWNER TO postgres;

--
-- Name: equipment_id_equipment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipment_id_equipment_seq OWNED BY public.equipment.id_equipment;


--
-- Name: technical_report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.technical_report (
    id_technical_report integer NOT NULL,
    id_equipment integer,
    id_technician integer,
    orden_number integer NOT NULL,
    reported_problem character varying(255) NOT NULL,
    diagnosis character varying(255) NOT NULL,
    is_warranty boolean,
    status character varying(15) NOT NULL,
    photo character varying(255) NOT NULL
);


ALTER TABLE public.technical_report OWNER TO postgres;

--
-- Name: technical_report_id_technical_report_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.technical_report_id_technical_report_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technical_report_id_technical_report_seq OWNER TO postgres;

--
-- Name: technical_report_id_technical_report_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.technical_report_id_technical_report_seq OWNED BY public.technical_report.id_technical_report;


--
-- Name: technical_report_orden_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.technical_report_orden_number_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technical_report_orden_number_seq OWNER TO postgres;

--
-- Name: technical_report_orden_number_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.technical_report_orden_number_seq OWNED BY public.technical_report.orden_number;


--
-- Name: tipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo (
    id_tipo integer NOT NULL,
    nombre character varying(65)
);


ALTER TABLE public.tipo OWNER TO postgres;

--
-- Name: tipo_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_id_tipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_id_tipo_seq OWNER TO postgres;

--
-- Name: tipo_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_id_tipo_seq OWNED BY public.tipo.id_tipo;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_users integer NOT NULL,
    name character varying(65) NOT NULL,
    last_name character varying(65) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(64) NOT NULL,
    rol character varying(15) NOT NULL,
    phone character varying(9) NOT NULL,
    dni character varying(12) NOT NULL,
    auth boolean,
    update_at date,
    create_at date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_users_seq OWNER TO postgres;

--
-- Name: users_id_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_users_seq OWNED BY public.users.id_users;


--
-- Name: equipment id_equipment; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id_equipment SET DEFAULT nextval('public.equipment_id_equipment_seq'::regclass);


--
-- Name: technical_report id_technical_report; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report ALTER COLUMN id_technical_report SET DEFAULT nextval('public.technical_report_id_technical_report_seq'::regclass);


--
-- Name: technical_report orden_number; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report ALTER COLUMN orden_number SET DEFAULT nextval('public.technical_report_orden_number_seq'::regclass);


--
-- Name: tipo id_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo ALTER COLUMN id_tipo SET DEFAULT nextval('public.tipo_id_tipo_seq'::regclass);


--
-- Name: users id_users; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_users SET DEFAULT nextval('public.users_id_users_seq'::regclass);


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipment (id_equipment, id_client, id_tipo, model, brand, photo, create_at, update_at) FROM stdin;
\.


--
-- Data for Name: technical_report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.technical_report (id_technical_report, id_equipment, id_technician, orden_number, reported_problem, diagnosis, is_warranty, status, photo) FROM stdin;
\.


--
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo (id_tipo, nombre) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_users, name, last_name, email, password, rol, phone, dni, auth, update_at, create_at) FROM stdin;
\.


--
-- Name: equipment_id_equipment_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipment_id_equipment_seq', 1, false);


--
-- Name: technical_report_id_technical_report_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.technical_report_id_technical_report_seq', 1, false);


--
-- Name: technical_report_orden_number_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.technical_report_orden_number_seq', 1, false);


--
-- Name: tipo_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_id_tipo_seq', 1, false);


--
-- Name: users_id_users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_users_seq', 1, false);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id_equipment);


--
-- Name: technical_report technical_report_orden_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report
    ADD CONSTRAINT technical_report_orden_number_key UNIQUE (orden_number);


--
-- Name: technical_report technical_report_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report
    ADD CONSTRAINT technical_report_pkey PRIMARY KEY (id_technical_report);


--
-- Name: tipo tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (id_tipo);


--
-- Name: users users_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_dni_key UNIQUE (dni);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);


--
-- Name: equipment equipment_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.users(id_users);


--
-- Name: equipment equipment_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipo(id_tipo);


--
-- Name: technical_report technical_report_id_equipment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report
    ADD CONSTRAINT technical_report_id_equipment_fkey FOREIGN KEY (id_equipment) REFERENCES public.equipment(id_equipment);


--
-- Name: technical_report technical_report_id_technician_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.technical_report
    ADD CONSTRAINT technical_report_id_technician_fkey FOREIGN KEY (id_technician) REFERENCES public.users(id_users);


--
-- PostgreSQL database dump complete
--

