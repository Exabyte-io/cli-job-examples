# Run Quantum ESPRESSO simulation on GPUs

- This examples uses CUDA enabled Quantum ESPRESSO
- The job is run on `GOF` queue which has 8 CPUs and 1 NVIDIA V100 GPU per node
- This example sets 1 MPI process with 8 OpenMP threads
- For comparison, we run the same job on 8 CPUs using CPU/Intel build of Quantum ESPRESSO
- Reference output files can be found under `./output-reference`.

Time taken by GPU job (1 MPI, 8 OpenMP on 8 CPUs + 1 NVIDIA V100 GPU):
```
    PWSCF        :     37.94s CPU     50.77s WALL
```

Time taken by CPU job (8 MPI on 8 CPUs):
```
    PWSCF        :  18m 0.56s CPU  18m25.33s WALL
```
