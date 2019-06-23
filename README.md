# BashCoder
BashでAtCoderやる

## Tips

### 標準入力を受け取るときのTips

#### 入力を変数に代入する
`read` コマンドを使う

```bash
cat << EOS > >(
  read A B
  echo $A $B
)
hoge piyo
EOS
```

#### 入力を配列(Array)として受け取る

##### 基本

```bash
cat << EOS > >(
  # 配列の初期化
  a=($(cat))

  # 配列の長さ
  echo ${#a[@]}

  # 配列の全体
  echo ${a[@]}
  echo ${a[*]}

  # i番目の要素
  echo ${a[0]}
  echo ${a[1]}
  echo ${a[2]}
)
hoge piyo fuga
EOS
```

##### 算術式と組み合わせる

```bash
cat << EOS > >(
  a=($(cat))

  # 算術式では変数名に$はつけない
  echo $((a[0]+a[1]+a[2]))

  # forで合計を出す
  for ((i=0,sum=0;i<${#a[@]};i++)); do
    ((sum+=a[i]))
  done
  echo $sum

  # eval+let+ブレース展開で合計を出す
  # IFS_BACKUP=$IFS # 同一プロセスで動かすときは、IFSをもとに戻す必要あり
  IFS=,;eval let sum=0 sum+={"${a[*]}"}
  # IFS=$IFS_BACKUP
  echo $sum
)
1 2 3
EOS
```

##### 複数行ある場合

`cat` だと一気に最後まで読んでしまうので、一行ずつ処理したい場合は `while read` で処理する

```bash
cat << EOS > >(
  while read line; do
    a=($line)
    echo $((a[0]+a[1]+a[2]))
  done
)
1 2 3
4 5 6
7 8 9
EOS
```
