package Dist::Zilla::Plugin::SurgicalPodWeaver;
# ABSTRACT: Surgically apply PodWeaver

=head1 SYNOPSIS

In your L<Dist::Zilla> C<dist.ini>:

    [SurgicalPodWeaver]

To hint that you want to apply PodWeaver:

    package Xyzzy;
    # Dist::Zilla: +PodWeaver

    ...

=head1 DESCRIPTION

Dist::Zilla::Plugin::SurgicalPodWeaver will only PodWeaver a .pm if:

    1. There exists an # ABSTRACT: ...
    2. The +PodWeaver hint is present

If either condition is satisfied, PodWeavering will be done.

You can forcefully disable PodWeaver on a .pm by using the C<-PodWeaver> hint

=cut

use Moose;
extends qw/ Dist::Zilla::Plugin::PodWeaver /;

sub parse_hint {
    my $self = shift;
    my $content = shift;

    my %hint;
    if ( $content =~ m/^\s*#+\s*(?:Dist::Zilla):\s*(.+)$/m ) {
        %hint = map {
            m/^([\+\-])(.*)$/ ?
                ( $1 eq '+' ? ( $2 => 1 ) : ( $2 => 0 ) ) :
                ()
        } split m/\s+/, $1;
    }

    return \%hint;
}

around munge_pod => sub {
    my $inner = shift;
    my ( $self, $file ) = @_;

    my $content = $file->content;

    my $yes = 0;
    if ( my $hint = __PACKAGE__->parse_hint( $content ) ) {
        if ( exists $hint->{PodWeaver} ) {
            return unless $hint->{PodWeaver};
            $yes = 1;
        }
    }

    return unless $yes || $content =~ m/^\s*#+\s*(?:ABSTRACT):\s*(.+)$/m;

    return $inner->( @_ )
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;
