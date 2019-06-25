# 再帰版
function sum() {
  local -r arr=($@)
  local -r r="(i<${#arr[@]})?(sum+=arr[i],i++,r):sum"
  echo $((sum=0,i=0,r))
}
sum 1 2 3 4 # 10
# 数が多いと再帰の深さ上限に引っかかる
# sum $(seq 10000)
# bash: i: expression recursion level exceeded (error token is "i")

# whileループ版
function sum() {
  local -i count=0
  while (($#>0)); do
    ((count+=$1))
    shift
  done
  echo $count
}

# なんとか動く（これ以上の長さは厳しそう）
sum $(seq 10000) # 50005000

# for-inループ版（while read）
function sum() {
  local -i count=0
  for i in "$@"; do
    ((count+=$i))
    shift
  done
  echo $count
}

# なんとか動く（while版よりちょっと速い気がする）
sum $(seq 10000) # 50005000

# awk版
# 圧倒的に速い
seq 10000 | awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
