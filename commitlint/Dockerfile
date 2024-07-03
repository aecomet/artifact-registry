FROM node:22.4.0-slim
LABEL org.opencontainers.image.description "An image to check some commit messages on Pull Request"

WORKDIR /app
RUN  apt update &&\
  # install git and make `.git` to use reviewdog
  apt install -y git &&\
  npm i -g pnpm@9.4.0 @commitlint/cli @commitlint/config-conventional
COPY . /app

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
