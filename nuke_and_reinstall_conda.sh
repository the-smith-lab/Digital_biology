#!/bin/bash  
#SBATCH --account=c01988
#SBATCH --time=12:00:00
#SBATCH --mem=20gb

### remove existing conda
echo "removing"
rm -rf ~/.mamba  # important if your mamba install got interrupted
rm -rf ~/.conda
rm Miniconda3-latest-Linux-x86_64.sh
rm -rf ~/Miniconda

### install conda
echo "installing conda"
cd  # go home
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  # download
bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/Miniconda  # install
source ~/Miniconda/etc/profile.d/conda.sh  # tell bash where to look for conda
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
conda create -n "DigitalBio" --yes  # creates a new conda environment
conda init bash
printf '\n# activate conda env\n' >> ~/.bashrc
printf '[[ $- == *i* ]] && conda activate DigitalBio\n' >> ~/.bashrc  # interactive only
conda activate DigitalBio  # loads the new conda env                                                                                                                                         
conda install mamba -c conda-forge --yes  # installs mamba, another installer program
rm Miniconda3-latest-Linux-x86_64.sh  # clean up

### install software we want
echo "installing tools"
mamba install emboss blast sra-tools==3.2.1 fastqc fastp multiqc -c bioconda -c conda-forge -c bioconda --yes 
