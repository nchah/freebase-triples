# freebase-triples

This repository contains Bash and Python code to process the Freebase RDF triples data dumps.
Portions of this README document steps to clean and analyze the Freebase data dumps.


## Citation

The accompanying paper is available at [arXiv](https://arxiv.org/abs/1712.08707).

BibTeX entry for citation:

```
@article{chah2017freebase,
  title={Freebase-triples: A Methodology for Processing the Freebase Data Dumps},
  author={Chah, Niel},
  journal={arXiv preprint arXiv:1712.08707},
  year={2017}
}
```

The code is archived with a DOI on Zenodo: [![DOI](https://zenodo.org/badge/60580082.svg)](https://zenodo.org/badge/latestdoi/60580082)

`Niel Chah. (2017, November 10). nchah/freebase-triples v1.1.0 (Version v1.1.0). Zenodo. http://doi.org/10.5281/zenodo.1045306`


## Table of Contents

  * [Background](#background)
     * [Freebase](#freebase)
     * [Freebase Data Dumps](#freebase-data-dumps)
  * [In This Repository](#in-this-repository)
     * [Directory](#directory)
     * [Scripts](#scripts)
  * [ETL Changes](#etl-changes)
     * [Tasks](#tasks)
  * [Sample Analysis](#sample-analysis)
     * [Cayley](#cayley)
  * [License](#license)
  * [Sources](#sources)
     * [Announcements Timeline](#announcements-timeline)
     * [Freebase](#freebase-1)
     * [Google Developers Resources](#google-developers-resources)

## Background

### Freebase

The [Freebase](https://en.wikipedia.org/wiki/Freebase) Wikipedia article provides a good overview of the knowledge base's nearly decade-long lifetime from its beginnings at Metaweb Technologies, Inc. in 2007, its acquisition by Google in 2010, and its eventual shutdown and move to Wikidata towards 2015-2016. 
Freebase data could be accessed through the Freebase API and the online Query Editor.
At the time, queries were written in the Metaweb Query Language (MQL).

Although the shutdown of freebase.com was set for as early as June 30, 2015 according to this initial [Google+ post](https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc), the actual website was still accessible for quite a long time. 
On May 2, 2016, freebase.com was finally closed off as announced in this [Google Group post](https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ).
The freebase.com link now redirects to the Google Developers page for the remaining Freebase triples data dumps.

A screenshot of freebase.com on May 2, 2016 before it was shut down.
![freebase.com screenshot](https://github.com/nchah/freebase-triples/blob/master/images/screenshot-freebase-com.png)

### Freebase Data Dumps

A data dump of 1.9 billion Freebase Triples in [N-Triples RDF](https://www.w3.org/TR/rdf-testcases/#ntriples) format is available on the [developers page](https://developers.google.com/freebase/#freebase-rdf-dumps) under the [CC-BY](http://creativecommons.org/licenses/by/2.5/) license.
The [freebase.com](http://freebase.com) URL also redirects to this page following its shutdown. 
The Developers page lists the file as 22 GB gzip compressed and 250 GB uncompressed, although a recent download exceeds this file size (a May 2016 download amounted to >30 GB compressed and >400 GB uncompressed). 

Examining the compressed data with Z commands on the command-line:

```
$ # Scan through the data with zmore or zless
$ zmore freebase-rdf-latest.gz

<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/type.property>      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.object.name>   "footballdb ID"@en      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.unique>       "true"  .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.expected_type>        <http://rdf.freebase.com/ns/type.enumeration>   .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://www.w3.org/2000/01/rdf-schema#label>    "footballdb ID"@en      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.schema>       <http://rdf.freebase.com/ns/american_football.football_player>  .
```

You can also grep it:

```
$ zgrep '/ns/film.film>' -m 5 freebase-rdf-latest.gz

<http://rdf.freebase.com/ns/film.film_song_relationship.film>   <http://rdf.freebase.com/ns/type.property.expected_type>    <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/film.film_song_relationship.film>   <http://www.w3.org/2000/01/rdf-schema#range>    <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.112ygbz6_>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.112ygbz6_>    <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.113qbnjlk>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
```

Each triple is encoded in the aforementioned N-Triples format. 
The subject, predicate, and object values on each line are "< >" enclosed and tab separated. 
Each line terminates with a "." and a newline. 

Viewing this with `vim`, using `:set list` to show these hidden characters:

```
</american_football.football_player.footballdb_id>^I</type.object.name>^I"footballdb ID"@en^I.$
</astronomy.astronomical_observatory.discoveries>^I</type.object.name>^I"Discoveries"@en^I.$
</automotive.body_style.fuel_tank_capacity>^I</type.object.name>^I"Fuel Tank Capacity"@en^I.$
</automotive.engine.engine_type>^I</type.object.name>^I"Engine Type"@en^I.$
</automotive.trim_level.max_passengers>^I</type.object.name>^I"Maximum Number of Passengers"@en^I.$
```


## In This Repository

### Directory

An overview of the directory structure.
```
$ tree
.
├── README.md
├── data
│   └── schema
│       ├── fb-rdf-pred-schema-domains-ids-1-byalpha-desc
│       ├── fb-rdf-pred-schema-domains-ids-1-byalpha-typeinfo
│       ├── fb-rdf-pred-schema-properties-ids-1-byalpha-desc
│       ├── fb-rdf-pred-schema-properties-ids-1-byalpha-typeinfo
│       ├── fb-rdf-pred-schema-types-ids-1-byalpha-desc
│       ├── fb-rdf-pred-schema-types-ids-1-byalpha-typeinfo
│       ├── unique-predicates-sorted
│       └── unique-types-sorted-and-counts
├── images
│   ├── screenshot-cayley-visualization.png
│   └── screenshot-freebase-com.png
└── scripts
    ├── python
    │   ├── queries
    │   │   ├── queries-common--properties
    │   │   ├── queries-common--types
    │   │   ├── queries-schema-for-domains-types-properties
    │   │   ├── queries-slices-for-all-domains
    │   │   ├── queries-type--properties
    │   │   └── queries-type--types
    │   ├── s2-c1-extract-triples.py
    │   ├── s2-c2-extract-schema.py
    │   ├── s2-c3-extract-schema-ids.py
    │   ├── s2-c4-extract-schema-desc.py
    │   ├── s2-c5-extract-schema-typeinfo.py
    │   └── s2-c6-extract-merge-triples.py
    └─── shell
        ├── s0-run-parse-extract-triples.sh
        ├── s1-parse-triples.sh
        ├── s2-extract-triples.sh
        └── s3-query-triples.sh
```

### Scripts

**Languages**

The scripts in this repo are written in Bash and Python.
Each script is named and ordered to reflect the ETL stages outlined here.
Bash/Shell scripts handled the initial parsing stages for the massive data dumps. 
Python, with its many libraries, is ideal to use after the initial processing.

- `Bash` commands used: `awk`, `cat`, `cut`, `grep`, `gsed`*, `less`, `more`, `parallel`, `pv`, `sed`, `sort`, `wc`, `zless`, `zmore`, `zgrep`

*`gsed` is GNU sed. macOS's `sed` does not handle '\t' as tab characters so gsed is preferred in some instances.

**Operating Scripts**

Pausing a job on the command line can be done with `CTRL+Z`.
All stopped and background jobs can be listed with the `jobs` command.
To bring background jobs back into the foreground, use `fg [job]`.
Unless specified differently, scripts were run on a MacBook Pro (Early 2015, 2.7 GHz Intel Core i5, 8 GB memory).


## ETL Changes

[ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load) refers to the extraction, transformation, and loading of large datasets in the data science field. 
This section tracks the ETL changes that can be applied to the triples data.

The data dumps encode Freebase data in a few ways that are different from the usual usage on Freebase.com. 

- Notes:
    - "/" is replaced by "." for topic mids and domains/types/properties (e.g. /m.abcdef or /film.film instead of /m/abcdef or /film/film).
    - URLs to freebase.com or w3.org are used, not just the Freebase mids. All freebase.com addresses no longer work following the site shutdown but remain in the data dump as unique identifiers.
    - A mix of freebase.com and w3.org schemas are used, especially as predicates in the triples.
    - There are over 1.9 billion triples and thus the same amount of lines in the entire data dump.
    - The triples are already sorted alphabetically in some columns, but this is applied either inconsistently or according to a pattern that needs to be discovered.
    - Unique identifiers are enclosed in "<,>". Strings are written in the format: "string"@language_namespace. 

### Tasks 

1. Simplifying Data
    - `[s1-c1]` - Convert N-Triples [(Wikipedia)](https://en.wikipedia.org/wiki/N-Triples) format to a leaner format. Working with the full URIs conforms to the standard, but can be unwieldy to use for this project.
    - `[s1-c2]` - Removing the "< >" format enclosing each value.
    - `[s1-c3]` - Convert "." back to "/" in the domain, type, and property schemas to return a more Freebase-like format (e.g. "/award/award_winner" for the type).
2. Slicing Data
    - `[s2-c1]` - Create predicate-based slices for each domain, type, and property. 
    - `[s2-c2, 3, 4, 5]` - Extract data on the schema (ontology) from the slices.
    - `[s2-c6]` - Extract and merge a slice's data concerning a domain(s) with other slices, like `name`, `desc`, etc.
3. Querying Data
    - `[s3-c1]` - Query triples by specific prediciates, by domain, or other criteria of interest.
    - `[s3-c2]` - Obtain analytics/statistics on the data distribution, shape of the data, etc.
    - `[s3-c3]` - Merge data together to understand a specific domain, object, etc.
4. Interpreting/Visualizing Data
    - Possible tools include:
        - [Cayley](https://github.com/cayleygraph/cayley)
        - [Gephi](https://en.wikipedia.org/wiki/Gephi)
        - [Neo4j](https://en.wikipedia.org/wiki/Neo4j)


## Sample Analysis

### Cayley

Once the data is cleaned and ready, the Cayley graph database and platform can be used to analyze triples data. 
Cayley is an open-source graph database that draws on Freebase and the Knowledge Graph. 
It is maintained at [cayleygraph/cayley](https://github.com/cayleygraph/cayley).

A Gremlin query using the Cayley Visualize function in the browser:
```
$ # On the command line:
$ ./cayley http --dbpath=data/testdata.nq

> // Running Cayley in the browser locally
> // Visualizing instances of /award/award_winner
> // Set GetLimit() as getting All() creates a large cluster of thousands of nodes
> g.V("/award.award_winner").Tag("source").Out("/type.type.instance").Tag("target").GetLimit(10)
```

![Cayley visualization screenshot](https://github.com/nchah/freebase-triples/blob/master/images/screenshot-cayley-visualization.png)


## License

Freebase data is licensed under the [CC-BY](http://creativecommons.org/licenses/by/2.5/) license. 
The Freebase API also has additional [Terms and Conditions](https://developers.google.com/freebase/terms#license). 


## Sources

Some sources may no longer be available following the deprecation of the Freebase API on June 30, 2015.

### Announcements Timeline

Many Freebase and Knowledge Graph related updates are posted on the once active [freebase-discuss](https://groups.google.com/forum/#!forum/freebase-discuss) Google Group and the [Google+](https://plus.google.com/u/0/109936836907132434202/posts) community.

- Jul 16, 2010 - Freebase joining Google ([freebase-discuss](https://groups.google.com/d/msg/freebase-discuss/NkCF1DayKzA/QQufQ9gDwBsJ))
- Dec 16, 2014 - timeline for Freebase sunsetting announced ([Google+ archive link](https://web.archive.org/web/20190206213838/https://plus.google.com/109936836907132434202/posts/bu3z2wVqcQc)) and ([freebase-discuss](https://groups.google.com/d/msg/freebase-discuss/s_BPoL92edc/Y585r7_2E1YJ))
- Mar 26, 2015 - details on Wikidata and new KG API projected ([Google+ archive link](https://web.archive.org/web/20190206213923/https://plus.google.com/109936836907132434202/posts/3aYFVNf92A1))
- Sep 28, 2015 - short update on KG API ([Google+ archive link](https://web.archive.org/web/20190206214155/https://plus.google.com/109936836907132434202/posts/JntBzAinjRr))
- Dec 16, 2015 - KG Search API released ([Google+ archive link](https://web.archive.org/web/20190206214009/https://plus.google.com/109936836907132434202/posts/iY8NZGFF6DN))
- Jan 28, 2016 - KG Search Widget released ([Google+ archive link](https://web.archive.org/web/20190206214059/https://plus.google.com/109936836907132434202/posts/MCKpjUpx1H1))
- May 02, 2016 - Freebase.com shutdown ([freebase-discuss](https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ))

### Freebase

- Bollacker, K., Evans, C., Paritosh, P., Sturge, T., & Taylor, J. (2008, June). Freebase: a collaboratively created graph database for structuring human knowledge. In Proceedings of the 2008 ACM SIGMOD international conference on Management of data (pp. 1247-1250). AcM.
- Google, Freebase Data Dumps, https://developers.google.com/freebase/data, August 15, 2017.

### Google Developers Resources

**Freebase API**

- https://developers.google.com/freebase/
- https://developers.google.com/freebase/mql/

**Knowledge Graph Search API**

- [Google+ archive link](https://web.archive.org/web/20190206214009/https://plus.google.com/109936836907132434202/posts/iY8NZGFF6DN) (released on Dec 16, 2015)
- https://developers.google.com/knowledge-graph/

