#!/bin/bash

# Caminhos
WRF_DIR="/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real"
PFT_DIR="/home/augusto.pereira/BUILD_WRF/Processors/wes_coldens"
PFT_FILE="season_wes_usgs.nc"
DOMAINS=1  # Ajuste para quantos domínios tiver

# Cria arquivo wesely.inp automaticamente
cat > wesely.inp <<EOF
&control
  wrf_dir     = '${WRF_DIR}',
  pft_dir     = '${PFT_DIR}',
  pft_flnm    = '${PFT_FILE}',
  domains     = ${DOMAINS},
/
EOF

# Mostra o conteúdo do input criado
echo "Arquivo wesely.inp criado:"
cat wesely.inp
echo "============================="

# Executa e salva log
echo "Iniciando execução do wesely..."
./wesely < wesely.inp > wesely.out 2>&1

# Verifica se o arquivo de saída foi criado com sucesso
if [[ -f wrf_season_wes_usgs_d01.nc ]]; then
  echo "Arquivo gerado com sucesso:"
  ls -lh wrf_season_wes_usgs_d01.nc
else
  echo "Erro: arquivo wrf_season_wes_usgs_d01.nc não encontrado!"
  tail -n 40 wesely.out
fi
