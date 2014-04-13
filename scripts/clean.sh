#!/bin/bash
# clean.sh

#  Clean data[(1)|(2)]_[(train)|(test)]_grid_file.list.
#  Some files in the data[(1)|(2)]_[(train)|(test)] is empty,
#  so we have to remove these record and others with the same
#+ original document name from data[(1)|(2)]_[(train)|(test)]_grid_file.list

work_dir=$(pwd)
result_dir="${work_dir}/../result"

list_1="${result_dir}/data1_train_grid_file.list"
list_2="${result_dir}/data1_test_grid_file.list"
list_3="${result_dir}/data2_train_grid_file.list"
list_4="${result_dir}/data2_test_grid_file.list"

list_remove_1="${result_dir}/data1_train_grid_file_remove.list"
list_remove_2="${result_dir}/data1_test_grid_file_remove.list"
list_remove_3="${result_dir}/data2_train_grid_file_remove.list"
list_remove_4="${result_dir}/data2_test_grid_file_remove.list"

list_clean_1="${result_dir}/data1_train_grid_file_clean.list"
list_clean_2="${result_dir}/data1_test_grid_file_clean.list"
list_clean_3="${result_dir}/data2_train_grid_file_clean.list"
list_clean_4="${result_dir}/data2_test_grid_file_clean.list"

# data1_train - 1
cat "$list_1" | \
    # remove lines without average out-degree
    sed -n '/grid $/p' | \
    # extract prefix
    sed 's/perm.*//g'  | \
    # remove duplicated records
    awk '!a[$0]++'  > \
    $list_remove_1

cat "$list_1" > "$list_clean_1"
for record in `cat $list_remove_1`
do
    sed -i "/$record/d" $list_clean_1
done

# data1_test - 2
cat "$list_2" | \
    # remove lines without average out-degree
    sed -n '/grid $/p' | \
    # extract prefix
    sed 's/perm.*//g'  | \
    # remove duplicated records
    awk '!a[$0]++'  > \
    $list_remove_2

cat "$list_2" > "$list_clean_2"
for record in `cat $list_remove_2`
do
    sed -i "/$record/d" $list_clean_2
done

# data2_train - 3
cat "$list_3" | \
    # remove lines without average out-degree
    sed -n '/grid $/p' | \
    # extract prefix
    sed 's/perm.*//g'  | \
    # remove duplicated records
    awk '!a[$0]++'  > \
    $list_remove_3

cat "$list_3" > "$list_clean_3"
for record in `cat $list_remove_3`
do
    sed -i "/$record/d" $list_clean_3
done

# data2_test - 4
cat "$list_4" | \
    # remove lines without average out-degree
    sed -n '/grid $/p' | \
    # extract prefix
    sed 's/perm.*//g'  | \
    # remove duplicated records
    awk '!a[$0]++'  > \
    $list_remove_4

cat "$list_4" > "$list_clean_4"
for record in `cat $list_remove_4`
do
    sed -i "/$record/d" $list_clean_4
done
