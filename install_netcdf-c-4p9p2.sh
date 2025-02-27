
# Some procedures to install netcdf-c-4.9.2


$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES
$ wget https://downloads.unidata.ucar.edu/netcdf-c/4.9.2/netcdf-c-4.9.2.tar.gz
$ tar -xzf netcdf-c-4.9.2.tar.gz
$ cd netcdf-c-4.9.2

$ export HDF5=/home/augusto.pereira/BUILD_WRF/LIBRARIES/hdf5
$ export NETCDF=/home/augusto.pereira/BUILD_WRF/LIBRARIES/netcdf
$ export CPPFLAGS="-I$HDF5/include"
$ export LDFLAGS="-L$HDF5/lib"
$ export LD_LIBRARY_PATH="$HDF5/lib:$LD_LIBRARY_PATH"
$ export PATH="$HDF5/bin:$PATH"

$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES/netcdf-c-4.9.2

$ ./configure --prefix=$NETCDF --enable-hdf5 --disable-dap --enable-netcdf-4 --disable-shared --enable-largefile --disable-byterange \
    CPPFLAGS="-I$HDF5/include" LDFLAGS="-L$HDF5/lib"


$ make -j$(nproc)
$ make install



# Check if NetCDF C was installed with HDF5 support
$ nc-config --has-hdf5

# If the output is "yes," then it was installed correctly
