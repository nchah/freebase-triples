#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.
# Run on the command line: $ bash parse-triples.sh

## Z commands

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


## s1-c1 Substring replacement: URLs 

FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

sed "s/$FB_NS_URI//g; s/$W3_URI//g; s/$FB_URI//g" freebase-rdf-latest | pv -pterbl -s 425229008315 >freebase-rdf-latest-s01-c01.nt


## s1-c2 Substring replacement: <,> Signs

gsed "s/^<//g; s/\t</\t/g; s/>\t/\t/g" freebase-rdf-latest-s01-c01.nt | pv -pterbl >freebase-rdf-latest-s01-c02.nt




