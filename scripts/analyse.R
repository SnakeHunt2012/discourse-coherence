#!/usr/bin/env R
# analyse.R
# histgram #1: sentence
#pdf("mygraph.pdf", width = 9 + 1, height = 4 + 1);
#par(pin = c(9, 4), mai = c(1, 1, 1, 0));
#title = "Newspaper Articles";
#barplot(data1_sentence_accuracy$V2, main = title, col = "grey", ylab = "Number of Discourses", xlab = "Length of Discourse", names.arg = as.character(data1_sentence_accuracy$V1));
#dev.off();

# histgram #2: entity
#pdf("mygraph.pdf", width = 9 + 1, height = 4 + 1)
#par(pin = c(9, 4), mai = c(1, 1, 1, 0))
#title = "Accident Reports Written by Government Officials";
#barplot(data2_sentence_accuracy$V2, main = title, col = "grey", ylab = "Number of Discourses", xlab = "Length of Discourse", names.arg = as.character(data2_sentence_accuracy$V1));
#dev.off();

## plot #1: sentence
# P_U - g
# P_W - b
# P_Acc - r
pdf("../graph/accuracy-sentence.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
sentence_U <- read.csv("../csv/P-U/sentence-accuracy.csv", header=F, sep=",");
#sentence_W <- read.csv("../csv/P-W/sentence-accuracy.csv", header=F, sep=",");
#sentence_Acc <- read.csv("../csv/P-Acc/sentence-accuracy.csv", header=F, sep=",");
title = "Newspaper Articles";
x_lab = "Length of Discourse";
y_lab = "Accuracy";
par(family = "serif")
par(ps = 20)
plot(sentence_U$V1, sentence_U$V3, type = "b", col = "green", main = title, xlab = x_lab, ylab = y_lab);
#lines(sentence_W$V1, sentence_W$V3, type = "b", col = "blue");
#lines(sentence_Acc$V1, sentence_Acc$V3, type = "b", col = "red");
#legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()

## plot #2: entity
# P_U - g
# P_W - b
# P_Acc - r
pdf("../graph/accuracy-entity.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
entity_U <- read.csv("../csv/P-U/entity-accuracy.csv", header=F, sep=",");
#entity_W <- read.csv("../csv/P-W/entity-accuracy.csv", header=F, sep=",");
#entity_Acc <- read.csv("../csv/P-Acc/entity-accuracy.csv", header=F, sep=",");
title = "Newspaper Articles";
x_lab = "Number of Entity";
y_lab = "Accuracy";
par(family = "serif")
par(ps = 20)
plot(entity_U$V1, entity_U$V3, type = "b", col = "green", main = title, xlab = x_lab, ylab = y_lab)
#lines(entity_W$V1, entity_W$V3, type = "b", col = "blue")
#lines(entity_Acc$V1, entity_Acc$V3, type = "b", col = "green")
#legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()
