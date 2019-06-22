# 最大公約数
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

# 最小公倍数
function LCM() {
  m=$1 n=$2
  echo $(((m*n)/$(GCD $m $n)))
}