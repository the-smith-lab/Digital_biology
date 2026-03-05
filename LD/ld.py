# example usage:python ld.py chr2_qual30_noIndels_noAlt_noMiss_0.33.vcf

import sys
import allel
import numpy as np
from scipy.spatial.distance import pdist
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D



infile = sys.argv[1]

### params
numbins=20
min_val = 1e4
max_val = 1e8

### read vcf
geno_mat = []
pos_mat = []
vcf = open(infile, "r")
for line in vcf:
    if line[0:2] == "##":
        pass
    elif line[0] == "#":
        header = line.strip().split("\t")
        n = len(header) - 9
    else:
        newline = line.strip().split("\t")
        genos = []
        alleles = {}
        for field in range(9, len(newline)):
            pos = float(newline[1])
            geno = newline[field].split(":")[0].split("/")
            if "." in geno:  # missing
                alleles.setdefault(-1, 0)
                alleles[-1] += 1
            else:
                alleles.setdefault(int(geno[0]), 0)
                alleles[int(geno[0])] += 1
                alleles.setdefault(int(geno[1]), 0)
                alleles[int(geno[1])] += 1
                genos.append( [int(geno[0]), int(geno[1])] )  # still phased at this point
        #
        if -1 not in alleles and len(list(alleles.keys())) == 2:  # filters non-missing AND biallelic

            # recalculate major/minor allele
            major, minor = list(alleles.keys())  # (random init)
            if alleles[major] < alleles[minor]:
                major, minor = minor, major
            #                                                  
            new_genotypes = []
            for i in range(n):
                new_genotype = [None, None]
                for j in range(2):  # diploid
                    if genos[i][j] == major:
                        new_genotype[j] = 0
                    else:
                        new_genotype[j] = 1
                #                                              
                new_genotypes.append(new_genotype)
            #
            geno_mat.append(new_genotypes)
            pos_mat.append(pos)

### calc LD
geno_mat = np.array(geno_mat)
pos_mat = np.array(pos_mat)
g = allel.GenotypeArray(geno_mat)
gn = g.to_n_alt(fill=-1)
pos = np.expand_dims(pos_mat,-1)
dist = pdist(pos)
r = allel.rogers_huff_r(gn[:, :])
r2 = r**2

### discretize                                                   
bins = np.logspace(np.log10(min_val), np.log10(max_val), numbins)
r2_means = []
for i in range(len(bins)-1):
    mask = (dist>=bins[i]) & (dist < bins[i+1])
    #print(bins[i], bins[i+1], np.sum(mask))                     
    r2_means.append(np.nanmean(r2[mask]))
    
### plot                                                         
midpt =  bins[:-1] + (bins[1:] - bins[:-1])/2
plt.plot(midpt, r2_means, marker='o', linestyle='-')
plt.xscale('log')
plt.xlabel("Distance between SNPs (bp)")
plt.ylabel(r"Mean $r^2 in bin$")
plt.title("LD decay")
plt.tight_layout()
plt.savefig("ld_decay.pdf")
plt.close()
