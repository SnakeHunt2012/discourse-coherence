discourse-coherence
===================

USAGE
-------------------
1. shell >> cd /path/to/discourse-coherence/
2. shell >> ./scripts/script.sh
3. shell >> ./scripts/clean.sh
4. shell >> ./scripts/analyse.sh

Data Detail
-------------------
+ ./result/
  这个文件夹下面存放的是有意义的临时数据
  + raw-data
    这些文件都是用main.py处理而成的，内容为不同permutation对应的连贯性指数等信息，文件每一行的格式均为"<文章名> <连贯性得分> <实体数量> <句子数量>"，一行一个permutation。这四组数据分别对应原数据集里的data1-train, data1-test, data2-train, data2-test这四个子数据集，我把每个子数据集单独存放。
    * data1-train.list
    * data1-test.list
    * data2-train.list
    * data2-test.list
  + clean-data
    这个文件夹下面存放的是清理后的raw-data，这是因为在原数据集中存在空的permutation，为公平起见，我将这些permutation所对应的原permutation及其shuffle所产生的其他permutation全部剔除。这个目录下所存放的就是用clean.sh剔除之后的raw-data数据，这部分数据可以直接用来进行结果分析。 
    * xxx-clean.list
      用clean.sh剔除之后的raw-data数据
    * xxx-remove.list
      为了生成xxx-clean.list而删除的文章列表
    * data1-whole.list
      data1-test-clean.list + data1-train-clean.list
    * data2-whole.list
      data2-test-clean.list + data2-train-clean.list
    * data-whole.list
      data1-whole.list + data2-whole.list
  + analyse-data
    目前为空
+ ./csv/
  这个文件夹下面放的是三种边权重计算方法在数据上的测试结果，以.csv文件形式存储
  + ./result/P-U
    对应于第一种边权重计算方法，只要相邻两个句子有公共实体边权重即为1，否则为0。
    * Accuracy.log
      里面一共有7行，分别代表我们的模型在各个数据集上面的准确度。
    * data1-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-permutation-accuracy.csv
      这部分数据没什么用
    * data2-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-permutation-accuracy.csv
      这部分数据没什么用
  + ./result/P-W
    对应于第一种边权重计算方法，边权重的值为相邻两个句子所共享的实体的数量。
    * Accuracy.log
      里面一共有7行，分别代表我们的模型在各个数据集上面的准确度。
    * data1-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-permutation-accuracy.csv
      这部分数据没什么用
    * data2-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-permutation-accuracy.csv
      这部分数据没什么用
  + ./result/P-Acc
    对应于第一种边权重计算方法，边权重为相邻两个句内中，句子与公共实体所形成的带权边的权权重的向量积。
    * Accuracy.log
      里面一共有7行，分别代表我们的模型在各个数据集上面的准确度。
    * data1-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data1数据集。
    * data1-permutation-accuracy.csv
      这部分数据没什么用
    * data2-entity-accuracy.csv
      这部分数据统计的是我们的模型的准确度在拥有不同实体数量的文章上的准确度，每行的格式为"<实体数量>,<拥有这么多实体的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-sentence-accuracy.csv
      这部分数据统计的是我们的模型的准确度在不同长度的文章上的准确度，每行的格式为"<句子数量>,<拥有这么多句子的文章有多少篇>,<我们的模型在这些文章上面的准确度>"，统计于data2数据集。
    * data2-permutation-accuracy.csv
      这部分数据没什么用

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

Scripts Invoking Detail
-------------------
+ script.sh
  对指定目录下所存放的所有.grid文件计算连贯性指数
  * -> main.py
+ clean.sh
  摘除空permutation及其相关permutation
+ analyse.sh
  分析模型在不同长度的文章上和不同实体数量的文章掌上的表现
  * -> analyse.py
  生成统计数据
  * -> analyse.R
  画图

Functions Invoking Detail
-------------------
+ main.py
  输入为.grid文件，输出为这个表格所转化的图的平均出度。
  + main()
    * -> grid_parse()
    * -> grid_to_graph()
  + grid_parse()
  + grid_to_graph()
    * -> connection_between_sentences()
    * -> edge_version_1()
    * -> edge_version_2()
    * -> edge_version_3()
  + connection_between_sentences()
  + edge_version_1()
  + edge_version_2()
  + edge_version_3()
    * -> edge_weight_entity_sentence()
  + edge_weight_entity_sentence()
+ analyse.py
  输入为.list文件，输出为清理过后的.list文件。
  + main()
    * -> parse_record_file()
    * -> group_permutations()
    * -> compute_accuracy()
    * -> group_discourse_by_entity_amount()
    * -> group_discourse_by_sentence_amount()
    * -> count_discourse_by_entity_amount()
    * -> count_discourse_by_sentence_amount()
  + parse_record_file()
  + group_permutations()
  + compute_accuracy()
  + group_discourse_by_entity_amount()
  + group_discourse_by_sentence_amount()
  + count_discourse_by_entity_amount()
  + count_discourse_by_sentence_amount()
  
Class Detail(in grid.py)
-------------------
+ class Discourse
  * identity
  * sentence_amount
  * sentence_list -> class Sentence
+ class Sentence
  * token_amount
  * token_list -> class Token
+ class Token
  * word_itself
  * part_of_speech
  * phrase_bit
  * resolute_op rator_list-> class Resolute_Operator

 +-----------------+
 | Discourse       |
 +-----------------+
 | identity        |
 | sentence_amount |	  +--------------+
 | sentence_list   |----> | Sentence     |
 +-----------------+	  +--------------+
			  | token_amount |	+------------------------+
			  | token_list   |----> | Token                  |
			  +--------------+	+------------------------+
						| word_itself            |
						| part_of_speech         |
						| phrase_bit             |	+-------------------+
						| resolute_operator_list |----> | Resolute_Operator |
						+------------------------+	+-------------------+
										| identity          |
										| operation         |
										+-------------------+

