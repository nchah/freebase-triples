#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.
# Run on the command line: $ bash parse-triples.sh

## s1-c1 Substring replacement: URLs 

FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

sed "s/$FB_NS_URI//g;s/$W3_URI//g;s/$FB_URI//g" freebase-rdf-latest | pv -pterb -s 425229008315 >freebase-rdf-latest-s01-c01.nt

## s1-c2 Substring replacement: <,> Signs

sed "s/<//g;s/>//g" freebase-rdf-latest-s01-c01.nt | pv -pterb >freebase-rdf-latest-s01-c02.nt





