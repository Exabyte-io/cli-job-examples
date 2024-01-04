# Mat3ra CLI Examples

This repository contains example data for command-line jobs using commonly-deployed materials modeling packages on
Mat3ra.com [[1,2](#links)]. The package is pre-installed for all users of the platform as explained in the
corresponding [documentation](https://docs.mat3ra.com/data-on-disk/directories/#job-script-templates), however, the data
can also be used outside the platform as a standalone tool. The main goal of the repository is to provide a quick start
for the users.

| Simulation Engine | Folder                                                       | Description                                                                                                                                              |
|-------------------|--------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Quantum ESPRESSO  | [espresso/pw.x](espresso/pw.x/)                              | Self-consistent total energy calculation for FCC Silicon with Quantum ESPRESSO (QE) pw.x.                                                                
| VASP              | [vasp/](vasp/)                                               | Self-consistent total energy calculation for FCC Silicon with VASP (same as QE above).                                                                   
| Quantum ESPRESSO  | [espresso/cp.x](espresso/cp.x)                               | Car-Parinello Molecular Dynamics run with QE cp.x using Wannier functions. This MD trajectory is also used as a reference for the DeePMD use case below. 
| DeePMD            | [deepmd/train_mlff_qe-cp-traj](deepmd/train_mlff_qe-cp-traj) | Constructing Machine-learned Force Field using ab-initio data, neural networks, and further deployment using molecular dynamics package (LAMMPS).        
| LAMMPS            | [lammps/](lammps/)                                           | Basic Molecular Dyanmics run with LAMMPS for Copper using Lennard-Jones potential or EAM potential.                                                      
| GROMACS           | [gromacs/cpu-double](gromacs/cpu-double)                     | Basic Molecular Dyanmics run with GROMACS for multiple computational setups: CPU single and double-precision, and GPU single precision.                  
| NWChem            | [nwchem/](nwchem/)                                           | Basic Total Energy DFT calculation with NWChem for a water molecule.                                                                                     
| SISSO             | [sisso/README.md](sisso/README.md)                           | Example SISSO run. Consult README.md for more details.                                                                                                   


## 1. Usage

### 1.1. Within the Mat3ra.com Command-line Interface.

The examples are available under the `~/job_script_templates` directory for each user. Thus, to use an example, copy the
corresponding folder and submit the job script. Note the `-rL` flags for the copy command required to properly resolve
any symbolic links in the source folder.

```bash
cp -rL ~/cli-job-examples/espresso/pw.x espresso-example-pw.x
cd espresso-example-pw.x
qsub job.pbs
```

This should submit a job to the queue and print the job ID. The job ID can be used to check the status of the job using
the `qstat` command. Read more about the command-line jobs in
the [documentation](https://docs.mat3ra.com/jobs-cli/overview/).

### 1.2. Outside the Mat3ra.com Command-line Interface.

Sources are batch job scripts and can be cloned as below:

> [!NOTE]
> We use `git-lfs` to store some data (binary files, non-version-controllable sources). Please be sure to
> install `git-lfs` [[3](#links)] in order to get access to these data files.

```bash
git clone git@github.com:exabyte-io/cli-job-examples.git
```

or

```bash
git clone https://github.com/exabyte-io/cli-job-examples.git
```


## 2. Conventions.

### 2.1. Folder Structure.

The folder structure (circa 2024-01) is as follows:

```bash
.
├── cp2k
├── deepmd
│    └── train_mlff_qe-cp-traj
│        ├── step_01_generate_dft_data -> ../../espresso/cp.x/cp-wf_h2o
│        ├── step_02_preprocess_dft_data
│        │    ├── input
│        │    ├── output
│        │    └── output-reference/**
│        ├── step_03_train_mlff
│        │    ├── input
│        │    ├── output
│        │    └── output-reference
│        └── step_04_run_mlff_md
│            ├── input
│            ├── output
│            └── output-reference
├── espresso
│    ├── cp.x
│    │    └── cp-wf_h2o
│    │        ├── input
│    │        ├── output
│    │        └── output-reference
│    └── pw.x
├── gromacs
│    ├── cpu-double
│    ├── cpu-single
│    └── gpu-single
├── lammps
├── nwchem
├── sisso
│    ├── classification
│    └── regression
└── vasp
```

The top-level folder corresponds to the simulation engine. The next level - to a specific use case.
For some of the use cases the input/output/output-reference structure is used. The `input` folder contains the input
files, the `output` folder is empty and is meant to contain the output files during the run, and the `output-reference`
folder contains the reference output files for comparison purposes. The reference output files are used to compare the
output of the job with the reference output and to determine if the job has completed successfully.

### 2.2. Job Scripts.

The job script is always named `job.pbs` and is located in the root folder of the use case. The job script is meant to
be submitted from the root folder of the use case.


## 3. Contribution.

This repository is an [open-source](LICENSE.md) work-in-progress and we welcome contributions. We suggest forking this
repository and introducing the adjustments there, the changes in the fork can further be considered for merging into
this repository as it is commonly done on Github [[4](#links)].

## Links

1. [Mat3ra.com Documentation](https://docs.mat3ra.com)
2. [Command-line Jobs in the Mat3ra.com](https://docs.mat3ra.com/jobs-cli/overview/)
3. [Git Large File Storage](https://git-lfs.github.com/)
4. [GitHub Standard Fork & Pull Request Workflow](https://gist.github.com/Chaser324/ce0505fbed06b947d962)
