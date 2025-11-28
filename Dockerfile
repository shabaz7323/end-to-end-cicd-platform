FROM node:18-alpine
WORKDIR /usr/src/app
COPY app/package.json ./
RUN npm install --production
COPY app/ ./
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "index.js"]
