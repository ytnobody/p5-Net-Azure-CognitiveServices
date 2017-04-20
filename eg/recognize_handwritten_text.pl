use strict;
use warnings;
use Net::Azure::CognitiveServices;
use Data::Dumper;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ARGV[0],
    access_key => $ARGV[1],
);

my $cv = $cognitive->ComputerVision;
my $recognized = $cv->recognize_text(
    'http://isuta.jp/category/iphone/wp-content/tmp/vol/2013/03/memo2.jpg', 
    handwritten => 'true'
);

warn Dumper($recognized);