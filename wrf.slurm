#!/bin/bash
#SBATCH --job-name=wrf_chem
#SBATCH --partition=PESQ1,PESQ2
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=96        # 4 × 48 = 192
#SBATCH --exclusive
#SBATCH --time=12:00:00
#SBATCH --output=wrf_chem_output.log
#SBATCH --error=wrf_chem_error.log

module load mpi
module load netcdf

cd /home/augusto.pereira/BUILD_WRF/WRF-4.6.0/test/em_real

ulimit -s unlimited
ulimit -v unlimited
export OMP_STACKSIZE=512M
export WRF_DEBUG_LEVEL=0

echo "Início da execução: $(date)"
free -m > memoria_inicio.txt
time mpirun -np 384 ./wrf.exe
free -m >> memoria_fim.txt
echo "Fim da execução: $(date)"
