#!/usr/bin/env python
"""
USAGE:

python analyse.py xxx.list

This script parse file such as:

data1_train_grid_file_clean.list
data1_test_grid_file_clean.list
data2_train_grid_file_clean.list
data2_test_grid_file_clean.list

and return the Accuracy.
"""

import sys
import re
import itertools

def parse_record_file(in_file):
    "parse a record file into permutation_list"
    permutation_list = []

    try:
        record_file = open(in_file)
    except IOError:
        print "Couldn't open file %s." % in_file
    records = record_file.readlines()
    record_file.close()

    # compile regular expression for parsing discourse id
    re_discourse_id = re.compile(r"[\S]+(?=\.perm-)") 
    
    # compile regular expression for parsing permutation id
    re_permutation_id = re.compile(r"(?<=perm-)[0-9]+")

    for record in records:
        if record.isspace():
            break
        record_rstripped = record.rstrip('\n')
        item_list = record_rstripped.split(' ')

        # check spliting result
        if len(item_list) != 2:
            try:
                raise InputError(record, "len(item_list) == %d" % len(len_list))
            except InputError as e:
                print "InputError occurred, msg:", e.msg
        
        # parse average out-degree
        avg_out_degree = float(item_list[1])
        
        # parse discourse id
        match_discourse_id = re_discourse_id.search(item_list[0])
        discourse_id = match_discourse_id.group()
        # debug: print matching result
        #print type(match_discourse_id.group()), match_discourse_id.group()
        
        # parse permutation id
        match_permutation_id = re_permutation_id.search(item_list[0])
        permutation_id = int(match_permutation_id.group())
        # debug: print matching result
        #print type(match_permutation_id.group()), match_permutation_id.group()

        permutation_list.append(Permutation(permutation_id,
                                            discourse_id,
                                            avg_out_degree))
        # debug: print detail for object Permutation
        #print "permutation_id:\t", type(permutation_id), permutation_id
        #print "discourse_id:\t", type(discourse_id), discourse_id
        #print "avg_out_degree:\t", type(avg_out_degree), avg_out_degree

    return permutation_list

def compute_accuracy(permutation_list):
    "compute accuracy for records from permutation_list"
    permutation_groups = itertools.groupby(permutation_list,
                               lambda permutation: permutation.discourse_id)
    # debug: print permutation groups
    #for discourse_id, permutation_group in permutation_groups:
    #    print discourse_id
    #    for permutation in permutation_group:
    #        print permutation.permutation_id

    record_list = []
    
    #  version 1: for each group, if the origin permutation has
    #+ the highest average out-degree, then mark positive example
    #for discourse_id, permutation_group in permutation_groups:
    #    # debug: print discourse_id
    #    #print discourse_id
    #   max_permutation = permutation_group.next()
    #    for permutation in permutation_group:
    #        #debug: print permutation
    #        #print permutation.permutation_id, permutation.avg_out_degree
    #        if permutation.avg_out_degree > max_permutation.avg_out_degree:
    #            max_permutation = permutation
    #    # debug: print max_permutation.avg_out_degree
    #    #print "max_permutation.avg_out_degree:", max_permutation.avg_out_degree
    #    if max_permutation.permutation_id == 1:
    #        record_list.append(int(1))
    #        # debug: print access 
    #        #print "Access!"
    #    else:
    #        record_list.append(int(0))
    #        # debug: print fail
    #        #print "Fail!"

    #  version 2: for each permutation(except origin permutation),
    #+ if the origin permutation has the higher(not equal) average
    #+ out-degree, then mark positive example
    for discourse_id, permutation_group in permutation_groups:
        permutation_list = []
        # debug: print discourse_id
        #print discourse_id,
        #  search for the origin permutation and record
        #+ every permutation in to a list for cacheing
        for permutation in permutation_group:
            permutation_list.append(permutation)
            if permutation.permutation_id == 1:
                ori_permutation = permutation
        # debug: print ori_permutation
        #print "ori_permutation:", ori_permutation.permutation_id, ori_permutation.avg_out_degree
        # compute item(positive or negative example) to record_list
        for permutation in permutation_list:
            if permutation.permutation_id == 1:
                continue
            #debug: print permutation
            #print permutation.permutation_id, permutation.avg_out_degree,
            if ori_permutation.avg_out_degree > permutation.avg_out_degree:
                record_list.append(int(1))
                # debug print positive result
                #print "positive"
            else:
                record_list.append(int(0))
                # debug print negative result
                #print "negative"

    #  version 3: for each permutation(except origin permutation),
    #+ if the origin permutation has the higher or the same average
    #+ out-degree, then mark positive example
    #for discourse_id, permutation_group in permutation_groups:
    #    permutation_list = []
    #    # debug: print discourse_id
    #    #print discourse_id,
    #    #  search for the origin permutation and record
    #    #+ every permutation in to a list for cacheing
    #    for permutation in permutation_group:
    #        permutation_list.append(permutation)
    #        if permutation.permutation_id == 1:
    #            ori_permutation = permutation
    #    # debug: print ori_permutation
    #    #print "ori_permutation:", ori_permutation.permutation_id, ori_permutation.avg_out_degree
    #    # compute item(positive or negative example) to record_list
    #    for permutation in permutation_list:
    #        if permutation.permutation_id == 1:
    #            continue
    #        #debug: print permutation
    #        #print permutation.permutation_id, permutation.avg_out_degree,
    #        if ori_permutation.avg_out_degree >= permutation.avg_out_degree:
    #            record_list.append(int(1))
    #            # debug print positive result
    #            #print "positive"
    #        else:
    #            record_list.append(int(0))
    #            # debug print negative result
    #            #print "negative"
                
    return float(sum(record_list)) / len(record_list)
        

    
class Error(Exception):
    """ Base class for exceptions in this module."""
    pass

class InputError(Exception):
    """ Exception raised for errors in the input.

        Attributes:
        expr -- input expression in which the error occurred
        msg  -- explanation of the error
    """
    def __init__(self, expr, msg):
        self.expr = expr
        self.msg = msg

class Permutation(object):
    "Permutation Class"
    def __init__(self, permutation_id, discourse_id, avg_out_degree):
        "set permutation_id, discourse_id, avg_out_degree for this permutation"
        self.permutation_id = permutation_id # shall be an int
        self.discourse_id = discourse_id     # shall be a string
        self.avg_out_degree = avg_out_degree # shall be a float

class Discourse(object):
    "Discourse Class"
    def __init__(self, discourse_id, permutation_list):
        "discourse_id, permutation_list for this discourse"
        self.discourse_id = discourse_id         # shall be a string
        self.permutation_list = permutation_list # shall be a list of class Permutation

    
if __name__ == "__main__":
    args = sys.argv
    
    permutation_list = parse_record_file(args[1])
    # debug: print all permutations
    #for permutation in permutation_list:
    #    print "permutation_id:\t", type(permutation.permutation_id), permutation.permutation_id
    #    print "discourse_id:\t", type(permutation.discourse_id), permutation.discourse_id
    #    print "avg_out_degree:\t", type(permutation.avg_out_degree), permutation.avg_out_degree
    #    print "---"
    #print "total:", len(permutation_list), "permutations."

    accuracy = compute_accuracy(permutation_list)
    print accuracy
