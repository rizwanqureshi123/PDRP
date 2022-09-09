# PDRP

This repository contains source files for the PDRP Project. The project mainly consists of three steps:
1 - Protein- drug complex modeling
2 - MD Simulation
3 - Extracting features from MD simulation and designing a machine learning based model for drug response classification.
First, we model the protein- drug complex in Rosetta, the protein structure was taken from Protein Data Bank. 
After that molecular dynamics simulation was performed for 2-ns. The MD simulation scripts are provided in this repository. After that we extract the binfing free energy and geometricatl features using the CGAL library.
Final, we combine these information with a 201 patient cohort dataset, that includes clinical information about the mutation type, drug response and other demographics features, such as, age, sex, smoking history etc etc.   
Finally, we apply five machine learning models to predict the drug response. The trajectory files can be obatined from Rizwan Qureshi ("engr.rizwanqureshi786@gmail.com").
