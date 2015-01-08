use 5.20.0;

our $VERSION = '0.2200'; # VERSION

package Map::Metro::Standard::Moops {

    use base 'Moops';
    use List::AllUtils();
    use experimental();
    use Map::Metro::Types();
    use Eponymous::Hash();
    use List::Compare();
    use MooseX::SetOnce();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq/],
            'Eponymous::Hash'   => ['eh'],
            'String::Trim'      => ['trim'],
            'feature'           => [qw/:5.20/],
            'experimental'      => [qw/postderef/],
            'Map::Metro::Types' => [{ replace => 1 }, '-types'],
            'List::Compare'     => [],
            'MooseX::SetOnce'   => [],
        );

        $class->SUPER::import(%opts);
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Standard::Moops

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
