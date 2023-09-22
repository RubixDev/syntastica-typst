#import "../syntastica.typ": syntastica, languages, theme-bg, theme-fg

#set page(height: auto, width: auto, margin: .5cm)

#let examples = toml("example_programs.toml")
#let theme = "gruvbox::light"

#let languages = languages()
#for (index, lang) in languages.enumerate() {
  let code = examples.at(lang, default: none)
  show raw: syntastica.with(theme: theme)
  block(
    fill: theme-bg(theme),
    inset: 8pt,
    radius: 5pt,
    [
      == *#box(
        fill: luma(240),
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
        raw(lang, block: false),
      )*\
      #if code == none {
        text(fill: red, raw("missing example program", block: true))
      } else {
        let fg = theme-fg(theme)
        let code = raw(code, lang: lang, block: true)
        if fg == none { code } else { text(fill: fg, code) }
      }
    ]
  )
  if index != languages.len() - 1 {
    pagebreak()
  }
}
