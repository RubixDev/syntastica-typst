#!/bin/sh

typst compile --root . examples/main.typ &
typst compile --root . examples/all_themes.typ &
typst compile --root . examples/all_languages.typ &
typst compile --root . examples/comparison.typ -f png examples/comparison.png &
typst compile --root . examples/prod_toggle.typ &

wait
