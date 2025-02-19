# `syntastica` for Typst

Tree-sitter syntax highlighting for code blocks.

## Showcase

![Comparison between normal and syntastica highlighting](https://raw.githubusercontent.com/RubixDev/syntastica-typst/main/examples/comparison.png)

````typ
#import "syntastica.typ": syntastica

#set page(height: auto, width: auto, margin: 1cm)

Without `syntastica`:

```rust
fn fib(n: usize) -> usize {
    if n < 2 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}
```

#show raw: syntastica

With `syntastica`:

```rust
fn fib(n: usize) -> usize {
    if n < 2 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}
```
````

For more examples, have a look at the
['examples'](https://github.com/RubixDev/syntastica-typst/tree/main/examples/)
directory.

## Installation

Due to its large size, this package
[was not accepted](https://github.com/typst/packages/pull/143) for the
[official package repository](https://github.com/typst/packages). However, you
can still use it in one of two ways:

### Option 1: Install as a local package

If you are using Typst locally, you can install this package to your local
package repository. The easiest way to do that is to clone this repository and
run the `install_local.sh` script (Linux only):

```bash
git clone https://github.com/RubixDev/syntastica-typst
cd syntastica-typst
./install_local.sh
```

Alternatively you can manually create the appropriate directory as described
[here](https://github.com/typst/packages#local-packages), and copy the following
files from this repo into that folder:

- [`typst.toml`](https://github.com/RubixDev/syntastica-typst/blob/main/typst.toml)
- [`syntastica.typ`](https://github.com/RubixDev/syntastica-typst/blob/main/syntastica.typ)
- [`syntastica_typst.wasm`](https://github.com/RubixDev/syntastica-typst/blob/main/syntastica_typst.wasm)

After that is done, you can import the functions like this:

```typ
#import "@local/syntastica:0.1.0": syntastica, languages, themes, theme-bg, theme-fg
```

### Option 2: Copy the files into your project

You can also just simply copy the package files into your project and import
them like usual. Note that because this package uses a Wasm plugin, you must
copy that too.

Required files:

- [`syntastica.typ`](https://github.com/RubixDev/syntastica-typst/blob/main/syntastica.typ)
- [`syntastica_typst.wasm`](https://github.com/RubixDev/syntastica-typst/blob/main/syntastica_typst.wasm)

Import with:

```typ
#import "syntastica.typ": syntastica, languages, themes, theme-bg, theme-fg
```

## Performance

Please bear in mind that this package is **slow**. And the more different
languages you make use of, the slower it will get. This is actually somewhat
fine when using an LSP, which will run the language initialization code in the
plugin once, and then keep it in memory for following compilations.

One way to go about this is to add a top-level variable for toggling
`syntastica` and only set it to `true` for production builds. See the
[`prod_toggle` example](https://github.com/RubixDev/syntastica-typst/blob/main/examples/prod_toggle.typ)
for an implementation of this approach.

> [!NOTE] Typst 0.13.0 drastically improved performance of WebAssambly plugins,
> but sadly this package is still _very_ slow compared to not using it.

## Usage

### `syntastica`

Apply `syntastica` highlighting to a raw code element.

```typ
#let syntastica(it, theme: "one::light") = { ... }
```

**Arguments:**

- `it`: [`content`] &mdash; The
  [raw element](https://typst.app/docs/reference/text/raw/) to apply
  highlighting to.
- `theme`: [`str`] &mdash; The theme to use. See
  [here](https://github.com/RubixDev/syntastica-typst/blob/main/examples/all_themes.pdf)
  for a list of all themes.

### `languages`

Get a list of all supported languages.

```typ
#let languages() = { ... }
```

**Returns:** An [`array`] of [`str`]s.

### `themes`

Get a list of all supported themes.

```typ
#let themes() = { ... }
```

**Returns:** An [`array`] of [`str`]s.

### `theme-bg`

Get the default background color of a theme.

```typ
#let theme-bg(theme) = { ... }
```

**Arguments:**

- `theme`: [`str`] &mdash; The theme name.

**Returns:** [`color`] or `none`

### `theme-fg`

Get the default foreground color of a theme.

```typ
#let theme-fg(theme) = { ... }
```

**Arguments:**

- `theme`: [`str`] &mdash; The theme name.

**Returns:** [`color`] or `none`

[`array`]: https://typst.app/docs/reference/foundations/array/
[`str`]: https://typst.app/docs/reference/foundations/str/
[`content`]: https://typst.app/docs/reference/foundations/content/
[`color`]: https://typst.app/docs/reference/visualize/color/
