#!/usr/bin/env R
# try.R

data <- read.csv(file="./result.csv", header=TRUE, colClasses=c("factor", "character", "integer", "integer"));
sum(data$no_co_occurrence_amount) / sum(data$pair_amount);

# for bn data
sub_data <- data[which(data$length_interval == "bn_0_5"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_5_10"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_10_15"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_15_20"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_20_25"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_25_30"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_30_35"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_35_40"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_40_45"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "bn_45_50"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

# for nw data
sub_data <- data[which(data$length_interval == "nw_0_5"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_5_10"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_10_15"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_15_20"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_20_25"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_25_30"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_30_35"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_35_40"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_40_45"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

sub_data <- data[which(data$length_interval == "nw_45_50"),];
sum(sub_data$no_co_occurrence_amount) / sum(sub_data$pair_amount);

