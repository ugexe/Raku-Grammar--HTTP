unit module TestLocal::Grammar;
no precompilation;

use Test;

sub is_match (Cool $string, Str $rule, Grammar $grammar) is export {
    my $match = $grammar.parse($string, :rule($rule));

    ok($match, "「{safe_print($string)}」 matched rule: $rule");
    is($match.Str, $string, " - 『{safe_print($match.Str)}』returned for match of 「{safe_print($string.perl)}」");

    return $match;
}

sub not_match ( Cool $string, Str $rule, Grammar $grammar ) is export {
    my $match = $grammar.parse($string, :rule($rule));

    ok(!$match, "「{safe_print($string)}」 didn't match rule: $rule");
}

sub safe_print (Cool $string is copy) {
    if $string ~~ m/<[\x[00]..\x[1F]]>/ {
        # NFG for \r\n
        $string ~~ s:g/\x0D\x0A/\c[SYMBOL FOR CARRIAGE RETURN]\c[SYMBOL FOR LINE FEED]/;

        $string ~~ s:g/\x00/\c[SYMBOL FOR NULL]/;
        $string ~~ s:g/\x01/\c[SYMBOL FOR START OF HEADING]/;
        $string ~~ s:g/\x02/\c[SYMBOL FOR START OF TEXT]/;
        $string ~~ s:g/\x03/\c[SYMBOL FOR END OF TEXT]/;
        $string ~~ s:g/\x04/\c[SYMBOL FOR END OF TRANSMISSION]/;
        $string ~~ s:g/\x05/\c[SYMBOL FOR ENQUIRY]/;
        $string ~~ s:g/\x06/\c[SYMBOL FOR ACKNOWLEDGE]/;
        $string ~~ s:g/\x07/\c[SYMBOL FOR BELL]/;
        $string ~~ s:g/\x08/\c[SYMBOL FOR BACKSPACE]/;
        $string ~~ s:g/\x09/\c[SYMBOL FOR HORIZONTAL TABULATION]/;
        $string ~~ s:g/\x0A/\c[SYMBOL FOR LINE FEED]/;
        $string ~~ s:g/\x0B/\c[SYMBOL FOR VERTICAL TABULATION]/;
        $string ~~ s:g/\x0C/\c[SYMBOL FOR FORM FEED]/;
        $string ~~ s:g/\x0D/\c[SYMBOL FOR CARRIAGE RETURN]/;
        $string ~~ s:g/\x0E/\c[SYMBOL FOR SHIFT OUT]/;
        $string ~~ s:g/\x0F/\c[SYMBOL FOR SHIFT IN]/;
        $string ~~ s:g/\x10/\c[SYMBOL FOR DATA LINK ESCAPE]/;
        $string ~~ s:g/\x11/\c[SYMBOL FOR DEVICE CONTROL ONE]/;
        $string ~~ s:g/\x12/\c[SYMBOL FOR DEVICE CONTROL TWO]/;
        $string ~~ s:g/\x13/\c[SYMBOL FOR DEVICE CONTROL THREE]/;
        $string ~~ s:g/\x14/\c[SYMBOL FOR DEVICE CONTROL FOUR]/;
        $string ~~ s:g/\x15/\c[SYMBOL FOR NEGATIVE ACKNOWLEDGE]/;
        $string ~~ s:g/\x16/\c[SYMBOL FOR SYNCHRONOUS IDLE]/;
        $string ~~ s:g/\x17/\c[SYMBOL FOR END OF TRANSMISSION BLOCK]/;
        $string ~~ s:g/\x18/\c[SYMBOL FOR CANCEL]/;
        $string ~~ s:g/\x19/\c[SYMBOL FOR END OF MEDIUM]/;
        $string ~~ s:g/\x1A/\c[SYMBOL FOR SUBSTITUTE]/;
        $string ~~ s:g/\x1B/\c[SYMBOL FOR ESCAPE]/;
        $string ~~ s:g/\x1C/\c[SYMBOL FOR FILE SEPARATOR]/;
        $string ~~ s:g/\x1D/\c[SYMBOL FOR GROUP SEPARATOR]/;
        $string ~~ s:g/\x1E/\c[SYMBOL FOR RECORD SEPARATOR]/;
        $string ~~ s:g/\x1F/\c[SYMBOL FOR UNIT SEPARATOR]/;
    }

    return $string
}
