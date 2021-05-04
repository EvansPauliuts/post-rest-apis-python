VENV := venv
SRC_DIR_TEST := ./tests
BIN := $(VENV)/bin
PYTHON := $(BIN)/python3
SHELL := /bin/bash
FLAKE8 := "$(BIN)/flake8"
AUTOPEP8 := "$(BIN)/autopep8"

REQUIREMENTS_DEV:="requirements/dev.txt"

.PHONY: venv
venv: ## Make a new virtual environment
	python3 -m venv $(VENV) && source $(BIN)/activate
	@echo '************ SUCCESS ACTIVATE VENV ************'

.PHONY: install
install: venv ## Make venv and install requirements
	$(BIN)/pip install --upgrade -r $(REQUIREMENTS_DEV)
	@echo '************ SUCCESS REQUIREMENTS ************'

freeze: ## Pin current dependencies
	$(BIN)/pip freeze > $(REQUIREMENTS_DEV)
	@echo '************ SUCCESS FREEZE ************'

migrate: ## Make and run migrations
	$(PYTHON) manage.py makemigrations
	$(PYTHON) manage.py migrate
	@echo '************ SUCCESS MIGRATIONS ************'

.PHONY: test
tests: ## Run tests
	$(PYTHON) manage.py test
	@echo '************ SUCCESS TEST ************'

.PHONY: run
run: ## Run the Django server
	$(PYTHON) manage.py runserver
	@echo '************ SUCCESS RUN DJANGO ************'

.PHONY: test
test: ## Run the Django server
	pytest
	@echo '************ SUCCESS RUN TEST ************'

.PHONY: shell
shell: # run shell
	$(PYTHON) manage.py shell
	@echo '************ SUCCESS SHELL ************'

.PHONY: check
check: ## run flake8
	@$(FLAKE8)
	@echo '************ SUCCESS FLAKE8 ************'


# DOCKER

.PHONY: docker_dev
docker_dev: # docker-compose dev run project app
	docker-compose -f docker-compose.yml up --build
	@echo '************ SUCCESS DOCKER BUILD DEV ************'

.PHONY: docker_down
docker_down: # docker-compose dev down project
	docker-compose -f docker-compose.yml down
	@echo '************ SUCCESS DOCKER BUILD ************'

.PHONY: up
up: # docker-compose up
	docker-compose -f docker-compose.yml up
	@echo '************ SUCCESS DOCKER UP ************'

.PHONY: docker_stop
docker_stop: # docker stop
	docker-compose stop
	@echo '************ SUCCESS DOCKER STOP ************'

.PHONY: docker_status
docker_status: # docker status
	docker-compose ps
	@echo '************ SUCCESS DOCKER STATUS ************'