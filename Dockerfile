FROM rocker/verse:4.0.3 # use rocker tidyverse 4.X

RUN apt-get update

# Install Bioconductor Packages
RUN R -e 'install.packages("BiocManager")'
RUN R -e 'BiocManager::install("GSVA")'
RUN R -e 'BiocManager::install("preprocessCore")'

COPY R/ /R/
RUN chmod +x /R/*.R

CMD ["Rscript /R/run_selinescore.R"]
