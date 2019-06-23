# BashCoder
BashでAtCoderやる

## Tips

### 標準入力を受け取るときのTips

#### 入力を変数に代入する
readコマンドを使う

```bash
cat << EOS > >(
  read A B
  echo $A $B
)
hoge piyo
EOS
```

#### 入力を配列(Array)として受け取る

```bash
cat << EOS > >(
  a=($(cat)) # 配列の初期化
  echo ${#a[@]} # 配列の長さ
  echo ${a[@]} # 配列の全体
  echo ${a[0]} # i番目の要素
  echo ${a[1]}
  echo ${a[2]}
)
hoge piyo fuga
EOS
```

算術式と組み合わせる

```bash
cat << EOS > >(
  a=($(cat))
  echo $((a[0]+a[1]+a[2]))
  # forで合計を出す
  for ((i=0,sum=0;i<${#a[@]};i++)); do
    ((sum+=a[i]))
  done
  echo $sum
  # eval+let+ブレース展開で合計を出す(一行で書けるけど、動作が理解し辛い)
  IFS=,;eval let sum=0 sum+={"${a[*]}"}
  echo $sum
)
1 2 3
EOS
```
