FROM rocker/r-base:4.1.0 as base
LABEL image=r-base-with-packages
# Install package dependencies
RUN apt update \
  && apt install -y libcurl4-openssl-dev \
  && apt install -y libssl-dev \
  && apt install -y libxml2-dev \
  && Rscript -e "install.packages(c('devtools', 'covr', 'DT', 'usethis', 'httr', 'rxoygen2', 'rversions', 'RestRserve', 'openssl', 'curl', 'httr', 'xml2', 'credentials', 'gert', 'gh'))" \
  && ln -s /bin/tar /bin/gtar
ENV R_ZIPCMD /usr/bin/zip
