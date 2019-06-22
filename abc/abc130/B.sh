#!/usr/bin/env bash
# https://atcoder.jp/contests/abc130/tasks/abc130_b

read N X
((pos = 0, count = 0))
for L in $(cat -); do
  ((pos+=L,count++))
  if [[ $((pos>X)) = 1 ]]; then
    echo $count
    exit
  fi
done
echo $((count+1))

: "
cat << EOS | ./B.sh
4 9
3 3 3 3
EOS
"