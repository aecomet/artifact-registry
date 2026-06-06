FROM node:26.3.0-slim

WORKDIR /app

COPY . /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl git && \
    mkdir -p .git && \
    npm install -g pnpm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/sh"]
CMD ["-c", "sh"]
