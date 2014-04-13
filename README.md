discourse-coherence
===================

USAGE
-------------------
1. shell >> cd /path/to/discourse-coherence/
2. shell >> ./scripts/script.sh
3. shell >> ./scripts/clean.sh
4. shell >> ./analyse.sh

Generation Detail
-------------------
+ scripts/script.sh 
  * -> result/data1_train_grid_file.list
  * -> result/data1_test_grid_file.list
  * -> result/data2_train_grid_file.list
  * -> result/data2_test_grid_file.list
+ scripts/clean.sh 
  * -> result/data1_train_grid_file_remove.list
  * -> result/data1_train_grid_file_clean.list
  * -> result/data1_test_grid_file_remove.list
  * -> result/data1_test_grid_file_clean.list
  * -> result/data2_train_grid_file_remove.list
  * -> result/data2_train_grid_file_clean.list
  * -> result/data2_test_grid_file_remove.list
  * -> result/data2_test_grid_file_clean.list
+ scripts/analyse 
  * -> result/data1_whole.list
  * -> result/data2_whole.list
  * -> result/data_whole.list

Invoking Detail
-------------------
+ script.sh -> main.py
+ clean.sh
+ analyse.sh -> analyse.py
