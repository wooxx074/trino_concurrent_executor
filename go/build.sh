# Requires a python environment with cffi installed
go build -buildmode=c-shared -o libmath.so main.go
python build_ffi.py
