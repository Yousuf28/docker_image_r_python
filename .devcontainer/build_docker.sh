#!/bin/bash

echo "Build the docker"

docker build . -f Dockerfile \
               --progress=plain \
               --build-arg PROJECT_NAME="R Dev Env" \
               --build-arg VENV_NAME="R_ENV" \
               --build-arg R_VERSION_MAJOR=4 \
               --build-arg R_VERSION_MINOR=4 \
               --build-arg R_VERSION_PATCH=0 \
                --build-arg DEBIAN_FRONTEND=noninteractive \
                 --build-arg CRAN_MIRROR="https://cran.rstudio.com/" \
               -t yousuf28/pfda:test

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
# docker push yousuf28/pfda:test
else
echo "Docker build failed"
fi
