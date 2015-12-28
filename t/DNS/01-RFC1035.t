use v6;
use Test;
use lib <t/lib>;
use TestLocal::Grammar;

plan 8;

use Grammar::IETF::DNS::RFC1035;

my Grammar $grammar = Grammar::IETF::DNS::RFC1035.new();

subtest {
    plan 106;

    for flat ('a'..'z', 'A'..'Z') -> $char {
        is_match($char, 'letter', $grammar);
    }

    not_match('AA', 'letter', $grammar);
    not_match(1, 'letter', $grammar);
}, 'letter';

subtest {
    plan 22;

    for 0..9 -> $digit {
        is_match($digit, 'digit', $grammar);
    }

    not_match("a", 'digit', $grammar);
    not_match(12, 'digit', $grammar);
}, 'digit';

subtest {
    plan 4;

    is_match(' ', 'domain', $grammar);
    is_match('a.b', 'domain', $grammar);
}, 'domain';

subtest {
    plan 10;

    is_match('A.ISI.EDU', 'subdomain', $grammar);
    is_match('XX.LCS.MIT.EDU', 'subdomain', $grammar);
    is_match('SRI-NIC.ARPA', 'subdomain', $grammar);

    # domain parts must start with a letter
    not_match('a234es.987123', 'subdomain', $grammar);

    # Domains must start with a letter
    not_match('1.123reg.com', 'subdomain', $grammar);
    not_match('2132', 'subdomain', $grammar);
    not_match('.dom1an29', 'subdomain', $grammar);
}, 'subdomain';

subtest {
    plan 11;

    is_match('foo', 'label', $grammar);
    is_match('aa', 'label', $grammar);
    is_match('foo-bar', 'label', $grammar);
    is_match('a', 'label', $grammar);

    not_match('1', 'label', $grammar);
    not_match(' ', 'label', $grammar);
    not_match('bar--foo-', 'label', $grammar);
}, 'label';

subtest {
    plan 10;

    is_match('-', 'ldh-str', $grammar);
    is_match('aa--', 'ldh-str', $grammar);
    is_match('bar1', 'ldh-str', $grammar);
    is_match('bar-222-333', 'ldh-str', $grammar);
    is_match('foo--bar', 'ldh-str', $grammar);
},'ldh-str';

subtest {
    plan 6;

    is_match('a', 'let-dig-hyp', $grammar);
    is_match(1, 'let-dig-hyp', $grammar);
    is_match('-', 'let-dig-hyp', $grammar);
}, 'let-dig-hyp';

subtest {
    plan 4;

    is_match('d', 'let-dig', $grammar);
    is_match(3, 'let-dig', $grammar);
}, 'let-dig';
