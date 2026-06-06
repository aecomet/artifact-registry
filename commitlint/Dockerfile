FROM node:26.3.0-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    npm install -g pnpm @commitlint/cli @commitlint/config-conventional && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /app

ENTRYPOINT ["/bin/sh"]
CMD ["-c", "sh"]
