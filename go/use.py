# use.py
from _math_cffi import lib, ffi

result = lib.Add(5, 3)
print(result)  # prints 8

