use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices;

my $cognitive = Net::Azure::CognitiveServices->new(
    region     => $ENV{region},
    access_key => $ENV{access_key_cv},
);

my $cv = $cognitive->ComputerVision;
my $operation_id = $cv->recognize_text(
    'http://www.scottedelman.com/wordpress/wp-content/uploads/2011/03/PaulLevitzReject1.jpg', 
    handwritten => 'true'
);
my $data = $cv->poll_text_operation($operation_id);
isa_ok $data, 'HASH';

my @lines = $cv->extract_handwritten_texts($data);
is_deeply [@lines], [
    'Memo from',
    'Paul Levitz',
    '484 - 8513',
    'NO IN JOKE',
    'INDUSTRY',
    'STORIES PLEASE'
], "Text is array and it contains 'Memo from', 'Paul Levitz', '484 - 8513', 'NO IN JOKE', 'INDUSTRY', 'STORIES PLEASE'";

done_testing;