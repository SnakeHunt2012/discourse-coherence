#!/bin/bash
# analyse-final.sh

# dirs
work_dir=$(pwd)
result_dir="${work_dir}/../result"
csv_dir="${work_dir}/../csv"

# paths
pyscript_path="${work_dir}/analyse.py"
rscript_path="${work_dir}/analyse-final.R"
U_result_path=${result_dir}/result-U.list
W_result_path=${result_dir}/result-W.list
Acc_result_path=${result_dir}/result-Acc.list
U_discourse_path=${result_dir}/discourse-U.list
W_discourse_path=${result_dir}/discourse-W.list
Acc_discourse_path=${result_dir}/discourse-Acc.list
U_csv_path=${csv_dir}/discourse-U.csv
W_csv_path=${csv_dir}/discourse-W.csv
Acc_csv_path=${csv_dir}/discourse-Acc.csv

# create or clean
touch $U_discourse_path
touch $W_discourse_path
touch $Acc_discourse_path
touch $U_csv_path
touch $W_csv_path
touch $Acc_csv_path
: > $U_discourse_path
: > $W_discourse_path
: > $Acc_discourse_path
: > $U_csv_path
: > $W_csv_path
: > $Acc_csv_path

# create discourse-X.list: discourse_id entity_amount sentence_amount positive_amount negative_amount share_rate
python $pyscript_path --discourse-list $U_result_path > $U_discourse_path
python $pyscript_path --discourse-list $W_result_path > $W_discourse_path
python $pyscript_path --discourse-list $Acc_result_path > $Acc_discourse_path

# create disocurse-X.csv: 
#python $pyscript_path --discourse-csv $U_discourse_path > $U_csv_path
#python $pyscript_path --discourse-csv $W_discourse_path > $W_csv_path
#python $pyscript_path --discourse-csv $Acc_discourse_path > $Acc_csv_path

echo "subject,source,discourse_id,entity_amount,sentence_amount,positive,negative,share_rate" >> $U_csv_path
while read line
do
    discourse=$(echo $line | awk '{print $1}')

    subject=$(echo $discourse | awk -F '[-]' '{print $1}')
    source=$(echo $discourse | awk -F '[-]' '{print $2}')
    part=$(echo $discourse | awk -F '[-]' '{print $3}')
    discourse_id=$(echo $discourse | awk -F '[-]' '{print $4}')

    entity_amount=$(echo $line | awk '{print $2}')
    sentence_amount=$(echo $line | awk '{print $3}')
    positive=$(echo $line | awk '{print $4}')
    negative=$(echo $line | awk '{print $5}')
    share_rate=$(echo $line | awk '{print $6}')

    echo "${subject},${source},${discourse_id},${entity_amount},${sentence_amount},${positive},${negative},${share_rate}" >> $U_csv_path
done <$U_discourse_path

echo "subject,source,discourse_id,entity_amount,sentence_amount,positive,negative,share_rate" >> $W_csv_path
while read line
do
    discourse=$(echo $line | awk '{print $1}')

    subject=$(echo $discourse | awk -F '[-]' '{print $1}')
    source=$(echo $discourse | awk -F '[-]' '{print $2}')
    part=$(echo $discourse | awk -F '[-]' '{print $3}')
    discourse_id=$(echo $discourse | awk -F '[-]' '{print $4}')

    entity_amount=$(echo $line | awk '{print $2}')
    sentence_amount=$(echo $line | awk '{print $3}')
    positive=$(echo $line | awk '{print $4}')
    negative=$(echo $line | awk '{print $5}')
    share_rate=$(echo $line | awk '{print $6}')

    echo "${subject},${source},${discourse_id},${entity_amount},${sentence_amount},${positive},${negative},${share_rate}" >> $W_csv_path
done <$W_discourse_path

echo "subject,source,discourse_id,entity_amount,sentence_amount,positive,negative,share_rate" >> $Acc_csv_path
while read line
do
    discourse=$(echo $line | awk '{print $1}')

    subject=$(echo $discourse | awk -F '[-]' '{print $1}')
    source=$(echo $discourse | awk -F '[-]' '{print $2}')
    part=$(echo $discourse | awk -F '[-]' '{print $3}')
    discourse_id=$(echo $discourse | awk -F '[-]' '{print $4}')

    entity_amount=$(echo $line | awk '{print $2}')
    sentence_amount=$(echo $line | awk '{print $3}')
    positive=$(echo $line | awk '{print $4}')
    negative=$(echo $line | awk '{print $5}')
    share_rate=$(echo $line | awk '{print $6}')

    echo "${subject},${source},${discourse_id},${entity_amount},${sentence_amount},${positive},${negative},${share_rate}" >> $Acc_csv_path
done <$Acc_discourse_path