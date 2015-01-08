use Map::Metro::Standard::Moops;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Plugin::Hook::PrettyPrinter

class Map::Metro::Plugin::Hook::PrettyPrinter using Moose {

    method register {
        before_add_routing => sub {

            my $self = shift;
            my $routing = shift;

            my $header = sprintf q{From %s to %s} => $routing->origin_station->name, $routing->destination_station->name;

            my @rows = ('', $header, '=' x length $header, '');

            my $route_count = 0;
            my $longest_length = 0;

            ROUTE:
            foreach my $route ($routing->ordered_routes) {

                my $line_name_length = $route->longest_line_name_length;
                $longest_length = $line_name_length if $line_name_length > $longest_length;

                push @rows => sprintf '-- Route %d (cost %s) ----------', ++$route_count, $route->weight;

                STEP:
                foreach my $step ($route->all_steps) {
                    push @rows =>  sprintf "[ %1s %-${line_name_length}s ] %s" => ($step->was_line_transfer && !$step->was_station_transfer ? '*' : ''),
                                                                                   $step->origin_line_station->line->name,
                                                                                   join '/' => $step->origin_line_station->station->name_with_alternative;
                    if($step->is_station_transfer) {
                        push @rows =>  sprintf "[ %1s %-${line_name_length}s ] %s" => ($step->is_station_transfer ? '+' : ''),
                                                                                   ' ' x length $step->origin_line_station->line->name,
                                                                                   join '/' => $step->destination_line_station->station->name_with_alternative;
                    }
                    if(!$step->has_next_step) {
                        push @rows =>  sprintf "[ %1s %-${line_name_length}s ] %s" => '',
                                                                                 $step->destination_line_station->line->name,
                                                                                 join '/' => $step->destination_line_station->station->name_with_alternative;
                    }
                }
                push @rows => '';
            }

            my @lines_in_routing = uniq sort { $a->name cmp $b->name } map { $_->origin_line_station->line } map { $_->all_steps } $routing->all_routes;

            LINE:
            foreach my $line (@lines_in_routing) {
                push @rows => sprintf "%-${longest_length}s  %s", $line->name, $line->description;
            }

            push @rows => '', '*: Transfer to other line', '+: Transfer to other station', '';

            say join "\n" => @rows;

        };
    }

}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Plugin::Hook::PrettyPrinter

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
