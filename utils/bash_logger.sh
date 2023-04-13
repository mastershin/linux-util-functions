#!/usr/bin/env bash
# Provices a simple color Logging for bash scripts
# and prints the caller script names and line numbers
# which is useful for debugging purpose.
#
# @maintainer: jae@voxelcloud.io
# @version: 1.2.1

# TIME_FORMAT='%F %T %Z'
# TIME_FORMAT='%Y-%m-%d %T'
timestamp() { date +"${TIME_FORMAT:-%T}"; }
LOG() {
  printf "$2${BASH_SOURCE[2]}"
  for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
    case ${FUNCNAME[i]} in
      LOG | DEBUG | INFO | WARN | ERROR) ;;
      main) printf ':%s ' "${BASH_LINENO[i - 1]}" ;;
      *) printf ' <%s:%s>' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}" ;;
    esac
  done
  printf "[$1] $(timestamp) $3\033[0m\n"
}

DEBUG() { LOG "$FUNCNAME" '\033[90m' "$@"; }
INFO() { LOG "$FUNCNAME" '\033[37m' "$@"; }
WARN() { LOG "$FUNCNAME" '\033[33m' "$@"; }
ERROR() { LOG "$FUNCNAME" '\033[31m' "$@"; }

# Redudant, but, for not want to use source this script,
# use this to copy paste code to other scripts.  They do same thing.
log_info() {
  printf "\033[37m${BASH_SOURCE[1]}"
  for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
    case ${FUNCNAME[i]} in
      log_info) ;;
      main) printf ':%s ' "${BASH_LINENO[i - 1]}" ;;
      *) printf ' <%s:%s>' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}" ;;
    esac
  done
  printf "[INFO] %s $1\033[0m\n" $(date +"${TIME_FORMAT:-%T}")
}
log_warn() {
  printf "\033[33m${BASH_SOURCE[1]}"
  for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
    case ${FUNCNAME[i]} in
      log_warn) ;;
      main) printf ':%s ' "${BASH_LINENO[i - 1]}" ;;
      *) printf ' <%s:%s>' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}" ;;
    esac
  done
  printf "[WARN] %s $1\033[0m\n" $(date +"${TIME_FORMAT:-%T}")
}
log_debug() {
  printf "\033[90m${BASH_SOURCE[1]}"
  for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
    case ${FUNCNAME[i]} in
      log_debug) ;;
      main) printf ':%s ' "${BASH_LINENO[i - 1]}" ;;
      *) printf ' <%s:%s>' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}" ;;
    esac
  done
  printf "[DEBUG] %s $1\033[0m\n" $(date +"${TIME_FORMAT:-%T}")
}
log_error() {
  printf "\033[31m${BASH_SOURCE[1]}"
  for ((i = ${#BASH_LINENO[@]} - 1; i >= 1; i--)); do
    case ${FUNCNAME[i]} in
      log_debug) ;;
      main) printf ':%s ' "${BASH_LINENO[i - 1]}" ;;
      *) printf ' <%s:%s>' "${FUNCNAME[i]}" "${BASH_LINENO[i - 1]}" ;;
    esac
  done
  printf "[ERROR] %s $1\033[0m\n" $(date +"${TIME_FORMAT:-%T}")
}
