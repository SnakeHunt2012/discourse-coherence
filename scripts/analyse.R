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

## plot #1: data1-sentence
# P_U - g
# P_W - b
# P_Acc - r
pdf("data1_sentence.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 0));
data1_sentence_U <- read.csv("../csv/P-U/data1-sentence-accuracy.csv", header=F, sep=",");
data1_sentence_W <- read.csv("../csv/P-W/data1-sentence-accuracy.csv", header=F, sep=",");
data1_sentence_Acc <- read.csv("../csv/P-Acc/data1-sentence-accuracy.csv", header=F, sep=",");
title = "Newspaper Articles";
x_lab = "Length of Discourse";
y_lab = "Accuracy";
par(family = "serif")
par(ps = 20)
plot(data1_sentence_Acc$V1, data1_sentence_Acc$V3, type = "b", col = "red", main = title, xlab = x_lab, ylab = y_lab);
lines(data1_sentence_W$V1, data1_sentence_W$V3, type = "b", col = "blue");
lines(data1_sentence_U$V1, data1_sentence_U$V3, type = "b", col = "green");
legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()

## plot #2: data1-entity
# P_U - g
# P_W - b
# P_Acc - r
pdf("data1_entity.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 0));
data1_entity_U <- read.csv("../csv/P-U/data1-entity-accuracy.csv", header=F, sep=",");
data1_entity_W <- read.csv("../csv/P-W/data1-entity-accuracy.csv", header=F, sep=",");
data1_entity_Acc <- read.csv("../csv/P-Acc/data1-entity-accuracy.csv", header=F, sep=",");
title = "Newspaper Articles";
x_lab = "Number of Entity";
y_lab = "Accuracy";
par(family = "serif")
par(ps = 20)
plot(data1_entity_Acc$V1, data1_entity_Acc$V3, type = "b", col = "red", main = title, xlab = x_lab, ylab = y_lab)
lines(data1_entity_W$V1, data1_entity_W$V3, type = "b", col = "blue")
lines(data1_entity_U$V1, data1_entity_U$V3, type = "b", col = "green")
legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()

## plot #3: data2-sentence
# P_U - g
# P_W - b
# P_Acc - r
pdf("data2_sentence.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 0));
data2_sentence_U <- read.csv("../csv/P-U/data2-sentence-accuracy.csv", header=F, sep=",");
data2_sentence_W <- read.csv("../csv/P-W/data2-sentence-accuracy.csv", header=F, sep=",");
data2_sentence_Acc <- read.csv("../csv/P-Acc/data2-sentence-accuracy.csv", header=F, sep=",");
title = "Accident Reports Written by Government Officials";
x_lab = "Length of Discourse"
y_lab = "Accuracy";
par(family = "serif")
par(ps = 20)
plot(data2_sentence_W$V1, data2_sentence_W$V3, type = "b", col = "blue", main = title, xlab = x_lab, ylab = y_lab)
lines(data2_sentence_Acc$V1, data2_sentence_Acc$V3, type = "b", col = "red")
lines(data2_sentence_U$V1, data2_sentence_U$V3, type = "b", col = "green")
legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()

## graph #4: data2-entity
# P_U - g
# P_W - b
# P_Acc - r
pdf("data2_entity.pdf", width = 10 + 1, height = 6 + 1)
par(pin = c(10, 6), mai = c(1, 1, 1, 0));
data2_entity_U <- read.csv("../csv/P-U/data2-entity-accuracy.csv", header=F, sep=",");
data2_entity_W <- read.csv("../csv/P-W/data2-entity-accuracy.csv", header=F, sep=",");
data2_entity_Acc <- read.csv("../csv/P-Acc/data2-entity-accuracy.csv", header=F, sep=",");
title = "Accident Reports Written by Government Officials";
par(family = "serif")
x_lab = "Number of Entity";
par(ps = 20)
plot(data2_entity_Acc$V1, data2_entity_Acc$V3, type = "b", col = "red", main = title, xlab = x_lab, ylab = y_lab)
lines(data2_entity_W$V1, data2_entity_W$V3, type = "b", col = "blue")
lines(data2_entity_U$V1, data2_entity_U$V3, type = "b", col = "green")
legend("bottomright", c("U", "W", "Acc"), title = "Strategy Type", lty = c(1, 1, 1), col = c("green", "blue", "red"));
dev.off()
