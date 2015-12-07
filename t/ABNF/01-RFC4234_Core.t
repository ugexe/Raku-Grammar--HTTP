no precompilation;

use v6;
use Test;
use lib <t/lib>;
use TestLocal::Grammar;

plan 16;

use Grammar::IETF::ABNF::RFC4234;

my Grammar $grammar = grammar TestGrammar does Grammar::IETF::ABNF::RFC4234_Core {};

subtest {
    plan 5;

    subtest {
        plan 52;

        for "a".."z" -> $letter {
            is_match($letter, 'ALPHA', $grammar);
        }
    }, 'lowercase';

    subtest {
        plan 52;

        for "A".."Z" -> $letter {
            is_match($letter, 'ALPHA', $grammar);
        }
    }, 'uppercase';

    subtest {
        plan 9;

        for 1..9 -> $number {
            not_match($number, 'ALPHA', $grammar);
        }
    }, 'not numbers';

    subtest {
        plan 1;

        not_match('é', 'ALPHA', $grammar);
    }, 'not unicode';

    subtest {
        plan 1;

        not_match('ab', 'ALPHA', $grammar);
    }, 'not two letters';
}, 'ALPHA';

subtest {
    plan 4;

    for 0, 1 ->  $binary {
        is_match($binary, 'BIT', $grammar);
    }
}, 'BIT';

subtest {
    plan 254;

    for "\x[01]".."\x[7F]" -> $char {
        is_match($char, 'CHAR', $grammar);
    }
}, 'CHAR';

subtest {
    plan 5;

    is_match("\x[0D]", 'CR', $grammar);
    is_match("\r", 'CR', $grammar);
    not_match("\n", 'CR', $grammar);
}, 'CR';

subtest {
    plan 7;

    is_match("\x[0D]\x[0A]", 'CRLF', $grammar);
    is_match("\r\n", 'CRLF', $grammar);
    not_match("\n\r", 'CRLF', $grammar);
    not_match("\n", 'CRLF', $grammar);
    not_match("\r", 'CRLF', $grammar);
}, 'CRLF';

subtest {
    plan 66;

    for ("\x[00]".."\x[1F]", "\x[7F]").flat -> $control_char {
        is_match($control_char, 'CTL', $grammar);
    }
}, 'CTL';

subtest {
    subtest {
        plan 18;

        for 1..9 -> $number {
            is_match($number, 'DIGIT', $grammar);
        }
    }, 'numbers';

    subtest {
        plan 52;

        for ("a".."z", "A".."Z").flat -> $letter {
            not_match($letter, 'DIGIT', $grammar);
        }
    }, 'not letters';

    subtest {
        plan 1;

        not_match('二', 'DIGIT', $grammar); # Unicode numeral
    }, 'not unicode';
}, 'DIGIT';

subtest {
    plan 4;

    is_match('"', 'DQUOTE', $grammar);

    subtest {
        plan 2;

        not_match('“', 'DQUOTE', $grammar);
        not_match('”', 'DQUOTE', $grammar);
    }, 'not unicode';

    subtest {
        plan 1;

        not_match("''", 'DQUOTE', $grammar);
    }, 'not two quotes';
}, 'DQUOTE';

subtest {
    plan 27;

    for "A".."F" -> $char {
        is_match($char, 'HEXDIG', $grammar);
    }

    for "a".."f" -> $char {
        is_match($char, 'HEXDIG', $grammar);
    }

    is_match(2, 'HEXDIG', $grammar); # We've already tested <DIGIT>

    not_match('X', 'HEXDIG', $grammar);
}, 'HEXDIG';

subtest {
    plan 5;

    is_match("\t", 'HTAB', $grammar);
    is_match("	", 'HTAB', $grammar);

    # Vertical Tab
    not_match("", 'HTAB', $grammar);
}, 'HTAB';

subtest {
    plan 5;

    is_match("\n", 'LF', $grammar);

    not_match("\r", 'LF', $grammar);
    not_match("\x[B]", 'LF', $grammar);
    not_match("\x[85]", 'LF', $grammar);
}, 'LF';

subtest {
    plan 4;

    is_match(' ', 'LWSP', $grammar);
    is_match("\r\n ", 'LWSP', $grammar);
}, 'LWSP';

subtest {
    plan 512;

    for "\x[00]".."\x[FF]" -> $octet {
        is_match($octet, 'OCTET', $grammar);
    }
}, 'OCTET';

subtest {
    plan 22;

    is_match(" ", 'SP', $grammar);

    not_match("\t", 'SP', $grammar);
    not_match(' ', 'SP', $grammar); # nbsp
    not_match("\x[1680]", 'SP', $grammar); # Ogham Space Mark
    not_match("\x[180E]", 'SP', $grammar); # Mongolian Vowel Separator
    not_match("\x[2000]", 'SP', $grammar); # EN Quad
    not_match("\x[2001]", 'SP', $grammar); # EM Quad
    not_match("\x[2002]", 'SP', $grammar); # EN Space
    not_match("\x[2003]", 'SP', $grammar); # EM Space
    not_match("\x[2004]", 'SP', $grammar); # Three-per-em space
    not_match("\x[2005]", 'SP', $grammar); # Four-per-em space
    not_match("\x[2006]", 'SP', $grammar); # Six-per-em Space
    not_match("\x[2007]", 'SP', $grammar); # Figure Space
    not_match("\x[2008]", 'SP', $grammar); # Punctuation Space
    not_match("\x[2009]", 'SP', $grammar); # Thin Space
    not_match("\x[200A]", 'SP', $grammar); # Hair Space
    not_match("\x[200B]", 'SP', $grammar); # Zero Width Space
    not_match("\x[202F]", 'SP', $grammar); # Narrow No-Break Space
    not_match("\x[205F]", 'SP', $grammar); # Mediam Mathematical Space
    not_match("\x[3000]", 'SP', $grammar); # Ideographic Space
    not_match("\x[FEFF]", 'SP', $grammar); # Zerp Wodth No-Break Space
}, 'SP';

subtest {
    plan 188;

    for "\x[21]".."\x[7E]" -> $char {
        is_match($char, 'VCHAR', $grammar);
    }
}, 'VCHAR';

subtest {
    plan 4;

    is_match(' ', 'WSP', $grammar);
    is_match("\t", 'WSP', $grammar);
}, 'WSP';
