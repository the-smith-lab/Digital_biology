# eg python hap2dip.py $INPUT.VCF > $OUTPUT.VCF

import sys

infile = sys.argv[1]

with open(infile) as vcf:
    for line in vcf:
        if line[0:2] == "##":
            print(line.strip())
        elif line[0] == "#":
            header = line.strip().split()
            print(line.strip())
        else:
            newline = line.strip().split()
            beginning = newline[0:9]
            samps = newline[9:]
            genos = []
            for field in range(9, len(newline)):
                samp = newline[field]
                geno = newline[field].split(":")[0]  # haploid genotype
                newgeno = [geno + "/" + geno]  # diploid
                newgeno += newline[field].split(":")[1:]
                genos.append(":".join(newgeno))
            outline = beginning + genos
            print(outline)
            print("\t".join(outline))
