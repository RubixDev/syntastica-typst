#import "../syntastica.typ": syntastica, themes, theme-bg

#set page(height: auto, width: auto, margin: .5cm)

#let themes = themes()
#for (index, theme) in themes.enumerate() {
  show raw.where(block: true): it => block(
    fill: theme-bg(theme),
    inset: 8pt,
    radius: 5pt,
    [
      == *#box(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
        raw(theme, block: false),
      )*\
      #syntastica(theme: theme, it)
    ]
  )
  [
    ```rust
    // TODO: comment
    fn main() {
        println!("Hello, World!");
    }
    ```
  ]
  if index != themes.len() - 1 {
    pagebreak()
  }
}
