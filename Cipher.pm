package Crypt::Cipher;

# This package is the base package for all Crypt::Ciphers, providing 
# an encapsulated and easily inheritable framework for building 
# ciphers.  See the POD for more details on the user side.

# The implementation of this program is currently based on the
# Regexp::Tr class and inherits from there.


# Boilerplate package beginning
use 5.008;
use strict;
use warnings;
use Carp;

BEGIN {
    eval { require Text::Cipher; };
    carp "Please upgrade Crypt::Cipher to Text::Cipher.\n" if($@);
}

# UNIVERSAL class variables
our @ISA = qw(Text::Cipher);
our $VERSION = '0.03';

return 1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Crypt::Cipher - Depreciated -- see Text::Cipher

=head1 ABSTRACT

Provides a standard interface and simple methods for ciphers of 
various kinds, saving on development time and redundant code.

This class has now been replaced with L<Text::Cipher>.  For 
compatability purposes, this class is now an infintesimally thin 
wrapper around that class.

=head1 SEE ALSO

=over 4

=item * B<L<Text::Cipher>Z<>>: The newest edition.

=back 4


=head1 AUTHOR

Robert Fischer, E<lt>chia@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Robert Fischer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
