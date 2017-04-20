package Net::Azure::CognitiveServices::Face;
use 5.008001;
use strict;
use warnings;
use base 'Net::Azure::CognitiveServices::Base::API';

our $VERSION  = "0.01";

1;
__END__

=encoding utf-8

=head1 NAME

Net::Azure::CognitiveServices::Face - A wrapper class for Face API of Azure Cognitive Services

=head1 SYNOPSIS

    use Net::Azure::CognitiveServices;
    my $cognitive = Net::Azure::CognitiveServices->new(access_key => 'YOUR_ACCESS_KEY');

    ### Face - Detect
    my $face_api = $cognitive->Face->Face;
    my $result = $face_api->detect(
        "http://example.com/photo.jpg", 
        returnFaceAttributes => ['age', 'gender'],
    );
    printf "age: %d, gender: %d¥n", $result->[0]{faceAttributes}{age}, $result->[0]{faceAttributes}{gender};
    
    ### Person - List Persons in a PersonGroup
    my $person_api = Net::Azure::CognitiveServices::Face->Person;
    $result = $person_api->list('my_person_group');
    for my $person (@$result) {
        printf "name: %s, personId: %s¥n", $person->{name}, $person->{personId};
    }


=head1 DESCRIPTION

Net::Azure::CognitiveServices::Face provides following subclasses.

=over 4

=item Net::Azure::CognitiveServices::Face::Face

=item Net::Azure::CognitiveServices::Face::FaceList

=item Net::Azure::CognitiveServices::Face::Person

=item Net::Azure::CognitiveServices::Face::PersonGroup

=back 

Please see L<https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236> for more information. 

=head1 METHODS

=head2 access_key

Set the access key for accessing to Azure Cognitive Services APIs

=head2 Face

Returns an instance of Net::Azure::CognitiveServices::Face::Face

=head2 FaceList

Returns an instance of Net::Azure::CognitiveServices::Face::FaceList

=head2 Person

Returns an instance of Net::Azure::CognitiveServices::Face::Person

=head2 PersonGroup

Returns an instance of Net::Azure::CognitiveServices::Face::PersonGroup

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

