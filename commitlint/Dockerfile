FROM node:24.3.0-slim

WORKDIR /app
RUN  apt update &&\
  # install git and make `.git` to use reviewdog
  apt install -y git &&\
  npm i -g pnpm@10.12.4 @commitlint/cli @commitlint/config-conventional
COPY . /app

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
