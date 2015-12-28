use v6;

use Test;
use lib <t/lib>;
use TestLocal::Grammar;

plan 4;

use Grammar::IETF::ABNF::RFC7405;

my Grammar $grammar = Grammar::IETF::ABNF::RFC7405.new();

subtest {
    plan 192;

    for flat ("\x[20]".."\x[21]", "\x[23]".."\x7E") -> $char {
        is_match('"'~$char~'"', 'quoted-string', $grammar);
    }
    is_match('"We \are <allowed> angles (in $this) string"', 'quoted-string', $grammar);

    not_match('"not " quotes" allowed "', 'quoted-string', $grammar);
    not_match('not "unquoted strings" allowed', 'quoted-string', $grammar);
}, 'quoted-string';

subtest {
    plan 5;

    is_match('%i"char"', 'case-insensitive-string', $grammar);
    is_match('"char"', 'case-insensitive-string', $grammar);

    not_match('%s"char"', 'case-insensitive-string', $grammar);
}, 'case-insensitive-string';

subtest {
    plan 4;

    is_match('%s"char"', 'case-sensitive-string', $grammar);

    not_match('%i"char"', 'case-sensitive-string', $grammar);
    not_match('"char"', 'case-sensitive-string', $grammar);
}, 'case-sensitive-string';

subtest {
    plan 4;

    is_match('%i"char"', 'char-val', $grammar);
    is_match('%s"char"', 'char-val', $grammar);
}, 'char-val';
