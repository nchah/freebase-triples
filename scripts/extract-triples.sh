#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

## Z commands

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz


# Pipe the data to another file

# Specifying triples with a specific predicate
# Triples with "name" predicate
zgrep '/type.object.name' -m 1000 freebase-rdf-latest.gz > freebase-triples-names.txt

# Restricting to certain i18n languages
zgrep '/type.object.name.*@en' -m 1000 freebase-rdf-latest.gz > freebase-triples-names-en.txt

# Triples with "description" predicate
zgrep '/common.topic.description' -m 1000 freebase-rdf-latest.gz > freebase-triples-desc.txt









