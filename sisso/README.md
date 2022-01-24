# SISSO

SISSO (sure independence screening and sparsifying operator) is a technique for symbolic regression introduced in 2017 [1].
SISSO consists of an exhaustive feature generation step that combines input features using unary and binary operations, followed by sure independence screening, before finally a sparse linear model is fitted on the identified features. When combining features higher order features are selected based on their ability to fit the residual errors of models built using lower order features.

## Notes

Examples for both regression (`*-reg*`) and classification (`*-clf*`) tasks are presented. The regression task looks at predicting the energy difference between the Rock Salt (RS) and Zinc Blende (ZB) structures of octet-binary compounds. Whereas the classification task looks at predicting whether RS or ZB is lower in energy. 

In both problems the following feature set is used: the nuclear charge (Z); ionization potential (IP); electron affinity (EA); HOMO and LUMO energies (E_HOMO and E_LUMO); and radii of the atomic s, p and d-orbitals (r_s, r_p, and r_d) of the cation (A) and anion(B) of the materials. Additionally the radii of the \sigma and \pi orbitals of the dimer for each material are included.

These examples use the data from the official `sisso++` tutorial here: https://sissopp_developers.gitlab.io/sissopp/tutorial/0_intro.html . The original data was first presented in [2].

## Links

[1] - https://doi.org/10.1103/PhysRevMaterials.2.083802 (https://arxiv.org/abs/1710.03319)
[2] - https://doi.org/10.1103/PhysRevLett.114.105503
