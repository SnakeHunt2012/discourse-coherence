#!/bin/bash
# script.sh

work_dir=$(pwd)
data1_train_dir="${work_dir}/../data/data1-train"
data1_test_dir="${work_dir}/data/data1-test"
data2_train_dir="${work_dir}/data/data2-train"
data2_test_dir="${work_dir}/data/data2-test"

data1_train_grid_list_file="${work_dir}/data1_train_grid_file.list"
data1_test_grid_list_file="${work_dir}/data1_test_grid_file.list"
data2_train_grid_list_file="${work_dir}/data2_train_grid_file.list"
data2_test_grid_list_file="${work_dir}/data2_test_grid_file.list"

#data1_train_grid_log_file="${work_dir}/data1_train_grid_file.log"
#data1_test_grid_log_file="${work_dir}/data1_test_grid_file.log"
#data2_train_grid_log_file="${work_dir}/data2_train_grid_file.log"
#data2_test_grid_log_file="${work_dir}/data2_test_grid_file.log"

# data1_train
cd $data1_train_dir

: > $data1_train_grid_list_file
#
	: > $data1_train_grid_log_file

for file in $(ls)
do
    if echo "$file" | grep -q '.grid$'
    then
	file_path="${data1_train_dir}/${file}"
	main_path="${work_dir}/main.py"
	echo "computing $file"
	echo "${file} $(${main_path} ${file_path})" >> $data1_train_grid_list_file
    fi
done

# data1_test

# data2_train

# data2_test

exit 0