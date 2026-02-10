import sys

fp = sys.argv[1]

bioprojects = {}
with open(fp) as infile:
    for line in infile:
        newline = line.strip().split(",")
        if len(newline) < 3:
            print("problem")
            1/0
        srr = newline[0]
        data = ",".join(newline[1:])
        bioprojects[data] = bioprojects.get(data, 0) + 1

taxa = {}
for p in bioprojects:
    if bioprojects[p] >= 10:
        if " x " not in p:
            newline = p.split(",")
            prj = newline[0]
            taxon = ",".join(newline[1:])
            taxon = taxon.split(" ")
            if len(taxon) >= 2:
                taxon = " ".join(taxon[0:2])
                taxa.setdefault(taxon, []).append(prj)

for p in taxa:
    print(p, ",".join(taxa[p]))
