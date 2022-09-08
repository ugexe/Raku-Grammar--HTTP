## Grammar::HTTP

Grammars for parsing HTTP headers, message bodies, and URIs

## Synopsis

    use Grammar::HTTP;

    my $request = "GET / HTTP/1.1\r\nHost: www.raku.org\r\n\r\n";
    my $match   = Grammar::HTTP.parse($request);
    say $match;

    # ｢GET / HTTP/1.1
    # Host: www.raku.org
    #
    #｣
    # HTTP-message => ｢GET / HTTP/1.1
    # Host: www.raku.org
    #
    #｣
    #  start-line => ｢GET / HTTP/1.1
    #｣
    #   request-line => ｢GET / HTTP/1.1
    #｣
    #    method => ｢GET｣
    #    request-target => ｢/｣
    #    HTTP-version => ｢HTTP/1.1｣
    #     HTTP-name => ｢HTTP｣
    #     major => ｢1｣
    #     minor => ｢1｣
    #  header-field => ｢Host: www.raku.org｣
    #   name => ｢Host｣
    #   value => ｢www.raku.org｣
    #    host => ｢www.raku.org｣
    #  message-body => ｢｣


### Rules

    token HTTP-start
    token HTTP-headers
    token HTTP-header
    token HTTP-body
    token HTTP-message

Parsing individual parts of the HTTP message can also be done by using a different rule. The default 
`Grammar::HTTP.parse($str)` is really the same as `Grammar::HTTP.parse($str, :rule('HTTP-message')`. 
So to parse just the start line you could do:
    
    my $string = "GET /http.html HTTP/1.1\r\n"; 
    say Grammar::HTTP.parse($string, :rule<HTTP-start>)'

    # ｢GET /http.html HTTP/1.1
    # ｣
    #  start-line => ｢GET /http.html HTTP/1.1
    # ｣
    #   request-line => ｢GET /http.html HTTP/1.1
    # ｣
    #    method => ｢GET｣
    #    request-target => ｢/http.html｣
    #    HTTP-version => ｢HTTP/1.1｣
    #    HTTP-name => ｢HTTP｣
    #    major => ｢1｣
    #    minor => ｢1｣

### Actions

`Grammar::HTTP::Actions` can be used to generate a structured hash from a HTTP response message

    use Grammar::HTTP::Actions;
    use Grammar::HTTP;

    my $response = "HTTP/1.1 200 OK\r\n"
        ~ "Allow: GET, HEAD, PUT\r\n"
        ~ "Content-Type: text/html; charset=utf-8\r\n"
        ~ "Transfer-Encoding: chunked, gzip\r\n\r\n";

    my $parsed = Grammar::HTTP.parse($response, :actions(Grammar::HTTP::Actions.new));
    my %header = $parsed.<HTTP-message>.<header-field>>>.made;
    dd %header;

    # Hash %header = {
    #    :Allow($("GET", "HEAD", "PUT")),
    #    :Content-Type($[
    #        :type("text"),
    #        :subtype("html"),
    #        :parameters([ :charset("utf-8") ])
    #    ]),
    #    :Transfer-Encoding($("chunked", "gzip"))}


#### RFCs

[RFC1035](https://www.rfc-editor.org/rfc/rfc1035) Domain Names - Implementation and Specification

[RFC3066](https://www.rfc-editor.org/rfc/rfc3066) Tags for the Identification of Languages

[RFC4234](https://www.rfc-editor.org/rfc/rfc4234) Augmented BNF for Syntax Specifications: ABNF

[RFC5234](https://www.rfc-editor.org/rfc/rfc5234) Augmented BNF for Syntax Specifications: ABNF (replaces 4234)

[RFC7405](https://www.rfc-editor.org/rfc/rfc7405) Case-Sensitive String Support in ABNF

[RFC4647](https://www.rfc-editor.org/rfc/rfc4647) Matching of Language Tags

[RFC5322](https://www.rfc-editor.org/rfc/rfc5322) Internet Message Format

[RFC5646](https://www.rfc-editor.org/rfc/rfc5646) Tags for Identifying Languages

[RFC7230](https://www.rfc-editor.org/rfc/rfc7230) Hypertext Transfer Protocol (HTTP/1.1): Message Syntax and Routing

[RFC7231](https://www.rfc-editor.org/rfc/rfc7231) Hypertext Transfer Protocol (HTTP/1.1): Semantics and Content

[RFC7232](https://www.rfc-editor.org/rfc/rfc7232) Hypertext Transfer Protocol (HTTP/1.1): Conditional Requests

[RFC7233](https://www.rfc-editor.org/rfc/rfc7233) Hypertext Transfer Protocol (HTTP/1.1): Range Requests

[RFC7234](https://www.rfc-editor.org/rfc/rfc7234) Hypertext Transfer Protocol (HTTP/1.1): Caching

[RFC7235](https://www.rfc-editor.org/rfc/rfc7235) Hypertext Transfer Protocol (HTTP/1.1): Authentication
