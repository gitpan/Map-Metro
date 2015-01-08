use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Graph::Connection
# ABSTRACT: What is a line?

class Map::Metro::Graph::Connection using Moose {

    has origin_line_station => (
        is => 'ro',
        isa => LineStation,
        required => 1,
    );
    has destination_line_station => (
        is => 'ro',
        isa => LineStation,
        required => 1,
    );
    has previous_connection => (
        is => 'rw',
        isa => Maybe[ Connection ],
        predicate => 1,
    );
    has next_connection => (
        is => 'rw',
        isa => Maybe[ Connection ],
        predicate => 1,
    );
    has weight => (
        is => 'ro',
        isa => Int,
        required => 1,
        default => 1,
    );
}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Graph::Connection - What is a line?

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 DESCRIPTION

Connections represent the combination of two specific L<LineStations|Map::Metro::Graph::LineStation>, and the 'cost' of
travelling between them.

In L<Graph> terms, a connection is a weighted edge.

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
