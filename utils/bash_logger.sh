#!/usr/bin/env bash
# Provices a simple color Logging for bash scripts
# and prints the caller script names and line numbers
# which is useful for debugging purpose.
#
# @author: mastershin@gmail.com

LOG() {
    color=$2
    printf $color
    # print the caller name and line number
    printf "${BASH_SOURCE[2]} "
    for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
        case ${FUNCNAME[i]} in
        LOG | DEBUG | INFO | WARN | ERROR)
            # skip LOG() and other logging functions
            ;;
        *)
            printf '<%s:%s> ' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}"
            ;;
        esac
    done
    # echo "$LINENO"
    printf "[$1] $(date '+%F %T %Z') $3"
    printf '\033[0m\n'
}

DEBUG() { LOG "$FUNCNAME" '\033[90m' "$@"; }
INFO() { LOG "$FUNCNAME" '\033[37m' "$@"; }
WARN() { LOG "$FUNCNAME" '\033[33m' "$@"; }
ERROR() { LOG "$FUNCNAME" '\033[31m' "$@"; }

