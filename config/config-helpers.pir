=head1 NAME

Glue.pir - Rakudo "glue" builtins (functions/globals) converted for NQP


=head1 SYNOPSIS

    # Load this library
    load_bytecode('src/lib/Glue.pbc');

    # I/O
    $contents := slurp($filename);
    spew(  $filename, $contents);
    append($filename, $contents);

    # Regular expressions
    $regex_object := rx($regex_source);
    @matches := all_matches($regex, $text);
    $edited := subst($original, $regex, $replacement);

    # Global variables;
    our $PROGRAM_NAME;
    our @ARGS;
    our %ENV;
    our %VM;
    our $OS;
    our $OSVER;

    
=cut

.namespace []

.include 'interpinfo.pasm'
.include 'sysinfo.pasm'
.include 'iglobals.pasm'


=head1 DESCRIPTION

=head2 Functions

=over 4

=item $contents := slurp($filename)

Read the C<$contents> of a file as a single string.

=cut

.sub 'slurp'
    .param string filename
    .local string contents

    $P0 = open filename, 'r'
    contents = $P0.'readall'()
    close $P0
    .return(contents)
.end


=item spew($filename, $contents)

Write the string C<$contents> to a file.

=cut

.sub 'spew'
    .param string filename
    .param string contents

    $P0 = open filename, 'w'
    $P0.'print'(contents)
    close $P0
.end


=item append($filename, $contents)

Append the string C<$contents> to a file.

=cut

.sub 'append'
    .param string filename
    .param string contents

    $P0 = open filename, 'a'
    $P0.'print'(contents)
    close $P0
.end


=item $regex_object := rx($regex_source)

Compile C<$regex_source> (a string representing the source code form of a
Perl 6 Regex) into a C<$regex_object>, suitable for using in C<match()> and
C<subst()>.

=cut

.sub 'rx'
    .param string source

    .local pmc p6regex, object
    p6regex = compreg 'PGE::Perl6Regex'
    object  = p6regex(source)

    .return(object)
.end

=item @matches := all_matches($regex, $text)

Find all matches (C<:g> style, not C<:exhaustive>) for C<$regex> in the
C<$text>.  The C<$regex> must be a regex object returned by C<rx()>.

=cut

.sub 'all_matches'
    .param pmc    regex
    .param string text

    # Find all matches in the original string
    .local pmc matches, match
    matches = root_new ['parrot';'ResizablePMCArray']
    match   = regex(text)
    unless match goto done_matching

  match_loop:
    push matches, match

    $I0   = match.'to'()
    match = regex(match, 'continue' => $I0)

    unless match goto done_matching
    goto match_loop
  done_matching:

    .return(matches)
.end


=item $edited := subst($original, $regex, $replacement)

Substitute all matches of the C<$regex> in the C<$original> string with the
C<$replacement>, and return the edited string.  The C<$regex> must be a regex
object returned by the C<rx()> function.

The C<$replacement> may be either a simple string or a sub that will be called
with each match object in turn, and must return the proper replacement string
for that match.

=cut

.sub 'subst'
    .param string original
    .param pmc    regex
    .param pmc    replacement

    # Find all matches in the original string
    .local pmc matches
    matches = all_matches(regex, original)

    # Do the substitutions on a clone of the original string
    .local string edited
    edited = clone original

    # Now replace all the matched substrings
    .local pmc match
    .local int offset
    offset = 0
  replace_loop:
    unless matches goto done_replacing
    match = shift matches

    # Handle either string or sub replacement
    .local string replace_string
    $I0 = isa replacement, 'Sub'
    if $I0 goto call_replacement_sub
    replace_string = replacement
    goto have_replace_string
  call_replacement_sub:
    replace_string = replacement(match)
  have_replace_string:

    # Perform the replacement
    $I0  = match.'from'()
    $I1  = match.'to'()
    $I2  = $I1 - $I0
    $I0 += offset
    substr edited, $I0, $I2, replace_string
    $I3  = length replace_string
    $I3 -= $I2
    offset += $I3
    goto replace_loop
  done_replacing:

    .return(edited)
.end

=item $joined := join($delimiter, @strings)

Join C<@strings> together with the specified C<$delimiter>.

=cut

.sub 'join'
    .param string delim
    .param pmc    strings

    .local string joined
    joined = join delim, strings

    .return (joined)
.end

=item @pieces := split($delimiter, $original)

Split the C<$original> string with the specified C<$delimiter>, which is not
included in the resulting C<@pieces>.

=cut

.sub 'split'
    .param string delim
    .param string original

    .local pmc pieces
    pieces = split delim, original

    .return (pieces)
.end

=back

=head2 Global Variables

=over 4

=item $PROGRAM_NAME

Name of running program (argv[0] in C)

=item @ARGS

Program's command line arguments (including options, which are NOT parsed)

=item %VM

Parrot configuration

=item %ENV

Process-wide environment variables

=item $OS

Operating system generic name

=item $OSVER

Operating system version

=back

=cut

.sub 'onload' :anon :load :init
    load_bytecode 'config.pbc'
    $P0 = getinterp
    $P1 = $P0[.IGLOBALS_CONFIG_HASH]
    $P2 = new ['Hash']
    $P2['config'] = $P1
    set_hll_global '%VM', $P2

    $P1 = $P0[.IGLOBALS_ARGV_LIST]
    if $P1 goto have_args
    unshift $P1, '<anonymous>'
  have_args:
    $S0 = shift $P1
    $P2 = box $S0
    set_hll_global '$PROGRAM_NAME', $P2
    set_hll_global '@ARGS', $P1

    $P0 = root_new ['parrot';'Env']
    set_hll_global '%ENV', $P0

    $S0 = sysinfo .SYSINFO_PARROT_OS
    $P0 = box $S0
    set_hll_global '$OS', $P0

    $S0 = sysinfo .SYSINFO_PARROT_OS_VERSION
    $P0 = box $S0
    set_hll_global '$OSVER', $P0
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
