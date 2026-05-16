FROM nginx:latest

# Installe openssl pour pouvoir générer les clés SSL
RUN apt-get update && apt-get install -y openssl

# Crée le dossier et génère le certificat SSL auto-signé
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=inception.local"

# Copie le fichier de configuration nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]
