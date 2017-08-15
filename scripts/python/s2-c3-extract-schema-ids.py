#!/usr/bin/env python3
"""
Run with:
$ python s2.py [path_to_input_file]
"""

import argparse
import subprocess


def main(input_file):
    """ main shell commands """

    """ = = = = = = = = = = """
    """ Preprocessing """
    # Removing unnecessary triples from type-object-id
    fname_input_preprocess = input_file  # = "slices-new/fb-rdf-pred-type-object-id"
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
    """ Starting domains script """
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

    # Remove "base" domains and get only the domains:
    domains = open(fname_output).readlines()
    for domain in domains:
        hrid = domain.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 1:
            with open("slices-new/fb-rdf-pred-schema-domains-ids-1", "a") as f:
                f.write(domain)
    # Sort alphabetically by id
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-domains-ids-1 >\
        slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha'], shell=True)

    """ = = = = = = = = = = """
    """ Startng types script """
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

    # Remove "base" domain types:
    types = open(fname_output).readlines()
    for typ in types:
        hrid = typ.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 2:
            with open("slices-new/fb-rdf-pred-schema-types-ids-1", "a") as f:
                f.write(typ)
    # Sort alphabetically by id
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-types-ids-1 >\
        slices-new/fb-rdf-pred-schema-types-ids-1-byalpha'], shell=True)


    """ = = = = = = = = = = """
    """ Startng properties script """
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

    # Remove "base" properties types:
    properties = open(fname_output).readlines()
    for prop in properties:
        hrid = prop.split("\t")[2]
        if "/base/" not in hrid and hrid.count("/") == 3:
            with open("slices-new/fb-rdf-pred-schema-properties-ids-1", "a") as f:
                f.write(prop)
    # Sort alphabetically by id
    subprocess.check_output(['sort -k 3 slices-new/fb-rdf-pred-schema-properties-ids-1 >\
        slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha'], shell=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', help='Path to the input data file')
    args = parser.parse_args()
    main(args.input_file)
