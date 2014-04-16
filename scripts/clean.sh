#!/bin/bash
# clean.sh

#  Clean data[(1)|(2)]_[(train)|(test)]_grid_file.list.
#  Some files in the data[(1)|(2)]_[(train)|(test)] is empty,
#  so we have to remove these record and others with the same
#+ original document name from data[(1)|(2)]_[(train)|(test)]_grid_file.list

work_dir=$(pwd)
raw_dir="${work_dir}/../result/raw-data"
clean_dir="${work_dir}/../result/clean-data"

list_1="${raw_dir}/data1-train.list"
list_2="${raw_dir}/data1-test.list"
list_3="${raw_dir}/data2-train.list"
list_4="${raw_dir}/data2-test.list"

list_remove_1="${clean_dir}/data1-train-remove.list"
list_remove_2="${clean_dir}/data1-test-remove.list"
list_remove_3="${clean_dir}/data2-train-remove.list"
list_remove_4="${clean_dir}/data2-test-remove.list"

list_clean_1="${clean_dir}/data1-train-clean.list"
list_clean_2="${clean_dir}/data1-test-clean.list"
list_clean_3="${clean_dir}/data2-train-clean.list"
list_clean_4="${clean_dir}/data2-test-clean.list"

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
