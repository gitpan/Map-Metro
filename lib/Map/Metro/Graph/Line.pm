use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Graph::Line
# ABSTRACT: What is a line?

class Map::Metro::Graph::Line using Moose {

    has id => (
        is => 'ro',
        isa => Str,
        required => 1,
    );
    has name => (
        is => 'ro',
        isa => Str,
        required => 1,
    );
    has description => (
        is => 'ro',
        isa => Str,
        required => 1,
    );
    has color => (
        is => 'rw',
        isa => Str,
        default => '#333333',
    );
    has width => (
        is => 'rw',
        isa => Int,
        default => 3,
    );

    around BUILDARGS($orig: $self, %args) {
        if($args{'id'} =~ m{([^a-z0-9])}i)  {
            Map::Metro::Exception::LineIdContainsIllegalCharacter::LineIdContainsIllegalCharacter->throw(line_id => $args{'id'}, illegal_character => $_, ident => 'parser: line_id');
        }
        $self->$orig(%args);
    }
}

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Graph::Line - What is a line?

=head1 VERSION

Version 0.2200, released 2015-01-08.

=head1 DESCRIPTION

Lines are currently only placeholders to identify the concept of a line. They don't have stations.

=head1 METHODS

=head2 id()

Returns the line id given in the parsed map file.

=head2 name()

Returns the line name given in the parsed map file.

=head2 description()

Returns the line description given in the parsed map file.

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
