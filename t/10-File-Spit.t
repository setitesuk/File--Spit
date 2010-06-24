use strict;
use warnings;
use Carp;
use English qw{-no_match_vars};
use Test::More 'no_plan';#tests => ;
use Test::Exception;
use File::Temp qw{tempdir};
use Perl6::Slurp;

my $tmp_dir = tempdir(
    DIR => q{/tmp},
    CLEANUP => 1,
  );

diag $tmp_dir;

BEGIN {
  use_ok(q{File::Spit});
}

{
   throws_ok { spit (); } qr{no[ ]data[ ]to[ ]save[ ]out}, q{spit method called with no arguements};

   my $file_path = $tmp_dir . q{/test.txt};

   throws_ok { spit ( $file_path, undef); } qr{no[ ]data[ ]to[ ]save[ ]out}, q{spit method called with undef in data arguement};

   my $text = q{I didn't want Ipsum Lorem};

   lives_ok {
     spit ( $file_path, $text );
   } q{no croak - file_path and some text};
   is( slurp( $file_path ), $text, q{text is in file} );

   my $result = $text . $text;
   lives_ok {
     spit ( $file_path, $text, 1 );
   } q{no croak - file_path, text and append is true};
   is( slurp ( $file_path ), $result, q{text is appended to file});

   $result .= qq{\t\n$text};
   lives_ok {
     spit ( $file_path, $text, qq{\t\n} );
   } q{no croak - file_path, text and append with tab delimiter};
   is( slurp ( $file_path ), $result, q{text is tab appended} );

   lives_ok {
     spit ( $file_path, $text );
   } q{no croak - file_path and some text - write and destroy previous};
   is( slurp( $file_path ), $text, q{correct text is in file} );

}
1;