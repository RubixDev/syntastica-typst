#import "../syntastica.typ": syntastica

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
