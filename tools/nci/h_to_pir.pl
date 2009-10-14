=head1 DESCRIPTION

This utility converts a C header file created using f2c into a pir library and an nci
signature file.

The output nci file contains signatures that currently need adding to the parrot call list
<parrot source>/config/gen/call_list/misc.in. 


h_to_dll.pl --name clapack --headerfile ./extern/include/clapack.h 
    --outputpir ./extern/pir/clapack.pir --outputnci ./extern/pir/clapack.nci
       [--libsymformat "f2c_%s"] [--ncihints ./extern/include/clapack.hints]

=cut


use strict;
use File::Basename;
use File::Path;
use Getopt::Long;

my $output_pir; 
my $nci_signatures;
my $name;
my $header_file;
my $symformat = '%s_'; # if given prefixes external symbol with prefix 
my $nci_hints_file;

GetOptions("headerfile=s" => \$header_file, "name=s" => \$name, 
    "outputpir=s" => \$output_pir, "outputnci=s" => \$nci_signatures,
    "libsymformat=s" => \$symformat, "ncihints=s" => \$nci_hints_file);

die "h_to_dll.pl --name clapack --headerfile ./extern/include/clapack.h --outputpir ./extern/pir/clapack.pir --outputnci ./extern/pir/clapack.nci" 
    if (!-f $header_file || $name eq '' || $output_pir eq '' || $nci_signatures eq '');


# note: L_fp ~ function pointer, for now leave as pmc
my %nci_typemap = qw(
int i
integer* 3
integer i
logical* 3
char* t
real* p
real f
doublereal* p
doublereal d
complex* p
doublecomplex* p
VOID v
void v
L_fp p
);

sub get_nci_code {
    die "Can't find type '$_[0]'!" if not exists $nci_typemap{$_[0]};
    return $nci_typemap{$_[0]};
}

my %nci_hints;
if (-f $nci_hints_file) {
    open my $fh, $nci_hints_file or die "cannot open file: $!";
    while (my $line = <$fh>) {
        my ($fname, $fsig) = ( $line =~ m/^(\S+):(\S+)\r?$/); 
        $nci_hints{$fname} = $fsig;
    }
    close $fh;
}

my %nci_sigs;

my @pir_raw_funcs;
my @pir_raw_header;

push @pir_raw_header, <<EOD1;
.include 'library/dumper.pir'
.include 'datatypes.pasm'

.sub '_init' :load
  .local pmc lib, func

  \$P0 = new 'ResizablePMCArray'
  \$S1 = sysinfo 4
  \$S2 = sysinfo 7
  push \$P0, \$S2
  push \$P0, \$S1
  \$S0 = sprintf "extern/lib/%s-%s/$name", \$P0

  lib = loadlib \$S0
  if lib goto loaded_ok
  \$P0 = new 'Exception'
  \$P1 = new 'ResizablePMCArray'
  push \$P1, \$S0
  \$S1 = sprintf "library failed to load: ensure path '%s' exists!\\n", \$P1
  printerr \$S1
  throw \$P0
loaded_ok:
EOD1

push @pir_raw_funcs, <<EOD2;

.namespace ['$name';'RAW']

EOD2

open my $fh, $header_file or die "cannot find file: $!";
local $/ = ";";
my $c = 0;
while (my $rec = <$fh>) {

#last if $c++ == 5;
 
$rec =~ s/\n/ /mg;
$rec =~ s/\s+/ /mg;

my ($ret, $fname, $args) = $rec =~ m/^(?:.* |)(\S+) (\S+)_\((.*)\).*$/s;

# there's a better way to check if we reach the end!
last if $fname eq ''; 

push @pir_raw_funcs, 
    qq|.sub '$fname'|;
    
my $nci_sig = get_nci_code($ret);
my @dlargs;
foreach my $arg (split(/,/, $args)) {
    my ($ftype, $mod, $pname) = $arg =~ m/^\s*(\S+)\s+(\**)\s*(\S+)\s*$/;
    $nci_sig .= get_nci_code($ftype.$mod);
    push @pir_raw_funcs, qq|  .param pmc $pname|;
    push @dlargs, $pname;
}

# override signature if in hints
if (exists $nci_hints{$fname}) {
    $nci_sig = $nci_hints{$fname};
}

my $symbolname = sprintf($symformat, $fname);

push @pir_raw_header, <<EOD3; 
  func = dlfunc lib, '$symbolname', '$nci_sig'
  set_hll_global ['$name';'RAW'], '_$fname', func  
EOD3

# misc.in pads spaces between return param and others
$nci_sig =~ s/^(\S)(\S*)$/$1    $2/;
$nci_sigs{$nci_sig} = undef;

my $dlargs_list = join(',',@dlargs);
push @pir_raw_funcs, <<EOD4; 

   \$P0 = find_name '_$fname'
   \$I0 = defined \$P0
   if \$I0 goto do_fn

    \$P10 = new 'Exception'
    printerr "cannot find function!\\n"
    throw \$P10
   

 do_fn:
  .local int _return
  _return = \$P0($dlargs_list)
  .return(_return)
.end
EOD4


}
close $fh;

push @pir_raw_header, 
    qq|.end|;

    
# dump contents into files
#
open my $fh, ">$output_pir" or die "cannot open file: $!";
print $fh join("\n", @pir_raw_header, "\n", @pir_raw_funcs, "\n");
close $fh;

open my $fh, ">$nci_signatures" or die "cannot open file: $!";
print $fh join("\n", keys(%nci_sigs), "\n");
close $fh;
