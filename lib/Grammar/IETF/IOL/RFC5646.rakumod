# Tags for Identifying Languages

use Grammar::IETF::ABNF::RFC5234;

grammar Grammar::IETF::IOL::RFC5646 does Grammar::IETF::ABNF::RFC5234_Core {
    token Language-Tag {
        | <langtag>
        | <privateuse>
        | <grandfathered>
    }

    token langtag {
        <language> >>
        ['-' <script> >> ]?
        ['-' <region> >> ]?
        ['-' <variant> >> ]*
        ['-' <extension> >> ]*
        ['-' <privateuse> >> ]?
    }

    token language {
        | [ <.ALPHA> ** 2..3 >> [ '-' <.extlang> ]? ]
        | <.ALPHA> ** 4 >>
        | <.ALPHA> ** 5..8 >>
    }

    token extlang {
        <.ALPHA> ** 3 >>
        [ '-' <.ALPHA> ** 3 >> ] ** ^3
    }

    token script { <.ALPHA> ** 4 >> }

    token region {
        | <.ALPHA> ** 2 >>
        | <.DIGIT> ** 3 >>
    }

    token variant {
        | <.alphanum> ** 5..8 >>
        | <.DIGIT> <.alphanum> ** 3 >>
    }

    token extension { <.singleton> [ '-' <.alphanum> ** 2..8 >> ]+ }

    token singleton { <+alphanum -[xX]> >> }

    token privateuse { 'x' >> [ '-' <.alphanum> ** 5..8 >> ]+ }

    token grandfathered { [ <.irregular> | <.regular> ] >> }

    token irregular { :i
        | 'en-GB-oed'
        | 'i-ami'
        | 'i-bnn'
        | 'i-default'
        | 'i-enochian'
        | 'i-hak'
        | 'i-klingon'
        | 'i-lux'
        | 'i-mingo'
        | 'i-navajo'
        | 'i-pwn'
        | 'i-tao'
        | 'i-tay'
        | 'i-tsu'
        | 'sgn-BE-FR'
        | 'sgn-BE-NL'
        | 'sgn-CH-DE'
    }

    token regular { :i
        | 'art-lojban'
        | 'cel-gaulish'
        | 'no-bok'
        | 'no-nyn'
        | 'zh-guoyu'
        | 'zh-hakka'
        | 'zh-min'
        | 'zh-min-nan'
        | 'zh-xiang'
    }

    token alphanum { <.ALPHA> | <.DIGIT> }
}
