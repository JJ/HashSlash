use lib qw( ../lib lib ); # -*- cperl -*- 

use strict;
use warnings;

use Test::More;
use File::Slurp 'read_file';

# use Text::Hunspell;
use Text::Aspell;

BEGIN {
use_ok( 'Text::HashSlash' );
}

my $dict_dir;

if ( -e "/usr/share/hunspell/es.aff" ) {
  $dict_dir =  "/usr/share/hunspell";
} elsif  ( -e "data/es.aff" ) {
  $dict_dir = "data";
} else {
  $dict_dir = "../data";
}

# You can use relative or absolute paths.
# my $speller = Text::Hunspell->new(
# 				  "$dict_dir/es.aff",    # Hunspell affix file
# 				  "$dict_dir/es.dic"     # Hunspell dictionary file
# 				 );

my $speller = Text::Aspell->new;
die unless $speller;
$speller->set_option('lang','es');

my $hashslash = new Text::HashSlash;
my $dir = $hashslash->abs_dir();

diag( "Testing Text::HashSlash $Text::HashSlash::VERSION in $dir" );

$speller->set_option('personal',"$dir/.aspell.es.pws");

my $clean_text = $hashslash->text;
$clean_text =~  s/\{:.+?\}//g;
my @words = split /\s+/, $clean_text;
my $word_re = qr/([a-zA-Z'áéíóúÁÉÍÓÚñÑü]+)/;

my $prev_word = '';
for my $w (@words) {
  my ($stripped_word) = ( $w =~ $word_re );
  ok( $speller->check( $stripped_word), "Checking $prev_word $stripped_word in text")   if ( $stripped_word ) ;
  $prev_word = $stripped_word || '';
  
}

for my $a (keys %{$hashslash->appendices()}) {
  @words = split /\s+/, $hashslash->appendices()->{$a};
  for my $w (@words) {
    my ($stripped_word) = ( $w =~ $word_re );
    ok( $speller->check( $stripped_word), "Checking $stripped_word in $a") if ( $stripped_word ) ;
  }
}

done_testing();

