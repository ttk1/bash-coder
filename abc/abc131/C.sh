#!/usr/bin/env bash
# https://atcoder.jp/contests/abc131/tasks/abc131_c

function GCD() {
  m=$1 n=$2
  if [[ $((m>=n)) = 0 ]]; then
    ((tmp=n,n=m,m=tmp))
  fi
  while [[ $((n==0)) = 0 ]]; do
    ((tmp=n,n=m%n,m=tmp))
  done
  echo $m
}

function LCM() {
  m=$1 n=$2
  echo $(((m*n)/$(GCD $m $n)))
}

read A B C D
echo $((
  A--,
  lcm=$(LCM $C $D),
  (B-A)-((B/C-A/C)+(B/D-A/D)-(B/lcm-A/lcm))
))

: "
cat << EOS | ./C.sh
4 9 2 3
EOS
cat << EOS | ./C.sh
10 40 6 8
EOS
cat << EOS | ./C.sh
314159265358979323 846264338327950288 419716939 937510582
EOS
"