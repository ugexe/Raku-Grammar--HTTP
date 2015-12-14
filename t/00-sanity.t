no precompilation;

use v6;
use Test;
plan 6;


subtest {
    plan 1;

    use-ok('Grammar::IETF::URI::RFC3986'),
        '3986: Uniform Resource Identifier (URI): Generic Syntax';
}, 'URI RFC Grammars';

subtest {
    plan 3;

    use-ok('Grammar::IETF::ABNF::RFC4234'),
        '4234: Augmented BNF for Syntax Specifications: ABNF';
    use-ok('Grammar::IETF::ABNF::RFC5234'),
        '5234: Augmented BNF for Syntax Specifications: ABNF';
    use-ok('Grammar::IETF::ABNF::RFC7405'),
        '7405: Augmented BNF for Syntax Specifications: ABNF';
}, 'ABNF Grammars';

subtest {
    plan 1;

    use-ok('Grammar::IETF::DNS::RFC1035'),
        '1035: Domain Names - Implementatin and Specification';
}, 'DNS Grammars';

subtest {
    plan 2;

    use-ok('Grammar::IETF::IOL::RFC3066'),
        '3066: Tags for Identification of Languages';

    use-ok('Grammar::IETF::IOL::RFC4647'),
        '4647: Matching of Language Tags';
}, 'Identification of Language (IOL) Grammars';

subtest {
    use-ok('Grammar::HTTP::RFC5322'),
        '5322: Internet Message Format';

    use-ok('Grammar::HTTP::RFC5646'),
        '5646: Tags for Identifying Languages';

    use-ok('Grammar::HTTP::RFC6265'),
        '6265: HTTP State Management Mechanism';

    use-ok('Grammar::HTTP::RFC6854'),
        '6854: Update to Internet Message Format to Allow Group Syntax in the "From:" and "Sender:" Header Fields';

    use-ok('Grammar::HTTP::RFC7230'),
        '7230: HTTP/1.1 Message Syntax and Routing';

    use-ok('Grammar::HTTP::RFC7231'),
        '7231: Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content';

    use-ok('Grammar::HTTP::RFC7232'),
        '7232: Hypertext Transfer Protocol (HTTP/1.1): Conditional Requests';

    use-ok('Grammar::HTTP::RFC7233'),
        '7233: Hypertext Transfer Protocol (HTTP/1.1): Range Requests';

    use-ok('Grammar::HTTP::RFC7234'),
        '7234: Hypertext Transfer Protocol (HTTP/1.1): Caching';

    use-ok('Grammar::HTTP::RFC7235'),
        '7235: Hypertext Transfer Protocol (HTTP/1.1): Authentication';
}, 'HTTP RFC Grammars';

use-ok('Grammar::HTTP');
