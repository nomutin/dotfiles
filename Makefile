.PHONY: deploy
deploy:
	zsh scripts/deploy.sh

.PHONY: init
init:
	zsh scripts/init.sh

.PHONY: shellcheck
shellcheck:
	zsh scripts/shellcheck.sh

.PHONY: actionlint
actionlint:
	zsh scripts/actionlint.sh

.PHONY: shfmt
shfmt:
	zsh scripts/shfmt.sh
