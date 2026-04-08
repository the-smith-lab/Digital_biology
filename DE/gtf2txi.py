import sys

fp = sys.argv[1]

with open(fp) as infile:
    for line in infile:
        if line[0:2] == "#!":
            pass
        else:
            newline = line.strip().split()
            type_ = newline[2]
            if type_ == "transcript":
                geneid_idx = newline.index("gene_id")
                geneid = newline[geneid_idx+1].split("\"")[1]
                if "gene_name" in newline:
                    genename_idx = newline.index("gene_name")
                    genename = newline[genename_idx+1].split("\"")[1]
                else:
                    genename = "\"NA\""
                transcriptid_idx = newline.index("transcript_id")
                transcriptid = newline[transcriptid_idx+1].split("\"")[1]
                transcriptversion_idx = newline.index("transcript_version")
                transcriptversion = newline[transcriptversion_idx+1].split("\"")[1]
                transcriptid = ".".join([transcriptid,transcriptversion])
                print("\t".join([transcriptid, geneid, genename]))
