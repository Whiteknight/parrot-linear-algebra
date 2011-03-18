#! parrot-nqp
INIT {
    pir::load_bytecode('rosella/test.pbc');
    pir::load_bytecode('t/testlib/pla_test.pbc');
}

my $interp := pir::getinterp__P();
my @argv := $interp[2];
MAIN(@argv);

sub MAIN(@argv) {
    my $test := @argv.shift;
    if $test ne 't/sanity.t' {
        my $pla := pir::loadlib__ps("./dynext/linalg_group");
    }
    compile_and_execute($test);
}

sub is_pir_test($filename) {
    my $idx := pir::index__ISS($filename, 't/pir');
    if $idx == 0 {
        return 1;
    }
    return 0;
}

sub compile_pir_test($filename) {
    my $sub;
    Q:PIR {
        $P1 = find_lex "$filename"
        $P0 = new ['FileHandle']
        $P0.'open'($P1)
        $P2 = $P0.'readall'()
        $P0.'close'()
        $P3 = compreg 'PIR'
        $P4 = $P3($P2)
        $P4 = $P4[0]
        store_lex '$sub', $P4
    };
    return $sub;
}

sub compile_nqp_test($filename) {
    my $nqp := pir::compreg__PS("NQP-rx");
    my $fh := pir::new__PS("FileHandle");
    $fh.open($filename);
    my $code := $fh.readall();
    $fh.close();
    my $sub := $nqp.compile($code);
    return $sub[0];
}

sub compile_and_execute($filename) {
    my $sub;
    my $pirfile := is_pir_test($filename);
    if $pirfile == 0 {
        $sub := compile_nqp_test($filename);
    } else {
        $sub := compile_pir_test($filename);
    }
    try {
        $sub();
        CATCH {
            pir::say($!);
            pir::say(pir::join('\n', $!.backtrace_strings()));
            # WAT DO?
        }
    }
}
