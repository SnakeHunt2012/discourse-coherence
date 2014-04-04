#!/usr/bin/env python
"""
USAGE:

--pass--

This script --pass--
"""

import sys
import networkx as nx

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
        word_list = line_rstripped.split(' ')
        pos_end = len(word_list)
        entity_name = word_list[0] # warning: using space to split a line may cause error
        entity_trace = word_list[1:pos_end]
        grid.append(Entity(entity_name, entity_trace))
        
    return grid

def connection_between_sentences(grid, frm, to):
    connect_entities_frm = set()
    connect_entities_to = set()

    # entities connected by sentence "frm"
    for index in range(len(grid)):
        if not(grid[index].trace[frm] == '-'):
            connect_entities_frm.add(index)

    # entities connected by sentence "to"
    for index in range(len(grid)):
        if not(grid[index].trace[to] == '-'):
            connect_entities_to.add(index)

    # do sentences "frm" and "to" have entities in common?
    if (connect_entities_frm & connect_entities_to) == set():
        return False
    else:
        return True

def edge_weight_entity_sentence(grid, entity, sentence):
    weight = 0
    if grid[entity].trace[sentence] == 'S':
        weight = 3
    elif grid[entity].trace[sentence] == 'O':
        weight = 2
    elif grid[entity].trace[sentence] == 'X':
        weight = 1
    return weight # warning: this value shall be converted to other type with high precision if needed

def edge_weight_version_1(grid, frm, to):
    "compute edge weight between two sentences by method P_U"
    weight = 1
    return weight # warning: this value shall be converted to other type with high precision when needed

def edge_weight_version_2(grid, frm, to):
    "compute edge weight between two sentences by method P_W"
    weight = 0
    for index in range(len(grid)):
        if not(grid[index].trace[frm] == '-') and not(grid[index].trace[to] == '-'):
            weight = weight + 1
    return weight # warning: this value shall be converted to other type with high precision when needed

def edge_weight_version_3(grid, frm, to):
    "compute edge weight between two sentences by method P_Acc"
    weight = 0
    for index in range(len(grid)):
        weight = weight + edge_weight_entity_sentence(grid, index, frm) * edge_weight_entity_sentence(grid, index, to)
    return weight # warning: this value shall be converted to other type with high precision when needed

def grid_to_graph(grid):
    "generate one-mode projection graph between sentences"
    graph = nx.DiGraph()
    tuples_frm_to_weights = []
    num_of_sentences = len(grid[0].trace)
    # Version 1: the sentence "to" is the sentence later than "frm" just by one(adjacent to "frm")
    for i in range(num_of_sentences - 1):
        if connection_between_sentences(grid, i, i + 1):
            tuples_frm_to_weights.append((i, i + 1, edge_weight_version_2(grid, i, i + 1)))
    # Version 2: the sentence "to" is every sentence later than "frm"
    #for i in range(num_of_sentences - 1):
    #    for j in range(i + 1, num_of_sentences):
    #        if connection_between_sentences(grid, i, j): 
    #            tuples_frm_to_weights.append((i, j, edge_weight_version_3(grid, i, j)))
    
    # debug: print all tuples
    print tuples_frm_to_weights
    return graph 

    
class Entity(object):
    "Entity Class"
    def __init__(self, name, trace):
        "set entity and trace for this entity"
        self.name = name # a string
        self.trace = trace # a str list


if __name__ == "__main__":
    "---pass--"
    # under construction
    grid = grid_parse("./in.txt")
    graph = grid_to_graph(grid)
