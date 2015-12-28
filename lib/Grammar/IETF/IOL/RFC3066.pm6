# Tags for Identification of Languages

use Grammar::IETF::ABNF::RFC5234;
grammar Grammar::IETF::IOL::RFC3066 does Grammar::IETF::ABNF::RFC5234_Core {
    token language-tag   { <primary-subtag> ['-' <subtag>]* }
    token primary-subtag { <.ALPHA> ** 1..8                 }
    token subtag         { [ <.ALPHA> || <.DIGIT> ] ** 1..8 }
}
