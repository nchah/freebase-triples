# CHANGELOG
Overview of the full pipeline.

# Scripts

```
├── s1-c1-parse-triples.sh
├── s1-c2-parse-triples.sh
├── s1-c3-parse-triples.sh
├── s1-parse-triples-full.sh
└── s2-c1-extract-triples.sh
```

# Data

Organizing the files as if running $ tree command:
```
Original: freebase-rdf-latest.gz
.
└── freebase-rdf-latest
    # *[10K Samples - GitHub]*
    ├── fb-rdf-10k-head.nt
        ├── fb-rdf-10k-head-s01-c01.nt
        ├── fb-rdf-10k-head-s01-c02.nt
        └── fb-rdf-10k-head-s01-c03.nt
            └── fb-rdf-10k-head-desc-all-s02-c01.nt
                └── fb-rdf-10k-head-desc-en-s02-c01.nt
            └── fb-rdf-10k-head-name-all-s02-c01.nt
                └── fb-rdf-10k-head-name-en-s02-c01.nt
            └── fb-rdf-10k-head-type-s02-c01.nt
    ├── fb-rdf-10k-tail-s01-c01.nt
    ├── fb-rdf-10k-desc-all-s01-c01.nt
    ├── fb-rdf-10k-names-en-s01-c01.nt
    ├── fb-rdf-10k-names-all-s01-c01.nt
    # *[All Data - External Drive]*
    ├── freebase-rdf-latest-s01-c01
    ├── freebase-rdf-latest-s01-c02
    └── freebase-rdf-latest-s01-c03
        └── freebase-rdf-latest-desc-all-s02-c01
            ├── freebase-rdf-latest-desc-all-s02-c01
            └── freebase-rdf-latest-desc-[ISO lang...]-s02-c01
        └── freebase-rdf-latest-name-all-s02-c01
            ├── freebase-rdf-latest-name-all-s02-c01
            └── freebase-rdf-latest-desc-[ISO lang...]-s02-c01
        └── freebase-rdf-latest-type-all-s02-c01
            └── freebase-rdf-latest-type-[type...]-s02-c01


```
