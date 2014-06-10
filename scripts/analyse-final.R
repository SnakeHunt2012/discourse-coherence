#!/usr/bin/env R
# analyse-final.R

# old version
#data_U <- read.csv(file="result-U", header=FALSE);
#data_W <- read.csv(file="result-W", header=FALSE);
#data_Acc <- read.csv(file="result-Acc", header=FALSE);
#
#pdf("../graph/accuracy-sentence-final.pdf", width = 10 + 1, height = 6 + 1);
#par(pin = c(10, 6), mai = c(1, 1, 1, 1));
#plot(xrange, yrange, type = 'n', xaxt = 'n', yaxt = 'n', xlab = "Discourse Length", ylab = "Accuracy");
#axis(2, at=c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1))
#axis(1, at=c(1:10), labels=c("1-5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-35", "35-40", "41-45", "46-50"));
#lines(data$V2, type = 'b', lty = 3, pch = 3, col = "green");
#lines(data1$V2, type = 'b', lty = 5, pch = 1, col = "blue");
#lines(data2$V2, type = 'b', lty = 1, pch = 20, col = "red");
#legend("bottomright", inset = 0.05, c("U", "W", "Acc"), lty = c(3, 5, 1), pch = c(3, 1, 20), col = c("green", "blue", "red"), bty = 'n');
#dev.off()

# new version
discourse_U <- read.csv(file = "../csv/discourse-U.csv", header = TRUE);
discourse_W <- read.csv(file = "../csv/discourse-W.csv", header = TRUE);
discourse_Acc <- read.csv(file = "../csv/discourse-Acc.csv", header = TRUE);

discourse_U_bn <- discourse_U[which(discourse_U$subject == "bn"),];
discourse_W_bn <- discourse_W[which(discourse_W$subject == "bn"),];
discourse_Acc_bn <- discourse_Acc[which(discourse_Acc$subject == "bn"),];

discourse_U_nw <- discourse_U[which(discourse_U$subject == "nw"),];
discourse_W_nw <- discourse_W[which(discourse_W$subject == "nw"),];
discourse_Acc_nw <- discourse_Acc[which(discourse_Acc$subject == "nw"),];

sum(discourse_U$positive) / (sum(discourse_U$positive) + sum(discourse_U$negative));
sum(discourse_W$positive) / (sum(discourse_W$positive) + sum(discourse_W$negative));
sum(discourse_Acc$positive) / (sum(discourse_Acc$positive) + sum(discourse_Acc$negative));

sum(discourse_U_bn$positive) / (sum(discourse_U_bn$positive) + sum(discourse_U_bn$negative));
sum(discourse_W_bn$positive) / (sum(discourse_W_bn$positive) + sum(discourse_W_bn$negative));
sum(discourse_Acc_bn$positive) / (sum(discourse_Acc_bn$positive) + sum(discourse_Acc_bn$negative));

sum(discourse_U_nw$positive) / (sum(discourse_U_nw$positive) + sum(discourse_U_nw$negative));
sum(discourse_W_nw$positive) / (sum(discourse_W_nw$positive) + sum(discourse_W_nw$negative));
sum(discourse_Acc_nw$positive) / (sum(discourse_Acc_nw$positive) + sum(discourse_Acc_nw$negative));


discourse_sentence_U <- list();
accuracy_sentence_U <- list();
discourse_sentence_U_bn <- list();
accuracy_sentence_U_bn <- list();
discourse_sentence_U_nw <- list();
accuracy_sentence_U_nw <- list();
discourse_sentence_W <- list();
accuracy_sentence_W <- list();
discourse_sentence_W_bn <- list();
accuracy_sentence_W_bn <- list()
discourse_sentence_W_nw <- list();
accuracy_sentence_W_nw <- list();
discourse_sentence_Acc <- list();
accuracy_sentence_Acc <- list();
discourse_sentence_Acc_bn <- list();
accuracy_sentence_Acc_bn <- list();
discourse_sentence_Acc_nw <- list();
accuracy_sentence_Acc_nw <- list();

for (index in 1:10) {
  # U
  discourse_sentence_U[[index]] <- discourse_U[which(discourse_U$sentence_amount > ((index - 1) * 5) & discourse_U$sentence_amount <= (index * 5)),];
  accuracy_sentence_U[[index]] <- (sum(discourse_sentence_U[[index]]$positive) / (sum(discourse_sentence_U[[index]]$positive) + sum(discourse_sentence_U[[index]]$negative)));
  
  discourse_sentence_U_bn[[index]] <- discourse_U_bn[which(discourse_U_bn$sentence_amount > ((index - 1) * 5) & discourse_U_bn$sentence_amount <= (index * 5)),];
  accuracy_sentence_U_bn[[index]] <- (sum(discourse_sentence_U_bn[[index]]$positive) / (sum(discourse_sentence_U_bn[[index]]$positive) + sum(discourse_sentence_U_bn[[index]]$negative)));
  
  discourse_sentence_U_nw[[index]] <- discourse_U_nw[which(discourse_U_nw$sentence_amount > ((index - 1) * 5) & discourse_U_nw$sentence_amount <= (index * 5)),];
  accuracy_sentence_U_nw[[index]] <- (sum(discourse_sentence_U_nw[[index]]$positive) / (sum(discourse_sentence_U_nw[[index]]$positive) + sum(discourse_sentence_U_nw[[index]]$negative)));

  # W
  discourse_sentence_W[[index]] <- discourse_W[which(discourse_W$sentence_amount > ((index - 1) * 5) & discourse_W$sentence_amount <= (index * 5)),];
  accuracy_sentence_W[[index]] <- (sum(discourse_sentence_W[[index]]$positive) / (sum(discourse_sentence_W[[index]]$positive) + sum(discourse_sentence_W[[index]]$negative)));
  
  discourse_sentence_W_bn[[index]] <- discourse_W_bn[which(discourse_W_bn$sentence_amount > ((index - 1) * 5) & discourse_W_bn$sentence_amount <= (index * 5)),];
  accuracy_sentence_W_bn[[index]] <- (sum(discourse_sentence_W_bn[[index]]$positive) / (sum(discourse_sentence_W_bn[[index]]$positive) + sum(discourse_sentence_W_bn[[index]]$negative)));
  
  discourse_sentence_W_nw[[index]] <- discourse_W_nw[which(discourse_W_nw$sentence_amount > ((index - 1) * 5) & discourse_W_nw$sentence_amount <= (index * 5)),];
  accuracy_sentence_W_nw[[index]] <- (sum(discourse_sentence_W_nw[[index]]$positive) / (sum(discourse_sentence_W_nw[[index]]$positive) + sum(discourse_sentence_W_nw[[index]]$negative)));

  # Acc
  discourse_sentence_Acc[[index]] <- discourse_Acc[which(discourse_Acc$sentence_amount > ((index - 1) * 5) & discourse_Acc$sentence_amount <= (index * 5)),];
  accuracy_sentence_Acc[[index]] <- (sum(discourse_sentence_Acc[[index]]$positive) / (sum(discourse_sentence_Acc[[index]]$positive) + sum(discourse_sentence_Acc[[index]]$negative)));
  
  discourse_sentence_Acc_bn[[index]] <- discourse_Acc_bn[which(discourse_Acc_bn$sentence_amount > ((index - 1) * 5) & discourse_Acc_bn$sentence_amount <= (index * 5)),];
  accuracy_sentence_Acc_bn[[index]] <- (sum(discourse_sentence_Acc_bn[[index]]$positive) / (sum(discourse_sentence_Acc_bn[[index]]$positive) + sum(discourse_sentence_Acc_bn[[index]]$negative)));
  
  discourse_sentence_Acc_nw[[index]] <- discourse_Acc_nw[which(discourse_Acc_nw$sentence_amount > ((index - 1) * 5) & discourse_Acc_nw$sentence_amount <= (index * 5)),];
  accuracy_sentence_Acc_nw[[index]] <- (sum(discourse_sentence_Acc_nw[[index]]$positive) / (sum(discourse_sentence_Acc_nw[[index]]$positive) + sum(discourse_sentence_Acc_nw[[index]]$negative)));
}

## draw graph
# all
yrange <- range(c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1));
xrange <- range(c(1:10));
pdf("../graph/accuracy-sentence-all.pdf", width = 10 + 1, height = 6 + 1);
plot(xrange, yrange, type = 'n', xaxt = 'n', yaxt = 'n', xlab = "Discourse Length", ylab = "Accuracy");
axis(2, at=c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1))
axis(1, at=c(1:10), labels=c("1-5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-35", "35-40", "41-45", "46-50"));
lines(c(1:10), accuracy_sentence_U, type = 'b', lty = 3, pch = 3, col = "green");
lines(c(1:10), accuracy_sentence_W, type = 'b', lty = 5, pch = 1, col = "blue");
lines(c(1:10), accuracy_sentence_Acc, type = 'b', lty = 1, pch = 20, col = "red");
dev.off()

# bn
yrange <- range(c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1));
xrange <- range(c(1:10));
pdf("../graph/accuracy-sentence-bn.pdf", width = 10 + 1, height = 6 + 1);
plot(xrange, yrange, type = 'n', xaxt = 'n', yaxt = 'n', xlab = "Discourse Length", ylab = "Accuracy");
axis(2, at=c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1))
axis(1, at=c(1:10), labels=c("1-5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-35", "35-40", "41-45", "46-50"));
lines(c(1:10), accuracy_sentence_U_bn, type = 'b', lty = 3, pch = 3, col = "green");
lines(c(1:10), accuracy_sentence_W_bn, type = 'b', lty = 5, pch = 1, col = "blue");
lines(c(1:10), accuracy_sentence_Acc_bn, type = 'b', lty = 1, pch = 20, col = "red");
dev.off()

# nw
yrange <- range(c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1));
xrange <- range(c(1:10));
pdf("../graph/accuracy-sentence-nw.pdf", width = 10 + 1, height = 6 + 1);
plot(xrange, yrange, type = 'n', xaxt = 'n', yaxt = 'n', xlab = "Discourse Length", ylab = "Accuracy");
axis(2, at=c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1))
axis(1, at=c(1:10), labels=c("1-5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-35", "35-40", "41-45", "46-50"));
lines(c(1:10), accuracy_sentence_U_nw, type = 'b', lty = 3, pch = 3, col = "green");
lines(c(1:10), accuracy_sentence_W_nw, type = 'b', lty = 5, pch = 1, col = "blue");
lines(c(1:10), accuracy_sentence_Acc_nw, type = 'b', lty = 1, pch = 20, col = "red");
dev.off()
