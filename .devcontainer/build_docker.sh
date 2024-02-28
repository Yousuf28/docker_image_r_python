#!/bin/bash

echo "Build the docker"

docker build . -f Dockerfile --no-cache \
               --progress=plain \
               --build-arg PROJECT_NAME="R Dev Env" \
               --build-arg VENV_NAME="R_ENV" \
               --build-arg R_VERSION_MAJOR=4 \
               --build-arg R_VERSION_MINOR=3 \
               --build-arg R_VERSION_PATCH=1 \
                --build-arg DEBIAN_FRONTEND=noninteractive \
                 --build-arg CRAN_MIRROR="https://cran.rstudio.com/" \
               -t yousuf28/r_python:test

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
# docker push yousuf28/r_python:vim
else
echo "Docker build failed"
fi
