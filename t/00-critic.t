package critic;
use strict;
use warnings;
use Test::More;
use English qw(-no_match_vars);

our $VERSION = do { my @r = (q$LastChangedRevision: 5780 $ =~ /\d+/mxg); sprintf '%d.'.'%03d' x $#r, @r };

if (!$ENV{TEST_AUTHOR}) {
  my $msg = 'Author test.  Set $ENV{TEST_AUTHOR} to a true value to run.';
  plan( skip_all => $msg );
}

eval {
  require Test::Perl::Critic;
};

if($EVAL_ERROR) {
  plan skip_all => 'Test::Perl::Critic not installed';

} else {
  Test::Perl::Critic->import(
			     -severity => 1,
			     -exclude => [qw{
			       tidy
			       ValuesAndExpressions::ProhibitImplicitNewlines
			       Miscellanea::RequireRcsKeywords
			       Documentation::RequirePodAtEnd
			     }],
			     -profile => 't/perlcriticrc',
			    );
  all_critic_ok();
}

1;
