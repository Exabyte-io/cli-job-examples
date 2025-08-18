#!/bin/bash -l

# module load berkeleygw-tutorial
# kgrid="kgrid.x"

# srun -n 1 -c 4 --cpu-bind=cores $kgrid ./kgrid.inp ./kgrid.out ./kgrid.log

$CMD_PREFIX_BGW kgrid.x ./kgrid.inp ./kgrid.out ./kgrid.log
