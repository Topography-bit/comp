--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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

ALTER TABLE IF EXISTS ONLY public.workers DROP CONSTRAINT IF EXISTS workers_position_id_fkey;
ALTER TABLE IF EXISTS ONLY public.workers DROP CONSTRAINT IF EXISTS workers_devision_id_fkey;
ALTER TABLE IF EXISTS ONLY public.devisions DROP CONSTRAINT IF EXISTS devisions_organize_id_fkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_document_id_fkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_author_id_fkey;
ALTER TABLE IF EXISTS ONLY public.workingcalendar DROP CONSTRAINT IF EXISTS workingcalendar_pk;
ALTER TABLE IF EXISTS ONLY public.workers DROP CONSTRAINT IF EXISTS workers_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.test DROP CONSTRAINT IF EXISTS test_pkey;
ALTER TABLE IF EXISTS ONLY public.positions DROP CONSTRAINT IF EXISTS positions_pkey;
ALTER TABLE IF EXISTS ONLY public.positions DROP CONSTRAINT IF EXISTS positions_name_key;
ALTER TABLE IF EXISTS ONLY public.organize DROP CONSTRAINT IF EXISTS organize_pkey;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_pkey;
ALTER TABLE IF EXISTS ONLY public.devisions DROP CONSTRAINT IF EXISTS devisions_pkey;
ALTER TABLE IF EXISTS ONLY public.comments DROP CONSTRAINT IF EXISTS comments_pkey;
ALTER TABLE IF EXISTS ONLY public.alembic_version DROP CONSTRAINT IF EXISTS alembic_version_pkc;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.documents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.comments ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.workingcalendar;
DROP TABLE IF EXISTS public.workers;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.test;
DROP TABLE IF EXISTS public.positions;
DROP TABLE IF EXISTS public.organize;
DROP SEQUENCE IF EXISTS public.documents_id_seq;
DROP TABLE IF EXISTS public.documents;
DROP TABLE IF EXISTS public.devisions;
DROP SEQUENCE IF EXISTS public.comments_id_seq;
DROP TABLE IF EXISTS public.comments;
DROP TABLE IF EXISTS public.alembic_version;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    document_id integer NOT NULL,
    text character varying NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_updated timestamp without time zone NOT NULL,
    author_id integer NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: devisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devisions (
    id integer NOT NULL,
    name character varying(255),
    organize_id integer
);


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id integer NOT NULL,
    title character varying NOT NULL,
    date_created timestamp without time zone NOT NULL,
    date_updated timestamp without time zone NOT NULL,
    category character varying NOT NULL,
    has_comments boolean NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: organize; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organize (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: positions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positions (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test (
    id integer NOT NULL,
    number character varying(255)
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying NOT NULL,
    password character varying NOT NULL,
    "position" character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workers (
    id integer NOT NULL,
    name character varying(255),
    surname character varying(255),
    middle_name character varying(255),
    devision_id integer,
    position_id integer,
    phone_number character varying(255),
    cabinet character varying(255),
    email character varying(255)
);


--
-- Name: workingcalendar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workingcalendar (
    id integer NOT NULL,
    exceptiondate date NOT NULL,
    isworkingday boolean NOT NULL
);


--
-- Name: TABLE workingcalendar; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.workingcalendar IS 'Список дней исключений в производственном календаре';


--
-- Name: COLUMN workingcalendar.exceptiondate; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.workingcalendar.exceptiondate IS 'День-исключение';


--
-- Name: COLUMN workingcalendar.isworkingday; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.workingcalendar.isworkingday IS '0 - будний день, но законодательно принят выходным; 1 - сб или вс, но является рабочим';


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
8d87b654254e
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.comments (id, document_id, text, date_created, date_updated, author_id) FROM stdin;
\.


--
-- Data for Name: devisions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.devisions (id, name, organize_id) FROM stdin;
1	Административный департамент	1
2	Договорной отдел	1
3	Общий отдел	1
4	Отдел закупок	1
5	Отдел протокольного сопровождения	1
6	Управление административно-хозяйственной деятельности	1
7	Отдел ИТ	1
8	Управление административно-хозяйственной деятельности	1
9	Управление безопасности	1
10	Управление по обеспечению безопасности	1
11	Академия Умные дороги	2
12	Отдел сетевых программ	2
13	Проектно-аналитический отдел	2
14	Учебно-организационный отдел	2
15	Департамент коммуникаций	4
16	Управление по PR-проектам	4
17	Отдел по организации и сопровождению мероприятий	4
18	Отдел по работе с корпорациями	4
19	Управление Пресс-службы	4
20	Отдел по работе со СМИ	4
21	Отдел цифровых коммуникаций	4
22	Управление Пресс-службы	4
23	Департамент маркетинга и партнерских отношений	5
24	Управление маркетинга	5
25	Лицензионный отдел	5
26	Управление маркетинга	5
27	Управление по развитию бизнеса	5
28	Отдел по  привлечению новых клиентов	5
29	Отдел по организации мероприятий	5
30	Управление по развитию партнерских отношений	5
31	Аналитический отдел	9
32	Отдел проектного управления	9
33	Управление бухгалтерского и налогового учета	11
34	Управление казначейства	11
35	Операционный отдел	11
36	Финансово-экономический департамент	11
37	Финансово-экономическое управление	11
38	Управление нормативного обеспечения и договорной работы	12
39	Юридический департамент	12
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.documents (id, title, date_created, date_updated, category, has_comments) FROM stdin;
\.


--
-- Data for Name: organize; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organize (id, name) FROM stdin;
1	Административный департамент
2	Академия Умные дороги
3	Аппарат управления
4	Департамент коммуникаций
5	Департамент маркетинга и партнерских отношений
6	Департамент по организации корпоративов
7	Департамент по работе с персоналом
8	Департамент по работе с промышленностью
9	Департамент стратегии и планирования
10	Управление Финансового планирования и контроля
11	Финансово-экономический департамент
12	Юридический департамент
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.positions (id, name) FROM stdin;
1	Административный директор-руководитель аппарата
2	Руководитель контрольно-ревизионного направления
3	Начальник отдела
4	Старший специалист
5	Руководитель проекта
6	Специалист
7	Менеджер проектов
8	Ведущий специалист
9	Водитель
10	Курьер
11	Начальник управления
12	Руководитель проектов
13	Специалист по складской работе
14	Руководитель направления
15	Директор Академии
16	Заместитель директора Академии по практической подготовке
17	Главный специалист
18	Ведущий специалист по договорной работе
19	Генеральный директор
20	Заместитель генерального директора по внедрению стандартов
21	Заместитель генерального директора по исследованиям и разработкам
22	Заместитель генерального директора по коммуникациям
23	Заместитель генерального директора по маркетингу и партнерским отношениям
24	Заместитель генерального директора по организации корпоративов
25	Заместитель генерального директора по подготовке кадров
26	Первый заместитель генерального директора
27	Помощник генерального директора
28	Советник генерального директора по стратегическому развитию
29	Советник генерального директора по оперативному планированию
30	Заместитель директора департамента
31	Специалист технического сопровождения
32	Руководитель управления
33	Руководитель проекта по разработке дизайна
34	Руководитель проекта по рекламе
35	Директор департамента
36	Специалист по охране труда
37	Финансовый контролер
38	Бухгалтер
39	Бухгалтер по расчету заработной платы
40	Ведущий бухгалтер
41	Начальник управления - Заместитель главного бухгалтера
42	Старший бухгалтер
43	Специалист казначейства
44	Руководитель департамента - Главный бухгалтер
45	Начальник финансово - экономического отдела
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.test (id, number) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, password, "position") FROM stdin;
1	string	$2b$12$Vv72QVc6Teg.k5Yn.hJaLeVgAwViLY.JWSSMCBY1AS8JQK4qIjnui	\N
2	string1	$2b$12$158Dx/v0.BmK1PsA7rbLqOn7yXRWdjMfnT1FSLfkVX4Kf.jd1kwyq	\N
3	Админ2	$2b$12$.E2DRIT0Y8cFAqwQ4PxQPOGG.2db9yPo5KHLkdFTFHvS54rIBIOGa	Администратор
\.


--
-- Data for Name: workers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.workers (id, name, surname, middle_name, devision_id, position_id, phone_number, cabinet, email) FROM stdin;
1	Белоусов	Семен	Агафонович	1	1	+7 (179) 370-26-88	402А	белоусов@гкдр.ру
2	Матвеев	Вадим	Юрьевич	1	2	+7 (711) 977-16-52	402А	матвеев@гкдр.ру
3	Ермакова	Юнона	Руслановна	2	3	+7 (210) 088-64-36	482	ермакова@гкдр.ру
4	Евсеева	Генриетта	Дмитриевна	2	4	+7 (904) 027-35-92	482	евсеева@гкдр.ру
5	Шарапова	Дария	Андреевна	2	4	+7 (212) 625-28-08	482	шарапова@гкдр.ру
6	Кузьмина	Галина	Максовна	3	3	+7 (370) 519-03-10	479	кузьмина@гкдр.ру
7	Гурьева	Янина	Тимофеевна	3	5	+7 (401) 189-86-51	479	гурьева@гкдр.ру
8	Большакова	Снежана	Тарасовна	3	6	+7 (223) 503-67-44	479	большакова@гкдр.ру
9	Миронова	Диша	Митрофановна	3	7	+7 (084) 252-77-53	479	миронова@гкдр.ру
10	Жданова	Виоланта	Иосифовна	3	4	+7 (900) 353-41-72	479	жданова@гкдр.ру
11	Колесников	Анатолий	Владленович	4	3	+7 (438) 363-52-14	482	колесников@гкдр.ру
12	Мухин	Флор	Иванович	4	4	+7 (487) 123-91-17	482	мухин@гкдр.ру
13	Воронова	Устинья	Митрофановна	5	7	+7 (708) 393-49-39	483	воронова@гкдр.ру
14	Ковалёва	Муза	Тарасовна	5	3	+7 (624) 457-34-25	483	ковалёва@гкдр.ру
15	Крылов	Флор	Максович	7	3	+7 (902) 340-55-48	483	крылов@гкдр.ру
16	Зимин	Илья	Серапионович	7	4	+7 (565) 435-79-80	483	зимин@гкдр.ру
17	Зайцев	Парамон	Феликсович	8	8	+7 (454) 252-05-25	525	зайцев@гкдр.ру
18	Маслов	Модест	Дамирович	8	9	+7 (664) 602-03-71	525	маслов@гкдр.ру
19	Исаков	Велорий	Витальевич	8	9	+7 (098) 359-34-95	525	исаков@гкдр.ру
20	Шашков	Донат	Владленович	8	9	+7 (051) 523-43-73	525	шашков@гкдр.ру
21	Тарасов	Эрнест	Якунович	8	10	+7 (131) 790-43-24	525	тарасов@гкдр.ру
22	Зимин	Лев	Евсеевич	8	11	+7 (609) 728-78-87	525	зимин@гкдр.ру
23	Суханов	Эрнест	Петрович	8	12	+7 (342) 350-52-75	525	суханов@гкдр.ру
24	Харитонов	Любомир	Андреевич	8	6	+7 (933) 010-23-01	525	харитонов@гкдр.ру
25	Евдокимов	Павел	Пётрович	8	13	+7 (676) 507-65-30	525	евдокимов@гкдр.ру
26	Кулагин	Аввакум	Альбертович	9	11	+7 (091) 411-45-67	489	кулагин@гкдр.ру
27	Рогов	Май	Филатович	9	6	+7 (046) 142-05-62	489	рогов@гкдр.ру
28	Фролов	Мартин	Константинович	10	11	+7 (604) 952-64-10	527	фролов@гкдр.ру
29	Копылов	Власий	Валентинович	10	14	+7 (710) 970-74-65	527	копылов@гкдр.ру
30	Воронцов	Мстислав	Лаврентьевич	10	14	+7 (154) 776-83-19	527	воронцов@гкдр.ру
31	Стрелков	Аркадий	Никитевич	10	14	+7 (938) 736-81-71	527	стрелков@гкдр.ру
32	Кононов	Август	Германнович	10	14	+7 (812) 849-39-84	527	кононов@гкдр.ру
33	Горбачёв	Глеб	Мэлсович	10	14	+7 (626) 861-82-67	527	горбачёв@гкдр.ру
34	Беляев	Тарас	Владленович	10	14	+7 (909) 176-65-42	527	беляев@гкдр.ру
35	Селезнёва	Мэри	Фроловна	11	15	+7 (956) 710-49-22	477	селезнёва@гкдр.ру
36	Филиппова	Аза	Николаевна	11	16	+7 (163) 312-43-14	477	филиппова@гкдр.ру
37	Галкина	Эрика	Лукьяновна	12	8	+7 (567) 060-46-69	404	галкина@гкдр.ру
38	Лихачёва	Динара	Георгьевна	12	3	+7 (624) 064-06-24	404	лихачёва@гкдр.ру
39	Лобанова	Дебора	Владимировна	12	6	+7 (318) 827-54-60	404	лобанова@гкдр.ру
40	Коновалова	Карина	Анатольевна	12	6	+7 (800) 239-60-38	404	коновалова@гкдр.ру
41	Дьячков	Гордей	Юрьевич	13	8	+7 (462) 807-37-94	415	дьячков@гкдр.ру
42	Дементьев	Людвиг	Дмитриевич	13	17	+7 (232) 050-93-59	415	дементьев@гкдр.ру
43	Тетерин	Терентий	Артёмович	13	3	+7 (855) 470-76-70	415	тетерин@гкдр.ру
44	Шарапов	Нинель	Артемович	13	6	+7 (064) 865-03-57	415	шарапов@гкдр.ру
45	Быкова	Роксалана	Евгеньевна	14	18	+7 (640) 077-77-65	479	быкова@гкдр.ру
46	Карпова	Берта	Васильевна	14	3	+7 (424) 549-00-75	479	карпова@гкдр.ру
47	Князева	Эрида	Михайловна	14	6	+7 (476) 265-08-34	479	князева@гкдр.ру
48	Боброва	Анэля	Григорьевна	14	6	+7 (197) 497-66-92	479	боброва@гкдр.ру
49	Ефремов	Вальтер	Платонович	\N	19	+7 (210) 001-40-01	Ресепшн	ефремов@гкдр.ру
50	Смирнов	Аввакум	Проклович	\N	20	+7 (234) 327-27-37	406А	смирнов@гкдр.ру
51	Сидорова	Богдана	Степановна	\N	21	+7 (333) 007-73-86	406А	сидорова@гкдр.ру
52	Медведева	Анфиса	Куприяновна	\N	22	+7 (352) 984-89-47	406А	медведева@гкдр.ру
53	Соколова	Злата	Донатовна	\N	23	+7 (263) 295-98-84	406А	соколова@гкдр.ру
54	Максимова	Антонина	Наумовна	\N	24	+7 (059) 049-11-97	406А	максимова@гкдр.ру
55	Емельянова	Лали	Адольфовна	\N	25	+7 (643) 148-48-83	406А	емельянова@гкдр.ру
56	Лобанов	Андрей	Владленович	\N	26	+7 (749) 358-03-33	406А	лобанов@гкдр.ру
57	Бирюков	Валерий	Леонидович	\N	27	+7 (882) 562-21-24	Ресепшн	бирюков@гкдр.ру
58	Рябов	Влас	Богданович	\N	28	+7 (673) 157-65-87	406А	рябов@гкдр.ру
59	Мельников	Модест	Тихонович	\N	29	+7 (480) 955-36-17	406А	мельников@гкдр.ру
60	Никифорова	Любава	Васильевна	15	30	+7 (890) 112-51-51	406	никифорова@гкдр.ру
61	Денисова	Веселина	Демьяновна	17	14	+7 (606) 810-72-96	489А	денисова@гкдр.ру
62	Лобанова	Георгина	Евсеевна	18	14	+7 (760) 683-71-57	406	лобанова@гкдр.ру
63	Калашникова	Маргарита	Адольфовна	20	3	+7 (567) 984-10-59	404	калашникова@гкдр.ру
64	Корнилов	Давид	Михайлович	20	14	+7 (535) 508-09-63	404	корнилов@гкдр.ру
65	Мишина	Сабрина	Всеволодовна	21	14	+7 (123) 099-67-67	489А	мишина@гкдр.ру
66	Давыдова	Крис	Алексеевна	21	6	+7 (086) 732-87-28	489А	давыдова@гкдр.ру
67	Тетерина	Сабрина	Евсеевна	21	31	+7 (305) 078-20-93	489А	тетерина@гкдр.ру
68	Мишина	Зоряна	Семёновна	22	32	+7 (941) 758-60-21	489А	мишина@гкдр.ру
69	Филиппова	Ирэн	Рудольфовна	23	30	+7 (791) 893-63-24	406	филиппова@гкдр.ру
70	Сорокина	Виктория	Альбертовна	25	14	+7 (256) 543-71-97	489А	сорокина@гкдр.ру
71	Фролова	Эрида	Юлиановна	26	33	+7 (382) 787-58-02	489А	фролова@гкдр.ру
72	Дементьева	Дарьяна	Пантелеймоновна	28	14	+7 (772) 653-55-16	410Б	дементьева@гкдр.ру
73	Денисова	Эдилия	Святославовна	28	34	+7 (661) 640-32-15	410Б	денисова@гкдр.ру
74	Борисова	Варвара	Богуславовна	28	12	+7 (625) 163-29-48	410Б	борисова@гкдр.ру
75	Сафонова	Алина	Михайловна	29	14	+7 (949) 247-53-70	402Б	сафонова@гкдр.ру
76	Моисеев	Павел	Витальевич	30	14	+7 (395) 842-89-60	411	моисеев@гкдр.ру
77	Денисова	Альжбета	Валерьевна	30	14	+7 (405) 652-62-30	411	денисова@гкдр.ру
78	Калинина	Лариса	Улебовна	\N	7	+7 (459) 094-61-74	402Б	калинина@гкдр.ру
79	Громова	Роксалана	Егоровна	\N	12	+7 (790) 385-88-79	402Б	громова@гкдр.ру
80	Авдеева	Лика	Лаврентьевна	\N	6	+7 (905) 571-85-23	402Б	авдеева@гкдр.ру
81	Фадеева	Юлиана	Святославовна	\N	17	+7 (325) 978-22-94	401	фадеева@гкдр.ру
82	Королёва	Диана	Созоновна	\N	35	+7 (198) 515-56-04	401	королёва@гкдр.ру
83	Михеева	Георгина	Борисовна	\N	6	+7 (951) 095-81-15	401	михеева@гкдр.ру
84	Михеева	Георгина	Борисовна	\N	36	+7 (818) 456-17-32	401	михеева@гкдр.ру
85	Савельева	Диша	Данииловна	\N	35	+7 (145) 189-60-52	410Б	савельева@гкдр.ру
86	Щербакова	Лира	Витальевна	\N	14	+7 (066) 097-49-63	410Б	щербакова@гкдр.ру
87	Калинина	Радмила	Пётровна	\N	12	+7 (041) 340-67-42	410Б	калинина@гкдр.ру
88	Харитонова	Видана	Николаевна	\N	12	+7 (686) 601-90-65	410Б	харитонова@гкдр.ру
89	Рожкова	Сильвия	Мартыновна	\N	12	+7 (141) 793-69-11	410Б	рожкова@гкдр.ру
90	Нестерова	Данна	Игнатьевна	31	5	+7 (383) 545-59-27	487	нестерова@гкдр.ру
91	Корнилова	Ангелина	Алексеевна	31	5	+7 (195) 929-02-05	487	корнилова@гкдр.ру
92	Аксёнова	Мирра	Григорьевна	31	6	+7 (614) 995-85-89	487	аксёнова@гкдр.ру
93	Фадеева	Влада	Семёновна	32	5	+7 (060) 326-14-90	421	фадеева@гкдр.ру
94	Кононова	Майя	Максовна	32	5	+7 (673) 181-26-22	421	кононова@гкдр.ру
95	Некрасова	Лилу	Константиновна	\N	17	+7 (885) 634-33-04	401	некрасова@гкдр.ру
96	Баранова	Диана	Леонидовна	\N	11	+7 (174) 853-49-83	401	баранова@гкдр.ру
97	Гришина	Азалия	Агафоновна	\N	6	+7 (017) 495-66-09	401	гришина@гкдр.ру
98	Архипова	Наталья	Юрьевна	\N	37	+7 (325) 282-73-59	401	архипова@гкдр.ру
99	Рожкова	Мила	Кирилловна	33	38	+7 (644) 679-57-32	488	рожкова@гкдр.ру
100	Богданова	Эллада	Георгиевна	33	38	+7 (366) 341-61-81	488	богданова@гкдр.ру
101	Яковлева	Аделия	Геласьевна	33	38	+7 (990) 358-79-57	488	яковлева@гкдр.ру
102	Соловьёва	Габриэлла	Созоновна	33	38	+7 (298) 353-76-77	488	соловьёва@гкдр.ру
103	Щукина	Розалина	Витальевна	33	39	+7 (041) 888-17-81	488	щукина@гкдр.ру
104	Никитина	Азалия	Алексеевна	33	40	+7 (379) 582-61-58	488	никитина@гкдр.ру
105	Дроздова	Береслава	Максимовна	33	41	+7 (812) 542-65-16	488	дроздова@гкдр.ру
106	Галкина	Божена	Филипповна	33	42	+7 (120) 462-91-94	488	галкина@гкдр.ру
107	Казакова	Земфира	Федосеевна	33	42	+7 (312) 173-95-22	488	казакова@гкдр.ру
108	Доронина	Эдуарда	Дмитрьевна	35	43	+7 (398) 556-52-52	421	доронина@гкдр.ру
109	Гурьева	Фанни	Андреевна	35	43	+7 (192) 794-90-18	421	гурьева@гкдр.ру
110	Кононова	Нонна	Анатольевна	35	43	+7 (049) 956-85-86	421	кононова@гкдр.ру
111	Блинова	Милослава	Андреевна	36	3	+7 (134) 370-87-86	524	блинова@гкдр.ру
112	Щукина	Владислава	Альбертовна	36	44	+7 (441) 380-03-70	524	щукина@гкдр.ру
113	Громова	Архелия	Святославовна	36	43	+7 (834) 538-57-98	524	громова@гкдр.ру
114	Соколова	Фанни	Григорьевна	36	43	+7 (787) 780-96-88	524	соколова@гкдр.ру
115	Веселова	Регина	Натановна	37	45	+7 (695) 489-78-71	523	веселова@гкдр.ру
116	Субботина	Инга	Васильевна	37	6	+7 (955) 709-44-45	523	субботина@гкдр.ру
117	Исаков	Аполлон	Ефимович	38	11	+7 (952) 550-14-44	421	исаков@гкдр.ру
118	Галкин	Никифор	Евсеевич	39	35	+7 (270) 482-96-24	524	галкин@гкдр.ру
119	Харитонова	Ангелина	Мэлоровна	39	30	+7 (800) 847-84-22	524	харитонова@гкдр.ру
\.


--
-- Data for Name: workingcalendar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.workingcalendar (id, exceptiondate, isworkingday) FROM stdin;
1	2024-01-01	f
2	2024-01-02	f
3	2024-01-03	f
4	2024-01-04	f
5	2024-01-05	f
6	2024-01-08	f
7	2024-02-23	f
8	2024-03-08	f
9	2024-04-27	t
10	2024-04-29	f
11	2024-04-30	f
12	2024-05-01	f
13	2024-05-09	f
14	2024-05-10	f
15	2024-06-12	f
16	2024-11-02	t
17	2024-11-04	f
18	2024-12-28	t
19	2024-12-30	f
20	2024-12-31	f
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: devisions devisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devisions
    ADD CONSTRAINT devisions_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: organize organize_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organize
    ADD CONSTRAINT organize_pkey PRIMARY KEY (id);


--
-- Name: positions positions_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_name_key UNIQUE (name);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workers workers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);


--
-- Name: workingcalendar workingcalendar_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workingcalendar
    ADD CONSTRAINT workingcalendar_pk PRIMARY KEY (id);


--
-- Name: comments comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: comments comments_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: devisions devisions_organize_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devisions
    ADD CONSTRAINT devisions_organize_id_fkey FOREIGN KEY (organize_id) REFERENCES public.organize(id);


--
-- Name: workers workers_devision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_devision_id_fkey FOREIGN KEY (devision_id) REFERENCES public.devisions(id);


--
-- Name: workers workers_position_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.positions(id);


--
-- PostgreSQL database dump complete
--

