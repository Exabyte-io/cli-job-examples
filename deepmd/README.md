# DeePMD

## 1. Introduction

Example(s) in this folder demonstrate how to use DeePMD (Deep Potential Molecular Dynamics)[^1], a package for building  neural network potentials for molecular dynamics. The trained models can be interfaced directly to LAMMPS and other molecular dynamics codes.

### 1.1. Example(s): Machine Learning Force-field for H2O.

Located in [train_mlff_qe-cp-traj](train_mlff_qe-cp-traj/). In this CLI job example, we perform:

1. Ab-initio molecular dynamics calculation using Quantum ESPRESSO `cp.x`
2. Transform output data into DeePMD format for training and validation
3. Train a model and freeze it (save into a file) for reuse.
4. Use the frozen model for molecular dynamics calculation using `LAMMPS` included with DeePMD distribution.

The setup is similar to the one in Ref. [^2] below. The main difference is that we use the `cp.x` program from Quantum ESPRESSO to perform ab-initio molecular dynamics calculation. The resulting trajectory is then used to train a model using DeePMD. The trained model is then used to perform molecular dynamics calculation using LAMMPS.

The workflow can be invoked using the [run.sh](./train_mlff_qe-cp-traj/run.sh) script in the top-level folder. The [job.pbs](./train_mlff_qe-cp-traj/job.pbs) file in the top-level folder can be submitted to the queue to run all steps in sequence using `run.sh`.

Example usage (for a user inside the Mat3ra.com CLI):

```bash
mkdir mlff-h2o && cd mlff-h2o
cp -r ~/job_script_templates/deepmd/train_mlff_qe-cp-traj .
cd train_mlff_qe-cp-traj
sh run.sh
```

Then, we can check the status of the job using `qstat` command. Read more about the command-line jobs in the [documentation](https://docs.mat3ra.com/jobs-cli/overview/). Note that although 4 jobs are submitted, only one job is running at a time. The other jobs are in the queue waiting for the previous job in the sequence to finish.

```bash
qstat
Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
94883.master-production-20160 ...-MLFF-step_01 timur           00:00:01 R D              
94884.master-production-20160 ...-MLFF-step_02 timur                  0 H D              
94885.master-production-20160 ...-MLFF-step_03 timur                  0 H D              
94886.master-production-20160 ...-MLFF-step_04 timur                  0 H D  
```

The output directories can then be monitored with 

```bash
watch -n 5 ls -tlhra */output/
```

> [!NOTE]
> To have examples that can be run rather quickly, the setup is such that the model in question is trained with a small amount of data for a short period of time. Consequently, the accuracy of the resulting model is low as intended.

## 2. "DeePMD-MLFF" Workflow Steps

Important notes:

- We isolate each step to the corresponding folder starting with `step_` prefix, e.g. `step_01_generate_dft_data. This way we can run each step independently.
- Each subsequent step depends on the previous step. For example, `step_02_preprocess_dft_data` depends on `step_01_generate_dft_data` and so on. The content of the output folder of the previous step is used as the input for the next step by linking the files. See [./step_02_preprocess_dft_data/job.pbs](./train_mlff_qe-cp-traj/step_02_preprocess_dft_data/job.pbs) for an example.
- We use the [Folder Structure](README.md#folder-structure) with "input", "output", and "output-reference" folders for each step.
- Each step has a `job.pbs` file that can be submitted to the queue independently, assuming the previous step has been completed.
- There is a top-level [run.sh](./train_mlff_qe-cp-traj/run.sh) script that runs all steps in sequence. The [job.pbs](./train_mlff_qe-cp-traj/job.pbs) file in the top-level folder can be submitted to the queue to run all steps in sequence using `run.sh`.
- In order to introduce modifications, one can also edit [settings.sh](./train_mlff_qe-cp-traj/settings.sh) file in the top-level folder.

### 2.1. Ab-initio Molecular Dynamics.

Perform ab-initio molecular dynamics calculation using Quantum ESPRESSO `cp.x` program. For input files see under `espresso/cp.x`. We can run the calculation by using Car-Parrinello molecular dynamics with Quantum Espresso.

> [!NOTE]
> We have set prefix "h2o_32" to be the same as the base input filename "h2o_32.in". This way we get the same base file names (`{prefix}.???`) for other output files. When loading data using DeepMD `dpdata` tool, it expects the base names for various input files to be the same.

### 2.2. Data Conversion and Train/Test Split.

Next we invoke a [python script](./train_mlff_qe-cp-traj/step_02_preprocess_dft_data/input/convert_and_train_test_split.py) to transform the output of a
Car-Parrinello molecular dynamics run using Quantum Espresso into the input
format used by DeePMD-Kit. The data are saved under `model_training/data`.  We divide dataset into two parts: 80 percent of the frames for training and
20 percent of the frames for validation.

### 2.3. Model Training

The training script trains a model on the water data prepared in the previous
step and then freezes that model for production. The job must be submitted from
the same directory as the `model_training/job.pbs` file. The frozen model is
saved to file `model_training/results/graph.pb`.


### 2.4. (Classical) Molecular Dynamics.

The molecular dynamics script takes the `graph.pb` file produced by the training
example and carries out a prospective simulation using LAMMPS. As above the job
must be submitted from the same directory as the `molecular_dynamics/job.pbs`
file.


### 2.5. (Extra) Model inference

We can use the DeePMD python interface for model inference, for example, we can
evaluate the energy of each frame in the LAMMPS trajectory.

```py
import dpdata

data = dpdata.System('water.dump', fmt="lammps/dump", type_map=["O", "H"])
d_predict = data.predict(dp="../model_training/results/graph.pb")
print(d_predict["energies"])
```

### 2.6. (Extra) Molecular Dynamics with ASE.

We can also use the DeePMD python interface for invoking the Atomistic Simulations Environment (ASE) as explained in [^2]).

```python
from ase import Atoms
from deepmd.calculator import DP

water = Atoms('H2O',
              positions=[(0.7601, 1.9270, 1),
                         (1.9575, 1, 1),
                         (1., 1., 1.)],
              cell=[100, 100, 100],
              calculator=DP(model="frozen_model.pb"))
print(water.get_potential_energy())
print(water.get_forces())
```

Optimization can be performed as:

```python
from ase.optimize import BFGS
dyn = BFGS(water)
dyn.run(fmax=1e-6)
print(water.get_positions())
```

## 3. Links.

[^1]: [DeePMD-kit: A deep learning package for many-body potential energy representation and molecular dynamic](https://doi.org/10.1016/j.cpc.2018.03.016); ([arXiv](https://arxiv.org/abs/1712.03641)).
[^2]: [DeePMD-kit: Getting Started](https://docs.deepmodeling.com/projects/deepmd/en/v2.0.0.b4/getting-started.html#)
