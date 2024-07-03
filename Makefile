deploy:
	bash scripts/deploy.sh

init_macos:
	bash scripts/init_macos.sh

.PHONY: init_macos deploy
