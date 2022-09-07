use Grammar::IETF::ABNF::RFC5234;

grammar Grammar::IETF::ABNF::RFC7405 is Grammar::IETF::ABNF::RFC5234 {
    token char-val  {
        <.case-insensitive-string> || <.case-sensitive-string>
    }

    token quoted-string           {
        <.DQUOTE> <+[\x[20]..\x[21]] +[\x[23]..\x[7E]]>* <.DQUOTE>
    }

    token case-insensitive-string { [ '%' <[iI]> ]? <.quoted-string> }
    token case-sensitive-string   {   '%' <[sS]>    <.quoted-string> }
}
