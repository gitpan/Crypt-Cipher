package Crypt::Cipher;

# This package is the base package for all Crypt::Ciphers, providing 
# an encapsulated and easily inheritable framework for building 
# ciphers.  See the POD for more details on the user side.

# The implementation of this program is currently based on the
# Regexp::Tr class and inherits directly from there.


# Boilerplate package beginning
use 5.008;
use strict;
use warnings;
use Carp;

# Implementation-specific imports
use Regexp::Tr v0.03;

# UNIVERSAL class variables
our @ISA = qw(Regexp::Tr);
our $VERSION = '0.01';

BEGIN {
    *clean           = \&Regexp::Tr::flush;
    *encipher        = \&Regexp::Tr::trans;
    *encipher_string = \&encipher;
    *encipher_scalar = \&Regexp::Tr::bind;
}

sub encipher_list {
    my $self = shift;
    return map { scalar(Regexp::Tr::trans($self, $_)) } @_;
}

sub encipher_array {
    my($self,$ref) = @_;
    carp "Parameter passed is not an array ref" unless(ref($ref) eq "ARRAY");
    eval { map { scalar(Regexp::Tr::bind($self, \$_)) } @{$ref} };
    die "Error in encipher_array: $@" if($@);
}


return 1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Crypt::Cipher - Very flexible base class for text ciphers. 

=head1 SYNOPSIS

  # WITHIN MAIN
  use Crypt::Cipher;
  my $obj = Crypt::Cipher->new($domain,$mapping);      #Constructor
  my $storage = $obj->encipher("some string");         #String op
  $obj->encipher_scalar(\$some_scalar);                #Scalar ref op
  my @big_storage = $obj->encipher_list("2nd string",  #List operator
                                        "and another",
                                        "and more",   
                                        "yet more");
  $obj->encipher_array(\@some_array);                  #Array operator
  Crypt::Cipher->clean();                              #Memory cleanup
  
  # AS INHERITED BASE CLASS
  package Crypt::Cipher::NewCipher;
  @ISA = qw(Crypt::Cipher);
   
  sub new {
      my $class = shift;
      ...
      ...
      return Crypt::Cipher::new($class,$from,$to);
  }

  # Crypt::Cipher::NewCipher automatically creates all of the above
  # methods.

  # Aliasing example: make Crypt::Cipher::NewCipher::flush operate 
  # just like Crypt::Cipher::clean.
  BEGIN { *flush = *Crypt::Cipher::clean };  


=head1 ABSTRACT

Provides a standard interface and simple methods for ciphers of 
various kinds, saving on development time and redundant code.

=head1 DESCRIPTION

=head2 Use as an Independent Class

=over 4

=head3 Crypt::Cipher->new(PARAMLIST)

=over 4

This method is the constructor for the Crypt::Cipher class.  When
called as Crypt::Cipher->new(DOMAIN, MAPPING), it creates an object
mapping each letter in DOMAIN to its respective letter in MAPPING, 
as per the tr/// operator.

=back

=head3 $obj->bind(SCALARREF)

=over 4

This method takes a reference to a scalar (note that it does not 
B<create> the reference to the scalar) and performs the cipher upon 
the scalar it refers to.  It returns true if anything in the scalar 
was changed through the application of the cipher.

=back

=head3 $obj->trans(LIST)

=over 4

In scalar context, this method transliterates the first scalar in the 
list and returns the transliterated string in scalar context.  In list 
context, transliterates each element in the list and returns a new 
list consisting of the transliterated values.

=back

=head3 CLASS->clean()

=over 4

Performs operations to recover memory, which may or may not make a
substantial change in the speed of your code.

=back

=back

=head2 Use as a Base Class

=over 4

=head3 Default Use

=over 4

If you just want to use the methods provided to you by the class,
all you have to do is end your constructor with the following code
snippet:

    return Crypt::Cipher::new('Crypt::Cipher::NewClass',$from,$to);

Replace "Crypt::Cipher::NewClass" with your class's name, and $from
should contain the letters your cipher will change (aka: SEARCHLIST)
while $to should contain the letters your cipher will move things over
to (aka: REPLACEMENTLIST).

=back

=head3 Overloading

=over 4

If you want to overload a method (the "new" method is popular to
overload, as is the "clean" method), then just be sure to end your new
method with a call to this class's method.

    # Example
    sub encipher {
        my $obj = shift;
        ...
        return Crypt::Cipher::encipher($obj,@params);
    }

If you are trying to do something even fancier, please ensure that any
other impelementation of Crypt::Cipher or any other cipher built on 
Crypt::Cipher would still function using your code.

=back

=back

=head1 HISTORY

=over 8

=item 0.01

Original version; created by h2xs 1.22 with options

  -ABCX
	-n
	Crypt::Cipher

=back

=head1 SEE ALSO

=over 4

=item * B<L<Text::Shift>Z<>>: One cipher built on this system

=back 4


=head1 AUTHOR

Robert Fischer, E<lt>chia@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Robert Fischer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
