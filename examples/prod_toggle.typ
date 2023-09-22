#import "../syntastica.typ": syntastica

#set page(height: auto, width: auto, margin: .5cm)

// keep this set to `false` during development
#let syntastica-enabled = true
// use the variable wherever you use syntastica
#show raw: it => if syntastica-enabled { syntastica(it, theme: "tokyo::day") } else { it }

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
