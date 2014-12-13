package Map::Metro::Plugin::Map;
$Map::Metro::Plugin::Map::VERSION = '0.1800';
use Moose::Role;
use Types::Path::Tiny 'AbsPath';

has mapfile => (
    is => 'ro',
    isa => AbsPath,
);

1;

=encoding utf-8

=head1 NAME

Map::Metro::Plugin::Map - How to make your own map

=head1 SYNOPSIS

    --stations
    Stadshagen
    Fridhemsplan
    Rådhuset
    T-Centralen

    # comments are possible
    Gamla stan
    Slussen
    Medborgarplatsen
    Skanstull
    Gullmarsplan
    Globen
    Sergels torg
    Nybroplan

    --transfers
    T-Centralen|Sergels torg|weight:4

    --lines
    10|T10|Blue line
    11|T11|Blue line
    19|T19|Green line
    7|L7|Spårväg city

    --segments
    10->,11<-|Stadshagen|Fridhemsplan
    10,11|Fridhemsplan|Rådhuset
    10,11|Rådhuset|T-Centralen
    10,11|T-Centralen|Kungsträdgården
    19|T-Centralen|Gamla stan
    19|Gamla stan|Slussen
    19|Slussen|Medborgarplatsen
    19|Medborgarplatsen|Skanstull
    19|Skanstull|Gullmarsplan
    19|Gullmarsplan|Globen
    7|Sergels torg|Nybroplan


=head1 DESCRIPTION

It is straightforward to create a map file. It consists of four parts:

=head2 --stations

This is a list of all stations in the network. Currently only one value per line. Don't use C<|> in station names.


=head2 --transfers

This is a list of L<Transfers|Map::Metro::Graph::Transfer>. If two stations share at least one line they are B<not> transfers. Three groups of data per line (delimited by C<|>):

=over 4

=item The first station.

=item The following station.

=item Optional options.

=back

The options in turn is a comma separated list of colon separated key-value pairs. Currently the only supported option is:

=over 4

=item weight. Integer. Set a custom weight for the 'cost' of making this transfer. Default value is 5. (Travelling between two
      stations on the same line cost 1, and changing lines at a station costs 3).

=back


=head2 --lines

This is a list of all lines in the network. Three values per line (delimited by C<|>):

=over 4

=item Line id (only a-z, A-Z and 0-9 allowed). Used in segments.

=item Line name. This should preferably be short(ish) and a common name for the line.

=item Line description. This can be a longer common name for the line.

=back


=head2 --segments

This is a list of all L<Segments|Map::Metro::Graph::Segment> in the network. (A segment is a pair of consecutive stations.) Three groups of data per line (delimited by C<|>):

* A list of line ids (comma delimited). This references the line list above. The list of line ids represents all lines travelling between the two stations.

* The first station.

* The following station

In the synopsis, one of the segments look like this:

   10->,11<-|Stadshagen|Fridhemsplan

The arrow notation describes the direction of travel (the default is both ways, all three can be combined in one segment definition).

C<-E<gt>> means that the line only travels I<from> Stadshagen I<to> Fridhemsplan.

C<E<lt>-> means that the line only travels I<from> Fridhemsplan I<to> Stadshagen.

=head1 WHAT NOW?

Start a distribution called C<Map::Metro::Plugin::Map::$city>.

Save the map file as C<map-$city.metro> in the C<share> directory.

Say we make a map for London; then C<Map::Metro::Plugin::Map::London> would look like this:

    package Map::Metro::Plugin::Map::London {

        use Moose;
        use File::ShareDir 'dist_dir';
        use Path::Tiny;
        with 'Map::Metro::Plugin::Map';

        has '+mapfile' => (
            default => sub { path(dist_dir('Map-Metro-Plugin-Map-London'))->child('map-london.metro')->absolute },
        );
    }

    1;

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
