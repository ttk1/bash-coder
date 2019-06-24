# 最大公約数
function GCD() {
  m=$1 n=$2
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
  m=$1 n=$2
  echo $(((m*n)/$(GCD $m $n)))
}

# 難読化バージョン
function GCD() {
  loop='n?(tmp=n,n=m%n,m=tmp,loop):m'
  echo $((($1>$2)?(m=$1,n=$2):(m=$2,n=$1),loop))
}

function LCM() {
  echo $((($1*$2)/$(GCD $1 $2)))
}