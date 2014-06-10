#!/usr/bin/env python
"""
USAGE:

python feature.py xxx.grid

This script return the feature vector
of the file xxx.grid
"""
import sys
import itertools
import copy

class Entity(object):
    "Entity Class"
    def __init__(self, name, trace):
        "set entity and trace for this entity"
        self.name = name # a string
        self.trace = trace # a str list

class Feature(object):
    "Feature Class"
    def __init__(self, pattern, value):
        self.pattern = pattern # shall be a tuple such as ("S", "O", "X", "-")
        self.value = value # shall be a integer

class Vector(object):
    "Vector Class"
    def __init__(self, grid):
        #self.feature_list = self.extract_features_without_salience(grid)
        self.feature_list = self.extract_features_with_salience(grid)
        self.discourse_new = 0
        self.pronoun_coreference = 0

    def extract_features_with_salience(self, grid):
        "extract features form the grid (with salience)"
        unsalience_list, salience_list = separate_salience(grid)

        if not (len(unsalience_list) == 0):
            unsalience_feature_list = self.extract_features_without_salience(unsalience_list)
        else:
            unsalience_feature_list = []
            
        if not (len(salience_list) == 0):
            salience_feature_list = self.extract_features_without_salience(salience_list)
        else:
            salience_feature_list = []

        unsalience_feature_list.extend(salience_feature_list)
        return unsalience_feature_list

    def extract_features_without_salience(self, grid):
        "extract features from the grid"
        feature_list = []
        pattern_list = []
        pattern_range = [2, 3]
        entity_amount = len(grid)
        sentence_amount = len(grid[0].trace)

        # ascertain patterns
        for length in pattern_range:
            pattern_list.extend(list(itertools.product("-OSX", repeat=length)))

        # set value_list
        value_list = [0 for patter in pattern_list]

        # extract features
        for entity in grid:
            for length in pattern_range:
                for index in range(0, sentence_amount - length + 1):
                    index_begin = index
                    index_end = index + length
                    pattern_current = entity.trace[index_begin:index_end]
                    record_pattern(pattern_current, pattern_list, value_list)

        # record and return 
        value_sum = 0
        for value in value_list:
            value_sum = value_sum + value
        for index in range(len(pattern_list)):
            feature_list.append(Feature(tuple(pattern_list[index]),
                                        float(value_list[index]) /
                                        float(entity_amount *
                                              (sentence_amount - len(pattern_list[index]) + 1)))) # ZeroDivisionError: float division by zero
        return feature_list

# tools
def separate_salience(ori_grid):
    '''
    saparate salience entities and un-salience entities
    ---------------------------------------------------
    input: grid (a list of entity objects)
    output: unsalience_list, salience_list (both a list of entity objects)
    Note: we will destroy the input list
    '''
    unsalience_list = []
    salience_list = []
    grid = copy.deepcopy(ori_grid)

    # saparate salience
    for entity in grid:
        if judge_salience(entity):
            salience_list.append(entity)
        else:
            unsalience_list.append(entity)
    return unsalience_list, salience_list

def judge_salience(entity):
    '''
    judge if entity is a salience entity
    ------------------------------------
    input: class entity
    output: boolean indicating salience or not
    '''
    count = 0
    for step in entity.trace:
        if not (step == '-'):
            count = count + 1

    # salience if count > 1
    if count > 1:
        return True
    else:
        return False
    
def record_pattern(pattern_current, pattern_list, value_list):
    '''
    record pattern into the list
    '''
    for pattern_index in range(len(pattern_list)):
        if match_pattern(pattern_current, pattern_list[pattern_index]):
            value_list[pattern_index] = value_list[pattern_index] + 1

def match_pattern(tuple_one, tuple_two):
    '''
    combine two pattern being the same or not
    tuple_one: list or tuple
    tuple_two: list or tuple
    '''
    if not (len(tuple_one) == len(tuple_two)):
        return False
    for step_index in range(len(tuple_one)):
        if tuple_one[step_index] != tuple_two[step_index]:
            return False
    return True

def grid_parse(in_file):
    "parse a grid file into a grid"
    grid = []
    
    try:
        grid_file = open(in_file)
    except IOError:
        print "Couldn't open file %s." % in_file
    lines = grid_file.readlines()
    grid_file.close()
    
    for line in lines:
        if line.isspace():
            break
        line_rstripped = line.rstrip('\n')
        word_list = line_rstripped.split()
        pos_end = len(word_list)
        entity_name = word_list[0]
        entity_trace = word_list[1:pos_end]
        grid.append(Entity(entity_name, entity_trace))
        
    return grid


if __name__=="__main__":
    '''
    print feature vector of grid
    '''
    args = sys.argv
    grid = grid_parse(args[1])
    
    feature_vector = Vector(grid)
    feature_list = feature_vector.feature_list

    for index in range(len(feature_list)):
        if index < len(feature_list) - 1:
            sys.stdout.write("%f," % feature_list[index].value)
        else:
            sys.stdout.write("%f\n" % feature_list[index].value)
    
