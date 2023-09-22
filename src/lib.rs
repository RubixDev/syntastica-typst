use std::sync::Mutex;

use anyhow::{Context, Result};
use once_cell::sync::Lazy;
use syntastica::{language_set::SupportedLanguage, renderer, style::Style, Processor};
use syntastica_parsers_git::{Lang, LanguageSetImpl, LANGUAGE_NAMES};
use syntastica_themes::THEMES;
use wasm_minimal_protocol::*;

initiate_protocol!();

// the Mutex shouldn't add any overhead on Wasm targets, as they are always single threaded
static PROCESSOR: Lazy<Mutex<Processor<LanguageSetImpl>>> =
    Lazy::new(|| Mutex::new(Processor::new(Box::leak(Box::new(LanguageSetImpl::new())))));

fn get_lang(name: &str) -> Option<Lang> {
    Lang::for_name(name)
        .ok()
        .or_else(|| Lang::for_injection(name))
}

#[wasm_func]
pub fn highlight(code: &[u8], lang: &[u8], theme: &[u8]) -> Result<Vec<u8>> {
    let code = std::str::from_utf8(code).with_context(|| "couldn't decode `code` input")?;
    let lang = std::str::from_utf8(lang).with_context(|| "couldn't decode `lang` input")?;
    let theme = std::str::from_utf8(theme).with_context(|| "couldn't decode `theme` input")?;

    let highlights = PROCESSOR
        .lock()
        .unwrap()
        .process(
            code,
            match get_lang(lang) {
                Some(lang) => lang,
                None => {
                    let mut out = vec![];
                    ciborium::into_writer(
                        &code
                            .lines()
                            .map(|line| [(line, None::<Style>)])
                            .collect::<Vec<_>>(),
                        &mut out,
                    )?;
                    return Ok(out);
                }
            },
        )
        .with_context(|| "highlighting failed")?;
    // TODO: choose theme from typst
    let highlights = renderer::resolve_styles(
        &highlights,
        syntastica_themes::from_str(theme).with_context(|| format!("unknown theme '{theme}'"))?,
    );

    let mut out = vec![];
    ciborium::into_writer(&highlights, &mut out)
        .with_context(|| "failed to serialize highlights")?;

    Ok(out)
}

#[wasm_func]
pub fn supports_lang(lang: &[u8]) -> Result<Vec<u8>> {
    let lang = std::str::from_utf8(lang).with_context(|| "couldn't decode `lang` input")?;
    let supported = get_lang(lang).is_some();
    Ok(vec![supported as u8])
}

#[wasm_func]
pub fn all_languages() -> Result<Vec<u8>> {
    let mut out = vec![];
    ciborium::into_writer(&LANGUAGE_NAMES, &mut out)
        .with_context(|| "failed to serialize output")?;

    Ok(out)
}

#[wasm_func]
pub fn all_themes() -> Result<Vec<u8>> {
    let mut out = vec![];
    ciborium::into_writer(&THEMES, &mut out).with_context(|| "failed to serialize output")?;

    Ok(out)
}

#[wasm_func]
pub fn theme_bg(theme: &[u8]) -> Result<Vec<u8>> {
    let theme = std::str::from_utf8(theme).with_context(|| "couldn't decode `theme` input")?;

    let bg = syntastica_themes::from_str(theme)
        .with_context(|| format!("unknown theme '{theme}'"))?
        .bg();

    let mut out = vec![];
    ciborium::into_writer(&bg, &mut out).with_context(|| "failed to serialize output")?;

    Ok(out)
}

#[wasm_func]
pub fn theme_fg(theme: &[u8]) -> Result<Vec<u8>> {
    let theme = std::str::from_utf8(theme).with_context(|| "couldn't decode `theme` input")?;

    let fg = syntastica_themes::from_str(theme)
        .with_context(|| format!("unknown theme '{theme}'"))?
        .fg();

    let mut out = vec![];
    ciborium::into_writer(&fg, &mut out).with_context(|| "failed to serialize output")?;

    Ok(out)
}
