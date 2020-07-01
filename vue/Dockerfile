# etapa de compilación
FROM node:13.10.1-alpine3.10 as base-develop
WORKDIR /app
COPY ./djfullapp-vue ./
WORKDIR /app/djfullapp-vue
RUN npm install
WORKDIR /app
RUN npm run test

# etapa de producción
FROM nginx:1.13.12-alpine as prod
COPY --from=base-develop /app /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
