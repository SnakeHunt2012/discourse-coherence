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
import argparse

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
        if len(item_list) != 4:
            try:
                raise InputError(record, "len(item_list) == %d" % len(len_list))
            except InputError as e:
                print "InputError occurred, msg:", e.msg
        
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

        # parse average out-degree
        avg_out_degree = float(item_list[1])
        
        # parse entity_amount
        entity_amount = int(item_list[2])

        # parse sentence_amount
        sentence_amount = int(item_list[3])

        permutation_list.append(Permutation(permutation_id,
                                            discourse_id,
                                            entity_amount,
                                            sentence_amount,
                                            avg_out_degree))
        # debug: print detail for object Permutation
        #print "permutation_id:\t", type(permutation_id), permutation_id
        #print "discourse_id:\t", type(discourse_id), discourse_id
        #print "avg_out_degree:\t", type(avg_out_degree), avg_out_degree

    return permutation_list

def group_permutations(permutation_list):
    "group permutations by discourse name"
    permutation_groups = []
    permutation_groups_raw = itertools.groupby(permutation_list,
                                lambda permutation: permutation.discourse_id)
    for discourse_id, permutation_group in permutation_groups_raw:
        permutation_list = []
        for permutation in permutation_group:
            permutation_list.append(permutation)
        permutation_groups.append(permutation_list)
    # debug: print all permutations in permutation_groups
    #for permutation_list in permutation_groups:
    #    if len(permutation_list) == 0:
    #        try:
    #            raise InputError(permutation_list, "len(permutation_list) == %d" % len(permutation_list))
    #        except InputError as e:
    #            print "InputError occurred, msg:", e.msg
    #    print permutation_list[0].discourse_id
    #    for permutation in permutation_list:
    #        print permutation.permutation_id

    return permutation_groups

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

def group_discourse_by_entity_amount(discourse_list):
    "group discourses by entity amount"
    group_item_list = []
    
    # sort (for grouping)
    discourse_list = sorted(discourse_list,
                            key = lambda discourse: discourse.entity_amount)
    # group by discourse
    discourse_group = itertools.groupby(discourse_list,
                                         lambda discourse: discourse.entity_amount)
    # make group_item add them to group_item_list
    for entity_amount, discourses in discourse_group:
        store_list = []
        for discourse in discourses:
            store_list.append(discourse)
        group_item = Group_Item(entity_amount, store_list, [])
        group_item_list.append(group_item)
    return group_item_list

def group_discourse_by_sentence_amount(discourse_list):
    "group discourses by sentence amount"
    group_item_list = []
    
    # sort (for grouping)
    discourse_list = sorted(discourse_list,
                            key = lambda discourse: discourse.sentence_amount)
    # group by discourse
    discourse_group = itertools.groupby(discourse_list,
                                         lambda discourse: discourse.sentence_amount)
    # make group_item add them to group_item_list
    for sentence_amount, discourses in discourse_group:
        store_list = []
        for discourse in discourses:
            store_list.append(discourse)
        group_item = Group_Item(sentence_amount, store_list, [])
        group_item_list.append(group_item)
    return group_item_list

def count_discourse_by_entity_amount(discourse_list):
    "group discourses by entity amount and then compute accuracy for each group"
    group_item_list = []
    
    # sort (for grouping)
    discourse_list = sorted(discourse_list,
                            key = lambda discourse: discourse.entity_amount)
    # group by discourse
    discourse_group = itertools.groupby(discourse_list,
                                         lambda discourse: discourse.entity_amount)
    # make group_item add them to group_item_list
    for entity_amount, discourses in discourse_group:
        store_list = []
        discourse_amount = 0
        accuracy_accumulate = 0
        for discourse in discourses:
            store_list.append(discourse)
            discourse_amount = discourse_amount + 1
            accuracy_accumulate = accuracy_accumulate + discourse.accuracy
            accuracy = accuracy_accumulate / discourse_amount
        group_item = Group_Item(entity_amount, store_list, (accuracy + 1) / 2)
        group_item_list.append(group_item)
        
    return group_item_list
    
def count_discourse_by_sentence_amount(discourse_list):
    "group discourses by sentence amount and then compute accuracy for each group"
    group_item_list = []
    
    # sort (for grouping)
    discourse_list = sorted(discourse_list,
                            key = lambda discourse: discourse.sentence_amount)
    # group by discourse
    discourse_group = itertools.groupby(discourse_list,
                                         lambda discourse: discourse.sentence_amount)
    # make group_item add them to group_item_list
    for sentence_amount, discourses in discourse_group:
        store_list = []
        discourse_amount = 0
        accuracy_accumulate = 0
        for discourse in discourses:
            store_list.append(discourse)
            discourse_amount = discourse_amount + 1
            accuracy_accumulate = accuracy_accumulate + discourse.accuracy
            accuracy = accuracy_accumulate / discourse_amount
        group_item = Group_Item(sentence_amount, store_list, (accuracy + 1) / 2)
        group_item_list.append(group_item)
        
    return group_item_list
    
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
    def __init__(self, permutation_id,
                 discourse_id,
                 entity_amount,
                 sentence_amount,
                 avg_out_degree):
        "set permutation_id, discourse_id, avg_out_degree for this permutation"
        self.permutation_id = permutation_id   # shall be an int
        self.discourse_id = discourse_id       # shall be a string
        self.entity_amount = entity_amount     # shell be an int
        self.sentence_amount = sentence_amount # shell be an int
        self.avg_out_degree = avg_out_degree   # shall be a float

class Discourse(object):
    "Discourse Class"
    def __init__(self, discourse_id, entity_amount, sentence_amount, permutation_list):
        "set discourse_id, permutation_list for this discourse"
        self.discourse_id = discourse_id         # shall be a string
        self.entity_amount = entity_amount       # shall be an int
        self.sentence_amount = sentence_amount   # shall be an int
        self.range_front = 0                     # shall be an int
        self.range_rear = 0                      # shall be an int
        self.accuracy = 0                        # shall be a float
        self.permutation_list = permutation_list # shall be a list of class Permutation
        
        # compute self.permutation_amount
        self.permutation_amount = len(permutation_list)

        # compute self.range_front and self.range_rear
        self.permutation_list = sorted(permutation_list,
                                       key = lambda permutation: permutation.permutation_id)
        self.range_front = 1
        self.range_rear = 1
        ori_permutation = permutation_list[0]
        for permutation in permutation_list:
            if permutation.permutation_id == 1:
                continue
            if permutation.avg_out_degree > ori_permutation.avg_out_degree:
                self.range_front = self.range_front + 1
            if permutation.avg_out_degree >= ori_permutation.avg_out_degree:
                self.range_rear = self.range_rear + 1

        # compute self.accuracy
        range_avg = float(self.range_front) + float(self.range_rear) / 2
        mu = float(self.permutation_amount) / 2
        sigma = float(self.permutation_amount)
        self.accuracy = ((self.permutation_amount - range_avg) - mu) / sigma

class Group_Item(object):
    "item of list groups returned by funnction group_by_xxx()"
    def __init__(self, item_key, item_list, info):
        "set item_key, item_list for this group item"
        self.item_key = item_key   # not sure about the type (could be any type)
        self.item_list = item_list # shall be a list
        self.info = info           # not sure about the type (could be any type)

    
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    
    # add argument: records_file
    parser.add_argument("records_file", type = str,
                        help = "analyse the records in the 'xxx.list' file you type here")
    # add option: --accuracy
    group.add_argument("-a", "--accuracy", action = "store_true",
                        help = "print the accuracy for all records in the 'xxx.list' file")
    # add option: --permutation-amount
    group.add_argument("-p", "--permutation-amount", action = "store_true",
                        help = "print the number of permutations for each discourse from the records in the 'xxx.list' file")
    # add option: --sort-by-permutation-amount
    group.add_argument("--sort-by-permutation-amount", action = "store_true",
                       help = "print the number of discourses with the same permutation amount along with the permutation amount behind in csv[permutation_amount, discourse_amount] form")
    # add option: --sort-by-entity-amount
    group.add_argument("--sort-by-entity-amount", action = "store_true",
                       help = "print the number of discourses with the same entity amount along with the sentence amount behind in csv[sentence_amount, discourse_amount] form")
    # add option: --sort-by-sentence-amount
    group.add_argument("--sort-by-sentence-amount", action = "store_true",
                        help = "print the number of discourses with the same sentence amount along with the sentence amount behind in csv[sentence_amount, discourse_amount] form")
    # add option: --result-by-permutation-amount
    group.add_argument("--result-by-permutation-amount", action = "store_true",
                       help = "print the accuracy of discourses with the same permutation amount along with the permutation behind in csv[accuracy, permutation_amount] form")
    # add option: --result-by-entity-amount
    group.add_argument("--result-by-entity-amount", action = "store_true",
                       help = "print the accuracy of discourses with the same entity amount along with the permutation behind in csv[accuracy, entity_amount] form")
    # add option: --result-by-sentence-amount
    group.add_argument("--result-by-sentence-amount", action = "store_true",
                       help = "print the accuracy of discourses with the same sentence amount along with the permutation behind in csv[accuracy, sentence_amount] form")
    # add option: --permutation-for-hist-gram
    group.add_argument("--permutation-for-hist-gram", action = "store_true",
                       help = "print permutation amount for every discourse, one discourse per line")
    # add option: --entity-for-hist-gram
    group.add_argument("--entity-for-hist-gram", action = "store_true",
                       help = "print entity amount and accuracy for every discourse, one discourse per line")
    # add option: --sentence-for-hist-gram
    group.add_argument("--sentence-for-hist-gram", action = "store_true",
                       help = "print sentence amount and accuracy for every discourse, one discourse per line")
    # add option: --avg-amount-amount
    group.add_argument("--avg-entity-amount", action = "store_true",
                       help = "print average entity amount in form [discourse_amount_avg discourse_amount]")
    # add option: --avg-sentence-amount
    group.add_argument("--avg-sentence-amount", action = "store_true",
                       help = "print average sentence amount in form [sentence_amount_avg discourse_amount]")
    

    # parse args from command
    args = parser.parse_args()
    
    permutation_list = parse_record_file(args.records_file)
    permutation_groups = group_permutations(permutation_list)

    # debug: print all permutations
    #for permutation in permutation_list:
    #    print "permutation_id:\t", type(permutation.permutation_id), permutation.permutation_id
    #    print "discourse_id:\t", type(permutation.discourse_id), permutation.discourse_id
    #    print "entity_amount:\t", type(permutation.entity_amount), permutation.entity_amount
    #    print "sentence_amount:\t", type(permutation.sentence_amount), permutation.sentence_amount
    #    print "avg_out_degree:\t", type(permutation.avg_out_degree), permutation.avg_out_degree
    #    print "---"
    #print "total:", len(permutation_list), "permutations."

    # convert permutation_gourps to discourse_list
    discourse_list = []
    for permutation_group in permutation_groups:
        # 1.sort permutation_group by permutation_id
        permutation_group = sorted(permutation_group,
                                   key = lambda permutation: permutation.permutation_id)
        # 2.make discourse by permutation_group
        min_sentence_amount = permutation_group[0].sentence_amount
        for permutation in permutation_group:
            if permutation.sentence_amount < min_sentence_amount:
                min_sentence_amount = permutation.sentence_amount
        discourse = Discourse(permutation_group[0].discourse_id,
                              permutation_group[0].entity_amount,
                              min_sentence_amount,
                              permutation_group)
        # 3.add discourse to discourse_list
        discourse_list.append(discourse)
        
    # debug: print all discourse
    #for discourse in discourse_list:
    #    print "%s\t%d\t%d\t[%f]\t[%d-%d]" % (discourse.discourse_id,
    #                                         discourse.entity_amount,
    #                                         discourse.sentence_amount,
    #                                         discourse.accuracy,
    #                                         discourse.range_front,
    #                                         discourse.range_rear)
    #    for permutation in discourse.permutation_list:
    #        print "%d\t%d\t%d\t%f" % (permutation.permutation_id,
    #                                permutation.entity_amount,
    #                                permutation.sentence_amount,
    #                                permutation.avg_out_degree)
    
    # act as the args specify
    if args.accuracy:
        accuracy = compute_accuracy(permutation_list)
        print accuracy
    elif args.permutation_amount:
        for permutation_group in permutation_groups:
            if len(permutation_group) == 0:
                try:
                    raise InputError(permutation_list, "len(permutation_list == %d)" % len(permutation_list))
                except InputError as e:
                    print "InputError occurred, msg:", e.msg
            print "%s,%d" % (permutation_group[0].discourse_id, len(permutation_group))
    elif args.permutation_for_hist_gram:
        for discourse in discourse_list:
            print len(discourse.permutation_list)
    elif args.sort_by_permutation_amount:
        permutation_groups = sorted(permutation_groups,
                                    key = lambda permutation_group: len(permutation_group))
        permutation_group_groups = itertools.groupby(permutation_groups,
                                                     lambda permutation_group: len(permutation_group))
        for permutation_group_size, permutation_group_group in permutation_group_groups:
            count = 0
            for permutation_group in permutation_group_group:
                count = count + 1
            print "%d,%d" % (permutation_group_size, count)
    elif args.sort_by_entity_amount:
        group_item_list = group_discourse_by_entity_amount(discourse_list)
        for group_item in group_item_list:
            print "%d,%d" % (group_item.item_key, len(group_item.item_list))
    elif args.sort_by_sentence_amount:
        group_item_list = group_discourse_by_sentence_amount(discourse_list)
        for group_item in group_item_list:
            print "%d,%d" % (group_item.item_key, len(group_item.item_list))
    elif args.result_by_permutation_amount:
        # under construction
        print "function result_by_permutation_amount is under construction"
    elif args.result_by_entity_amount:
        group_item_list = count_discourse_by_entity_amount(discourse_list)
        for group_item in group_item_list:
            print "%d,%d,%f" % (group_item.item_key, len(group_item.item_list), group_item.info)
    elif args.result_by_sentence_amount:
        group_item_list = count_discourse_by_sentence_amount(discourse_list)
        for group_item in group_item_list:
            print "%d,%d,%f" % (group_item.item_key, len(group_item.item_list), group_item.info)
    elif args.permutation_for_hist_gram:
        for discourse in discourse_list:
            print len(discourse.permutation_list)
    elif args.entity_for_hist_gram:
        for discourse in discourse_list:
            print "%d,%f" % (discourse.entity_amount, discourse.accuracy)
    elif args.sentence_for_hist_gram:
        for discourse in discourse_list:
            print "%d,%f" % (discourse.sentence_amount, discourse.accuracy)
    elif args.avg_entity_amount:
        entity_amount_total = 0
        for discourse in discourse_list:
            entity_amount_total = entity_amount_total + discourse.entity_amount
        entity_amount_avg = float(entity_amount_total) / float(len(discourse_list))
        print "%f\t%d" % (entity_amount_avg, len(discourse_list))
    elif args.avg_sentence_amount:
        sentence_amount_total = 0
        for discourse in discourse_list:
            sentence_amount_total = sentence_amount_total + discourse.sentence_amount
        sentence_amount_avg = float(sentence_amount_total) / float(len(discourse_list))
        print "%f\t%d" % (sentence_amount_avg, len(discourse_list))
    else:
        # impossible to go through this branch, so do noting
        pass
