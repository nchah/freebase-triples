# freebase-triples

A repository to document a project to clean and analyze the Freebase data dumps.

## Table of Contents

 * [Background](#background)
    * [Freebase](#freebase)
    * [Freebase Data Dumps](#freebase-data-dumps)
 * [This Repository](#this-repository)
    * [Directory](#directory)
    * [Scripts](#scripts)
    * [Data](#data)
    * [Computing Resources](#computing-resources)
 * [ETL Changes](#etl-changes)
    * [Tasks](#tasks)
 * [Analysis](#analysis)
    * [Cayley](#cayley)
 * [License](#license)
 * [Sources](#sources)
    * [Announcements Timeline](#announcements-timeline)
    * [Freebase](#freebase-1)
    * [Knowledge Graph](#knowledge-graph)
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

Examining the compressed data with Z commands on the terminal:

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
$ zgrep '/ns/film.film>' -m 10 freebase-rdf-latest.gz

<http://rdf.freebase.com/ns/film.film_song_relationship.film>   <http://rdf.freebase.com/ns/type.property.expected_type>    <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/film.film_song_relationship.film>   <http://www.w3.org/2000/01/rdf-schema#range>    <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.112ygbz6_>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.112ygbz6_>    <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.113qbnjlk>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.113qbnjlk>    <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.119pgc86w>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.119pgc86w>    <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.119pgkfwp>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/film.film>  .
<http://rdf.freebase.com/ns/g.119pgkfwp>    <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>   <http://rdf.freebase.com/ns/film.film>  .
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


## This Repository

### Directory

An overview of the directory structure.
```
$ tree
.
├── README.md
├── data
│   ├── fb-rdf-10k-head-s01-c01.nt
│   ├── fb-rdf-10k-head-s01-c02.nt
│   ├── fb-rdf-10k-head-s01-c03.nt
│   ├── fb-rdf-10k-head.nt
│   ├── fb-rdf-10k-...
│   └── ... additional files
├── documents
│   └── mql-reference-guide.pdf
├── images
│   ├── Freebase_Logo_optimised.svg
│   ├── screenshot-cayley-visualization.png
│   └── screenshot-freebase-com.png
└── scripts
    ├── s1-c1-parse-triples.sh
    ├── s1-c2-parse-triples.sh
    ├── s1-c3-parse-triples.sh
    ├── s1-parse-triples-full.sh
    └── s2-c1-extract-triples.sh
```

### Scripts

The scripts in this repo are mostly written in Bash and Python. 
Bash/Shell scripts handled the initial parsing stages for the massive data dumps. 
Python, with its many libraries, is a simple way to use the triples data after the initial processing.

- `Bash` commands used: `awk`, `cat`, `cut`, `grep`, `gsed`*, `less`, `more`, `parallel`, `pv`, `sed`, `sort`, `wc`, `zless`, `zmore`, `zgrep`
- `Python` libraries: TBA

*`gsed` is GNU sed. Mac/OS X's `sed` does not handle '\t' as tab characters so gsed is preferred in some instances.

#### Command Line Usage

**Operating Scripts**

Pausing a job on the command line can be done with `CTRL+Z`.
All stopped and background jobs can be listed with the `jobs` command.
To bring background jobs back into the foreground, use `fg [job]`.


### Data

The original files are extremely large and cannot be stored on GitHub. 
Only a small sample of the output files are included here. 
For consistency, output data is named according t the script used to process it (sX-cX for stage and change versions respectively).

### Computing Resources

Unless specified differently, the scripts that were run "locally" indicates a MacBook Pro (Early 2015, 2.7 GHz Intel Core i5, 8 GB memory) was used.


## ETL Changes

[ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load) refers to the extraction, transformation, and loading of large datasets in the data science field. 
Similarly, this section tracks the changes made to the raw triples data dump to ease processing.

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
    - `[s1-c1]` - Convert N-Triples [(Wikipedia)](https://en.wikipedia.org/wiki/N-Triples) format to N3 [(Wikipedia)](https://en.wikipedia.org/wiki/Notation3) or other format?? Working with the full URIs conforms to the standard, but can be unwieldy to use for this project. Removing "http://rdf.freebase.com/*", "http://www.w3.org/*" with Regular Expressions for now.
        - Running on a head sample of 10k triples shows the following diffs in file size. The file size reduction where ~43% of the original is preserved looks promising.
        ```
        # Test Files:
        Original:   fb-triples-10k-head.nt - 1368687 Bytes
        s1-c1:      fb-triples-10k-head-s1-c1.nt - 589935 Bytes (43.1%)
        s1-c2:      fb-triples-10k-head-s1-c2.nt - 589111 Bytes (43.0%)
        ```
        - Adding pv to display a progress bar.
        ```
        $ bash parse-triples-pv.sh
        xxB 0:00:00 [xx.xMiB/s] [>                                                            ]  0% ETA 0:00:00
        ```
        - Running on the entire data dump (>5 hrs locally). ~53% of the original is kept after the first pass:
        ```
        # Entire File:
        Original:   freebase-rdf-latest         - 425229008315 Bytes (425.2 GB)
        s1-c1:      freebase-rdf-latest-s1-c1   - 229008851191 Bytes (229.0 GB) (53.8%)
        ```
    - `[s1-c2]` - Removing "< >" format which encloses each value.
    - `[s1-c3]` - Convert "." back to "/" in the domain, type, and property schemas to return a more Freebase-like format (e.g. format as "/award/award_winner" for types).
        - More efficient RegEx needed before running on main dataset.
    - ...
2. Indexing/Sorting Data
    - `[s2-c1]` - Create dataset(s) for quick topic lookups: extract triples with predicate == /type.object.name, /common.topic.description and possibly /type.object.type. Scripts should create separate data sets for each.
        - `[s2-c1-name]` - Processed: /type.object.name: (~1.5 hrs locally, 72.7M lines/triples extracted)
        ```
        freebase-rdf-latest-name-s02-c01        - (4.4 GB)
        ```
        - `[s2-c1-desc]` - Processed: /common.topic.description (~1.5 hrs locally, 20.5M lines/triples extracted)
        ```
        freebase-rdf-latest-desc-s02-c01        - (8.6 GB)
        ```
        - `[s2-c1-type]` - Processed: /type.object.type (~2.5 hrs locally, 293.7M lines/triples extracted)
        ```
        freebase-rdf-latest-type-s02-c01        - (17.7 GB)
        ```
        - Optimized scripts with GNU Parallel to run scripts on all CPU cores.
        - Distinguish textual type values (name, description) by ISO language codes.
        ```
        # Isolating '@en' language:
        freebase-rdf-latest-name-en-s02-c01     - (2.9 GB, 48,284,173 lines)
        freebase-rdf-latest-desc-en-s02-c01     - (2.6 GB, 7,528,658 lines)
        # In comparison, '@en-GB':
        freebase-rdf-latest-name-en-GB-s02-c01  - (1.4 MB, or 20K lines)
        freebase-rdf-latest-desc-en-GB-s02-c01  - (3 KB, or just 20 lines!)
        ```
        - Create topic profiles based on a combination of /name, /description, and /type triples.
            - Determine how to resolve conflations or incoherence
        - Process further for Freebase user-created /base domain, types, and properties. Easily distinguishable as these take the form /user/...
    - `[s2-c2]` - Create dataset(s) for schema - extract triples with predicate == /type.property.schema; predicate == /type.object.type and object == /type.property; (many others...)
        - ...
    - i18n Support - Text values are associated with an ISO language code (e.g. "String value"@en )
    - Using `awk` to parse data. 
    - ...
3. Interpreting/Visualizing Data
    - [Cayley](https://github.com/cayleygraph/cayley) - Try the Cayley graph database
    - [Gephi](https://en.wikipedia.org/wiki/Gephi) - Try Gephi open-source software
    - [Neo4j](https://en.wikipedia.org/wiki/Neo4j) - Try the Neo4j graph database


## Analysis

Once the data is cleaned and ready, this section outlines some of the software to manipluate, visualize, and analyze it.

### Cayley

The Cayley graph database and platform can be used to analyze the cleaned triples data. 
Cayley is an open-source graph database that draws on Freebase and the Knowledge Graph. 
It is maintained by a Google employee, with the GitHub repository at [cayleygraph/cayley](https://github.com/cayleygraph/cayley).

A Gremlin query using the Cayley Visualize function in the browser.

```
$ # On the command line:
$ ./cayley http --dbpath=data/testdata.nq

> // Running Cayley in the browser locally
> // Visualizing instances of /award/award_winner
> // Set GetLimit() as getting All() creates a large cluster of thousands of nodes
> g.V("/award.award_winner").Tag("source").Out("/type.type.instance").Tag("target").GetLimit(10)

```

![Cayley visualization screenshot](https://github.com/nchah/freebase-triples/blob/master/images/screenshot-cayley-visualization.png)


...

...

...


## License

Freebase data is licensed under the [CC-BY](http://creativecommons.org/licenses/by/2.5/) license. 
The Freebase API also has additional [Terms and Conditions](https://developers.google.com/freebase/terms#license). 


## Sources

Some sources may no longer be available following the deprecation of the Freebase API on June 30, 2015.

### Announcements Timeline

Many Freebase and Knowledge Graph related updates are posted on the once active [freebase-discuss](https://groups.google.com/forum/#!forum/freebase-discuss) Google Group and the [Google+](https://plus.google.com/u/0/109936836907132434202/posts) community.

- Jul 16, 2010 (Freebase joining Google) https://groups.google.com/d/msg/freebase-discuss/NkCF1DayKzA/QQufQ9gDwBsJ
- Dec 16, 2014 (timeline for Freebase sunsetting announced) https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc and https://groups.google.com/d/msg/freebase-discuss/s_BPoL92edc/Y585r7_2E1YJ
- Mar 26, 2015 (details on Wikidata and new KG API projected) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Sep 28, 2015 (short update on KG API) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Dec 16, 2015 (KG Search API releasted) https://plus.google.com/u/0/109936836907132434202/posts/iY8NZGFF6DN
- Jan 28, 2016 (KG Search Widget released) https://plus.google.com/u/0/109936836907132434202/posts/MCKpjUpx1H1
- May 02, 2016 (Freebase.com shutdown) https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ

### Freebase

- http://www.freebase.com/ (shutdown on May 02, 2016, now redirects to the data dumps)
- http://wiki.freebase.com/wiki/Main_Page

### Knowledge Graph

- https://www.google.com/intl/bn/insidesearch/features/search/knowledge.html (Google Inside Search explaining the Knowledge Graph)

### Google Developers Resources

**Freebase API**

- https://developers.google.com/freebase/
- https://developers.google.com/freebase/mql/

**Knowledge Graph Search API**

- https://plus.google.com/109936836907132434202/posts/iY8NZGFF6DN (released on Dec 16, 2015)
- https://developers.google.com/knowledge-graph/

**Google Search**

- https://developers.google.com/search/
- https://developers.google.com/structured-data/
- https://developers.google.com/structured-data/customize/overview

