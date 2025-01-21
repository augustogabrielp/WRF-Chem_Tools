# Instalar WRF e WPS no egeon



$ pwd
/home/augusto.pereira

$ mkdir BUILD_WRF
$ mkdir TESTS

## --------------------------------------------------------------------
# baixar os arquivos TESTS
$ cd /home/augusto.pereira/TESTS
$ wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/ 
$ compile_tutorial/tar_files/Fortran_C_tests.tar
$ tar -xvzf Fortran_C_tests.tar

# Teste 1
$ gfortran TEST_1_fortran_only_fixed.f 
$ ./a.out
# Teste 2
$ gfortran TEST_2_fortran_only_free.f90 
$ ./a.out
# Teste 3
$ gcc TEST_3_c_only.c 
$ ./a.out
# Teste 4
$ gcc -c -m64 TEST_4_fortran+c_c.c
$ gfortran -c -m64 TEST_4_fortran+c_f.f90
$ gfortran -m64 TEST_4_fortran+c_f.o TEST_4_fortran+c_c.o
$ ./a.out
# Teste 5
$ csh ./TEST_csh.csh
# Teste 6
$ ./TEST_perl.pl
# Teste 7
$ ./TEST_sh.sh
## --------------------------------------------------------------------

# Construir Libs

$ cd /home/augusto.pereira/BUILD_WRF
$ mkdir LIBRARIES

$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES

$ wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
$ wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
$ wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
# libpng versao 1.2.59
$ wget https://downloads.sourceforge.net/project/libpng/libpng12/1.2.59/libpng-1.2.59.tar.gz
$ wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz

# Talvez seja necessário "resetar" o .bashrc, entao use o seguinte comando se necessario
# cp /etc/skel/.bashrc ~/.bashrc

# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export DIR=/home/augusto.pereira/BUILD_WRF/LIBRARIES
export CC=gcc
export CXX=g++
export FC=gfortran
export FCFLAGS=-m64
export F77=gfortran
export FFLAGS=-m64
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc




$ tar -zxvf netcdf-4.1.3.tar.gz
$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES/netcdf-4.1.3
$ ./configure --prefix=$DIR/netcdf --disable-dap --disable-netcdf-4 --disable-shared
$ make
$ make install

# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export PATH=$DIR/netcdf/bin:$PATH
export NETCDF=$DIR/netcdf
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc




$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES
$ tar -zxvf mpich-3.0.4.tar.gz
$ cd mpich-3.0.4
$ ./configure --prefix=$DIR/mpich
$ make
$ make install

# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export PATH=$DIR/mpich/bin:$PATH
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc



$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES
$ tar -zxvf zlib-1.2.7.tar.gz
$ cd zlib-1.2.7
$ ./configure --prefix=$DIR/grib2
$ make
$ make install




$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES
$ tar -zxvf libpng-1.2.59.tar.gz
$ cd libpng-1.2.59
$ ./configure --prefix=$DIR/grib2
$ make
$ make install

# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export LD_LIBRARY_PATH=/home/augusto.pereira/BUILD_WRF/LIBRARIES/libpng-1.2.59/build/lib:$LD_LIBRARY_PATH
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc




$ cd /home/augusto.pereira/BUILD_WRF/LIBRARIES
$ tar -zxvf jasper-1.900.1.tar.gz
$ cd jasper-1.900.1
$ ./configure --prefix=$DIR/grib2
$ make
$ make install



## --------------------------------------------------------------------
# Testes
$ cd /home/augusto.pereira/TESTS
$ wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_NETCDF_MPI_tests.tar
$ tar -xvzf Fortran_C_NETCDF_MPI_tests.tar

# Teste 1 
$ cp ${NETCDF}/include/netcdf.inc .
$ gfortran -c 01_fortran+c+netcdf_f.f
$ gcc -c 01_fortran+c+netcdf_c.c
$ gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
$ ./a.out
# Expected output: SUCCESS test 1 fortran + c + netcdf

# Teste 2
$ cp ${NETCDF}/include/netcdf.inc .
$ mpif90 -c 02_fortran+c+netcdf+mpi_f.f
$ mpicc -c 02_fortran+c+netcdf+mpi_c.c
$ mpif90 02_fortran+c+netcdf+mpi_f.o 02_fortran+c+netcdf+mpi_c.o -L${NETCDF}/lib -lnetcdff -lnetcdf
$ mpirun ./a.out
# Expected output: SUCCESS test 2 fortran + c + netcdf + mpi
## --------------------------------------------------------------------





## --------------------------------------------------------------------
# Instalar o WRF
## --------------------------------------------------------------------


wget https://github.com/wrf-model/WRF/archive/refs/tags/v4.3.3.tar.gz
tar -xvzf v4.3.3.tar.gz
cd WRF-4.3.3

# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export WRF_DIR=/home/augusto.pereira/BUILD_WRF/WRF-4.3.3
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc






./configure
# selecionar opcoes:
# 34
# 1

## --------------------------------------------------------------------
## --------------------------------------------------------------------
## --------------------------------------------------------------------
# ATENCAO
## --------------------------------------------------------------------
## --------------------------------------------------------------------
## --------------------------------------------------------------------

# Agora atencao, apos o ./configure, sera gerado alguns arquivos e diretorios.

# Preste bem atencao no arquivo "configure.wrf". Dentro do "configure.wrf" possui um caminho para o diretorio "time" mas o Egeon não tem esse diretorio "time".

# Vamos fazer uma busca pelo "time" dentro do arquivo. Busca sera a seguinte: quero saber quais os numeros das linhas que tem o nome "time". Use o seguinte comando:

$ grep -n "time" configure.wrf

# A saida sera mais ou menos assim:
10:# file but be aware they will be overwritten each time you run configure.
78:ESMF_MOD_DEPENDENCE = $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90/module_utility.o
79:# select -I options for external/io_esmf vs. external/esmf_time_f90
80:ESMF_IO_INC         = -I$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90
83:# select cpp token for external/io_esmf vs. external/esmf_time_f90
85:# select build target for external/io_esmf vs. external/esmf_time_f90
86:ESMF_TARGET         = esmf_time
139:FC              =       time $(DM_FC)
213: ESMF_IO_LIB     =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
214:ESMF_IO_LIB_EXT =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
243:io_only:  esmf_time wrfio_nf   \
299:esmf_time :
300:    ( cd $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 ; \

# Veja que a linha 139 esta direcionando para o diretorio "time" mais o caminho para "$(DM_FC)".

# Vamos deixar somente "$(DM_FC)".

# Editar o "configure.wrf".

$ vi configure.wrf

10:# file but be aware they will be overwritten each time you run configure.
78:ESMF_MOD_DEPENDENCE = $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90/module_utility.o
79:# select -I options for external/io_esmf vs. external/esmf_time_f90
80:ESMF_IO_INC         = -I$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90
83:# select cpp token for external/io_esmf vs. external/esmf_time_f90
85:# select build target for external/io_esmf vs. external/esmf_time_f90
86:ESMF_TARGET         = esmf_time
139:FC              =       $(DM_FC) # time $(DM_FC)
213: ESMF_IO_LIB     =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
214:ESMF_IO_LIB_EXT =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
243:io_only:  esmf_time wrfio_nf   \
299:esmf_time :
300:    ( cd $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 ; \
# Comentei "time $(DM_FC)" e deixei somente "$(DM_FC)"

$ ./compile em_real >& compile.log & tail -f compile.log


# Compile the WRF-Chem external emissions conversion code
./compile emi_conv 2>1 | tee emission_compile.log


$ ls -las main/*.exe
# resultado:
lrwxrwxrwx 1 augusto.pereira augusto.pereira 28 Jan 20 12:38 test/em_real/convert_emiss.exe -> ../../chem/convert_emiss.exe
lrwxrwxrwx 1 augusto.pereira augusto.pereira 20 Jan 20 12:22 test/em_real/ndown.exe -> ../../main/ndown.exe
lrwxrwxrwx 1 augusto.pereira augusto.pereira 19 Jan 20 12:22 test/em_real/real.exe -> ../../main/real.exe
lrwxrwxrwx 1 augusto.pereira augusto.pereira 17 Jan 20 12:22 test/em_real/tc.exe -> ../../main/tc.exe
lrwxrwxrwx 1 augusto.pereira augusto.pereira 18 Jan 20 12:22 test/em_real/wrf.exe -> ../../main/wrf.exe











## --------------------------------------------------------------------
# Instalar o WPS
## --------------------------------------------------------------------

$ cd /home/augusto.pereira/BUILD_WRF
$ ./clean
$ mkdir WPS
$ cd WPS
$ wget https://github.com/wrf-model/WPS/archive/refs/tags/v4.3.1.tar.gz
$ cd WPS-4.3.1


# Editar o ~/.bashrc
$ vi ~/.bashrc
# Aperte a tecla "i" para editar o .bashrc

# Incluir as seguinte linhas no final de .bashrc
export JASPERLIB=$DIR/grib2/lib
export JASPERINC=$DIR/grib2/include
# aperte "esc" e digite ":wq" para salvar e sair

# Carregue a atualização do .bashrc
$ source ~/.bashrc




$ ./configure
# Select option 3 (Linux x86-64) gfortran (dmpar) for gfortran and distributed memory
$ ./compile >& compile.log & tail -f compile.log


# Verificar os executávies 
$ ls -ls *.exe

1 lrwxrwxrwx 1 augusto.pereira augusto.pereira 23 Jan  9 16:05 geogrid.exe -> geogrid/src/geogrid.exe
1 lrwxrwxrwx 1 augusto.pereira augusto.pereira 23 Jan  9 16:05 metgrid.exe -> metgrid/src/metgrid.exe
1 lrwxrwxrwx 1 augusto.pereira augusto.pereira 21 Jan  9 16:05 ungrib.exe -> ungrib/src/ungrib.exe










## --------------------------------------------------------------------
# Instalar o WRFDA 
## --------------------------------------------------------------------





$ ulimit -s unlimited
$ export MALLOC_CHECK_=0
$ export WRFIO_NCD_LARGE_FILE_SUPPORT=1 
$ export EM_CORE=1
$ export NMM_CORE=0



cd /home/augusto.pereira/BUILD_WRF
mkdir WRFDA
cd /home/augusto.pereira/BUILD_WRF/WRFDA

cp /home/augusto.pereira/BUILD_WRF/v4.3.1.tar.gz /home/augusto.pereira/BUILD_WRF/WRFDA
tar -xvzf v4.3.3.tar.gz
cd /home/augusto.pereira/BUILD_WRF/WRFDA//WRF-4.3.3

 ./configure wrfda
 # 34




 # Preste bem atencao no arquivo "configure.wrf". Dentro do "configure.wrf" possui um caminho para o diretorio "time" mas o Egeon não tem esse diretorio "time".

# Vamos fazer uma busca pelo "time" dentro do arquivo. Busca sera a seguinte: quero saber quais os numeros das linhas que tem o nome "time". Use o seguinte comando:

$ grep -n "time" configure.wrf

# A saida sera mais ou menos assim:
10:# file but be aware they will be overwritten each time you run configure.
78:ESMF_MOD_DEPENDENCE = $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90/module_utility.o
79:# select -I options for external/io_esmf vs. external/esmf_time_f90
80:ESMF_IO_INC         = -I$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90
83:# select cpp token for external/io_esmf vs. external/esmf_time_f90
85:# select build target for external/io_esmf vs. external/esmf_time_f90
86:ESMF_TARGET         = esmf_time
139:FC              =       time $(DM_FC)
213: ESMF_IO_LIB     =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
214:ESMF_IO_LIB_EXT =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
243:io_only:  esmf_time wrfio_nf   \
299:esmf_time :
300:    ( cd $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 ; \

# Veja que a linha 139 esta direcionando para o diretorio "time" mais o caminho para "$(DM_FC)".

# Vamos deixar somente "$(DM_FC)".

# Editar o "configure.wrf".

$ vi configure.wrf

10:# file but be aware they will be overwritten each time you run configure.
78:ESMF_MOD_DEPENDENCE = $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90/module_utility.o
79:# select -I options for external/io_esmf vs. external/esmf_time_f90
80:ESMF_IO_INC         = -I$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90
83:# select cpp token for external/io_esmf vs. external/esmf_time_f90
85:# select build target for external/io_esmf vs. external/esmf_time_f90
86:ESMF_TARGET         = esmf_time
139:FC              =       $(DM_FC) # time $(DM_FC)
213: ESMF_IO_LIB     =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
214:ESMF_IO_LIB_EXT =    -L$(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 -lesmf_time
243:io_only:  esmf_time wrfio_nf   \
299:esmf_time :
300:    ( cd $(WRF_SRC_ROOT_DIR)/external/esmf_time_f90 ; \
# Comentei "time $(DM_FC)" e deixei somente "$(DM_FC)"



./compile all_wrfvar >& compile.out


 ls -l var/build/*exe var/obsproc/src/obsproc.exe
 # resultado: 44 executáveis
-rwxrwxr-x 1 augusto.pereira augusto.pereira    35416 Jan 20 14:58 var/build/da_advance_time.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira   115208 Jan 20 14:59 var/build/da_bias_airmass.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira   106592 Jan 20 14:58 var/build/da_bias_scan.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira    48696 Jan 20 14:58 var/build/da_bias_sele.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira    61392 Jan 20 14:58 var/build/da_bias_verif.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira   135080 Jan 20 14:58 var/build/da_tune_obs_desroziers.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira   281120 Jan 20 14:59 var/build/da_tune_obs_hollingsworth1.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira   186880 Jan 20 14:59 var/build/da_tune_obs_hollingsworth2.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2131848 Jan 20 14:59 var/build/da_update_bc.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2090992 Jan 20 14:59 var/build/da_update_bc_ad.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2180744 Jan 20 14:59 var/build/da_verif_grid.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  1815776 Jan 20 14:59 var/build/da_verif_obs.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira 25497528 Jan 20 15:02 var/build/da_wrfvar.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2782800 Jan 20 14:59 var/build/gen_be_addmean.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2761048 Jan 20 14:59 var/build/gen_be_cov2d.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2773536 Jan 20 14:59 var/build/gen_be_cov2d3d_contrib.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2761048 Jan 20 14:59 var/build/gen_be_cov3d.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2773536 Jan 20 14:59 var/build/gen_be_cov3d2d_contrib.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2769448 Jan 20 14:59 var/build/gen_be_cov3d3d_bin3d_contrib.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2777632 Jan 20 14:59 var/build/gen_be_cov3d3d_contrib.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2752856 Jan 20 14:59 var/build/gen_be_diags.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2769432 Jan 20 14:59 var/build/gen_be_diags_read.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2765248 Jan 20 14:59 var/build/gen_be_ensmean.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2781664 Jan 20 14:59 var/build/gen_be_ensrf.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2842968 Jan 20 14:59 var/build/gen_be_ep1.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2916840 Jan 20 14:59 var/build/gen_be_ep2.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2839432 Jan 20 14:59 var/build/gen_be_etkf.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2769240 Jan 20 14:59 var/build/gen_be_hist.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2872408 Jan 20 14:59 var/build/gen_be_stage0_gsi.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2892592 Jan 20 14:59 var/build/gen_be_stage0_wrf.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2810200 Jan 20 14:59 var/build/gen_be_stage1.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2802016 Jan 20 14:59 var/build/gen_be_stage1_1dvar.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2802256 Jan 20 14:59 var/build/gen_be_stage1_gsi.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2785624 Jan 20 14:59 var/build/gen_be_stage2.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2802104 Jan 20 14:59 var/build/gen_be_stage2_1dvar.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  1505616 Jan 20 14:59 var/build/gen_be_stage2_gsi.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2773344 Jan 20 14:59 var/build/gen_be_stage2a.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2781528 Jan 20 14:59 var/build/gen_be_stage3.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2756960 Jan 20 14:59 var/build/gen_be_stage4_global.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2790032 Jan 20 14:59 var/build/gen_be_stage4_regional.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2757040 Jan 20 14:59 var/build/gen_be_vertloc.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  2892312 Jan 20 14:59 var/build/gen_mbe_stage2.exe
-rwxrwxr-x 1 augusto.pereira augusto.pereira  1105360 Jan 20 15:02 var/obsproc/src/obsproc.exe






# prep chem sources
cd /home/augusto.pereira/BUILD_WRF/
mkdir prep_chem
# wget ftp://aftp.fsl.noaa.gov/divisions/taq/global_emissions/prep_chem_sources_v1.5_24aug2015.tar.gz
# https://www.youtube.com/watch?v=d6zhi4gPbgw&list=PL93HaRiv5QkA_LyLj9rbbBD0QY2imFop0&index=2








