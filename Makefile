deploy-macos:
	bash scripts/deploy-macos.sh

deploy-linux:
	bash scripts/deploy-linux.sh

init-macos:
	bash scripts/init-macos.sh

.PHONY: deploy-macos deploy-linux init-macos
