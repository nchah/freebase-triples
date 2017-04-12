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

OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template
OUTPUT_FILE_=${INPUT_FILE:0:${#INPUT_FILE}-11}"--s02-c01.nt"  # template


## s3-c1 Query Triples:

# Specific topic mid
cat freebase-rdf-latest-type-s02-c01 | parallel --pipe --block 2M --progress 
grep -E "\</m.02mjmr\>" >test.txt



## s3-c2 Analytics

# All Slices
# Returns a long list of number of triples
wc -l fb-rdf-pred-*


# Slice Level Analytics
# Example slice: fb-rdf-pred-bicycles

# Number of  triples
wc -l fb-rdf-pred-bicycles
# -> 313

# Unique SPO counts
# Sub
awk -F"\t" '!seen[$1]++ { print $1 }' fb-rdf-pred-bicycles | wc -l
# -> 166

# Pred
awk -F"\t" '!seen[$2]++ { print $2 }' fb-rdf-pred-bicycles | wc -l
# -> 5  # this should be quite low as it ~= the domain properties

# Obj
awk -F"\t" '!seen[$3]++ { print $3 }' fb-rdf-pred-bicycles | wc -l
# -> 170


# Browse Data

# Scroll up and down!
less fb-rdf-pred-bicycles








