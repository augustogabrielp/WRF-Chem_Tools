#!/bin/bash
# wacc-20250313114216737859.nc  AGOSTO
# waccm-20250710125538085374.nc SETEMBTO

# module purge
# module load hdf5/1.10.8
# module load netcdf/4.9.2

module load gnu9/9.4.0
module load mpich/3.4.2-ucx
module load phdf5/1.10.8
module load netcdf/4.7.4
module load netcdf-fortran/4.5.3

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
