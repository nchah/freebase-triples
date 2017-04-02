#!/usr/bin/sql
# A SQL script to parse, process, clean the Freebase data dumps.

/* * * * * * * * * * * * * * * * * * * *
 * SET UP
 * * * * * * * * * * * * * * * * * * * */

/* Create database if none exists */
create database FB;

/* Select database*/
use FB;

/* Create table */
create table triples (
    sub varchar(255),
    pred varchar(255),
    obj varchar(255)
);

/* Show and describe table */
show tables;
describe FB.triples;

/* Load triples */
LOAD DATA LOCAL INFILE '/path/to/file'
INTO TABLE FB.triples
FIELDS terminated by '\t'
LINES terminated by '\n';

/* Delete rows without dropping table */
delete from FB.triples;


/* * * * * * * * * * * * * * * * * * * *
 * QUERY
 * * * * * * * * * * * * * * * * * * * */

/* Query with LIKE */

/* Values that have "the" in any position */
select * from FB.triples
where triples.obj like '%the%'
limit 5;















