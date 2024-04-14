--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Ubuntu 16.2-1.pgdg22.04+1)

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
-- Name: banner; Type: TABLE; Schema: public; Owner: banners
--

CREATE TABLE public.banner (
    id integer NOT NULL,
    content text,
    feature_id smallint NOT NULL,
    is_active boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.banner OWNER TO banners;

--
-- Name: banner_id_seq; Type: SEQUENCE; Schema: public; Owner: banners
--

CREATE SEQUENCE public.banner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banner_id_seq OWNER TO banners;

--
-- Name: banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: banners
--

ALTER SEQUENCE public.banner_id_seq OWNED BY public.banner.id;


--
-- Name: banner_to_tag; Type: TABLE; Schema: public; Owner: banners
--

CREATE TABLE public.banner_to_tag (
    id integer NOT NULL,
    tag_id integer NOT NULL,
    banner_id integer NOT NULL
);


ALTER TABLE public.banner_to_tag OWNER TO banners;

--
-- Name: banner_to_tag_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: banners
--

CREATE SEQUENCE public.banner_to_tag_banner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banner_to_tag_banner_id_seq OWNER TO banners;

--
-- Name: banner_to_tag_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: banners
--

ALTER SEQUENCE public.banner_to_tag_banner_id_seq OWNED BY public.banner_to_tag.banner_id;


--
-- Name: banner_to_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: banners
--

CREATE SEQUENCE public.banner_to_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banner_to_tag_id_seq OWNER TO banners;

--
-- Name: banner_to_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: banners
--

ALTER SEQUENCE public.banner_to_tag_id_seq OWNED BY public.banner_to_tag.id;


--
-- Name: banner_to_tag_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: banners
--

CREATE SEQUENCE public.banner_to_tag_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banner_to_tag_tag_id_seq OWNER TO banners;

--
-- Name: banner_to_tag_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: banners
--

ALTER SEQUENCE public.banner_to_tag_tag_id_seq OWNED BY public.banner_to_tag.tag_id;


--
-- Name: banner id; Type: DEFAULT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner ALTER COLUMN id SET DEFAULT nextval('public.banner_id_seq'::regclass);


--
-- Name: banner_to_tag id; Type: DEFAULT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner_to_tag ALTER COLUMN id SET DEFAULT nextval('public.banner_to_tag_id_seq'::regclass);


--
-- Name: banner_to_tag tag_id; Type: DEFAULT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner_to_tag ALTER COLUMN tag_id SET DEFAULT nextval('public.banner_to_tag_tag_id_seq'::regclass);


--
-- Name: banner_to_tag banner_id; Type: DEFAULT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner_to_tag ALTER COLUMN banner_id SET DEFAULT nextval('public.banner_to_tag_banner_id_seq'::regclass);


--
-- Data for Name: banner; Type: TABLE DATA; Schema: public; Owner: banners
--

COPY public.banner (id, content, feature_id, is_active, created_at, updated_at) FROM stdin;
2	{"title":"some_title"}	10	t	2024-04-14 17:07:36.672419+00	2024-04-14 17:07:36.672419+00
3	{"text":"some_text","title":"some_title"}	11	t	2024-04-14 17:13:06.297619+00	2024-04-14 17:13:06.297619+00
4	{"field":"some_field","title":"some_title"}	10	f	2024-04-14 17:14:02.762025+00	2024-04-14 17:14:02.762025+00
6	{"field":"some_field","title":"some_title"}	10	t	2024-04-14 17:16:05.849687+00	2024-04-14 17:16:05.849687+00
7	{"field":"some_field","title":"some_title"}	10	t	2024-04-14 17:16:17.805812+00	2024-04-14 17:16:17.805812+00
8	{"field":"some_field","title":"some_title"}	10	t	2024-04-14 17:16:39.754942+00	2024-04-14 17:16:39.754942+00
9	{"field":"some_field","title":"some_title"}	13	t	2024-04-14 17:17:07.68555+00	2024-04-14 17:17:07.68555+00
\.


--
-- Data for Name: banner_to_tag; Type: TABLE DATA; Schema: public; Owner: banners
--

COPY public.banner_to_tag (id, tag_id, banner_id) FROM stdin;
3	10	2
4	10	3
5	11	4
7	12	6
8	13	7
9	14	8
10	14	9
\.


--
-- Name: banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banners
--

SELECT pg_catalog.setval('public.banner_id_seq', 9, true);


--
-- Name: banner_to_tag_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banners
--

SELECT pg_catalog.setval('public.banner_to_tag_banner_id_seq', 1, false);


--
-- Name: banner_to_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banners
--

SELECT pg_catalog.setval('public.banner_to_tag_id_seq', 10, true);


--
-- Name: banner_to_tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banners
--

SELECT pg_catalog.setval('public.banner_to_tag_tag_id_seq', 1, false);


--
-- Name: banner banner_pkey; Type: CONSTRAINT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner
    ADD CONSTRAINT banner_pkey PRIMARY KEY (id);


--
-- Name: banner_to_tag banner_to_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner_to_tag
    ADD CONSTRAINT banner_to_tag_pkey PRIMARY KEY (id);


--
-- Name: banner_to_tag fk_banner_id; Type: FK CONSTRAINT; Schema: public; Owner: banners
--

ALTER TABLE ONLY public.banner_to_tag
    ADD CONSTRAINT fk_banner_id FOREIGN KEY (banner_id) REFERENCES public.banner(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

