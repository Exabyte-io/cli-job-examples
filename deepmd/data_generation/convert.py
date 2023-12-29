import dpdata
import numpy as np

data = dpdata.LabeledSystem("h2o_32", fmt="qe/cp/traj")
print('# the data contains %d frames' % len(data))

# randomly choose 20% index for validation_data
size = len(data)
size_validation = round(size * 0.2)

index_validation = np.random.choice(size, size=size_validation, replace=False)
index_training = list(set(range(size)) - set(index_validation))

data_training = data.sub_system(index_training)
data_validation = data.sub_system(index_validation)

# all training data put into directory:"training_data"
data_training.to_deepmd_npy('training_data')
# all validation data put into directory:"validation_data"
data_validation.to_deepmd_npy('validation_data')
print('# the training data contains %d frames' % len(data_training))
print('# the validation data contains %d frames' % len(data_validation))
