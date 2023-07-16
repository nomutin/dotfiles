name: shfmt

on:
  push:
    branches:
      - master
  pull_request:

jobs:
  shfmt:
    name: Run shfmt
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Setup shfmt
        uses: mfinelli/setup-shfmt@v2

      - name: Run shfmt
        run: |
          shfmt -i 2 -ci -d $(shfmt -f . | grep -v '\.zsh$')
