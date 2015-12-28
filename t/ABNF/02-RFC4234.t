use v6;
use Test;
use lib <t/lib>;
use TestLocal::Grammar;

plan 22;

use Grammar::IETF::ABNF::RFC4234;

my Grammar $grammar = Grammar::IETF::ABNF::RFC4234.new();

subtest {
    plan 7;

    is_match("\r\n", 'rulelist', $grammar);
    is_match("rule = foo\r\n", 'rulelist', $grammar);
    is_match("     \r\n", 'rulelist', $grammar);
    not_match(" foo = bar\r\n", 'rulelist', $grammar);
}, 'rulelist';

subtest {
    plan 2;

    is_match('rulelist  =  1*( rule / (*c-wsp c-nl) )'~"\r\n", 'rule', $grammar);
}, 'rule';

subtest {
    plan 6;

    is_match(' ', 'c-wsp', $grammar);
    is_match("\r\n ", 'c-wsp', $grammar);
    is_match("; A comment here \r\n ", 'c-wsp', $grammar);
}, 'c-wsp';

subtest {
    plan 4;

    is_match("; a comment\r\n", 'c-nl', $grammar);
    is_match("\r\n", 'c-nl', $grammar);
}, 'c-nl';

subtest {
    plan 3;

    is_match("; This is a comment \r\n", 'comment', $grammar);
    not_match("; Single line comment", 'comment', $grammar);
}, 'comment';

subtest {
    plan 6;

    is_match('foo', 'alternation', $grammar);
    is_match('bar / foo', 'alternation', $grammar);
    is_match("bar\r\n ; comment\r\n /foo", 'alternation', $grammar);
}, 'alternation';

subtest {
    plan 8;

    is_match('2*foo', 'concatenation', $grammar);
    is_match('foo foo       *1bar', 'concatenation', $grammar);
    is_match("foo bar \r\n *1bar", 'concatenation', $grammar);
    is_match('*[foo] foo', 'concatenation', $grammar);
}, 'concatenation';

subtest {
    plan 4;

    is_match('2*2foo', 'repetition', $grammar);
    is_match('1*( foo  foo )', 'repetition', $grammar);
}, 'repetition';

subtest {
    plan 4;

    is_match('foo / bar', 'elements', $grammar);
    is_match('foo ', 'elements', $grammar);
}, 'elements';

subtest {
    plan 10;

    is_match('a', 'rulename', $grammar);
    is_match('S', 'rulename', $grammar);
    is_match('a1-sd', 'rulename', $grammar);
    is_match('a-', 'rulename', $grammar);

    not_match(1, 'rulename', $grammar);
    not_match('a!', 'rulename', $grammar);
}, 'rulename';

subtest {
    plan 10;

    is_match(" = ", 'defined-as', $grammar);
    is_match(" =/ ", 'defined-as', $grammar);
    is_match('=', 'defined-as', $grammar);
    is_match("\r\n =", 'defined-as', $grammar);
    is_match("; A comment\r\n = ; another comment\r\n ", 'defined-as', $grammar);
}, 'defined-as';

subtest {
    plan 18;

    is_match('*', 'repeat', $grammar);
    is_match('1*', 'repeat', $grammar);
    is_match('*1', 'repeat', $grammar);
    is_match('2*1', 'repeat', $grammar);
    is_match('1', 'repeat', $grammar);
    is_match('200*200', 'repeat', $grammar);
    is_match('200', 'repeat', $grammar);
    is_match('200*', 'repeat', $grammar);
    is_match('*200', 'repeat', $grammar);
}, 'repeat';

subtest {
    plan 12;

    is_match('rulename', 'element', $grammar);
    is_match('( group )', 'element', $grammar);
    is_match('[ option ]', 'element', $grammar);
    is_match('" char "', 'element', $grammar);
    is_match('%d23-24', 'element', $grammar);
    is_match('< prose 101 >', 'element', $grammar);
}, 'element';

subtest {
    plan 7;

    is_match('( foo / *bar )', 'group', $grammar);
    is_match('(groups (all (the (way (down)))))', 'group', $grammar);
    is_match('(group *(many groups))', 'group', $grammar);
    not_match('foo / bar', 'group', $grammar);
}, 'group';

subtest {
    plan 7;

    is_match('[ foo / *bar ]', 'option', $grammar);
    is_match('[options [all [the [way [down]]]]]', 'option', $grammar);
    is_match('[option *[many options]]', 'option', $grammar);
    not_match('foo / bar', 'option', $grammar);
}, 'option';

subtest {
    plan 192;

    for flat ("\x[20]".."\x[21]", "\x[23]".."\x7E") -> $char {
        is_match('"'~$char~'"', 'char-val', $grammar);
    }
    is_match('"We \are <allowed> angles (in $this) string"', 'char-val', $grammar);

    not_match('"not " quotes" allowed "', 'char-val', $grammar);
    not_match('not "unquoted strings" allowed', 'char-val', $grammar);
}, 'char-val';

subtest {
    plan 8;

    is_match('%b01', 'num-val', $grammar);
    is_match('%d12', 'num-val', $grammar);
    is_match('%x2F', 'num-val', $grammar);

    not_match('%t2', 'num-val', $grammar);
    not_match('$d12', 'num-val', $grammar);
}, 'num-val';

subtest {
    plan 14;

    is_match('b1', 'bin-val', $grammar);
    is_match('b10101101', 'bin-val', $grammar);

    is_match('b0-1', 'bin-val', $grammar);
    is_match('b10101011.11001010', 'bin-val', $grammar);
    is_match('b11.10.11', 'bin-val', $grammar);

    is_match('B10.11', 'bin-val', $grammar);

    not_match('b22.22', 'bin-val', $grammar);
    not_match('b121212', 'bin-val', $grammar);
}, 'bin-val';

subtest {
    plan 14;

    is_match('d1', 'dec-val', $grammar);
    is_match('d12123123', 'dec-val', $grammar);

    is_match('d20-21', 'dec-val', $grammar);
    is_match('d22.23', 'dec-val', $grammar);
    is_match('d22.23.24', 'dec-val', $grammar);

    is_match('D22.23', 'dec-val', $grammar);

    not_match('b22.22', 'dec-val', $grammar);
    not_match('b101010', 'dec-val', $grammar);
}, 'dec-val';

subtest {
    plan 14;

    is_match('xF', 'hex-val', $grammar);
    is_match('xFF', 'hex-val', $grammar);

    is_match('x20-21', 'hex-val', $grammar);
    is_match('x22.23', 'hex-val', $grammar);
    is_match('x22.23.34', 'hex-val', $grammar);

    is_match('X22.23', 'hex-val', $grammar);

    not_match('d22.22', 'hex-val', $grammar);
    not_match('xFY', 'hex-val', $grammar);
}, 'hex-val';

subtest {
    plan 191;
    for "\x[20]".."\x[3D]" -> $string {
        is_match( '<'~$string~'>', 'prose-val' , $grammar);
    }

    for "\x[3f]".."\x[7E]" -> $string {
        is_match('<'~$string~'>', 'prose-val', $grammar);
    }


    is_match('<'~'this is a test {vchars} and [sp] without angles!'~'>', 'prose-val', $grammar);

    not_match('(no angles)', 'prose-val', $grammar);
}, 'prose-val';

subtest {
    plan 2;

    my $text = "t/ABNF/rfc5234_grammar.txt".IO.slurp;

    # File is \n but the grammar spec is \r\n;
    $text ~~ s:g/\n/\r\n/;

    is_match($text, 'rulelist', $grammar);
}, 'rules list from file (rfc spec)';
