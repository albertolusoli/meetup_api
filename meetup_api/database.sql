--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id bigint NOT NULL,
    event_id text,
    group_id bigint,
    name text,
    description text,
    number_of_participants integer,
    participants_names text[] DEFAULT '{}'::text[],
    member_bios text[] DEFAULT '{}'::text[],
    venue text,
    urlname text,
    venue_address text,
    link text,
    event_date date,
    venue_city text,
    venue_state text,
    venue_country text,
    event_time time without time zone,
    lat double precision,
    lon double precision,
    venue_name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: group_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE group_members (
    id bigint NOT NULL,
    member_id bigint,
    group_id bigint,
    name text,
    bio text,
    city text,
    country text,
    gender text,
    birthday date,
    link text,
    meetup_profile_link text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE group_members OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_members_id_seq OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_members_id_seq OWNED BY group_members.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups (
    id bigint NOT NULL,
    group_id bigint,
    name text,
    urlname text,
    meta_category_id bigint,
    meta_category_category_ids bigint[] DEFAULT '{}'::bigint[],
    category_name text,
    category_id bigint,
    city text,
    organizer_id bigint,
    organizer_name text,
    date_of_creation date,
    description text,
    link text,
    members integer,
    who text,
    lat double precision,
    meta_category_name text,
    lon double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE groups OWNER TO postgres;

--
-- Name: groups_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups_history (
    id bigint NOT NULL,
    group_id bigint,
    name text,
    urlname text,
    meta_category_id bigint,
    meta_category_category_ids bigint[] DEFAULT '{}'::bigint[],
    category_name text,
    category_id bigint,
    city text,
    organizer_id bigint,
    organizer_name text,
    date_of_creation date,
    description text,
    link text,
    members integer,
    who text,
    lat double precision,
    meta_category_name text,
    lon double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE groups_history OWNER TO postgres;

--
-- Name: groups_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_history_id_seq OWNER TO postgres;

--
-- Name: groups_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_history_id_seq OWNED BY groups_history.id;


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: past_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE past_events (
    id bigint NOT NULL,
    event_id text,
    group_id bigint,
    urlname text,
    name text,
    description text,
    number_of_participants integer,
    participants_names text[] DEFAULT '{}'::text[],
    member_bios text[] DEFAULT '{}'::text[],
    venue text,
    address text,
    link text,
    event_date date,
    event_time time without time zone,
    venue_lat double precision,
    venue_lon double precision,
    venue_address text,
    venue_city text,
    venue_state text,
    venue_country text,
    venue_name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE past_events OWNER TO postgres;

--
-- Name: past_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE past_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE past_events_id_seq OWNER TO postgres;

--
-- Name: past_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE past_events_id_seq OWNED BY past_events.id;


--
-- Name: rsvps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rsvps (
    id bigint NOT NULL,
    member_id bigint NOT NULL,
    member_ids bigint[] DEFAULT '{}'::bigint[],
    group_id bigint,
    group_urlname text,
    event_id text NOT NULL,
    link text,
    response text,
    event_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE rsvps OWNER TO postgres;

--
-- Name: rsvps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rsvps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rsvps_id_seq OWNER TO postgres;

--
-- Name: rsvps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rsvps_id_seq OWNED BY rsvps.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    id bigint NOT NULL,
    topic_id bigint,
    lang text,
    name text,
    description text,
    member_count integer,
    group_count integer,
    urlkey text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: group_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members ALTER COLUMN id SET DEFAULT nextval('group_members_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: groups_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups_history ALTER COLUMN id SET DEFAULT nextval('groups_history_id_seq'::regclass);


--
-- Name: past_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY past_events ALTER COLUMN id SET DEFAULT nextval('past_events_id_seq'::regclass);


--
-- Name: rsvps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps ALTER COLUMN id SET DEFAULT nextval('rsvps_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2018-01-29 20:53:41.024053	2018-01-29 20:53:41.024053
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, event_id, group_id, name, description, number_of_participants, participants_names, member_bios, venue, urlname, venue_address, link, event_date, venue_city, venue_state, venue_country, event_time, lat, lon, venue_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY group_members (id, member_id, group_id, name, bio, city, country, gender, birthday, link, meetup_profile_link, created_at, updated_at) FROM stdin;
1	7521073	18553122	Anna	\N	Vancouver	ca	\N	\N	\N	http://www.meetup.com/members/7521073	2018-01-29 12:59:18	2018-01-29 13:02:36
2	129651982	18553122	Annie Xu	\N	Vancouver	ca	\N	\N	\N	http://www.meetup.com/members/129651982	2018-01-29 12:59:18	2018-01-29 13:02:36
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (id, group_id, name, urlname, meta_category_id, meta_category_category_ids, category_name, category_id, city, organizer_id, organizer_name, date_of_creation, description, link, members, who, lat, meta_category_name, lon, created_at, updated_at) FROM stdin;
1	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:57:05	\N
2	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:57:05	\N
13	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:17	\N
3	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:57:05	\N
14	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:17	\N
15	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:17	\N
\.


--
-- Data for Name: groups_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups_history (id, group_id, name, urlname, meta_category_id, meta_category_category_ids, category_name, category_id, city, organizer_id, organizer_name, date_of_creation, description, link, members, who, lat, meta_category_name, lon, created_at, updated_at) FROM stdin;
1	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:58:55	\N
2	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:58:55	\N
3	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:58:55	\N
4	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:59:03	\N
5	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:59:03	\N
6	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:59:03	\N
7	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:17	\N
8	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:17	\N
9	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:17	\N
10	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:55	\N
11	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:55	\N
12	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:55	\N
23	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:16:48	\N
13	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:02:01	\N
14	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:02:01	\N
15	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:02:01	\N
16	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:02:36	\N
17	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:02:36	\N
30	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 14:17:24	\N
18	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:02:36	\N
19	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:16:00	\N
20	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:16:00	\N
21	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:16:00	\N
22	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:16:48	\N
24	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:16:48	\N
25	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 14:11:57	\N
26	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 14:11:57	\N
27	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 14:11:57	\N
28	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 14:17:24	\N
29	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 14:17:24	\N
\.


--
-- Data for Name: past_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY past_events (id, event_id, group_id, urlname, name, description, number_of_participants, participants_names, member_bios, venue, address, link, event_date, event_time, venue_lat, venue_lon, venue_address, venue_city, venue_state, venue_country, venue_name, created_at, updated_at) FROM stdin;
2	246910988	18564632	SocialInnovation	 Recruiting Strategies & Creating A Good Onboarding Process For Your First Hires	<p>• What we'll do<br/>Looking to on-board your first hire or bring on a contractor? What paperwork do you need to have in place? How do you ensure you set a strong first impression? Come hear answers to these questions and more in an in-depth workshop by HR experts at Amui.co</p> <p>Who is this for:</p> <p>Founders of companies that are bringing on their first employees</p> <p>HR specialist looking to set up a strong onboarding process</p> <p>You will Learn About:</p> <p>Hiring vs. Contracting.</p> <p>Strategies around recruiting, interviewing, and compensation.</p> <p>Onboarding process.</p> <p>Agenda:</p> <p>5:30PM – Registration &amp; Networking</p> <p>5:45PM – Presentation begins</p> <p>6:45PM – Q&amp;A</p> <p>7:00PM – Networking</p> <p>7:30PM – Wrap-up</p> <p>About Your Speaker:</p> <p>Allison Guld</p> <p>Allison’s strategic, operational and management experience in recruitment and HR was honed in high tech organizations such as Blast Radius, Ernst &amp; Young, and MDA. No stranger to entrepreneurial adventures, Allison’s first company paid for her university degree. She went on to be a top performer as a 100% commission high tech recruiter which segued into her own recruitment agency in the late 1990’s. She spent the last 10 years working in-house for high growth companies in senior human resources roles until 2015 when she co-founded amui with partner, Stephanie Lyster.</p> <p>Stephanie Lyster</p> <p>Stephanie has experience identifying and implementing strategic HR solutions including workforce planning, performance management, recruitment and change management. Her background in building people infrastructure for high growth companies cemented her belief that HR should not be a cost function but a strategic partner for performance, cultural influence and retention. After establishing herself in corporate HR roles, Stephanie pursued her entrepreneurial interests as a consultant starting 2009 until she co-founded amui in 2015 with partner, Allison Guld.</p> <p>Amui is a company that is changing the way that organizations interact with HR by providing on-demand access to HR knowledge so everyone makes better decisions. Allison and Stephanie are frequent speakers at industry events providing informative workshops and insights into the innovation potential of HR technology to transform business.</p> <p>• What to bring</p> <p>• Important to know<br/>Don't forget to RSVP on Eventbrite to save your spot. Seats are limited. <a href="https://www.eventbrite.com/e/recruiting-strategies-and-creating-a-good-on-boarding-process-for-your-first-hires-tickets-41982166791?aff=Soc" class="linkified">https://www.eventbrite.com/e/recruiting-strategies-and-creating-a-good-on-boarding-process-for-your-first-hires-tickets-41982166791?aff=Soc</a></p> 	1	{}	{}	\N	\N	https://www.meetup.com/SocialInnovation/events/246910988/	2018-02-06	17:30:00	49.28106689453125	-123.104782104492188	90-425 Carrall St	\N	\N	\N	Spring	2018-01-29 13:01:45	2018-01-29 13:19:48
1	246908538	18564632	SocialInnovation	Spring Breakfast Talks: Scale Your Online Business	<p>• What we'll do<br/>Do you sell products on Amazon or would like to start?</p> <p>Join us for a breakfast Q&amp;A session on things you need to know to sell successfully on Amazon.</p> <p>Topics for discussion:</p> <p>Brief explanation of the online avenues for consumer packaged goods<br/>Understand how to assess the cost of selling online, so you can price your product competitively and profitably<br/>Key aspects of well performing product pages<br/>Operational proficiency as it applies to the flow of orders and the expectations of the industry<br/>Supply chain management as it applies to having appropriate inventory levels to grow your business.<br/>Interacting with Amazon, when it’s near impossible to talk to anyone, or find an email contact that can properly answer your question<br/>Handling returns and packing goods to avoid damages</p> <p>Subject Matter Expert</p> <p>Brad Glessing, Glessing Enterprise Inc.</p> <p>Brad has over 35 years of experience in senior management positions with mid-sized consumer packaged goods companies, the most recent position was CEO of AZ Home &amp; Gifts. Brad realized the opportunity in the online channel and with his team became a top 20 vendor at Amazon (home division) and achieved Platinum Vendor status. Currently, Brad and his colleagues help companies grow their online business with a focus on operational proficiency and supply chain optimization. You can contact Brad at [masked]</p> <p>RSVP on Eventbrite if you haven't! Space is limited.</p> <p>• What to bring</p> <p><br/>• Important to know<br/><a href="https://www.eventbrite.com/e/spring-breakfast-talks-scale-your-online-business-tickets-41843181081?aff=soci" class="linkified">https://www.eventbrite.com/e/spring-breakfast-talks-scale-your-online-business-tickets-41843181081?aff=soci</a></p> 	4	{}	{}	\N	\N	https://www.meetup.com/SocialInnovation/events/246908538/	2018-01-30	08:00:00	49.2821464538574219	-123.104515075683594	319 Carrall Street 	\N	\N	\N	East Van Roasters	2018-01-29 13:01:45	2018-01-29 13:19:48
\.


--
-- Data for Name: rsvps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rsvps (id, member_id, member_ids, group_id, group_urlname, event_id, link, response, event_date, created_at, updated_at) FROM stdin;
1	243099223	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
2	236885945	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
3	213244190	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
4	225543997	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
9	243099223	{}	\N	SocialInnovation	246910988	\N	yes	\N	2018-01-29 13:16:01	2018-01-29 13:16:48
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20180127211634
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY topics (id, topic_id, lang, name, description, member_count, group_count, urlkey, created_at, updated_at) FROM stdin;
1	19882	en_US	Entrepreneurship	Meet local entrepreneurs, discuss strategies and share success stories with them!	15722669	32474	entrepreneurship	\N	\N
2	26643	en_US	Social Entrepreneurship	Find out what's happening in Social Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	944814	2293	social-entrepreneurship	\N	\N
3	21680	en_US	Entrepreneurship Training	Find out what's happening in Entrepreneurship Training Meetup groups around the world and start meeting up with the ones near you.	128908	381	entrepreneurship-training	\N	\N
4	134056	en_US	Entrepreneurship and Self Empowerment	Find out what's happening in Entrepreneurship and Self Empowerment Meetup groups around the world and start meeting up with the ones near you.	61773	200	entrepreneurship-and-self-empowerment	\N	\N
5	148105	en_US	Marketing and Entrepreneurship	Find out what's happening in Marketing and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	79202	162	marketing-and-entrepreneurship	\N	\N
6	757162	en_US	Veterans Entrepreneurship	Find out what's happening in Veterans Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	1978	17	veterans-entrepreneurship	\N	\N
7	608872	en_US	Entrepreneurship in Jerusalem	Find out what's happening in Entrepreneurship in Jerusalem Meetup groups around the world and start meeting up with the ones near you.	14386	12	entrepreneurship-in-jerusalem	\N	\N
8	99253	en_US	Holistic Entrepreneurship	Find out what's happening in Holistic Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	686	7	holistic-entrepreneurship	\N	\N
9	734002	en_US	applied entrepreneurship	Find out what's happening in applied entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	2139	6	applied-entrepreneurship	\N	\N
10	711032	en_US	Immigrant Entrepreneurship	Find out what's happening in Immigrant Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	246	2	immigrant-entrepreneurship	\N	\N
11	131343	en_US	Intellectual Entrepreneurship	Find out what's happening in Intellectual Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	44	1	intellectual-entrepreneurship	\N	\N
12	74017	en_US	Entrepreneurship: Innovative Ideas for Your Child	Find out what's happening in Entrepreneurship: Innovative Ideas for Your Child Meetup groups around the world and start meeting up with the ones near you.	0	0	entrepreneurship-innovative-ideas-for-your-child	\N	\N
13	102177	en_US	High Impact Entrepreneurship	Find out what's happening in High Impact Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	high-impact-entrepreneurship	\N	\N
14	136076	en_US	From Corporate to Entrepreneurship	Find out what's happening in From Corporate to Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	from-corporate-to-entrepreneurship	\N	\N
15	144132	it	happiness through entrepreneurship	Find out what's happening in happiness through entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	happiness-through-entrepreneurship	\N	\N
16	162876	en_US	Entrepreneurship in the 21st Century	Find out what's happening in Entrepreneurship in the 21st Century Meetup groups around the world and start meeting up with the ones near you.	0	0	entrepreneurship-in-the-21st-century	\N	\N
17	315911	en_US	Steps toward Entrepreneurship	Find out what's happening in Steps toward Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	steps-toward-entrepreneurship	\N	\N
18	343911	en_US	Desi Entrepreneurship	Find out what's happening in Desi Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	desi-entrepreneurship	\N	\N
19	398152	en_US	Seattle Entrepreneurship	Find out what's happening in Seattle Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	seattle-entrepreneurship	\N	\N
20	538702	en_US	Science Innovation and Entrepreneurship	Find out what's happening in Science Innovation and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	science-innovation-and-entrepreneurship	\N	\N
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_id_seq', 1, false);


--
-- Name: group_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_members_id_seq', 8, true);


--
-- Name: groups_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_history_id_seq', 30, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_id_seq', 36, true);


--
-- Name: past_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('past_events_id_seq', 16, true);


--
-- Name: rsvps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rsvps_id_seq', 10, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('topics_id_seq', 20, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: group_members group_members_member_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members
    ADD CONSTRAINT group_members_member_id_group_id_key UNIQUE (member_id, group_id);


--
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (id);


--
-- Name: groups_history groups_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups_history
    ADD CONSTRAINT groups_history_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: past_events past_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY past_events
    ADD CONSTRAINT past_events_pkey PRIMARY KEY (id);


--
-- Name: rsvps rsvps_member_id_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps
    ADD CONSTRAINT rsvps_member_id_event_id_key UNIQUE (member_id, event_id);


--
-- Name: rsvps rsvps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps
    ADD CONSTRAINT rsvps_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: index_events_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_events_on_event_id ON events USING btree (event_id);


--
-- Name: index_events_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_events_on_group_id ON events USING btree (group_id);


--
-- Name: index_groups_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_groups_on_group_id ON groups USING btree (group_id);


--
-- Name: index_past_events_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_past_events_on_event_id ON past_events USING btree (event_id);


--
-- Name: index_past_events_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_past_events_on_group_id ON past_events USING btree (group_id);


--
-- Name: index_topics_on_topic_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_topics_on_topic_id ON topics USING btree (topic_id);


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO postgres;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id bigint NOT NULL,
    event_id text,
    group_id bigint,
    name text,
    description text,
    number_of_participants integer,
    participants_names text[] DEFAULT '{}'::text[],
    member_bios text[] DEFAULT '{}'::text[],
    venue text,
    urlname text,
    venue_address text,
    link text,
    event_date date,
    venue_city text,
    venue_state text,
    venue_country text,
    event_time time without time zone,
    lat double precision,
    lon double precision,
    venue_name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: group_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE group_members (
    id bigint NOT NULL,
    member_id bigint,
    group_id bigint,
    name text,
    bio text,
    city text,
    country text,
    gender text,
    birthday date,
    link text,
    meetup_profile_link text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE group_members OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_members_id_seq OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_members_id_seq OWNED BY group_members.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups (
    id bigint NOT NULL,
    group_id bigint,
    name text,
    urlname text,
    meta_category_id bigint,
    meta_category_category_ids bigint[] DEFAULT '{}'::bigint[],
    category_name text,
    category_id bigint,
    city text,
    organizer_id bigint,
    organizer_name text,
    date_of_creation date,
    description text,
    link text,
    members integer,
    who text,
    lat double precision,
    meta_category_name text,
    lon double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE groups OWNER TO postgres;

--
-- Name: groups_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE groups_history (
    id bigint NOT NULL,
    group_id bigint,
    name text,
    urlname text,
    meta_category_id bigint,
    meta_category_category_ids bigint[] DEFAULT '{}'::bigint[],
    category_name text,
    category_id bigint,
    city text,
    organizer_id bigint,
    organizer_name text,
    date_of_creation date,
    description text,
    link text,
    members integer,
    who text,
    lat double precision,
    meta_category_name text,
    lon double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE groups_history OWNER TO postgres;

--
-- Name: groups_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_history_id_seq OWNER TO postgres;

--
-- Name: groups_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_history_id_seq OWNED BY groups_history.id;


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: past_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE past_events (
    id bigint NOT NULL,
    event_id text,
    group_id bigint,
    urlname text,
    name text,
    description text,
    number_of_participants integer,
    participants_names text[] DEFAULT '{}'::text[],
    member_bios text[] DEFAULT '{}'::text[],
    venue text,
    address text,
    link text,
    event_date date,
    event_time time without time zone,
    venue_lat double precision,
    venue_lon double precision,
    venue_address text,
    venue_city text,
    venue_state text,
    venue_country text,
    venue_name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE past_events OWNER TO postgres;

--
-- Name: past_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE past_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE past_events_id_seq OWNER TO postgres;

--
-- Name: past_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE past_events_id_seq OWNED BY past_events.id;


--
-- Name: rsvps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rsvps (
    id bigint NOT NULL,
    member_id bigint NOT NULL,
    member_ids bigint[] DEFAULT '{}'::bigint[],
    group_id bigint,
    group_urlname text,
    event_id text NOT NULL,
    link text,
    response text,
    event_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE rsvps OWNER TO postgres;

--
-- Name: rsvps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rsvps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rsvps_id_seq OWNER TO postgres;

--
-- Name: rsvps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rsvps_id_seq OWNED BY rsvps.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    id bigint NOT NULL,
    topic_id bigint,
    lang text,
    name text,
    description text,
    member_count integer,
    group_count integer,
    urlkey text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: group_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members ALTER COLUMN id SET DEFAULT nextval('group_members_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: groups_history id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups_history ALTER COLUMN id SET DEFAULT nextval('groups_history_id_seq'::regclass);


--
-- Name: past_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY past_events ALTER COLUMN id SET DEFAULT nextval('past_events_id_seq'::regclass);


--
-- Name: rsvps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps ALTER COLUMN id SET DEFAULT nextval('rsvps_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2018-01-29 20:53:41.024053	2018-01-29 20:53:41.024053
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, event_id, group_id, name, description, number_of_participants, participants_names, member_bios, venue, urlname, venue_address, link, event_date, venue_city, venue_state, venue_country, event_time, lat, lon, venue_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY group_members (id, member_id, group_id, name, bio, city, country, gender, birthday, link, meetup_profile_link, created_at, updated_at) FROM stdin;
1	7521073	18553122	Anna	\N	Vancouver	ca	\N	\N	\N	http://www.meetup.com/members/7521073	2018-01-29 12:59:18	2018-01-29 13:02:36
2	129651982	18553122	Annie Xu	\N	Vancouver	ca	\N	\N	\N	http://www.meetup.com/members/129651982	2018-01-29 12:59:18	2018-01-29 13:02:36
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (id, group_id, name, urlname, meta_category_id, meta_category_category_ids, category_name, category_id, city, organizer_id, organizer_name, date_of_creation, description, link, members, who, lat, meta_category_name, lon, created_at, updated_at) FROM stdin;
1	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:57:05	\N
2	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:57:05	\N
13	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:17	\N
3	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:57:05	\N
14	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:17	\N
15	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:17	\N
\.


--
-- Data for Name: groups_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups_history (id, group_id, name, urlname, meta_category_id, meta_category_category_ids, category_name, category_id, city, organizer_id, organizer_name, date_of_creation, description, link, members, who, lat, meta_category_name, lon, created_at, updated_at) FROM stdin;
1	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:58:55	\N
2	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:58:55	\N
3	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:58:55	\N
4	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 12:59:03	\N
5	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 12:59:03	\N
6	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 12:59:03	\N
7	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:17	\N
8	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:17	\N
9	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:17	\N
10	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 12:59:55	\N
11	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 12:59:55	\N
12	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 12:59:55	\N
23	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:16:48	\N
13	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:02:01	\N
14	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:02:01	\N
15	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:02:01	\N
16	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:02:36	\N
17	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:02:36	\N
30	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 14:17:24	\N
18	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:02:36	\N
19	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:16:00	\N
20	26577129	Crypto Crowd	Crypto-Crowd	26577129	\N	Crypto Crowd	26577129	Vancouver	26577129	\N	2017-11-12	<p>This is a non-technical crypto group looking at the big picture of the cryptocurrency landscape. We will analyze coins and tokens together to decide which are best to get. We will also be newby friendly to assist those who need to get themselves set up with crypto. It is a bit of a learning curve but definitely something worth learning before the masses show up.</p>	https://www.meetup.com/Crypto-Crowd/	303	Early Adopters	49.259999999999998	Crypto Crowd	-123.069999999999993	2018-01-29 13:16:00	\N
21	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:16:00	\N
22	18508213	Spiritual Development, Meditation & Mysticism Events In B.C.	SpiRitual-Artistry	18508213	\N	Spiritual Development, Meditation & Mysticism Events In B.C.	18508213	Vancouver	18508213	\N	2015-03-17	<p><span>Spi-Ritual Artistry and Mysticism's name has been updated to Spiritual Development, Meditation and Mysticism Events in BC Canada. It is a spiritual group here to support, teach and host discussions, development classes and healing circles for our community in a safe, compassionate and informative way. Events will vary in topic. Some will be on Spirit Rituals (Spi-ritual), your unique spiritual expression (artistry) and mystical paths and experiences (mysticism). &nbsp;Meditation and spiritual development classes will be held to manage and sharpen your abilities.</span><span>&nbsp;Please see the notes at the conclusion of the description of events for group etiquette. <br> <br><span>This group is partnered with our registered not-for-profit </span>society<span>&nbsp;called The Integration Centre Of the Nexus (ICON). Our meeting place is Commercial Dr. 2910 Commercial Dr, office 7.&nbsp;&nbsp;</span></span><a href="https://www.facebook.com/thenexussociety">https://www.facebook.com/thenexussociety</a><span>. The ICON is a member-funded, non-profit, interspiritual, interfaith and intercultural society.&nbsp;</span><span>&nbsp;We welcome people from different spiritual paths, beliefs, faiths and backgrounds and all-levels of development. This group is for psychics, mediums, readers, intuitives, sensitives, pagans, energy healers etc. and the curious mind.&nbsp; If you are on Facebook, please find us under our new group&nbsp;<a href="https://www.facebook.com/groups/spiritualmystictribe/">https://www.facebook.com/groups/spiritualmystictribe/</a></span></p>\n<p><span>We believe that everyone has a unique spiritual expression that deserves to be expressed and witnessed. Please join us in Expressing, Experiencing, Experimenting and Exploring Life.</span> <br></p>	https://www.meetup.com/SpiRitual-Artistry/	1251	Spiritual Mystics	49.259999999999998	Spiritual Development, Meditation & Mysticism Events In B.C.	-123.069999999999993	2018-01-29 13:16:48	\N
24	3926402	The Vancouver B Movie Factory, Movie Making Dreams Come True	The-Vancouver-B-Movie-Factory	3926402	\N	The Vancouver B Movie Factory, Movie Making Dreams Come True	3926402	Vancouver	3926402	\N	2012-05-23	<p>This is the place where B movies are made and where your movie making dreams can come true. Do you love to write or shoot or act or sing or dance or capture sound or do make up or do hair or create costumes or make music or be a part of creating something from nothing? If you said yes to any of these things then the B Movie Factory family would love to have you. The movies are definitely B movies but the fun is making the movie. Our motto is "If you are not having fun, don't do it". Oh ya, we do have fun. A little to much some times. As you can see from our videos.</p>\n<p><a href="http://www.meetup.com/The-Vancouver-B-Movie-Factory/pages/The_Vancouver_B_Movie_Videos/" class="linkified">http://www.meetup.com/The-Vancouver-B-Movie...</a></p>\n<p>There is a lot of hard costs that go into organizing this group. The $ that is asked for at some of the meetings is just a drop in the bucket to help keep this going. We have a hole lot of free meetings that are great but the ones that have a small fee are important and shows you are committed to make this work.</p>\n<p>Please click on the link below and donate to help us continue to make dreams come true and provide a lot of movies for years to come.</p>\n<p><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=ALGRJYZF8A7DJ" class="linkified">https://www.paypal.com/cgi-bin/webscr?cmd=_...</a></p>\n<p><img src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" height="1" width="1"></p>	https://www.meetup.com/The-Vancouver-B-Movie-Factory/	2247	Gang Members	49.2700000000000031	The Vancouver B Movie Factory, Movie Making Dreams Come True	-123.090000000000003	2018-01-29 13:16:48	\N
25	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 14:11:57	\N
26	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 14:11:57	\N
27	1164843	Growing Your Canadian Real Estate Business	canadianmastermind	1164843	\N	Growing Your Canadian Real Estate Business	1164843	Vancouver	1164843	\N	2008-05-25	<p>It makes no difference if you are a mom, dad, business professional, student or lazy good for nothing couch potato, this is the MEET UP designed for you.</p>\n<p>Already we have a number of multi millionaires attending this group and sharing their techniques and tricks so you can make your living sitting on the beach anywhere in the world.</p>\n<p>High profile business builders who are masters of offline marketing and pro's at online marketing are all in one place for your mental expansion and assistance. A number of joint ventures have been developed already and will produce results in the millions.<br><br>We look forward to seeing you at the next event. <br></p>	https://www.meetup.com/canadianmastermind/	738	Real Estate Entreprenures	49.2700000000000031	Growing Your Canadian Real Estate Business	-123.069999999999993	2018-01-29 14:11:57	\N
28	18564632	Vancouver Social Innovation	SocialInnovation	18564632	\N	Vancouver Social Innovation	18564632	Vancouver	18564632	\N	2015-04-26	<p><span>Social Innovation Meetup for startup workshops and networking to get funded or make more money. Vancouver social innovation hubs include for-profit companies for-good in our community. Social innovation can take place within government; for-profit sector,&nbsp;</span>nonprofit<span> sector, or in the spaces between them. There </span>are<span> a number of growing social innovation hubs in Vancouver that help social innovation startups grow. Many of these offer </span><b>workspace, support and/or investors for eligible startups</b><span>.&nbsp;<a href="http://meetup.com/socialinnovation/about/"><b>Read more</b></a></span></p>\n<p><img src="https://secure.meetupstatic.com/photos/event/5/f/e/0/600_465444544.jpeg"></p>	https://www.meetup.com/SocialInnovation/	1415	Innovators	49.2700000000000031	Vancouver Social Innovation	-123.069999999999993	2018-01-29 14:17:24	\N
29	18553122	Martin Armstrong - Vancouver friends, fans, and followers	Martin-Armstrong-Vancouver-friends-fans-and-followers	18553122	\N	Martin Armstrong - Vancouver friends, fans, and followers	18553122	Vancouver	18553122	\N	2015-04-18	<p>Want more depth, more understanding, more viewpoints? The implications of Martin's work are profound, insightful and far-reaching. I started this discussion group because I don't always get it. Martin's work influences my choices and investments: financial and otherwise. To better make these choices, I want more understanding, and discussion can get me there. We meet for an hour and a bit once or twice a month, at a private facility in False Creek South near Granville Island. Requirements: please bring your sense of humour ( this stuff can be dry. . . ), and your respect for all things, especially opinions, viewpoints, and privacy.</p>	https://www.meetup.com/Martin-Armstrong-Vancouver-friends-fans-and-followers/	86	Inquiring minds	49.2700000000000031	Martin Armstrong - Vancouver friends, fans, and followers	-123.069999999999993	2018-01-29 14:17:24	\N
\.


--
-- Data for Name: past_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY past_events (id, event_id, group_id, urlname, name, description, number_of_participants, participants_names, member_bios, venue, address, link, event_date, event_time, venue_lat, venue_lon, venue_address, venue_city, venue_state, venue_country, venue_name, created_at, updated_at) FROM stdin;
2	246910988	18564632	SocialInnovation	 Recruiting Strategies & Creating A Good Onboarding Process For Your First Hires	<p>• What we'll do<br/>Looking to on-board your first hire or bring on a contractor? What paperwork do you need to have in place? How do you ensure you set a strong first impression? Come hear answers to these questions and more in an in-depth workshop by HR experts at Amui.co</p> <p>Who is this for:</p> <p>Founders of companies that are bringing on their first employees</p> <p>HR specialist looking to set up a strong onboarding process</p> <p>You will Learn About:</p> <p>Hiring vs. Contracting.</p> <p>Strategies around recruiting, interviewing, and compensation.</p> <p>Onboarding process.</p> <p>Agenda:</p> <p>5:30PM – Registration &amp; Networking</p> <p>5:45PM – Presentation begins</p> <p>6:45PM – Q&amp;A</p> <p>7:00PM – Networking</p> <p>7:30PM – Wrap-up</p> <p>About Your Speaker:</p> <p>Allison Guld</p> <p>Allison’s strategic, operational and management experience in recruitment and HR was honed in high tech organizations such as Blast Radius, Ernst &amp; Young, and MDA. No stranger to entrepreneurial adventures, Allison’s first company paid for her university degree. She went on to be a top performer as a 100% commission high tech recruiter which segued into her own recruitment agency in the late 1990’s. She spent the last 10 years working in-house for high growth companies in senior human resources roles until 2015 when she co-founded amui with partner, Stephanie Lyster.</p> <p>Stephanie Lyster</p> <p>Stephanie has experience identifying and implementing strategic HR solutions including workforce planning, performance management, recruitment and change management. Her background in building people infrastructure for high growth companies cemented her belief that HR should not be a cost function but a strategic partner for performance, cultural influence and retention. After establishing herself in corporate HR roles, Stephanie pursued her entrepreneurial interests as a consultant starting 2009 until she co-founded amui in 2015 with partner, Allison Guld.</p> <p>Amui is a company that is changing the way that organizations interact with HR by providing on-demand access to HR knowledge so everyone makes better decisions. Allison and Stephanie are frequent speakers at industry events providing informative workshops and insights into the innovation potential of HR technology to transform business.</p> <p>• What to bring</p> <p>• Important to know<br/>Don't forget to RSVP on Eventbrite to save your spot. Seats are limited. <a href="https://www.eventbrite.com/e/recruiting-strategies-and-creating-a-good-on-boarding-process-for-your-first-hires-tickets-41982166791?aff=Soc" class="linkified">https://www.eventbrite.com/e/recruiting-strategies-and-creating-a-good-on-boarding-process-for-your-first-hires-tickets-41982166791?aff=Soc</a></p> 	1	{}	{}	\N	\N	https://www.meetup.com/SocialInnovation/events/246910988/	2018-02-06	17:30:00	49.28106689453125	-123.104782104492188	90-425 Carrall St	\N	\N	\N	Spring	2018-01-29 13:01:45	2018-01-29 13:19:48
1	246908538	18564632	SocialInnovation	Spring Breakfast Talks: Scale Your Online Business	<p>• What we'll do<br/>Do you sell products on Amazon or would like to start?</p> <p>Join us for a breakfast Q&amp;A session on things you need to know to sell successfully on Amazon.</p> <p>Topics for discussion:</p> <p>Brief explanation of the online avenues for consumer packaged goods<br/>Understand how to assess the cost of selling online, so you can price your product competitively and profitably<br/>Key aspects of well performing product pages<br/>Operational proficiency as it applies to the flow of orders and the expectations of the industry<br/>Supply chain management as it applies to having appropriate inventory levels to grow your business.<br/>Interacting with Amazon, when it’s near impossible to talk to anyone, or find an email contact that can properly answer your question<br/>Handling returns and packing goods to avoid damages</p> <p>Subject Matter Expert</p> <p>Brad Glessing, Glessing Enterprise Inc.</p> <p>Brad has over 35 years of experience in senior management positions with mid-sized consumer packaged goods companies, the most recent position was CEO of AZ Home &amp; Gifts. Brad realized the opportunity in the online channel and with his team became a top 20 vendor at Amazon (home division) and achieved Platinum Vendor status. Currently, Brad and his colleagues help companies grow their online business with a focus on operational proficiency and supply chain optimization. You can contact Brad at [masked]</p> <p>RSVP on Eventbrite if you haven't! Space is limited.</p> <p>• What to bring</p> <p><br/>• Important to know<br/><a href="https://www.eventbrite.com/e/spring-breakfast-talks-scale-your-online-business-tickets-41843181081?aff=soci" class="linkified">https://www.eventbrite.com/e/spring-breakfast-talks-scale-your-online-business-tickets-41843181081?aff=soci</a></p> 	4	{}	{}	\N	\N	https://www.meetup.com/SocialInnovation/events/246908538/	2018-01-30	08:00:00	49.2821464538574219	-123.104515075683594	319 Carrall Street 	\N	\N	\N	East Van Roasters	2018-01-29 13:01:45	2018-01-29 13:19:48
\.


--
-- Data for Name: rsvps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rsvps (id, member_id, member_ids, group_id, group_urlname, event_id, link, response, event_date, created_at, updated_at) FROM stdin;
1	243099223	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
2	236885945	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
3	213244190	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
4	225543997	{}	\N	SocialInnovation	246908538	\N	yes	\N	2018-01-29 13:02:01	2018-01-29 13:02:36
9	243099223	{}	\N	SocialInnovation	246910988	\N	yes	\N	2018-01-29 13:16:01	2018-01-29 13:16:48
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20180127211634
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY topics (id, topic_id, lang, name, description, member_count, group_count, urlkey, created_at, updated_at) FROM stdin;
1	19882	en_US	Entrepreneurship	Meet local entrepreneurs, discuss strategies and share success stories with them!	15722669	32474	entrepreneurship	\N	\N
2	26643	en_US	Social Entrepreneurship	Find out what's happening in Social Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	944814	2293	social-entrepreneurship	\N	\N
3	21680	en_US	Entrepreneurship Training	Find out what's happening in Entrepreneurship Training Meetup groups around the world and start meeting up with the ones near you.	128908	381	entrepreneurship-training	\N	\N
4	134056	en_US	Entrepreneurship and Self Empowerment	Find out what's happening in Entrepreneurship and Self Empowerment Meetup groups around the world and start meeting up with the ones near you.	61773	200	entrepreneurship-and-self-empowerment	\N	\N
5	148105	en_US	Marketing and Entrepreneurship	Find out what's happening in Marketing and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	79202	162	marketing-and-entrepreneurship	\N	\N
6	757162	en_US	Veterans Entrepreneurship	Find out what's happening in Veterans Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	1978	17	veterans-entrepreneurship	\N	\N
7	608872	en_US	Entrepreneurship in Jerusalem	Find out what's happening in Entrepreneurship in Jerusalem Meetup groups around the world and start meeting up with the ones near you.	14386	12	entrepreneurship-in-jerusalem	\N	\N
8	99253	en_US	Holistic Entrepreneurship	Find out what's happening in Holistic Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	686	7	holistic-entrepreneurship	\N	\N
9	734002	en_US	applied entrepreneurship	Find out what's happening in applied entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	2139	6	applied-entrepreneurship	\N	\N
10	711032	en_US	Immigrant Entrepreneurship	Find out what's happening in Immigrant Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	246	2	immigrant-entrepreneurship	\N	\N
11	131343	en_US	Intellectual Entrepreneurship	Find out what's happening in Intellectual Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	44	1	intellectual-entrepreneurship	\N	\N
12	74017	en_US	Entrepreneurship: Innovative Ideas for Your Child	Find out what's happening in Entrepreneurship: Innovative Ideas for Your Child Meetup groups around the world and start meeting up with the ones near you.	0	0	entrepreneurship-innovative-ideas-for-your-child	\N	\N
13	102177	en_US	High Impact Entrepreneurship	Find out what's happening in High Impact Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	high-impact-entrepreneurship	\N	\N
14	136076	en_US	From Corporate to Entrepreneurship	Find out what's happening in From Corporate to Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	from-corporate-to-entrepreneurship	\N	\N
15	144132	it	happiness through entrepreneurship	Find out what's happening in happiness through entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	happiness-through-entrepreneurship	\N	\N
16	162876	en_US	Entrepreneurship in the 21st Century	Find out what's happening in Entrepreneurship in the 21st Century Meetup groups around the world and start meeting up with the ones near you.	0	0	entrepreneurship-in-the-21st-century	\N	\N
17	315911	en_US	Steps toward Entrepreneurship	Find out what's happening in Steps toward Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	steps-toward-entrepreneurship	\N	\N
18	343911	en_US	Desi Entrepreneurship	Find out what's happening in Desi Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	desi-entrepreneurship	\N	\N
19	398152	en_US	Seattle Entrepreneurship	Find out what's happening in Seattle Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	seattle-entrepreneurship	\N	\N
20	538702	en_US	Science Innovation and Entrepreneurship	Find out what's happening in Science Innovation and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.	0	0	science-innovation-and-entrepreneurship	\N	\N
\.


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('events_id_seq', 1, false);


--
-- Name: group_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_members_id_seq', 8, true);


--
-- Name: groups_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_history_id_seq', 30, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_id_seq', 36, true);


--
-- Name: past_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('past_events_id_seq', 16, true);


--
-- Name: rsvps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rsvps_id_seq', 10, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('topics_id_seq', 20, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: group_members group_members_member_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members
    ADD CONSTRAINT group_members_member_id_group_id_key UNIQUE (member_id, group_id);


--
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (id);


--
-- Name: groups_history groups_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups_history
    ADD CONSTRAINT groups_history_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: past_events past_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY past_events
    ADD CONSTRAINT past_events_pkey PRIMARY KEY (id);


--
-- Name: rsvps rsvps_member_id_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps
    ADD CONSTRAINT rsvps_member_id_event_id_key UNIQUE (member_id, event_id);


--
-- Name: rsvps rsvps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rsvps
    ADD CONSTRAINT rsvps_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: index_events_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_events_on_event_id ON events USING btree (event_id);


--
-- Name: index_events_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_events_on_group_id ON events USING btree (group_id);


--
-- Name: index_groups_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_groups_on_group_id ON groups USING btree (group_id);


--
-- Name: index_past_events_on_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_past_events_on_event_id ON past_events USING btree (event_id);


--
-- Name: index_past_events_on_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_past_events_on_group_id ON past_events USING btree (group_id);


--
-- Name: index_topics_on_topic_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_topics_on_topic_id ON topics USING btree (topic_id);


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES  TO postgres;


--
-- PostgreSQL database dump complete
--

