# Matching of Language Tags

role Grammar::HTTP::RFC4647 {
    token language-range          { <language-tag> || '*'                              }
    token extended-language-range { [<primary-subtag> || '*'] ['-' [<subtag> || '*']]* }
}
