# DEEPMD

DeePMD (Deep Potential Molecular Dynamics)[^1] is a package for easily building
performant neural network potentials for carrying out molecular dynamics. The
DeePMD code base has been developed such that trained models can be interfaced
directly to LAMMPS.

In this CLI job example, we perform:
 - Ab-initio molecular dynamics calculation using Quantum ESPRESSO cp.x
 - We transform QE output data into DeePMD format for neural network training
and validation
 - Freeze the trained model (saved into a file) for production
 - Use the frozen model for molecular dynamics calculation using LAMMPS
 - Finally, we make some inferences of our model.

Below we walkthrough the above steps in more details.


> [!NOTE]
> We note that in order to have simple examples the model in question is trained with a small amount of data for a short period of time. Consequently, the accuracy of the resulting model is lower than we should expect for a model trained for longer on a larger amount of data.

### Ab-initio Molecular Dynamics

Perform ab-initio molecular dynamics calculation using Quantum ESPRESSO `cp.x`
program. For input files see under `espresso/cp.x`. We can run the calculation
by using the PBS script `espresso/cp.x/job.pbs`.

> [!NOTE]
> Here we have set prefix (`h2o_32`) same as base input filename (`h2o_32.in`), in that way we get same base file names (`{prefix}.???`) for various output files. While loading data using dpdata, it expects base file names for various input files to be the same.

Once the calculation is finished we may copy the input and output files to
`deepmd/data_generation/qe_raw_output` for next step.

### Data Generation

Next we invoke a python script (`convert.py`) to transform the output of a
Car-Parrinello molecular dynamics run using Quantum Espresso into the input
format used by DeePMD-Kit. The data are saved under `model_training/data`.

We divide our data set into two parts: 80 percent of the frames for training and
20 percent of the frames for validation.

```
module load deepmd/deepmd-2.0.2
cd deepmd/data_generation/qe_raw_output
python3 ../convert.py
```

### Model Training

The training script trains a model on the water data prepared in the previous
step and then freezes that model for production. The job must be submitted from
the same directory as the `model_training/job.pbs` file. The frozen model is
saved to file `model_training/results/graph.pb`.


### Molecular Dynamics

The molecular dynamics script takes the `graph.pb` file produced by the training
example and carries out a prospective simulation using LAMMPS. As above the job
must be submitted from the same directory as the `molecular_dynamics/job.pbs`
file.


### Model inference

We can use the DeePMD python interface for model inference, for example, we can
evaluate the energy of each frame in the LAMMPS trajectory.

```py
import dpdata

data = dpdata.System('water.dump', fmt="lammps/dump", type_map=["O", "H"])
d_predict = data.predict(dp="../model_training/results/graph.pb")
print(d_predict["energies"])
```


## Links

[^1]: [DeePMD-kit: A deep learning package for many-body potential energy representation and molecular dynamic](https://doi.org/10.1016/j.cpc.2018.03.016) ([arXiv](https://arxiv.org/abs/1712.03641)).
