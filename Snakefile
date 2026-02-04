from dotenv import dotenv_values

myconfig = dotenv_values("scripts/config.env")

datadir = myconfig["datadir"]
resultsdir = myconfig["resultsdir"]
docsdir = myconfig["docsdir"]

onstart:
    print("running analysis pipeline")
    print(myconfig)

rule all:
    input:
        f"{resultsdir}/md5sums.txt"

include: "rules/download-data.smk"

rule clean:
    "Clean up output directories"
    shell:
        """
        rm -r {resultsdir}/*
        """