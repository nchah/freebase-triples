#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

########## ########## ########## ########## ##########
## Stages and Changes
########## ########## ########## ########## ##########

## s1-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c03.nt"


## s1-c1 Substring replacement: URLs

#FB_URI='http:\/\/rdf.freebase.com'
#FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
#W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

# single sed substitute operation
#sed "s/$FB_NS_URI//g; s/$W3_URI//g; s/$FB_URI//g" $1 | pv -pterbl >"$1-c1.nt"


## s1-c2 Substring replacement: <,> Signs

# [DEPRECATED] single sed substitute operation
# [DEPRECATED] sed "s/<//g; s/>//g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE

# Running with GNU sed ($ gsed) since OS X sed doesn't handle '\t' tab chars
# - 1st sub: targets the leading "<" char on each line
# - 2nd sub: targets leading "<", with a leading tab
# - 3rd sub: targets trailing ">" char, accurately found as its tab separated
#gsed "s/^<//g; s/\t</\t/g; s/>\t/\t/g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE


## s1-c3 Substring replacement: Schema IDs /.. to ///

sed "s/\./\//g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE # TODO: better regex with gsed



