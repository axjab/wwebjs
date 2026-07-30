FROM node:24-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
        # Chrome/Chromium runtime dependencies
        libglib2.0-0 \
        libnss3 \
        libnspr4 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libdrm2 \
        libxkbcommon0 \
        libxcomposite1 \
        libxdamage1 \
        libxfixes3 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
        libpango-1.0-0 \
        libcairo2 \
        libatspi2.0-0 \
        libx11-6 \
        libxcb1 \
        libxext6 \
        fonts-liberation \
        libappindicator3-1 \
        xdg-utils \
        wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

RUN chmod +x /app/docker/entrypoint.sh \
    /app/docker/scripts/*.sh && \
    mkdir -p /logs

VOLUME ["/logs"]
VOLUME ["/data"]
VOLUME ["/plugins"]

ENTRYPOINT ["/app/docker/entrypoint.sh"]
