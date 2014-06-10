#!/bin/bash
# grid.sh

work_dir=$(pwd)
pyscript_path="${work_dir}/grid.py"
sampling_dir="${work_dir}/../sampling"

for part in $(ls ${sampling_dir})
do
    echo "part: ${part}: -------------------"
    for conll in $(ls ${sampling_dir}/${part})
    do
	python $pyscript_path --benchmark ${sampling_dir}/${part}/${conll} ${sampling_dir}/${part}
    done
done

