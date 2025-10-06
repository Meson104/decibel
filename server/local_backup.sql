--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Ubuntu 17.5-1.pgdg24.04+1)
-- Dumped by pg_dump version 17.5 (Ubuntu 17.5-1.pgdg24.04+1)

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
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id text NOT NULL,
    song_id text,
    user_id text
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- Name: songs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.songs (
    id text NOT NULL,
    song_url text,
    thumbnail_url text,
    artist text,
    song_name character varying(100),
    hex_code character varying(6)
);


ALTER TABLE public.songs OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id text NOT NULL,
    name character varying(100),
    email character varying(100),
    password bytea
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, song_id, user_id) FROM stdin;
9fbfc492-3e54-4a4f-a2d8-7bf7e2129b3b	2e7549db-ad12-4b8b-96ce-0a089a5c31f6	cad8af26-b591-45c3-a02b-03b1f4ced4a6
\.


--
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.songs (id, song_url, thumbnail_url, artist, song_name, hex_code) FROM stdin;
2e7549db-ad12-4b8b-96ce-0a089a5c31f6	http://res.cloudinary.com/dvbnlssln/video/upload/v1748878723/songs/2e7549db-ad12-4b8b-96ce-0a089a5c31f6/m5bghd4f1noybn9s79ig.mp3	http://res.cloudinary.com/dvbnlssln/image/upload/v1748878725/songs/2e7549db-ad12-4b8b-96ce-0a089a5c31f6/q3qeq2z9wgpgunoizagw.jpg	kar	sample	e53935
bc18f13a-5dc0-4385-8c1f-db62c903e68c	http://res.cloudinary.com/dvbnlssln/video/upload/v1749293082/songs/bc18f13a-5dc0-4385-8c1f-db62c903e68c/u2ynspcbmbmgldocy0x3.mp3	http://res.cloudinary.com/dvbnlssln/image/upload/v1749293084/songs/bc18f13a-5dc0-4385-8c1f-db62c903e68c/mrh2ungogvotqhx7eksz.jpg	John Paesano	Marvel's Spider-Man (Official soundtrack)	a91212
46cb1df1-b24b-4c84-8095-67a2560ced2a	http://res.cloudinary.com/dvbnlssln/video/upload/v1749293226/songs/46cb1df1-b24b-4c84-8095-67a2560ced2a/mtw4y9ccoi1uez3wkkmt.mp3	http://res.cloudinary.com/dvbnlssln/image/upload/v1749293228/songs/46cb1df1-b24b-4c84-8095-67a2560ced2a/jihf3zu0al65ooeyacbm.jpg	John Paesano	Marvel's Spider-Man 2 : Greater Together	c01a10
6f38813f-db6d-4825-aa9f-c689b0287687	http://res.cloudinary.com/dvbnlssln/video/upload/v1749293369/songs/6f38813f-db6d-4825-aa9f-c689b0287687/wjmbwvqsrlmf13izduli.mp3	http://res.cloudinary.com/dvbnlssln/image/upload/v1749293371/songs/6f38813f-db6d-4825-aa9f-c689b0287687/qjxqp6ort5moy9plubed.jpg	Survivor	Eye of the Tiger - Rocky III	378cd1
a1022cd4-d32c-44cb-8c22-ec0e11f07660	http://res.cloudinary.com/dvbnlssln/video/upload/v1749325735/songs/a1022cd4-d32c-44cb-8c22-ec0e11f07660/dxfvsdyqqvp3bqyzcs4p.mp3	http://res.cloudinary.com/dvbnlssln/image/upload/v1749325736/songs/a1022cd4-d32c-44cb-8c22-ec0e11f07660/otnhlwlfbmymn0s6nxqd.jpg	Hesham Nazih	Moon Knight	434343
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password) FROM stdin;
c3d82b11-787e-4787-a7db-9083edd5715b	Kartikeya	test@gmail.com	\\x24326224313624522f42556c4547713337426f5a5935612e534775427541545636346f425279694c57656e413761585849504b6e45464f7139434c6d
d432f3fb-1ef9-49c6-a461-d6016ac1c23c	Kartikeya	tester@gmail.com	\\x243262243136245670586c647a4d734b454a477341614f417a6d636f4f2f5a4d434d3875774647356d484479693477546756687a4463467230397447
855d7294-d8ae-462b-8e80-662c732d45c1	Kartikeya	tester1@gmail.com	\\x243262243136246c43473547486f574b587259644935533241637578757539473268693346682f636c736e2e4a74665570436146783734792e35706d
2289b07d-62ad-4b5e-aec6-2f1e00fe398e	Sahil	evilnigga@gmail.com	\\x2432622431362456587a453758742f486e512e346272707848656c2f2e7a425447357259725a6c6167635a6a7277615933756d47575058692f50504b
ed7e5f21-eb99-4f9f-865c-21c696f5afea			\\x24326224313624586f496f3462506c526c3541315a392e70377a496e2e7a54584d4b384776347338695a444471697759574b424b3159775a67384a53
88eb3d24-2447-414c-9b43-ed22bea85e01	kar	kar@email.com	\\x243262243136245a4472475153635a626c6135792f4176362f554469756e6e77485453684366687a5259746c6a3049704135644c7056527052493569
f65bdc7c-ac60-40ce-9d1d-56e1c4482dfc	Vivek	vivek@gmail.com	\\x24326224313624756864453061566d524b4a6164556b626c7678504c2e3855502e5a44334b75746c33315a366b663568646f676733616c7749467943
cad8af26-b591-45c3-a02b-03b1f4ced4a6	Prime	prime@gmail.com	\\x24326224313624655676715332466f47545369693578387751717a522e5258644c7963363048546e6e394872636a7078373449433553437a76655843
23dd3b0a-ddde-47ed-a7b4-fc81a065ee19	Ares	ares@gow.ai	\\x243262243136244f62646c2f33747639547471336246467051727a6c4f3776476a614f4d6a5a63386c56634a716230414438526a4372772f7855616d
a6482336-bd96-4340-8b6f-f8f9d8904c28	Ares	ares@gow.ai	\\x243262243136247074623966525439796c717a4541704459534844387545543862346b48725932457633444a4d2f5057324f7946704e524b69373475
4ed20916-e584-4870-8524-d3635d8bb809	Ultron	ultron@gmail.com	\\x243262243136243967555a344163456d2f664544732e7567503471466550314f7a6352624931774a50724f4b783567317a55647148474952636d484f
657c9b23-4f30-42fa-a7f7-be400978e489	microbot	mbot@gmail.com	\\x24326224313624497a34344d6e7776526439634c684a643069505038657a4735505443477068762e6b6e365246423248397664702f374c4e6470362e
aaf6aa19-cf69-46a0-8eaf-22170dd9b63b	kneegrow	real@gmail.com	\\x24326224313624524a55745a4a7a596856756b2e6372313548774b2e656f6a5548464c7449736154507067785768446e6341796a2f5636726e387269
48d11df0-373b-44d6-be66-48d3b4563370	tester	test123@gmail.com	\\x243262243136246a48376b765279574c6f764a6a6b30664c5364484a75466e664f4274572f33335671505a63676a725a31446848675231596f6b452e
ab5664fc-9ad5-41f5-b3bf-fc20d1327140	Kar	testmail1@gmail.com	\\x243262243136244f716f59736a4d35626e4b6b70326f595073667671752e66743632782f4555574a3635396d76325a726364686864556d2f6554742e
\.


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: songs songs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.songs(id);


--
-- Name: favorites favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

