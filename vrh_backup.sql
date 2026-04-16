--
-- PostgreSQL database dump
--

\restrict lWgZVJ5lV5eUpr5bW0FIxmhKmTd2NJeexyMdZd07u18RFbXmZprKFv2NnfBvZ6f

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-16 10:07:05

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

--
-- TOC entry 6 (class 2615 OID 16451)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 6037 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 16452)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 6039 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17552)
-- Name: areas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.areas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    region character varying(255),
    description text,
    location public.geography(Point,4326),
    elevation_min double precision,
    elevation_max double precision,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.areas OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17601)
-- Name: climbing_routes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.climbing_routes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    summit_id uuid,
    name character varying(255) NOT NULL,
    grade_french character varying(10),
    grade_uiaa character varying(10),
    grade_alpine character varying(10),
    type character varying(50) DEFAULT 'sport'::character varying,
    length_m integer,
    num_bolts integer,
    rock_type character varying(100),
    description text,
    created_at timestamp without time zone DEFAULT now(),
    description_sl text,
    name_sl character varying(255)
);


ALTER TABLE public.climbing_routes OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17618)
-- Name: conditions_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conditions_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    trail_id uuid,
    climbing_route_id uuid,
    status character varying(50) NOT NULL,
    notes text,
    reported_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.conditions_reports OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17670)
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    summit_id uuid,
    trail_id uuid,
    climbing_route_id uuid,
    url character varying(500) NOT NULL,
    caption text,
    location public.geography(Point,4326),
    taken_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.photos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17644)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    trail_id uuid,
    climbing_route_id uuid,
    rating integer,
    body text,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17566)
-- Name: summits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.summits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    area_id uuid,
    name character varying(255) NOT NULL,
    name_sl character varying(255),
    elevation_m double precision NOT NULL,
    location public.geography(Point,4326),
    description text,
    type character varying(50) DEFAULT 'peak'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    description_sl text,
    difficulty character varying(50)
);


ALTER TABLE public.summits OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17707)
-- Name: ticklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticklist (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    summit_id uuid,
    trail_id uuid,
    climbing_route_id uuid,
    ascent_date date,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT ticklist_one_target CHECK ((((((summit_id IS NOT NULL))::integer + ((trail_id IS NOT NULL))::integer) + ((climbing_route_id IS NOT NULL))::integer) = 1))
);


ALTER TABLE public.ticklist OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17584)
-- Name: trails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trails (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    summit_id uuid,
    name character varying(255) NOT NULL,
    difficulty character varying(50),
    distance_km double precision,
    elevation_gain_m double precision,
    activity_type character varying(50) DEFAULT 'hiking'::character varying,
    path public.geography(LineString,4326),
    description text,
    created_at timestamp without time zone DEFAULT now(),
    description_sl text,
    name_sl character varying(255)
);


ALTER TABLE public.trails OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17534)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    avatar_url character varying(500),
    bio text,
    is_pro boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 6024 (class 0 OID 17552)
-- Dependencies: 226
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.areas (id, name, slug, region, description, location, elevation_min, elevation_max, created_at) FROM stdin;
5631819f-979a-4767-a5a8-383b5ed326e3	Julijske Alpe	julijske-alpe	Gorenjska	Highest mountain range in Slovenia, home of Triglav.	\N	\N	\N	2026-04-13 12:17:04.80348
297f3879-484e-4d03-9eb1-966792fd9a7e	Karavanke	karavanke	Gorenjska	Long mountain range on the border with Austria.	\N	\N	\N	2026-04-13 12:17:04.80348
96108f89-1b09-499e-a1f3-d5139bda063a	Kamniško-Savinjske Alpe	kamnisko-savinjske-alpe	Savinjska	Central Slovenian mountain range with dramatic walls.	\N	\N	\N	2026-04-13 12:17:04.80348
\.


--
-- TOC entry 6027 (class 0 OID 17601)
-- Dependencies: 229
-- Data for Name: climbing_routes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) FROM stdin;
6ac74535-e102-43bc-beba-8153d067e504	86f22509-e02f-4d5d-926f-5ff56cd65423	Picnik	6c	VII+	\N	sport	25	10	\N	A popular moderate route, great for intermediate climbers.	2026-04-13 13:56:37.993069	\N	\N
6bd93b8b-7f66-4df4-a7d8-aa01be8a2e02	86f22509-e02f-4d5d-926f-5ff56cd65423	Valter	7a	VIII	\N	sport	22	9	\N	Sustained climbing with a crux near the top.	2026-04-13 13:56:37.993069	\N	\N
72508556-3e9c-4a9f-8719-e50ac765a55a	7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e	Bala	9a	XI	\N	sport	35	14	\N	One of the hardest routes in Slovenia, requiring exceptional strength.	2026-04-13 13:56:37.993069	\N	\N
7c5c0ec2-f992-41a3-ad74-726bc170e5f9	7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e	Charge	8a+	X	\N	sport	30	12	\N	Powerful moves on an overhanging wall, a must-do for strong climbers.	2026-04-13 13:56:37.993069	\N	\N
84a09177-e059-45d3-a8f1-641cb0af61ab	b9b8f664-8fb2-4607-b1cc-0bf281468c5f	Helba - Gorenjska	\N	VII+	TD+	alpine	1000	\N	\N	Classic alpine route on the Triglav North Face. First climbed in 1928 (Gorenjska) and 1971 (Helba). 1000m wall, 1450m total elevation gain. Approach 1h15min from Aljazev Dom. Gear: cams 0.3-3, nuts, slings. One of the great Julian Alps classics.	2026-04-13 19:51:21.30197	\N	\N
47c7aab8-424b-4c57-a149-6873dadcfc50	7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e	Mala Mišja	7c	IX	\N	sport	26	10	\N	Excellent climbing for advanced sport climbers, technical and sustained.	2026-04-13 13:56:37.993069	\N	\N
c0e028f8-f789-4651-a1fb-f3d26c2955e5	86f22509-e02f-4d5d-926f-5ff56cd65423	Obsesija	8a	IX+	\N	sport	30	12	\N	One of the classic hard routes at Osp, powerful moves on perfect limestone.	2026-04-13 13:56:37.993069	\N	\N
ab5e12db-27d8-4356-b52f-ea54a031651a	86f22509-e02f-4d5d-926f-5ff56cd65423	Strelovod	7b	VIII+	\N	sport	28	11	\N	Technical face climbing on small holds, a Osp classic.	2026-04-13 13:56:37.993069	\N	\N
269b9875-5c31-4e31-ad38-30826ad7fdc2	7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e	Sanjski par	8b+	X+	\N	sport	32	13	\N	Dream route with continuous technical climbing on steep limestone.	2026-04-13 13:56:37.993069	\N	\N
\.


--
-- TOC entry 6028 (class 0 OID 17618)
-- Dependencies: 230
-- Data for Name: conditions_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conditions_reports (id, user_id, trail_id, climbing_route_id, status, notes, reported_at) FROM stdin;
f908b3af-6de8-4706-b0e7-cfaa61655101	bc5033cd-1832-4a7b-935a-966f0146640c	5047067c-f1c1-4374-b379-9355eaaa8f9c	\N	good	Pot je lepo urejena in varovana s klini.	2026-04-13 19:45:05.998813
\.


--
-- TOC entry 6030 (class 0 OID 17670)
-- Dependencies: 232
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photos (id, user_id, summit_id, trail_id, climbing_route_id, url, caption, location, taken_at) FROM stdin;
\.


--
-- TOC entry 6029 (class 0 OID 17644)
-- Dependencies: 231
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, user_id, trail_id, climbing_route_id, rating, body, created_at) FROM stdin;
\.


--
-- TOC entry 5799 (class 0 OID 16771)
-- Dependencies: 221
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 6025 (class 0 OID 17566)
-- Dependencies: 227
-- Data for Name: summits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) FROM stdin;
b9b8f664-8fb2-4607-b1cc-0bf281468c5f	5631819f-979a-4767-a5a8-383b5ed326e3	Triglav	Triglav	2864	\N	Highest peak in Slovenia and national symbol.	peak	2026-04-13 12:17:04.806334	Najvišji vrh Slovenije in simbol slovenskega naroda. Triglav je srce Triglavskega narodnega parka.	\N
1ea0d02e-e746-4987-a900-622136d8fc09	5631819f-979a-4767-a5a8-383b5ed326e3	Mangart	Mangart	2679	\N	Second highest peak in Slovenia with views into Italy and Austria.	peak	2026-04-13 12:17:04.806334	Drugi najvišji vrh v Sloveniji z osupljivimi razgledi na Italijo in Avstrijo.	\N
9d037f48-6bdb-4d38-bc43-1b332464bb3d	5631819f-979a-4767-a5a8-383b5ed326e3	Jalovec	Jalovec	2645	\N	One of the most beautiful peaks in the Julian Alps.	peak	2026-04-13 12:17:04.806334	Eden najlepših vrhov Julijskih Alp, znan po ostrih grebenih in zahtevnih smereh.	\N
de3f6143-f32b-48be-880e-08279260bf05	96108f89-1b09-499e-a1f3-d5139bda063a	Grintovec	Grintovec	2558	\N	Highest peak of the Kamnik-Savinja Alps.	peak	2026-04-13 12:17:04.806334	Najvišji vrh Kamniško-Savinjskih Alp z označenimi potmi iz različnih smeri.	\N
1da58feb-2ad1-43a6-8100-c8476f476a03	297f3879-484e-4d03-9eb1-966792fd9a7e	Stol	Stol	2236	\N	Highest peak of the Karavanke on the Slovenian side.	peak	2026-04-13 12:17:04.806334	\N	\N
df471336-df80-4e39-800e-041eafc9bf3a	96108f89-1b09-499e-a1f3-d5139bda063a	Brana	Brana	2253	\N	Distinctive peak above Kamniško sedlo, popular with mountaineers.	peak	2026-04-14 07:53:25.604314	\N	\N
7630d807-b661-43c8-96a8-96526bfb6fe3	96108f89-1b09-499e-a1f3-d5139bda063a	Planjava	Planjava	2394	\N	Broad summit with excellent circular routes above Logarska dolina.	peak	2026-04-14 07:53:25.604314	\N	\N
bf43f570-93fb-4a90-b40c-db1f5ca0ba55	96108f89-1b09-499e-a1f3-d5139bda063a	Storžič	Storžič	2132	\N	One of the most popular peaks in the Kamnik-Savinja Alps, great views.	peak	2026-04-14 07:53:25.604314	\N	\N
b21ca54f-ad3d-4aa8-ac73-7a21c2d3a9e4	96108f89-1b09-499e-a1f3-d5139bda063a	Raduha	Raduha	2062	\N	Remote peak above Logarska dolina, known for the Snežna jama ice cave nearby.	peak	2026-04-14 07:53:25.604314	\N	\N
e381d3f0-52e9-4342-8df6-5c17b2d01621	96108f89-1b09-499e-a1f3-d5139bda063a	Jezerska Kočna	Jezerska Kočna	2540	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
c7c490bf-a55f-4bde-b1eb-f19f94e5303c	96108f89-1b09-499e-a1f3-d5139bda063a	Kokrska Kočna	Kokrska Kočna	2520	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
5356cfe5-1035-4a19-affd-0c8e04263266	96108f89-1b09-499e-a1f3-d5139bda063a	Na Križu	Na Križu	2484	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
b7203215-88bc-4ba7-9adb-67e59fcd77e0	96108f89-1b09-499e-a1f3-d5139bda063a	Dolgi hrbet	Dolgi hrbet	2473	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
129fd77a-b4c5-4a7d-978f-65f5b59d1a86	96108f89-1b09-499e-a1f3-d5139bda063a	Štruca	Štruca	2457	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
271e6b33-9e2d-484c-9cd0-2c0dd1a3d561	96108f89-1b09-499e-a1f3-d5139bda063a	Kranjska Rinka	Kranjska Rinka	2453	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
1bf690d5-565c-4e90-ac79-796909096065	96108f89-1b09-499e-a1f3-d5139bda063a	Koroška Rinka	Koroška Rinka	2433	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
a929a3f1-f8a9-4e1c-8536-2f3a823a5e63	96108f89-1b09-499e-a1f3-d5139bda063a	Planjava - zahodni vrh	Planjava - zahodni vrh	2394	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
c2cba3ac-02e9-4cf0-89a7-eb61312fcb79	96108f89-1b09-499e-a1f3-d5139bda063a	Štajerska Rinka	Štajerska Rinka	2374	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
b335c4fa-e300-4c03-8efd-d396e0648abc	96108f89-1b09-499e-a1f3-d5139bda063a	Lučka Brana	Lučka Brana	2331	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
cce60bb8-85f8-40c6-babf-6a9d07fadc27	96108f89-1b09-499e-a1f3-d5139bda063a	Mala Rinka	Mala Rinka	2289	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
8b6d6bc1-e03b-4d17-b431-b2f6c4082de0	96108f89-1b09-499e-a1f3-d5139bda063a	Turska gora	Turska gora	2251	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
3ef9e210-d00d-4b1b-95ee-05797e9da4ed	96108f89-1b09-499e-a1f3-d5139bda063a	Kalški greben	Kalški greben	2224	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
46bb0aa7-f7ae-45c3-9d2a-c3530d5d8a8d	96108f89-1b09-499e-a1f3-d5139bda063a	Mrzla gora	Mrzla gora	2203	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
74cd6060-d7fa-45a4-9310-2f6a5001e1d0	96108f89-1b09-499e-a1f3-d5139bda063a	Najvišji rob	Najvišji rob	2127	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
d8ac9ed3-a803-4a3f-8894-d551b707faa5	96108f89-1b09-499e-a1f3-d5139bda063a	Velika Baba	Velika Baba	2127	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
6fba209f-48e3-4874-87e8-3c6abdbce38f	96108f89-1b09-499e-a1f3-d5139bda063a	Velika Zelenica	Velika Zelenica	2114	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
aea713a3-07c5-4293-be6b-91ee63ffcccc	96108f89-1b09-499e-a1f3-d5139bda063a	Storžek	Storžek	2110	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
7cee2ae9-a232-484e-a6f2-72d849a9008c	96108f89-1b09-499e-a1f3-d5139bda063a	Veliki vrh	Veliki vrh	2110	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
e45bc0b3-112c-4b56-bfc3-1203d6e733fd	96108f89-1b09-499e-a1f3-d5139bda063a	Ledinski vrh	Ledinski vrh	2108	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
e937155c-b8df-47e6-9ee8-c3f69ddf0086	96108f89-1b09-499e-a1f3-d5139bda063a	Kogel	Kogel	2100	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
1499ad56-4104-400f-b508-7610aa9d9aa4	96108f89-1b09-499e-a1f3-d5139bda063a	Krofička	Krofička	2083	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
cfdc3acf-a718-4b6e-9643-595bec02c62a	96108f89-1b09-499e-a1f3-d5139bda063a	Velika Raduha	Velika Raduha	2062	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
25560c4e-2670-4d07-aa35-ad109a685ca3	96108f89-1b09-499e-a1f3-d5139bda063a	Kalška gora	Kalška gora	2047	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
9bb99e35-adf9-4d22-a241-834be010dbab	96108f89-1b09-499e-a1f3-d5139bda063a	Mala Raduha	Mala Raduha	2029	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
6f017dcc-48df-4faf-a486-f325383ee289	96108f89-1b09-499e-a1f3-d5139bda063a	Molička peč	Molička peč	2029	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
86f22509-e02f-4d5d-926f-5ff56cd65423	\N	Osp	Osp	100	\N	World famous sport climbing crag above the village of Osp.	crag	2026-04-13 13:52:07.624319	Svetovno znana športnoplezalna stena nad vasjo Osp z apnenčastimi stenami.	\N
7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e	\N	Mišja Peč	Mišja Peč	120	\N	One of the hardest climbing crags in Europe.	crag	2026-04-13 13:52:07.624319	Ena najtežjih plezalnih sten v Evropi z mnogimi smermi devetih stopenj.	\N
d1cb14d6-a3fe-448e-8745-7708297cbc71	96108f89-1b09-499e-a1f3-d5139bda063a	Velika Planina	Velika Planina	1666	\N	Famous alpine plateau with traditional shepherd huts, accessible by cable car.	peak	2026-04-14 07:53:25.604314	Razgledna planota z značilnimi pastirskimi kočami, dostopna z gondolo.	\N
9dc7a521-6190-4132-8d3d-5d95663f4257	96108f89-1b09-499e-a1f3-d5139bda063a	Lučki Dedec	Lučki Dedec	2023	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
fed3f00d-d480-4944-b3cf-b50ce4daeef9	96108f89-1b09-499e-a1f3-d5139bda063a	Mala Ojstrica	Mala Ojstrica	2017	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
86a8e990-ff49-467e-97ee-2b9f9bc90a01	96108f89-1b09-499e-a1f3-d5139bda063a	Vrh Korena	Vrh Korena	1999	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
c8204d50-065b-46b3-acf9-547594653a94	96108f89-1b09-499e-a1f3-d5139bda063a	Kompotela	Kompotela	1989	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
ec1bf083-c571-48cf-99da-a1c9344a12bb	96108f89-1b09-499e-a1f3-d5139bda063a	Tolsti vrh	Tolsti vrh	1985	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
b0205feb-3b5e-4261-945b-b1a7b397c4fb	96108f89-1b09-499e-a1f3-d5139bda063a	Vršiči	Vršiči	1980	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
227a8075-11b7-4cfb-ba68-bf6c197dfaf2	96108f89-1b09-499e-a1f3-d5139bda063a	Košutna	Košutna	1974	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
2d6445f4-da41-4888-9fcd-9f825ed1fb56	96108f89-1b09-499e-a1f3-d5139bda063a	Veliki Zvoh	Veliki Zvoh	1971	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
0b4a9ad2-9826-4034-b686-9f00f41cbc57	96108f89-1b09-499e-a1f3-d5139bda063a	Deska	Deska	1970	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
966c8737-8cb8-4aa7-ac27-16b67fceeab1	96108f89-1b09-499e-a1f3-d5139bda063a	Vežica	Vežica	1965	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
de76a638-d9a1-49bd-bb56-20af35c9a438	96108f89-1b09-499e-a1f3-d5139bda063a	Dleskovec	Dleskovec	1965	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
0013ca4c-1ac9-4db4-b484-c6850f3c20b6	96108f89-1b09-499e-a1f3-d5139bda063a	Matkova kopa	Matkova kopa	1957	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
9e27637f-4b86-49ce-aac9-794541f265a4	96108f89-1b09-499e-a1f3-d5139bda063a	Lanež	Lanež	1925	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
5fb0484e-2552-401e-95a3-2d2c639ca4a4	96108f89-1b09-499e-a1f3-d5139bda063a	Križevnik	Križevnik	1909	\N	\N	peak	2026-04-14 07:56:33.171225	\N	\N
ab514d14-635c-47d8-91f9-e1c79fca1134	96108f89-1b09-499e-a1f3-d5139bda063a	Skuta	Skuta	2532	\N	Second highest peak in the Kamnik-Savinja Alps, known for its dramatic north face.	peak	2026-04-14 07:53:25.604314	Drugi najvišji vrh Kamniško-Savinjskih Alp z zahtevno severno steno.	\N
267785cc-d923-42aa-ae04-7ffad34f44c6	96108f89-1b09-499e-a1f3-d5139bda063a	Kočna	Kočna	2540	\N	Impressive peak above Jezersko with a demanding ascent.	peak	2026-04-14 07:53:25.604314	Markanten vrh nad Jezerskim z zahtevnim vzponom.	\N
c9199782-9848-490a-aa2b-600e6338a504	96108f89-1b09-499e-a1f3-d5139bda063a	Ojstrica	Ojstrica	2350	\N	Sharp rocky peak with beautiful views over Logarska dolina.	peak	2026-04-14 07:53:25.604314	Oster skalnati vrh z lepimi razgledi nad Logarsko dolino.	\N
d8c8b6aa-0e93-471f-b766-70e877c5268a	5631819f-979a-4767-a5a8-383b5ed326e3	Škrlatica	Škrlatica	2740	\N	Second highest peak in Slovenia, known for its imposing north face and demanding routes.	peak	2026-04-14 16:39:28.652083	\N	\N
9ca6e361-7845-40e3-bb1a-c49382fde033	5631819f-979a-4767-a5a8-383b5ed326e3	Razor	Razor	2601	\N	Distinctive sharp peak in the Julian Alps with excellent views towards Triglav.	peak	2026-04-14 16:39:28.652083	\N	\N
a7a47971-732c-4524-9632-8f5ea6748663	5631819f-979a-4767-a5a8-383b5ed326e3	Prisojnik	Prisojnik	2547	\N	One of the most popular peaks in the Julian Alps, known for the Window of Prisojnik rock formation.	peak	2026-04-14 16:39:28.652083	\N	\N
15dd7faf-384c-4256-bbf5-b7c769be0cfc	5631819f-979a-4767-a5a8-383b5ed326e3	Kanjavec	Kanjavec	2568	\N	Remote and wild peak in the heart of Triglav National Park.	peak	2026-04-14 16:39:28.652083	\N	\N
5692b60d-7604-422a-82e7-d3e552798041	5631819f-979a-4767-a5a8-383b5ed326e3	Bogatin	Bogatin	2003	\N	Beautiful peak above Bohinjsko jezero with panoramic views over the Bohinj valley.	peak	2026-04-14 16:39:28.652083	\N	\N
6a7352a9-bea9-498d-bbd2-60b993ae6d3b	5631819f-979a-4767-a5a8-383b5ed326e3	Krn	Krn	2244	\N	Historic WWI battlefield peak above the Soča valley with a mountain lake nearby.	peak	2026-04-14 16:39:28.652083	\N	\N
c2fba83b-0db1-4229-96b8-f5e54458079f	5631819f-979a-4767-a5a8-383b5ed326e3	Rombon	Rombon	2208	\N	Impressive peak above Bovec with views over the Soča valley and the Italian border.	peak	2026-04-14 16:39:28.652083	\N	\N
16a0bc2d-32eb-482b-8fa3-ab8e5558c149	5631819f-979a-4767-a5a8-383b5ed326e3	Polovnik	Polovnik	1621	\N	Popular viewpoint above Kobarid with views over the Soča valley.	peak	2026-04-14 16:39:28.652083	\N	\N
b22166b5-0cc0-4b94-b960-11433f9c950a	5631819f-979a-4767-a5a8-383b5ed326e3	Stog	Stog	1673	\N	Accessible peak above Tolmin with beautiful views over the Soča and Tolminka valleys.	peak	2026-04-14 16:39:28.652083	\N	\N
66d22f7f-c9a4-4194-8852-789b6e21f8df	5631819f-979a-4767-a5a8-383b5ed326e3	Črna prst	Črna prst	1844	\N	Popular ski and hiking destination above Bohinjska Bistrica.	peak	2026-04-14 16:39:28.652083	\N	\N
c96d95a8-bfa3-4dc4-8dba-afb1873dbfbb	5631819f-979a-4767-a5a8-383b5ed326e3	Vogel	Vogel	1922	\N	Accessible by cable car from Bohinjsko jezero, stunning views over Bohinj and Triglav.	peak	2026-04-14 16:39:28.652083	\N	\N
c4280359-ddd2-4020-9da4-65c89c9be4e8	5631819f-979a-4767-a5a8-383b5ed326e3	Veliki Draški vrh	Veliki Draški vrh	2243	\N	High plateau peak in the Triglav National Park above Bohinj.	peak	2026-04-14 16:39:28.652083	\N	\N
286b46e6-bb8e-4aa6-bef8-03f7c29701e3	5631819f-979a-4767-a5a8-383b5ed326e3	Tosc	Tosc	2275	\N	Broad summit in the Julian Alps above the Bohinj valley.	peak	2026-04-14 16:39:28.652083	\N	\N
2d2f730c-00ed-4180-aca7-d5244f307d65	5631819f-979a-4767-a5a8-383b5ed326e3	Vrh Planje	Vrh Planje	2347	\N	High peak in the Julian Alps near the Italian border.	peak	2026-04-14 16:39:28.652083	\N	\N
8bb56f64-3e42-4a30-b5a2-da75e47719e2	5631819f-979a-4767-a5a8-383b5ed326e3	Visoka Ponca	Visoka Ponca	2274	\N	Peak on the Slovenian-Italian border above the Trenta valley.	peak	2026-04-14 16:39:28.652083	\N	\N
a45d2598-8df5-4e06-9343-d272c4e2657e	297f3879-484e-4d03-9eb1-966792fd9a7e	Košuta	Košuta	2133	\N	Long ridge peak on the Austrian border, popular for its panoramic views.	peak	2026-04-14 16:40:23.106794	\N	\N
3b880f15-9a82-4371-b2d6-aaca56c5c19b	297f3879-484e-4d03-9eb1-966792fd9a7e	Begunjščica	Begunjščica	2060	\N	Distinctive peak above Begunje na Gorenjskem with views over the Sava valley.	peak	2026-04-14 16:40:23.106794	\N	\N
ccd8b85c-c2a3-45ef-95ea-3758ab07fa96	297f3879-484e-4d03-9eb1-966792fd9a7e	Kepa	Kepa	2143	\N	Northernmost high peak in Slovenia on the Austrian border above Jesenice.	peak	2026-04-14 16:40:23.106794	\N	\N
2e544b2a-55ea-44ae-b484-0d2cac9a2325	297f3879-484e-4d03-9eb1-966792fd9a7e	Golica	Golica	1836	\N	Famous for its spectacular narcissus bloom every spring, one of the most visited peaks in Slovenia.	peak	2026-04-14 16:40:23.106794	\N	\N
c853f24b-dcf2-4952-8801-9c782c3dcd1d	297f3879-484e-4d03-9eb1-966792fd9a7e	Karavanke	Karavanke	1991	\N	Broad summit on the main Karavanke ridge with views into Austria.	peak	2026-04-14 16:40:23.106794	\N	\N
2f7751ee-dd92-4f49-8844-be04d4b2ab0c	297f3879-484e-4d03-9eb1-966792fd9a7e	Ojstrnik	Ojstrnik	1945	\N	Sharp rocky peak in the eastern Karavanke range.	peak	2026-04-14 16:40:23.106794	\N	\N
b6df36c5-df09-49b9-85e3-6139b9a6aa74	297f3879-484e-4d03-9eb1-966792fd9a7e	Kočna	Kočna	1999	\N	Accessible peak in the western Karavanke with panoramic views.	peak	2026-04-14 16:40:23.106794	\N	\N
8c0dbfb6-ca02-44fd-8064-b5b6e0ba1c2d	297f3879-484e-4d03-9eb1-966792fd9a7e	Vrtača	Vrtača	2180	\N	High peak in the Karavanke range above Tržič with demanding approaches.	peak	2026-04-14 16:40:23.106794	\N	\N
dca11122-f02a-4111-b8d4-672aad663616	297f3879-484e-4d03-9eb1-966792fd9a7e	Tolsti vrh	Tolsti vrh	1712	\N	Forested peak in the western Karavanke above Kranjska Gora.	peak	2026-04-14 16:40:23.106794	\N	\N
b2b85b67-3bfd-4df2-914b-61c27e47cc37	297f3879-484e-4d03-9eb1-966792fd9a7e	Struška Kočna	Struška Kočna	2083	\N	Remote peak in the central Karavanke with beautiful alpine scenery.	peak	2026-04-14 16:40:23.106794	\N	\N
6b0df5e2-4e46-4b44-bc25-c8c15adde80f	297f3879-484e-4d03-9eb1-966792fd9a7e	Smrekovec	Smrekovec	1577	\N	Forested peak in the eastern Karavanke, popular family hiking destination.	peak	2026-04-14 16:40:23.106794	\N	\N
87a45a3a-3411-4765-8f4c-8b2e846b0eb7	297f3879-484e-4d03-9eb1-966792fd9a7e	Peca	Peca	2126	\N	Highest peak in the eastern Karavanke, on the tripoint border of Slovenia, Austria and Italy.	peak	2026-04-14 16:40:23.106794	\N	\N
6a1c121b-3377-4f92-a755-e1e6f80f72f3	297f3879-484e-4d03-9eb1-966792fd9a7e	Olševa	Olševa	1929	\N	Beautiful plateau peak in the eastern Karavanke above Solčava.	peak	2026-04-14 16:40:23.106794	\N	\N
27a5c5cf-65e2-47bb-9fd5-ecee9c54979b	297f3879-484e-4d03-9eb1-966792fd9a7e	Uršlja gora	Uršlja gora	1699	\N	Highest peak in the Pohorje-Uršlja gora range, with a church on the summit.	peak	2026-04-14 16:40:23.106794	\N	\N
95c3e205-e091-4479-ae93-efbb9a025775	297f3879-484e-4d03-9eb1-966792fd9a7e	Razen	Razen	1796	\N	Rocky peak in the central Karavanke with views over the Mežica valley.	peak	2026-04-14 16:40:23.106794	\N	\N
7f321e7a-e3cf-41e1-b2ff-e2d6fa356b43	5631819f-979a-4767-a5a8-383b5ed326e3	Jôf di Montasio	Montaž	2753	\N	Jôf di Montasio with its 2753m of elevation is the second highest peak of Julian alps. On the summit there's a cross with a bell dedicated to an alpinist Riccardo Deffar	peak	2026-04-14 19:29:37.127808	Montaž je s svojimi 2753m nadmorske višine druga najvišja gora v Julijskih Alpah. Na vrhu stoji križ z zvoncem, ki je posvečen alpinistu Riccardu Deffarju.	\N
\.


--
-- TOC entry 6031 (class 0 OID 17707)
-- Dependencies: 233
-- Data for Name: ticklist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticklist (id, user_id, summit_id, trail_id, climbing_route_id, ascent_date, notes, created_at) FROM stdin;
\.


--
-- TOC entry 6026 (class 0 OID 17584)
-- Dependencies: 228
-- Data for Name: trails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) FROM stdin;
8873edf7-07d4-42a7-9bee-a58f4dfd6506	b9b8f664-8fb2-4607-b1cc-0bf281468c5f	Kredarica route	hard	18	1600	hiking	\N	Route via Kredarica mountain hut, most popular path to the summit.	2026-04-13 13:50:12.109775	\N	Pot čez Kredarico
04c5b73b-891c-439a-8347-1a9ec54beeff	1ea0d02e-e746-4987-a900-622136d8fc09	Mangart Saddle route	medium	4	350	hiking	\N	Short but scenic route from the Mangart saddle, accessible by road.	2026-04-13 13:50:12.109775	\N	Pot čez Mangartsko sedlo
2e15bba4-196e-45b6-a143-c049e9dfc29b	de3f6143-f32b-48be-880e-08279260bf05	South ridge route	hard	12	1400	hiking	\N	Classic ridge approach to the highest peak of the Kamnik-Savinja Alps.	2026-04-13 13:50:12.109775	\N	Pot čez južni greben
5047067c-f1c1-4374-b379-9355eaaa8f9c	b9b8f664-8fb2-4607-b1cc-0bf281468c5f	Pot čez Vrata	hard	22	1800	hiking	\N	Classic route to Triglav via the Vrata valley. Long and demanding but very rewarding.	2026-04-13 13:50:12.109775	\N	Pot čez Vrata
c321f994-0b16-4c98-8115-3df14ab46329	1da58feb-2ad1-43a6-8100-c8476f476a03	Normalna pot z Javorniškega Rovta	medium	10	1100	hiking	\N	Most popular route up Stol, through forest and open ridges.	2026-04-13 13:50:12.109775	\N	Normalna pot z Javorniškega Rovta
6c1d8828-e5b1-4232-b61b-b89a6b495d48	b9b8f664-8fb2-4607-b1cc-0bf281468c5f	Tominškova pot	hard	14	1850	hiking	\N	One of the classic routes to the summit of Triglav, starting from Aljažev dom in the Vrata valley. The route begins with a gentle forest walk past a memorial to fallen partisan mountaineers before climbing steeply through the trees with wooden steps in places. Above the treeline the path transitions into an exposed via ferrata section with fixed cables and pegs, traversing the slopes of Begunjski vrh. Above 2000m the terrain eases briefly before the final push to Triglavski dom na Kredarici. The summit approach crosses Triglavski podi plateau before tackling the steep and exposed face of Mali Triglav with fixed cables throughout. The final ridge narrows dramatically on both sides before the last few metres to the Aljažev stolp tower on the summit. Total time approximately 6 hours 10 minutes. Can be busy in summer with queues on the upper sections.	2026-04-14 16:10:21.760523	Ena klasičnih poti na vrh Triglava z izhodiščem pri Aljaževem domu v Vratih. Pot se začne z zložno hojo skozi gozd mimo partizanskega klina in se nato strmo vzpne skozi drevje, mestoma s pomočjo lesenih stopnic. Nad gozdno mejo sledi plezalni del s klini in jeklenicami po pobočjih Begunjskega vrha. Nad 2000 metri se zahtevnost za kratek čas zmanjša, nato pa sledita vzpon do Triglavskega doma na Kredarici in prečenje Triglavskih podov. Zaključni del poti vodi čez strmo in izpostavljeno steno Malega Triglava z jeklenicami vse do vrha. Greben se proti vrhu zoži in postane prepadna na obe strani. Skupni čas vzpona je približno 6 ur in 10 minut. Poleti so na zgornjih odsekih možni zastoji.	Tominškova pot
\.


--
-- TOC entry 6023 (class 0 OID 17534)
-- Dependencies: 225
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, username, password_hash, avatar_url, bio, is_pro, created_at) FROM stdin;
bc5033cd-1832-4a7b-935a-966f0146640c	nace.grabnar@gmail.com	NaceGrabnar	$2b$10$GW.Rv.R7hkEoGD7vs.zLfeeT0A8/1WbzQFh/g1vOUE8dWSaZeK89e	\N	\N	f	2026-04-13 19:22:10.225128
\.


--
-- TOC entry 5834 (class 2606 OID 17563)
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- TOC entry 5836 (class 2606 OID 17565)
-- Name: areas areas_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_slug_key UNIQUE (slug);


--
-- TOC entry 5842 (class 2606 OID 17612)
-- Name: climbing_routes climbing_routes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.climbing_routes
    ADD CONSTRAINT climbing_routes_pkey PRIMARY KEY (id);


--
-- TOC entry 5844 (class 2606 OID 17628)
-- Name: conditions_reports conditions_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conditions_reports
    ADD CONSTRAINT conditions_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 5848 (class 2606 OID 17680)
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- TOC entry 5846 (class 2606 OID 17654)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 5838 (class 2606 OID 17578)
-- Name: summits summits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summits
    ADD CONSTRAINT summits_pkey PRIMARY KEY (id);


--
-- TOC entry 5850 (class 2606 OID 17718)
-- Name: ticklist ticklist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticklist
    ADD CONSTRAINT ticklist_pkey PRIMARY KEY (id);


--
-- TOC entry 5840 (class 2606 OID 17595)
-- Name: trails trails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trails
    ADD CONSTRAINT trails_pkey PRIMARY KEY (id);


--
-- TOC entry 5828 (class 2606 OID 17549)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5830 (class 2606 OID 17547)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5832 (class 2606 OID 17551)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5851 (class 1259 OID 17741)
-- Name: ticklist_user_route_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ticklist_user_route_uniq ON public.ticklist USING btree (user_id, climbing_route_id) WHERE (climbing_route_id IS NOT NULL);


--
-- TOC entry 5852 (class 1259 OID 17739)
-- Name: ticklist_user_summit_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ticklist_user_summit_uniq ON public.ticklist USING btree (user_id, summit_id) WHERE (summit_id IS NOT NULL);


--
-- TOC entry 5853 (class 1259 OID 17740)
-- Name: ticklist_user_trail_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ticklist_user_trail_uniq ON public.ticklist USING btree (user_id, trail_id) WHERE (trail_id IS NOT NULL);


--
-- TOC entry 5856 (class 2606 OID 17613)
-- Name: climbing_routes climbing_routes_summit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.climbing_routes
    ADD CONSTRAINT climbing_routes_summit_id_fkey FOREIGN KEY (summit_id) REFERENCES public.summits(id) ON DELETE CASCADE;


--
-- TOC entry 5857 (class 2606 OID 17639)
-- Name: conditions_reports conditions_reports_climbing_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conditions_reports
    ADD CONSTRAINT conditions_reports_climbing_route_id_fkey FOREIGN KEY (climbing_route_id) REFERENCES public.climbing_routes(id) ON DELETE CASCADE;


--
-- TOC entry 5858 (class 2606 OID 17634)
-- Name: conditions_reports conditions_reports_trail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conditions_reports
    ADD CONSTRAINT conditions_reports_trail_id_fkey FOREIGN KEY (trail_id) REFERENCES public.trails(id) ON DELETE CASCADE;


--
-- TOC entry 5859 (class 2606 OID 17629)
-- Name: conditions_reports conditions_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conditions_reports
    ADD CONSTRAINT conditions_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5863 (class 2606 OID 17696)
-- Name: photos photos_climbing_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_climbing_route_id_fkey FOREIGN KEY (climbing_route_id) REFERENCES public.climbing_routes(id) ON DELETE CASCADE;


--
-- TOC entry 5864 (class 2606 OID 17686)
-- Name: photos photos_summit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_summit_id_fkey FOREIGN KEY (summit_id) REFERENCES public.summits(id) ON DELETE CASCADE;


--
-- TOC entry 5865 (class 2606 OID 17691)
-- Name: photos photos_trail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_trail_id_fkey FOREIGN KEY (trail_id) REFERENCES public.trails(id) ON DELETE CASCADE;


--
-- TOC entry 5866 (class 2606 OID 17681)
-- Name: photos photos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5860 (class 2606 OID 17665)
-- Name: reviews reviews_climbing_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_climbing_route_id_fkey FOREIGN KEY (climbing_route_id) REFERENCES public.climbing_routes(id) ON DELETE CASCADE;


--
-- TOC entry 5861 (class 2606 OID 17660)
-- Name: reviews reviews_trail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_trail_id_fkey FOREIGN KEY (trail_id) REFERENCES public.trails(id) ON DELETE CASCADE;


--
-- TOC entry 5862 (class 2606 OID 17655)
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5854 (class 2606 OID 17579)
-- Name: summits summits_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.summits
    ADD CONSTRAINT summits_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.areas(id) ON DELETE SET NULL;


--
-- TOC entry 5867 (class 2606 OID 17734)
-- Name: ticklist ticklist_climbing_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticklist
    ADD CONSTRAINT ticklist_climbing_route_id_fkey FOREIGN KEY (climbing_route_id) REFERENCES public.climbing_routes(id) ON DELETE CASCADE;


--
-- TOC entry 5868 (class 2606 OID 17724)
-- Name: ticklist ticklist_summit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticklist
    ADD CONSTRAINT ticklist_summit_id_fkey FOREIGN KEY (summit_id) REFERENCES public.summits(id) ON DELETE CASCADE;


--
-- TOC entry 5869 (class 2606 OID 17729)
-- Name: ticklist ticklist_trail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticklist
    ADD CONSTRAINT ticklist_trail_id_fkey FOREIGN KEY (trail_id) REFERENCES public.trails(id) ON DELETE CASCADE;


--
-- TOC entry 5870 (class 2606 OID 17719)
-- Name: ticklist ticklist_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticklist
    ADD CONSTRAINT ticklist_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5855 (class 2606 OID 17596)
-- Name: trails trails_summit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trails
    ADD CONSTRAINT trails_summit_id_fkey FOREIGN KEY (summit_id) REFERENCES public.summits(id) ON DELETE CASCADE;


--
-- TOC entry 6038 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-04-16 10:07:06

--
-- PostgreSQL database dump complete
--

\unrestrict lWgZVJ5lV5eUpr5bW0FIxmhKmTd2NJeexyMdZd07u18RFbXmZprKFv2NnfBvZ6f

