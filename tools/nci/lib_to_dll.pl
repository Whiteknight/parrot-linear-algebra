=head1 DESCRIPTION

This utility converts a static library file for Windows (.lib) to a
dynamic link library (.dll).

This utility should be run using a Visual Studio command shell as it requires
lib.exe, dumpbin.exe and cl.exe to be in the %PATH%.

Specifying "--debug" will generate debug binaries. 

lib_to_dll.pl [--debug] --libdir "C:\CLAPACK-3.1.1-VisualStudio\LIB\Win32" --name clapackd
                    --olib libf2c.lib --olib BLAS.lib [--outdir=c:\out]

=cut

use strict;
use File::Basename;
use File::Path;
use Getopt::Long;

my $debug = '';
my $LIBDIR = '';
my @otherlibs;
my $name = '';
my $outdir = '';

my $tempdir = $ENV{'TEMP'};

GetOptions("libdir=s" => \$LIBDIR, "name=s" => \$name, "debug"  => \$debug, "olib=s" => \@otherlibs, "outdir=s" => \$outdir);

die 'Usage: lib_to_dll.pl [--debug] --libdir "C:\CLAPACK-3.1.1-VisualStudio\LIB\Win32" --name clapackd' 
    if (! -d $LIBDIR || $name eq '');
    
chdir($outdir) if -d $outdir;

my $config = $debug ? 'DEBUG' : 'RELEASE';

my $workdir = "$tempdir\\lib_to_dll\\$config";
mkpath($workdir);

my $C = "$workdir\\$name.c";
my $DEF = "$workdir\\$name.def";
my $CL = "$workdir\\$name.args";

my $LIB = "$LIBDIR\\$name.lib";

my $OTHERLIBS;
for my $olib (@otherlibs) {
    $OTHERLIBS .= qq("$LIBDIR\\$olib"\n);
}

my $LIBEXE = 'lib.exe';
my $DUMPBINEXE = 'dumpbin.exe';
my $CLEXE = 'cl.exe';

my $c_data = <<'EOL';
#include <windows.h>
BOOL WINAPI DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}
EOL

my $switches = $debug ?  qq(/MT /ZI /Zp8) : qq(/MT /GL /Zp8);

my $generation_switches = qq(/EHsc /GF /Gy /Gm- /GS- /GR-  /GA /GT /Gd);
my $preprocessor_switches = qq(/D_WIN32_WINNT=0x0500 /DWINVER=0x0500 /D_WIN32_IE=0x0501 /DWIN32_LEAN_AND_MEAN=1 /DSECURITY_WIN32=1 /D_CRT_SECURE_NO_DEPRECATE=1 /D_CRT_NONSTDC_NO_DEPRECATE=1);

my $cl_data = <<EOL;
/nologo /Od /WX /LD /Fo$name.obj /Fe$name.dll /Fd$name.pdb $generation_switches $switches $preprocessor_switches
"$C"
EOL

# add object files to cc list
open my $objh, qq("$LIBEXE" /nologo /list "$LIB"|);
while (my $objfile = <$objh>) {
    chomp($objfile);
    my $outfile = "$workdir\\$objfile";
    my $dirname = dirname($outfile);
    mkpath($dirname);
    
    my $cmd = qq("$LIBEXE" /nologo /extract:"$objfile"  /out:"$outfile"  "$LIB");
    qx($cmd);
    
    $cl_data .= qq("$outfile"\n);

}
close $objh;

$cl_data .= <<EOL;
ws2_32.lib user32.lib wininet.lib advapi32.lib ole32.lib oleaut32.lib shell32.lib iphlpapi.lib odbc32.lib winmm.lib vfw32.lib gdi32.lib activeds.lib adsiid.lib secur32.lib
$OTHERLIBS
"$DEF"
/link /LIBPATH:.
EOL

# extract exports
#
my $def_data = qq(EXPORTS\n);
my $reached_public_symbols = 0;
open my $objh, qq("$DUMPBINEXE" /LINKERMEMBER:1 "$LIB"|);
while (my $member = <$objh>) {
    chomp($member);
    
    if ($member =~ /public symbols/) {
        $reached_public_symbols = 1;
        next;
    }
    
    next unless $reached_public_symbols;
    
    if ($member =~ /^\s+(\S+)\s+(\S+)\s*$/) {
        next if $2 =~ /^\?\?_C@/;
        next if $2 =~ /^\?/; # ignore c++ for now
        next if $2 =~ /@/;
        
        my ($symbol) = $2 =~ /^_(\S+)$/;
        
        $def_data .= "$symbol\n";
    }
}
close $objh;

# create the files
open my $fh, ">$C";
print $fh $c_data;
close $fh;

open my $fh, ">$DEF";
print $fh $def_data;
close $fh;

open my $fh, ">$CL";
print $fh $cl_data;
close $fh;

system(qq($CLEXE \@"$CL"));






