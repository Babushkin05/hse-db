--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg22.04+1)
-- Dumped by pg_dump version 17.2

-- Started on 2025-11-07 21:25:46

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

--
-- TOC entry 268 (class 1259 OID 16801)
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    country_id character(2) NOT NULL,
    country_name character varying(40),
    region_id integer
);


--
-- TOC entry 271 (class 1259 OID 16822)
-- Name: departments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.departments (
    department_id integer NOT NULL,
    department_name character varying(30) NOT NULL,
    manager_id integer,
    location_id integer
);


--
-- TOC entry 272 (class 1259 OID 16832)
-- Name: departments_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.departments_seq
    START WITH 280
    INCREMENT BY 10
    NO MINVALUE
    MAXVALUE 9990
    CACHE 1;


--
-- TOC entry 274 (class 1259 OID 16838)
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(25) NOT NULL,
    email character varying(25) NOT NULL,
    phone_integer character varying(20),
    hire_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    salary numeric(8,2),
    commission_pct numeric(2,2),
    manager_id integer,
    department_id integer,
    CONSTRAINT emp_salary_min CHECK ((salary > (0)::numeric))
);


--
-- TOC entry 273 (class 1259 OID 16833)
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    job_id character varying(10) NOT NULL,
    job_title character varying(35) NOT NULL,
    min_salary integer,
    max_salary integer
);


--
-- TOC entry 269 (class 1259 OID 16811)
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    location_id integer NOT NULL,
    street_address character varying(40),
    postal_code character varying(12),
    city character varying(30) NOT NULL,
    state_province character varying(25),
    country_id character(2)
);


--
-- TOC entry 267 (class 1259 OID 16796)
-- Name: regions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regions (
    region_id integer NOT NULL,
    region_name character varying(25)
);


--
-- TOC entry 277 (class 1259 OID 16883)
-- Name: emp_details_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.emp_details_view AS
 SELECT e.employee_id,
    e.job_id,
    e.manager_id,
    e.department_id,
    d.location_id,
    l.country_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.commission_pct,
    d.department_name,
    j.job_title,
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
   FROM public.employees e,
    public.departments d,
    public.jobs j,
    public.locations l,
    public.countries c,
    public.regions r
  WHERE ((e.department_id = d.department_id) AND (d.location_id = l.location_id) AND (l.country_id = c.country_id) AND (c.region_id = r.region_id) AND ((j.job_id)::text = (e.job_id)::text));


--
-- TOC entry 275 (class 1259 OID 16866)
-- Name: employees_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_seq
    START WITH 207
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 276 (class 1259 OID 16867)
-- Name: job_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_history (
    employee_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id character varying(10) NOT NULL,
    department_id integer,
    CONSTRAINT jhist_date_interval CHECK ((end_date > start_date))
);


--
-- TOC entry 270 (class 1259 OID 16821)
-- Name: locations_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_seq
    START WITH 3300
    INCREMENT BY 100
    NO MINVALUE
    MAXVALUE 9900
    CACHE 1;


--
-- TOC entry 278 (class 1259 OID 16971)
-- Name: t1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.t1 (
    col1 integer NOT NULL
);


--
-- TOC entry 3444 (class 0 OID 16801)
-- Dependencies: 268
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.countries VALUES ('IT', 'Italy', 1);
INSERT INTO public.countries VALUES ('JP', 'Japan', 3);
INSERT INTO public.countries VALUES ('US', 'United States of America', 2);
INSERT INTO public.countries VALUES ('CA', 'Canada', 2);
INSERT INTO public.countries VALUES ('CN', 'China', 3);
INSERT INTO public.countries VALUES ('IN', 'India', 3);
INSERT INTO public.countries VALUES ('AU', 'Australia', 3);
INSERT INTO public.countries VALUES ('ZW', 'Zimbabwe', 4);
INSERT INTO public.countries VALUES ('SG', 'Singapore', 3);
INSERT INTO public.countries VALUES ('UK', 'United Kingdom', 1);
INSERT INTO public.countries VALUES ('FR', 'France', 1);
INSERT INTO public.countries VALUES ('DE', 'Germany', 1);
INSERT INTO public.countries VALUES ('ZM', 'Zambia', 4);
INSERT INTO public.countries VALUES ('EG', 'Egypt', 4);
INSERT INTO public.countries VALUES ('BR', 'Brazil', 2);
INSERT INTO public.countries VALUES ('CH', 'Switzerland', 1);
INSERT INTO public.countries VALUES ('NL', 'Netherlands', 1);
INSERT INTO public.countries VALUES ('MX', 'Mexico', 2);
INSERT INTO public.countries VALUES ('KW', 'Kuwait', 4);
INSERT INTO public.countries VALUES ('IL', 'Israel', 4);
INSERT INTO public.countries VALUES ('DK', 'Denmark', 1);
INSERT INTO public.countries VALUES ('ML', 'Malaysia', 3);
INSERT INTO public.countries VALUES ('NG', 'Nigeria', 4);
INSERT INTO public.countries VALUES ('AR', 'Argentina', 2);
INSERT INTO public.countries VALUES ('BE', 'Belgium', 1);


--
-- TOC entry 3447 (class 0 OID 16822)
-- Dependencies: 271
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.departments VALUES (10, 'Administration', 200, 1700);
INSERT INTO public.departments VALUES (20, 'Marketing', 201, 1800);
INSERT INTO public.departments VALUES (30, 'Purchasing', 114, 1700);
INSERT INTO public.departments VALUES (40, 'Human Resources', 203, 2400);
INSERT INTO public.departments VALUES (50, 'Shipping', 121, 1500);
INSERT INTO public.departments VALUES (60, 'IT', 103, 1400);
INSERT INTO public.departments VALUES (70, 'Public Relations', 204, 2700);
INSERT INTO public.departments VALUES (80, 'Sales', 145, 2500);
INSERT INTO public.departments VALUES (90, 'Executive', 100, 1700);
INSERT INTO public.departments VALUES (100, 'Finance', 108, 1700);
INSERT INTO public.departments VALUES (110, 'Accounting', 205, 1700);
INSERT INTO public.departments VALUES (120, 'Treasury', NULL, 1700);
INSERT INTO public.departments VALUES (130, 'Corporate Tax', NULL, 1700);
INSERT INTO public.departments VALUES (140, 'Control And Credit', NULL, 1700);
INSERT INTO public.departments VALUES (150, 'Shareholder Services', NULL, 1700);
INSERT INTO public.departments VALUES (160, 'Benefits', NULL, 1700);
INSERT INTO public.departments VALUES (170, 'Manufacturing', NULL, 1700);
INSERT INTO public.departments VALUES (180, 'Construction', NULL, 1700);
INSERT INTO public.departments VALUES (190, 'Contracting', NULL, 1700);
INSERT INTO public.departments VALUES (200, 'Operations', NULL, 1700);
INSERT INTO public.departments VALUES (210, 'IT Support', NULL, 1700);
INSERT INTO public.departments VALUES (220, 'NOC', NULL, 1700);
INSERT INTO public.departments VALUES (230, 'IT Helpdesk', NULL, 1700);
INSERT INTO public.departments VALUES (240, 'Government Sales', NULL, 1700);
INSERT INTO public.departments VALUES (250, 'Retail Sales', NULL, 1700);
INSERT INTO public.departments VALUES (260, 'Recruiting', NULL, 1700);
INSERT INTO public.departments VALUES (270, 'Payroll', NULL, 1700);


--
-- TOC entry 3450 (class 0 OID 16838)
-- Dependencies: 274
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000.00, NULL, NULL, 90);
INSERT INTO public.employees VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000.00, NULL, 100, 90);
INSERT INTO public.employees VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000.00, NULL, 100, 90);
INSERT INTO public.employees VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000.00, NULL, 102, 60);
INSERT INTO public.employees VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000.00, NULL, 103, 60);
INSERT INTO public.employees VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800.00, NULL, 103, 60);
INSERT INTO public.employees VALUES (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800.00, NULL, 103, 60);
INSERT INTO public.employees VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200.00, NULL, 103, 60);
INSERT INTO public.employees VALUES (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008.00, NULL, 101, 100);
INSERT INTO public.employees VALUES (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000.00, NULL, 108, 100);
INSERT INTO public.employees VALUES (110, 'John', 'Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200.00, NULL, 108, 100);
INSERT INTO public.employees VALUES (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700.00, NULL, 108, 100);
INSERT INTO public.employees VALUES (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800.00, NULL, 108, 100);
INSERT INTO public.employees VALUES (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900.00, NULL, 108, 100);
INSERT INTO public.employees VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000.00, NULL, 100, 30);
INSERT INTO public.employees VALUES (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100.00, NULL, 114, 30);
INSERT INTO public.employees VALUES (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900.00, NULL, 114, 30);
INSERT INTO public.employees VALUES (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800.00, NULL, 114, 30);
INSERT INTO public.employees VALUES (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600.00, NULL, 114, 30);
INSERT INTO public.employees VALUES (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500.00, NULL, 114, 30);
INSERT INTO public.employees VALUES (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000.00, NULL, 100, 50);
INSERT INTO public.employees VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200.00, NULL, 100, 50);
INSERT INTO public.employees VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900.00, NULL, 100, 50);
INSERT INTO public.employees VALUES (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500.00, NULL, 100, 50);
INSERT INTO public.employees VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800.00, NULL, 100, 50);
INSERT INTO public.employees VALUES (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (139, 'John', 'Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000.00, 0.40, 100, 80);
INSERT INTO public.employees VALUES (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500.00, 0.30, 100, 80);
INSERT INTO public.employees VALUES (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000.00, 0.30, 100, 80);
INSERT INTO public.employees VALUES (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000.00, 0.30, 100, 80);
INSERT INTO public.employees VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500.00, 0.20, 100, 80);
INSERT INTO public.employees VALUES (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000.00, 0.30, 145, 80);
INSERT INTO public.employees VALUES (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500.00, 0.25, 145, 80);
INSERT INTO public.employees VALUES (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000.00, 0.25, 145, 80);
INSERT INTO public.employees VALUES (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000.00, 0.20, 145, 80);
INSERT INTO public.employees VALUES (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500.00, 0.20, 145, 80);
INSERT INTO public.employees VALUES (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000.00, 0.15, 145, 80);
INSERT INTO public.employees VALUES (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000.00, 0.35, 146, 80);
INSERT INTO public.employees VALUES (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500.00, 0.35, 146, 80);
INSERT INTO public.employees VALUES (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000.00, 0.35, 146, 80);
INSERT INTO public.employees VALUES (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000.00, 0.30, 146, 80);
INSERT INTO public.employees VALUES (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500.00, 0.30, 146, 80);
INSERT INTO public.employees VALUES (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000.00, 0.25, 146, 80);
INSERT INTO public.employees VALUES (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500.00, 0.25, 147, 80);
INSERT INTO public.employees VALUES (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500.00, 0.15, 147, 80);
INSERT INTO public.employees VALUES (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200.00, 0.10, 147, 80);
INSERT INTO public.employees VALUES (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800.00, 0.10, 147, 80);
INSERT INTO public.employees VALUES (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400.00, 0.10, 147, 80);
INSERT INTO public.employees VALUES (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200.00, 0.10, 147, 80);
INSERT INTO public.employees VALUES (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500.00, 0.25, 148, 80);
INSERT INTO public.employees VALUES (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000.00, 0.20, 148, 80);
INSERT INTO public.employees VALUES (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600.00, 0.20, 148, 80);
INSERT INTO public.employees VALUES (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400.00, 0.15, 148, 80);
INSERT INTO public.employees VALUES (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300.00, 0.15, 148, 80);
INSERT INTO public.employees VALUES (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100.00, 0.10, 148, 80);
INSERT INTO public.employees VALUES (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000.00, 0.30, 149, 80);
INSERT INTO public.employees VALUES (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800.00, 0.25, 149, 80);
INSERT INTO public.employees VALUES (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600.00, 0.20, 149, 80);
INSERT INTO public.employees VALUES (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400.00, 0.20, 149, 80);
INSERT INTO public.employees VALUES (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000.00, 0.15, 149, NULL);
INSERT INTO public.employees VALUES (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200.00, 0.10, 149, 80);
INSERT INTO public.employees VALUES (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800.00, NULL, 120, 50);
INSERT INTO public.employees VALUES (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000.00, NULL, 121, 50);
INSERT INTO public.employees VALUES (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500.00, NULL, 122, 50);
INSERT INTO public.employees VALUES (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800.00, NULL, 123, 50);
INSERT INTO public.employees VALUES (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600.00, NULL, 124, 50);
INSERT INTO public.employees VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400.00, NULL, 101, 10);
INSERT INTO public.employees VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000.00, NULL, 100, 20);
INSERT INTO public.employees VALUES (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000.00, NULL, 201, 20);
INSERT INTO public.employees VALUES (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500.00, NULL, 101, 40);
INSERT INTO public.employees VALUES (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000.00, NULL, 101, 70);
INSERT INTO public.employees VALUES (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008.00, NULL, 101, 110);
INSERT INTO public.employees VALUES (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300.00, NULL, 205, 110);
INSERT INTO public.employees VALUES (999, 'Dima', 'Degtyarev', 'dvdegtyarev@edu.hse.ru', '515.123.4444', '2003-09-17', 'AD_ASST', 4400.00, NULL, 101, 10);


--
-- TOC entry 3452 (class 0 OID 16867)
-- Dependencies: 276
-- Data for Name: job_history; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.job_history VALUES (102, '2001-01-13', '2006-07-24', 'IT_PROG', 60);
INSERT INTO public.job_history VALUES (101, '1997-09-21', '2001-10-27', 'AC_ACCOUNT', 110);
INSERT INTO public.job_history VALUES (101, '2001-10-28', '2005-03-15', 'AC_MGR', 110);
INSERT INTO public.job_history VALUES (201, '2004-02-17', '2007-12-19', 'MK_REP', 20);
INSERT INTO public.job_history VALUES (114, '2006-03-24', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO public.job_history VALUES (122, '2007-01-01', '2007-12-31', 'ST_CLERK', 50);
INSERT INTO public.job_history VALUES (200, '1995-09-17', '2001-06-17', 'AD_ASST', 90);
INSERT INTO public.job_history VALUES (176, '2006-03-24', '2006-12-31', 'SA_REP', 80);
INSERT INTO public.job_history VALUES (176, '2007-01-01', '2007-12-31', 'SA_MAN', 80);
INSERT INTO public.job_history VALUES (200, '2002-07-01', '2006-12-31', 'AC_ACCOUNT', 90);


--
-- TOC entry 3449 (class 0 OID 16833)
-- Dependencies: 273
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.jobs VALUES ('AD_PRES', 'President', 20080, 40000);
INSERT INTO public.jobs VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO public.jobs VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO public.jobs VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO public.jobs VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO public.jobs VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO public.jobs VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO public.jobs VALUES ('SA_MAN', 'Sales Manager', 10000, 20080);
INSERT INTO public.jobs VALUES ('SA_REP', 'Sales Representative', 6000, 12008);
INSERT INTO public.jobs VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO public.jobs VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO public.jobs VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO public.jobs VALUES ('ST_CLERK', 'Stock Clerk', 2008, 5000);
INSERT INTO public.jobs VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO public.jobs VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO public.jobs VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO public.jobs VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO public.jobs VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO public.jobs VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500);


--
-- TOC entry 3445 (class 0 OID 16811)
-- Dependencies: 269
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.locations VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO public.locations VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO public.locations VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO public.locations VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO public.locations VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO public.locations VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO public.locations VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO public.locations VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO public.locations VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO public.locations VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO public.locations VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
INSERT INTO public.locations VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO public.locations VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO public.locations VALUES (2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
INSERT INTO public.locations VALUES (2400, '8204 Arthur St', NULL, 'London', NULL, 'UK');
INSERT INTO public.locations VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
INSERT INTO public.locations VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO public.locations VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO public.locations VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO public.locations VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO public.locations VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO public.locations VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO public.locations VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');


--
-- TOC entry 3443 (class 0 OID 16796)
-- Dependencies: 267
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.regions VALUES (1, 'Europe');
INSERT INTO public.regions VALUES (2, 'Americas');
INSERT INTO public.regions VALUES (3, 'Asia');
INSERT INTO public.regions VALUES (4, 'Middle East and Africa');


--
-- TOC entry 3453 (class 0 OID 16971)
-- Dependencies: 278
-- Data for Name: t1; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.t1 VALUES (2);
INSERT INTO public.t1 VALUES (3);
INSERT INTO public.t1 VALUES (11);
INSERT INTO public.t1 VALUES (12);
INSERT INTO public.t1 VALUES (13);
INSERT INTO public.t1 VALUES (27);
INSERT INTO public.t1 VALUES (33);
INSERT INTO public.t1 VALUES (34);
INSERT INTO public.t1 VALUES (35);
INSERT INTO public.t1 VALUES (42);


--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 272
-- Name: departments_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.departments_seq', 280, false);


--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 275
-- Name: employees_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employees_seq', 207, false);


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 270
-- Name: locations_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.locations_seq', 3300, false);


--
-- TOC entry 3275 (class 2606 OID 16805)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- TOC entry 3279 (class 2606 OID 16826)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- TOC entry 3283 (class 2606 OID 16845)
-- Name: employees emp_email_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT emp_email_uk UNIQUE (email);


--
-- TOC entry 3285 (class 2606 OID 16843)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3287 (class 2606 OID 16872)
-- Name: job_history job_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_pkey PRIMARY KEY (employee_id, start_date);


--
-- TOC entry 3281 (class 2606 OID 16837)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (job_id);


--
-- TOC entry 3277 (class 2606 OID 16815)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);


--
-- TOC entry 3273 (class 2606 OID 16800)
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- TOC entry 3289 (class 2606 OID 16975)
-- Name: t1 t1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.t1
    ADD CONSTRAINT t1_pkey PRIMARY KEY (col1);


--
-- TOC entry 3290 (class 2606 OID 16806)
-- Name: countries countr_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES public.regions(region_id);


--
-- TOC entry 3292 (class 2606 OID 16827)
-- Name: departments departments_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);


--
-- TOC entry 3293 (class 2606 OID 16888)
-- Name: departments dept_mgr_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES public.employees(employee_id);


--
-- TOC entry 3294 (class 2606 OID 16856)
-- Name: employees emp_manager_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES public.employees(employee_id);


--
-- TOC entry 3295 (class 2606 OID 16851)
-- Name: employees employees_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 3296 (class 2606 OID 16846)
-- Name: employees employees_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- TOC entry 3297 (class 2606 OID 16878)
-- Name: job_history job_history_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 3298 (class 2606 OID 16873)
-- Name: job_history job_history_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- TOC entry 3291 (class 2606 OID 16816)
-- Name: locations loc_c_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES public.countries(country_id);


-- Completed on 2025-11-07 21:25:47

--
-- PostgreSQL database dump complete
--

