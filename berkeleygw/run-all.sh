#!/bin/bash
set -e

export OMP_NUM_THREADS=1
export CMD_PREFIX_QE="mpirun --allow-run-as-root -np 4 apptainer run /root/qe-7.4-gcc-openmpi-openblas.sif "
export CMD_PREFIX_BGW="mpirun --allow-run-as-root -np 4 apptainer run /root/berkeleygw-4.0-gnu.sif "

cd 1-mf-qe
bash link_files.sh

cd 1-scf
bash 1-calculate_scf.run
cd ..

cd 2-wfn
bash 1-calculate_wfn.run
bash 2-convert_wfn.run
cd ..

cd 3-wfnq
bash 1-calculate_wfn.run
bash 2-convert_wfn.run
cd ..

cd 4-bandstructure
bash 1-calculate_wfn.run
bash 2-convert_wfn.run
cd ..

cd ..
cd 2-bgw-qe
bash link_files.sh

cd 1-epsilon
bash 1-run_epsilon.run
cd ..

cd 2-sigma
bash 1-run_sigma.run

cd bandstructure
bash 1-run_inteqp.run
