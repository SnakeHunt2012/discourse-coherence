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
  * -> result/data1-train.list
  * -> result/data1-test.list
  * -> result/data2-train.list
  * -> result/data2-test.list
+ scripts/clean.sh 
  * -> result/data1-train-remove.list
  * -> result/data1-train-clean.list
  * -> result/data1-test-remove.list
  * -> result/data1-test-clean.list
  * -> result/data2-train-remove.list
  * -> result/data2-train-clean.list
  * -> result/data2-test-remove.list
  * -> result/data2-test-clean.list
+ scripts/analyse 
  * -> result/data1-whole.list
  * -> result/data2-whole.list
  * -> result/data-whole.list

Invoking Detail
-------------------
+ script.sh -> main.py
+ clean.sh
+ analyse.sh -> analyse.py
