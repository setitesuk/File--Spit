#############
# Created By: setitesuk
# Created On: 2010-06-24

package File::Spit;
use strict;
use warnings;
use Carp;
use English qw{-no_match_vars};
use Readonly; Readonly::Scalar our $VERSION => 0.1;

use FileHandle;

use base qw{Exporter};
our @EXPORT = qw{spit}; ## no critic (Modules::ProhibitAutomaticExportation)

=head1 NAME

File::Spit

=head1 VERSION

0.1

=head1 SYNOPSIS

  use File::Spit;
  spit ( $FilePath, $data );
  spit ( $FilePath, $string, $break );

=head1 DESCRIPTION

This module exports the single function, 'spit' which handles writing out to your file any string/data.
Optionally, it can take a third arguement. If it is true, then it will append to the file. If it matches
a whitespace character (or string of them), it will use these as the delimiter between them. It will also
use any punctuation given as a delimiter.

=head1 SUBROUTINES/METHODS

=head2 spit

will croak if once it has a file_path and a possible delimiter, it finds no data (note, this is different from an empty string or 0)

delimiter - if the delimiter matches against /\A[\s:=,.\/;]+\z/xms, it will be used, else it will just append to the file
perl false values (undef, q{} or 0) will be classified as though there is no delimiter given

will croak if it fails to write, with value of $EVAL_ERROR

Write to file, killing any previous versions of file (note, no warnings)
  eval {
    spit ( $FilePath, $data );
  } or do {
    your error handling here...
  };

Append to file, creating if needed, but no delimiter

  eval {
    spit ( $FilePath, $string, 1 ); # note, it is just a true value, any perl false values will use write and kill previous file
  } or do {
    your error handling here...
  };

Append as above, but with delimiter

  eval {
    spit ( $FilePath, $string, qq{\n\n} );
  } or do {
    your error handling here...
  };

On success, this returns a true value (1)

=cut

sub spit { ## no critic (Subroutines::RequireArgUnpacking)

  my $file_path = shift @_;

  my $delimiter;
  if ( scalar @_ == 2 ) {
    $delimiter = pop @_;
  }

  if ( scalar @_ != 1 || ! defined $_[0] ) {
    croak q{no data to save out};
  }

  my $fh = FileHandle->new();

  if ( ! $delimiter ) {
    eval {
      $fh->open( qq{> $file_path} );
      print {$fh} $_[0] or croak qq{unable to write to $file_path};
      1;
    } or do {
      croak $EVAL_ERROR;
    };

    $fh->close();
    return 1;
  }

  eval {
    $fh->open( qq{>> $file_path} );
    if ( $delimiter =~ /\A[\s:=,.\/;]+\z/xms ) {
      print {$fh} $delimiter . $_[0] or croak qq{unable to write to $file_path};
    } else {
      print {$fh} $_[0] or croak qq{unable to write to $file_path};
    }
    1;
  } or do {
    croak $EVAL_ERROR;
  };

  $fh->close;

  return 1;

}

1;
__END__

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Carp

=item English -no_match_vars

=item File::Handle

=item Readonly

=item base

=item Exporter

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

Most code has bugs and/or limitations, and this code is likely no exception. Please contact me via RT if available, email if not if you have any problems, concerns, patches or updates.

=head1 AUTHOR

$Author$

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2010 Andy Brown (setitesuk@gmail.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
