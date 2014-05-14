#!/bin/bash
# sampling.sh

work_dir=$(pwd)
rscript_path="${work_dir}/sampling.R"
table_dir="${work_dir}/../tables"
sampling_dir="${work_dir}/../sampling"
conll_dir="${work_dir}/../data/conll-2012/v4/data/train/data/english/annotations"

# generate file index tables using script sampling.R
#R CMD BATCH --vanilla --salve $rscript_path

mkdir -p $sampling_dir
for table in $(ls $table_dir)
do
    target_dir="${sampling_dir}/${table%_sampling.table}"
    table_path="${table_dir}/${table}"
    mkdir -p $target_dir
    cat ${table_path} | while read record
    do
	echo "copying ${conll_dir}/${record// //} -> ${target_dir}/"
	cp ${conll_dir}/${record// //} ${target_dir}/
    done
done