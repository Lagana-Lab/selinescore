FROM rocker/verse:4.0.3

RUN apt-get update

# Install Bioconductor Packages
RUN R -e 'install.packages("BiocManager")'
RUN R -e 'BiocManager::install("GSVA")'
RUN R -e 'BiocManager::install("preprocessCore")'
RUN R -e 'remotes::install_github("jenniferfranks/FSQN")'

COPY R/ /R/
RUN chmod +x /R/*.R

CMD ["/bin/bash"]
