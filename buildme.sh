#! /bin/bash

# Documentation function
function usage(){
    cat <<EOF
    Usage: A script to build the docker image and push to public docker.io repository
    
    -r: The version of R to user when building the docker image
    -v: The version of the package to pin to the docker image
    -h: Print this help documentation
    
EOF
}

# Read in arguments
while getopts hrv flag
do
    case "${flag}" in
        h) usage; exit 0;;
        r) rversion=${OPTARG};;
        v) version=${OPTARG};;
        *) usage; exit 1;;
    esac
done

# Load the parse_yaml function
. parse_yaml.sh

# Set default R-version
if [[ -z "$rversion" ]]; then
  rversion=4.1.0
fi

# Set default docker image version pin
if [[ -z "$version" ]]; then
  # read yaml file
  eval $(parse_yaml DESCRIPTION "config_")
  version="${config_Version/$'\r'/}"
  echo $version
fi

# This abuses the fact that I'm already logged in.
docker login
# Build docker image & push to repo
# NOTE: This obviously won't work for anyone else.
docker buildx build --build-arg rversion=$rversion . -t "aavannoy/r-webapp:$version" --push

exit 0