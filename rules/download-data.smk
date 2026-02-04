rule download_data:
    "Download the omic data"
    input:
        "scripts/files.csv"
    output:
        f"{resultsdir}/md5sums.txt",
        f"{datadir}/methylation-clean-score-sites.csv.gz"
    container:
        "rhds-tcga-r.sif"
    log:
        f"{resultsdir}/logs/download-data.log"
    shell:
        """
        cd scripts
        bash download-data.sh {datadir} {resultsdir} > {log}
        """

rule download_pan_cancer_clinical:
    "Download the pan-cancer clinical data"
    output:
        f"{resultsdir}/TCGA-CDR-SupplementalTableS1.txt"
    container:
        "rhds-tcga-r.sif"
    log:
        f"{resultsdir}/logs/download-pan-cancer-clinical.log"
    shell:
        """
        Rscript scripts/download-pan-cancer-clinical.r {datadir} {resultsdir}
        """