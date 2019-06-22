#!/usr/bin/env bash
# https://atcoder.jp/contests/abc130/tasks/abc130_d

# python3コマンドがなければ作る
if [[ ! $(type python3 2>/dev/null) ]]; then
  python3() {
    python "$@"
  }
fi

python3 -c "
N, K = map(int, input().split())
A = tuple(map(int, input().split()))
sum, count, i, j = A[0], 0, 0, 0
while i < N and (sum >= K or j < N-1):
  if sum >= K:
    sum -= A[i]
    count += N - j
    i += 1
  else:
    j += 1
    sum += A[j]
print(count)
"
exit 0

# TLE
read N K
A=($(cat -))
for ((sum=A[0],count=0,i=0,j=0;i<N&&(sum>=K||j<N-1);)); do
  if [[ $((sum>=K)) = 1 ]]; then
    ((count+=N-j,sum-=A[i],i++))
  else
    ((j++,sum+=A[j]))
  fi
done
echo $count

: "
cat << EOS | ./D.sh
10 53462
103 35322 232 342 21099 90000 18843 9010 35221 19352
EOS
"