-- Adminer 4.3.1 PostgreSQL dump

DROP TABLE IF EXISTS "topics";
CREATE SEQUENCE topics_id_seq INCREMENT  MINVALUE  MAXVALUE  START 1 CACHE ;

CREATE TABLE "public"."topics" (
    "id" bigint DEFAULT nextval('topics_id_seq') NOT NULL,
    "topic_id" bigint,
    "lang" text,
    "name" text,
    "description" text,
    "member_count" integer,
    "group_count" integer,
    "urlkey" text,
    "created_at" timestamp,
    "updated_at" timestamp,
    CONSTRAINT "index_topics_on_topic_id" UNIQUE ("topic_id"),
    CONSTRAINT "topics_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "topics" ("id", "topic_id", "lang", "name", "description", "member_count", "group_count", "urlkey", "created_at", "updated_at") VALUES
(1,	19882,	'en_US',	'Entrepreneurship',	'Meet local entrepreneurs, discuss strategies and share success stories with them!',	15722669,	32474,	'entrepreneurship',	NULL,	NULL),
(2,	26643,	'en_US',	'Social Entrepreneurship',	'Find out what''s happening in Social Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	944814,	2293,	'social-entrepreneurship',	NULL,	NULL),
(3,	21680,	'en_US',	'Entrepreneurship Training',	'Find out what''s happening in Entrepreneurship Training Meetup groups around the world and start meeting up with the ones near you.',	128908,	381,	'entrepreneurship-training',	NULL,	NULL),
(4,	134056,	'en_US',	'Entrepreneurship and Self Empowerment',	'Find out what''s happening in Entrepreneurship and Self Empowerment Meetup groups around the world and start meeting up with the ones near you.',	61773,	200,	'entrepreneurship-and-self-empowerment',	NULL,	NULL),
(5,	148105,	'en_US',	'Marketing and Entrepreneurship',	'Find out what''s happening in Marketing and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	79202,	162,	'marketing-and-entrepreneurship',	NULL,	NULL),
(6,	757162,	'en_US',	'Veterans Entrepreneurship',	'Find out what''s happening in Veterans Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	1978,	17,	'veterans-entrepreneurship',	NULL,	NULL),
(7,	608872,	'en_US',	'Entrepreneurship in Jerusalem',	'Find out what''s happening in Entrepreneurship in Jerusalem Meetup groups around the world and start meeting up with the ones near you.',	14386,	12,	'entrepreneurship-in-jerusalem',	NULL,	NULL),
(8,	99253,	'en_US',	'Holistic Entrepreneurship',	'Find out what''s happening in Holistic Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	686,	7,	'holistic-entrepreneurship',	NULL,	NULL),
(9,	734002,	'en_US',	'applied entrepreneurship',	'Find out what''s happening in applied entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	2139,	6,	'applied-entrepreneurship',	NULL,	NULL),
(10,	711032,	'en_US',	'Immigrant Entrepreneurship',	'Find out what''s happening in Immigrant Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	246,	2,	'immigrant-entrepreneurship',	NULL,	NULL),
(11,	131343,	'en_US',	'Intellectual Entrepreneurship',	'Find out what''s happening in Intellectual Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	44,	1,	'intellectual-entrepreneurship',	NULL,	NULL),
(12,	74017,	'en_US',	'Entrepreneurship: Innovative Ideas for Your Child',	'Find out what''s happening in Entrepreneurship: Innovative Ideas for Your Child Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'entrepreneurship-innovative-ideas-for-your-child',	NULL,	NULL),
(13,	102177,	'en_US',	'High Impact Entrepreneurship',	'Find out what''s happening in High Impact Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'high-impact-entrepreneurship',	NULL,	NULL),
(14,	136076,	'en_US',	'From Corporate to Entrepreneurship',	'Find out what''s happening in From Corporate to Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'from-corporate-to-entrepreneurship',	NULL,	NULL),
(15,	144132,	'it',	'happiness through entrepreneurship',	'Find out what''s happening in happiness through entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'happiness-through-entrepreneurship',	NULL,	NULL),
(16,	162876,	'en_US',	'Entrepreneurship in the 21st Century',	'Find out what''s happening in Entrepreneurship in the 21st Century Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'entrepreneurship-in-the-21st-century',	NULL,	NULL),
(17,	315911,	'en_US',	'Steps toward Entrepreneurship',	'Find out what''s happening in Steps toward Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'steps-toward-entrepreneurship',	NULL,	NULL),
(18,	343911,	'en_US',	'Desi Entrepreneurship',	'Find out what''s happening in Desi Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'desi-entrepreneurship',	NULL,	NULL),
(19,	398152,	'en_US',	'Seattle Entrepreneurship',	'Find out what''s happening in Seattle Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'seattle-entrepreneurship',	NULL,	NULL),
(20,	538702,	'en_US',	'Science Innovation and Entrepreneurship',	'Find out what''s happening in Science Innovation and Entrepreneurship Meetup groups around the world and start meeting up with the ones near you.',	0,	0,	'science-innovation-and-entrepreneurship',	NULL,	NULL);

-- 2018-01-29 14:12:29.643617-08
