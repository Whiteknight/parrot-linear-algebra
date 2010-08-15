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

.include 'iglobals.pasm'

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'parrot-linear-algebra'
    $P0['abstract'] = 'Linear Algebra Package for Parrot VM'
    $P0['authority'] = 'http://github.com/Whiteknight'
    $P0['description'] = 'Linear Algebra Package for Parrot VM.'
    $P1 = split ';', 'matrix;linear;algebra;gsl;atlas;blas;cblas'
    $P0['keywords'] = $P1
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'PLA Contributors'
    $P0['checkout_uri'] = 'git://github.com/Whiteknight/parrot-linear-algebra.git'
    $P0['browser_uri'] = 'http://github.com/Whiteknight/parrot-linear-algebra'
    $P0['project_uri'] = 'http://github.com/Whiteknight/parrot-linear-algebra'
    $P0['version'] = "0.1"

    # build
    $I0 = elements args
    if $I0 == 0 goto probe_files
    $S0 = args[0]
    if $S0 == "build" goto probe_files
    goto no_probe
  probe_files:
    'system_linker_settings'($P0)
    'probe for cblas.h'()
  no_probe:

    $P2 = new 'Hash'
    $P3 = split "\n", <<'SOURCES'
src/pmc/nummatrix2d.pmc
src/pmc/pmcmatrix2d.pmc
src/pmc/charmatrix2d.pmc
src/pmc/complexmatrix2d.pmc
src/pmc/matrixproxy.pmc
SOURCES
    $S0 = pop $P3
    $P2['linalg_group'] = $P3
    $P0['dynpmc'] = $P2

    $P2 = new 'Hash'
    $P2["src/nqp/pla.pir"] = "src/nqp/pla.nqp"
    $P0["pir_nqp-rx"] = $P2

    $P2 = new 'Hash'
    $P2["src/nqp/pla.pbc"] = "src/nqp/pla.pir"
    $P0["pbc_pir"] = $P2

    $S0 = args[0]
    if $S0 != "test" goto no_test
    $S0 = get_nqp()
    $S0 = $S0 . " t/harness"
    $I0 = spawnw $S0
    exit $I0
    # test
    #$S0 = get_nqp()
    #$S0 = $S0 . " t/harness"
    #$P0['test_exec'] = $S0
  no_test:


    # dist
    $P5 = glob('src/pmc/pla_matrix_types.h src/*.pir src/*.m examples/*.pir')
    $P0['manifest_includes'] = $P5

    .tailcall setup(args :flat, $P0 :flat :named)
.end

.sub 'system_linker_settings'
    .param pmc config

    config["dynpmc_cflags"] = "-g"

    $P0 = getinterp
    $P1 = $P0[.IGLOBALS_CONFIG_HASH]
    $S0 = $P1['osname']
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

.sub 'probe for cblas.h'
    $I0 = probe_include('cblas.h', 0 :named('verbose'))
    if $I0 == 0 goto L1
    say "no cblas.h"
    say "install libatlas-base-dev"
    end
  L1:
.end



# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
