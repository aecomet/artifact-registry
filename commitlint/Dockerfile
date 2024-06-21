FROM node:22.2.0-slim as builder

WORKDIR /app
COPY . /app
RUN  apt update &&\
  # install git and make `.git` to use reviewdog
  apt install -y git &&\
  yarn global add pnpm@9.2.0 &&\
  pnpm install --frozen-lockfile

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "sh" ]
