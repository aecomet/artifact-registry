# artifact-registry

Docker images for development

[My build images is here!](https://github.com/aecomet?tab=packages)

## Initialize

```sh
# ghcr.io personal access token
export CR_PAT="[your personal access token]"
# login ghcr.io
echo $CR_PAT | docker login ghcr.io -u aecomet --password-stdin
```

## build image

```sh
# --platform linux/amd64 ... for Github Actions and Linux
# --platform linux/arm ... for Mac
docker buildx build --platform linux/amd64 --no-cache -f [Dockerfile] -t ghcr.io/aecomet/[name:imageTag] .
```

## push image

```sh
docker push ghcr.io/aecomet/[name:imageTag]
```

## inside container (for debug)

```sh
docker run --rm -it [tagName:imageTag] su
# ex: docker run --rm -it ghcr.io/aecomet/[name:imageTag] su
```
