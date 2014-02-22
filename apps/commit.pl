#!/usr/bin/env perl

use strict;
use warnings;

use Git;
use File::Slurp qw(read_file write_file);
use Cwd;

use v5.12;

my $comment = shift || "No comment";
my $this_dir = getcwd;
my $words=  'texto/.aspell.es.pws';
my $file_name = ( -e "$this_dir/$words")? "$this_dir/$words": "../texto/.aspell.es.pws";

my $git = Git->repository;

my $branch =  $git->command(qw/rev-parse --abbrev-ref HEAD/);
say "Pre-commit hook (falso) en $branch";
if ( $branch =~ /muerta/ ) {
  my $changed = $git->command(qw/diff --name-status/);
  my @changed_files = ($changed =~ /\s*\w\s+(\S+)/g);
  if ( $words ~~ @changed_files ) {
    my @palabras = read_file($file_name);
    $palabras[0] =~ s/es (\d+) /es $#palabras /;
    write_file( $file_name, @palabras);
  }
  $git->command( "commit", "-a", "-m", $comment );
  $git->command( "push" );
}


=head1 NAME

commit.pl - process stuff and eventually do a commit and push

=head2 SYNOPSIS

First you need to install C<File::Slurp>. I use say,
so you will need perl > 5.10. Besides, you need to locate Git.pm and
copy it where this script can find it. That depends on the OS and perl
installation you're using (I use perlbrew), In my case it was:

  bash% cp /usr/share/perl5/Git.pm ~/perl5/perlbrew/perls/perl-5.16.1/lib/site_perl/5.16.1/

Then it's just

  bash% ./commit.pl

To process the C<words.dic > file and generate and change other files
before doing a commit and eventually do it. 

=head1 LICENSE

This is released under the Artistic 
License. See L<perlartistic>.

=head2 AUTHOR

JJ Merelo, L<jj@merelo.net>
