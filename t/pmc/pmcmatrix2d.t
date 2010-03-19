class Test::PmcMatrix2D is Pla::Matrix::Testcase;

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
    return (Parrot::new("PMCMatrix2D"));
}

method nullvalue() {
    return (pir::null__P());
}

method test_VTABLE_get_integer_keyed() {
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

method test_VTABLE_get_number_keyed() {
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

method test_VTABLE_get_string_keyed() {
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

method test_VTABLE_set_integer_keyed() {
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

method test_VTABLE_set_number_keyed() {
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

method test_VTABLE_set_string_keyed() {
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

method test_VTABLE_get_string() {
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

