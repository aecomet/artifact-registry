# artifact-registry

Docker images for development

## Initialize

```sh
# ghcr.io personal access token
export CR_PAT="[your personal access token]"
# login ghcr.io
echo $CR_PAT | docker login ghcr.io -u aecomet --password-stdin
```

## build image

```sh
docker build --no-cache -f [Dockerfile] -t ghcr.io/aecomet/[name:imageTag] .
```

## push image

```sh
docker push ghcr.io/aecomet/[name:imageTag]
```
