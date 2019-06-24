# 再帰版
function sum() {
  local -r arr=($@)
  local -r loop="(i<${#arr[@]})?(sum+=arr[i],i++,loop):sum"
  echo $((sum=0,i=0,loop))
}
sum 1 2 3 4 # 10
# 数が多いと再帰の深さ上限に引っかかる
# sum $(seq 10000)
# bash: i: expression recursion level exceeded (error token is "i")

# ループ版
function sum() {
  local -i count=0
  while (($#>0)); do
    ((count+=$1))
    shift
  done
  echo $count
}

# ループ版だとなんとか動く（これ以上の長さは厳しそう）
sum $(seq 10000) # 50005000