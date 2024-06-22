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
docker buildx build --push --platform linux/amd64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag-amd64" ./$name
docker buildx build --push --platform linux/arm64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag-arm64" ./$name

echo "Create manifest..."
# create manifest
docker manifest create "ghcr.io/aecomet/$name-base:$tag" "ghcr.io/aecomet/$name-base:$tag-amd64" "ghcr.io/aecomet/$name-base:$tag-arm64"

echo "Push manifest..."
# push manifest
docker manifest push -p "ghcr.io/aecomet/$name-base:$tag"
