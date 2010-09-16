#!parrot-nqp
INIT {
    pir::load_bytecode('distutils.pbc');
    pir::load_bytecode('nqp-setting.pbc');
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
        :copyright_holder('Andrew Whitworth'),
        :checkout_uri('git://github.com/Whiteknight/parrot-linear-algebra.git'),
        :browser_uri('http://github.com/Whiteknight/parrot-linear-algebra'),
        :project_uri('http://github.com/Whiteknight/parrot-linear-algebra'),
        :version('1.0'),
        :setup('setup.nqp')
    );
    setup_PLA_keys(%PLA);
    my $mode;
    if +@argv == 0 {
        $mode := 'build';
    }
    else {
        $mode := @argv[0];
    }
    if $mode eq "test" {
        run_test_harness(%PLA);
        pir::exit__vI(0);
    } else {
        find_blas(%PLA);
        probe_for_cblas_h(%PLA);
        find_lapack(%PLA);
    }
    setup_test_manifest(%PLA);
    setup_c_library_files(%PLA);
    setup_dynpmc(%PLA);
    setup_testlib(%PLA);
    setup_nqp_bootstrapper(%PLA);
    setup_dynpmc_flags(%PLA);
    setup_docs(%PLA);
    setup_smolder(%PLA);

    setup(@argv, %PLA);
}

sub new_hash(*%hash) { %hash; }
sub new_array(*@array) { @array; }
sub get_args() {
    my $interp := pir::getinterp__P();
    $interp[2];
}

sub setup_test_manifest(%PLA) {
    %PLA{'prove_files'} :=
        "t/*.t t/pmc/*.t t/methods/nummatrix2d/*.t t/methods/pmcmatrix2d/*.t " ~
        "t/methods/complexmatrix2d/*.t t/pir-subclass/*.t";
}

sub setup_smolder(%PLA) {
    %PLA{'prove_exec'} := 'parrot-nqp t/run_test.nqp';
    %PLA{'smolder_url'} :=
        'http://smolder.parrot.org/app/projects/process_add_report/2';
    %PLA{'smolder_credentials'} := 'parrot-autobot:qa_rocks';
    my $blas := %PLA{'blas_lib'};
    my $lapack := %PLA{'lapack_lib'};
    my $cc := get_config(){'cc'};
    %PLA{'smolder_tags'} := ~$blas ~ "," ~ $lapack ~ "," ~ $cc;
    pir::say(%PLA{'smolder_tags'});
}

# final step, coerce the list of dynpmc ldflags into a string
sub setup_dynpmc_flags(%PLA) {
    %PLA{'dynpmc_ldflags'} := %PLA{'dynpmc_ldflags_list'}.join(' ');
    %PLA{'dynpmc_cflags'} := %PLA{'dynpmc_cflags_list'}.join(' ');
}

sub setup_PLA_keys(%PLA) {
    %PLA{'cc_dynpmc'} := new_hash();
    %PLA{'dynpmc_ldflags_list'} := new_array();
    %PLA{'dynpmc_cflags_list'} := new_array();
    %PLA{'inst_lib'} := new_array();
    %PLA{'pir_pir'} := new_hash();
    %PLA{'pir_pir'}{'t/testlib/pla_test.pir'} := new_array();
    %PLA{'need_cblas_h'} := 0;
    %PLA{'manifest_includes'} := new_array();
}

#
sub probe_for_cblas_h(%PLA) {
    if %PLA{'need_cblas_h'} {
        if probe_include("cblas.h", :verbose(1)) {
            pir::say("Cannot find cblas.h. This is required if you are using CBLAS or ATLAS");
            pir::exit(1);
        } else {
            %PLA{'dynpmc_cflags_list'}.push("-D_PLA_HAVE_CBLAS_H");
        }
    }
}

sub find_blas(%PLA) {
    my %config := get_config();
    my $osname := %config{'osname'};
    my $found_blas := 0;
    if $osname eq 'linux' {
        $found_blas := find_blas_linux(%PLA);
    }
    else {
        pir::say("Only Linux is currently supported");
        pir::exit(1);
    }
    if $found_blas == 0 {
        pir::say("Cannot find BLAS");
        pir::exit(1);
    }
}

sub find_blas_linux(%PLA) {
    my $found_blas := 0;
    my %searches;
    %searches{'libblas-3.so'} := ['-lblas-3', '-D_PLA_HAVE_BLAS', 0];
    %searches{'libblas.so'} := ['-lblas', '-D_PLA_HAVE_ATLAS', 1];
    %searches{'atlas/libcblas.so'} := ['-L/usr/lib/atlas -lcblas', '-D_PLA_HAVE_ATLAS', 1];
    for %searches {
        my $searchloc := $_;
        my $hasblas := find_lib_on_paths($searchloc);
        if $hasblas == 1 {
            $found_blas := 1;
            my @options := %searches{$searchloc};
            %PLA{'dynpmc_ldflags_list'}.push(@options[0]);
            %PLA{'dynpmc_cflags_list'}.push(@options[1]);
            %PLA{'need_cblas_h'} := @options[2];
            %PLA{'blas_lib'} := $searchloc;
            pir::say("=== PLA: Using BLAS library $searchloc");
            return $found_blas;
        }
    }
    return $found_blas;
}

sub find_lib_on_paths($lib) {
    # TODO: Allow the user to specify a location on the commandline
    my @paths := ["/usr/lib", "/usr/local/lib"];
    for @paths {
        my $path := $_;
        my $searchloc := ~$path ~ "/" ~ $lib;
        my $test_ldd := pir::spawnw__IS('ldd ' ~ $searchloc);
        if $test_ldd == 0 {
            return 1;
        }
    }
    return 0;
}


sub find_lapack(%PLA) {
    my %config := get_config();
    my $osname := %config{'osname'};
    %PLA{'lapack_lib'} := 'no-lapack';
    if $osname eq 'linux' {
        my %searches;
        %searches{'liblapack-3.so'} := ['-llapack-3', '-D_PLA_HAVE_LAPACK'];
        for %searches {
            my $searchloc := $_;
            my $haslapack := find_lib_on_paths($searchloc);
            if $haslapack == 1 {
                %PLA{'dynpmc_ldflags_list'}.push(%searches{$searchloc}[0]);
                %PLA{'dynpmc_cflags_list'}.push(%searches{$searchloc}[1]);
                %PLA{'lapack-lib'} := $searchloc;
                return;
            }
        }
    }
    # No LAPACK? No problem! We compile without it
}

sub run_test_harness(%PLA) {
    my $nqp := get_nqp();
    my $result := pir::spawnw__IS($nqp ~ " t/harness");
    pir::exit(+$result);
}

sub setup_c_library_files(%PLA) {
    register_step_before('build', compile_c_library_files);
    register_step_after('clean', clean_c_library_files);

    my @cfiles := <
        src/lib/matrix_common
        src/lib/math_common
        src/lib/pla_blas
    >;
    my $obj := get_obj();
    for @cfiles {
        %PLA{'dynpmc_ldflags_list'}.push($_ ~ $obj);
        %PLA{'manifest_includes'}.push($_ ~ '.c');
    }
    %PLA{'manifest_includes'}.push('src/include/pla.h');
    %PLA{'manifest_includes'}.push('src/include/pla_blas.h');
    %PLA{'manifest_includes'}.push('src/include/pla_lapack.h');
    %PLA{'manifest_includes'}.push('src/include/pla_matrix_library.h');
    %PLA{'manifest_includes'}.push('src/include/pla_matrix_types.h');

    %PLA{'cc_dynpmc'}{'linalg_group'} := @cfiles;
}

sub compile_c_library_files(*%args) {
    my @files := %args{'cc_dynpmc'}{'linalg_group'};
    my $obj := get_obj();
    my $cflags := get_cflags() ~ %args{'dynpmc_cflags'};
    my @prereqs := <
        cfile_goes_here
        src/include/pla.h
        src/include/pla_matrix_library.h
        src/include/pla_blas.h
        src/include/pla_lapack.h
    >;
    for @files {
        my $file := $_;
        my $objfile := $file ~ $obj;
        my $cfile := $file ~ ".c";
        @prereqs[0] := $cfile;
        unless newer($objfile, @prereqs) {
            __compile_cc($objfile, $cfile, $cflags);
        }
    }
}

sub clean_c_library_files(*%kv) {
    my @files := %kv{'cc_dynpmc'}{'linalg_group'};
    my $obj := get_obj();
    for @files {
        my $file := $_;
        my $objfile := $file ~ $obj;
        unlink($objfile, :verbose(1));
    }
}

sub setup_dynpmc(%PLA) {
    %PLA{'dynpmc_cflags_list'}.push('-g');
    %PLA{'dynpmc_cflags_list'}.push('-Isrc/include/');
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
    for @testlib {
        my $nqp_file := 't/testlib/' ~ $_ ~ '.nqp';
        my $pir_file := 't/testlib/' ~ $_ ~ '.pir';
        %PLA<pir_nqp-rx>{$pir_file} := $nqp_file;
        %PLA<pir_pir>{'t/testlib/pla_test.pir'}.push($pir_file);
    }
    %PLA{'pbc_pir'}{'t/testlib/pla_test.pbc'} := 't/testlib/pla_test.pir';
}

sub setup_nqp_bootstrapper(%PLA) {
    %PLA{'pir_nqp-rx'}{'src/nqp/pla.pir'} := 'src/nqp/pla.nqp';
    %PLA{'pbc_pir'}{'pla_nqp.pbc'} := 'src/nqp/pla.pir';
    %PLA{'inst_lib'}.push('pla_nqp.pbc');
}

sub setup_docs(%PLA) {
    %PLA{'html_pod'}{'docs/nummatrix2d.html'} := 'src/pmc/nummatrix2d.pmc';
    %PLA{'html_pod'}{'docs/pmcmatrix2d.html'} := 'src/pmc/pmcmatrix2d.pmc';
    %PLA{'html_pod'}{'docs/complexmatrix2d.html'} := 'src/pmc/complexmatrix2d.pmc';
}


