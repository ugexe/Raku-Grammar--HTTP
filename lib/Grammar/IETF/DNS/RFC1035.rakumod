# DOMAIN NAMES - IMPLEMENTATION AND SPECIFICATION

grammar Grammar::IETF::DNS::RFC1035 {
    token letter      { <[a..zA..Z]>                              }
    token digit       { <[0..9]>                                  }
    token domain      { <subdomain> || ' '                        }
    token subdomain   { <.label>+ % '.'                           }
    # Allow backtracking to capture the last letter/numer in a label
    regex label       { <.letter> [ <.ldh-str>? <.let-dig> ]?     }
    regex ldh-str     { <.let-dig-hyp>+                           }
    token let-dig-hyp { <.let-dig> || <[-]>                       }
    token let-dig     { <.letter>  || <.digit>                    }
}
