# build_ffi.py
import os
from cffi import FFI

# Get absolute path to your shared library and header
CURRENT_DIR = os.path.abspath(os.path.dirname(__file__))
LIB_PATH = os.path.join(CURRENT_DIR, "libmath.so")
HEADER_PATH = os.path.join(CURRENT_DIR, "libmath.h")

ffibuilder = FFI()
ffibuilder.cdef("""
    int Add(int a, int b);
""")

ffibuilder.set_source("_math_cffi",
    f"""
    #include "{HEADER_PATH}"
    """,
    extra_objects=[LIB_PATH],
    include_dirs=[CURRENT_DIR])

if __name__ == "__main__":
    ffibuilder.compile(verbose=True)
