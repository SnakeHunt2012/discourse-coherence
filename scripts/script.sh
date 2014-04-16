#!/bin/bash
# script.sh

work_dir=$(pwd)
raw_dir="${work_dir}/../result/raw-data"
data1_train_dir="${work_dir}/../data/data1-train"
data1_test_dir="${work_dir}/../data/data1-test"
data2_train_dir="${work_dir}/../data/data2-train"
data2_test_dir="${work_dir}/../data/data2-test"

data1_train_grid_list_file="${raw_dir}/data1-train.list"
data1_test_grid_list_file="${raw_dir}/data1-test.list"
data2_train_grid_list_file="${raw_dir}/data2-train.list"
data2_test_grid_list_file="${raw_dir}/data2-test.list"

# data1_train
cd $data1_train_dir

: > $data1_train_grid_list_file

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
cd $data1_test_dir

: > $data1_test_grid_list_file

for file in $(ls)
do
    if echo "$file" | grep -q '.grid$'
    then
	file_path="${data1_test_dir}/${file}"
	main_path="${work_dir}/main.py"
	echo "computing $file"
	echo "${file} $(${main_path} ${file_path})" >> $data1_test_grid_list_file
    fi
done

# data2_train
cd $data2_train_dir

: > $data2_train_grid_list_file

for file in $(ls)
do
    if echo "$file" | grep -q '.grid$'
    then
	file_path="${data2_train_dir}/${file}"
	main_path="${work_dir}/main.py"
	echo "computing $file"
	echo "${file} $(${main_path} ${file_path})" >> $data2_train_grid_list_file
    fi
done

# data2_test
cd $data2_test_dir

: > $data2_test_grid_list_file

for file in $(ls)
do
    if echo "$file" | grep -q '.grid$'
    then
	file_path="${data2_test_dir}/${file}"
	main_path="${work_dir}/main.py"
	echo "computing $file"
	echo "${file} $(${main_path} ${file_path})" >> $data2_test_grid_list_file
    fi
done

exit 0