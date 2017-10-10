#!/usr/bin/env python
"""
Run with:
$ python this-script.py [path_to_input_file]
"""

import argparse
import datetime
import subprocess
import time


# Globals

# Note: path to the query file has been hardcoded here
#       queries.txt file has a schema of [slice_title],[query]
queries = open('queries/queries-schema-for-domains-types-properties').readlines()


def main(input_file):
    """ Run the main shell commands
    :param input_file: the path to the RDF file you want sliced according to the queries """

    query_count = 0
    fname_input = input_file
    fname_output = "slices-new/fb-rdf-schema-"
    fname_rest = "fb-rdf-rest-"

    for query in queries:
        query = query.split(",")
        query_title = query[0].strip().replace(".", "-")
        query_raw = query[1].strip()

        query_count += 1
        fname_output += query_title  # Add the 1st column from the queries data to the title
        fname_rest += str(query_count)  # Increment up the filename for the remainder data

        t0 = subprocess.check_output(['gdate','+"%s%3N"'])
        p = subprocess.Popen(['gawk',
                              "{ fname" + '="'+fname_output+'";' + ' fname_rest="' +fname_rest +'"; ' +
                              'if(' + query_raw + ')' + " { print $0 >> fname; } else { print $0 >> fname_rest; } }",
                              fname_input])
        p.communicate()

        t1 = subprocess.check_output(['gdate','+"%s%3N"'])
        # Show the runtime stats: initial time, finished time
        print(query_title + "\t" + t0.decode('ascii').strip() + "\t" + t1.decode('ascii').strip())

        # Reset some of the file names for the next loop
        fname_input = fname_rest
        fname_rest = "fb-rdf-rest-"
        fname_output = "slices-new/fb-rdf-schema-"


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('input_file', help='Path to the input data file')
    args = parser.parse_args()
    main(args.input_file)
    # main()

