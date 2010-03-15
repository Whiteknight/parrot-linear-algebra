#! parrot-nqp

INIT {
    # Load the Kakapo library
    pir::load_language('parrot');
    my $env := pir::new__PS('Env');
    my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
    pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
    pir::loadlib__ps("./linalg_group");
    Nqp::compile_file( 't/Testcase.nqp' );
}

class Test::CharMatrix2D is Pla::Testcase;

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

MAIN();

sub MAIN() {
    my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
    $proto.suite.run;
}

method matrix() {
    return (Parrot::new("CharMatrix2D"));
}
method defaultvalue() {
    return "A";
}
method nullvalue() {
    return " ";
}
method fancyvalue() {
    return "Z";
}

method test_VTABLE_set_string_keyed_int() {
    my $c := self.matrix();
    $c[0] := "ABCD";
    $c[1] := "EFGH";
    assert_equal(~($c), "ABCD\nEFGH\n", "can not set row-at-a-time, with equal lengths");
}

method test_VTABLE_get_string_keyed_int() {
    my $c := self.matrix();
    $c[0] := "ABCD";
    $c[1] := "EFGH";
    my $firstrow;
    my $secondrow;
    Q:PIR {
        $P0 = find_lex "$c"
        $P1 = find_lex "$firstrow"
        $P2 = find_lex "$secondrow"
        $S0 = $P0[0]
        $P1 = $S0
        $S0 = $P0[1]
        $P2 = $S0
    };
    assert_equal($firstrow, "ABCD", "Can not get the first row as a string");
    assert_equal($secondrow, "EFGH", "Can not get the second row as a string");
}

method test_VTABLE_set_integer_keyed() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        # TODO: We really need to figure out indexing, because this seems wrong
        $P0[0;0] = 65
        $P0[1;0] = 66
        $P0[2;0] = 67
        $P0[3;0] = 68
        $P0[0;1] = 69
        $P0[1;1] = 70
        $P0[2;1] = 71
        $P0[3;1] = 72
        $S0 = $P0[0]
        assert_equal($S0, "ABCD", "Can not set characters by ASCII value, first row")
        $S0 = $P0[1]
        assert_equal($S0, "EFGH", "Can not set characters by ASCII value, second row")
    };
}

method test_VTABLE_set_number_keyed() {
    Q:PIR {
        $P0 = new ['CharMatrix2D']
        $P0[0;0] = 65.2
        $P0[1;0] = 66.3
        $P0[2;0] = 67.4
        $P0[3;0] = 68.5
        $P0[0;1] = 69.6
        $P0[1;1] = 70.7
        $P0[2;1] = 71.8
        $P0[3;1] = 72.9
        $S0 = $P0[0]
        assert_equal($S0, "ABCD", "Can not set characters by decimal ASCII value, first row")
        $S0 = $P0[1]
        assert_equal($S0, "EFGH", "Can not set characeters by decimal ASCII value, second row")
    }
}

method test_VTABLE_set_pmc_keyed() {
    todo("Tests Needed!");
}

method test_METHOD_fill() {
    my $m := self.defaultmatrix2x2();
    my $n := self.matrix2x2(
        self.fancyvalue(),
        self.fancyvalue(),
        self.fancyvalue(),
        self.fancyvalue()
    );
    $m.fill(90);
    assert_equal($n, $m, "Cannot fill");
}
method test_METHOD_fill_RESIZE() {
    my $m := self.matrix();
    my $n := self.matrix2x2(
        self.fancyvalue(),
        self.fancyvalue(),
        self.fancyvalue(),
        self.fancyvalue()
    );
    $m.fill(90, 2, 2);
    assert_equal($n, $m, "Cannot fill");
}
