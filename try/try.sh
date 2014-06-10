#!/bin/bash
# try.sh

work_dir=$(pwd)
pyscript_path="${work_dir}/../scripts/grid.py"
sampling_dir="${work_dir}/../sampling"

# csv header
echo "length_interval,file_name,pair_amount,no_co_occurrence_amount"
for part in $(ls ${sampling_dir})
do
    #echo "----------- ${part} -----------"
    for conll in $(ls ${sampling_dir}/${part} | grep '_conll$')
    do
	echo -n "${part},${conll},"
	python ${pyscript_path} -U ${sampling_dir}/${part}/${conll} test
    done
done