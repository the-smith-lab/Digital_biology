import sys


fp = sys.argv[1]

with open(fp) as infile:
    for line in infile:
        if line[0] == ">":
            newline = line.strip().split("|")[0]
            print(newline)
        else:
            print(line.strip())
