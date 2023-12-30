# DEEPMD

DeePMD (Deep Potential Molecular Dynamics) [1] is a package for easily building
performant neural network potentials for carrying out molecular dynamics. The
DeePMD code base has been developed such that trained models can be interfaced
directly to LAMMPS.

Here we provide two sets of examples, one for training a neural network
potential using DeePMD, and a second for running a LAMMPS simulation using that
trained model.

We note that in order to have simple examples the model in question is trained
with a small amount of data for a short period of time. Consequently, the
accuracy of the resulting model is lower than we should expect for a model
trained for longer on a larger amount of data.


### Data Generation

This example invokes a python script to transform the output of a Car-Parrinello
molecular dynamics run using Quantum Espresso (See `espresso/CP/job.pbs`) into
the input format used by DeePMD-Kit. We divide our data set into two parts: 80
percent of the frames for training and 20 percent of the frames for validation.

```
module load deepmd/deepmd-2.0.2
cd qe_raw_output
python3 ../convert.py
```

### Model Training

The training script trains a model on the water data prepared in the previous
step and then freezes that model for production. The job must be submitted from
the same directory as the `model_training/job.pbs` file.


### Molecular Dynamics

The molecular dynamics script takes the `graph.pb` file produced by the training
example and carries out a prospective simulation using LAMMPS. As above the job
must be submitted from the same directory as the `molecular_dynamics/job.pbs`
file.


### Model inference

DP model can be used to evaluate the energy of each frame in the LAMMPS
trajectory.

```py
import dpdata

data = dpdata.System('water.dump', fmt="lammps/dump", type_map=["O", "H"])
d_predict = data.predict(dp="../model_training/results/graph.pb")
print(d_predict["energies"])
```


## Links

[1] - https://doi.org/10.1016/j.cpc.2018.03.016 (https://arxiv.org/abs/1712.03641)
