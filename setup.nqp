INIT {
    pir::load_bytecode('distutils.pbc');
}

MAIN(get_args());

sub MAIN(@argv) {
    my $name := pir::shift(@argv);
    my %PLA := new_hash(
        :name('parrot-linear-algebra'),
        :abstract('Linear Algebra Package for Parrot VM'),
        :authority('http://github.com/Whiteknight'),
        :description('Linear Algebra Package for Parrot VM.'),
        :keywords(<matrix linear algebra gsl atlas blas cblas>),
        :license_type('Artistic License 2.0'),
        :license_uri('http://www.perlfoundation.org/artistic_license_2_0'),
        :copyright_holder('PLA Contributors'),
        :checkout_uri('git://github.com/Whiteknight/parrot-linear-algebra.git'),
        :browser_uri('http://github.com/Whiteknight/parrot-linear-algebra'),
        :project_uri('http://github.com/Whiteknight/parrot-linear-algebra'),
        :version("0.1")
    );
    my $mode;
    if +@argv == 0 {
        $mode := 'build';
    }
    else {
        $mode := @argv[0];
    }
    if $mode eq "build" {
        probe_for_cblas(%PLA);
        system_linker_settings(%PLA);
    }
    if $mode eq "test" {
        run_test_harness(%PLA);
        pir::exit__vI(0);
    }
    setup_dynpmc_sources(%PLA);
    setup_testlib(%PLA);
    setup_nqp_bootstrapper(%PLA);

    setup(@argv, %PLA);
}

sub new_hash(*%hash) { %hash; }
sub get_args() {
    my $interp := pir::getinterp__P();
    $interp[2];
}

sub probe_for_cblas(%PLA) {
    if probe_include("cblas.h", :verbose(0)) {
        pir::say("Cannot find cblas.h\nPlease install libatlas-base-dev");
        pir::exit__vI(1);
    }
}

sub system_linker_settings(%PLA) {
    %PLA{'dynpmc_cflags'} := '-g';
    my %config := get_config();
    my $osname := %config{'osname'};
    if $osname eq 'linux' {
        my %searches;
        %searches{'/usr/lib/libblas.so'} := '-lblas';
        %searches{'/usr/lib/atlas/libcblas.so'} := '-L/usr/lib/atlas -lcblas';
        for %searches {
            my $searchloc := $_;
            my $test_ldd := pir::spawnw__IS('ldd ' ~ $searchloc);
            if $test_ldd == 0 {
                %PLA{'dynpmc_ldflags'} := %searches{$searchloc};
                return;
            }
        }
    }
    else {
        pir::say("Only Linux is currently supported");
        pir::exit(1);
    }
}

sub run_test_harness(%PLA) {
    my $nqp := get_nqp();
    my $result := pir::spawnw__IS($nqp ~ " t/harness");
    pir::exit(+$result);
}

sub setup_dynpmc_sources(%PLA) {
    %PLA{'dynpmc'}{'linalg_group'} := <
        src/pmc/nummatrix2d.pmc
        src/pmc/pmcmatrix2d.pmc
        src/pmc/complexmatrix2d.pmc
    >;
}

sub setup_testlib(%PLA) {
    my @testlib := <
        matrixtestbase
        matrixtest
        numericmatrixtest
        loader
        matrixtestfactory
        methods/convert_to_complex_matrix
        methods/convert_to_number_matrix
        methods/convert_to_pmc_matrix
        methods/fill
        methods/gemm
        methods/get_block
        methods/initialize_from_args
        methods/initialize_from_array
        methods/item_at
        methods/iterate_function_external
        methods/iterate_function_inplace
        methods/mem_transpose
        methods/resize
        methods/row_combine
        methods/row_scale
        methods/row_swap
        methods/set_block
        methods/transpose
    >;
    %PLA<pir_pir>{'t/testlib/pla_test.pir'} := <>;
    for @testlib {
        my $nqp_file := 't/testlib/' ~ $_ ~ '.nqp';
        my $pir_file := 't/testlib/' ~ $_ ~ '.pir';
        %PLA<pir_nqp-rx>{$pir_file} := $nqp_file;
        pir::push__vPP(%PLA<pir_pir>{'t/testlib/pla_test.pir'}, $pir_file);
    }
    %PLA{'pbc_pir'}{'t/testlib/pla_test.pbc'} := 't/testlib/pla_test.pir';
}

sub setup_nqp_bootstrapper(%PLA) {
    %PLA{'pir_nqp-rx'}{'src/nqp/pla.pir'} := 'src/nqp/pla.nqp';
    %PLA{'pbc_pir'}{'pla_nqp.pbc'} := 'src/nqp/pla.pir';
    %PLA{'inst_lib'} := <pla_nqp.pbc>;
}


