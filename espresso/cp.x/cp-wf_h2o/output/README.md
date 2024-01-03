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
-rw-rw-r-- 2 timur timur 5.8K Jan  3 04:59 h2o_32.in
drwxrwxr-x 3 timur timur 4.0K Jan  3 05:05 .
-rw-rw-r-- 1 timur timur  97K Jan  3 05:13 h2o_32.wfc
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 h2o_32.vel
-rw-rw-r-- 1 timur timur 1.9K Jan  3 05:13 h2o_32.str
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 h2o_32.pos
-rw-rw-r-- 1 timur timur 1.2K Jan  3 05:13 h2o_32.nos
-rw-rw-r-- 1 timur timur  72K Jan  3 05:13 h2o_32.for
-rw-rw-r-- 1 timur timur 1.9K Jan  3 05:13 h2o_32.evp
-rw-rw-r-- 1 timur timur  11K Jan  3 05:13 h2o_32.eig
-rw-rw-r-- 1 timur timur 1.5K Jan  3 05:13 h2o_32.cel
-rw-rw-r-- 1 timur timur 2.7K Jan  3 05:13 h2o_32.spr
drwxrwxr-x 2 timur timur 4.0K Jan  3 05:13 h2o_32_50.save
-rw-rw-r-- 1 timur timur  77K Jan  3 05:13 h2o_32.out
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 h2o_32.con
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 h2o_32.pol
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 h2o_32.the
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 h2o_32.ncg
-rw-rw-r-- 1 timur timur    1 Jan  3 05:13 h2o_32.hrs
drwxrwxr-x 6 timur timur 4.0K Jan  3 05:13 ..

>>>>$ tree
.
├── h2o_32_50.save
│   ├── charge-density.dat
│   ├── data-file-schema.xml
│   ├── H_ONCV_PBE-SG15-1.2.upf
│   ├── lambda1
│   ├── lambdam1
│   ├── O_ONCV_PBE-SG15-1.2.upf
│   ├── print_counter
│   ├── wfc1.dat
│   └── wfcm1.dat
├── h2o_32.cel
├── h2o_32.con
├── h2o_32.eig
├── h2o_32.evp
├── h2o_32.for
├── h2o_32.hrs
├── h2o_32.in
├── h2o_32.ncg
├── h2o_32.nos
├── h2o_32.out
├── h2o_32.pol
├── h2o_32.pos
├── h2o_32.spr
├── h2o_32.str
├── h2o_32.the
├── h2o_32.vel
├── h2o_32.wfc
├── H_ONCV_PBE-SG15-1.2.upf
└── O_ONCV_PBE-SG15-1.2.upf
```
