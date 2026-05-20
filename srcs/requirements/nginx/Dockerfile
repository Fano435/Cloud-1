FROM nginx:alpine

# Installe openssl pour pouvoir générer les clés SSL
RUN apk add --no-cache openssl

# Crée le dossier et génère le certificat SSL auto-signé
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/cloud.crt \
    -keyout /etc/nginx/ssl/cloud.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cloud.local"

# Copie le fichier de configuration nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]
