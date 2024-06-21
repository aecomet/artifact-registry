FROM node:22.2.0-slim as builder

WORKDIR /app
COPY . /app
RUN apt update &&\
  # install curl and make `.git` to use reviewdog
  apt install -y curl &&\
  mkdir -p .git &&\
  # install pnpm
  yarn global add pnpm@9.2.0
