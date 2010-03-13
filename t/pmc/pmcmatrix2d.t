#! parrot-nqp

INIT {
    # Load the Kakapo library
    pir::load_language('parrot');
    my $env := pir::new__PS('Env');
    my $root_dir := $env<HARNESS_ROOT_DIR> || '.';
    pir::load_bytecode($root_dir ~ '/library/kakapo_full.pbc');
    pir::loadlib__ps("./linalg_group");
}

class Test::CharMatrix2D is UnitTest::Testcase;

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

MAIN();

sub MAIN() {
    my $proto := Opcode::get_root_global(pir::get_namespace__P().get_name);
    $proto.suite.run;
}

method test_op_new() {
    assert_throws_nothing("Cannot create PMCMatrix2D", {
        my $m := Parrot::new("PMCMatrix2D");
        assert_not_null($m, "PMCMatrix2D is null for some reason");
    });
}

method test_op_does() {
    my $m := Parrot::new("PMCMatrix2D");
    assert_true(pir::does($m, "matrix"), "Does not do matrix");
    assert_false(pir::does($m, "gobbledegak"), "Does do gobbledegak");
}

method test_vtable_set_pmc_keyed() {
    assert_throws_nothing("set_pmc_keyed fails", {
        my $m := Parrot::new("PMCMatrix2D");
        my $n := 1;
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$n"
            $P0[0;0] = $P1
        };
    });
}

method test_vtable_get_pmc_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n := 42;
    my $o;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P0[0;0] = $P1
        $P2 = $P0[0;0]
        store_lex "$o", $P2
    };
    assert_equal($o, $n, "they are not equal");
}

method test_vtable_get_integer_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n := 42;
    my $o;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P0[0;0] = $P1
        $I0 = $P0[0;0]
        $P2 = box $I0
        store_lex "$o", $P2
    };
    assert_equal($n, $o, "get_integer_keyed does not work");
}

method test_vtable_get_number_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n := 42.5;
    my $o;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P0[0;0] = $P1
        $N0 = $P0[0;0]
        $P2 = box $N0
        store_lex "$o", $P2
    };
    assert_equal($n, $o, "get_number_keyed does not work");
}

method test_vtable_get_string_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n := "Hello World";
    my $o;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$n"
        $P0[0;0] = $P1
        $S0 = $P0[0;0]
        $P2 = box $S0
        store_lex "$o", $P2
    };
    assert_equal($n, $o, "get_string_keyed does not work");
}

method test_vtable_set_integer_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n;
    Q:PIR {
        $P0 = find_lex "$m"
        $I0 = 42
        $P0[0;0] = $I0
        $I1 = $P0[0;0]
        $P1 = box $I1
        store_lex "$n", $P1
    };
    assert_equal($n, 42, "set_integer_keyed does not work");
}

method test_vtable_set_number_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n;
    Q:PIR {
        $P0 = find_lex "$m"
        $N0 = 42.5
        $P0[0;0] = $N0
        $N1 = $P0[0;0]
        $P1 = box $N1
        store_lex "$n", $P1
    };
    assert_equal($n, 42.5, "set_number_keyed does not work");
}

method test_vtable_set_string_keyed() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n;
    Q:PIR {
        $P0 = find_lex "$m"
        $S0 = "Hello World"
        $P0[0;0] = $S0
        $S1 = $P0[0;0]
        $P1 = box $S1
        store_lex "$n", $P1
    };
    assert_equal($n, "Hello World", "set_integer_keyed does not work");
}

method test_vtable_get_string() {
    my $m := Parrot::new("PMCMatrix2D");
    my $n;
    Q:PIR {
        $P0 = find_lex "$m"
        $S0 = "Hello World"
        $P0[0;0] = $S0
        $S1 = $P0[0;0]
        $P1 = box $S1
        store_lex "$n", $P1
    };
    assert_equal(~($m), '{' ~ "\n\t[0,0] = Hello World\n" ~ '}' ~ "\n", "get_string does not work");
}

method test_method_initialize_from_array() {
    todo("Test Needed");
}

method test_op_getattribute_null_matrix() {
    my $m := Parrot::new("PMCMatrix2D");
    my $rows := pir::getattribute__PPS($m, "rows");
    my $cols := pir::getattribute__PPS($m, "cols");
    assert_equal($rows, 0, "rows are not zero");
    assert_equal($cols, 0, "cols are not zero");
}

method test_method_resize() {
    my $m := Parrot::new("PMCMatrix2D");
    my $rows := pir::getattribute__PPS($m, "rows");
    my $cols := pir::getattribute__PPS($m, "cols");
    $m.resize(5, 3);
    $rows := pir::getattribute__PPS($m, "rows");
    $cols := pir::getattribute__PPS($m, "cols");
    assert_equal($rows, 5, "rows are not zero");
    assert_equal($cols, 3, "cols are not zero");
}

