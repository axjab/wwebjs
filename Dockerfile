FROM node:24-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

RUN chmod +x /app/docker/entrypoint.sh \
    /app/docker/scripts/*.sh

VOLUME ["/data"]
VOLUME ["/plugins"]

ENTRYPOINT ["/app/docker/entrypoint.sh"]
