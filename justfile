go_dir := "src/go/trino_concurrent_executor"
gopy_build_path := "src/python/trino_concurrent_executor"

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
    {{ local_bin }}/gopy build --output=./{{ gopy_build_path }} -no-make=true -rename=true -vm=python ./{{ go_dir }}/source
    rm ./{{ gopy_build_path }}/__init__.py
    cp ./src/python/gopy_build__init__.py ./{{ gopy_build_path }}/__init__.py

@dist:
    pip install build
    python -m build --wheel

# Remove build Go bindings
@remove-build:
	find ./{{ gopy_build_path }} ! -name ".gitkeep" -type f -exec rm -f {} +
