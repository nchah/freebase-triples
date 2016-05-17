#freebase-mql

A reflection and review of [Freebase.com](http://www.freebase.com) and the (now deprecated) Metaweb Query Language (MQL). This repo is a response to the increasing attention being given to Facebook's [GraphQL](https://code.facebook.com/posts/1691455094417024), which was released in September 2015. Those who have worked with MQL before would have immediately noticed the similiarities of GraphQL with this now deprecated language. 


## Freebase

The [Freebase](https://en.wikipedia.org/wiki/Freebase) Wikipedia article provides a good overview of the knowledge base's nearly decade-long lifetime from its beginnings at Metaweb Technologies, Inc. in 2007, its acquisition by Google in 2010, and its eventual shutdown and move to Wikidata towards 2015-2016. Freebase accepted queries to its vast stores of data through the Metaweb Query Language (MQL).

Although the shutdown of freebase.com was set for as early as June 30, 2015 according to this [Google+ post](https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc), the actual website could be accessed for quite a long time. On May 2, 2016, freebase.com was finally closed off as announced in this [Google Group post](https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ). The link now redirects to the static Freebase data dumps.

A screenshot of freebase.com on May 2, 2016 before it was shut down.
![freebase.com screenshot](https://github.com/nchah/freebase-mql/blob/master/images/screenshot-freebase-com.png)

### Data Dumps

A data dump of Freebase Triples is available on the [developers page](https://developers.google.com/freebase/#freebase-rdf-dumps). The file is 22 GB gzip compressed, 250 GB uncompressed.




## Sample MQL Scripts

Some samples of MQL scripts that I wrote are enclosed as txt files in the mql-queries folder. At the time, I queried these MQL scripts against the Freebase API using Python. Due to Python requirements, "None" may need to be replaced with "null" in the MQL queries. 

The [MQL Reference Guide](https://developers.google.com/freebase/mql/ch03#firstquery) presents the following as a first query using MQL.

```
	Query:
	{
	  "type" : "/music/artist",
	  "name" : "The Police",
	  "album" : []
	}

	Response:
	{
	  "type": "/music/artist",
	  "name": "The Police",
	  "album": [
	    "Outlandos d'Amour",
	    "Reggatta de Blanc",
	    "Zenyatta Mondatta",
	    "Ghost in the Machine",
	    "Synchronicity",
	  ]
	}
```

In comparison, the [GraphQL documentation](https://facebook.github.io/react/blog/2015/05/01/graphql-introduction.html) offers the following introductory query:
```
	Query:
	{
	  user(id: 3500401) {
	    id,
	    name,
	    isViewerFriend,
	    profilePicture(size: 50)  {
	      uri,
	      width,
	      height
	    }
	  }
	}

	Response:
	{
	  "user" : {
	    "id": 3500401,
	    "name": "Jing Chen",
	    "isViewerFriend": true,
	    "profilePicture": {
	      "uri": "http://someurl.cdn/pic.jpg",
	      "width": 50,
	      "height": 50
	    }
	  }
	}
```

The syntax has some differences but there are notable similarities in the general nested structure and query format. The query request essentially lays out the data structure that should be returned in the response. 



## The Google Knowledge Graph

Following the deprecation of the Freebase APIs, the new Knowledge Graph Search API (KG API) was released by Google on December 16, 2015 ([Google+ post](https://plus.google.com/u/0/109936836907132434202/posts/iY8NZGFF6DN)). As of April 2016, the new KG API does not support queries written in MQL as it did on Freebase. 

I have some further code to explore the Knowledge Graph API in this repository [knowledge-graph-api](https://github.com/nchah/knowledge-graph-api).


## Sources

Some sources may no longer be available following the deprecation of the Freebase API on June 30, 2015. 

**Announcements**

Many Freebase and Knowledge Graph related updates are posted on the once active [freebase-discuss](https://groups.google.com/forum/#!forum/freebase-discuss) Google Group and the [Google+](https://plus.google.com/u/0/109936836907132434202/posts) community.

- Jul 16, 2010 (joining Google) https://groups.google.com/d/msg/freebase-discuss/NkCF1DayKzA/QQufQ9gDwBsJ
- Dec 16, 2014 (timeline for Freebase sunsetting announced) https://plus.google.com/u/0/109936836907132434202/posts/bu3z2wVqcQc and https://groups.google.com/d/msg/freebase-discuss/s_BPoL92edc/Y585r7_2E1YJ
- Mar 26, 2015 (details on Wikidata and new KG API projected) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Sep 28, 2015 (short update on KG API) https://plus.google.com/u/0/109936836907132434202/posts/3aYFVNf92A1
- Dec 16, 2015 (KG Search API releasted) https://plus.google.com/u/0/109936836907132434202/posts/iY8NZGFF6DN
- Jan 28, 2016 (KG Search Widget released) https://plus.google.com/u/0/109936836907132434202/posts/MCKpjUpx1H1
- May 02, 2016 (Freebase.com shutdown) https://groups.google.com/forum/#!topic/freebase-discuss/WEnyO8f7xOQ

**Freebase**
- http://www.freebase.com/ (shutdown on May 02, 2016, now redirects to the data dumps)
- http://wiki.freebase.com/wiki/Main_Page

**MQL**
- http://wiki.freebase.com/images/8/87/MQLReferenceGuide.pdf (extensive 220 page PDF)

**Knowledge Graph**
- https://www.google.com/intl/bn/insidesearch/features/search/knowledge.html (Google Inside Search explaining the Knowledge Graph)

**Google Developers Resources**

*Freebase API*
- https://developers.google.com/freebase/
- https://developers.google.com/freebase/mql/

*Knowledge Graph Search API*
- https://plus.google.com/109936836907132434202/posts/iY8NZGFF6DN (released on Dec 16, 2015)
- https://developers.google.com/knowledge-graph/

*Google Search*
- https://developers.google.com/search/
- https://developers.google.com/structured-data/
- https://developers.google.com/structured-data/customize/overview

