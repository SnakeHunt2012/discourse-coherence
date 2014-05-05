#!/usr/bin/env python
#-*- coding: utf-8 -*-
"""
USAGE:

python grid.py xxx_conll > xxx.grid

This script generate the xxx.grid file
from the corresponding xxx_conll file
"""

import sys
import argparse
import re

class Discourse(object):
    '''
    the Discourse object records all essential information
    extracted from the _conll file for a single discourse
    '''
    def __init__(self, identity, sentence_amount, sentence_list):
        self.identity = identity # shall be a string, e.g. "chtb_0001.v4"`
        self.sentence_amount = sentence_amount # shall be an integer
        self.sentence_list = sentence_list # shall be a list of Sentence object
        #self.entity_amount = 0 # entity amount of this discourse
        #self.entity_list = [] # entity_list of this discourse

    def extract_mention(self):
        '''
        extract all mmentions from all sentences
        and return a list containing all mentions
        appeared in this discourse
        '''
        mention_list = []
        for sentence in self.sentence_list:
            sentence.parse_mention()
            mention_list.extend(sentence.mention_list)
            
        # debug: print all mention in this discourse
        mention_index = 0
        for mention in mention_list:
            print "mention %d:\t%d\t" % (mention_index, mention.entity_identity),
            index_begin = mention.token_index_begin
            index_end = mention.token_index_end
            sentence_index = mention.sentence_index
            token_list = self.sentence_list[sentence_index].token_list[index_begin:index_end]
            for token in token_list:
                print token.word_itself,
            mention_index = mention_index + 1
            print
        
        return mention_list

    def group_mention():
        "under construction"
        pass

class Sentence(object):
    '''
    the Sentence object records all essential information
    extracted from a sentence in the _conll file, the sentence
    is a serial of lines without any empty lines interupting them,
    and of course two sentences are separated by an empty lines between them
    '''
    def __init__(self, index, token_amount, token_list):
        self.index = index # shall be an integer which assign the index of this sentence in the discourse
        self.token_amount = token_amount # shall be an integer
        self.token_list = token_list # shall be a list of Token object
        self.mention_amount = 0 # mention amount of this sentence
        self.mention_list = [] # mention_list of this sentence

    def parse_mention(self):
        '''
        parse all metnions in this sentence
        into mention_amount and mention_list
        '''
        mention_amount = 0
        mention_list = []
        mention_stack = []

        token_index = 0
        for token in self.token_list:
            # extract mentions from this sentence
            for mention in mention_stack:
                mention.token_index_end = mention.token_index_end + 1
                
            for operator in token.resolute_operator_list:
                if operator.operation == 0:
                    # this token is the begin of a new mention
                    identity = operator.identity
                    mention_new = Mention(identity,
                                          self.index,
                                          token_index,
                                          token_index + 1)
                    mention_stack.append(mention_new)
                elif operator.operation == 1:
                    # this token is the ending of the mention at the top of the mention_stack
                    # Todo:
                    # 1. parse identity
                    # 2. find the mention with the same identity in the mention_stack backwards
                    # 3. mention_list <- mention_stack.pop(remove_index)
                    # 4. mention_amount++

                    # 1. parse identity
                    identity = operator.identity

                    # 2. find the mention with the same identity in the mention_stack backwards
                    remove_index = len(mention_stack) - 1
                    for remove_index in range(remove_index - 1, -1, -1):
                        if mention_stack[remove_index].entity_identity == identity:
                            break

                    # 3. mention_list <- mention_stack.pop(remove_index)
                    mention_list.append(mention_stack.pop(remove_index))

                    # 4. mention_amount++
                    mention_amount = mention_amount + 1

                else:
                    # this token is a single mention itself
                    identity = operator.identity
                    mention_new = Mention(identity,
                                          self.index,
                                          token_index,
                                          token_index + 1)
                    mention_list.append(mention_new)
                    mention_amount = mention_amount + 1
                
            token_index = token_index + 1
            
        self.mention_amount = mention_amount
        self.mention_list = mention_list
            

class Token(object):
    '''
    the Token object records all the essential information
    extracted from a single line in the conll file,
    every word in a discourse is represented by a line along with
    other information related to the word, we use `token` as the
    name because it not only records the word itself but other
    essential information as well
    '''
    def __init__(self, word_itself,
                 part_of_speech, phrase_bit,
                 coreference_operator_list):
        self.word_itself = word_itself # shall be a string, e.g. "the"
        self.part_of_speech = part_of_speech # shall be a string, e.g. "NR"
        self.phrase_bit = phrase_bit # shall be a string, e.g. "(TOP(IP(NP(NP*"
        self.resolute_operator_list = coreference_operator_list # shall be an list of Resolute_Operator object

class Resolute_Operator(object):
    '''
    the Coreference_Operator object describe
    an operator of resolution, including three
    types:
    0 - start of entity xx, such as `(8`
    1 - end of entity xx, such as `8)`
    2 - this is a single mention of xx,
        i.e. including both start and end,
        e.g. (8)
    '''
    def __init__(self, identity, operation):
        # shall be an integer as the number of the entity of this mention, e.g. 8
        self.identity = identity
        # shall be a integer as the type of operation, e.g. 2
        # the coreference resolution operation have three type:
        # 0 - start of entity xx, such as `(8`
        # 1 - end of entity xx, such as `8)`
        # 2 - this is a single mention of xx, such as `(8)`
        self.operation = operation

class Entity(object):
    '''
    Class Entity
    '''
    def __init__(self, identity, mention_list):
        self.identity = identity # shall be an integer
        self.mention_list = mention_list # shall be a list of mention object

class Mention(object):
    '''
    Class Mention
    '''
    def __init__(self, entity_identity,
                 sentence_index,
                 token_index_begin,
                 token_index_end):
        self.entity_identity = entity_identity # shall be an integer
        self.sentence_index = sentence_index # shall be an integer as the index to a sentence list of this Discourse
        self.token_index_begin = token_index_begin # shall be an integer as the index to a token list of the sentence indexed by the sentence_index in the previous line
        self.token_index_end = token_index_end # shall be an integer as the index to a token list of the sentence indexed by the sentence_index in the previous line

def parse_conll(file_in):
    '''
    parse _conll file and extract the Discourse objects inside
    return a list of Discourse objects
    --under construction--
    '''

    # open _conll file
    try:
        file_conll = open(file_in)
    except IOError:
        print "Couldn't open file", file_in
    # read in lines
    lines = file_conll.readlines()
    # close _conll file
    file_conll.close()

    # parse lines
    discourse_list = []
    discourse_current = None
    sentence_current = None
    discourse_new = None
    sentence_new = None
    identity = None
    state = 0
    type_line = 0
    count_line = 0
    sentence_index = 0
    re_identity = re.compile(r"(?<=document \()\S+(?=\);)")
    for line in lines:
        type_line = determin_type(line)
        if state == 0:
            # state zero
            count_line = count_line + 1
            # behave
            if type_line == 1:
                # 1. parse identity
                identity = re_identity.search(line)
                if identity:
                    identity = identity.group(0)
                else:
                    print "error: identity parse failed line = %s" % line
                # 2. new discourse <- identity
                discourse_new = Discourse(identity, 0, [])
                # 3. discourse_current <- discourse
                discourse_current = discourse_new
                # move state <- 1
                state = 1
            else:
                # error
                print "error: state = %d\tline_type = %d\tline = %d" % (state, line, count_line)
        elif state == 1:
            # state one
            count_line = count_line + 1
            # behave
            if type_line == 3:
                # 1. move state <- 1
                state = 1
            elif type_line == 4:
                # 1. parse token
                token = parse_line(line)
                # 2. new sentence
                sentence_new = Sentence(sentence_index , 0, [])
                sentence_index = sentence_index + 1
                # 3. sentence <- token
                sentence_new.token_amount = sentence_new.token_amount + 1
                sentence_new.token_list.append(token)
                # 4. sentence_current <- sentence
                sentence_current = sentence_new
                # move state <- 2
                state = 2
            elif type_line == 2:
                # 1. discourse_list <- discourse_current
                discourse_list.append(discourse_current)
                # 2. discourse_current <- NULL
                discourse_current = None
            else:
                # error
                print "error: state = %d\tline_type = %d\tline = %d" % (state, type_line, count_line)
        elif state == 2:
            # state two
            count_line = count_line + 1
            # behave
            if type_line == 2:
                # 1. discourse_current <- sentence_current
                discourse_current.sentence_amount = discourse_current.sentence_amount + 1
                discourse_current.sentence_list.append(sentence_current)
                # 2. sentence_current <- NULL
                sentence_current = None
                # 3. discourse_list <- discourse_current
                discourse_list.append(discourse_current)
                # 4. discourse_current <- NULL
                discourse_current = None
                # move state <- 0
                state = 0
            elif type_line == 3:
                # 1. discourse_current <- sentence_current
                discourse_current.sentence_amount = discourse_current.sentence_amount + 1
                discourse_current.sentence_list.append(sentence_current)
                # 2. sentence_current <- NULL
                sentence_current = None
                # move state <- 1
                state = 1
            elif type_line == 4:
                # 1. parse token
                token = parse_line(line)
                # 2. sentence_current <- token
                sentence_current.token_amount = sentence_current.token_amount + 1
                sentence_current.token_list.append(token)
                # move state <- 2
                state = 2
            else:
                # error
                print "error, state = %d\tline_type = %d\tline = %d" % (state, line, count_line)
        else:
            # state error
            count_line = count_line + 1
            print "error: state = %d\tline = %d" % (state, count_line)
    return discourse_list

def determin_type(line):
    '''
    determin which kinds of line the current line is
    1. "#begin" of a discourse
    2. "#end" of a discourse
    3. an empty line
    4. a token line
    input a single line of the _conll file
    return type of this line by integer: 1|2|3|4
    '''

    # regex for three type
    re_type_1 = re.compile(r"^#begin")
    re_type_2 = re.compile(r"^#end")
    re_type_3 = re.compile(r"^\s*$")

    # determin line type
    if re_type_1.search(line):
        return 1
    elif re_type_2.search(line):
        return 2
    elif re_type_3.search(line):
        return 3
    else:
        return 4


def parse_line(line):
    '''
    parse a recording line in _conll file
    return a Token object, these infomation
    contain:
    1. word itself
    2. part of speech
    3. phrase bit
    4. the list of coreference operators, e.g. (8 | 8) | (8)
    '''
    # split the line by white spaces
    line = line.split()

    # extract infos
    word_itself = line[3]
    part_of_speech = line[4]
    phrase_bit = line[5]
    coreference_operator_list = parse_operators(line[-1])

    # debug: print a token
    #print "word_itself: %s\tpart_of_speech: %s\tphrase_bit: %s\t" % (word_itself, part_of_speech, phrase_bit),
    #for coreference_operator in coreference_operator_list:
    #    print "(%d, %d)" % (coreference_operator.identity, coreference_operator.operation),
    #print

    # malloc and register and return Token
    return Token(word_itself, part_of_speech, phrase_bit, coreference_operator_list)
    
def parse_operators(operators):
    '''
    parse a string that records
    the coreference operators, e.g.
    input:
        "(8|(10)|(12|9)|11)"
    output:
        [
        Resolute_Operator(8, 0),
        Resolute_Operator(10, 2),
        Resolute_Operator(12, 0),
        Resolute_Operator(9, 1),
        Resolute_Operator(11, 1)
        ] (<- this is a list of Resolution_Operator object)
    '''

    # remove blank characters
    operators = operators.strip()

    # check if operators is '-'
    if operators == "-":
        return []

    # split by character '|'
    operators = operators.split('|')

    # operators -> operator_list
    operator_list = []
    for operator in operators:
        operator = parse_operator(operator)
        operator_list.append(operator)

    return operator_list

def parse_operator(operator):
    '''
    parse a sting in which is
    an operator, e.g.
    input:
        "(8" or "8)" or "(8)"
    output:
        Resolution_Operator(8, 0)
        or
        Resolution_Operator(8, 1)
        or
        Resolution_Operator(8, 2)
    '''
    # regex for parsing operator type
    # type 0: this is begin of a mention
    re_type_0 = re.compile(r"^\([0-9]+$")
    # type 1: this is end of a mention
    re_type_1 = re.compile(r"^[0-9]+\)$")
    # type 2: this is a single mention
    re_type_2 = re.compile(r"^\([0-9]+\)$")
    
    # regex for parsing entity id
    re_entity_id = re.compile(r"[0-9]+")

    # parse operator type
    # type 0: this is begin of a mention
    if re_type_0.match(operator):
        is_type_0 = 1
    else:
        is_type_0 = 0
    # type 1: this is end of a mention
    if re_type_1.match(operator):
        is_type_1 = 1
    else:
        is_type_1 = 0
    # type 2: this is a single mention
    if re_type_2.match(operator):
        is_type_2 = 1
    else:
        is_type_2 = 0

    # determin resolution type
    if is_type_0 + is_type_1 + is_type_2 != 1:
        print "can't parse operator", operator
    elif is_type_0 == 1:
        operation = 0
    elif is_type_1 == 1:
        operation = 1
    elif is_type_2 == 1:
        operation = 2
    else:
        print "can't parse operator", operator
        
    # parse entity id
    identity = re_entity_id.search(operator)
    identity = int(identity.group())

    # malloc and register and return Resolution_Operator
    return Resolute_Operator(identity, operation)

if __name__ == "__main__":
    "-- pass --"
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    
    # add argument: conll_file
    parser.add_argument("conll_file", type = str,
                        help = "print the entity grid from the xxx_conll file you type here")

    # add option: --all-noun
    group.add_argument("-n", "--all-noun", action = "store_true",
                       help = "use all nouns as the entities without coreference resolution")
    
    # add option: --np-noun
    group.add_argument("-p", "--np-noun", action = "store_true",
                       help = "use coreferenced resoluted (nouns and NPs) as the entities, i.e. resoluted( resoluted({nouns}) + resoluted({NPs}) )")

    args = parser.parse_args()
    discourse_list = parse_conll(args.conll_file)

    # debug: print mentions of a sentence for testing function parse_mention()
    #sentence_sample = discourse_list[0].sentence_list[8]
    #sentence_sample.parse_mention()
    #mention_index = 0
    #for mention in sentence_sample.mention_list:
    #    print "mention %d:\t%d\t" % (mention_index, mention.entity_identity),
    #    index_begin = mention.token_index_begin
    #    index_end = mention.token_index_end
    #    token_list = sentence_sample.token_list[index_begin:index_end]
    #    for token in token_list:
    #        print token.word_itself,
    #    mention_index = mention_index + 1
    #    print
    #print "mention amount: %d" % (sentence_sample.mention_amount)

    # debug: print all mention in a discourse
    discourse_list[0].extract_mention()

    # debug: print discourse_list
    #for discourse in discourse_list:
    #    count_sentence = 0
    #    for sentence in discourse.sentence_list:
    #        print "sentence %d\t" % (count_sentence),
    #        for token in sentence.token_list:
    #            print token.word_itself,
    #        count_sentence = count_sentence + 1
    #        print 
    
    if args.all_noun:
        pass
    elif args.np_noun:
        pass
    else:
        pass
