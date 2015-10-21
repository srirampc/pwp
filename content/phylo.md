---
title: ALFRED for Phylogenetic Inference
is_hidden: true
_:
---

# ALFRED : Distance Estimator for Phylogenetic Inference

AlFRED is an Alignment Free Distance Estimator software for Phylogenetic
Inference. It takes as input a set of n sequences and ouputs an n x n
matrix of distance estimate for use in Phylogenetic inference.

# Downloads

1. [ALFRED source code](assets/docs/alfred.tar.gz)
2. [Datasets](assets/docs/datasets.tar.gz)


# Installation and Usage

## Dependencies
### External Dependencies that need to be installed
* A modern, C++11 ready compiler such as `g++` version 4.8 or higher or `clang` version 3.2 or higher.
* The [cmake](www.cmake.org) build system (Version >= 2.8.11).
* A 64-bit operating system. Either Mac OS X or Linux are currently supported.
* Git version control system

### Dependices made available with the gz file
* [googletest](https://code.google.com/p/googletest/) is included as git submodule.
* [libdivsufsort](https://github.com/y-256/libdivsufsort) libraries are copied in the directory.

## Compilation

Download the alfred.tar.gz file available
[here](assets/docs/alfred.tar.gz). Extract the contents as follows:

    tar xvzf alfred.tar.gz

Next, create a build directory. For example,

     mkdir build
     cd build

Finally, configure and build the executable 'alfred.x'. Continuing the example,

     cmake ..
     make

If successfully built, alfred.x should be available in the build directory.

# Usage

## Preparing Input

Place the input sequences into a single fasta files. Make sure that the
header of the fasta file has the appropriate sequence name. For example,
PHYLIP doesn't accept sequence names longer than 10 characters. Also,
make sure that the input file has one of 'fasta' or 'fa' or 'fas' file
extension. Note that the program accepts only sequences with valid DNA
or protien alphabets. An example is as shown below.

    >SeqName
    ACGTTAGAGTAAATGGAGTAGAAT

## Compute greedy  alignment free estimator
Run the program by providing the pepared input file with -f option,
the output file with the -o option, and the number of mismatches to allow
with -x option. An example is shown below:

    build/alfred.x -f primates.full.fas -o alfred.primates.x8.out -x 8

Output is generated in a matrix format, which can be fed directly to PHYLIP


# Datasets

Datasets used in our experiments are available from
[here](assets/docs/datasets.tar.gz). The contents of the files are as
follows:

_aliases.xlsx_ contains the alises we used for the organism names so as to
construct the tree.

_data_ sub-directory contains all the input data files and the reference
trees. The input files are in fasta format and has .fa extension and the
refrence trees are in phylip format and has .tree extension. For
roseobacter dataset, multiple sequence alignment is also given. MSA for
BaliBASE datasets can be downloaded from the BaliBASE website.

_runs_ sub-directory contains all the output matrix files and the trees
with the best RF.dist score. Ouput matrix files use the format as
accepted by PHYLIP.

# Citation

Thankachan, Sharma V, Chockalingam, Sriram P, Liu, Yongchao, Krishnan,
Ambujam, and Aluru, Srinivas. _A greedy alignment-free distance
estimator for phylogenetic inference_ (Submitted.)
