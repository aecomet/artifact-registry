#!/bin/bash

usage() {
  echo "Usage: $0 [tag]"
  exit 1
}

if [ $# -eq 0 ]; then
  echo "Error: No args specified."
  usage
fi

tag=$1
names=("commitlint" "pnpm" "reviewdog")

# build image
for name in ${names[@]}; do
  docker buildx build --platform linux/amd64 --no-cache -f "./$name/Dockerfile" -t "ghcr.io/aecomet/$name-base:$tag" ./$name
done

# publish images
for name in ${names[@]}; do
  docker push "ghcr.io/aecomet/$name-base:$tag"
done
