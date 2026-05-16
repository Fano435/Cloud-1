COMPOSE = docker compose -f ./srcs/docker-compose.yml

.PHONY : build run stop re clear

all : build
#	python3 -m venv .venv
#	source .venv/bin/activate
#	pip install -r requirements.txt
#	commande pour lancer script ansible
#	ansible-playbook -i inventory.ini playbook.yml
#	à terme, on enlève tout le reste (docker compose est lancé via le playbook ansible)

build :
	mkdir -p ../data/wordpress
	mkdir -p ../data/mariadb
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
