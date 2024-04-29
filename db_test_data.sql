--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

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
-- Name: grouped_spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grouped_spots (
    id_grouped_spots integer NOT NULL,
    groupings_id integer NOT NULL,
    spots_id integer NOT NULL
);


ALTER TABLE public.grouped_spots OWNER TO postgres;

--
-- Name: grouped_spots_id_grouped_spots_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.grouped_spots ALTER COLUMN id_grouped_spots ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grouped_spots_id_grouped_spots_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: groupings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupings (
    id_groupings integer NOT NULL,
    name character varying(255) NOT NULL,
    users_id integer NOT NULL
);


ALTER TABLE public.groupings OWNER TO postgres;

--
-- Name: groupings_id_groupings_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.groupings ALTER COLUMN id_groupings ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.groupings_id_groupings_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: labeled_groupings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labeled_groupings (
    id_labeled_groupings integer NOT NULL,
    groupings_id integer NOT NULL,
    labels_id integer NOT NULL
);


ALTER TABLE public.labeled_groupings OWNER TO postgres;

--
-- Name: labeled_groupings_id_labeled_groupings_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.labeled_groupings ALTER COLUMN id_labeled_groupings ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.labeled_groupings_id_labeled_groupings_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labels (
    id_labels integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.labels OWNER TO postgres;

--
-- Name: labels_id_labels_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.labels ALTER COLUMN id_labels ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.labels_id_labels_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id_locations integer NOT NULL,
    country character varying(255),
    city character varying(255),
    zip character varying(255),
    house_number integer,
    street_name character varying(255),
    spots_id integer NOT NULL,
    x_coordinates real NOT NULL,
    y_coordinates real NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_locations_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.locations ALTER COLUMN id_locations ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.locations_id_locations_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pictures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pictures (
    id_pictures integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    file_path character varying(255) NOT NULL,
    spots_id integer NOT NULL,
    users_id integer
);


ALTER TABLE public.pictures OWNER TO postgres;

--
-- Name: pictures_id_pictures_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pictures ALTER COLUMN id_pictures ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pictures_id_pictures_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots (
    id_spots integer NOT NULL,
    name character varying(255) NOT NULL,
    rating integer,
    n_ratings integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.spots OWNER TO postgres;

--
-- Name: spots_id_spots_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.spots ALTER COLUMN id_spots ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.spots_id_spots_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: spots_labeled; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots_labeled (
    id_spots_labeled integer NOT NULL,
    labels_id integer NOT NULL,
    spots_id integer NOT NULL
);


ALTER TABLE public.spots_labeled OWNER TO postgres;

--
-- Name: spots_labeled_id_spots_labeled_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.spots_labeled ALTER COLUMN id_spots_labeled ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.spots_labeled_id_spots_labeled_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_users integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    name_full character varying(255),
    spot_count integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id_users ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users_ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_ratings (
    id_users_ratings integer NOT NULL,
    users_id integer NOT NULL,
    spots_id integer NOT NULL,
    given_rating integer
);


ALTER TABLE public.users_ratings OWNER TO postgres;

--
-- Name: users_ratings_id_users_ratings_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users_ratings ALTER COLUMN id_users_ratings ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_ratings_id_users_ratings_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: grouped_spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grouped_spots (id_grouped_spots, groupings_id, spots_id) FROM stdin;
1	3	14
2	3	18
3	3	35
4	3	50
5	3	1
6	4	3
7	4	33
9	4	34
10	4	41
11	4	42
12	5	42
13	5	37
14	5	51
15	5	14
16	5	24
17	5	8
18	6	8
19	6	14
21	6	31
22	6	5
23	6	7
24	6	20
\.


--
-- Data for Name: groupings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupings (id_groupings, name, users_id) FROM stdin;
2	Hamba is officially remote !!!! HURRAAAAAA	1
3	Pauls Favourites	2
4	Thomas Favourites	3
5	Wessels Favourites	4
6	Peters Favourites	5
\.


--
-- Data for Name: labeled_groupings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.labeled_groupings (id_labeled_groupings, groupings_id, labels_id) FROM stdin;
1	3	11
2	4	11
3	5	11
4	6	11
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.labels (id_labels, name) FROM stdin;
1	babbon
2	hamba is officially remote HURRRRAAAAAA
3	Ping Pong
4	Accessible
5	Sridhar
6	Park
7	Toilet
8	Bench
9	Flowers
10	Original
11	Favourites
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id_locations, country, city, zip, house_number, street_name, spots_id, x_coordinates, y_coordinates) FROM stdin;
1	Germany	Berlin	12435	65	Lohmuehlenstraße	1	52.49717	13.456173
2	Germany	Berlin	12435	65	Lohmuehlenstraße	2	52.508724	13.407724
3	Germany	Berlin	12435	65	Lohmuehlenstraße	3	52.49499	13.44643
4	Germany	Berlin	12435	65	Lohmuehlenstraße	4	52.55672	13.38133
5	Germany	Berlin	12435	65	Lohmuehlenstraße	5	52.514206	13.413992
6	Germany	Berlin	12435	65	Lohmuehlenstraße	6	52.51218	13.40103
7	Germany	Berlin	12435	65	Lohmuehlenstraße	7	52.5246	13.43232
8	Germany	Berlin	12435	65	Lohmuehlenstraße	8	52.50468	13.33068
9	Germany	Berlin	12435	65	Lohmuehlenstraße	9	52.50812	13.4514
10	Germany	Berlin	12435	65	Lohmuehlenstraße	10	52.49365	13.44398
11	Germany	Berlin	12435	65	Lohmuehlenstraße	11	52.48307	13.41635
12	Germany	Berlin	12435	65	Lohmuehlenstraße	12	52.521927	13.399313
13	Germany	Berlin	12435	65	Lohmuehlenstraße	13	52.52289	13.36967
14	Germany	Berlin	12435	65	Lohmuehlenstraße	14	52.49535	13.44796
15	Germany	Berlin	12435	65	Lohmuehlenstraße	15	52.50354	13.4431
16	Germany	Berlin	12435	65	Lohmuehlenstraße	16	52.49778	13.37176
17	Germany	Berlin	12435	65	Lohmuehlenstraße	17	52.43854	13.17658
18	Germany	Berlin	12435	65	Lohmuehlenstraße	18	52.50399	13.41019
19	Germany	Berlin	12435	65	Lohmuehlenstraße	19	52.55335	13.46155
20	Germany	Berlin	12435	65	Lohmuehlenstraße	20	52.49204	13.46932
21	Germany	Berlin	12435	65	Lohmuehlenstraße	21	52.47889	13.36181
22	Germany	Berlin	12435	65	Lohmuehlenstraße	22	52.52271	13.45856
23	Germany	Berlin	12435	65	Lohmuehlenstraße	23	52.56517	13.35932
24	Germany	Berlin	12435	65	Lohmuehlenstraße	24	52.50624	13.4034
25	Germany	Berlin	12435	65	Lohmuehlenstraße	25	52.5306	13.39659
26	Germany	Berlin	12435	65	Lohmuehlenstraße	26	52.5396	13.35386
27	Germany	Berlin	12435	65	Lohmuehlenstraße	27	52.49433	13.44299
28	Germany	Berlin	12435	65	Lohmuehlenstraße	28	52.5219	13.36933
29	Germany	Berlin	12435	65	Lohmuehlenstraße	29	52.54249	13.40384
30	Germany	Berlin	12435	65	Lohmuehlenstraße	30	52.47705	13.40894
31	Germany	Berlin	12435	65	Lohmuehlenstraße	31	52.54749	13.38808
32	Germany	Berlin	12435	65	Lohmuehlenstraße	32	52.54721	13.38474
33	Germany	Berlin	12435	65	Lohmuehlenstraße	33	52.49611	13.40912
34	Germany	Berlin	12435	65	Lohmuehlenstraße	34	52.53174	13.40844
42	Germany	Munich	80335	13	Marsstraße	35	48.20186	11.60614
43	Germany	Munich	80335	13	Marsstraße	36	48.15685	11.58068
44	Turkey	Sinop	57000	13	Bülent Ecevit Cd.	37	42.05926	35.05009
45	Turkey	Sinop	57000	13	Bülent Ecevit Cd.	38	42.02961	35.16478
46	Turkey	Sinop	57000	13	Bülent Ecevit Cd.	39	42.05967	35.0511
47	Turkey	Sinop	57000	13	Bülent Ecevit Cd.	40	42.05505	35.04535
48	Turkey	Sinop	57000	13	Bülent Ecevit Cd.	41	42.02256	35.1544
49	South Africa	Johannesburg	2193	60	Westwold Way, Parkwood, Randburg,	42	-26.156101	28.029247
50	South Africa	Johannesburg	2193	60	Westwold Way, Parkwood, Randburg,	43	-26.1571	28.02904
51	Germany	Berlin	10969	14	Lindenstraße	44	52.49564	13.4482
52	Germany	Berlin	10969	14	Lindenstraße	45	52.50628	13.396
53	Germany	Berlin	10969	14	Lindenstraße	46	52.52525	13.46388
54	Germany	Berlin	10969	14	Lindenstraße	47	52.55238	13.38673
55	Germany	Berlin	10969	14	Lindenstraße	48	52.51023	13.39979
56	Germany	Berlin	10969	14	Lindenstraße	49	52.54939	13.42277
57	Germany	Berlin	10405	9	Diedenhofer Str.	50	52.51436	13.41584
58	Germany	Berlin	10405	9	Diedenhofer Str.	51	52.4994	13.47634
59	Germany	Berlin	10405	9	Diedenhofer Str.	52	52.53773	13.36196
60	Germany	Berlin	10405	9	Diedenhofer Str.	53	52.53366	13.41799
\.


--
-- Data for Name: pictures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pictures (id_pictures, name, created_at, file_path, spots_id, users_id) FROM stdin;
\.


--
-- Data for Name: spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots (id_spots, name, rating, n_ratings, created_at) FROM stdin;
1	The Cheeze-man Spot	0	0	2024-04-21 10:41:45.352607+00
2	Luisenstädtischer Kirchpark	0	0	2024-04-21 10:41:45.354145+00
3	Lohmühlenspot	0	0	2024-04-21 10:41:45.354826+00
4	Osloer North - along water	0	0	2024-04-21 10:41:45.355482+00
5	Märkischer Spot am Water	0	0	2024-04-21 10:41:45.356166+00
6	Bench am Auswertigen Amt	0	0	2024-04-21 10:41:45.356841+00
7	Volkspark Friedrichshain	0	0	2024-04-21 10:41:45.35757+00
8	Birb is the wirb	0	0	2024-04-21 10:41:45.358264+00
9	Down Warschauer Steps	0	0	2024-04-21 10:41:45.358886+00
10	Smell the Flowers	0	0	2024-04-21 10:41:45.35956+00
12	James-Simon-Park	0	0	2024-04-21 10:41:45.360789+00
13	Welcome to B	0	0	2024-04-21 10:41:45.361465+00
15	EastSide G4llery Lawn	0	0	2024-04-21 10:41:45.362734+00
16	Post-Volleyball	0	0	2024-04-21 10:41:45.363495+00
17	Grab shell dude	0	0	2024-04-21 10:41:45.364184+00
18	Waiting for bus	0	0	2024-04-21 10:41:45.36475+00
19	Weißensee Spot	0	0	2024-04-21 10:41:45.365617+00
20	Good when full	0	0	2024-04-21 10:41:45.366373+00
21	Südkreuz Spot	0	0	2024-04-21 10:41:45.36724+00
22	Hausburg Spot	0	0	2024-04-21 10:41:45.367883+00
23	Schäfer Spot	0	0	2024-04-21 10:41:45.368538+00
24	Waldeck-Park	0	0	2024-04-21 10:41:45.36937+00
25	Mid Haircut	0	0	2024-04-21 10:41:45.369985+00
26	/w the Boiz	0	0	2024-04-21 10:41:45.370682+00
27	Overview	0	0	2024-04-21 10:41:45.371389+00
28	V's Ufer	0	0	2024-04-21 10:41:45.372095+00
29	Sunday	0	0	2024-04-21 10:41:45.372891+00
30	B-day	0	0	2024-04-21 10:41:45.373827+00
31	LVL 1	0	0	2024-04-21 10:41:45.374507+00
32	LVL 2	0	0	2024-04-21 10:41:45.375174+00
33	Boiz	0	0	2024-04-21 10:41:45.3759+00
34	Sid	0	0	2024-04-21 10:41:45.376643+00
35	Freimann Wiese	0	0	2024-04-21 10:46:06.537363+00
36	MUC	0	0	2024-04-21 10:46:06.538402+00
37	I'm a fish morty!	0	0	2024-04-21 10:53:28.5316+00
38	Hulk Overview	0	0	2024-04-21 10:53:28.532534+00
39	Poseidon Overview	0	0	2024-04-21 10:53:28.533229+00
40	Wheel bench spot	0	0	2024-04-21 10:53:28.533838+00
41	Bariş Manço	0	0	2024-04-21 10:53:28.534551+00
42	Gucci Gang	0	0	2024-04-21 11:09:27.019733+00
43	Zoo Lake	0	0	2024-04-21 11:09:27.020958+00
44	C<>DE Pong	0	0	2024-04-21 11:13:57.703144+00
45	Die Jute Zwirbelwiese	0	0	2024-04-21 11:13:57.704923+00
46	Gustavo PingPong	0	0	2024-04-21 11:13:57.706+00
47	Pong with Mosaic	0	0	2024-04-21 11:13:57.706878+00
48	PinpPongSpot	0	0	2024-04-21 11:13:57.707665+00
49	Humanplatz Pong	0	0	2024-04-21 11:13:57.708434+00
50	Märkisches Ufer Spot	0	0	2024-04-21 11:17:43.559384+00
51	Zillepromenade Spot	0	0	2024-04-21 11:17:43.560399+00
52	Spot am Nordhafen	0	0	2024-04-21 11:17:43.56116+00
14	Long times	4	4	2024-04-21 10:41:45.362088+00
53	Wasserturm Spot	3	4	2024-04-21 11:17:43.561877+00
11	Hasenheide roses	5	4	2024-04-21 10:41:45.360222+00
\.


--
-- Data for Name: spots_labeled; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots_labeled (id_spots_labeled, labels_id, spots_id) FROM stdin;
1	3	44
2	3	46
3	3	47
4	3	48
5	3	49
6	3	45
7	5	50
8	5	51
9	5	52
10	5	53
11	8	14
12	10	14
13	10	44
14	4	44
15	9	10
16	10	10
17	10	27
18	6	27
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_users, email, password, name_full, spot_count) FROM stdin;
1	weasel	hambaISPissingBytheTree	paul,peter,wessel,thomas	4
2	paul.schilling@code.berlin	fick3n	Paul Schilling	1
3	thomas.frey@code.berlin	f1ck3n	Thomas Frey	50
4	wessel.weernink@code.berlin	ch33s3	Wessel Weernink	1
5	peter.sanyo@code.berlin	m0v13cutt3r	Péter Sanyó	1
\.


--
-- Data for Name: users_ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_ratings (id_users_ratings, users_id, spots_id, given_rating) FROM stdin;
1	2	14	5
2	3	14	4
3	4	14	3
4	5	14	4
5	2	53	2
6	3	53	3
7	4	53	4
8	5	53	3
9	2	11	5
10	3	11	5
11	4	11	5
12	5	11	5
\.


--
-- Name: grouped_spots_id_grouped_spots_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grouped_spots_id_grouped_spots_seq', 24, true);


--
-- Name: groupings_id_groupings_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groupings_id_groupings_seq', 6, true);


--
-- Name: labeled_groupings_id_labeled_groupings_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.labeled_groupings_id_labeled_groupings_seq', 4, true);


--
-- Name: labels_id_labels_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.labels_id_labels_seq', 11, true);


--
-- Name: locations_id_locations_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_locations_seq', 60, true);


--
-- Name: pictures_id_pictures_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pictures_id_pictures_seq', 1, false);


--
-- Name: spots_id_spots_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spots_id_spots_seq', 53, true);


--
-- Name: spots_labeled_id_spots_labeled_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spots_labeled_id_spots_labeled_seq', 18, true);


--
-- Name: users_id_users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_users_seq', 5, true);


--
-- Name: users_ratings_id_users_ratings_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_ratings_id_users_ratings_seq', 12, true);


--
-- Name: grouped_spots grouped_spots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouped_spots
    ADD CONSTRAINT grouped_spots_pkey PRIMARY KEY (id_grouped_spots);


--
-- Name: groupings groupings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupings
    ADD CONSTRAINT groupings_pkey PRIMARY KEY (id_groupings);


--
-- Name: labeled_groupings labeled_groupings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_groupings
    ADD CONSTRAINT labeled_groupings_pkey PRIMARY KEY (id_labeled_groupings);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id_labels);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id_locations);


--
-- Name: pictures pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id_pictures);


--
-- Name: spots_labeled spots_labeled_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots_labeled
    ADD CONSTRAINT spots_labeled_pkey PRIMARY KEY (id_spots_labeled);


--
-- Name: spots spots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots
    ADD CONSTRAINT spots_pkey PRIMARY KEY (id_spots);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);


--
-- Name: users_ratings users_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_ratings
    ADD CONSTRAINT users_ratings_pkey PRIMARY KEY (id_users_ratings);


--
-- Name: grouped_spots fk_groupings_g_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouped_spots
    ADD CONSTRAINT fk_groupings_g_s FOREIGN KEY (groupings_id) REFERENCES public.groupings(id_groupings) ON DELETE CASCADE;


--
-- Name: labeled_groupings fk_groupings_l_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_groupings
    ADD CONSTRAINT fk_groupings_l_g FOREIGN KEY (groupings_id) REFERENCES public.groupings(id_groupings) ON DELETE CASCADE;


--
-- Name: labeled_groupings fk_labels_l_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_groupings
    ADD CONSTRAINT fk_labels_l_g FOREIGN KEY (labels_id) REFERENCES public.labels(id_labels) ON DELETE CASCADE;


--
-- Name: spots_labeled fk_labels_s_l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots_labeled
    ADD CONSTRAINT fk_labels_s_l FOREIGN KEY (labels_id) REFERENCES public.labels(id_labels) ON DELETE CASCADE;


--
-- Name: pictures fk_spots; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT fk_spots FOREIGN KEY (spots_id) REFERENCES public.spots(id_spots) ON DELETE CASCADE;


--
-- Name: grouped_spots fk_spots_g_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grouped_spots
    ADD CONSTRAINT fk_spots_g_s FOREIGN KEY (spots_id) REFERENCES public.spots(id_spots) ON DELETE CASCADE;


--
-- Name: locations fk_spots_locations; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT fk_spots_locations FOREIGN KEY (spots_id) REFERENCES public.spots(id_spots) ON DELETE CASCADE;


--
-- Name: spots_labeled fk_spots_s_l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots_labeled
    ADD CONSTRAINT fk_spots_s_l FOREIGN KEY (spots_id) REFERENCES public.spots(id_spots) ON DELETE CASCADE;


--
-- Name: users_ratings fk_spots_u_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_ratings
    ADD CONSTRAINT fk_spots_u_s FOREIGN KEY (spots_id) REFERENCES public.spots(id_spots) ON DELETE CASCADE;


--
-- Name: groupings fk_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupings
    ADD CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES public.users(id_users) ON DELETE CASCADE;


--
-- Name: pictures fk_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT fk_users FOREIGN KEY (users_id) REFERENCES public.users(id_users);


--
-- Name: users_ratings fk_users_u_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_ratings
    ADD CONSTRAINT fk_users_u_s FOREIGN KEY (users_id) REFERENCES public.users(id_users);


--
-- PostgreSQL database dump complete
--

