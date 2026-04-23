args <- commandArgs(trailingOnly = TRUE)  # print(args)
inpath=args[1]

data <- read.table(inpath, header=TRUE)
pred = "ADD"
data = data[data$TEST == pred, ]
chr_len <- aggregate(BP ~ CHR, data, max)
chr_len$offset <- c(0, cumsum(chr_len$BP[-nrow(chr_len)]))
data <- merge(data, chr_len[, c("CHR", "offset")], by="CHR")
data$BPcumul <- data$BP + data$offset
data$logP <- -log10(data$P)

png(paste(inpath, ".png", sep=""), width = 4500, height = 1500, res = 300, type = "cairo")
plot(data$BPcumul, data$logP,
     pch = 20,
     col = as.factor(data$CHR),
     xlab = "Genomic position",
     ylab = "-log10(P)",
     xaxt="n")
abline(8,0, lty=2)
axis(1,
at = tapply(data$BPcum, data$CHR, mean),
labels = unique(data$CHR))
dev.off()

