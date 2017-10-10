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
                       Note: this should be '/type/object/id' slice so that machine ids (mid) are extracted """

    """ = = = = = = = = = = """
    """ Preprocessing       """
    """ = = = = = = = = = = """
    
    # 1. Removing unnecessary triples from the type-object-id slice, like /soft and /user data
    fname_input_preprocess = input_file  # Should = "slices-new/fb-rdf-pred-type-object-id"
    fname_output_preprocess = "slices-new/fb-rdf-pred-type-object-id-1"
    fname_rest_preprocess = "slices-new/fb-rdf-pred-type-object-id-1-soft-user"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    p = subprocess.Popen(['gawk',
        "{ fname" + '="'+fname_output_preprocess+'";' + ' fname_rest="'+fname_rest_preprocess+'"; ' +
        'if( $3 !~ "/soft.*" && $3 !~ "/user." )' + " { print $0 >> fname; } else { print $0 >> fname_rest; } }",
        fname_input_preprocess])
    p.communicate()
    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print("Done pre-processing" + "\t" + t0.decode('ascii').strip() + "\t" + t1.decode('ascii').strip())


    """ = = = = = = = = = = """
    """ Domains             """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -3  slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha
    </m.01xljnx>    </type.object.id>   "/american_football"    .
    </m.04kcwl6>    </type.object.id>   "/amusement_parks"  .
    </m.01xljms>    </type.object.id>   "/architecture" . 
    """

    # 1. Get the machine id (mid) and the corresponding domain name
    query_count = 0
    fname_input = fname_output_preprocess
    fname_output = "slices-new/fb-rdf-pred-schema-domains-ids"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    domains = open('slices-new/fb-rdf-pred-schema-domains').readlines()
    for domain in domains:
        domain = domain.split("\t")
        mid = domain[0]

        p = subprocess.Popen(['gawk',
                "{ fname" + '="'+fname_output+'";' +
                'if( $1 == "' + mid + '")' + " { print $0 >> fname; } }",
                fname_input])
        p.communicate()

        query_count += 1
        if query_count % 100 == 0:
            print(str(query_count) + "\t" + mid)

    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())

    # 2. Remove "base" domains and get only the remaining domains
    domains = open(fname_output).readlines()
    for domain in domains:
        hrid = domain.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 1:
            with open("slices-new/fb-rdf-pred-schema-domains-ids-1", "a") as f:
                f.write(domain)

    # 3. Sort alphabetically by the domain name (the 3rd column)
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-domains-ids-1 >\
        slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha'], shell=True)


    """ = = = = = = = = = = """
    """ Types               """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -3  slices-new/fb-rdf-pred-schema-types-ids-1-byalpha
    </m.01xljvt>    </type.object.id>   "/american_football/football_coach" .
    </m.04xg8pq>    </type.object.id>   "/american_football/football_coach_position"    .
    </m.025dnr9>    </type.object.id>   "/american_football/football_conference"    .
    """

    # 1. Get the machine id (mid) and the corresponding domain name
    query_count = 0
    fname_output_preprocess = "slices-new/fb-rdf-pred-type-object-id-1"
    fname_input = fname_output_preprocess
    fname_output = "slices-new/fb-rdf-pred-schema-types-ids"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    types = open('slices-new/fb-rdf-pred-schema-types').readlines()
    for typ in types:
        typ = typ.split("\t")
        mid = typ[0]
        if "</m." in mid:
            p = subprocess.Popen(['gawk',
                    "{ fname" + '="'+fname_output+'";' +
                    'if( $1 == "' + mid + '")' + " { print $0 >> fname; } }",
                    fname_input])
            p.communicate()

            query_count += 1
            if query_count % 100 == 0:
                print(str(query_count) + "\t" + mid)
    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())

    # 2. Remove "base" domain types
    types = open(fname_output).readlines()
    for typ in types:
        hrid = typ.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 2:
            with open("slices-new/fb-rdf-pred-schema-types-ids-1", "a") as f:
                f.write(typ)

    # 3. Sort alphabetically by the type (the 3rd column)
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-types-ids-1 >\
        slices-new/fb-rdf-pred-schema-types-ids-1-byalpha'], shell=True)


    """ = = = = = = = = = = """
    """ Properties          """
    """ = = = = = = = = = = """
    """ Sample of final output:

    $ head -3  slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha
    </m.04xg8_0>    </type.object.id>   "/american_football/football_coach/coaching_history"    .
    </m.04xg9d7>    </type.object.id>   "/american_football/football_coach/current_team_head_coached"   .
    </m.04xg8yc>    </type.object.id>   "/american_football/football_coach_position/coaches_holding_this_position"  .
    """

    # 1. Get the machine id (mid) and the corresponding property name
    query_count = 0
    fname_output_preprocess = "slices-new/fb-rdf-pred-type-object-id-1"
    fname_input = fname_output_preprocess
    fname_output = "slices-new/fb-rdf-pred-schema-properties-ids"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    properties = open('slices-new/fb-rdf-pred-schema-properties').readlines()
    for prop in properties:
        prop = prop.split("\t")
        mid = prop[0]
        if "</m." in mid:
            p = subprocess.Popen(['gawk',
                    "{ fname" + '="'+fname_output+'";' +
                    'if( $1 == "' + mid + '")' + " { print $0 >> fname; } }",
                    fname_input])
            p.communicate()

            query_count += 1
            if query_count % 100 == 0:
                print(str(query_count) + "\t" + mid)
    t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t1.decode('ascii').strip())

    # 2. Remove "base" domain properties
    properties = open(fname_output).readlines()
    for prop in properties:
        hrid = prop.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 3:
            with open("slices-new/fb-rdf-pred-schema-properties-ids-1", "a") as f:
                f.write(prop)

    # 3. Sort alphabetically by the property (the 3rd column)
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-properties-ids-1 >\
        slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha'], shell=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', help='Path to the input data file')
    args = parser.parse_args()
    main(args.input_file)
