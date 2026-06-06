FROM node:24.14.0-slim

WORKDIR /app
COPY . /app
RUN apt update &&\
  # install curl, git and make `.git` to use reviewdog
  apt install -y curl git &&\
  mkdir -p .git &&\
  # install pnpm
  npm i -g pnpm

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
