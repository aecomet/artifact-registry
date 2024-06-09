FROM node:22.2.0-slim as builder

WORKDIR /app
COPY . /app
RUN yarn global add pnpm &&\
  pnpm install --frozen-lockfile
