cd /home/augusto.pereira/BUILD_WRF/Processors/wes_coldens

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
#         -L$(HDF5_DIR)/lib -lhdf5 -lhdf5_hl -lz # LIBS   = -L$(NETCDF_DIR)/lib $(AR_FILES)
# INCLUDE_MODULES = -I$(NETCDF_DIR)/include
# FFLAGS = -g
#
# OBJS_WESELY = mo_calendar.o\
#              make_wesely.o
#
# OBJS_EXO_COLDENS = mo_calendar.o\
#                    make_exo_coldens.o
# 
# .f90.o:
#                 ${F90} ${FFLAGS} -c ${INCLUDE_MODULES} $<
# 
# ##dependencies
# 
# exo_coldens: ${OBJS_EXO_COLDENS}
#                  ${F90} -o $@ ${FFLAGS} ${OBJS_EXO_COLDENS} ${LIBS}
# 
# wesely: ${OBJS_WESELY}
#                 ${F90} -o $@ ${FFLAGS} ${OBJS_WESELY} ${LIBS}
# 
# cleanup:
#                 rm -f *.o *.mod
# 
# clean:
#                 rm -f core *.o *.mod

./make_util exo_coldens

# +++++++++++++++++++++++++++++
# exo_coldens build successful
# +++++++++++++++++++++++++++++






