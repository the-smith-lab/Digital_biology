

To install all software for the class project:

1. Delete your entire Conda environment:

   ```
   rm -rf Miniconda/
   ```

2. Install conda (but don't create a new env yet:

   ```
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  # download

   bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/Miniconda  # install

   source ~/Miniconda/etc/profile.d/conda.sh  # tell bash where to look for conda

   conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main

   conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
   ```

3. Install mamba (faster than conda)

   ```
   conda install mamba -c conda-forge --yes  # installs mamba, another installer program
   ```

4. Copy/download `class_project`, and run the below command:

   ```
   mamba env create -f Conda/class_project.yml
   ```


