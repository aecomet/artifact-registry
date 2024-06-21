FROM node:22.2.0-slim as builder

WORKDIR /app
COPY . /app
RUN apt update &&\
  # install curl, git and make `.git` to use reviewdog
  apt install -y curl git &&\
  mkdir -p .git &&\
  # install pnpm
  yarn global add pnpm@9.2.0

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
