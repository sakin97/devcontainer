FROM node:20-slim AS base

COPY . .

RUN --mount=type=cache,target=/root/.npm \
  npm ci && \
  npm run build

USER node
CMD [ "node", "./dist/main.js" ]

