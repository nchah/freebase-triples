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

## s2-c0 Setting File Names
INPUT_FILE=$1

OUTPUT_FILE_NAME_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-en-s02-c01.nt"
OUTPUT_FILE_NAME_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-all-s02-c01.nt"
OUTPUT_FILE_DESC_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-en-s02-c01.nt"
OUTPUT_FILE_DESC_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-all-s02-c01.nt"
OUTPUT_FILE_TYPE=${INPUT_FILE:0:${#INPUT_FILE}-11}"-type-s02-c01.nt"
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template


## s2-c1 Extract Triples: Name, Description, 
# Specifying triples with specific predicates

# Triples with "name" predicate
grep '/type.object.name' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_NAME_ALL

# Restricting to certain i18n languages
grep '/type.object.name.*@en' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_NAME_EN

# Triples with "description" predicate
grep '/common.topic.description' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_DESC_ALL

# Restricting to certain i18n languages
grep '/common.topic.description.*@en' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_DESC_EN

# Triples with the "type" predicate
grep '/type.object.type' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_TYPE


# Testing out GNU parallels

parallel --j 4 --progress grep '@en' >freebase-rdf-latest-name-en-s02-c02 ::: freebase-rdf-latest-name-s02-c01

parallel --j 4 --progress grep '@en' >freebase-rdf-latest-desc-en-s02-c02 ::: freebase-rdf-latest-desc-s02-c01





