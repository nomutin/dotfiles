.PHONY: deploy
deploy:
	bash scripts/deploy.sh

.PHONY: init
init:
	bash scripts/init.sh

.PHONY: shellcheck
shellcheck:
	bash scripts/shellcheck.sh
