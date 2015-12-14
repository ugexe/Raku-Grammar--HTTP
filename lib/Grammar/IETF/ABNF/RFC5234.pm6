# Core ABNF token definition
no precompilation;

role Grammar::IETF::ABNF::RFC5234_Core is Grammar {
    token ALPHA  { <[ \x[41]..\x[5A] ]> || <[ \x[61]..\x[7A] ]> }
    token BIT    { 0 || 1                                       }
    token CHAR   { <[ \x[01]..\x[7F] ]>                         }
    token CR     { \x[0D]                                       }
    token CRLF   { \x[0D] \x[0A]                                }
    token CTL    { <[ \x[00]..\x[1F] ]> || \x[7F]               }
    token DIGIT  { <[\x[30]..\x[39]]>                           }
    token DQUOTE { \x[22]                                       }
    token HEXDIG { <.DIGIT> || <[ a..f A..F ]>                  }
    token HTAB   { \x[09]                                       }
    token LF     { \x[0A]                                       }
    # LWSP is deprecated for use in Mail Headers if line is just WSP.
    # Not recommended in other uses
    regex LWSP   { [ <.WSP> || <.CRLF> <.WSP> ]*                }
    token OCTET  { <[ \x[00]..\x[FF] ]>                         }
    token SP     { \x[20]                                       }
    token VCHAR  { <[ \x[21]..\x[7E] ]>                         }
    token WSP    { <.SP> || <.HTAB>                             }
}

# ABNF Format
grammar Grammar::IETF::ABNF::RFC5234 does Grammar::IETF::ABNF::RFC5234_Core {
    token rulelist      { [ <rule> || [ <.c-wsp>* <.c-nl>] ]+                           }
    token rule          { <rulename> <defined-as> <elements> <.c-nl>                    }
    token rulename      { <.ALPHA> [ <.ALPHA> || <.DIGIT> || '-' ]*                     }
    token defined-as    { <.c-wsp>* '=' '/'? <.c-wsp>*                                  }
    token elements      { <.alternation> <.c-wsp>*                                      }
    token c-wsp         { <.WSP> || [ <.c-nl> <.WSP> ]                                  }
    token c-nl          { <.comment> || <.CRLF>                                         }
    token comment       { ';' [<.WSP> || <.VCHAR>]* <.CRLF>                             }
    token alternation   { <.concatenation> [<.c-wsp>* '/' <.c-wsp>* <.concatenation>]*  }
    token concatenation { <.repetition> [<.c-wsp>+ <.repetition>]*                      }
    token repetition    { <.repeat>? <.element>                                         }
    token repeat        { <.DIGIT>+ | [ <.DIGIT>* '*' <.DIGIT>* ]                       }
    token element {
        || <.rulename>
        || <.group>
        || <.option>
        || <.char-val>
        || <.num-val>
        || <.prose-val>
    }

    token group     { '(' <.c-wsp>* <.alternation> <.c-wsp>* ')'                       }
    token option    { '[' <.c-wsp>* <.alternation> <.c-wsp>* ']'                       }
    token char-val  { <.DQUOTE> <+[\x[20]..\x[21]] +[\x[23]..\x[7E]]>* <.DQUOTE>       }
    token num-val   { '%' [ <.bin-val> || <.dec-val> || <.hex-val> ]                   }
    token bin-val   { <[bB]> <.BIT>+    [ [ '.' <.BIT>+    ]+ || [ '-' <.BIT>+    ] ]? }
    token dec-val   { <[dD]> <.DIGIT>+  [ [ '.' <.DIGIT>+  ]+ || [ '-' <.DIGIT>+  ] ]? }
    token hex-val   { <[xX]> <.HEXDIG>+ [ [ '.' <.HEXDIG>+ ]+ || [ '-' <.HEXDIG>+ ] ]? }
    token prose-val { '<' <+[\x[20]..\x[3D]] +[\x[3F]..\x[7E]]>* '>'                   }
}
