#freebase-triples

A repository to document the effort to clean and analyze the Freebase data dumps.

## Freebase

The [Freebase](https://en.wikipedia.org/wiki/Freebase) Wikipedia article provides a good overview of the knowledge base's nearly decade-long lifetime from its beginnings at Metaweb Technologies, Inc. in 2007, its acquisition by Google in 2010, and its eventual shutdown and move to Wikidata towards 2015-2016. Freebase accepted queries to its vast stores of data through the Metaweb Query Language (MQL).

Although the shutdown of freebase.com was set for as early as June 30, 2015 according to this [Google+ post](https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc), the actual website could be accessed for quite a long time. On May 2, 2016, freebase.com was finally closed off as announced in this [Google Group post](https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ). The link now redirects to the static Freebase data dumps.

A screenshot of freebase.com on May 2, 2016 before it was shut down.
![freebase.com screenshot](https://github.com/nchah/freebase-mql/blob/master/images/screenshot-freebase-com.png)

## Freebase Data Dumps

A data dump of 1.9 billion Freebase Triples in [N-Triples RDF](https://www.w3.org/TR/rdf-testcases/#ntriples) format is available on the [developers page](https://developers.google.com/freebase/#freebase-rdf-dumps) under the [CC-BY](http://creativecommons.org/licenses/by/2.5/) license. The [freebase.com](http://freebase.com) URL also redirects to this page following its shutdown. 
The file is listed as being 22 GB gzip compressed and 250 GB uncompressed according to the website, although recent downloads exceed this file size (a May 2016 download amounted to >30 GB compressed and >400 GB uncompressed). 

Examining the compressed data with Z commands on the terminal:

```
# Scan through the data with zmore or zless
$ zmore freebase-rdf-latest.gz

<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.object.type>   <http://rdf.freebase.com/ns/type.property>      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.object.name>   "footballdb ID"@en      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.unique>       "true"  .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.expected_type>        <http://rdf.freebase.com/ns/type.enumeration>   .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://www.w3.org/2000/01/rdf-schema#label>    "footballdb ID"@en      .
<http://rdf.freebase.com/ns/american_football.football_player.footballdb_id>    <http://rdf.freebase.com/ns/type.property.schema>       <http://rdf.freebase.com/ns/american_football.football_player>  .


# You can also grep it
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

## Changes

Changes made to the raw triples data dump to ease processing.

- TODO:
    - Data Cleaning
        - Convert N-Triples [(Wikipedia)](https://en.wikipedia.org/wiki/N-Triples) format to N3 [(Wikipedia)](https://en.wikipedia.org/wiki/Notation3) or other format. Working with the full URIs conforms to the standard, but can be wordy.


## Analysis

### Cayley

The Cayley graph can be used to analyze the cleaned data. Cayley is an open-source graph database maintained by a Google employee. GitHub repository is available at [google/cayley](https://github.com/google/cayley).


## License

Freebase data is licensed under the [CC-BY](http://creativecommons.org/licenses/by/2.5/) license. The Freebase API also has additional [Terms and Conditions](https://developers.google.com/freebase/terms#license). 


## Sources

Some sources may no longer be available following the deprecation of the Freebase API on June 30, 2015. 

### Announcements

Many Freebase and Knowledge Graph related updates are posted on the once active [freebase-discuss](https://groups.google.com/forum/#!forum/freebase-discuss) Google Group and the [Google+](https://plus.google.com/u/0/109936836907132434202/posts) community.

- Jul 16, 2010 (joining Google) https://groups.google.com/d/msg/freebase-discuss/NkCF1DayKzA/QQufQ9gDwBsJ
- Dec 16, 2014 (timeline for Freebase sunsetting announced) https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc and https://groups.google.com/d/msg/freebase-discuss/s_BPoL92edc/Y585r7_2E1YJ
- Mar 26, 2015 (details on Wikidata and new KG API projected) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Sep 28, 2015 (short update on KG API) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Dec 16, 2015 (KG Search API releasted) https://plus.google.com/u/0/109936836907132434202/posts/iY8NZGFF6DN
- Jan 28, 2016 (KG Search Widget released) https://plus.google.com/u/0/109936836907132434202/posts/MCKpjUpx1H1
- May 02, 2016 (Freebase.com shutdown) https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ

### Freebase

- http://www.freebase.com/ (shutdown on May 02, 2016, now redirects to the data dumps)
- http://wiki.freebase.com/wiki/Main_Page

### MQL

- http://wiki.freebase.com/images/8/87/MQLReferenceGuide.pdf (extensive 220 page PDF)

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

