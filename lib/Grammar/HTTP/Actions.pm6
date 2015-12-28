role Grammar::HTTP::Actions::Header::Allow {
    method Allow($/) {
        make $/<allow-value>.map(*.made).cache;
    }

    method allow-value($/) {
        make $/<method>.made;
    }

    method method($/) {
        make $/.Str;
    }
}

role Grammar::HTTP::Actions::Header::Accept-Language {
    method Accept-Language($/) {
        make $/<accept-language-value>.map(*.made).cache;
    }

    method accept-language-value($/) {
        if $/<weight> {
            make [tag => $/<language-range>.made, weight => $/<weight>.made];
        }
        else {
            make [tag => $/<language-range>.made];
        }
    }

    method language-range($/) {
        make $/<language-tag>.Str;
    }

    my method weight($/) {
        make $/<qvalue>.made;
    }
}

role Grammar::HTTP::Actions::Header::Accept-Encoding { 
    method Accept-Encoding($/) {
        make $/<accept-encoding-value>.map(*.made).cache;
    }

    method accept-encoding-value($/) {
        if $/<weight> {
            make [coding => $/<codings>.Str, weight => $/<weight>.made];
        }
        else {
            make [coding => $/<codings>.Str];
        }
    }

    my method weight($/) {
        make $/<qvalue>.made;
    }

    method codings($/) {
        make $/.Str;
    } 
}

role Grammar::HTTP::Actions::Header::Accept { 
    method Accept($/) {
        make $/<accept-value>.map(*.made).cache;
    }

    method accept-value($/) {
        if $/<accept-params> {
            make [range => $/<media-range>.made, $/<accept-params>.made];
        }
        else {
            make [range => $/<media-range>.made];
        }
    }

    method media-range($/) {
        if $/<parameter> {
            make [type => $/<type>.Str, subtype => $/<subtype>.Str, parameters => $/<parameter>.map(*.made).cache];
        }
        else {
            make [type => $/<type>.Str, subtype => $/<subtype>.Str];            
        }
    }

    method parameter($/) { 
        make $/<name>.Str => $/<value>.Str; 
    }

    method accept-params($/) { 
        if $/<accept-ext> {
            make [weight => $/<weight>.made, parameters => $/<accept-ext>.map(*.made).cache];
        }
        else {
            make [weight => $/<weight>.made];
        }
    }

    method weight($/) {
        make $/<qvalue>.made;
    }

    method accept-ext($/) {
        if $/<value> {
            make $/<name>.Str => $/<value>.Str;
        }
        else {
            make $/<name>.Str;
        }
    }

    method qvalue($/) {
        make $/.Str;
    }
}

role Grammar::HTTP::Actions::Header::Connection {
    method Connection($/) {
        make [$<connection-option>>>.Str]
    }
}

role Grammar::HTTP::Actions::Header::Content-Type {
    method Content-Type($/) {
        make $<media-type>.made;
    }

    method media-type($/) {
        if $/<parameter> {
            make [type => $/<type>.Str, subtype => $/<subtype>.Str, parameters => [$/<parameter>.map(*.made).cache.flat]];
        }
        else {
            make [type => $/<type>.Str, subtype => $/<subtype>.Str];            
        }
    }
}

role Grammar::HTTP::Actions::Header::Transfer-Encoding {
    method Transfer-Encoding($/) {
        make $<transfer-encoding-value>.map(*.made).cache;
    }

    method transfer-encoding-value($/) {
        make $/<transfer-coding>.made;
    }

    method transfer-coding($/) {
        make $/.Str;
    }
}




class Grammar::HTTP::Actions::Response {
    also does Grammar::HTTP::Actions::Header::Allow;
    also does Grammar::HTTP::Actions::Header::Content-Type;
    also does Grammar::HTTP::Actions::Header::Transfer-Encoding;
}

class Grammar::HTTP::Actions::Request {
    also does Grammar::HTTP::Actions::Header::Accept;
    also does Grammar::HTTP::Actions::Header::Accept-Encoding;
    also does Grammar::HTTP::Actions::Header::Accept-Language;
    also does Grammar::HTTP::Actions::Header::Connection;

}


# todo: eventually phase this out and use the Reponse and Request actions directly.
# This just makes it easier for testing some initial things.
class Grammar::HTTP::Actions {
    also is Grammar::HTTP::Actions::Request;
    also is Grammar::HTTP::Actions::Response;

    method start-line($/) {
        make $/.made;
    }

    method method($/) {
        make ~$/;
    }

    method request-target($/) {
        # todo: use a URI object?
        make $/.Str;
    }

    method header-field($/) {
        if $/<value>.made {
            make $/<name>.Str => $/<value>.ast;
        }
        else {
            make $/<name>.Str => $/<value>.Str;
        }
    }


    # reponse
    method Location($/) {
        make $/.Str;
    }
}

