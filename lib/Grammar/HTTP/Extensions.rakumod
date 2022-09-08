role Grammar::HTTP::Extensions {
    token directive                 { <directive-name> [ "=" <directive-value> ]? }
    token directive-name            { <.token>                                    }
    token directive-value           { <.token> || <.quoted-string>                }

    # Header extensions
    # These are known headers that are not defined  in an RFC
    # (or in an RFC not implemented in these grammars yet)
    token known-header:sym<Alternate-Protocol> { [:i <.sym>] }
    token known-header:sym<Keep-Alive>         { [:i <.sym>] }
    token known-header:sym<P3P>                { [:i <.sym>] }
    token known-header:sym<Strict-Transport-Security> {[:i <.sym>] }
    token known-header:sym<X-Robots-Tag>       { [:i <.sym>] }
    token known-header:sym<X-UA-Compatible>    { [:i <.sym>] }
    token known-header:sym<X-XSS-Protection>   { [:i <.sym>] }
    token known-header:sym<Status> { [:i <.sym>] }

    token Status { <status-code> <.SP> <reason-phrase> }


    token Alternate-Protocol { [[<port> ':' <protocol>] || <directive>] *%% ','       }
    token Keep-Alive         { [<directive>]?  [";" [<.OWS> <directive> ]?]*          }
    token P3P                { [<directive>]?  [";" [<.OWS> <directive> ]?]*          }
    token Strict-Transport-Security { [<directive>]?  [";" [<.OWS> <directive> ]?]*   }

    token X-Robots-Tag       { (<.token>) *%% ','                               }
    token X-XSS-Protection   { [<directive>]?  [";" [<.OWS> <directive> ]?]*    }
    token X-UA-Compatible    { [<directive>]?  [";" [<.OWS> <directive> ]?]*    }

    # todo:
    #Strict-Transport-Security # max-age=16070400; includeSubDomains
    #Link # <http://www.example.com/>; rel=”cononical”
    #X-Content-Type-Options
    #X-Frame-Options
    #Strict-Transport-Security
    #Public-Key-Pins
    #Access-Control-Allow-Origin
    #Content-Security-Policy
    #Alt-Svc
}