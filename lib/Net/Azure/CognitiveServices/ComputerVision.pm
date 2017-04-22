package Net::Azure::CognitiveServices::ComputerVision;
use 5.008001;
use strict;
use warnings;
use base 'Net::Azure::CognitiveServices::Base::Feature';

our $VERSION  = "0.01";

sub path {'/vision/v1.0'};

sub _analyze_image_request {
    my ($self, $image_url, %param) = @_;
    $self->build_request(POST => ['analyze', %param], undef, {url => $image_url});
}

sub analyze_image {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_analyze_image_request($image_url, %param);
    my $data = $self->request($req);
    return $data;
}

sub _describe_image_request {
    my ($self, $image_url, %param) = @_;
    $self->build_request(POST => ['describe', %param], undef, {url => $image_url});
}

sub describe_image {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_describe_image_request($image_url, %param);
    my $data = $self->request($req);
    return $data;
}

sub _recognize_text_request {
    my ($self, $image_url, %param) = @_;
    $self->build_request(POST => ['recognizeText', %param], undef, {url => $image_url});
}

sub recognize_text {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_recognize_text_request($image_url, %param);
    my ($data, $headers) = $self->request($req);
    use Data::Dumper;
    warn Dumper($headers);
    $data->{'apim-request-id'} = $headers->header('Apim-Request-Id');
    return $data;
}

sub _get_handwritten_text_operation_request {
    my ($self, $operation_id) = @_;
    $self->build_request(GET => ["textOperation/$operation_id"]);
}

sub get_handwritten_text_operation {
    my ($self, $operation_id) = @_;
    my $req = $self->_get_handwritten_text_operation_request($operation_id);
    my $data = $self->request($req);
    return $data;
}

sub _thumbnail_request {
    my ($self, $image_url, %param) = @_;
    $self->build_request(POST => ["generateThumbnail", %param], undef, {url => $image_url});
}

sub thumbnail {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_thumbnail_request($image_url, %param);
    my $data = $self->request($req);
    return $data;
}

sub _list_domain_specific_models_request {
    my ($self) = @_;
    $self->build_request(GET => ["models"]);
}

sub list_domain_specific_models {
    my ($self) = shift;
    my $req = $self->_list_domain_specific_models_request;
    my $data = $self->request($req);
    return $data;
}

sub _ocr_request {
    my ($self, $image_url, %param) = @_;
    $self->build_request(POST => ["ocr", %param], undef, {url => $image_url});
}

sub ocr {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_ocr_request($image_url);
    my $data = $self->request($req);
    return $data;
}

sub _recognize_domain_specific_content_request {
    my ($self, $image_url, %param) = @_;
    my $model = $param{model};
    $self->build_request(POST => ["models/$model/analyze"], undef, {url => $image_url});
}

sub recognize_domain_specific_content {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_recognize_domain_specific_content_request($image_url, %param);
    my $data = $self->request($req);
    return $data;
}

sub _tag_request {
    my ($self, $image_url) = @_;
    $self->build_request(POST => ["tag"], undef, {url => $image_url});
}

sub tag {
    my ($self, $image_url) = @_;
    my $req = $self->_tag_request($image_url);
    my $data = $self->request($req);
    return $data;
}

1;
__END__

=encoding utf-8

=head1 NAME

Net::Azure::CognitiveServices::ComputerVision - A wrapper class for Computer Vision API of Azure Cognitive Services

=head1 SYNOPSIS

    use Net::Azure::CognitiveServices;
    my $cognitive = Net::Azure::CognitiveServices->new(
        access_key => 'YOUR_ACCESS_KEY',
        region     => 'westus',
    );
    my $cv = $cognitive->ComputerVision;
    my $metadata = $cv->analyze_image('http://image.to.example/image.jpg',
        visualFeatures => [qw/Categories Description Adult/],
        details        => [qw/Landmarks/],
        language       => 'en',
    );

=head1 DESCRIPTION



Please see L<https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236> for more information. 

=head1 METHODS

=head2 analyze

=head2 describe

=head2 get_handwritten_text_operation

=head2 thumbnail

=head2 list_domain_specific_models

=head2 ocr

=head2 recognize_domain_specific_content

=head2 recognize_text

=head2 tag

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

