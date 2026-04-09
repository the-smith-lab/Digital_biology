.libPaths(c("/N/scratch/chriscs/Public/Week_12/R_BIGRED/", .libPaths()))
library(tximport)
library(DESeq2)

### read transcript-to-gene mapping file
gene_map = read.table(
  "Reference_transcriptome/gene_map.txt",
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE
)

### read sample metadata
samples = read.table("samples.txt", header=T)  # tab-sep: accession, treatment, file
samples$treatment = factor(samples$treatment)

### convert transcript-level counts to gene-level
# https://github.com/thelovelab/tximport/blob/devel/R/helper.R#L26
#     newCounts <- abundanceMat * rowMeans(lengthMat)
#     Seems to rescale back to counts-like scale/units;
#     but it uses mean, therefore length-corrected counts: L * (mean length / transcript length)
# https://www.bioconductor.org/packages/devel/bioc//vignettes/tximport/inst/doc/tximport.html
#     ""lengthScaledTPM". Using either of these approaches, the counts are not correlated with length'
#data = tximport(samples$file, type = "salmon", tx2gene = gene_map, countsFromAbundance="lengthScaledTPM")

# But: the DESeq2 docs doesn't say to use countsFromAbundance in the salmon vignette.
#     Corrects for sample-specific gene length using "offsets".
#     e.g., data$length
# https://bioconductor.posit.co/packages/3.22/bioc/manuals/DESeq2/man/DESeq2.pdf
#     DESeq() doesn't take an offsets argument
# https://github.com/thelovelab/DESeq2/blob/devel/R/AllClasses.R#L419
#     DESeqDataSetFromTximport() automaticaly uses data$length
#     lengths <- txi$length
# It outputs "using 'avgTxLength' from assays(dds)"
# Conclusion: both approaches address a similar goal; deseq2 says to do it this way.
data = tximport(samples$file, type = "salmon", tx2gene = gene_map)

### run deseq2
ddsTxi = DESeqDataSetFromTximport(data,
                                  colData = samples,
                                  design = ~ treatment)

ddsTxi = ddsTxi[rowSums(counts(ddsTxi)) > 1, ]  # filter genes with total counts <1
dds = DESeq(ddsTxi)
res = results(dds, name="treatment_infected_vs_control")  # resultsNames(dds) # lists the coefficient names- need this to match

### plot
pdf("de.pdf", width = 5, height = 5)  # width & height in inches
res = res[!is.na(res$padj),]
sig = res$padj < 0.05 & abs(res$log2FoldChange) > 1
plot(res$log2FoldChange, -log10(res$padj),
     pch = 20,
     col = ifelse(sig, "darkgreen", "grey"),
     xlab = "Log2 Fold Change",
     ylab = "-Log10 Adjusted p-value")
dev.off()
