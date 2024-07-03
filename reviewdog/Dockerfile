FROM node:22.4.0-slim
LABEL org.opencontainers.image.description="An image to check some codes on Pull Request"
LABEL org.opencontainers.image.authors="comet <16721102+aecomet@users.noreply.github.com>"
LABEL org.opencontainers.image.url="https://github.com/aecomet?tab=packages"
LABEL org.opencontainers.image.source="https://github.com/aecomet/artifact-registry"
LABEL org.opencontainers.image.version="22.4.0"

WORKDIR /app
COPY . /app
RUN apt update &&\
  # install curl, git and make `.git` to use reviewdog
  apt install -y curl git &&\
  mkdir -p .git &&\
  # install pnpm
  npm i -g pnpm@9.4.0

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
