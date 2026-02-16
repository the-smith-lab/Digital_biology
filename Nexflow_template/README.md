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

### How to develop/learn more?
Nextflow requires an investment of trial and error to figure out, and then it becomes useful (but still expect some trial and error even then).
1. Starting from the template, try to make a separate process for each step in your pipeline (for an assignment or class project).
2. Try running, study output/errors, fix issues, iterate.
3. If you get stuck, check the NF docs, other resources online, ask group members, ask Chris.
                                                                                              
                                                                                              
                                                                                              
                                                                                       
