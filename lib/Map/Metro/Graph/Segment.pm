use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Graph::Segment
# ABSTRACT: What is a segment?

class Map::Metro::Graph::Segment using Moose {

    has line_ids => (
        is => 'ro',
        isa => ArrayRef[Str],
        traits => ['Array'],
        required => 1,
        default => sub { [] },
        handles => {
            all_line_ids => 'elements',
        }
    );
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
    has is_one_way => (
        is => 'ro',
        isa => Bool,
        default => 0,
    );

}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Graph::Segment - What is a segment?

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 DESCRIPTION

Segments are used during the graph building phase. Its purpose is to describe the combination of two L<Stations|Map::Metro::Graph::Station>
and all L<Lines|Map::Metro::Graph::Line> that go between them.

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
