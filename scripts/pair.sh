#!/bin/bash
# pair.sh

# dirs
work_dir=$(pwd)
csv_dir=${work_dir}/../csv
benchmark_dir=${work_dir}/../benchmark

# paths
pyscript_path=${work_dir}/pair.py
csv_path=${csv_dir}/permutation-features.csv
output_path=${benchmark_dir}/benchmark-one.dat

# pair
python ${pyscript_path} ${csv_path} > ${output_path}
