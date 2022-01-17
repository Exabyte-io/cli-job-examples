# SISSO

SISSO (sure independence screening and sparsifying operator) is a technique for symbolic regression introduced in 2017 [1].
SISSO consists of an exhaustive feature generation step that combines input features using unary and binary operations, followed by sure independence screening, before finally a sparse linear model is fitted on the identified features. When combining features higher order features are selected based on their ability to fit the residual errors of models built using lower order features.

## Notes

This example uses the same input files as in the sisso cli tutorial here: https://sissopp_developers.gitlab.io/sissopp/tutorial/1_command_line.html

## Links

[1] - https://link.aps.org/doi/10.1103/PhysRevMaterials.2.083802 (https://arxiv.org/abs/1710.03319)
