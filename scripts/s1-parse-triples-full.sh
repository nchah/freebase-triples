#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

########## ########## ########## ########## ##########
## Z Commands Overview
########## ########## ########## ########## ##########

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


########## ########## ########## ########## ##########
## Stages and Changes
########## ########## ########## ########## ##########

## s0-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE_S01_C01=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c01.nt"
OUTPUT_FILE_S01_C02=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c02.nt"
OUTPUT_FILE_S01_C03=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c03.nt"


## s1-c1 Substring replacement: URLs 

FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

sed "s/$FB_NS_URI//g; s/$W3_URI//g; s/$FB_URI//g" $INPUT_FILE | pv -pterbl -s 425229008315 >$OUTPUT_FILE_S01_C01


## s1-c2 Substring replacement: <,> Signs

# [DEPRECATED] single sed substitute operation
# [DEPRECATED] sed "s/<//g; s/>//g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE

# Running with GNU sed ($ gsed) since OS X sed doesn't handle '\t' tab chars
# - 1st sub: targets the leading "<" char on each line
# - 2nd sub: targets leading "<", with a leading tab
# - 3rd sub: targets trailing ">" char, accurately found as its tab separated
gsed "s/^<//g; s/\t</\t/g; s/>\t/\t/g" $OUTPUT_FILE_S01_C01 | pv -pterbl >$OUTPUT_FILE_S01_C02


## s1-c3 Substring replacement: Schema IDs /.. to ///

sed "s/\./\//g" $OUTPUT_FILE_S01_C02 | pv -pterbl >$OUTPUT_FILE_S01_C03 # TODO: better regex with gsed



