#!/bin/bash

module purge
module load hdf5/1.10.8
module load netcdf/4.9.2

cp /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/1MY_SUMULATION/data_mozbc/mozbc.inp-FOR-GOCART301 /home/augusto.pereira/BUILD_WRF/Processors/mozbc/mozbc.inp

cd /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real
! nccopy -k 64-bit-offset wrfinput_d01 wrfinput_classic.nc
nccopy -k 64-bit-offset wrfbdy_d01 wrfbdy_classic.nc

! mv wrfinput_d01 wrfinput_d01_netcdf4
! mv wrfinput_classic.nc wrfinput_d01

mv wrfbdy_d01 wrfbdy_d01_netcdf4
mv wrfbdy_classic.nc wrfbdy_d01

cd /home/augusto.pereira/BUILD_WRF/Processors/mozbc

chmod +x set_mozbc_input.sh
./set_mozbc_input.sh

cp /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/1MY_SUMULATION/data_mozbc/mozbc.inp-FOR-GOCART301 /home/augusto.pereira/BUILD_WRF/Processors/mozbc/mozbc.inp

./mozbc < mozbc.inp > mozbc.out
