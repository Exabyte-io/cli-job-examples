import dpdata

d_qe = dpdata.LabeledSystem("qe_raw_output/h2o_32", "qe/cp/traj")

d_qe.to_deepmd_raw('./deepmd_data/')
