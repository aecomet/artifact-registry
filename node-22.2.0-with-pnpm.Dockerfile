FROM node:22.2.0-slim as builder

LABEL package-name node-pnpm
RUN yarn global add pnpm@9.2.0

ENTRYPOINT [ "/bin/sh" ]
