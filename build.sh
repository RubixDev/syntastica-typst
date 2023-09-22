#!/bin/sh

cargo build --release --target wasm32-unknown-unknown
wasm-opt "${CARGO_TARGET_DIR:-target}/wasm32-unknown-unknown/release/syntastica_typst.wasm" -Os -o syntastica_typst.wasm

curl 'https://raw.githubusercontent.com/RubixDev/syntastica/main/examples/example_programs.toml' -o examples/example_programs.toml
