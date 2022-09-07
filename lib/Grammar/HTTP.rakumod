use Grammar::HTTP::Extensions;
use Grammar::HTTP::RFC5322;
use Grammar::HTTP::RFC6265;
use Grammar::HTTP::RFC6854;
use Grammar::HTTP::RFC7230;
use Grammar::HTTP::RFC7231;
use Grammar::HTTP::RFC7232;
use Grammar::HTTP::RFC7233;
use Grammar::HTTP::RFC7234;
use Grammar::HTTP::RFC7235;
use Grammar::IETF::ABNF::RFC5234;

# Mix in all the various RFCs into a usable grammar
grammar Grammar::HTTP {
    also does Grammar::HTTP::Extensions;
    also does Grammar::HTTP::RFC5322;
    also does Grammar::HTTP::RFC6265;
    also does Grammar::HTTP::RFC6854;
    also does Grammar::HTTP::RFC7230;
    also does Grammar::HTTP::RFC7231;
    also does Grammar::HTTP::RFC7232;
    also does Grammar::HTTP::RFC7233;
    also does Grammar::HTTP::RFC7234;
    also does Grammar::HTTP::RFC7235;
    also does Grammar::IETF::ABNF::RFC5234_Core;

    token TOP          { <HTTP-message> }

    token HTTP-start   { <start-line>   }
    token HTTP-headers { <start-line> [<header-field> <.CRLF>]* }
    token HTTP-header  { <header-field> }
    token HTTP-body    { <message-body> }
    token HTTP-message { <start-line> [<header-field> <.CRLF>]* <.CRLF> <message-body>? }

    # token HTTP-trailer { <HTTP-trailer> }
}
