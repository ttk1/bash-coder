# BashCoder
BashでAtCoderやる

## Tips

### 標準入力を受け取る

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

### 条件分岐
`[[ ]]` を使用する。

#### 文字列比較

```bash
# 文字列の一致
if [[ "hoge" = "hoge" ]]; then
  echo '一致'
fi

# 文字列の不一致
if [[ "hoge" != "piyo" ]]; then
  echo '不一致'
fi

# 正規表現マッチ
# 正規表現はクオートしない
if [[ "hoge" =~ ^h.{3}$ ]]; then
  echo ${BASH_REMATCH[0]} # マッチ箇所はこれで取り出す
  echo '一致'
fi

# 辞書順
# '<' および '>' は文字列の辞書順比較
if [[ "hoge" < "piyo" ]]; then
  echo 'yeah!'
fi

# よくある間違い（桁数が一致してないと数値の比較はできない）
if [[ 1000 < 11 ]]; then
  echo 'yeah!'
fi
```

#### 数値比較

|`(( ))`|`[[ ]]`|
|:-:|:-:|
|`a > b`|`$a -gt $b`|
|`a >= b`|`$a -ge $b`|
|`a < b`|`$a -lt $b`|
|`a <= b`|`$a -le $b`|
|`a == b`|`$a -eq $b`|
|`a != b`|`$a -ne $b`|

```bash
a=10 b=20

# [[ ]]
if [[ $a -lt $b ]]; then
  echo 'yeah!'
fi

# (( ))
# trueなら1が返る。
#こっちのほうがぱっと見頭に入ってくる（気がする）し、複合条件を算術式内に書ける。
if [[ $((a<b)) = 1 ]]; then
  echo 'yeah!'
fi
```

#### AND/OR/NOT

|意味|書き方|
|:-:|:-:|
|AND| `<condition> && <condition>` |
|OR| `<condition> \|\| <condition>` |
|NOT| `! <condition>` |
|グループ化| `(<condition>)` |

```bash
# 例
a=10 b=20 c=30
if [[ (! $a -gt $b) && ($b -lt $c || $c -ne 30) ]]; then
  echo 'yeah!'
fi
```

### 算術式内で条件分岐
- こちらを参考にした: https://qiita.com/akinomyoga/items/1e9799d71ce4102c8ab6

いわゆる三項演算子(条件演算子とも)。

`condition?expr1:expr2` のように書き、`condition` が `true` と評価された場合に `expr1` が実行され、 `false` と評価された場合に `expr2` を実行する。

bashの算術式では、`0` が `false` と評価され、それ以外は `true` となる。

```bash
((a=10,b=0))
(((a==10)?(b=10):(b=0)))
echo $b # 10

# もしくは
((a=10,b=0))
((b=(a==10)?10:0))
echo $b # 10
```

ついでに論理演算子についても。

- `expr1||expr2` は、`expr1` が `true` と判定された場合、 `expr2` は実行されない。
- `expr1&&expr2` は、`expr1` が `false` と判定された場合、 `expr2` は実行されない。

```bash
echo $((0||1)) # 1
echo $((1||0)) # 1
echo $((0&&1)) # 0
echo $((1&&0)) # 0

# 否定について
# できるっぽいこと書いてたけど、なんかエラーになる。
$ echo $((!1234))
bash: !10: event not found
```

ちなみにだが、算術式の戻り値は、一番最後の式の評価結果が `false` の時、ステータスコードが1となる。
bashの `e` オプションを指定し他場合に予期せずプログラムが終了してしまう場合がある。

```bash
((a=0))
echo $? # 1
```

### ループ

#### while

```bash
# 通常のwhileループ
count=0
while [[ $count -lt 10 ]]; do
  echo count=$count
  ((count++))
done

# 無限ループ
# while :; do でもよい
count=0
while true; do
  echo count=$count
  ((count++))
  if [[ $count -eq 10 ]]; then
    break
  fi
done
```

#### for

```bash
# 通常のforループ
for ((i=0;i<10;i++)); do
  echo i=$i
done

# for-inパターン
for i in 0 1 2 3; do
  echo i=$i
done

# for-in+ブレース展開
for i in {0..9}; do
  echo i=$i
done

# for-in+ブレース展開+インクリメント量2
# 3つ目の数字でインクリメント量を指定する
for i in {0..10..2}; do
  echo i=$i
done

# for-in+配列
a=({0..9})
for i in ${a[@]}; do
  echo i=$i
done

# for-in+seqコマンド
for i in $(seq 0 9); do
  echo i=$i
done

# for-in+seqコマンド+インクリメント量2
# 2つ目の数字でインクリメント量を指定する
for i in $(seq 0 2 10); do
  echo i=$i
done
```

- ブレース展開についてはここを参考にした: http://takuya-1st.hatenablog.jp/entry/2016/12/21/181839

#### 算術式を使ったループ
- ここを参考にした: https://qiita.com/akinomyoga/items/2dd3f341cf15dd9c330b

```bash
loop='(i!=10)&&(sum+=i,i++,loop)'
((
  sum=0,
  i=0,
  loop
))
echo $sum # 45
```

##### let+ブレース展開を使った小技
- ここを参考にした: http://takuya-1st.hatenablog.jp/entry/2016/12/21/181839

`入力を配列(Array)として受け取る` の節にもあるが、単純なループならletとブレース展開で比較的簡単に書ける。

```bash
let sum=0 sum+={0..9}
echo $sum # 45

# ループの範囲を変数化する場合
# そのままだと展開されないので、evalをかませる
first=0 last=9
eval let sum=0 sum+={$first..$last}
echo $sum # 45

# seqを使う場合
# ブレース展開させるため、セパレータに ',' を指定する
first=0 last=9
eval let sum=0 sum+={$(seq -s, $first $last)}
echo $sum # 45

# 配列の要素をなめる場合
# eval+let+ブレース展開で合計を出す
# ブレース展開させるため、IFSに ',' を指定する
## これで "${a[*]}" したときに ',' 区切りになってブレース展開されるようになる
IFS_BACKUP=$IFS # 同一プロセスで動かすときは、IFSをもとに戻す必要あり
a=($(seq 0 9))
IFS=,;eval let sum=0 sum+={"${a[*]}"}
IFS=$IFS_BACKUP
echo $sum # 45
```

### 算術式関係
そのうちまとめる