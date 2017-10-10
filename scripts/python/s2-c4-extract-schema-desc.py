#!/usr/bin/env python
"""
Run with:
$ python this-script.py [path_to_input_file]
"""

import argparse
import subprocess


def main(input_file):
    """ Run the main shell commands
    :param input_file: the path to the RDF file that will have its data extracted
                       Note: this should be the '/common/topic/description' slice so that desc are extracted """

    """ = = = = = = = = = = """
    """ Preprocessing       """
    """ = = = = = = = = = = """

    # 1. Creating a "en" English slice of descriptions.
    # This part already commented out in case the slice is already available
    fname_input_preprocess = input_file  # Should = "slices-new/fb-rdf-pred-common-topic-description"
    fname_output_preprocess = "slices-new/fb-rdf-pred-common-topic-description-en"
    # t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    # subprocess.check_output(['cat '+fname_input_preprocess+' | parallel --pipe --block 2M --progress '+
    #     "grep '@en' " + '>' + fname_output_preprocess], shell=True)
    # t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    # print("Preprocess en slice:\t" + t0.decode('ascii').strip() + "\t" + t1.decode('ascii').strip())


    """ = = = = = = = = = = """
    """ Domains             """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -2 slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha-desc
    </m.01xljnx>    </type.object.id>   "/american_football"    .
    </m.01xljnx>    </common.topic.description> "American Football types pertain to the sport of Football...
    """

    # Preserve the triples with the ids, and get additional triples on description
    query_count = 0
    fname_input = fname_output_preprocess  # Should = "slices-new/fb-rdf-pred-common-topic-description-en"
    fname_output = "slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    domains = open('slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha').readlines()
    for domain in domains:
        # In the first pass, write the same triple of data
        with open(fname_output, "a") as f:
            f.write(domain)
        
        domain = domain.split("\t")
        mid = domain[0].strip()
        p = subprocess.Popen(['gawk',
                "{ fname" + '="'+fname_output+'";' +
                'if( $1 == "'+mid+'" )' + " { print $0 >> fname; } }",
                fname_input])
        p.communicate()
        # mid = domain[0].replace(">", "\>")
        # mid = mid.replace("<", "\<")
        # subprocess.check_output(['cat '+fname_input+' | parallel --pipe --block 2M --progress '+\
            # "grep '"+mid+"' " + '>>' + fname_output], shell=True)

        query_count += 1
        if query_count % 100 == 0:
            print(str(query_count) + "\t" + mid)

    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())


    """ = = = = = = = = = = """
    """ Types               """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -2 slices-new/fb-rdf-pred-schema-types-ids-1-byalpha-desc
    </m.01xljvt>    </type.object.id>   "/american_football/football_coach" .
    </m.01xljvt>    </common.topic.description> "'Football Coach' refers to coaches of...
    """

    # Preserve the triples with the ids, and get additional triples on description
    query_count = 0
    fname_input = fname_output_preprocess  # Should = "slices-new/fb-rdf-pred-common-topic-description-en"
    fname_output = "slices-new/fb-rdf-pred-schema-types-ids-1-byalpha-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    types = open('slices-new/fb-rdf-pred-schema-types-ids-1-byalpha').readlines()
    for typ in types:
        # In the first pass, write the same triple of data
        with open(fname_output, "a") as f:
            f.write(typ)

        typ = typ.split("\t")
        mid = typ[0].strip()
        p = subprocess.Popen(['gawk',
                "{ fname" + '="'+fname_output+'";' +
                'if( $1 == "'+mid+'" )' + " { print $0 >> fname; } }",
                fname_input])
        p.communicate()

        query_count += 1
        if query_count % 100 == 0:
            print(str(query_count) + "\t" + mid)

    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())


    """ = = = = = = = = = = """
    """ Properties          """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -3 slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha-desc
    </m.04xg8_0>    </type.object.id>   "/american_football/football_coach/coaching_history"    .
    </m.04xg9d7>    </type.object.id>   "/american_football/football_coach/current_team_head_coached"   .
    </m.04xg9d7>    </common.topic.description> "List the team this coach is the head coach of (if any)"@en .
    """

    # Preserve the triples with the ids, and get additional triples on description
    query_count = 0
    fname_input = fname_output_preprocess  # Should = "slices-new/fb-rdf-pred-common-topic-description-en"
    fname_output = "slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    properties = open('slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha').readlines()
    for prop in properties:
        # In the first pass, write the same triple of data
        with open(fname_output, "a") as f:
            f.write(prop)

        prop = prop.split("\t")
        mid = prop[0]
        p = subprocess.Popen(['gawk',
                "{ fname" + '="'+fname_output+'";' +
                'if( $1 == "'+mid+'" )' + " { print $0 >> fname; } }",
                fname_input])
        p.communicate()

        query_count += 1
        if query_count % 100 == 0:
            print(str(query_count) + "\t" + mid)
    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', help='Path to the input data file')
    args = parser.parse_args()
    main(args.input_file)
