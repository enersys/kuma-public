
FROM louislam/uptime-kuma:builder-go AS build_healthcheck

FROM louislam/uptime-kuma:base-debian AS build
WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
COPY .npmrc .npmrc
COPY package.json package.json
COPY package-lock.json package-lock.json
RUN npm ci --omit=dev
COPY . .
COPY --from=build_healthcheck /app/extra/healthcheck /app/extra/healthcheck
RUN chmod +x /app/extra/entrypoint.sh


EXPOSE 3001
VOLUME ["/app/data"]
HEALTHCHECK --interval=60s --timeout=30s --start-period=180s --retries=5 CMD extra/healthcheck
ENTRYPOINT ["/usr/bin/dumb-init", "--", "extra/entrypoint.sh"]
CMD ["node", "server/server.js"]

