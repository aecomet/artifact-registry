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

# login to ghcr.io
echo "Start docker login..."
echo $CR_PAT | docker login ghcr.io -u aecomet --password-stdin

echo "Build and push image..."
# build & push image
docker buildx build --push --platform linux/amd64,linux/arm64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag" ./$name

echo "Successfully published multi-platform image: ghcr.io/aecomet/$name-base:$tag"
