# Matching of Language Tags

use Grammar::IETF::IOL::RFC3066;
role Grammar::HTTP::RFC4647 {
    token language-range          { $<language-tag>=<Grammar::IETF::IOL::RFC3066::language-tag> || '*'                              }
    token extended-language-range { [<primary-subtag> || '*'] ['-' [<subtag> || '*']]* }
}
