# Make is verbose. Make it silent.
MAKEFLAGS += --silent

FILE ?= .test.py
PYTHON_CMD ?= $(shell command -v python3 || command -v python)
PIP_CMD ?= $(shell command -v pip3 || command -v pip)

.PHONY: check-pipenv install-pipenv  install
check-pipenv:
	@which pipenv > /dev/null || { \
		echo "pipenv is not installed. Installing pipenv..."; \
		$(PIP_CMD) install pipenv || { echo "Failed to install pipenv. Please install it manually."; exit 1; }; \
	}

install: check-pipenv
	pipenv run $(PIP_CMD) install -r sku_requirements.txt

run-main: check-pipenv
	pipenv run $(PYTHON_CMD) main.py

run-script: check-pipenv
	pipenv run $(PYTHON_CMD) $(FILE)
