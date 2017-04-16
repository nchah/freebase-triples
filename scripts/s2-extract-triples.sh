#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.


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
awk \''{ fname = "fb-rdf-name-s02-c01"; fname_rest = "fb-rdf-rest-01";
if($2 == "</type.object.name>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# DESC
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-rdf-desc-s02-c01"; fname_rest = "fb-rdf-rest-02";
if($2 == "</common.topic.description")
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# TYPE
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-rdf-type-s02-c01"; fname_rest = "fb-rdf-rest-03";
if($2 == "</type.object.type>")
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# AKAS
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{fname = "fb-rdf-akas-s02-c01"; fname_rest = "fb-rdf-rest-04";
if($2 == "</common.topic.alias>")
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# KEYS
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-rdf-keys-s02-c01"; fname_rest = "fb-rdf-rest-05";
if($2 == "</type.object.key>")
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# template
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ if($2 == "</type.object.key>")
fname = "fb-rdf-keys-s02-c01"; fname_rest = "fb-rdf-rest-05";
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'


# LANG NS: i18n
# Get @en and @en-XX, like @en-GB
cat fb-rdf-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep '@en' >fb-rdf-desc-en-s02-c01
# Get @en only
cat fb-rdf-desc-s02-c01 | parallel --pipe --block 2M --progress 
grep -E '@en[[:space:]]' >fb-rdf-desc-en-s02-c01



## s2-c2 Extract Unique Values and Their Counts

# Unique predicates
# Not parallelizing is better for output script
awk -F"\t" '!seen[$2]++ { print $2 }' fb-rdf-s01-c01 
>fb-scm-pred-uniq-s02-c02
# Sort by alpha:
sort -u fb-scm-pred-uniq-s02-c02 >fb-scm-pred-uniq-byalpha-s02-c02
# Count
wc -l fb-scm-pred-uniq-s02-c02

# Sort unique
# -t $'\t' to catch the Tab character
# -k to get the column positions
sort -u -t$'\t' -k 2,2 "/path/to/file"

# Sort frequency distribution of types in order of magnitude
# Default is that list is already sorted byalpha
sort -t$'\t' -k 2,2 -g fb-scm-type-uniq-byalpha-counts-s02-c02
>fb-scm-type-uniq-byfreq-counts-s02-c02

# Sum the column of type assertion counts
cut -f2 fb-scm-type-uniq-byfreq-counts-s02-c02 | awk '{s+=$1} END {print s}'
# -> 266321867/3130753066.0 -> 0.08506639


# Unique MIDs
# Not parallelizing is better for output script
awk -F"\t" '!seen[$1]++ { print $1 }' fb-rdf-name-s01-c01 
>fb-scm-name-uniq-mids-s02-c02
# Sort by alpha:
# Note: data may already be in alphabetical order
sort -u fb-scm-name-uniq-mids-s02-c02 >fb-scm-name-uniq-mids-byalpha-s02-c02
# Count
wc -l fb-scm-name-uniq-mids-s02-c02



## s2-c3 Extract Schema

# Domains
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-domn-s02-c03"; fname_rest = "fb-rdf-rest-05";
if($3 == "</type.domain>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# The types in a domain:
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-domn-type-s02-c03"; fname_rest = "fb-rdf-rest-06";
if($2 == "</type.domain.types>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# Or get domains from the uniq predicates:
sort -u | awk -F. '$1 { print $1}' fb-scm-pred-uniq-byalpha-s02-c02
>fb-scm-domn-uniq-byalpha-s02-c02
# Clean up the base and key predicates
sort -u fb-scm-pred-uniq-byalpha-s02-c02 >fb-scm-pred-uniq-byalpha-s02-c03
# Further get rid of the '</key/* >' duplicates
awk '$1 !~ "/key/*"' fb-scm-domn-uniq-byalpha-s02-c03 >fb-scm-domn-uniq-byalpha-s02-c04


# Types
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-type-s02-c03"; fname_rest = "fb-rdf-rest-07";
if($3 == "</type.type>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# The properties in a type:
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-type-s02-c03"; fname_rest = "fb-rdf-rest-08";
if($2 == "</type.type.properties>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# Properties
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-prop-s02-c03"; fname_rest = "fb-rdf-rest-09";
if($3 == "</type.property>") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'

# The details in a property:
cat $INPUT_FILE | parallel --pipe --block 2M --progress 
awk \''{ fname = "fb-scm-prop-dets-s02-c03"; fname_rest = "fb-rdf-rest-10";
if($2 ~ "</type.property.*") 
{ print $0 >> fname; close(fname); } 
else { print $0 >> fname_rest; close(fname_rest); } }'\'


# Predicates
# Counts of all domain-sliced predicates
cat fb-rdf-s01-c01-test4 | parallel --pipe --block 2M --progress 
awk -F"\t" \'' { q = "</type.*"; if($2 ~ q) { count++; }} END {print q"\t"count} '\' >>test














