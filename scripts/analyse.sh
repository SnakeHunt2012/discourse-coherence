#!/bin/bash
# analyse.sh

# Generate testing result from data[(1)|(2)]_[(train)|(test)]_grid_file.list.
#
# The result output:
# 1. Accuracy at data1_train
# 2. Accuracy at data1_test
# 3. Accuracy at data2_train
# 4. Accuracy at data2_test
# 5. Accuracy at data set 1 (e.t. data1_train + data1_test)
# 6. Accuracy at data set 2 (e.t. data2_train + data2_test)
# 7. Accuracy at whole data (data1_train + data1_test + data2_train + data2_test)

work_dir=$(pwd)
result_dir="${work_dir}/../result"

list_clean_1="${result_dir}/data1_train_grid_file_clean.list"
list_clean_2="${result_dir}/data1_test_grid_file_clean.list"
list_clean_3="${result_dir}/data2_train_grid_file_clean.list"
list_clean_4="${result_dir}/data2_test_grid_file_clean.list"

list_data1="${result_dir}/data1_whole.list"
list_data2="${result_dir}/data2_whole.list"
list_data_whole="${result_dir}/data_whole.list"

: > "$list_data1"
: > "$list_data2"
: > "$list_data_whole"

# generate $list_data1
cat "$list_clean_1" >> "$list_data1"
cat "$list_clean_2" >> "$list_data1"

# generate $list_data2
cat "$list_clean_3" >> "$list_data2"
cat "$list_clean_4" >> "$list_data2"

# generate $list_data_whole
cat "$list_clean_1" >> "$list_data_whole"
cat "$list_clean_2" >> "$list_data_whole"
cat "$list_clean_3" >> "$list_data_whole"
cat "$list_clean_4" >> "$list_data_whole"

# print result
echo "Accuracy at data1_train: $(python ${work_dir}/analyse.py ${list_clean_1})"
echo "Accuracy at data1_test: $(python ${work_dir}/analyse.py ${list_clean_2})"
echo "Accuracy at data2_train: $(python ${work_dir}/analyse.py ${list_clean_3})"
echo "Accuracy at data2_test: $(python ${work_dir}/analyse.py ${list_clean_4})"
echo "Accuracy at data set 1: $(python ${work_dir}/analyse.py ${list_data1})"
echo "Accuracy at data set 2: $(python ${work_dir}/analyse.py ${list_data2})"
echo "Accuracy at whole data: $(python ${work_dir}/analyse.py ${list_data_whole})"
