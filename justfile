go_dir := "src/go/trino_concurrent_executor"
gopy_build_path := "output/trino_concurrent_executor"

local_bin := justfile_directory() + "/bin"
local_path := local_bin + ":" + env("PATH")

python_lib_path := justfile_directory() + "/.python/site-packages" 
python_path := python_lib_path + ":" + env("PYTHONPATH", "")

export GOBIN := local_bin
export PATH := local_path
export PYTHONPATH := python_path
# Show help message
[private]
@default:
    just --list

# Install dependencies
@install:
    mkdir -p ./{{ gopy_build_path }}
    pip install --upgrade pip
    pip install -e . --target {{ python_lib_path }} --upgrade
    go mod tidy
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/go-python/gopy@latest

# Build Go bindings
@build:
    # export PYTHONPATH=$PYTHONPATH:{{ python_path }}
    {{ local_bin }}/gopy build --output={{ gopy_build_path }} -no-make=true -rename=true -vm=python3.12 ./{{ go_dir }}
    # cp -f ./output/gopy_build__init__.py ./{{ gopy_build_path }}/__init__.py

@dist:
    pip install build
    python -m build --wheel ./output --outdir ./dist

# Remove build Go bindings
@remove-build:
	find ./{{ gopy_build_path }} ! -name ".gitkeep" -type f -exec rm -f {} +
