#import "../lib.typ": mysetting, showCode, itembox

// 個人用設定の読み込み
#show: mysetting
// 設定の上書き
#set par(first-line-indent: 0em)

// tips: コードブロック内の日本語のフォント指定方法
// font: (日本語以外のフォント, 日本語のフォント) で指定
// #show raw: set text(lang: "ja", font: ("Consolas", "MS Mincho"), size: 10.5pt)

// 以下使い方

// このような関数をあらかじめ定義すると便利
#let Code(path, ..args) = { showCode(read(path), path, ..args) }

= showCode
コードを表示する関数
== 基本的な使い方

普通に表示
#Code("./main.py")

関数指定で表示(`caption`属性で説明を付けられる)
#Code("./main.py", func: "add", caption: "add関数")

"差分を指定(初期値は`(-1, 0)`となっており端の空行は表示されない)
#Code("./main.py", func: "mul", diff: (-2, 1))

`showlines`を`true`にすると端の空行も表示される
#Code("./main.py", func: "mul", diff: (-2, 1), showlines: true)

クラス指定で表示
#Code("./main.py", class: "counter")

範囲指定で表示`showrange`の代わりにこちらも使用可
#Code("./main.py", range: (1, 2))

== 特殊な指定

#raw("funcに__main__を指定すると if __name__ == \"__main__\"部分が出力される")
#Code("./main.py", func: "__main__")

== 注意点

以下のようにインデントの合わないコメントがあるとそのコメント以下が表示されなくなるので注意

#showCode(
"
def func():
    a = 0
    b = 1
# このコメントはダメ
    c = 2  
  # この位置はok
",
".py"
)

= itembox
Latexのアイテムボックスのようなものを表示する関数
== 使い方

普通に使用
#itembox(
  caption: "課題1"
)[
  Typstの利便性について説明せよ 
]

`width`等の変更も可(`outsetやinsetの方向別指定をするとずれる`)
#itembox(
  caption: "課題2",
  width: 100%,
  radius: 10pt,
  inset: 12pt
)[
  Typstについて調べ、Latexと比較せよ
]

`caption`の横の空白サイズを変更
#itembox(
  caption: "課題3",
  width: 100%,
  caption_padding: 15pt
)[
  Typst最高!
]

// ページ際で使うと表示がおかしくなる可能性がある
#pagebreak()
`caption`と本文の間隔を変更
#text(size: 20pt)[
  #itembox(
    caption: "Tips",
    space: 10pt,
  )[
    かなり力技で実装している\
    もう少しいい感じにしたいカモ
  ]
]

== 注意点

力技で実装したため、文字サイズは6ptから30ptを想定しているのでこれを超えると`caption`がずれる\
`caption`の調整をうまく関数化してどんな文字サイズにも対応させたい
