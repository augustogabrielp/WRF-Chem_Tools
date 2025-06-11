#!/bin/bash

# Diretórios e parâmetros
WRF_DIR="/home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real"
EXO_DIR="/home/augusto.pereira/BUILD_WRF/Processors/wes_coldens"
EXO_FILE="exo_coldens.nc"
DOMAINS=1

# Cria o arquivo de entrada .inp
cat > exo_coldens.inp <<EOF
&control
  wrf_dir   = '${WRF_DIR}',
  exo_dir   = '${EXO_DIR}',
  exo_flnm  = '${EXO_FILE}',
  domains   = ${DOMAINS},
/
EOF

echo "Iniciando geração de exo_coldens_d0X..."

# Executa utilitário
cd "$EXO_DIR"
./exo_coldens < exo_coldens.inp > exo_coldens.out 2>&1

# Verificação e cópia
if [[ -f exo_coldens_d01 ]]; then
  echo "Geração concluída com sucesso:"
  ls -lh exo_coldens_d0*

  echo "Copiando arquivos para ${WRF_DIR}..."
  cp -v exo_coldens_d0* "${WRF_DIR}/"
else
  echo "Erro: os arquivos não foram gerados."
  echo "Últimas linhas do log:"
  tail -n 30 exo_coldens.out
fi
