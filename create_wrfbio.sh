#!/bin/bash

# Caminhos
WRF_DIR="/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real"
MEGAN_DIR="/home/augusto.pereira/BUILD_WRF/Processors/megan_data"
EXEC="./megan_bio_emiss"
INP="megan_bio_emiss.inp"
OUT="megan_bio_emiss.out"

# Gera o arquivo de entrada
cat > $INP <<EOF
&control
 domains = 1,
 start_lai_mnth = 7,
 end_lai_mnth   = 8,
 wrf_dir   = '$WRF_DIR',
 megan_dir = '$MEGAN_DIR'
/
EOF

# Executa o programa
$EXEC < $INP > $OUT

# Verifica se o arquivo foi gerado
if [ -f wrfbiochemi_d01 ]; then
    echo "wrfbiochemi_d01 gerado com sucesso."
else
    echo "Erro: wrfbiochemi_d01 não foi gerado. Verifique o log em $OUT."
fi


#####################################################################################################################################################
#cd /home/augusto.pereira/BUILD_WRF/Processors/megan_bio_emiss
#vi megan_bio_emiss.inp
#############################################################
#&control
 #domains = 1,
 #start_lai_mnth = 7,
 #end_lai_mnth   = 8,
 #wrf_dir   = '/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real',
 #megan_dir = '/home/augusto.pereira/BUILD_WRF/Processors/megan_data'
#/
#[augusto.pereira@headnode megan_bio_emiss]$ ./megan_bio_emiss < megan_bio_emiss.inp > megan_bio_emiss.out
#[augusto.pereira@headnode megan_bio_emiss]$ cat megan_bio_emiss.inp
#&control
 #domains = 1,
 #start_lai_mnth = 7,
 #end_lai_mnth   = 8,
 #wrf_dir   = '/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real',
 #megan_dir = '/home/augusto.pereira/BUILD_WRF/Processors/megan_data'
#/
#############################################################
# Esc
# :wq!
#./megan_bio_emiss < megan_bio_emiss.inp > megan_bio_emiss.out




