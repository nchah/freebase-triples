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
OUTPUT_FILE_AKAS=${INPUT_FILE:0:${#INPUT_FILE}-11}"-akas-s02-c01.nt"
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template


## s2-c1 Extract Triples: Name, Description, 
# Specifying triples with specific predicates

# NAME
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</type.object.name>"'\' >$OUTPUT_FILE

# i18n
# Get @en and @en-XX, like @en-GB
cat freebase-rdf-latest-name-s02-c01 | parallel --pipe --block 2M --progress 
grep '@en' >freebase-rdf-latest-name-en-s02-c01
# Get @en only
cat freebase-rdf-latest-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep -E '@en[[:space:]]' >freebase-rdf-latest-desc-en-s02-c01

# DESC
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</common.topic.description>"'\' >$OUTPUT_FILE

# i18n
# Get @en and @en-XX, like @en-GB
cat freebase-rdf-latest-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep '@en' >freebase-rdf-latest-desc-en-s02-c01
# Get @en only
cat freebase-rdf-latest-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep -E '@en[[:space:]]' >freebase-rdf-latest-desc-en-s02-c01

# TYPE
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</type.object.type>"'\' >$OUTPUT_FILE

# AKAS
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</common.topic.alias>"'\' >$OUTPUT_FILE

# KEYS
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</type.object.key>"'\' >$OUTPUT_FILE


## Updates:

# v1.0: grep Implementation
# NAME
# v1.0: grep '/type\.object\.name' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_NAME_ALL
# i18n
# Get @en and @en-XX, like @en-GB
# v1.0: grep '@en' $INPUT_FILE_NAME_ALL | pv -pterbl >$OUTPUT_FILE_NAME_EN
# Get @en only
# v1.0: grep -E '@en[[:space:]]' $INPUT_FILE_NAME_ALL | pv -pterbl >$OUTPUT_FILE_NAME_EN
# DESC
# v1.0: grep '/common\.topic\.description' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_DESC_ALL
# TYPE
# v1.0: grep '/type\.object\.type' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_TYPE
# AKAS
# v1.0: grep '/common\.topic\.alias' $INPUT_FILE | pv -pterbl >$OUTPUT_FILE_AKAS

# v2.0: GNU parallel implementation
# Template:
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
grep -E '@en[[:space:]]' >$OUTPUT_FILE
# Extracting @en only
cat freebase-rdf-latest-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep -E '@en[[:space:]]' >freebase-rdf-latest-desc-en-s02-c01

# v3.0: AWK implementation
# Template:
awk '$2 == "</type.object.name>"' $INPUT_FILE  >$OUTPUT_FILE
# with parallel
# the \' is necessary for parallel context
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''$2 == "</pred>"'\' >$OUTPUT_FILE


## s2-c2 Extract Unique

# Unique predicates
# "tab" character as delimiter
awk -F"\t" '!seen[$2]++' "file"

# Sort unique
# -t $'\t' to catch the Tab character
# -k to get the column positions
sort -u -t$'\t' -k 2,2 "/path/to/file"

# Sort frequency distribution of types in order of magnitude
sort -t$'\t' -k 2,2 -g type-unique-clean-counts.txt >type-unique-clean-counts-byfreq.txt

# Sum the column of type assertion counts
cut -f2 types-unique-clean-counts-byfreq.txt | awk '{s+=$1} END {print s}'
# -> 266321867/3130753066.0 -> 0.08506639





