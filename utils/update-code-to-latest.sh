#!/usr/bin/env bash
: <<'---'
When the code contains @version: xxx.yyy.zzz, this script can be used to
update all other scripts to the latest version, recursively.
@author: Jae Shin (mastershin at gmail.com)
@version: 0.0.1
---
usage() {
  echo "$0 [file] [latest] [update|dryrun]"
  echo "  file: the file name to search for"
  echo "  latest: 'latest' to find the latest version"
  echo "  update: update the file"
}
if [ $# == 1 ]; then
  find . -name $1 -exec grep -EH --color=always '^@version: (.*)' {} \;

  echo "****************** version summary"
  version_list=$(find . -name $1 -exec grep -E --color=always '^@version: (.*)' {} \; | sort -Vru)
  echo "$version_list"

  latest_version=$(echo "$version_list" | head -n 1)
  echo "latest version=$latest_version"

elif [ $# -ge 2 ]; then
  file=$1
  latest_version=$2
  action=$3

  if [ "$latest_version" == 'latest' ]; then
    version_list=$(find . -name $1 -exec grep -E '^@version: (.*)' {} \; | sort -Vru)
    latest_version=$(echo "$version_list" | head -n 1)
    echo "Using latest version=$latest_version"
  else
    echo 'Please use "latest" only for now'
    exit 1
  fi

  result_count=$(find . -name $file -exec grep -EH '^@version: (.*)' {} \; | grep "$latest_version" | wc -l)
  if [ "$result_count" -eq 1 ]; then
    latest_file=$(find . -name $file -exec grep -EH '@version: (.*)' {} \; | grep "$latest_version" | awk -F: '{print $1}')
    echo "Found matching one: $latest_file"

    if [ $action == 'update' ]; then
      find . -name $file -print -exec cp $latest_file {} \;
    else
      find . -name $file -exec echo "copying $latest_file --> {}" \;
    fi
  else
    echo "Exactly one file expected, not processing. count=$result_count"
  fi
else
  usage
fi
