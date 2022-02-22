FROM bioconductor/bioconductor_docker:RELEASE_3_13

RUN Rscript -e 'install.packages("devtools")'

# see https://github.com/greenelab/RNAseq_titration_results/pull/34
RUN Rscript -e "options(warn = 2); BiocManager::install( \
    'preprocessCore', \
    configure.args = '--disable-threading', \
    update = FALSE)"
# install FSQN
RUN Rscript -e 'devtools::install_github("jenniferfranks/FSQN", update = FALSE)'
RUN R -e 'BiocManager::install("GSVA", update = FALSE)'

COPY R/ /R/
RUN chmod +x /R/*.R

CMD ["/bin/bash"]
