--
-- PostgreSQL database dump
--

\restrict 47AxrBfev3uPT1csq7wz201PV92VuQL1SN8giORsAocISWSmXsBZ0jBTULOlrAU

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.areas DISABLE TRIGGER ALL;

INSERT INTO public.areas (id, name, slug, region, description, location, elevation_min, elevation_max, created_at) VALUES ('5631819f-979a-4767-a5a8-383b5ed326e3', 'Julijske Alpe', 'julijske-alpe', 'Gorenjska', 'Highest mountain range in Slovenia, home of Triglav.', NULL, NULL, NULL, '2026-04-13 12:17:04.80348');
INSERT INTO public.areas (id, name, slug, region, description, location, elevation_min, elevation_max, created_at) VALUES ('297f3879-484e-4d03-9eb1-966792fd9a7e', 'Karavanke', 'karavanke', 'Gorenjska', 'Long mountain range on the border with Austria.', NULL, NULL, NULL, '2026-04-13 12:17:04.80348');
INSERT INTO public.areas (id, name, slug, region, description, location, elevation_min, elevation_max, created_at) VALUES ('96108f89-1b09-499e-a1f3-d5139bda063a', 'Kamniško-Savinjske Alpe', 'kamnisko-savinjske-alpe', 'Savinjska', 'Central Slovenian mountain range with dramatic walls.', NULL, NULL, NULL, '2026-04-13 12:17:04.80348');


ALTER TABLE public.areas ENABLE TRIGGER ALL;

--
-- Data for Name: summits; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.summits DISABLE TRIGGER ALL;

INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b9b8f664-8fb2-4607-b1cc-0bf281468c5f', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Triglav', 'Triglav', 2864, NULL, 'Highest peak in Slovenia and national symbol.', 'peak', '2026-04-13 12:17:04.806334', 'Najvišji vrh Slovenije in simbol slovenskega naroda. Triglav je srce Triglavskega narodnega parka.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('1ea0d02e-e746-4987-a900-622136d8fc09', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Mangart', 'Mangart', 2679, NULL, 'Second highest peak in Slovenia with views into Italy and Austria.', 'peak', '2026-04-13 12:17:04.806334', 'Drugi najvišji vrh v Sloveniji z osupljivimi razgledi na Italijo in Avstrijo.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('9d037f48-6bdb-4d38-bc43-1b332464bb3d', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Jalovec', 'Jalovec', 2645, NULL, 'One of the most beautiful peaks in the Julian Alps.', 'peak', '2026-04-13 12:17:04.806334', 'Eden najlepših vrhov Julijskih Alp, znan po ostrih grebenih in zahtevnih smereh.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('de3f6143-f32b-48be-880e-08279260bf05', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Grintovec', 'Grintovec', 2558, NULL, 'Highest peak of the Kamnik-Savinja Alps.', 'peak', '2026-04-13 12:17:04.806334', 'Najvišji vrh Kamniško-Savinjskih Alp z označenimi potmi iz različnih smeri.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('1da58feb-2ad1-43a6-8100-c8476f476a03', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Stol', 'Stol', 2236, NULL, 'Highest peak of the Karavanke on the Slovenian side.', 'peak', '2026-04-13 12:17:04.806334', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('df471336-df80-4e39-800e-041eafc9bf3a', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Brana', 'Brana', 2253, NULL, 'Distinctive peak above Kamniško sedlo, popular with mountaineers.', 'peak', '2026-04-14 07:53:25.604314', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('7630d807-b661-43c8-96a8-96526bfb6fe3', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Planjava', 'Planjava', 2394, NULL, 'Broad summit with excellent circular routes above Logarska dolina.', 'peak', '2026-04-14 07:53:25.604314', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('bf43f570-93fb-4a90-b40c-db1f5ca0ba55', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Storžič', 'Storžič', 2132, NULL, 'One of the most popular peaks in the Kamnik-Savinja Alps, great views.', 'peak', '2026-04-14 07:53:25.604314', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b21ca54f-ad3d-4aa8-ac73-7a21c2d3a9e4', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Raduha', 'Raduha', 2062, NULL, 'Remote peak above Logarska dolina, known for the Snežna jama ice cave nearby.', 'peak', '2026-04-14 07:53:25.604314', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('e381d3f0-52e9-4342-8df6-5c17b2d01621', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Jezerska Kočna', 'Jezerska Kočna', 2540, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c7c490bf-a55f-4bde-b1eb-f19f94e5303c', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kokrska Kočna', 'Kokrska Kočna', 2520, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('5356cfe5-1035-4a19-affd-0c8e04263266', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Na Križu', 'Na Križu', 2484, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b7203215-88bc-4ba7-9adb-67e59fcd77e0', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Dolgi hrbet', 'Dolgi hrbet', 2473, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('129fd77a-b4c5-4a7d-978f-65f5b59d1a86', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Štruca', 'Štruca', 2457, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('271e6b33-9e2d-484c-9cd0-2c0dd1a3d561', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kranjska Rinka', 'Kranjska Rinka', 2453, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('1bf690d5-565c-4e90-ac79-796909096065', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Koroška Rinka', 'Koroška Rinka', 2433, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('a929a3f1-f8a9-4e1c-8536-2f3a823a5e63', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Planjava - zahodni vrh', 'Planjava - zahodni vrh', 2394, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c2cba3ac-02e9-4cf0-89a7-eb61312fcb79', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Štajerska Rinka', 'Štajerska Rinka', 2374, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b335c4fa-e300-4c03-8efd-d396e0648abc', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Lučka Brana', 'Lučka Brana', 2331, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('cce60bb8-85f8-40c6-babf-6a9d07fadc27', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Mala Rinka', 'Mala Rinka', 2289, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('8b6d6bc1-e03b-4d17-b431-b2f6c4082de0', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Turska gora', 'Turska gora', 2251, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('3ef9e210-d00d-4b1b-95ee-05797e9da4ed', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kalški greben', 'Kalški greben', 2224, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('46bb0aa7-f7ae-45c3-9d2a-c3530d5d8a8d', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Mrzla gora', 'Mrzla gora', 2203, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('74cd6060-d7fa-45a4-9310-2f6a5001e1d0', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Najvišji rob', 'Najvišji rob', 2127, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('d8ac9ed3-a803-4a3f-8894-d551b707faa5', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Velika Baba', 'Velika Baba', 2127, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('6fba209f-48e3-4874-87e8-3c6abdbce38f', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Velika Zelenica', 'Velika Zelenica', 2114, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('aea713a3-07c5-4293-be6b-91ee63ffcccc', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Storžek', 'Storžek', 2110, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('7cee2ae9-a232-484e-a6f2-72d849a9008c', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Veliki vrh', 'Veliki vrh', 2110, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('e45bc0b3-112c-4b56-bfc3-1203d6e733fd', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Ledinski vrh', 'Ledinski vrh', 2108, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('e937155c-b8df-47e6-9ee8-c3f69ddf0086', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kogel', 'Kogel', 2100, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('1499ad56-4104-400f-b508-7610aa9d9aa4', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Krofička', 'Krofička', 2083, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('cfdc3acf-a718-4b6e-9643-595bec02c62a', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Velika Raduha', 'Velika Raduha', 2062, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('25560c4e-2670-4d07-aa35-ad109a685ca3', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kalška gora', 'Kalška gora', 2047, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('9bb99e35-adf9-4d22-a241-834be010dbab', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Mala Raduha', 'Mala Raduha', 2029, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('6f017dcc-48df-4faf-a486-f325383ee289', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Molička peč', 'Molička peč', 2029, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('86f22509-e02f-4d5d-926f-5ff56cd65423', NULL, 'Osp', 'Osp', 100, NULL, 'World famous sport climbing crag above the village of Osp.', 'crag', '2026-04-13 13:52:07.624319', 'Svetovno znana športnoplezalna stena nad vasjo Osp z apnenčastimi stenami.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e', NULL, 'Mišja Peč', 'Mišja Peč', 120, NULL, 'One of the hardest climbing crags in Europe.', 'crag', '2026-04-13 13:52:07.624319', 'Ena najtežjih plezalnih sten v Evropi z mnogimi smermi devetih stopenj.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('d1cb14d6-a3fe-448e-8745-7708297cbc71', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Velika Planina', 'Velika Planina', 1666, NULL, 'Famous alpine plateau with traditional shepherd huts, accessible by cable car.', 'peak', '2026-04-14 07:53:25.604314', 'Razgledna planota z značilnimi pastirskimi kočami, dostopna z gondolo.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('9dc7a521-6190-4132-8d3d-5d95663f4257', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Lučki Dedec', 'Lučki Dedec', 2023, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('fed3f00d-d480-4944-b3cf-b50ce4daeef9', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Mala Ojstrica', 'Mala Ojstrica', 2017, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('86a8e990-ff49-467e-97ee-2b9f9bc90a01', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Vrh Korena', 'Vrh Korena', 1999, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c8204d50-065b-46b3-acf9-547594653a94', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kompotela', 'Kompotela', 1989, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('ec1bf083-c571-48cf-99da-a1c9344a12bb', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Tolsti vrh', 'Tolsti vrh', 1985, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b0205feb-3b5e-4261-945b-b1a7b397c4fb', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Vršiči', 'Vršiči', 1980, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('227a8075-11b7-4cfb-ba68-bf6c197dfaf2', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Košutna', 'Košutna', 1974, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('2d6445f4-da41-4888-9fcd-9f825ed1fb56', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Veliki Zvoh', 'Veliki Zvoh', 1971, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('0b4a9ad2-9826-4034-b686-9f00f41cbc57', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Deska', 'Deska', 1970, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('966c8737-8cb8-4aa7-ac27-16b67fceeab1', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Vežica', 'Vežica', 1965, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('de76a638-d9a1-49bd-bb56-20af35c9a438', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Dleskovec', 'Dleskovec', 1965, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('0013ca4c-1ac9-4db4-b484-c6850f3c20b6', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Matkova kopa', 'Matkova kopa', 1957, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('9e27637f-4b86-49ce-aac9-794541f265a4', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Lanež', 'Lanež', 1925, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('5fb0484e-2552-401e-95a3-2d2c639ca4a4', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Križevnik', 'Križevnik', 1909, NULL, NULL, 'peak', '2026-04-14 07:56:33.171225', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('ab514d14-635c-47d8-91f9-e1c79fca1134', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Skuta', 'Skuta', 2532, NULL, 'Second highest peak in the Kamnik-Savinja Alps, known for its dramatic north face.', 'peak', '2026-04-14 07:53:25.604314', 'Drugi najvišji vrh Kamniško-Savinjskih Alp z zahtevno severno steno.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('267785cc-d923-42aa-ae04-7ffad34f44c6', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Kočna', 'Kočna', 2540, NULL, 'Impressive peak above Jezersko with a demanding ascent.', 'peak', '2026-04-14 07:53:25.604314', 'Markanten vrh nad Jezerskim z zahtevnim vzponom.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c9199782-9848-490a-aa2b-600e6338a504', '96108f89-1b09-499e-a1f3-d5139bda063a', 'Ojstrica', 'Ojstrica', 2350, NULL, 'Sharp rocky peak with beautiful views over Logarska dolina.', 'peak', '2026-04-14 07:53:25.604314', 'Oster skalnati vrh z lepimi razgledi nad Logarsko dolino.', NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('d8c8b6aa-0e93-471f-b766-70e877c5268a', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Škrlatica', 'Škrlatica', 2740, NULL, 'Second highest peak in Slovenia, known for its imposing north face and demanding routes.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('9ca6e361-7845-40e3-bb1a-c49382fde033', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Razor', 'Razor', 2601, NULL, 'Distinctive sharp peak in the Julian Alps with excellent views towards Triglav.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('a7a47971-732c-4524-9632-8f5ea6748663', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Prisojnik', 'Prisojnik', 2547, NULL, 'One of the most popular peaks in the Julian Alps, known for the Window of Prisojnik rock formation.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('15dd7faf-384c-4256-bbf5-b7c769be0cfc', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Kanjavec', 'Kanjavec', 2568, NULL, 'Remote and wild peak in the heart of Triglav National Park.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('5692b60d-7604-422a-82e7-d3e552798041', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Bogatin', 'Bogatin', 2003, NULL, 'Beautiful peak above Bohinjsko jezero with panoramic views over the Bohinj valley.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('6a7352a9-bea9-498d-bbd2-60b993ae6d3b', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Krn', 'Krn', 2244, NULL, 'Historic WWI battlefield peak above the Soča valley with a mountain lake nearby.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c2fba83b-0db1-4229-96b8-f5e54458079f', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Rombon', 'Rombon', 2208, NULL, 'Impressive peak above Bovec with views over the Soča valley and the Italian border.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('16a0bc2d-32eb-482b-8fa3-ab8e5558c149', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Polovnik', 'Polovnik', 1621, NULL, 'Popular viewpoint above Kobarid with views over the Soča valley.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b22166b5-0cc0-4b94-b960-11433f9c950a', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Stog', 'Stog', 1673, NULL, 'Accessible peak above Tolmin with beautiful views over the Soča and Tolminka valleys.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('66d22f7f-c9a4-4194-8852-789b6e21f8df', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Črna prst', 'Črna prst', 1844, NULL, 'Popular ski and hiking destination above Bohinjska Bistrica.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c96d95a8-bfa3-4dc4-8dba-afb1873dbfbb', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Vogel', 'Vogel', 1922, NULL, 'Accessible by cable car from Bohinjsko jezero, stunning views over Bohinj and Triglav.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c4280359-ddd2-4020-9da4-65c89c9be4e8', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Veliki Draški vrh', 'Veliki Draški vrh', 2243, NULL, 'High plateau peak in the Triglav National Park above Bohinj.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('286b46e6-bb8e-4aa6-bef8-03f7c29701e3', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Tosc', 'Tosc', 2275, NULL, 'Broad summit in the Julian Alps above the Bohinj valley.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('2d2f730c-00ed-4180-aca7-d5244f307d65', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Vrh Planje', 'Vrh Planje', 2347, NULL, 'High peak in the Julian Alps near the Italian border.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('8bb56f64-3e42-4a30-b5a2-da75e47719e2', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Visoka Ponca', 'Visoka Ponca', 2274, NULL, 'Peak on the Slovenian-Italian border above the Trenta valley.', 'peak', '2026-04-14 16:39:28.652083', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('a45d2598-8df5-4e06-9343-d272c4e2657e', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Košuta', 'Košuta', 2133, NULL, 'Long ridge peak on the Austrian border, popular for its panoramic views.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('3b880f15-9a82-4371-b2d6-aaca56c5c19b', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Begunjščica', 'Begunjščica', 2060, NULL, 'Distinctive peak above Begunje na Gorenjskem with views over the Sava valley.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('ccd8b85c-c2a3-45ef-95ea-3758ab07fa96', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Kepa', 'Kepa', 2143, NULL, 'Northernmost high peak in Slovenia on the Austrian border above Jesenice.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('2e544b2a-55ea-44ae-b484-0d2cac9a2325', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Golica', 'Golica', 1836, NULL, 'Famous for its spectacular narcissus bloom every spring, one of the most visited peaks in Slovenia.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('c853f24b-dcf2-4952-8801-9c782c3dcd1d', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Karavanke', 'Karavanke', 1991, NULL, 'Broad summit on the main Karavanke ridge with views into Austria.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('2f7751ee-dd92-4f49-8844-be04d4b2ab0c', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Ojstrnik', 'Ojstrnik', 1945, NULL, 'Sharp rocky peak in the eastern Karavanke range.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b6df36c5-df09-49b9-85e3-6139b9a6aa74', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Kočna', 'Kočna', 1999, NULL, 'Accessible peak in the western Karavanke with panoramic views.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('8c0dbfb6-ca02-44fd-8064-b5b6e0ba1c2d', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Vrtača', 'Vrtača', 2180, NULL, 'High peak in the Karavanke range above Tržič with demanding approaches.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('dca11122-f02a-4111-b8d4-672aad663616', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Tolsti vrh', 'Tolsti vrh', 1712, NULL, 'Forested peak in the western Karavanke above Kranjska Gora.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('b2b85b67-3bfd-4df2-914b-61c27e47cc37', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Struška Kočna', 'Struška Kočna', 2083, NULL, 'Remote peak in the central Karavanke with beautiful alpine scenery.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('6b0df5e2-4e46-4b44-bc25-c8c15adde80f', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Smrekovec', 'Smrekovec', 1577, NULL, 'Forested peak in the eastern Karavanke, popular family hiking destination.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('87a45a3a-3411-4765-8f4c-8b2e846b0eb7', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Peca', 'Peca', 2126, NULL, 'Highest peak in the eastern Karavanke, on the tripoint border of Slovenia, Austria and Italy.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('6a1c121b-3377-4f92-a755-e1e6f80f72f3', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Olševa', 'Olševa', 1929, NULL, 'Beautiful plateau peak in the eastern Karavanke above Solčava.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('27a5c5cf-65e2-47bb-9fd5-ecee9c54979b', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Uršlja gora', 'Uršlja gora', 1699, NULL, 'Highest peak in the Pohorje-Uršlja gora range, with a church on the summit.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('95c3e205-e091-4479-ae93-efbb9a025775', '297f3879-484e-4d03-9eb1-966792fd9a7e', 'Razen', 'Razen', 1796, NULL, 'Rocky peak in the central Karavanke with views over the Mežica valley.', 'peak', '2026-04-14 16:40:23.106794', NULL, NULL);
INSERT INTO public.summits (id, area_id, name, name_sl, elevation_m, location, description, type, created_at, description_sl, difficulty) VALUES ('7f321e7a-e3cf-41e1-b2ff-e2d6fa356b43', '5631819f-979a-4767-a5a8-383b5ed326e3', 'Jôf di Montasio', 'Montaž', 2753, NULL, 'Jôf di Montasio with its 2753m of elevation is the second highest peak of Julian alps. On the summit there''s a cross with a bell dedicated to an alpinist Riccardo Deffar', 'peak', '2026-04-14 19:29:37.127808', 'Montaž je s svojimi 2753m nadmorske višine druga najvišja gora v Julijskih Alpah. Na vrhu stoji križ z zvoncem, ki je posvečen alpinistu Riccardu Deffarju.', NULL);


ALTER TABLE public.summits ENABLE TRIGGER ALL;

--
-- Data for Name: climbing_routes; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.climbing_routes DISABLE TRIGGER ALL;

INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('6ac74535-e102-43bc-beba-8153d067e504', '86f22509-e02f-4d5d-926f-5ff56cd65423', 'Picnik', '6c', 'VII+', NULL, 'sport', 25, 10, NULL, 'A popular moderate route, great for intermediate climbers.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('6bd93b8b-7f66-4df4-a7d8-aa01be8a2e02', '86f22509-e02f-4d5d-926f-5ff56cd65423', 'Valter', '7a', 'VIII', NULL, 'sport', 22, 9, NULL, 'Sustained climbing with a crux near the top.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('72508556-3e9c-4a9f-8719-e50ac765a55a', '7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e', 'Bala', '9a', 'XI', NULL, 'sport', 35, 14, NULL, 'One of the hardest routes in Slovenia, requiring exceptional strength.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('7c5c0ec2-f992-41a3-ad74-726bc170e5f9', '7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e', 'Charge', '8a+', 'X', NULL, 'sport', 30, 12, NULL, 'Powerful moves on an overhanging wall, a must-do for strong climbers.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('84a09177-e059-45d3-a8f1-641cb0af61ab', 'b9b8f664-8fb2-4607-b1cc-0bf281468c5f', 'Helba - Gorenjska', NULL, 'VII+', 'TD+', 'alpine', 1000, NULL, NULL, 'Classic alpine route on the Triglav North Face. First climbed in 1928 (Gorenjska) and 1971 (Helba). 1000m wall, 1450m total elevation gain. Approach 1h15min from Aljazev Dom. Gear: cams 0.3-3, nuts, slings. One of the great Julian Alps classics.', '2026-04-13 19:51:21.30197', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('47c7aab8-424b-4c57-a149-6873dadcfc50', '7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e', 'Mala Mišja', '7c', 'IX', NULL, 'sport', 26, 10, NULL, 'Excellent climbing for advanced sport climbers, technical and sustained.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('c0e028f8-f789-4651-a1fb-f3d26c2955e5', '86f22509-e02f-4d5d-926f-5ff56cd65423', 'Obsesija', '8a', 'IX+', NULL, 'sport', 30, 12, NULL, 'One of the classic hard routes at Osp, powerful moves on perfect limestone.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('ab5e12db-27d8-4356-b52f-ea54a031651a', '86f22509-e02f-4d5d-926f-5ff56cd65423', 'Strelovod', '7b', 'VIII+', NULL, 'sport', 28, 11, NULL, 'Technical face climbing on small holds, a Osp classic.', '2026-04-13 13:56:37.993069', NULL, NULL);
INSERT INTO public.climbing_routes (id, summit_id, name, grade_french, grade_uiaa, grade_alpine, type, length_m, num_bolts, rock_type, description, created_at, description_sl, name_sl) VALUES ('269b9875-5c31-4e31-ad38-30826ad7fdc2', '7dc85d4f-fdaa-46f8-92ea-2f6d374d9a2e', 'Sanjski par', '8b+', 'X+', NULL, 'sport', 32, 13, NULL, 'Dream route with continuous technical climbing on steep limestone.', '2026-04-13 13:56:37.993069', NULL, NULL);


ALTER TABLE public.climbing_routes ENABLE TRIGGER ALL;

--
-- Data for Name: trails; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.trails DISABLE TRIGGER ALL;

INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('8873edf7-07d4-42a7-9bee-a58f4dfd6506', 'b9b8f664-8fb2-4607-b1cc-0bf281468c5f', 'Kredarica route', 'hard', 18, 1600, 'hiking', NULL, 'Route via Kredarica mountain hut, most popular path to the summit.', '2026-04-13 13:50:12.109775', NULL, 'Pot čez Kredarico');
INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('04c5b73b-891c-439a-8347-1a9ec54beeff', '1ea0d02e-e746-4987-a900-622136d8fc09', 'Mangart Saddle route', 'medium', 4, 350, 'hiking', NULL, 'Short but scenic route from the Mangart saddle, accessible by road.', '2026-04-13 13:50:12.109775', NULL, 'Pot čez Mangartsko sedlo');
INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('2e15bba4-196e-45b6-a143-c049e9dfc29b', 'de3f6143-f32b-48be-880e-08279260bf05', 'South ridge route', 'hard', 12, 1400, 'hiking', NULL, 'Classic ridge approach to the highest peak of the Kamnik-Savinja Alps.', '2026-04-13 13:50:12.109775', NULL, 'Pot čez južni greben');
INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('5047067c-f1c1-4374-b379-9355eaaa8f9c', 'b9b8f664-8fb2-4607-b1cc-0bf281468c5f', 'Pot čez Vrata', 'hard', 22, 1800, 'hiking', NULL, 'Classic route to Triglav via the Vrata valley. Long and demanding but very rewarding.', '2026-04-13 13:50:12.109775', NULL, 'Pot čez Vrata');
INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('c321f994-0b16-4c98-8115-3df14ab46329', '1da58feb-2ad1-43a6-8100-c8476f476a03', 'Normalna pot z Javorniškega Rovta', 'medium', 10, 1100, 'hiking', NULL, 'Most popular route up Stol, through forest and open ridges.', '2026-04-13 13:50:12.109775', NULL, 'Normalna pot z Javorniškega Rovta');
INSERT INTO public.trails (id, summit_id, name, difficulty, distance_km, elevation_gain_m, activity_type, path, description, created_at, description_sl, name_sl) VALUES ('6c1d8828-e5b1-4232-b61b-b89a6b495d48', 'b9b8f664-8fb2-4607-b1cc-0bf281468c5f', 'Tominškova pot', 'hard', 14, 1850, 'hiking', NULL, 'One of the classic routes to the summit of Triglav, starting from Aljažev dom in the Vrata valley. The route begins with a gentle forest walk past a memorial to fallen partisan mountaineers before climbing steeply through the trees with wooden steps in places. Above the treeline the path transitions into an exposed via ferrata section with fixed cables and pegs, traversing the slopes of Begunjski vrh. Above 2000m the terrain eases briefly before the final push to Triglavski dom na Kredarici. The summit approach crosses Triglavski podi plateau before tackling the steep and exposed face of Mali Triglav with fixed cables throughout. The final ridge narrows dramatically on both sides before the last few metres to the Aljažev stolp tower on the summit. Total time approximately 6 hours 10 minutes. Can be busy in summer with queues on the upper sections.', '2026-04-14 16:10:21.760523', 'Ena klasičnih poti na vrh Triglava z izhodiščem pri Aljaževem domu v Vratih. Pot se začne z zložno hojo skozi gozd mimo partizanskega klina in se nato strmo vzpne skozi drevje, mestoma s pomočjo lesenih stopnic. Nad gozdno mejo sledi plezalni del s klini in jeklenicami po pobočjih Begunjskega vrha. Nad 2000 metri se zahtevnost za kratek čas zmanjša, nato pa sledita vzpon do Triglavskega doma na Kredarici in prečenje Triglavskih podov. Zaključni del poti vodi čez strmo in izpostavljeno steno Malega Triglava z jeklenicami vse do vrha. Greben se proti vrhu zoži in postane prepadna na obe strani. Skupni čas vzpona je približno 6 ur in 10 minut. Poleti so na zgornjih odsekih možni zastoji.', 'Tominškova pot');


ALTER TABLE public.trails ENABLE TRIGGER ALL;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, username, password_hash, avatar_url, bio, is_pro, created_at) VALUES ('bc5033cd-1832-4a7b-935a-966f0146640c', 'nace.grabnar@gmail.com', 'NaceGrabnar', '$2b$10$GW.Rv.R7hkEoGD7vs.zLfeeT0A8/1WbzQFh/g1vOUE8dWSaZeK89e', NULL, NULL, false, '2026-04-13 19:22:10.225128');


ALTER TABLE public.users ENABLE TRIGGER ALL;

--
-- Data for Name: conditions_reports; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.conditions_reports DISABLE TRIGGER ALL;

INSERT INTO public.conditions_reports (id, user_id, trail_id, climbing_route_id, status, notes, reported_at) VALUES ('f908b3af-6de8-4706-b0e7-cfaa61655101', 'bc5033cd-1832-4a7b-935a-966f0146640c', '5047067c-f1c1-4374-b379-9355eaaa8f9c', NULL, 'good', 'Pot je lepo urejena in varovana s klini.', '2026-04-13 19:45:05.998813');


ALTER TABLE public.conditions_reports ENABLE TRIGGER ALL;

--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.photos DISABLE TRIGGER ALL;



ALTER TABLE public.photos ENABLE TRIGGER ALL;

--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.reviews DISABLE TRIGGER ALL;



ALTER TABLE public.reviews ENABLE TRIGGER ALL;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.spatial_ref_sys DISABLE TRIGGER ALL;



ALTER TABLE public.spatial_ref_sys ENABLE TRIGGER ALL;

--
-- Data for Name: ticklist; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.ticklist DISABLE TRIGGER ALL;



ALTER TABLE public.ticklist ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

\unrestrict 47AxrBfev3uPT1csq7wz201PV92VuQL1SN8giORsAocISWSmXsBZ0jBTULOlrAU

