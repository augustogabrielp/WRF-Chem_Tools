# mudar para o diretorio do WRF
cd /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real

# link dos arquivos do WPS para o WRF
ln -sf /home/augusto.pereira/BUILD_WRF/WPS/WPS-4.5/met_em* .

# executar um programa paralelo utilizando o protocolo MPI (Message Passing Interface)
# distribui tarefas entre diferentes processadores ou nós de um cluster/supercomputador.
mpirun -np 50 ./real.exe  # mpirun -np 50 ./real.exe | tee real_output.log


tail rsl.error.0000 # se tudo deu certo, a mensagem será: SUCCESS COMPLETE REAL_EM INIT is coreect.

ls -alh wrfbdy_d01 wrfinput_d01 # se tudo estiver correto, veremos as seguintes saídas: wrfbdy_d01 e wrfinput_d01.


#################################
# Preciso dos seguintes caminhos:
#################################

# /home/augusto.pereira/BUILD_WRF/Processors/megan_bio_emiss
# /home/augusto.pereira/BUILD_WRF/Processors/megan_data
# /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real

################################# 


cd /home/augusto.pereira/BUILD_WRF/Processors/megan_bio_emiss

vi namelist_megan.input








##################################################################
# O namelist_megan.input vai ficar assim:
##################################################################
&control
  domains       = 1,
  wrf_dir       = '/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real',
  met_em_flnm   = 'met_em.d01.*.nc',
  bio_emiss_flnm= 'wrfbiochemi_d<domain>',
  start_date    = '2024-08-01_00:00:00',
  end_date      = '2024-08-06_00:00:00',
  dt_m          =  60,       ! intervalo de saída em minutos
/
&files
  megan_data_dir= '/home/augusto.pereira/BUILD_WRF/Processors/megan_data',
  megan_data_flnm= '*.nc',
/
&grid
  grid_type     = 1,        ! 1 = lat-lon
  nx            = 378,
  ny            = 402,
  lo1           = -90.0,    ! lon e lat de canto SW do seu domínio
  la1           = -20.0,
  dx            = 20000.0,  ! seu dx em metros
  dy            = 20000.0,
/
##################################################################
# Aperte:
# esc
# :wq
##################################################################


####################################################################################################################################
# Será criado um arquivo "wrapper-megan.sh" que irá tratar os *.nc em ~/BUILD_WRF/Processors/megan_data
####################################################################################################################################

vi wrapper-megan.sh



##################################################################
##################################################################
##################################################################
##################################################################
#!/bin/bash
# wrapper-megan.sh

MEGAN_DATA_DIR='/home/augusto.pereira/BUILD_WRF/Processors/megan_data'
months=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

# 1) renomeia em memória cada arquivo mensal
for i in {1..12}; do
  idx=$(printf "%02d" $i)
  m=${months[$((i-1))]}
  infile="$MEGAN_DATA_DIR/laiv2003${idx}_30sec.nc"
  tmpfile="tmp${idx}.nc"

  echo "→ Renomeando LAI_for_${m}_2003_(m2_per_m2) → laiv em $infile"
  cdo "chname,LAI_for_${m}_2003_(m2_per_m2),laiv" \
      "$infile" "$tmpfile" || {
    echo "  ✗ falhou em $infile"; exit 1
  }
done

# 2) opcional: crie links para o MEGAN enxergar estes tmpXX.nc como wrfbiochemi…
for i in {1..12}; do
  idx=$(printf "%02d" $i)
  ln -sf "$(pwd)/tmp${idx}.nc" "wrfbiochemi_d01_$(date -d "2024-0${idx}-01" +%Y-%m-%d)_00:00:00"
done

# 3) roda o MEGAN
./megan_bio_emiss < namelist_megan.input
##################################################################
# Aperte:
# esc
# :wq
##################################################################


chmod +x wrapper-megan.sh
./wrapper-megan.sh










