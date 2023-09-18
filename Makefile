deploy:
	bash scripts/deploy.sh

init:
	bash scripts/init.sh

shellcheck:
	bash scripts/shellcheck.sh

.PHONY: shellcheck init deploy
