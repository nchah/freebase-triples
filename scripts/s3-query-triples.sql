#!/usr/bin/sql
# A SQL script to query the Freebase data dumps.

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

-- Ex. Values that have "the" in any position
select * from FB.triples
where triples.obj like '%the%'
limit 5;

/* type */

-- All type triples - further filtered
select * into OUTFILE '/Volumes/Seagate/freebase-rdf-latest-type-s02-c01-v2' 
from triples_type where pred = "</type.object.type>";

-- All distinct type triples
select distinct obj into OUTFILE '/Volumes/Seagate/type-unique-clean.txt' 
from triples_type where pred = "</type.object.type>";

-- All type triples and their counts
select distinct obj, count(*) into OUTFILE '/Volumes/Seagate/type-unique-clean-counts.txt' 
from triples_type where pred = "</type.object.type>" group by obj;

# BASH
# Sort frequency distribution of types in order of magnitude
sort -t$'\t' -k 2,2 -g type-unique-clean-counts.txt >type-unique-clean-counts-byfreq.txt

# Sum the column of type assertion counts
cut -f2 type-unique-clean-counts-byfreq.txt | awk '{s+=$1} END {print s}'
# -> 266321867/3130753066.0 -> 0.08506639

/* name */

-- All name triples - further filtered
select * into OUTFILE '/Volumes/Seagate/freebase-rdf-latest-name-s02-c01-v2' 
from triples_name where pred = "</type.object.name>";

-- All nametriples and their counts by mid
select distinct sub, count(*) into OUTFILE '/Volumes/Seagate/name-unique-counts.txt' 
from triples_name where pred = "</type.object.name>" group by sub;


/* desc */

-- All desc triples - further filtered
select * into OUTFILE '/Volumes/Seagate/freebase-rdf-latest-desc-s02-c01-v2' 
from triples_desc where pred = "</common.topic.description>";


/* akas */

-- All aka triples - further filtered
select * into OUTFILE '/Volumes/Seagate/freebase-rdf-latest-akas-s02-c01-v2' 
from triples_akas where pred = "</common.topic.alias>";



