#!/usr/bin/sql
# A SQL script to parse, process, clean the Freebase data dumps.

/* * * * * * * * * * * * * * * * * * * *
 * SET UP
 * * * * * * * * * * * * * * * * * * * */

-- Create database if none exists
create database FB;

-- Select database
use FB;

-- Create tables
create table triples_name (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

create table triples_name_en (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

create table triples_name_en_GB (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

create table triples_desc (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

create table triples_desc_en (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

create table triples_type (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

-- Show and describe table
show tables;
describe FB.triples;

-- Load triples
-- docs: https://dev.mysql.com/doc/refman/5.7/en/load-data.html
LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-name-s02-c01'
INTO TABLE FB.triples_name
FIELDS terminated by '\t'
LINES terminated by '.\n';  /* this catches the "." delimiter */

LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-name-en-s02-c01'
INTO TABLE FB.triples_name_en
FIELDS terminated by '\t'
LINES terminated by '.\n';

LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-name-en-GB-s02-c01'
INTO TABLE FB.triples_name_en_GB
FIELDS terminated by '\t'
LINES terminated by '.\n';

LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-desc-s02-c01'
INTO TABLE FB.triples_desc
FIELDS terminated by '\t'
LINES terminated by '.\n';

LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-desc-en-s02-c01'
INTO TABLE FB.triples_desc_en
FIELDS terminated by '\t'
LINES terminated by '.\n';

LOAD DATA LOCAL INFILE '/Volumes/Seagate/freebase-rdf-latest-type-s02-c01'
INTO TABLE FB.triples_type
FIELDS terminated by '\t'
LINES terminated by '.\n';

-- Delete rows without dropping table
-- delete from FB.triples;


/* * * * * * * * * * * * * * * * * * * *
 * QUERY
 * * * * * * * * * * * * * * * * * * * */

/* Query with LIKE */

-- Values that have "the" in any position
select * from FB.triples
where triples.obj like '%the%'
limit 5;


-- All type triples
select distinct obj into OUTFILE '/Volumes/Seagate/types-unique2.txt' from triples_type where pred = "</type.object.type>";















