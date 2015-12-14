# Matching of Language Tags
no precompilation;

use Grammar::IETF::ABNF::RFC5234;

grammar Grammar::IETF::IOL::RFC4647 does Grammar::IETF::ABNF::RFC5234_Core {
    token language-range {
        $<language-tag>=(
            || [
                $<primary-subtag>=( <.ALPHA> ** 1..8    )
                [ '-'   $<subtag>=( <.alphanum> ** 1..8 ) ]*
               ]
            || '*'
        )
    }
    token alphanum { <.ALPHA> || <.DIGIT> }
    token extended-language-range {
        $<language-tag>=(
            $<primary-subtag>=( [ <.ALPHA> ** 1..8    ] || '*'  )
            [ '-'   $<subtag>=( [ <.alphanum> ** 1..8 ] || '*'  ) ]*
        )
    }
}
