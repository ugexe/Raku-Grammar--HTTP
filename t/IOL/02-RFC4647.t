use v6;
use Test;
use lib <t/lib>;
use TestLocal::Grammar;

use Grammar::IETF::IOL::RFC4647;

my Grammar $grammar = Grammar::IETF::IOL::RFC4647.new();

plan 1;

subtest {
    plan 11;

    is_match('en', 'language-range', $grammar);
    is_match('en-gb', 'language-range', $grammar);
    is_match('en-gb-cockney1', 'language-range', $grammar);
    is_match('*', 'language-range', $grammar);

    not_match('thishastomanyletters', 'language-range', $grammar);
    not_match('-gb', 'language-range', $grammar);
    not_match('en-*', 'language-range', $grammar);
}, 'language-range';
