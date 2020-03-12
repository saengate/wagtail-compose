# etapa de compilación
FROM node:13.10.1-alpine3.10 as build-stage
WORKDIR /app
COPY ./djfullapp-vue/package*.json ./
RUN npm install
COPY ./djfullapp-vue .
RUN npm run test

# etapa de producción
FROM nginx:1.13.12-alpine as production-stage
COPY --from=build-stage /app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
