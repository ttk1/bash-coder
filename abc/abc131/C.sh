#!/usr/bin/env bash
# https://atcoder.jp/contests/abc131/tasks/abc131_c

#### ここから ####

function GCD() {
  loop='n?(tmp=n,n=m%n,m=tmp,loop):m'
  echo $((($1>$2)?(m=$1,n=$2):(m=$2,n=$1),loop))
}

function LCM() {
  echo $((($1*$2)/$(GCD $1 $2)))
}

read A B C D
echo $((
  A--,
  lcm=$(LCM $C $D),
  (B-A)-((B/C-A/C)+(B/D-A/D)-(B/lcm-A/lcm))
))
exit 0

#### ここまで ####

cat << EOS | ./C.sh # 2
4 9 2 3
EOS

cat << EOS | ./C.sh # 23
10 40 6 8
EOS

cat << EOS | ./C.sh # 532105071133627368
314159265358979323 846264338327950288 419716939 937510582
EOS