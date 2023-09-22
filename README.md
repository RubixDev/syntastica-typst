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

Before this package becomes available in the
[official package repository](https://github.com/typst/packages) (if it even
ever does), you can use it in one of two ways.

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
