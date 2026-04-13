# e.g., python ~/../Software/Digital_biology/DE/splice_events.py ENSMUSG00000051951.6
import sys
import subprocess

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
with open(fp_ref) as infile:
    with open(lookup + ".fasta", "w") as outfile:
        for line in infile:
            if seq is True:  # inside sequence    
                newline = line.strip()
                if newline[0] != ">":
                    #sequence += newline
                    #print(newline)
                    outfile.write(newline + "\n")
                else:  # end of sequence
                    seq = False
            if seq is False:  # not "else", b/c check for hit immediately following
                newline = line.strip()
                if newline[0] != ">":
                    pass
                else:
                    transcript = newline.split(">")[1]
                    if transcript in gene_map[lookup]:
                        #print(newline)
                        outfile.write(newline + "\n")
                        seq = True
                        sequence = ""
        
### gmap
# gmap_build Mus_musculus.GRCm39.dna.primary_assembly.fa -d Mus_musculus.GRCm39_index -D .
cmd = "gmap -D . -d Mus_musculus.GRCm39_index -f samse " + lookup + ".fasta > " + lookup + ".sam"
subprocess.run(cmd, shell=True)
cmd = "samtools view -bS " + lookup + ".sam > " + lookup + ".bam"
subprocess.run(cmd, shell=True)
cmd = "samtools sort " + lookup + ".bam -o " + lookup + ".sorted.bam"
subprocess.run(cmd, shell=True)
cmd = "samtools index " + lookup + ".sorted.bam"
subprocess.run(cmd, shell=True)
