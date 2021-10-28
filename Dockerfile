ARG build
FROM docker.io/avannoy/r-base-with-packages:${build}-buildx as base
LABEL image=base
# Copy the directory into the base image
WORKDIR /
COPY . ExampleRAPI
WORKDIR /ExampleRAPI

# Install the R package
FROM base as prerelease
RUN mkdir man \
  && Rscript -e 'devtools::document(roclets = c("rd", "collate", "namespace"))' \
  && R CMD build . \
  && R CMD check ExampleRAPI_*.tar.gz --no-tests --no-manual \
  && rm -rf man \
  && R CMD INSTALL ExampleRAPI_*.tar.gz

# Test the R package
FROM prerelease as test
LABEL image=test
RUN mkdir ./scripts/results && (Rscript ./inst/server.R &) && sleep 2 && Rscript scripts/run_tests_docker.R

# Create the release image
FROM prerelease as release
LABEL image=release
WORKDIR /ExampleRAPI/inst
EXPOSE 8080
RUN ln -s /tmp/swagger-ui.html swagger-ui.html \
  && rm -rf ./ExampleRAPI.Rcheck
ENTRYPOINT [ "Rscript", "server.R" ]
