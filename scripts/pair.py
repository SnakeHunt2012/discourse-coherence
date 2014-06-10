#!/usr/bin/env python
#-*- coding: utf-8 -*-
"""
USAGE:

python pair.py xxx.csv
"""
import argparse
import itertools

class Permutation(object):
    "Class Permutation"
    def __init__(self,
                 subject,
                 index_begin,
                 index_end,
                 source,
                 part_id,
                 discourse_id,
                 permutation_id,
                 feature_list):

        self.subject = subject # str
        self.index_begin = index_begin # int
        self.index_end = index_end # int
        self.source = source # str
        self.part_id = part_id # str
        self.discourse_id = discourse_id # str
        self.permutation_id = permutation_id # int 
        self.feature_list = feature_list # list of float
        
class Pair(object):
    "Class Pair"
    def __init__(self, target,
                 permutation_id,
                 feature_vector):
        self.target = target
        self.permutation_id = permutation_id
        self.feature_vector = feature_vector

class Discourse(object):
    "Class Discourse"
    def __init__(self,
                 subject,
                 index_begin,
                 index_end,
                 source,
                 part_id,
                 discourse_id,
                 original_permutation,
                 shuffled_permutation_list):
        self.subject = subject
        self.index_begin = index_begin
        self.index_end = index_end
        self.source = source
        self.part_id = part_id
        self.discourse_id = discourse_id
        self.original_permutation = original_permutation
        self.shuffled_permutation_list = shuffled_permutation_list
        self.pair_list = []

    def pair_permutations(self):
        "pair permutations"
        pair_list = []
        original_permutation = self.original_permutation
        # target = 1 (original - shuffle)
        for shuffled_permutation in self.shuffled_permutation_list:
            feature_vector = []
            for index in range(len(original_permutation.feature_list)):
                feature = original_permutation.feature_list[index] - shuffled_permutation.feature_list[index]
                feature_vector.append(feature)
            pair_new = Pair(1, shuffled_permutation.permutation_id, feature_vector)
            pair_list.append(pair_new)

        # target = 0 (shuffle - original)
        for shuffled_pemutation in self.shuffled_permutation_list:
            feature_vector = []
            for index in range(len(original_permutation.feature_list)):
                feature = shuffled_permutation.feature_list[index] - original_permutation.feature_list[index]
                feature_vector.append(feature)
            pair_new = Pair(-1, shuffled_permutation.permutation_id, feature_vector)
            pair_list.append(pair_new)

        # register to self
        self.pair_list = pair_list

def parse_csv(csv_file):
    '''
    parse csv file to permutation_list[]
    '''
    permutation_list = []
    
    # open _conll file
    with open(csv_file, 'r') as csv:
        records = csv.readlines()
    for record in records:
        item_list = record.split(',')
        subject = item_list[0]
        index_begin = int(item_list[1])
        index_end = int(item_list[2])
        source = item_list[3]
        part_id = item_list[4]
        discourse_id = item_list[5]
        permutation_id = int(item_list[6])
        feature_list = item_list[7::]
        for index in range(len(feature_list)):
            feature_list[index] = float(feature_list[index])
        new_permutation = Permutation(subject,
                                     index_begin,
                                     index_end,
                                     source,
                                     part_id,
                                     discourse_id,
                                     permutation_id,
                                     feature_list)
        permutation_list.append(new_permutation)
    return permutation_list

def group_permutations(permutation_list):
    '''
    group permutations in permutation_list[]
    into discourse_list[]
    '''
    discourse_list = []

    # major_key()
    major_key = lambda permutation: (permutation.subject,
                                     permutation.source,
                                     permutation.discourse_id)

    # sort (for grouping)
    permutation_list = sorted(permutation_list, key = major_key)

    # group
    permutation_group_list = itertools.groupby(permutation_list, major_key)
    for key, group in permutation_group_list:
        # fetch permutations for current discourse
        permutation_list = []
        for permutation in group:
            permutation_list.append(permutation)
        # fetch and pop the original permutation
        original_permutation = None
        original_flag = 0
        for index in range(len(permutation_list)):
            if permutation_list[index].permutation_id == 1:
                original_permutation = permutation_list.pop(index)
                original_flag = 1
                break
        if original_flag == 0:
            print "Error: can't find original permutation for discourse: %s-%d" % (permutation_list[0].source_id, permutation_list[0].discourse_id)
        # new and register discourse
        subject = permutation_list[0].subject
        index_begin = permutation_list[0].index_begin
        index_end = permutation_list[0].index_end
        source = permutation_list[0].source
        part_id = permutation_list[0].part_id
        discourse_id = permutation_list[0].discourse_id
        discourse_new = Discourse(subject,
                                  index_begin,
                                  index_end,
                                  source,
                                  part_id,
                                  discourse_id,
                                  original_permutation,
                                  permutation_list)

        # add the new discourse into discourse_list[]
        discourse_list.append(discourse_new)
    return discourse_list


if __name__ == "__main__":
    '''
    pair.py
    '''
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()

    # add argument: csv_file 
    parser.add_argument("csv_file", type = str,
                        help = "the csv file including features for each permutaion to pair")
    
    # parse csv file and generate discourses(discourse_list[])
    args = parser.parse_args()
    
    permutation_list = parse_csv(args.csv_file)
    discourse_list = group_permutations(permutation_list)
    for discourse in discourse_list:
        discourse.pair_permutations()

    # print all pairs
    pattern_range = [2, 3]
    pattern_list = []
    for length in pattern_range:
        pattern_list.extend(list(itertools.product("-OSX", repeat=length)))
    pattern_amount = len(pattern_list)
    for discourse in discourse_list:
        pair_list = discourse.pair_list
        for pair in pair_list:
            print pair.target,
            for index in range(len(pair.feature_vector)):
                pattern_tuple = pattern_list[index % pattern_amount]
                pattern_str = ""
                for item in pattern_tuple:
                    pattern_str = pattern_str + item
                if index > pattern_amount:
                    #print "\"%s\":%f" % ("unsalience[" + pattern_str + "]", pair.feature_vector[index]),
                    print "%d:%f" % (index + 1, pair.feature_vector[index]),
                else:
                    #print "\"%s\":%f" % ("salience[" + pattern_str + "]", pair.feature_vector[index]),
                    print "%d:%f" % (index + 1, pair.feature_vector[index]),
            print "# "
    
