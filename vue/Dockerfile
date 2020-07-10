# etapa de compilación
FROM node:13.10.1-alpine3.10 as base-test
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY ./djfullapp-vue/package*.json ./
RUN npm install
RUN npm audit fix

COPY ./djfullapp-vue /app/

WORKDIR /app/djfullapp-vue
RUN npm run test:unit


FROM node:13.10.1-alpine3.10 as base-develop
COPY --from=base-test /app /app
ENV PATH /app/node_modules/.bin:$PATH

WORKDIR /app/djfullapp-vue
EXPOSE 80

COPY ./scripts/entrypoint.sh /tmp/
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
