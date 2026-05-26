FROM nginx:alpine

# Installe openssl pour pouvoir générer les clés SSL
RUN apk add --no-cache openssl

# Copie le fichier de configuration nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]
