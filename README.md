# MICCAI14_tracking

This repository for reproducing the result of the following paper.

> Yeqing Li, Chen Chen, Xiaolei Huang, and Junzhou Huang, “Instrument Tracking via Online Learning in Retinal Microsurgery”, the Annual International Conference on Medical Image Computing and Computer Assisted Intervention (MICCAI), 2014.

The source code is mainly based on [TLD](http://personal.ee.surrey.ac.uk/Personal/Z.Kalal/tld.html).

Start from the following two items:

+ **run_TLD_MICCAI14.m** is used to run most of the experiments. By changing the value of the variable *i* in line 22, one can run the experiments on each video sequence. The order of video sequences is the same as proposed in the [MICCAI paper](https://dl.dropboxusercontent.com/u/67398418/Papers/MICCAI14/MICCAI14Tracking.pdf). The first three sequences are retinal microsurgery sequences and the last two are laparoscopy surgery sequences.
+ **RetinalData** folder contains all the data for all the experiments.

Step of running the experiments.

1. Run the MatLab script **run_TLD_MICCAI14.m** and it will store the results in *RetinalData\separate* folder.
2. Go to the *RetinalData\separate* folder, the **convert.m** script will transform the TLD format results to the [DDVT](https://sites.google.com/site/sznitr/code-and-datasets) format result and make the plots. Currently it will reproduce the figures in the supplementary material.
3. Go to the *RetinalData\package\scripts*, the **scriptMakeGraphs.m** script will generate the figures for the first three sequences (seq1 to seq3).
4. Also in the *RetinalData\package\scripts*, the **mainMakeGraphsm** script will generate the figures for the last two sequences (seq4 and seq5). This can be done by running the script and setting *dbid* to 4 or 5.


> Sznitman, Raphael, et al. "Data-driven visual tracking in retinal microsurgery." Medical Image Computing and Computer-Assisted Intervention–MICCAI 2012. Springer Berlin Heidelberg, 2012. 568-575.