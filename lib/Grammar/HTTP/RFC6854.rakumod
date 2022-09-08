# Update to Internet Message Format to Allow Group Syntax in the "From:" and "Sender:" Header Fields

role Grammar::HTTP::RFC6854 {
    my token sent-from { "From:" [<mailbox-list> || <address-list>] <.CRLF> }
    my token sender    { "Sender:" [<mailbox> || <address>] <.CRLF>         }
    my token reply-to  { "Reply-To:" <address-list> <.CRLF>                 }

    my token resent-from   { "Resent-From:" [<mailbox-list> || <address-list>] <.CRLF> }
    my token resent-sender { "Resent-Sender:" [<mailbox> || <address>] <.CRLF>         }
}
