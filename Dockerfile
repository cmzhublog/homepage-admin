FROM docker.io/dockette/nodejs:v12 as base

## install the packages
RUN apk add vim git python3 

## clone the registry and install it 
RUN git clone https://github.com/Tomotoes/HomePage.git 
COPY config.json /HomePage/config.json
RUN  cd HomePage \
    && npm install \
    && npm run build 


## 部署阶段
FROM nginx:alpine3.18-perl as nginx
COPY --from=base /HomePage/dist  /usr/share/nginx/html
