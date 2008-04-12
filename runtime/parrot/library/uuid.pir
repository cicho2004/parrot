# Copyright (C) 2008, The Perl Foundation.
# $Id$

=head1 NAME

uuid.pir - minimalist uuid library

=head1 DESCRIPTION

See e2fsprogs/libuuid (ISO-C), UUID (Perl/XS)
L<http://e2fsprogs.sourceforge.net/>

=head2 Methods

=over 4

=cut


.namespace ['uuid']

.sub '__onload' :anon :load :init
    $P0 = subclass 'FixedIntegerArray', 'uuid'
.end

.const int N = 16

=item C<get_string>

=cut

.sub 'get_string' :vtable :method
    $S0 = sprintf '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x', self
    .return ($S0)
.end

=item C<time>

=cut

.sub 'time' :method
    .return (-1)
.end

=back

=head2 Functions

=over 4

=item C<generate_random>

=cut

.sub 'generate_random'
    .local pmc res
    new res, 'uuid'
    set res, N
    new $P0, 'Random'
    time $I0
    set $P0, $I0
    .local int i
    i = 0
  L1:
    unless i < N goto L2
    $N0 = $P0
    $N0 *= 256
    $I0 = floor $N0
    res[i] = $I0
    inc i
    goto L1
  L2:
    # variant
    $I0 = res[8]
    $I0 &= 0x3f
    $I0 |= 0x80
    res[8] = $I0
    # version
    $I0 = res[6]
    $I0 &= 0x0f
    $I0 |= 0x40
    res[6] = $I0
    .return (res)
.end

=item C<generate_time>

=cut

.sub 'generate_time'
    .local pmc res
    new res, 'uuid'
    set res, N
    new $P0, 'Random'
    time $I0
    set $P0, $I0
    .local int i
    i = 10
  L1:
    unless i < N goto L2
    $N0 = $P0
    $N0 *= 256
    $I0 = floor $N0
    res[i] = $I0
    inc i
    goto L1
  L2:
    $I0 = res[10]
    $I0 |= 0x01
    res[10] = $I0
    .return (res)
.end

=item C<generate>

=cut

.sub 'generate'
    .return 'generate_random'()
.end


=item C<parse>

=cut

.include 'cclass.pasm'

.sub 'parse'
    .param string target
    .local int pos, lastpos
    lastpos = length target
    unless lastpos == 36 goto L1
    pos = 0
    pos = find_not_cclass .CCLASS_HEXADECIMAL, target, pos, lastpos
    unless pos == 8 goto L1
    pos = index target, '-', pos
    unless pos == 8 goto L1
    inc pos
    pos = find_not_cclass .CCLASS_HEXADECIMAL, target, pos, lastpos
    unless pos == 13 goto L1
    pos = index target, '-', pos
    unless pos == 13 goto L1
    inc pos
    pos = find_not_cclass .CCLASS_HEXADECIMAL, target, pos, lastpos
    unless pos == 18 goto L1
    pos = index target, '-', pos
    unless pos == 18 goto L1
    inc pos
    pos = find_not_cclass .CCLASS_HEXADECIMAL, target, pos, lastpos
    unless pos == 23 goto L1
    pos = index target, '-', pos
    unless pos == 23 goto L1
    inc pos
    pos = find_not_cclass .CCLASS_HEXADECIMAL, target, pos, lastpos
    unless pos == 36 goto L1
    .local pmc res
    new res, 'uuid'
    set res, N
    .local int i
    i = 0
    $S0 = substr target, 0, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 2, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 4, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 6, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 9, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 11, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 14, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 16, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 19, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 21, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 24, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 26, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 28, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 30, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 32, 2
    $I0 = hex($S0)
    res[i] = $I0
    inc i
    $S0 = substr target, 34, 2
    $I0 = hex($S0)
    res[i] = $I0
    .return (0, res)
  L1:
    .return (-1)
.end

.sub 'hex' :anon
    .param string in
    .const string xdigits = '0123456789ABCDEF'
    upcase in
    $S1 = substr in, 0, 1
    $I1 = index xdigits, $S1
    $I1 *= 16
    $S2 = substr in, 1, 1
    $I2 = index xdigits, $S2
    $I1 += $I2
    .return ($I1)
.end


=back

=head1 AUTHORS

Francois Perrad

=cut


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

