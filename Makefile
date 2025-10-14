.PHONY: help up down test evidence

help:
	@echo "make up       - run app via uvicorn"
	@echo "make down     - stop compose"
	@echo "make test     - placeholder for tests"
	@echo "make evidence - show evidence tree"

up:
	uvicorn app.main:app --host 0.0.0.0 --port 8080

down:
	docker compose down -v || true

test:
	@echo "TBD"

evidence:
	@find EVIDENCE -type f || true
