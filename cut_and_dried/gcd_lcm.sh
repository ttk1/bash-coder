# 最大公約数
function GCD() {
  local -i m=$1 n=$2
  if ((m<n)); then
    ((tmp=n,n=m,m=tmp))
  fi
  while ((n)); do
    ((tmp=n,n=m%n,m=tmp))
  done
  echo $m
}

# 最小公倍数
function LCM() {
  local -i m=$1 n=$2
  echo $(((m*n)/$(GCD $m $n)))
}

# 再帰バージョン
function GCD() {
  local -r r='n?tmp=n,n=m%n,m=tmp,r:m'
  echo $((m=$1>$2?$1:$2,n=$1^$2^m,r))
}

function LCM() {
  echo $((($1*$2)/$(GCD $1 $2)))
}