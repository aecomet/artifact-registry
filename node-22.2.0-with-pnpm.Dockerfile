FROM node:22.2.0-slim as builder

LABEL package-name node-pnpm
RUN apt update &&\
  # install curl to use reviewdog
  apt install -y curl &&\
  # install pnpm
  yarn global add pnpm@9.2.0
