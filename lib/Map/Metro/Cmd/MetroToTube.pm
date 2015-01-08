use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Cmd::MetroToTube

class Map::Metro::Cmd::MetroToTube extends Map::Metro::Cmd using Moose {

    use MooseX::App::Command;
    use IO::File;
    use XML::Writer;

    parameter cityname => (
        is => 'rw',
        isa => Str,
        documentation => 'The name of the city',
        required => 1,
    );

    command_short_description 'Convert a Map::Metro map into a Map::Tube map';

    method run {

        my $graph = $self->cityname !~ m{\.} ? Map::Metro->new($self->cityname)->parse : Map::Metro::Shim->new($self->cityname)->parse;


        my $filename = sprintf 'map-%s-%s.xml', $self->cityname, time;
        my $io = IO::File->new($filename, '>');
        my $xml = XML::Writer->new(OUTPUT => $io, NEWLINES => 1, DATA_INDENT => 4, ENCODING => 'utf-8');
        $xml->xmlDecl('utf-8');
        $xml->startTag('tube', name => $self->cityname);
        $xml->startTag('stations');

        foreach my $station ($graph->all_stations) {
            my $line_names = join ',' => map { $_->name } sort { $a->name cmp $b->name } $station->all_lines;
            my $connecting_station_ids = join ',' => map { $_->id } $station->all_connecting_stations;
            $xml->emptyTag('station', id => $station->id, name => $station->name, line => $line_names, link => $connecting_station_ids);
        }
        $xml->endTag;
        $xml->endTag;
        $xml->end;
        $io->close;

        say "Saved in $filename.";
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Cmd::MetroToTube

=head1 VERSION

Version 0.2200, released 2015-01-08.

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
