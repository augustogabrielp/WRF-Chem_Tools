
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





###################################################################################
#
# an alternative that might work
#
###################################################################################
# netcdf-c

cd $DIR/netcdf-c-4.9.2
rm -rf build


mkdir build && cd build
cmake .. \
  -DCMAKE_INSTALL_PREFIX=$DIR/netcdf \
  -DBUILD_SHARED_LIBS=ON \
  -DENABLE_NETCDF_4=ON \
  -DENABLE_PARALLEL_IO=ON \
  -DENABLE_BYTERANGE=OFF \
  -DENABLE_DAP=OFF \
  -DENABLE_DISPATCH=OFF \
  -DHDF5_ROOT=$HDF5


make VERBOSE=1


make -j1 2>&1 | tee build.err


make install
nc-config --has-hdf5  # deve dizer "yes"
ls $DIR/netcdf/lib/libnetcdf.so
