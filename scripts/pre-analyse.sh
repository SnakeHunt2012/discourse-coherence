#!/bin/bash
# pre-analyse.sh

work_dir=$(pwd)
data_dir="${work_dir}/../data/conll-2012/v4/data/train/data/english/annotations"
rscript_path="${work_dir}/pre-analyse.R"
target_file="${work_dir}/../csv/subject-source-part-file-length.csv"

: > $target_file

echo "subject,source,part,file,length" >> $target_file
for subject in $(ls $data_dir)
do
    for data_source in $(ls $data_dir/$subject)
    do
	for part in $(ls $data_dir/$subject/$data_source)
	do
	    for file in $(ls $data_dir/$subject/$data_source/$part | grep 'gold_conll$')
	    do
		echo -n "$subject,$data_source,$part,$file," >> $target_file
		awk '/^$/{x++}END{print x}' $data_dir/$subject/$data_source/$part/$file >> $target_file
	    done
	done
    done
done
	    
R CMD BATCH --vanilla --salve $rscript_path