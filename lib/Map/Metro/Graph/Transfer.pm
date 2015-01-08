use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Graph::Transfer
# ABSTRACT: What is a transfer?

class Map::Metro::Graph::Transfer using Moose {

    has origin_station => (
        is => 'ro',
        isa => Station,
        required => 1,
    );
    has destination_station => (
        is => 'ro',
        isa => Station,
        required => 1,
    );
    has weight => (
        is => 'ro',
        isa => Int,
        default => 5,
    );

}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Graph::Transfer - What is a transfer?

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 DESCRIPTION

Transfers are used during the graph building phase. Its main purpose is to describe the combination of two L<Stations|Map::Metro::Graph::Station>
when the following holds true:

=over 4

=item There are no L<Lines|Map::Metro::Graph::Line> connecting the two stations.

=item The two stations are a common place for transfers:

=over 4

=item It could be the same physical station, but known under different
names for different types of transport.

=item It could be two subway stations on different lines known under different names.

=back

=back

=head1 SOURCE

L<https://github.com/Csson/p5-Map-Metro>

=head1 HOMEPAGE

L<https://metacpan.org/release/Map-Metro>

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
