function sum() {
  arr=($@)
  loop="(i<${#arr[@]})?(sum+=arr[i],i++,loop):sum"
  echo $((sum=0,i=0,loop))
}

sum 1 2 3 4 # 10