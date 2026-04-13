import sys

lookup = sys.argv[1]
fp_gene_map = "/N/scratch/chriscs/Digital_biology/Splicing/Reference_transcriptome/gene_map.txt"
fp_ref =      "/N/scratch/chriscs/Digital_biology/Splicing/Reference_transcriptome/transcriptome_edited.fasta"

### map tracripts to genes
gene_map = {}
with open(fp_gene_map) as infile:
    for line in infile:
        newline = line.strip().split()
        transcript, gene, _ = newline
        if gene not in gene_map:
            gene_map[gene] = []
        #
        gene_map[gene].append(transcript)

### get transcript sequences
seq = False
seqs = {}
with open(fp_ref) as infile:        
    for line in infile:
        if seq is True:  # inside sequence    
            newline = line.strip()
            if newline[0] != ">":
                sequence += newline
            else:  # end of sequence
                seqs[transcript] = sequence
                seq = False
        if seq is False:  # not "else", b/c check for hit immediately following
            newline = line.strip()
            if newline[0] != ">":
                pass
            else:
                transcript = newline.split(">")[1]
                if transcript in gene_map[lookup]:
                    seq = True
                    sequence = ""

from Bio import pairwise2
from Bio.pairwise2 import format_alignment

n = len(seqs)
for s1 in range(n-1):
    for s2 in range(s1+1, n):
        print(s1,s2)
        

                

