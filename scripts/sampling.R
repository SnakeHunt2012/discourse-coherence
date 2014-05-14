#!/usr/bin/evn R
# sampling.R

whole_data <- read.csv("../csv/subject-source-part-file-length.csv", header=T, sep=",", colClasses = c("factor", "factor", "factor", "factor", "integer"));

# bn
bn_0_5 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 0 & whole_data$length <= 5),];
bn_5_10 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 5 & whole_data$length <= 10),];
bn_10_15 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 10 & whole_data$length <= 15),];
bn_15_20 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 15 & whole_data$length <= 20),];
bn_20_25 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 20 & whole_data$length <= 25),];
bn_25_30 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 25 & whole_data$length <= 30),];
bn_30_35 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 30 & whole_data$length <= 35),];
bn_35_40 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 35 & whole_data$length <= 40),];
bn_40_45 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 40 & whole_data$length <= 45),];
bn_45_50 <- whole_data[which(whole_data$subject == "bn" & whole_data$length > 45 & whole_data$length <= 50),];

# nw
nw_0_5 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 0 & whole_data$length <= 5),];
nw_5_10 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 5 & whole_data$length <= 10),];
nw_10_15 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 10 & whole_data$length <= 15),];
nw_15_20 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 15 & whole_data$length <= 20),];
nw_20_25 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 20 & whole_data$length <= 25),];
nw_25_30 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 25 & whole_data$length <= 30),];
nw_30_35 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 30 & whole_data$length <= 35),];
nw_35_40 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 35 & whole_data$length <= 40),];
nw_40_45 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 40 & whole_data$length <= 45),];
nw_45_50 <- whole_data[which(whole_data$subject == "nw" & whole_data$length > 45 & whole_data$length <= 50),];

# bn sampling
bn_0_5_sampling <- bn_0_5[sample(1:nrow(bn_0_5), 30, replace=FALSE),];
bn_5_10_sampling <- bn_5_10[sample(1:nrow(bn_5_10), 30, replace=FALSE),];
bn_10_15_sampling <- bn_10_15[sample(1:nrow(bn_10_15), 30, replace=FALSE),];
bn_15_20_sampling <- bn_15_20[sample(1:nrow(bn_15_20), 30, replace=FALSE),];
bn_20_25_sampling <- bn_20_25[sample(1:nrow(bn_20_25), 30, replace=FALSE),];
bn_25_30_sampling <- bn_25_30[sample(1:nrow(bn_25_30), 30, replace=FALSE),];
bn_30_35_sampling <- bn_30_35;
bn_35_40_sampling <- bn_35_40;
bn_40_45_sampling <- bn_40_45;
bn_45_50_sampling <- bn_45_50;

# nw sampling
nw_0_5_sampling <- nw_0_5[sample(1:nrow(nw_0_5), 30, replace=FALSE),];
nw_5_10_sampling <- nw_5_10[sample(1:nrow(nw_5_10), 30, replace=FALSE),];
nw_10_15_sampling <- nw_10_15[sample(1:nrow(nw_10_15), 30, replace=FALSE),];
nw_15_20_sampling <- nw_15_20[sample(1:nrow(nw_15_20), 30, replace=FALSE),];
nw_20_25_sampling <- nw_20_25[sample(1:nrow(nw_20_25), 30, replace=FALSE),];
nw_25_30_sampling <- nw_25_30[sample(1:nrow(nw_25_30), 30, replace=FALSE),];
nw_30_35_sampling <- nw_30_35;
nw_35_40_sampling <- nw_35_40;
nw_40_45_sampling <- nw_40_45;
nw_45_50_sampling <- nw_45_50;

# sampling result
write.table(bn_0_5_sampling[,1:4], "../tables/bn_0_5_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_5_10_sampling[,1:4], "../tables/bn_5_10_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_10_15_sampling[,1:4], "../tables/bn_10_15_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_15_20_sampling[,1:4], "../tables/bn_15_20_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_20_25_sampling[,1:4], "../tables/bn_20_25_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_25_30_sampling[,1:4], "../tables/bn_25_30_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_30_35_sampling[,1:4], "../tables/bn_30_35_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_35_40_sampling[,1:4], "../tables/bn_35_40_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_40_45_sampling[,1:4], "../tables/bn_40_45_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(bn_45_50_sampling[,1:4], "../tables/bn_45_50_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)

write.table(nw_0_5_sampling[,1:4], "../tables/nw_0_5_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_5_10_sampling[,1:4], "../tables/nw_5_10_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_10_15_sampling[,1:4], "../tables/nw_10_15_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_15_20_sampling[,1:4], "../tables/nw_15_20_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_20_25_sampling[,1:4], "../tables/nw_20_25_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_25_30_sampling[,1:4], "../tables/nw_25_30_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_30_35_sampling[,1:4], "../tables/nw_30_35_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_35_40_sampling[,1:4], "../tables/nw_35_40_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_40_45_sampling[,1:4], "../tables/nw_40_45_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
write.table(nw_45_50_sampling[,1:4], "../tables/nw_45_50_sampling.table", quote = FALSE, row.names = FALSE, col.names = FALSE)
