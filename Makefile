.PHONY : all

all :
# 	installation des dépendances ansible
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt
	.venv/bin/ansible-galaxy collection install community.general
	.venv/bin/ansible-galaxy collection install community.docker
#	commande pour lancer script ansible
	.venv/bin/ansible-playbook -i inventory.ini playbook.yml