## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(text2speech)

## ------------------------------------------------------------------------
if ( tts_auth("amazon")) {
  df = tts_voices(service = "amazon")
  knitr::kable(df)
}

## ------------------------------------------------------------------------
if ( tts_auth("microsoft")) {
  df = tts_voices(service = "microsoft")
  knitr::kable(df)
}

## ------------------------------------------------------------------------
if ( tts_auth("google")) {
  df = tts_voices(service = "google")
  knitr::kable(df)
}

## ------------------------------------------------------------------------
if (tts_auth("google")) {
  df = tts("hey what's up?", service = "google")
  print(df)
  print(df$wav[[1]])
}

