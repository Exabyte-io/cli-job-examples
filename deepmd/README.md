# DEEPMD

DeePMD (Deep Potential Molecular Dynamics) [1] is a package for easily building performant neural network potentials for carrying out molecular dynamics. The DeePMD code base has been developed such that trained models can be interfaced directly to LAMMPS.

## Notes

Here we provide two sets of examples, one for training a neural network potential using DeePMD, and a second for running a LAMMPS simulation using that trained model.
We note that in order to have simple examples the model in question is trained with a small amount of data for a short period of time. Consequently, the accuracy of the resulting model is lower than we should expect for a model trained for longer on a larger amount of data.

### Data Generation

This example invokes a python script to transform the output of a Car-Parrinello molecular dynamics run using Quantum Espresso (See `espresso/cp.x/job.pbs`) into the input format used by DeePMD-Kit.

```
module load deepmd/deepmd-2.0.2
python convert.py
```

### Model Training

The training script trains a model on the water data provided in the package examples [2] and then freezes that model for production. The job must be submitted from the same directory as the job.pbs file.

### Molecular Dynamics

The molecular dynamics script takes the `frozen_model.pb` file produced by the training example and carries out a prospective simulation using LAMMPS. As above the job must be submitted from the same directory as the job.pbs file.


## Links

[1] - https://doi.org/10.1016/j.cpc.2018.03.016 (https://arxiv.org/abs/1712.03641)

[2] - https://github.com/deepmodeling/deepmd-kit/tree/master/examples/water/data