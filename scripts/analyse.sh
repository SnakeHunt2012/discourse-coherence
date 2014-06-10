#!/bin/bash
# analyse.sh

# Generate testing result from data[(1)|(2)]_[(train)|(test)]_grid_file.list.
#
# This script output:
# 1. Accuracy(stdout)
# 2. accuracy-entity.pdf
# 3. accuracy-sentence.pdf

# dirs
work_dir=$(pwd)
result_dir="${work_dir}/../result"
csv_dir="${work_dir}/../csv"
U_dir="${csv_dir}/P-U"
w_dir="${csv_dir}/P-W"
Acc_dir="${csv_dir}/P-Acc"

# paths
pyscript_path="${work_dir}/analyse.py"
rscript_path="${work_dir}/analyse.R"
list_path="${result_dir}/result.list"
csv_sentence_path="${U_dir}/sentence-accuracy.csv"
csv_entity_path="${U_dir}/entity-accuracy.csv"

# create or clean
touch $csv_sentence_path
touch $csv_entity_path
: > $csv_sentence_path
: > $csv_entity_path

# print accuracy to stdout
echo "Accuracy: $(python ${pyscript_path} -a ${list_path})"

# print accuracy to csv for analyse by R
python ${pyscript_path} --result-by-sentence-amount ${list_path} > ${csv_sentence_path}
python ${pyscript_path} --result-by-entity-amount ${list_path} > ${csv_entity_path}

# draw pictures
R CMD BATCH --vanilla analyse.R 

