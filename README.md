# artifact-registry

Docker images for development

[My build images is here!](https://github.com/aecomet?tab=packages)

## Initialize

```sh
# ghcr.io personal access token
export CR_PAT="[your personal access token]"
# login ghcr.io
echo $CR_PAT | docker login ghcr.io -u [USERNAME] --password-stdin
# echo $CR_PAT | docker login ghcr.io -u aecomet --password-stdin
```

## build image

```sh
sh publish-image.sh [name] [tag]
# ex. sh publish-image.sh commitlint 24.3.0
```

## inside container (for debug)

```sh
docker run --rm -it [tagName:imageTag] su
# ex. docker run --rm -it ghcr.io/aecomet/[name:imageTag] su

# (use docker compose)
docker compose run --rm --build debug
```
