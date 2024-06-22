#!/bin/bash

usage() {
  echo "Usage: $0 [name] [tag]"
  exit 1
}

if [ $# -eq 0 ]; then
  echo "Error: No args specified."
  usage
fi

name=$1
tag=$2

# build image
docker buildx build --platform linux/amd64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag-amd64" ./$name
docker buildx build --platform linux/arm64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag-arm64" ./$name

# publish image
docker push "ghcr.io/aecomet/$name-base:$tag-amd64"
docker push "ghcr.io/aecomet/$name-base:$tag-arm64"

# create manifest
docker manifest create "ghcr.io/aecomet/$name-base:$tag" "ghcr.io/aecomet/$name-base:$tag-amd64" "ghcr.io/aecomet/$name-base:$tag-arm64"

# push manifest
docker manifest push "ghcr.io/aecomet/$name-base:$tag"
