package Games::Angscum::TUI;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {};
    return bless $self, $class;
}

sub init {
    my $self = shift;
}

sub prompt {
    my $self = shift;
    print 'angscum> ';
    chomp(my $response = <STDIN>);
}

1;
