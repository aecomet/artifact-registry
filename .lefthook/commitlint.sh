#!/bin/sh
npx --yes -p @commitlint/cli -p @commitlint/config-conventional commitlint --config commitlint/commitlint.config.mjs -e "$1"
