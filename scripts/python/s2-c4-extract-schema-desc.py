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
    fname_input_preprocess = input_file  # = "slices-new/fb-rdf-pred-common-topic-description"
    fname_output_preprocess = "slices-new/fb-rdf-pred-common-topic-description-en"
    # t0 = subprocess.check_output(['gdate','+"%s%3N"'])

    # subprocess.check_output(['cat '+fname_input_preprocess+' | parallel --pipe --block 2M --progress '+
    #     "grep '@en' " + '>' + fname_output_preprocess], shell=True)
    
    # t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    # print("Preprocess en slice:\t" + t0.decode('ascii').strip() + "\t" + t1.decode('ascii').strip())


    # """ = = = = = = = = = = """
    # """ Starting domains script """
    # query_count = 0
    # fname_input = fname_output_preprocess  # = "slices-new/fb-rdf-pred-common-topic-description"
    # fname_output = "slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha-desc"

    # t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    # print(t0.decode('ascii').strip())

    # domains = open('slices-new/fb-rdf-pred-schema-domains-ids-1-byalpha').readlines()
    # for domain in domains:
    #     with open(fname_output, "a") as f:
    #         f.write(domain)
        
    #     domain = domain.split("\t")
    #     mid = domain[0].strip()
    #     p = subprocess.Popen(['gawk',
    #             "{ fname" + '="'+fname_output+'";' +
    #             'if( $1 == "'+mid+'" )' + " { print $0 >> fname; } }",
    #             fname_input])
    #     p.communicate()
    #     # mid = domain[0].replace(">", "\>")
    #     # mid = mid.replace("<", "\<")
    #     # subprocess.check_output(['cat '+fname_input+' | parallel --pipe --block 2M --progress '+\
    #         # "grep '"+mid+"' " + '>>' + fname_output], shell=True)

    #     query_count += 1
    #     if query_count % 100 == 0:
    #         print(str(query_count) + "\t" + mid)

    # t1 = subprocess.check_output(['gdate','+"%s%3N"'])
    # print(t1.decode('ascii').strip())


    """ = = = = = = = = = = """
    """ Startng types script """
    query_count = 0
    fname_input = fname_output_preprocess  # = "slices-new/fb-rdf-pred-common-topic-description"
    fname_output = "slices-new/fb-rdf-pred-schema-types-ids-1-byalpha-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    types = open('slices-new/fb-rdf-pred-schema-types-ids-1-byalpha').readlines()
    for typ in types:
        with open("slices-new/fb-rdf-pred-schema-types-ids-1-byalpha-desc", "a") as f:
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
    """ Startng properties script """
    query_count = 0
    fname_input = fname_output_preprocess  # = "slices-new/fb-rdf-pred-common-topic-description"
    fname_output = "slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    properties = open('slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha').readlines()
    for prop in properties:
        with open("slices-new/fb-rdf-pred-schema-properties-ids-1-byalpha-desc", "a") as f:
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
