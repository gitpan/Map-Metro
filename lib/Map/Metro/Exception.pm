use 5.20.0;
use warnings;

our $VERSION = '0.2200'; # VERSION
# PODNAME: Map::Metro::Exception

# Insired by Throwable::X
package Map::Metro::Exception {

    use Moose::Role;
    use Throwable::X::Types;

    use namespace::clean -except => 'meta';

    use Sub::Exporter -setup => {
        exports => { Payload => \'__payload' },
    };

    sub __payload {
        sub {
            'Role::HasPayload::Meta::Attribute::Payload';
        }
    }

    sub out {
        my $self = shift;
        say $self->message;
        say '';
        say $self->stack_trace;
        return $self;
    }
    sub fatal {
        die;
    }
    with(
        'Throwable',
        'StackTrace::Auto',
        'Role::HasPayload::Merged',
        'Role::HasMessage::Errf' => {
            default => sub { $_[0]->info },
            lazy => 1,
        }
    );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Map::Metro::Exception

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
