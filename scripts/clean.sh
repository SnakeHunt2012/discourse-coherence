#!/bin/bash
# clean.sh

#  Clean data[(1)|(2)]_[(train)|(test)]_grid_file.list.
#  Some files in the data[(1)|(2)]_[(train)|(test)] is empty,
#  so we have to remove these record and others with the same
#+ original document name from data[(1)|(2)]_[(train)|(test)]_grid_file.list

list_1="data1_train_grid_file.list"
list_2="data1_test_grid_file.list"
list_3="data2_train_grid_file.list"
list_4="data2_test_grid_file.list"

list_remove_1="data1_train_grid_file_remove.list"
list_remove_2="data1_test_grid_file_remove.list"
list_remove_3="data2_train_grid_file_remove.list"
list_remove_4="data2_test_grid_file_remove.list"

list_clean_1="data1_train_grid_file_clean.list"
list_clean_2="data1_test_grid_file_clean.list"
list_clean_3="data2_train_grid_file_clean.list"
list_clean_4="data2_test_grid_file_clean.list"

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