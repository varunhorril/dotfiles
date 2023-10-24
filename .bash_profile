#!/usr/bin/env bash

# Load .bashrc, which loads: ~/.{aliases,dockerfuncs,exports,extra,functions,paths}
if [[ -r "${HOME}/.bashrc" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"
fi
