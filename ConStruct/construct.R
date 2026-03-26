
### settings and command line args
print("loading software")
library("conStruct")  #install.packages("conStruct")
library(geosphere)  #install.packages("geosphere")
args <- commandArgs(trailingOnly = TRUE)  # print(args)
setwd("./")


### read and preprocess  #vignette(topic="format-data",package="conStruct")
print("reading vcf")
fp = paste(args[1], ".012", sep="")
genos = read.table(fp, row.names = 1, header=F)
freqs = genos / 2  # convert allele counts to frequencies in each indiv
freqs = as.matrix(freqs)
dim(freqs)

print("reading locs")
fp = paste(args[1], ".locs", sep="")
locs = read.table(fp, header=F)
locs = locs[, c(1,2)]
locs = as.matrix(locs)
dim(locs)
dists <- distm(locs, fun = distHaversine)
dim(dists)

K=as.integer(args[2])
my.run <- conStruct(spatial = F, 
                    K = K, 
                    freqs = freqs,
                    geoDist = dists,
                    coords = locs,
                    prefix = "spK3")

