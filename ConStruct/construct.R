
### settings and command line args
print("loading software")
set.seed(123)
library(conStruct)  #install.zpackages("conStruct")
library(geosphere)  #install.packages("geosphere")
library(maps)
args <- commandArgs(trailingOnly = TRUE)  # print(args)
setwd("./")
pref=args[1]
K=args[2]

### read and preprocess  #vignette(topic="format-data",package="conStruct")
print("reading vcf")
fp = paste(pref, ".012", sep="")
genos = read.table(fp, row.names = 1, header=F)
freqs = genos / 2  # convert allele counts to frequencies in each indiv
freqs = as.matrix(freqs)
dim(freqs)

print("reading locs")
fp = paste(pref, ".locs", sep="")
locs = read.table(fp, header=F)
locs = locs[, c(1,2)]
locs = as.matrix(locs)
dim(locs)
dists <- distm(locs, fun = distHaversine)
dim(dists)

### run single K
if (K != "cv"){
fp = paste(pref, "_K", K, sep="")
my.run <- conStruct(spatial = F, 
                    K = as.integer(K), 
                    freqs = freqs,
                    geoDist = dists,
                    coords = locs,
                    prefix = fp)

fp = paste(pref, "_K", K, "_map.pdf", sep="")
admix.props <- my.run$chain_1$MAP$admix.proportions
pdf(file = fp, width = 7, height = 5)  # width & height in inches
maps::map(xlim = range(locs[,1]) + c(-5,5), ylim = range(locs[,2])+c(-2,2), col="gray")
make.admix.pie.plot(admix.proportions = admix.props, coords = locs, add = TRUE)
dev.off()
} else {

### cross validation
my.xvals <- x.validation(train.prop = 0.9,
                         n.reps = 8,
                         K = 1:7,
                         freqs = freqs,
                         data.partitions = NULL,
                         geoDist = dists,
                         coords = locs,
                         prefix = pref,
                         n.iter = 1e3,
                         make.figs = TRUE,
                         save.files = FALSE,
                         parallel = FALSE,
                         n.nodes = NULL)

fp = paste(pref, "_sp_xval_results.txt", sep="")
sp.results <- as.matrix(
                read.table(fp,
                           header = TRUE,
                           stringsAsFactors = FALSE)
               )
fp = paste(pref, "_nsp_xval_results.txt", sep="")	       
nsp.results <- as.matrix(
                read.table(fp,
                           header = TRUE,
                           stringsAsFactors = FALSE)
               )

sp.CIs <- apply(sp.results,1,function(x){mean(x) + c(-1.96,1.96) * sd(x)/length(x)})
nsp.CIs <- apply(nsp.results,1,function(x){mean(x) + c(-1.96,1.96) * sd(x)/length(x)})

fp = paste(pref, "_cv.pdf", sep="")
pdf(file = fp, width = 7, height = 5)  # width & height in inches
plot(rowMeans(sp.results),
     pch=19,col="blue",
     ylab="predictive accuracy",xlab="values of K",
     ylim=range(sp.results,nsp.results),
     main="cross-validation results")
segments(x0 = 1:nrow(sp.results),
         y0 = sp.CIs[1,],
         x1 = 1:nrow(sp.results),
         y1 = sp.CIs[2,],
         col = "blue",lwd=2)
points(rowMeans(nsp.results),col="green",pch=17)
legend("bottomright",
       legend = c("spatial model", "non-spatial model"),
       col = c("blue", "green"),
       pch = c(19, 17))
dev.off()
}
