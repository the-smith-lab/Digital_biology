
.libPaths(c("/N/scratch/chriscs/Public/Week_12/R_BIGRED/", .libPaths()))
print(find.package("tximport"))
library(readr)
library(tximport)
library(DESeq2)

# read transcript-to-gene mapping file
gene_map = read.table(
  "Reference_transcriptome/gene_map.txt",
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE
)

#
samples = read.table("samples.txt", header=T)  # tab-sep: accession, treatment, file

data = tximport(samples$file, type = "salmon", tx2gene = gene_map, countsFromAbundance="lengthScaledTPM")
# https://github.com/thelovelab/tximport/blob/devel/R/helper.R#L26
#     newCounts <- abundanceMat * rowMeans(lengthMat)
#      reverses the length normalization.
# https://www.bioconductor.org/packages/devel/bioc//vignettes/tximport/inst/doc/tximport.html
#     ""lengthScaledTPM". Using either of these approaches, the counts are not correlated with length'

samples$treatment = factor(samples$treatment)

ddsTxi = DESeqDataSetFromTximport(data,
                                   colData = samples,
                                   design = ~ treatment)

ddsTxi = ddsTxi[rowSums(counts(ddsTxi)) > 1, ]  # filter genes with total counts <1

dds = DESeq(ddsTxi)

resultsNames(dds) # lists the coefficient names- need this to match below

res = results(dds, name="treatment_infected_vs_control")

resOrdered <- res[order(res$padj), ]
head(resOrdered)

#plotMA(res, main="DESeq2", ylim=c(-5,5))

# Prepare data
resOrdered <- as.data.frame(resOrdered)
resOrdered$gene <- rownames(resOrdered)

# Define significance: padj < 0.05 and |log2FC| > 1
sig <- resOrdered$padj < 0.05 & abs(resOrdered$log2FoldChange) > 1

# Volcano plot
plot(resOrdered$log2FoldChange, -log10(resOrdered$padj),
     pch = 20,
     col = ifelse(sig, "red", "grey"),
     xlab = "Log2 Fold Change",
     ylab = "-Log10 Adjusted p-value",
     main = "Volcano Plot")

# Optionally, highlight top genes
top_genes <- head(resOrdered[order(resOrdered$padj), ], 10)
text(top_genes$log2FoldChange, -log10(top_genes$padj),
     labels = top_genes$gene,
     pos = 3, cex = 0.8, col = "blue")






