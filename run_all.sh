#!/bin/bash

# Get project variables
source config.env

# Create necessary directories if they don't exist
mkdir -p $docsdir
mkdir -p $resultsdir
mkdir -p $datadir

# Run all scripts
cd scripts
bash download-data.sh $datadir $resultsdir
Rscript download-pan-cancer-clinical.r $datadir $resultsdir
Rscript extract-data.r $datadir $resultsdir
Rscript clean-clinical.r $datadir $resultsdir
Rscript predict-proteins.r $datadir $resultsdir
Rscript combine.r $datadir $resultsdir
Rscript analysis.r $datadir $resultsdir
jupyter nbconvert --execute --to html --output-dir $docsdir initial-analysis.ipynb