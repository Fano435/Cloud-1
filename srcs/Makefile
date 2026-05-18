COMPOSE = docker compose -f ./srcs/docker-compose.yml

.PHONY : build run stop re clear

all : build

build :
 	$(COMPOSE) build

run :
	$(COMPOSE) up -d
	$(COMPOSE) ps

stop :
	$(COMPOSE) down -v --remove-orphans

clear :
	make stop
	docker system prune -af --volumes

re :
	make stop
	make build
	make run