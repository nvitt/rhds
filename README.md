# Reproducible health data science short course

This repository contains the code for the short course practical sessions. 

## Setup instructions

Use Conda / Mamba to create an R environment and then install the R packages from the installation script.

```
mamba env create -f environment.yml
Rscript install.r
```

Next create a `config.env` file based on the `config-template.env` template.

## To run

You can run the entire pipeline using 

```
bash run-all.sh
```

Note, to run within a container, first create an image file (`rhds-tcga-r.sif`) from the definition file (`rhds-tcga-r.def`):

```
apptainer build rhds-tcga-r.sif rhds-tcga-r.def
```

Then use it to run the scripts e.g.

```
source config.env
mkdir -p ${datadir} ${resultsdir} ${docsdir}
apptainer run \
    --fakeroot \
    -B $(pwd) \
    -B ${datadir} -B ${resultsdir} -B ${docsdir} \
    rhds-tcga-r.sif \
    bash run-all.sh
```

## Snakemake pipeline

```
source config.env
mkdir -p ${docsdir} ${resultsdir} ${datadir}
snakemake \
    --cores 1 \
    --use-apptainer \
    --apptainer-args "--fakeroot -B ${datadir} -B ${resultsdir} -B ${docsdir} -B $(pwd)"
```