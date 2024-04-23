#import "../lib.typ": showCode

// tips: コードブロック内の日本語のフォント指定方法
// font: (日本語以外のフォント, 日本語のフォント) で指定
#show raw: set text(lang: "ja", font: ("Consolas", "MS Mincho"), size: 10.5pt)

// 以下使い方

= showCode
== 基本的な使い方
// このような関数をあらかじめ定義すると便利
#let Code(path, ..args) = { showCode(read(path), path, ..args) }

普通に表示
#Code("./main.py")

関数指定で表示
#Code("./main.py", func: "add")

#raw("差分を指定(初期値は(-1, 0)となっており端の空行は表示されない)")
#Code("./main.py", func: "mul", diff: (-2, 1))

#raw("showlinesをtrueにすると端の空行も表示される")
#Code("./main.py", func: "mul", diff: (-2, 1), showlines: true)

クラス指定で表示
#Code("./main.py", class: "counter")

範囲指定で表示
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