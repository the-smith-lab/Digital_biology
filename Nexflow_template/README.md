# Notes on nextflow

### Quick start
Install with conda/mamba:
```
mamba install bioconda::nextflow --yes
module load java  # seems to work
nextflow -version
```

Check out an interactive node (`srun`).

Change the file paths in `nextflow.config` to ones you have access to.

Run the template script:
```
nextflow run main.nf
```

Then run this command to see how nextflow tracks runs, and copy the "SESSION ID":
```
nextflow log
```

Next run this to see the paths to intermediate files that were created:
```
nextflow log <SESSION ID>
```

Peak inside some of those folders with `ls -a` to see hidden files---and check those out, too.

Now experiment with *deleting* one of the intermediate "download_X.txt" files, and then re-run nextflow and see what happens. 


### How to develop/learn more?
Nextflow requires an investment of trial and error to figure out, and then it becomes useful (but still expect some trial and error even then).
1. Play with the template: e.g., re-run with a larger number of `total_indices`. Check the log again. Try to find the intermediate outputs.
2. Starting from the template, try to make a separate process for each step in your pipeline (for an assignment or class project).
3. Try running workflows, study output/errors, fix issues, iterate.
4. If you get stuck, check the NF docs, other resources online, ask group members, ask Chris.
                                                                                              
                                                                                              
                                                                                              
                                                                                       
### Tips and tricks
- I often delete the whole nextflow working directory (`workdir`) as well as `.nextflow*`.
- A running Nextflow process usually responds to a single `CTRL-C`; holding it causes Nextflow to lock down.
