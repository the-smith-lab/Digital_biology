
# edit this if you want
install_dir=/N/u/$USER/Software/
echo $install_dir

mkdir -p $install_dir
cd $install_dir
git clone --recurse-submodules https://github.com/samtools/htslib.git
git clone https://github.com/samtools/bcftools.git
cd bcftools
autoheader && autoconf
./configure --prefix=$install_dir/bcftools/
make

# add to bashrc
echo >> ~/.bashrc
echo "# bcftools" >> ~/.bashrc
echo PATH=$install_dir/bcftools/:\$PATH >> ~/.bashrc

