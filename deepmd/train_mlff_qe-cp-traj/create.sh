#!/bin/bash
# ---------------------------------------------------------------- #
#  Run script that re-creates input files for this directory.       #
#  It expects the following:                                       #
#   - /dropbox/${ACCOUNT_NAME}/pseudopotentials/   with psp files  #
#   - /dropbox/${ACCOUNT_NAME}/structures/   with lammps structure #
# ---------------------------------------------------------------- #
ACCOUNT_NAME="seminar"
PROJECT_NAME="seminar-default"

# Copy cli job example to create subfolders
cp -Lr ~/job_script_templates/deepmd/train_mlff_qe-cp-traj/* .

# ---------------------------------------------------------------- #
#  step_01                                                         #
# ---------------------------------------------------------------- #
PREFIX=./step_01/input/
cp /dropbox/${ACCOUNT_NAME}/pseudopotentials/O_ONCV_PBE-SG15-1.2.upf $PREFIX/
cp /dropbox/${ACCOUNT_NAME}/pseudopotentials/H_ONCV_PBE-SG15-1.2.upf $PREFIX/

cat > ${PREFIX}/generate_dft_data.in <<EOF
&control
    title = 'water 32 Molecules - PBE 330K'
    calculation = 'cp-wf'
    restart_mode = 'from_scratch'
    prefix = 'generate_dft_data'
    pseudo_dir = '.'
    outdir = '.'
    nstep = 50
    isave = 100
    dt = 2.0
    tstress = .true.
    tprnfor = .true.
    iprint = 1
    ekin_conv_thr = 1e-06
/

&system
    ibrav = 1
    celldm(1) = 18.6655
    nat = 96
    ntyp = 2
    ecutwfc = 13.0
    ecfixed = 130.0
    q2sigma = 15.0
    qcutz = 200.0
    input_dft = 'PBE'
    tot_charge = -1
/

&electrons
    electron_dynamics = 'verlet'
    emass = 100.0
    emass_cutoff = 25.0
    ortho_max = 800
    electron_maxstep = 500
/

&ions
    ion_dynamics = 'verlet'
    ion_temperature = 'nose'
    fnosep = 60
    tempw = 330
    nhpcl = 4
    nhptyp = 2
    ndega = -3
    ion_radius(1:2) = 1.4, 1.4
/

&wannier
    nit = 60
    calwf = 3
    tolw = 1e-06
    nsteps = 50
    adapt = .false.
    wfdt = 2.0
    wf_q = 500.0
    wf_friction = 0.3
/

ATOMIC_SPECIES
 O  15.999   O_ONCV_PBE-SG15-1.2.upf
 H  1.00784  H_ONCV_PBE-SG15-1.2.upf

ATOMIC_POSITIONS {bohr}
O      16.115500     -21.906700      97.672200
O      11.535400     -10.947300      92.713400
O      22.991200     -32.624600      80.239500
O       7.112770     -28.170900      92.139600
O       9.498750     -20.522900      94.523300
O      16.614700     -17.437400      86.715700
O      -0.250940     -32.047100      93.581100
O      17.469200     -24.812800      91.772600
O       9.524150     -34.655800      88.823200
O       8.646670     -23.127000      80.473000
O       3.661560     -29.162100      95.102700
O      20.994300     -22.003300      94.398000
O      13.729200     -21.798100      86.691800
O      15.328800     -31.839300      89.628700
O       4.948030     -32.134500      86.140100
O      19.106100     -28.885300      88.403200
O       5.670910     -20.621000      91.015300
O      12.086300     -41.887700      91.442500
O      12.404700     -26.504100      97.555400
O      10.641400     -15.725800      76.697100
O      10.104400     -19.437800      83.896400
O      16.785300     -25.509200      85.375900
O      17.737300     -33.450200      82.239200
O       8.784620     -34.029400      81.163300
O      20.335500     -22.655000     102.239000
O      14.653500     -29.344700     101.390000
O       3.948620     -24.674200      98.203400
O       2.253850     -34.988000      89.772700
O      24.790200     -21.673500      86.279900
O      15.698800     -16.475400      96.577500
O      26.331200     -26.456600      86.658800
O      10.426000     -30.654900      84.468000
H      16.323000     -22.057300      99.444200
H      17.805500     -22.052000      96.880900
H      11.264800     -12.795200      93.484300
H      12.783800     -11.097400      91.358800
H      22.615100     -31.097300      78.995100
H      21.289700     -33.353500      80.136300
H       8.874440     -28.650000      92.204500
H       6.738120     -27.809200      90.354400
H      11.025500     -21.181700      93.585400
H      10.053800     -18.739800      94.771200
H      17.089900     -16.687100      85.066300
H      18.243400     -17.453800      87.831500
H       0.771254     -33.440800      92.850400
H      -1.344430     -31.981600      92.151100
H      17.976600     -26.316900      90.895600
H      15.696700     -24.455100      91.412200
H       9.276290     -36.419400      88.523400
H       8.937950     -34.298700      90.486600
H       8.959260     -22.445900      78.616300
H       9.674190     -24.695100      80.326400
H       2.242770     -29.899100      94.126800
H       4.886080     -28.868000      93.774200
H      19.714200     -22.948700      93.611500
H      21.652000     -22.956400      95.845600
H      12.531000     -20.831800      85.599700
H      14.986200     -20.438000      86.854800
H      16.764800     -30.766000      89.014600
H      15.479200     -33.493700      88.721100
H       4.740850     -32.317400      84.322400
H       6.658540     -32.636600      86.497100
H      20.699400     -29.497400      87.624300
H      18.241900     -27.830000      87.234100
H       6.948440     -20.535300      92.366100
H       4.306240     -21.416800      92.137900
H      12.502400     -41.428400      89.550100
H      10.920200     -43.186800      91.345800
H      13.457900     -25.121800      96.981100
H      11.911800     -27.632200      96.098200
H       9.866910     -15.303500      78.580700
H      12.517400     -15.986700      76.917000
H       9.713850     -17.788500      83.136700
H       9.478480     -20.537700      82.608900
H      18.229500     -24.517200      84.674900
H      15.538000     -24.205700      85.935800
H      16.676500     -32.031400      82.501200
H      16.892700     -34.270500      80.756400
H       6.953730     -33.709700      80.944500
H       9.148410     -32.575400      82.290700
H      21.725900     -22.265600     103.388000
H      21.125900     -23.441700     100.747000
H      14.257300     -28.577300      99.627300
H      15.161200     -27.788000     102.229000
H       5.692090     -24.652400      98.808100
H       3.351460     -26.335500      97.706200
H       3.446270     -36.127900      90.536800
H       3.289630     -34.010300      88.610200
H      26.192100     -20.735400      85.692000
H      24.818900     -21.432700      88.079500
H      16.879000     -15.631100      95.272300
H      15.867200     -18.318100      96.720300
H      25.902300     -24.719700      86.187200
H      27.198800     -27.406300      85.341600
H      10.923400     -31.391500      86.097500
H      12.225900     -30.308000      83.613300
EOF


# ---------------------------------------------------------------- #
#  step_02                                                         #
# ---------------------------------------------------------------- #
PREFIX=./step_02/input/
cat > ${PREFIX}/convert_and_train_test_split.py <<EOF
import dpdata
import numpy as np

# https://docs.deepmodeling.com/projects/dpdata/en/master/formats/QECPTrajFormat.html
data = dpdata.LabeledSystem("generate_dft_data", fmt="qe/cp/traj")
print("Dataset contains total {0} frames".format(len(data)))

# randomly choose 20% index for validation_data
size = len(data)
size_validation = round(size * 0.2)

index_validation = np.random.choice(size, size=size_validation, replace=False)
index_training = list(set(range(size)) - set(index_validation))

data_training = data.sub_system(index_training)
data_validation = data.sub_system(index_validation)

print("Using {0} frames as training set".format(len(data_training)))
print("Using {0} frames as validation set".format(len(data_validation)))

# save training and validation sets
data_training.to_deepmd_npy("./training")
data_validation.to_deepmd_npy("./validation")
EOF



# ---------------------------------------------------------------- #
#  step_03                                                         #
# ---------------------------------------------------------------- #
PREFIX=./step_03/input/
cat > ${PREFIX}/dp_train_input.json <<EOF
{
    "model": {
        "type_map": [
            "O",
            "H"
        ],
        "descriptor": {
            "type": "se_e2_r",
            "sel": [
                23,
                46
            ],
            "rcut_smth": 0.50,
            "rcut": 5.00,
            "neuron": [
                5,
                5,
                5
            ],
            "resnet_dt": false,
            "seed": 1
        },
        "fitting_net": {
            "neuron": [
                60,
                60,
                60
            ],
            "resnet_dt": true,
            "seed": 1
        }
    },
    "learning_rate": {
        "type": "exp",
        "decay_steps": 1000,
        "start_lr": 0.005,
        "stop_lr": 3.51e-6
    },
    "loss": {
        "start_pref_e": 0.02,
        "limit_pref_e": 1,
        "start_pref_f": 1000,
        "limit_pref_f": 1,
        "start_pref_v": 0,
        "limit_pref_v": 0
    },
    "training": {
        "training_data": {
            "systems": [
                "./training/"
            ],
            "batch_size": "auto"
        },
        "validation_data": {
            "systems": [
                "./validation/"
            ],
            "batch_size": "auto"
        },
        "numb_steps": 301,
        "seed": 1,
        "disp_file": "lcurve.out",
        "disp_freq": 10,
        "numb_test": 1,
        "save_freq": 100
    }
}
EOF


# ---------------------------------------------------------------- #
#  step_04                                                         #
# ---------------------------------------------------------------- #
PREFIX=./step_04/input/
cat > ${PREFIX}/in.lammps <<EOF
# LAMMPS input, deepmd-kit version. Built from bulk water calculation.

units           metal
boundary        p p p
atom_style      atomic

neighbor        2.0 bin
neigh_modify    every 10 delay 0 check no

read_data       structure.lmp
mass            1 16
mass            2 2

pair_style	    deepmd ./graph.pb
pair_coeff      * *

velocity        all create 330.0 23456789

fix             1 all nvt temp 330.0 330.0 0.5
timestep        0.0005
thermo_style    custom step pe ke etotal temp press vol
thermo          100
dump            1 all custom 100 structure.dump id type x y z

run             100
EOF

cp /dropbox/${ACCOUNT_NAME}/structures/structure.lmp $PREFIX/


# ---------------------------------------------------------------- #
#  Run workflow                                                    #
# ---------------------------------------------------------------- #
PROJECT_NAME=${PROJECT_NAME} WAIT_FOR_COMPLETION=1 bash run.sh
