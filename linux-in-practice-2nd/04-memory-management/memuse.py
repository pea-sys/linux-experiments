#!/usr/bin/python3

import subprocess

size = 10000000

print("メモリ獲得前のシステム全体のメモリ使用量を表示")
subprocess.run("free")

array = [0]*size

print("メモリ獲得後のシステム全体のメモリ使用量を表示")
subprocess.run("free")

