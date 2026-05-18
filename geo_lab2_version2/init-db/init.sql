--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg110+2)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg110+2)

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

--
-- Name: ogr_system_tables; Type: SCHEMA; Schema: -; Owner: gisuser
--

CREATE SCHEMA ogr_system_tables;


ALTER SCHEMA ogr_system_tables OWNER TO gisuser;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: event_trigger_function_for_metadata(); Type: FUNCTION; Schema: ogr_system_tables; Owner: gisuser
--

CREATE FUNCTION ogr_system_tables.event_trigger_function_for_metadata() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    obj record;
BEGIN
  IF has_schema_privilege('ogr_system_tables', 'USAGE') THEN
   IF has_table_privilege('ogr_system_tables.metadata', 'DELETE') THEN
    FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
    LOOP
        IF obj.object_type = 'table' THEN
            DELETE FROM ogr_system_tables.metadata m WHERE m.schema_name = obj.schema_name AND m.table_name = obj.object_name;
        END IF;
    END LOOP;
   END IF;
  END IF;
END;
$$;


ALTER FUNCTION ogr_system_tables.event_trigger_function_for_metadata() OWNER TO gisuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: metadata; Type: TABLE; Schema: ogr_system_tables; Owner: gisuser
--

CREATE TABLE ogr_system_tables.metadata (
    id integer NOT NULL,
    schema_name text NOT NULL,
    table_name text NOT NULL,
    metadata text
);


ALTER TABLE ogr_system_tables.metadata OWNER TO gisuser;

--
-- Name: metadata_id_seq; Type: SEQUENCE; Schema: ogr_system_tables; Owner: gisuser
--

CREATE SEQUENCE ogr_system_tables.metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE ogr_system_tables.metadata_id_seq OWNER TO gisuser;

--
-- Name: metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: ogr_system_tables; Owner: gisuser
--

ALTER SEQUENCE ogr_system_tables.metadata_id_seq OWNED BY ogr_system_tables.metadata.id;


--
-- Name: buildings; Type: TABLE; Schema: public; Owner: gisuser
--

CREATE TABLE public.buildings (
    ogc_fid integer NOT NULL,
    geom public.geometry(Geometry,4326) NOT NULL,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:municipality" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    incline character varying,
    lanes character varying,
    name character varying,
    sidewalk character varying,
    smoothness character varying,
    surface character varying,
    id character varying
);


ALTER TABLE public.buildings OWNER TO gisuser;

--
-- Name: buildings_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: gisuser
--

CREATE SEQUENCE public.buildings_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.buildings_ogc_fid_seq OWNER TO gisuser;

--
-- Name: buildings_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gisuser
--

ALTER SEQUENCE public.buildings_ogc_fid_seq OWNED BY public.buildings.ogc_fid;


--
-- Name: poi; Type: TABLE; Schema: public; Owner: gisuser
--

CREATE TABLE public.poi (
    id bigint,
    geom public.geometry,
    gid integer NOT NULL
);


ALTER TABLE public.poi OWNER TO gisuser;

--
-- Name: poi_gid_seq; Type: SEQUENCE; Schema: public; Owner: gisuser
--

CREATE SEQUENCE public.poi_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.poi_gid_seq OWNER TO gisuser;

--
-- Name: poi_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gisuser
--

ALTER SEQUENCE public.poi_gid_seq OWNED BY public.poi.gid;


--
-- Name: roads; Type: TABLE; Schema: public; Owner: gisuser
--

CREATE TABLE public.roads (
    ogc_fid integer,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:municipality" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    incline character varying,
    lanes character varying,
    name character varying,
    sidewalk character varying,
    smoothness character varying,
    surface character varying,
    id character varying,
    geom public.geometry(Geometry,4326),
    gid integer NOT NULL
);


ALTER TABLE public.roads OWNER TO gisuser;

--
-- Name: roads_gid_seq; Type: SEQUENCE; Schema: public; Owner: gisuser
--

CREATE SEQUENCE public.roads_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roads_gid_seq OWNER TO gisuser;

--
-- Name: roads_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gisuser
--

ALTER SEQUENCE public.roads_gid_seq OWNED BY public.roads.gid;


--
-- Name: tmp_layer; Type: TABLE; Schema: public; Owner: gisuser
--

CREATE TABLE public.tmp_layer (
    ogc_fid integer NOT NULL,
    "timestamp" timestamp with time zone,
    version character varying,
    changeset character varying,
    "user" character varying,
    uid character varying,
    "addr:city" character varying,
    "addr:housenumber" character varying,
    "addr:municipality" character varying,
    "addr:place" character varying,
    "addr:street" character varying,
    building character varying,
    "building:levels" character varying,
    highway character varying,
    incline character varying,
    lanes character varying,
    name character varying,
    sidewalk character varying,
    smoothness character varying,
    surface character varying,
    id character varying,
    geom public.geometry(Geometry,4326)
);


ALTER TABLE public.tmp_layer OWNER TO gisuser;

--
-- Name: tmp_layer_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: gisuser
--

CREATE SEQUENCE public.tmp_layer_ogc_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tmp_layer_ogc_fid_seq OWNER TO gisuser;

--
-- Name: tmp_layer_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gisuser
--

ALTER SEQUENCE public.tmp_layer_ogc_fid_seq OWNED BY public.tmp_layer.ogc_fid;


--
-- Name: metadata id; Type: DEFAULT; Schema: ogr_system_tables; Owner: gisuser
--

ALTER TABLE ONLY ogr_system_tables.metadata ALTER COLUMN id SET DEFAULT nextval('ogr_system_tables.metadata_id_seq'::regclass);


--
-- Name: buildings ogc_fid; Type: DEFAULT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.buildings ALTER COLUMN ogc_fid SET DEFAULT nextval('public.buildings_ogc_fid_seq'::regclass);


--
-- Name: poi gid; Type: DEFAULT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.poi ALTER COLUMN gid SET DEFAULT nextval('public.poi_gid_seq'::regclass);


--
-- Name: roads gid; Type: DEFAULT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.roads ALTER COLUMN gid SET DEFAULT nextval('public.roads_gid_seq'::regclass);


--
-- Name: tmp_layer ogc_fid; Type: DEFAULT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.tmp_layer ALTER COLUMN ogc_fid SET DEFAULT nextval('public.tmp_layer_ogc_fid_seq'::regclass);


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: ogr_system_tables; Owner: gisuser
--

COPY ogr_system_tables.metadata (id, schema_name, table_name, metadata) FROM stdin;
1	public	tmp_layer	<GDALMetadata>\n  <Metadata domain="NATIVE_DATA">\n    <MDI key="NATIVE_DATA">{ }</MDI>\n    <MDI key="NATIVE_MEDIA_TYPE">application/vnd.geo+json</MDI>\n  </Metadata>\n</GDALMetadata>\n
\.


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: gisuser
--

COPY public.buildings (ogc_fid, geom, "timestamp", version, changeset, "user", uid, "addr:city", "addr:housenumber", "addr:municipality", "addr:place", "addr:street", building, "building:levels", highway, incline, lanes, name, sidewalk, smoothness, surface, id) FROM stdin;
1	0106000020E610000001000000010300000001000000050000000650E7E50B9C4840D25F9E8488CC4A404B94185F0F9C48409D1ECA0688CC4A4075273339109C48403090B1248ACC4A409A232BBF0C9C484066D185A28ACC4A400650E7E50B9C4840D25F9E8488CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	105	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323366
2	0106000020E61000000100000001030000000100000005000000A46BCB25FA9B4840BEE204018DCC4A4027929ED8F99B48409BCAA2B08BCC4A405566EF31FD9B484059AD026B8BCC4A40D23F1C7FFD9B484011853BBC8CCC4A40A46BCB25FA9B4840BEE204018DCC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	106	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323367
3	0106000020E61000000100000001030000000100000005000000A56950340F9C484033631B0291CC4A40876A4AB20E9C4840FEDFC7878FCC4A4038656EBE119C4840E00ED4298FCC4A4056647440129C484080D250A390CC4A40A56950340F9C484033631B0291CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	103	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323368
4	0106000020E6100000010000000103000000010000000500000081311125109C4840F5A8537996CC4A40C30C326E0F9C4840A82BE97294CC4A407F81C586139C48408B2CE3F093CC4A403DA6A43D149C484042EA76F695CC4A4081311125109C4840F5A8537996CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	101	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323369
5	0106000020E6100000010000000103000000010000000500000049BE6D01FC9B48407FB273E492CC4A4079B8D38CFB9B484068A4EF7F91CC4A401948066FFE9B4840B00E362B91CC4A40548EC9E2FE9B4840C71CBA8F92CC4A4049BE6D01FC9B48407FB273E492CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	104	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323370
6	0106000020E6100000010000000103000000010000000500000031766792FD9B48406A0190C998CC4A40023A820AFD9B4840E884D04197CC4A40068F2562009C48403CF9F4D896CC4A4035CB0AEA009C4840BE75B46098CC4A4031766792FD9B48406A0190C998CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	102	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323371
7	0106000020E61000000100000001030000000100000005000000F5B3A217FF9B484068791EDC9DCC4A403C4CFBE6FE9B4840F74DAB329DCC4A40D58E8763029C48402D7B12D89CCC4A4022B60595029C48409EA685819DCC4A40F5B3A217FF9B484068791EDC9DCC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	100	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323372
8	0106000020E61000000100000001030000000100000005000000D98A47F3119C4840CEE8A27C9CCC4A40920C946F119C4840816B38769ACC4A400D929966159C4840B7989F1B9ACC4A40BF5076E9159C484003160A229CCC4A40D98A47F3119C4840CEE8A27C9CCC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	99	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323373
9	0106000020E61000000100000001030000000100000005000000C4CDA964009C48401D3FAFD3A3CC4A4012E1BABDFF9B48404EE3288AA1CC4A40E60DE665039C48403112352CA1CC4A402EBAAB0D049C48406BAEE474A3CC4A40C4CDA964009C48401D3FAFD3A3CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	98	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323374
10	0106000020E610000001000000010300000001000000050000003773A323149C484065677682A2CC4A405B07077B139C48406C448BC7A0CC4A4048BEB78E169C48402BF9D85DA0CC4A40B9E92A38179C4840241CC418A2CC4A403773A323149C484065677682A2CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	97	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323375
11	0106000020E6100000010000000103000000010000000500000017C6CCF4019C48407416AC27A9CC4A404DF3339A019C4840F17F4754A8CC4A4039AAE4AD049C4840633B29DDA7CC4A40037D7D08059C4840E5D18DB0A8CC4A4017C6CCF4019C48407416AC27A9CC4A40	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	96	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499348391
\.


--
-- Data for Name: poi; Type: TABLE DATA; Schema: public; Owner: gisuser
--

COPY public.poi (id, geom, gid) FROM stdin;
1	0101000020E61000002D9F5F0F0E9C484046BAB15489CC4A40	1
2	0101000020E6100000E7C509ACFB9B4840C24634368CCC4A40	2
3	0101000020E610000008EC3C79109C48408530C91590CC4A40	3
4	0101000020E6100000F8B3C9D5119C48405A09ED3495CC4A40	4
5	0101000020E61000006D82FD37FD9B48402803CD0792CC4A40	5
6	0101000020E61000009C8246FAFE9B4840547D42D197CC4A40	6
7	0101000020E61000005C11D5BD009C484068D51A5A9DCC4A40	7
8	0101000020E6100000F78BB5AC139C48409995184C9BCC4A40	8
9	0101000020E6100000439368E5019C484021F8CC7FA2CC4A40	9
10	0101000020E61000006AFF6A59159C484021B63070A1CC4A40	10
11	0101000020E610000027B85851039C4840EBA86A82A8CC4A40	11
\.


--
-- Data for Name: roads; Type: TABLE DATA; Schema: public; Owner: gisuser
--

COPY public.roads (ogc_fid, "timestamp", version, changeset, "user", uid, "addr:city", "addr:housenumber", "addr:municipality", "addr:place", "addr:street", building, "building:levels", highway, incline, lanes, name, sidewalk, smoothness, surface, id, geom, gid) FROM stdin;
12	2015-05-18 12:09:32+00	5	31253230	Konst_M	1934545	\N	\N	\N	\N	\N	\N	\N	unclassified	\N	\N	\N	\N	\N	\N	way/298623627	0105000020E61000000100000001020000004300000057F95404EE9F4840A85725EC36CC4A4067DFCB33E59F484062DFA9DB34CC4A4077741200D29F484008A8154B36CC4A4058F844E8B19F48409C7521B138CC4A408C721F6FA89F4840301B536639CC4A40463F1A4E999F48409A5544F23ACC4A406C43C5387F9F484046C1429C3DCC4A40723447567E9F48408DB5BFB33DCC4A401A5FC5F3639F484074DD4A6540CC4A4087E75BD5489F4840BA3B212A43CC4A40544A19822D9F48407D1700F445CC4A40FCEA60B3129F484087B949B148CC4A40B7103F5AF79E4840DF54FF7B4BCC4A40B9443F64DB9E4840D8E77B574ECC4A400FE72B92C09E48404ECAEE1351CC4A40CFB5D4E6A49E48400BA1DEE753CC4A40F58B6DAD8A9E4840090B389556CC4A40C6973F95899E4840E0B99CB756CC4A403E86D8AA6E9E4840A852B3075ACC4A400B314DC7529E4840F49BD3765DCC4A40530031AE5D9E48405708ABB184CC4A4023EC25D75E9E484008EF61E586CC4A40B387AC24689E48409F1793A3A5CC4A401B26BFEA6D9E48403651F0B9B8CC4A40B33742507F9E4840DCD8EC48F5CC4A407444BE4BA99E4840ECC781B284CD4A40B8955E9B8D9E4840C7E52E7887CD4A40FCA47FEE709E4840137706578ACD4A40E8B00CBB399E484048911040C5CC4A40F8904B77329E48406D95BB2AABCC4A402DC665811B9E48405CBBA3B558CC4A40E12E562F1A9E484017D9CEF753CC4A40C5BF74FFFD9D4840AAD4EC8156CC4A40C8693E9DE19D4840268E3C1059CC4A40EE878ED3C69D48400D5AA3795BCC4A40F017B325AB9D48407DDB02F85DCC4A4010A7DDF98F9D4840C9E2A36A60CC4A40B37680CC739D48405CDEC1F462CC4A4050F97C39589D48407961C66F65CC4A404C56A0713C9D4840A721AAF067CC4A40C5443987219D4840E1EB6B5D6ACC4A406A238DC00E9D4840E113460E6CCC4A4002D369DD069D4840BC1D86FB6DCC4A401D4938E3EA9C4840F6FBB44071CC4A4018DAEF3FE89C48409C548F8F71CC4A40C89750C1E19C4840852C66DF70CC4A40FB027AE1CE9C48408454409072CC4A405DF7FB6AB39C48408F9A650575CC4A4094241983989C4840E1A6F56D77CC4A40133246DA7C9C48402176A6D079CC4A405DD08C8F609C48403D27BD6F7CCC4A40BFAA69CD459C4840CBC1C7BB7ECC4A402C8F24F72A9C4840179B560A81CC4A402CB7B41A129C484093CA6F2C83CC4A408E210038F69B484092D8A49185CC4A40B459F5B9DA9B4840C06A76EE87CC4A408F8E064BD09B484079B878D388CC4A40EC1681B1BE9B4840DD9156218ACC4A40170CAEB9A39B4840F399A2128DCC4A40FCB03962889B48407BA587FC8ECC4A40D8101C97719B4840046FEDE98FCC4A40EC037FAE6C9B484051F28F6390CC4A402A3CC32F509B48401AD35D2393CC4A401428BDCA359B4840D74D29AF95CC4A40E78F696D1A9B4840717C485398CC4A4024DC1AC7FE9A48404667F4FE9ACC4A4061ACCA19E59A4840CD2A22799DCC4A40	1
13	2017-07-25 08:09:07+00	3	50548950	Kosolap	406208	\N	\N	\N	\N	\N	\N	\N	service	0	1	улица №11	no	bad	unpaved	way/298627459	0105000020E6100000010000000102000000020000008E210038F69B484092D8A49185CC4A40FDAF29464C9C4840A90716D1C0CD4A40	2
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: gisuser
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: tmp_layer; Type: TABLE DATA; Schema: public; Owner: gisuser
--

COPY public.tmp_layer (ogc_fid, "timestamp", version, changeset, "user", uid, "addr:city", "addr:housenumber", "addr:municipality", "addr:place", "addr:street", building, "building:levels", highway, incline, lanes, name, sidewalk, smoothness, surface, id, geom) FROM stdin;
1	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	105	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323366	0106000020E610000001000000010300000001000000050000000650E7E50B9C4840D25F9E8488CC4A404B94185F0F9C48409D1ECA0688CC4A4075273339109C48403090B1248ACC4A409A232BBF0C9C484066D185A28ACC4A400650E7E50B9C4840D25F9E8488CC4A40
2	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	106	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323367	0106000020E61000000100000001030000000100000005000000A46BCB25FA9B4840BEE204018DCC4A4027929ED8F99B48409BCAA2B08BCC4A405566EF31FD9B484059AD026B8BCC4A40D23F1C7FFD9B484011853BBC8CCC4A40A46BCB25FA9B4840BEE204018DCC4A40
3	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	103	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323368	0106000020E61000000100000001030000000100000005000000A56950340F9C484033631B0291CC4A40876A4AB20E9C4840FEDFC7878FCC4A4038656EBE119C4840E00ED4298FCC4A4056647440129C484080D250A390CC4A40A56950340F9C484033631B0291CC4A40
4	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	101	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323369	0106000020E6100000010000000103000000010000000500000081311125109C4840F5A8537996CC4A40C30C326E0F9C4840A82BE97294CC4A407F81C586139C48408B2CE3F093CC4A403DA6A43D149C484042EA76F695CC4A4081311125109C4840F5A8537996CC4A40
5	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	104	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323370	0106000020E6100000010000000103000000010000000500000049BE6D01FC9B48407FB273E492CC4A4079B8D38CFB9B484068A4EF7F91CC4A401948066FFE9B4840B00E362B91CC4A40548EC9E2FE9B4840C71CBA8F92CC4A4049BE6D01FC9B48407FB273E492CC4A40
6	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	102	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499323371	0106000020E6100000010000000103000000010000000500000031766792FD9B48406A0190C998CC4A40023A820AFD9B4840E884D04197CC4A40068F2562009C48403CF9F4D896CC4A4035CB0AEA009C4840BE75B46098CC4A4031766792FD9B48406A0190C998CC4A40
7	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	100	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323372	0106000020E61000000100000001030000000100000005000000F5B3A217FF9B484068791EDC9DCC4A403C4CFBE6FE9B4840F74DAB329DCC4A40D58E8763029C48402D7B12D89CCC4A4022B60595029C48409EA685819DCC4A40F5B3A217FF9B484068791EDC9DCC4A40
8	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	99	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323373	0106000020E61000000100000001030000000100000005000000D98A47F3119C4840CEE8A27C9CCC4A40920C946F119C4840816B38769ACC4A400D929966159C4840B7989F1B9ACC4A40BF5076E9159C484003160A229CCC4A40D98A47F3119C4840CEE8A27C9CCC4A40
9	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	98	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323374	0106000020E61000000100000001030000000100000005000000C4CDA964009C48401D3FAFD3A3CC4A4012E1BABDFF9B48404EE3288AA1CC4A40E60DE665039C48403112352CA1CC4A402EBAAB0D049C48406BAEE474A3CC4A40C4CDA964009C48401D3FAFD3A3CC4A40
10	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	97	Ставропольский муниципальный район	СНТ "Северное"	улица №12	house	2	\N	\N	\N	\N	\N	\N	\N	way/1499323375	0106000020E610000001000000010300000001000000050000003773A323149C484065677682A2CC4A405B07077B139C48406C448BC7A0CC4A4048BEB78E169C48402BF9D85DA0CC4A40B9E92A38179C4840241CC418A2CC4A403773A323149C484065677682A2CC4A40
11	2026-04-27 08:18:21+00	2	181878330	SysolyatinE	24041664	сельское поселение Подстепки	96	Ставропольский муниципальный район	СНТ "Северное"	улица №11	house	1	\N	\N	\N	\N	\N	\N	\N	way/1499348391	0106000020E6100000010000000103000000010000000500000017C6CCF4019C48407416AC27A9CC4A404DF3339A019C4840F17F4754A8CC4A4039AAE4AD049C4840633B29DDA7CC4A40037D7D08059C4840E5D18DB0A8CC4A4017C6CCF4019C48407416AC27A9CC4A40
12	2015-05-18 12:09:32+00	5	31253230	Konst_M	1934545	\N	\N	\N	\N	\N	\N	\N	unclassified	\N	\N	\N	\N	\N	\N	way/298623627	0105000020E61000000100000001020000004300000057F95404EE9F4840A85725EC36CC4A4067DFCB33E59F484062DFA9DB34CC4A4077741200D29F484008A8154B36CC4A4058F844E8B19F48409C7521B138CC4A408C721F6FA89F4840301B536639CC4A40463F1A4E999F48409A5544F23ACC4A406C43C5387F9F484046C1429C3DCC4A40723447567E9F48408DB5BFB33DCC4A401A5FC5F3639F484074DD4A6540CC4A4087E75BD5489F4840BA3B212A43CC4A40544A19822D9F48407D1700F445CC4A40FCEA60B3129F484087B949B148CC4A40B7103F5AF79E4840DF54FF7B4BCC4A40B9443F64DB9E4840D8E77B574ECC4A400FE72B92C09E48404ECAEE1351CC4A40CFB5D4E6A49E48400BA1DEE753CC4A40F58B6DAD8A9E4840090B389556CC4A40C6973F95899E4840E0B99CB756CC4A403E86D8AA6E9E4840A852B3075ACC4A400B314DC7529E4840F49BD3765DCC4A40530031AE5D9E48405708ABB184CC4A4023EC25D75E9E484008EF61E586CC4A40B387AC24689E48409F1793A3A5CC4A401B26BFEA6D9E48403651F0B9B8CC4A40B33742507F9E4840DCD8EC48F5CC4A407444BE4BA99E4840ECC781B284CD4A40B8955E9B8D9E4840C7E52E7887CD4A40FCA47FEE709E4840137706578ACD4A40E8B00CBB399E484048911040C5CC4A40F8904B77329E48406D95BB2AABCC4A402DC665811B9E48405CBBA3B558CC4A40E12E562F1A9E484017D9CEF753CC4A40C5BF74FFFD9D4840AAD4EC8156CC4A40C8693E9DE19D4840268E3C1059CC4A40EE878ED3C69D48400D5AA3795BCC4A40F017B325AB9D48407DDB02F85DCC4A4010A7DDF98F9D4840C9E2A36A60CC4A40B37680CC739D48405CDEC1F462CC4A4050F97C39589D48407961C66F65CC4A404C56A0713C9D4840A721AAF067CC4A40C5443987219D4840E1EB6B5D6ACC4A406A238DC00E9D4840E113460E6CCC4A4002D369DD069D4840BC1D86FB6DCC4A401D4938E3EA9C4840F6FBB44071CC4A4018DAEF3FE89C48409C548F8F71CC4A40C89750C1E19C4840852C66DF70CC4A40FB027AE1CE9C48408454409072CC4A405DF7FB6AB39C48408F9A650575CC4A4094241983989C4840E1A6F56D77CC4A40133246DA7C9C48402176A6D079CC4A405DD08C8F609C48403D27BD6F7CCC4A40BFAA69CD459C4840CBC1C7BB7ECC4A402C8F24F72A9C4840179B560A81CC4A402CB7B41A129C484093CA6F2C83CC4A408E210038F69B484092D8A49185CC4A40B459F5B9DA9B4840C06A76EE87CC4A408F8E064BD09B484079B878D388CC4A40EC1681B1BE9B4840DD9156218ACC4A40170CAEB9A39B4840F399A2128DCC4A40FCB03962889B48407BA587FC8ECC4A40D8101C97719B4840046FEDE98FCC4A40EC037FAE6C9B484051F28F6390CC4A402A3CC32F509B48401AD35D2393CC4A401428BDCA359B4840D74D29AF95CC4A40E78F696D1A9B4840717C485398CC4A4024DC1AC7FE9A48404667F4FE9ACC4A4061ACCA19E59A4840CD2A22799DCC4A40
13	2017-07-25 08:09:07+00	3	50548950	Kosolap	406208	\N	\N	\N	\N	\N	\N	\N	service	0	1	улица №11	no	bad	unpaved	way/298627459	0105000020E6100000010000000102000000020000008E210038F69B484092D8A49185CC4A40FDAF29464C9C4840A90716D1C0CD4A40
\.


--
-- Name: metadata_id_seq; Type: SEQUENCE SET; Schema: ogr_system_tables; Owner: gisuser
--

SELECT pg_catalog.setval('ogr_system_tables.metadata_id_seq', 1, true);


--
-- Name: buildings_ogc_fid_seq; Type: SEQUENCE SET; Schema: public; Owner: gisuser
--

SELECT pg_catalog.setval('public.buildings_ogc_fid_seq', 1, false);


--
-- Name: poi_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: gisuser
--

SELECT pg_catalog.setval('public.poi_gid_seq', 11, true);


--
-- Name: roads_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: gisuser
--

SELECT pg_catalog.setval('public.roads_gid_seq', 2, true);


--
-- Name: tmp_layer_ogc_fid_seq; Type: SEQUENCE SET; Schema: public; Owner: gisuser
--

SELECT pg_catalog.setval('public.tmp_layer_ogc_fid_seq', 13, true);


--
-- Name: metadata metadata_schema_name_table_name_key; Type: CONSTRAINT; Schema: ogr_system_tables; Owner: gisuser
--

ALTER TABLE ONLY ogr_system_tables.metadata
    ADD CONSTRAINT metadata_schema_name_table_name_key UNIQUE (schema_name, table_name);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (ogc_fid);


--
-- Name: poi poi_pkey; Type: CONSTRAINT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.poi
    ADD CONSTRAINT poi_pkey PRIMARY KEY (gid);


--
-- Name: roads roads_pkey; Type: CONSTRAINT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.roads
    ADD CONSTRAINT roads_pkey PRIMARY KEY (gid);


--
-- Name: tmp_layer tmp_layer_pkey; Type: CONSTRAINT; Schema: public; Owner: gisuser
--

ALTER TABLE ONLY public.tmp_layer
    ADD CONSTRAINT tmp_layer_pkey PRIMARY KEY (ogc_fid);


--
-- Name: idx_buildings_geom; Type: INDEX; Schema: public; Owner: gisuser
--

CREATE INDEX idx_buildings_geom ON public.buildings USING gist (geom);


--
-- Name: idx_poi_geom; Type: INDEX; Schema: public; Owner: gisuser
--

CREATE INDEX idx_poi_geom ON public.poi USING gist (geom);


--
-- Name: idx_roads_geom; Type: INDEX; Schema: public; Owner: gisuser
--

CREATE INDEX idx_roads_geom ON public.roads USING gist (geom);


--
-- Name: tmp_layer_geom_geom_idx; Type: INDEX; Schema: public; Owner: gisuser
--

CREATE INDEX tmp_layer_geom_geom_idx ON public.tmp_layer USING gist (geom);


--
-- Name: ogr_system_tables_event_trigger_for_metadata; Type: EVENT TRIGGER; Schema: -; Owner: gisuser
--

CREATE EVENT TRIGGER ogr_system_tables_event_trigger_for_metadata ON sql_drop
   EXECUTE FUNCTION ogr_system_tables.event_trigger_function_for_metadata();


ALTER EVENT TRIGGER ogr_system_tables_event_trigger_for_metadata OWNER TO gisuser;

--
-- PostgreSQL database dump complete
--

