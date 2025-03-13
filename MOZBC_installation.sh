cd /home/augusto.pereira/BUILD_WRF/Processors/mozbc




export NETCDF_DIR=/home/augusto.pereira/BUILD_WRF/LIBRARIES/netcdf
export CPATH=$NETCDF_DIR/include:$CPATH
export LIBRARY_PATH=$NETCDF_DIR/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$NETCDF_DIR/lib:$LD_LIBRARY_PATH


##################################################################################
##################################################################################
##################################################################################
#
# edit Makefile or change all Makefile
#
##################################################################################
##################################################################################
##################################################################################

vi Makefile


##################################################################################
##################################################################################
##################################################################################
# .SUFFIXES: .o .f90
# 
# HDF5_DIR = /home/augusto.pereira/BUILD_WRF/LIBRARIES/hdf5
# F90    = $(FC)
# LIBS   = -L$(NETCDF_DIR)/lib $(AR_FILES) -lnetcdff -lnetcdf \
#          -L$(HDF5_DIR)/lib -lhdf5 -lhdf5_hl -lz
#  # LIBS   = -L$(NETCDF_DIR)/lib $(AR_FILES)
# INCLUDE_MODULES = -I$(NETCDF_DIR)/include
# 
# ifeq ($(FC),lf95)
#   FFLAGS = --g
# else
#   FFLAGS = -g
# endif
#
# ifeq ($(FC),pgf90)
#   FFLAGS += -Mnosave -Ktrap=fp
# endif
#
# ifeq ($(FC),gfortran)
#   FFLAGS += -ffree-line-length-none
# endif
# 
# ifeq ($(FC),lf95)
#   FFLAGS += --nap --nchk --pca --nsav --trace --trap --wide
# endif
#
# ifeq ($(FC),ifort)
#   FFLAGS += -fpe0 -ftrapuv
# endif
# 
# EXEC = mozbc
#
# OBJS = mo_calendar.o\
#        mo_utils.o\
#        mo_mozart_lib.o \
#        mo_wrfchem_lib.o \
#        main_bc_wrfchem.o
#
# ##dependencies
# #$(OBJECTS) : makefile
#
# ${EXEC} :       ${OBJS}
#                ${F90} -o $@ ${OBJS} ${LIBS}
#
# .f90.o:
#                 ${F90} ${FFLAGS} -c ${INCLUDE_MODULES} $<
#
# cleanup:
#                 rm -f ${OBJS} *.mod
#
# clean:
#                 rm -f core ${EXEC} ${OBJS} *.mod
##################################################################################
##################################################################################
##################################################################################



export LD_LIBRARY_PATH=/opt/ohpc/pub/libs/gnu9/mpich/netcdf/4.7.4/lib:$LD_LIBRARY_PATH
echo 'export LD_LIBRARY_PATH=/opt/ohpc/pub/libs/gnu9/mpich/netcdf/4.7.4/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc



make clean
cd /home/augusto.pereira/BUILD_WRF/Processors/mozbc
./make_mozbc


# ++++++++++++++
# mozbc build Ok
# ++++++++++++++
