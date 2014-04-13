discourse-coherence
===================

* USAGE
-------------------
0. shell >> cd /path/to/discourse-coherence/
1. shell >> ./scripts/script.sh
2. shell >> ./scripts/clean.sh
3. shell >> python ./scripts/analyse.py ./result/data1_train_grid_file.list 
4. shell >> python ./scripts/analyse.py ./result/data1_test_grid_file.list 
5. shell >> python ./scripts/analyse.py ./result/data2_train_grid_file.list 
6. shell >> python ./scripts/analyse.py ./result/data2_test_grid_file.list 

* Generation Detail
-------------------
** scripts/script.sh -> result/data1_train_grid_file.list 
 	   	     -> result/data1_test_grid_file.list
		     -> result/data2_train_grid_file.list
	     	     -> result/data2_test_grid_file.list
** scripts/clean.sh -> result/data1_train_grid_file_remove.list
	    	    -> result/data1_train_grid_file_clean.list
   	    	    -> result/data1_test_grid_file_remove.list
	    	    -> result/data1_test_grid_file_clean.list
	    	    -> result/data2_train_grid_file_remove.list
	    	    -> result/data2_train_grid_file_clean.list
	    	    -> result/data2_test_grid_file_remove.list
	    	    -> result/data2_test_grid_file_clean.list

* Invoking Detail
-------------------
** script.sh -> main.py
** clean.sh
** analyse.py
