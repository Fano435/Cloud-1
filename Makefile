COMPOSE = docker compose -f ./srcs/docker-compose.yml

.PHONY : build run stop re clear

all : build

build :
	mkdir -p ../data/wordpress
	mkdir -p ../data/mariadb
	$(COMPOSE) build

# 	python3 -m venv .venv
# 	.venv/bin/pip install -r requirements.txt
# 	.venv/bin/ansible-galaxy collection install community.general
# 	.venv/bin/ansible-galaxy collection install community.docker
# #	commande pour lancer script ansible
# 	.venv/bin/ansible-playbook -i inventory.ini playbook.yml
#	à terme, on enlève tout le reste (docker compose est lancé via le playbook ansible)

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
# 	.venv/bin/ansible-playbook -i inventory.ini playbook.yml
