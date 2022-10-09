# 목표: nginx 폴더에 vue빌드 결과물인 dist폴더를 덮어씌운뒤 nginx도커를 재실행되도록 한다.
# build stage
FROM node:12-alpine as builder
WORKDIR /app

COPY package*.json .

RUN npm install

# dockerignore에서 등록한 리스트를 제외한 모든 파일을 WORKDIR에 복사
COPY . .
# vue프로젝트 빌드 -> 결과물로 dist폴더가 생성됨
RUN npm run build

## nginx 도커 실행 프로세스

# nginx 이미지 로딩
FROM nginx:stable-alpine
# 디폴트conf파일 삭제
# RUN rm -rf /etc/nginx/conf.d/default.conf
# 빌드한 conf파일 nginx에 복사
# COPY --from=builder /app/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
# nginx 실행
ENTRYPOINT ["nginx", "-g", "daemon off;"] 

# 도커빌드: docker build -t isb-portal-web .
# 도커실행: docker run --rm -p 8080:80 --name isb-portal-web isb-portal-web
# 이렇게 생성된 nginx이미지를 배포 및실행 시켜주면 된다.