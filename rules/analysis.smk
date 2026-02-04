rule initial_analysis:
    "Initial analysis of combined clinical and predicted protein data"
    input:
        f"{resultsdir}/combined-clin-pred-proteins.txt",
        f"scripts/initial-analysis.ipynb"
    output:
        f"{docsdir}/initial-analysis.html"
    container:
        "rhds-tcga-r.sif"
    log:
        f"{resultsdir}/logs/initial_analysis.log"
    shell:
        """
        jupyter nbconvert --execute --to html --output-dir {docsdir} scripts/initial-analysis.ipynb
        """
        
rule analysis:
    "Analysis of combined clinical and predicted protein data"
    input:
        f"{resultsdir}/combined-clin-pred-proteins.txt"
    output:
        f"{docsdir}/analysis.html"
    container:
        "rhds-tcga-r.sif"
    log:
        f"{resultsdir}/logs/analysis.log"
    shell:
        """
        quarto render scripts/analysis.qmd --output-dir {docsdir}
        """
