#!/bin/sh

name=$(grep -oP '(?<=name = ").*(?=")' typst.toml)
version=$(grep -oP '(?<=version = ").*(?=")' typst.toml)
entrypoint=$(grep -oP '(?<=entrypoint = ").*(?=")' typst.toml)

mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/$name/$version/"
cp -v typst.toml "$entrypoint" syntastica_typst.wasm "${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/$name/$version/"
