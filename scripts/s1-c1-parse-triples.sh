#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

## s0-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE=${INPUT_FILE:0:${#INPUT_FILE}-3}"-s01-c01.nt"


## s1-c1 Substring replacement: URLs
# Run on the command line: $ bash parse-triples.sh freebase-rdf-latest

FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

# single sed substitute operation
sed "s/$FB_NS_URI//g;s/$W3_URI//g;s/$FB_URI//g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE

