FROM node:22.4.0-slim
LABEL org.opencontainers.image.description="An image to check some commit messages on Pull Request"
LABEL org.opencontainers.image.authors="comet <16721102+aecomet@users.noreply.github.com>"
LABEL org.opencontainers.image.url="https://github.com/aecomet?tab=packages"
LABEL org.opencontainers.image.source="https://github.com/aecomet/artifact-registry"
LABEL org.opencontainers.image.version="22.4.0"

WORKDIR /app
RUN  apt update &&\
  # install git and make `.git` to use reviewdog
  apt install -y git &&\
  npm i -g pnpm@9.4.0 @commitlint/cli @commitlint/config-conventional
COPY . /app

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
