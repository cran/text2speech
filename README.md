
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Overview

<!-- badges: start -->
<!-- badges: end -->

The goal of text2speech is to harmonize various text-to-speech engines,
including Amazon Polly, Coqui TTS, Google Cloud Text-to-Speech API, and
Microsoft Cognitive Services Text to Speech REST API.

With the exception of Coqui TTS, all these engines are accessible as R
packages:

- [aws.polly](https://github.com/cloudyr/aws.polly) is a client for
  [Amazon
  Polly](https://docs.aws.amazon.com/polly/latest/dg/what-is.html)
- [googleLanguageR](https://github.com/ropensci/googleLanguageR) is a
  client to the [Google Cloud Text-to-Speech
  API](https://cloud.google.com/text-to-speech/)
- [conrad](https://github.com/fhdsl/conrad) is a client to the
  [Microsoft Cognitive Services Text to Speech REST
  API](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/rest-text-to-speech?tabs=streaming)

You might notice Coqui TTS doesn’t have its own R package. This is
because, at this time, text2speech directly incorporates the
functionality of Coqui TTS. The R wrapper of Coqui is [under
development](https://github.com/howardbaek/ribbit).

## Installation

You can install this package from CRAN or the development version from
GitHub with:

``` r
# Install from CRAN
install.packages("text2speech")

# or the development version from GitHub
# install.packages("devtools")
devtools::install_github("jhudsl/text2speech")
```

## Authentication

Check for authentication. If not already authenticated, users must
individually configure it for each service.

``` r
library(text2speech)

# Amazon Polly
tts_auth("amazon")
#> [1] TRUE
# Coqui TTS
tts_auth("coqui")
#> [1] TRUE
# Google Cloud Text-to-Speech API 
tts_auth("google")
#> [1] TRUE
# Microsoft Cognitive Services Text to Speech REST API
tts_auth("microsoft")
#> [1] TRUE
```

## Voices

List different voice options for each service.

``` r
# Amazon Polly
voices_amazon <- tts_amazon_voices()
head(voices_amazon)
#>   voice         language language_code gender service
#> 1 Zeina           Arabic           arb Female  amazon
#> 2 Zhiyu Chinese Mandarin        cmn-CN Female  amazon
#> 3  Naja           Danish         da-DK Female  amazon
#> 4  Mads           Danish         da-DK   Male  amazon
#> 5 Ruben            Dutch         nl-NL   Male  amazon
#> 6 Lotte            Dutch         nl-NL Female  amazon

# Coqui TTS
voices_coqui <- tts_coqui_voices()
#> ℹ Test out different voices on the CoquiTTS Demo (<https://huggingface.co/spaces/coqui/CoquiTTS>)
head(voices_coqui)
#> # A tibble: 6 × 5
#>   type       language     dataset       model_name service
#>   <chr>      <chr>        <chr>         <chr>      <chr>  
#> 1 tts_models multilingual multi-dataset your_tts   coqui  
#> 2 tts_models multilingual multi-dataset bark       coqui  
#> 3 tts_models bg           cv            vits       coqui  
#> 4 tts_models cs           cv            vits       coqui  
#> 5 tts_models da           cv            vits       coqui  
#> 6 tts_models et           cv            vits       coqui

# Google Cloud Text-to-Speech API 
voices_google <- tts_google_voices()
head(voices_google)
#>              voice language language_code gender service
#> 1 af-ZA-Standard-A     <NA>         af-ZA FEMALE  google
#> 2 af-ZA-Standard-A     <NA>         af-ZA FEMALE  google
#> 3  ar-XA-Wavenet-C   Arabic         ar-XA   MALE  google
#> 4 ar-XA-Standard-C   Arabic         ar-XA   MALE  google
#> 5 ar-XA-Standard-D   Arabic         ar-XA FEMALE  google
#> 6  ar-XA-Wavenet-A   Arabic         ar-XA FEMALE  google

# Microsoft Cognitive Services Text to Speech REST API
voices_microsoft <- tts_microsoft_voices()
head(voices_microsoft)
#>                                                                voice
#> 1   Microsoft Server Speech Text to Speech Voice (af-ZA, AdriNeural)
#> 2 Microsoft Server Speech Text to Speech Voice (af-ZA, WillemNeural)
#> 3 Microsoft Server Speech Text to Speech Voice (am-ET, MekdesNeural)
#> 4  Microsoft Server Speech Text to Speech Voice (am-ET, AmehaNeural)
#> 5 Microsoft Server Speech Text to Speech Voice (ar-AE, FatimaNeural)
#> 6 Microsoft Server Speech Text to Speech Voice (ar-AE, HamdanNeural)
#>                        language language_code gender   service
#> 1      Afrikaans (South Africa)         af-ZA Female microsoft
#> 2      Afrikaans (South Africa)         af-ZA   Male microsoft
#> 3            Amharic (Ethiopia)         am-ET Female microsoft
#> 4            Amharic (Ethiopia)         am-ET   Male microsoft
#> 5 Arabic (United Arab Emirates)         ar-AE Female microsoft
#> 6 Arabic (United Arab Emirates)         ar-AE   Male microsoft
```

## Convert text to speech

Synthesize speech with `tts(text = "TEXT", service = "ENGINE")`

``` r
# Amazon Polly
tts("Hello world!", service = "amazon")

# Coqui TTS
tts("Hello world!", service = "coqui")

# Google Cloud Text-to-Speech API 
tts("Hello world!", service = "google")

# Microsoft Cognitive Services Text to Speech REST API
tts("Hello world!", service = "microsoft")
```

The resulting output will consist of a standardized tibble featuring the
following columns:

- `index`: Sequential identifier number
- `original_text`: The text input provided by the user
- `text`: In case `original_text` exceeds the character limit, `text`
  represents the outcome of splitting `original_text`. Otherwise, `text`
  remains the same as `original_text`.
- `wav`: Wave object (S4 class)
- `file`: File path to the audio file
- `audio_type`: The audio format, either mp3 or wav
- `duration` : The duration of the audio file
- `service`: The text-to-speech engine used
