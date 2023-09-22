#import "../syntastica.typ": syntastica

#show raw: syntastica

```rust
use regex::Regex;
use lazy_regex::{regex, regex_is_match};

fn fib(n: usize) -> usize {
    if n < 2 {
        n
    } else {
        fib(n - 1) + fib(n - 2)
    }
}

fn main() {
    Regex::new(r"[a-fA-F0-9_]\s(.*)$");
    let a = regex!(r"[a-fA-F0-9_]\s(.*)$");
    if regex_is_match!(/* comment */ r"[a-fA-F0-9_]\s(.*)$"i, r"raw text \s[a-f]") {
        return;
    }
}
```

#[
  #show raw: syntastica.with(theme: "gruvbox::light")

  ```go
  import "fmt"

  // comment
  func Main() {
      fmt.Println("Hello, World!")
  }
  ```
]

Inline code is also supported: #raw("fn main() {}", lang: "rust").
This may be useful to reference types like #raw("i32", lang: "rust") or functions like #raw("foo()", lang: "rust") or even things like regular expressions '#raw("[a-fA-F0-9_]\s(.*)$", lang: "regex")' in text.

Languages that `syntastica` doesn't support will continue to be highlighted by Typst's native highlighting logic (using `syntect`)

```typ
= Chapter 1
#let hi = "Hello World"
```

```py
def fib(n):
    if n < 0:
        return None
    if n == 0 or n == 1:
        return n
    return fib(n-1) + fib(n-2)
```

#[
  #show raw.where(block: false): it => box(
    syntastica(it),
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  #show raw.where(block: true): it => block(
    syntastica(it),
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  You can also combine `syntastica` with other show rules.
  Here is the RegEx #raw("[a-fA-F0-9_]\s(.*)$", lang: "regex", block: false) again.

  ```s
  .intel_syntax
  .global _start

  .section .text

  _start:
      call        main..main
      mov         %rdi, 0
      call        exit

  main..main:
      push        %rbp
      mov         %rbp, %rsp
      sub         %rsp, 32
      mov         qword ptr [%rbp-8], 3
      lea         %rax, qword ptr [%rbp-8]
      mov         qword ptr [%rbp-16], %rax
      lea         %rax, qword ptr [%rbp-16]
      mov         qword ptr [%rbp-24], %rax
      mov         %rax, qword ptr [%rbp-24]
      mov         %rax, qword ptr [%rax]
      mov         qword ptr [%rbp-32], %rax
      mov         %rdi, qword ptr [%rbp-24]
      mov         %rdi, qword ptr [%rdi]
      mov         %rdi, qword ptr [%rdi]
      mov         %rsi, qword ptr [%rbp-24]
      mov         %rsi, qword ptr [%rsi]
      mov         %rsi, qword ptr [%rsi]
      call        __rush_internal_pow_int
      mov         %rdi, %rax
      mov         %rax, qword ptr [%rbp-32]
      mov         qword ptr [%rax], %rdi
      mov         %rdi, qword ptr [%rbp-24]
      mov         %rdi, qword ptr [%rdi]
      mov         %rdi, qword ptr [%rdi]
      call        exit
  main..main.return:
      leave
      ret
  ```
]

It can also be used in conbination with `algo` for even prettier listings:

#import "@preview/algo:0.3.3": code
#code(
  indent-guides: 1pt + gray,
  row-gutter: 5pt,
  column-gutter: 5pt,
  inset: 5pt,
  stroke: 2pt + black,
  fill: none,
)[
  ```rust
  fn fib(n: usize) -> usize {
      if n < 2 {
          n
      } else {
          fib(n - 1) + fib(n - 2)
      }
  }
  ```
]
