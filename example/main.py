import glob
from re import match

# 課題1 足し算をする関数
def add(a : int, b : int) -> int:
    return a + b

# 課題2 
# 掛け算をする関数
def mul(a : int, b : int) -> int:
    return a * b

# カウンター
class counter:
    count = 0
    def __init__(self) -> None:
        count = 0
    def add_count():
        count += 1

if __name__ == "__main__":
    print(add(1, 2))
    print(mul(2, 4))
    # main