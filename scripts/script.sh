#!/bin/bash
# script.sh

# dir
work_dir=$(pwd)
raw_dir="${work_dir}/../result/raw-data"
grid_dir="${work_dir}/../sampling"
result_dir="${work_dir}/../result"

# path
list_path="${result_dir}/result-Acc.list"
pyscript_path="${work_dir}/main.py"

# new version:
: > $list_path

# new version:
for part in $(ls ${grid_dir})
do
    echo "coming into $part -----"
    for grid in $(ls ${grid_dir}/${part} | grep '.grid$')
    do
	echo "    computing $grid"
	echo -n "$grid " >> $list_path
	python ${pyscript_path} ${grid_dir}/${part}/${grid} >> $list_path
    done
done

exit 0