help:
	@echo "clean - remove all build, test, coverage and Python artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "clean-test - remove test and coverage artifacts"
	@echo "lint - check style"
	@echo "test - run tests quickly with the default Python"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "build - package"

all: default

default: deps run

.venv:
	if [ ! -e ".venv/bin/activate_this.py" ] ; then python -m venv .venv ; fi

deps: .venv
	. .venv/bin/activate && pip install -U -r requirements.txt

run:
	. .venv/bin/activate && python agent.py