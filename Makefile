.PHONY: deploy
deploy:
	zsh scripts/deploy.sh

.PHONY: init
init:
	zsh scripts/init.sh

.PHONY: shellcheck
shellcheck:
	bash scripts/shellcheck.sh

.PHONY: actionlint
actionlint:
	bash scripts/actionlint.sh

.PHONY: shfmt
shfmt:
	bash scripts/shfmt.sh
