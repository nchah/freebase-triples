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

## s3-c0 Setting File Names
INPUT_FILE=$1

OUTPUT_FILE_NAME_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-en-s02-c01.nt"
OUTPUT_FILE_NAME_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-name-all-s02-c01.nt"
OUTPUT_FILE_DESC_EN=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-en-s02-c01.nt"
OUTPUT_FILE_DESC_ALL=${INPUT_FILE:0:${#INPUT_FILE}-11}"-desc-all-s02-c01.nt"
OUTPUT_FILE_TYPE=${INPUT_FILE:0:${#INPUT_FILE}-11}"-type-s02-c01.nt"
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template


## s3-c1 Query Triples:

# Specific topic mid
cat freebase-rdf-latest-type-s02-c01 | parallel --pipe --block 2M --progress  grep -E "\</m.02mjmr\>" >test.txt


# Sort frequency distribution of types in order of magnitude
sort -t$'\t' -k 2,2 -g types-unique-clean-counts.txt >types-unique-clean-counts-byfreq.txt





