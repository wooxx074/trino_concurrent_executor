go_dir := "src/trino_concurrent_executor/go"

local_bin := justfile_directory() + "/bin"
local_path := local_bin + ":" + env("PATH")

export GOBIN := local_bin
export PATH := local_path

# Show help message
[private]
@default:
    just --list

# Install dependencies
@install:
    pip install --upgrade pip
    pip install -e .
    go mod tidy
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/go-python/gopy@latest

# Build Go bindings
@build:
    {{ local_bin }}/gopy build --output=./{{ go_dir }}/py_build -no-make=true -rename=true -vm=python ./{{ go_dir }}/source

# Remove build Go bindings
@remove-build:
	find ./{{ go_dir }}/py_build/ ! -name ".gitkeep" -type f -exec rm -f {} +
