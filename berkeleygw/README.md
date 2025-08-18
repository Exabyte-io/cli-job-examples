# Hands-on Session: Silicon

https://workshop2023.berkeleygw.org

## Overview

In this session we will calculate the quasiparticle band structure of silicon
using the LDA and GW approximations. There are two top level directories:

**1-mf-qe:** Perform DFT calculations using Quantum ESPRESSO and convert QE
outputs to BerkeleyGW format.

**2-bgw-qe:** Perform GW calculation using BerkeleyGW code.


## Instructions

1. Review and run `bash run-all.sh`.
2. Make bandstructure plot.

```
# create and activate python virtualenv
python3 -m venv .venv
source .venv/bin/activate

# install python packages
pip install numpy matplotlib

# run plot script
cd 2-bgw-qe/2-sigma/bandstructure
python3 2-plot_bandstructure.py
```

The plot is saved as `Si_bands.pdf`. It is wellknown that standard DFT under
estimates semiconductor bandgap. With GW approximation, the bandgap value is
more closer to the experimental value.

```
LDA gap: 0.483 eV
GW gap: 1.137 eV
```
