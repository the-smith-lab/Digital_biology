setwd("./")
#install.packages("conStruct")
library("conStruct")
#install.packages("geosphere", type = "binary")
library(geosphere)


#vignette(topic="format-data",package="conStruct")

genos = read.table("snps_final.012", row.names = 1, header=F)
freqs = genos / 2  # convert allele counts to frequencies in each indiv
freqs = as.matrix(freqs)
dim(freqs)
locs = read.table("coords.txt", header=F)
locs = locs[, c(1,2)]
locs = as.matrix(locs)
dim(locs)
dists <- distm(locs, fun = distHaversine)
dim(dists)


my.run <- conStruct(spatial = F, 
                    K = 2, 
                    freqs = freqs,
                    geoDist = dists,
                    coords = locs,
                    prefix = "spK3")

