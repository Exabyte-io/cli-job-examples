#!/bin/bash -l

# This serial script runs kgrid.x to generate a file containing all
# the irreducible k-points (kgrid.out) and the relevant symmetry
# operations (kgrid.log).

# module load berkeleygw-tutorial
# kgrid="kgrid.x"

# srun -n 1 -c 4 --cpu-bind=cores $kgrid ./kgrid.inp ./kgrid.out ./kgrid.log

$CMD_PREFIX_BGW kgrid.x ./kgrid.inp ./kgrid.out ./kgrid.log
