


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

# /home/augusto.pereira/BUILD_WRF/Processors/ANTHRO/ANTHRO/src
# /home/augusto.pereira/BUILD_WRF/Processors/EDGAR/EDGAR-HTAP/MOZCART
# /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real

#################################                                           # Editar o mozcart.inp:                                                     #################################

cd /home/augusto.pereira/BUILD_WRF/Processors/ANTHRO/ANTHRO/src

ls mozcart.inp

vi mozcart.inp







#######################################################
# Verifique o seguinte vídeo, foi usado como referência:
# https://www.youtube.com/watch?v=T6Ci7VrFmRY&list=PLWZdud6ndmYdusq7GosiYCBeG28oW5Aou&index=3
# Editei o meu mozcart.inp e o resultado é o seguinte:
#######################################################

&CONTROL
 anthro_dir      = '/home/augusto.pereira/BUILD_WRF/Processors/EDGAR/EDGAR-HTAP/MOZCART'
 domains         = 1
 wrf_dir         = '/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real'
 src_file_prefix = 'EDGAR_HTAP_emi_'        ! 'IPCC_emissions_'
 src_file_suffix = '_2010.0.1x0.1.nc'       ! '_surface_1850-2000_1.9x2.5.nc'
 ! src_names = 'CO(28)','NO(30)','BIGALK(72)','BIGENE(56)','C2H4(28)','C2H5OH(46)',
 !            'C2H6(30)','C3H6(42)','C3H8(44)','CH2O(30)','CH3CHO(44)','CH3COCH3(58)',
 !            'CH3OH(32)','MEK(72)','SO2(64)','TOLUENE(92)','NH3(17)',
 !            'OC(12)','BC(12)','CH3COOH(60)'
 ! sub_categories = 'anthro'
 ! emis_map = 'CO->CO','NO->NO','BIGALK->BIGALK','C2H4->C2H4','C2H5OH->C2H5OH',
 !           'C2H6->C2H6','C3H6->C3H6','C3H8->C3H8','CH2O->CH2O','CH3CHO->CH3CHO',
 !           'CH3COCH3->CH3COCH3','CH3OH->CH3OH','MEK->MEK','SO2->SO2','TOLUENE->TOLUENE',
 !           'NH3->NH3','OC(a)->OC','BC(a)->BC','CH3COOH->CH3COOH'

 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 ! Verificar que mudei NO para NOx
 ! Retirada do CH3COOH
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 src_names = 'CO(28)','NOx(30)','BIGALK(72)','BIGENE(56)','C2H4(28)','C2H5OH(46)',
             'C2H6(30)','C3H6(42)','C3H8(44)','CH2O(30)','CH3CHO(44)','CH3COCH3(58)',
             'CH3OH(32)','MEK(72)','SO2(64)','TOLUENE(92)','NH3(17)',
             'OC(12)','BC(12)'
 sub_categories = 'anthro'
 emis_map = 'CO->CO','NO->NOx','BIGALK->BIGALK','C2H4->C2H4','C2H5OH->C2H5OH',
            'C2H6->C2H6','C3H6->C3H6','C3H8->C3H8','CH2O->CH2O','CH3CHO->CH3CHO',
            'CH3COCH3->CH3COCH3','CH3OH->CH3OH','MEK->MEK','SO2->SO2','TOLUENE->TOLUENE',
            'NH3->NH3','OC(a)->OC','BC(a)->BC'

 ! sub_categories = 'anthro'
 serial_output     = .true.
 start_output_time = '2024-08-01_00:00:00'        ! De acordo com o namelist.input
 stop_output_time  = '2024-08-06_00:00:00'        ! De acordo com o namelist.input
 data_yrs_offset   = +14,   ! Os dados do EDGAR são de 2010, e no meu namelist, estou trabalhando com o ano de 2024, ou seja, inserir "+14" anos
 output_interval   = 86400  ! Quero a saída a cada 86400 segundos, ou seja, a cada 24 horas
/




#######################################################
# Após editar, salve o mozcart.inp
# esc
# :wq
#######################################################




./anthro_emiss < mozcart.inp
