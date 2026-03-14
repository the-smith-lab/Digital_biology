#!/bin/bash  
#SBATCH --account=c01988
#SBATCH --time=3:00:00
#SBATCH --mem=20gb

### remove existing conda
echo "removing"
source ~/Miniconda/etc/profile.d/conda.sh
for i in $(seq ${CONDA_SHLVL}); do
    conda deactivate
done
rm -rf ~/.mamba  # important if your mamba install got interrupted
rm -rf ~/.conda
conda init --reverse bash
sed -i '/DigitalBio/d' ~/.bashrc
sed -i '/activate conda env/d' ~/.bashrc
source ~/.bashrc
rm -rf ~/Miniconda

### install conda
echo "installing conda"
cd  # go home
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  # download
bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/Miniconda  # install
source ~/Miniconda/etc/profile.d/conda.sh  # tell bash where to look for conda
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
rm Miniconda3-latest-Linux-x86_64.sh  # clean up
conda install mamba -c conda-forge --yes  # installs mamba, another installer program

### install software we want
echo "installing tools"
wget https://raw.githubusercontent.com/the-smith-lab/Digital_biology/refs/heads/main/Conda/class_project.yml
mamba env create -f class_project.yml --yes
conda init bash
printf '\n# activate conda env\n' >> ~/.bashrc
printf '[[ $- == *i* ]] && conda activate DigitalBio\n' >> ~/.bashrc  # interactive only
source ~/.bashrc
conda activate DigitalBio  # loads the new conda env
