#!/bin/bash
venv_info=""
[ -n "$CONDA_DEFAULT_ENV" ] && venv_info="($CONDA_DEFAULT_ENV) "
[ -n "$VIRTUAL_ENV" ] && venv_info="($(basename $VIRTUAL_ENV)) "

git_info=$(git -C "$(pwd)" rev-parse --abbrev-ref HEAD 2>/dev/null)
[ -n "$git_info" ] && git_info=" [$git_info] "

printf '\e[38;5;150m%s\e[0m \e[38;5;67m%s\e[38;5;109m@\e[38;5;108m%s \e[38;5;150m%s\e[0m' "$venv_info$git_info" "$(whoami)" "$(hostname -s)" "$(basename "$(pwd)")"
