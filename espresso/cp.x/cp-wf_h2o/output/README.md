# Quantum ESPRESSO CP-WF H2O example

This folder contains data for a CP-WF calculation of water molecule using the Quantum ESPRESSO code. 

Only some files are included in the [../output-reference](../output-reference) folder. 

See the full reference data content below.

## Full reference data content

The content of the directory is as follows:

```bash
>>>>$ ls -tlhra
total 624K
-rw-rw-r-- 2 timur timur  64K Jan  3 04:59 H_ONCV_PBE-SG15-1.2.upf
-rw-rw-r-- 2 timur timur  89K Jan  3 04:59 O_ONCV_PBE-SG15-1.2.upf
-rw-rw-r-- 2 timur timur 5.8K Jan  3 04:59 generate_dft_data.in
drwxrwxr-x 3 timur timur 4.0K Jan  3 05:05 .
-rw-rw-r-- 1 timur timur  97K Jan  3 05:13 generate_dft_data.wfc
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 generate_dft_data.vel
-rw-rw-r-- 1 timur timur 1.9K Jan  3 05:13 generate_dft_data.str
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 generate_dft_data.pos
-rw-rw-r-- 1 timur timur 1.2K Jan  3 05:13 generate_dft_data.nos
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 generate_dft_data.for
-rw-rw-r-- 1 timur timur 1.9K Jan  3 05:13 generate_dft_data.evp
-rw-rw-r-- 1 timur timur  11K Jan  3 05:13 generate_dft_data.eig
-rw-rw-r-- 1 timur timur 1.5K Jan  3 05:13 generate_dft_data.cel
-rw-rw-r-- 1 timur timur 2.7K Jan  3 05:13 generate_dft_data.spr
drwxrwxr-x 2 timur timur 4.0K Jan  3 05:13 generate_dft_data_50.save
-rw-rw-r-- 1 timur timur  77K Jan  3 05:13 generate_dft_data.out
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 generate_dft_data.con
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 generate_dft_data.pol
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 generate_dft_data.the
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 generate_dft_data.ncg
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 generate_dft_data.hrs
drwxrwxr-x 6 timur timur 4.0K Jan  3 05:13 ..

>>>>$ tree
.
├── generate_dft_data_50.save
│   ├── charge-density.dat
│   ├── data-file-schema.xml
│   ├── H_ONCV_PBE-SG15-1.2.upf
│   ├── lambda1
│   ├── lambdam1
│   ├── O_ONCV_PBE-SG15-1.2.upf
│   ├── print_counter
│   ├── wfc1.dat
│   └── wfcm1.dat
├── generate_dft_data.cel
├── generate_dft_data.con
├── generate_dft_data.eig
├── generate_dft_data.evp
├── generate_dft_data.for
├── generate_dft_data.hrs
├── generate_dft_data.in
├── generate_dft_data.ncg
├── generate_dft_data.nos
├── generate_dft_data.out
├── generate_dft_data.pol
├── generate_dft_data.pos
├── generate_dft_data.spr
├── generate_dft_data.str
├── generate_dft_data.the
├── generate_dft_data.vel
├── generate_dft_data.wfc
├── H_ONCV_PBE-SG15-1.2.upf
└── O_ONCV_PBE-SG15-1.2.upf
```
