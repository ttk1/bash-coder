#!/usr/bin/env bash
# https://atcoder.jp/contests/abc130/tasks/abc130_c

cat - | awk '{
  W=$1;
  H=$2;
  x=$3;
  y=$4;
  if (x == W/2 && y == H/2) {
    print (W*H)/2, 1
  } else {
    print W*H/2, 0
  }
}'

: "
cat << EOS | ./C.sh
10 53462
2 2 1 1
EOS
"