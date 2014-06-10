#!/bin/bash
# feature.sh

# dirs
work_dir=$(pwd)
sampling_dir=${work_dir}/../sampling
csv_dir=${work_dir}/../csv

# paths
pyscript_path=${work_dir}/feature.py
csv_path=${csv_dir}/permutation-features.csv

# create or clean csv file
: > ${csv_path}

for zone in $(ls ${sampling_dir})
do
    subject=$(echo $zone | awk -F '[ _]' '{print $1}')
    index_begin=$(echo $zone | awk -F '[ _]' '{print $2}')
    index_end=$(echo $zone | awk -F '[ _]' '{print $3}')
    for grid in $(ls ${sampling_dir}/${zone} | grep '.grid$')
    do
	grid_path=${sampling_dir}/${zone}/${grid}
	source=$(echo $grid | awk -F '[-]' '{print $2}')
	part_id=$(echo $grid | awk -F '[-]' '{print $3}')
	discourse_id=$(echo $grid | awk -F '[-_.]' '{print $5}')
	permutation_id=$(echo $grid | awk -F '[-_.]' '{print $7}')
	echo -n "${subject},${index_begin},${index_end},${source},${part_id},${discourse_id},${permutation_id}," >> $csv_path
	python ${pyscript_path} ${grid_path} >> $csv_path
    done
done