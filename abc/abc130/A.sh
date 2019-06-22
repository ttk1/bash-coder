#!/usr/bin/env bash
# https://atcoder.jp/contests/abc130/tasks/abc130_a

function main() {
  if [[ $1 -lt $2 ]]; then
    echo '0'
  else
    echo '10'
  fi
}
main $(cat -)

: "
cat << EOS | ./A.sh
6 6
EOS
"