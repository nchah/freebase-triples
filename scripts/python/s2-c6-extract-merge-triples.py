#!/usr/bin/env python
"""
Run with:
$ python this-script.py [path_to_input_file]
"""

import argparse
import subprocess


def main(input_file):
    """ Run the main shell commands
    :param input_file: the RDF file that should have its mids merged with triples from other slices 
                       Ideally should be one of the domain slices, like bicycles, chess, etc."""

    """ = = = = = = = = = = """
    """ Preprocessing       """
    """ = = = = = = = = = = """

    fname_input = input_file

    """ = = = = = = = = = = """
    """ Extract and Merge   """
    """ = = = = = = = = = = """

    # Preserve the triples with the ids, and get additional triples on description
    query_count = 0
    fname_output = fname_input + "-merged-name-desc"

    t0 = subprocess.check_output(['gdate','+"%s%3N"'])
    print(t0.decode('ascii').strip())

    triples = open(fname_input).readlines()
    for triple in triples:
        # In the first pass, write the same triple of data
        with open(fname_output, "a") as f:
            f.write(triple)

        # Get the mid, the first value in each triple
        mid = triple.split("\t")[0].strip()

        inputs = ["slices-new/fb-rdf-pred-type/fb-rdf-pred-type-object-name",
                "slices-new/fb-rdf-pred-common/fb-rdf-pred-common-topic-description" ]
        for inpt in inputs:
            fname_input = inpt

            p = subprocess.Popen(['gawk',
                    "{ fname" + '="'+fname_output+'";' +
                    'if( $1 == "'+mid+'" )' + " { print $0 >> fname; } }",
                    fname_input])
            p.communicate()

            # Printing out the progress
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
