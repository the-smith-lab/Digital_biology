
# edit this if you want
install_dir=/N/u/$USER/Software/

# install
mkdir -p $install_dir
cd $install_dir
wget https://github.com/samtools/htslib/releases/download/1.21/htslib-1.21.tar.bz2
tar -vxjf htslib-1.21.tar.bz2
cd htslib-1.21
./configure --prefix=$install_dir/htslib-1.21
make

# add to bashrc
echo >> ~/.bashrc
echo "# bgzip" >> ~/.bashrc
echo PATH=$install_dir/htslib-1.21/:\$PATH >> ~/.bashrc


