#!/usr/bin/env python3
# Use Python 3 for the Unicode support


# An example to parse the names triples sample file
triples = open("data/fb-triples-10k-names-all-v2-c1.txt").readlines()

print("Length of triples: " + str(len(triples)))  # 10000
print("triple1: " + triples[0])  # '</astronomy.astronomical_observatory.discoveries>\t</type.object.name>\t"Discoveries"@en\t.\n'

triple1 = triples[0].split("\t")
print("triple1 (split): " + str(triple1))  # ['</astronomy.astronomical_observatory.discoveries>', '</type.object.name>', '"Discoveries"@en', '.\n']


