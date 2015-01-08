use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Graph::Step
# ABSTRACT: What is a step?

class Map::Metro::Graph::Step using Moose {

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
    has previous_step => (
        is => 'rw',
        isa => Maybe[ Step ],
        predicate => 1,
    );
    has next_step => (
        is => 'rw',
        isa => Maybe[ Step ],
        predicate => 1,
    );
    has weight => (
        is => 'ro',
        isa => Int,
        required => 1,
        default => 1,
    );

    around BUILDARGS($orig: $class, %args) {
        return $class->$orig(%args) if !exists $args{'from_connection'};

        my $conn = $args{'from_connection'};
        return if !defined $conn;

        return $class->$orig(
            origin_line_station => $conn->origin_line_station,
            destination_line_station => $conn->destination_line_station,
            weight => $conn->weight,
        );
    }

    method is_line_transfer {
        return $self->origin_line_station->station->id == $self->destination_line_station->station->id;
        return $self->origin_line_station->line->id ne $self->destination_line_station->line->id;
    }
    method is_station_transfer {
        my $origin_station_line_ids = [ map { $_->id } $self->origin_line_station->station->all_lines ];
        my $destination_station_line_ids = [ map { $_->id } $self->destination_line_station->station->all_lines ];

        my $are_on_same_line = List::Compare->new($origin_station_line_ids, $destination_station_line_ids)->get_intersection;

        return !$are_on_same_line;
    }
    method was_line_transfer {
        return if !$self->has_previous_step;
        return $self->previous_step->is_line_transfer;
    }
    method was_station_transfer {
        return if !$self->has_previous_step;
        return $self->previous_step->is_station_transfer;
    }
}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Graph::Step - What is a step?

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 DESCRIPTION

Steps are exactly like L<Connections::Map::Metro::Graph::Connection>, in that they describe the combination of two
specific L<LineStations|Map::Metro::Graph::LineStation>, and the 'cost' of travelling between them, but with an important
difference: A Step is part of a specific L<Route|Map::Metro::Graph::Route>.

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
