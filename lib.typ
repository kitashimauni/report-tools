#import "@preview/codelst:2.0.1": sourcefile

// レポート用の個人用設定
#let mysetting(doc) = [
  // テキスト関連の設定 //
  // デフォルト値
  #set text(
    lang: "ja",
    font: ("Cambria", "MS Mincho"),
    size: 10.5pt,
  )
  #set par(first-line-indent: 1em)
  #set heading(
    numbering: (..args) => {
      let nums = args.pos()
      if nums.len() == 1 {
        return numbering("1.", ..nums)
      } else {
        return numbering("1.1", ..nums)
      }
    }
  )
  #show heading.where(level: 1): set text(lang: "ja", font: ("Cambria", "MS Gothic"), size: 12pt)
  #show heading.where(level: 2): set text(lang: "ja", font: ("Cambria", "MS Gothic"), size: 11pt) 
  #show heading: it => {
    it
    par(text(size: 0em, ""))
  }
  
  // コードブロック用
  #show raw: set text(lang: "ja", font: ("Consolas", "MS Mincho"), size: 10.5pt)

  // 図表関連の設定 //
  #show figure.where(kind: table): set figure.caption(position: top)
  
  #doc
]

// ソースファイルからコードを挿入する関数(関数指定, クラス指定は現在pythonのみ対応)
#let showCode(
  code, 
  file,
  caption: none,
  range: none, 
  func: none, 
  class: none, 
  diff: (-1, 0),
  showrange: none,
  ..args,
) = {
  if func != none or class != none {
    let txt = code.split("\n")
    let start = 0; let end = 0; let index = none; let count = 0
    let funcName = regex(if(func!=none){("^\s*def ", func)}else{("^\s*class ", class)}.join())
    if func == "__main__" {funcName = "if __name__ == "} // 特殊指定
    let spaceNum(line) = line.find(regex("(^\s*)")).len()
    for l in txt {
      count += 1
      if (funcName in l) and index == none { 
        index = spaceNum(l)
        start = count
      } else if not (regex("^\s*$") in l) and index != none and (spaceNum(l) > index) { 
        end = count
      } else if not (regex("^\s*$") in l) and index != none and (spaceNum(l) <= index) {
        break
      }
    }
    range = (start + diff.at(0), end + diff.at(1))
  }
  if showrange != none { range = showrange }
  return [
    #set block(spacing: 0.5em)
    #sourcefile(
      code,
      file: file,
      showrange: range,
      ..args,
    )
    #set align(center)
    #caption
  ]
}