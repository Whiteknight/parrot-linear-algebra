#!/usr/bin/env parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

See F<runtime/library/distutils.pir>.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $I0 = probe_include('cblas.h', 0 :named('verbose'))
    if $I0 == 0 goto L1
    say "no cblas.h"
    say "install libatlas-base-dev"
    end
  L1:

    $P0 = new 'Hash'
    $P0['name'] = 'parrot-linear-algebra'
    $P0['abstract'] = 'Linear Algebra Package for Parrot VM'
    $P0['authority'] = 'http://github.com/Whiteknight'
    $P0['description'] = 'Linear Algebra Package for Parrot VM.'
    $P1 = split ';', 'matrix;linear;algebra;gsl;atlas;blas;cblas'
    $P0['keywords'] = $P1
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Blair Sutton and Andrew Whitworth'
    $P0['checkout_uri'] = 'git://github.com/Whiteknight/parrot-linear-algebra.git'
    $P0['browser_uri'] = 'http://github.com/Whiteknight/parrot-linear-algebra'
    $P0['project_uri'] = 'http://github.com/Whiteknight/parrot-linear-algebra'

    # build
    $P2 = new 'Hash'
    $P3 = split "\n", <<'SOURCES'
src/pmc/nummatrix2d.pmc
src/pmc/pmcmatrix2d.pmc
src/pmc/charmatrix2d.pmc
src/pmc/complexmatrix2d.pmc
SOURCES
    $S0 = pop $P3
    $P2['linalg_group'] = $P3
    $P0['dynpmc'] = $P2
    'system_linker_settings'($P0)

    # test
    $S0 = get_nqp()
    $P0['harness_exec'] = $S0
    $P0['harness_files'] = 't/*.t t/pmc/*.t'

    # dist
    $P5 = glob('src/pmc/pla_matrix_types.h src/*.pir src/*.m examples/*.pir tools/nci/*.pl')
    $P0['manifest_includes'] = $P5

    .tailcall setup(args :flat, $P0 :flat :named)
.end

.sub 'system_linker_settings'
    .param pmc config
    $S0 = sysinfo 4
    if $S0 == "linux" goto have_linux

    # don't support other things yet.
    .return()

  have_linux:
    $I0 = spawnw "ldd /usr/lib/libblas.so"
    if $I0 != 0 goto try_2
    config['dynpmc_ldflags'] = "-lblas"
    .return()
  try_2:
    $I0 = spawnw "ldd /usr/lib/atlas/libcblas.so"
    if $I0 != 0 goto try_3
    config['dynpmc_ldflags'] = "-L/usr/lib/atlas -lcblas"
  try_3:
    # There is no try 3
    .return()
.end



# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
