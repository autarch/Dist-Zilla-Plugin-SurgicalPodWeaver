# NAME

Dist::Zilla::Plugin::SurgicalPodWeaver - Surgically apply PodWeaver

# VERSION

version 0.002

# SYNOPSIS

In your [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla) `dist.ini`:

    [SurgicalPodWeaver]

To hint that you want to apply PodWeaver:

    package Xyzzy;
    # Dist::Zilla: +PodWeaver

    ...

# DESCRIPTION

Dist::Zilla::Plugin::SurgicalPodWeaver will only PodWeaver a .pm if:

    1. There exists an # ABSTRACT: ...
    2. The +PodWeaver hint is present

If either condition is satisfied, PodWeavering will be done.

You can forcefully disable PodWeaver on a .pm by using the `-PodWeaver` hint

# AUTHOR

Robert Krimen <robertkrimen@gmail.com>

# CONTRIBUTOR

Robert Krimen <rokr@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Robert Krimen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
