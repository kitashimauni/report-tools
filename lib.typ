#import "@preview/codelst:2.0.1": sourcefile

// ソースファイルからコードを挿入する関数(関数指定, クラス指定は現在pythonのみ対応)
#let showCode(
  code, 
  file, 
  range: none, 
  func: none, 
  class: none, 
  diff: (-1, 0),
  showlines: false
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
    sourcefile(
      code,
      file: file,
      showrange: (start + diff.at(0), end + diff.at(1)),
      showlines: showlines
    )
  } else {
    sourcefile(
      code,
      file: file,
      showrange: range,
      showlines: showlines
    )
  }
}