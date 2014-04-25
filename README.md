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
  * -> result/raw-data/data1-train.list
  * -> result/raw-data/data1-test.list
  * -> result/raw-data/data2-train.list
  * -> result/raw-data/data2-test.list
+ scripts/clean.sh 
  * -> result/clean-data/data1-train-remove.list
  * -> result/clean-data/data1-train-clean.list
  * -> result/clean-data/data1-test-remove.list
  * -> result/clean-data/data1-test-clean.list
  * -> result/clean-data/data2-train-remove.list
  * -> result/clean-data/data2-train-clean.list
  * -> result/clean-data/data2-test-remove.list
  * -> result/clean-data/data2-test-clean.list
+ scripts/analyse 
  * -> csv/data1-whole.list
  * -> csv/data2-whole.list
  * -> csv/data-whole.list
  * -> graph/data1_entity.pdf
  * -> graph/data1_sentence.pdf
  * -> graph/data2_entity.pdf
  * -> graph/data2_sentence.pdf

Invoking Detail
-------------------
+ script.sh
  * -> main.py
+ clean.sh
+ analyse.sh
  * -> analyse.py
  * -> analyse.R
