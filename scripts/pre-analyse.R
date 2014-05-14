#!/usr/bin/env R
# pre-analyse.R

whole_data <- read.csv("../csv/subject-source-part-file-length.csv", header=T, sep=",")

levels_subject <- levels(whole_data$subject)
levels_source <- levels(whole_data$source)
levels_file <- levels(whole_data$file)

sub_data <- whole_data[which(whole_data$subject == "bc"),];
pdf("../graph/pre-analyse-pdf/bc.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of bc");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "bn"),];
pdf("../graph/pre-analyse-pdf/bn.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of bn");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "mz"),];
pdf("../graph/pre-analyse-pdf/mz.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of mz");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "nw"),];
pdf("../graph/pre-analyse-pdf/nw.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of nw");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "pt"),];
pdf("../graph/pre-analyse-pdf/pt.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of pt");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "tc"),];
pdf("../graph/pre-analyse-pdf/tc.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of tc");
rug(jitter(sub_data$length));
dev.off();

sub_data <- whole_data[which(whole_data$subject == "wb"),];
pdf("../graph/pre-analyse-pdf/wb.pdf", width = 10 + 1, height = 6 + 1);
par(pin = c(10, 6), mai = c(1, 1, 1, 1));
hist(sub_data$length, breaks=100, col = "gray", xlab = "Length of Discourse", main = "Histogram of wb");
rug(jitter(sub_data$length));
dev.off();
