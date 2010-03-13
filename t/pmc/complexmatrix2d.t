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
    #Spir::trace(4);
    $proto.suite.run;
}

sub matrix2x2($aa, $ab, $ba, $bb) {
    my $m := Parrot::new("ComplexMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$aa"
        $P2 = find_lex "$ab"
        $P3 = find_lex "$ba"
        $P4 = find_lex "$bb"

        $P0[0;0] = $P1
        $P0[0;1] = $P2
        $P0[1;0] = $P3
        $P0[1;1] = $P4
    };
    return ($m);
}

sub matrix2x2str($aa, $ab, $ba, $bb) {
    my $m := Parrot::new("ComplexMatrix2D");
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$aa"
        $S1 = $P1
        $P2 = find_lex "$ab"
        $S2 = $P2
        $P3 = find_lex "$ba"
        $S3 = $P3
        $P4 = find_lex "$bb"
        $S4 = $P4

        $P0[0;0] = $S1
        $P0[0;1] = $S2
        $P0[1;0] = $S3
        $P0[1;1] = $S4
    };
    return ($m);
}

method test_create_complexmatrix2d() {
    assert_throws_nothing("Cannot create ComplexMatrix2D", {
        my $c := Parrot::new("ComplexMatrix2D");
        assert_not_null($c, "Could not create a ComplexMatrix2D");
    });
}

method test_sub_op_does_matrix() {
    my $c := Parrot::new("ComplexMatrix2D");
    assert_true(pir::does($c, "matrix"), "Does not do matrix");
    assert_false(pir::does($c, "gobbledegak"), "Does gobbledegak");
}

method test_sub_vtable_get_number_keyed() {
    todo("Tests Needed!");
}

method test_vtable_get_integer_keyed() {
    todo("Tests Needed!");
}

method test_sub_vtable_get_string_keyed() {
    todo("Tests Needed!");
}

method test_vtable_get_pmc_keyed() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := Parrot::new("Complex");
    pir::assign__vPS($a, "1+1i");
    my $b;
    Q:PIR {
        $P0 = find_lex "$m"
        $P1 = find_lex "$a"
        $P0[0;0] = $P1
        $P2 = $P0[0;0]
        store_lex "$b", $P2
    };
    assert_equal($a, $b, "get_pmc_keyed doesn't work");
}

method test_vtable_set_pmc_keyed() {
    assert_throws_nothing("Cannot set_pmc_keyed", {
        my $m := Parrot::new("ComplexMatrix2D");
        my $a := Parrot::new("Complex");
        pir::assign__vPS($a, "1+1i");
        Q:PIR {
            $P0 = find_lex "$m"
            $P1 = find_lex "$a"
            $P0[0;0] = $P1
        };
    });
}

method test_vtable_set_string_keyed() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := Parrot::new("Complex");
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[0;0] = "1+1i"
        $P1 = $P0[0;0]
        store_lex "$a", $P1
    };
    assert_equal($a, "1+1i", "set_string_keyed doesn't work");
}

method test_vtable_get_string() {
    todo("Tests Needed!");
}

method test_vtable_get_attr_string() {
    todo("Tests Needed!");
}

method test_vtable_clone() {
    todo("Tests Needed!");
}

method test_vtable_is_equal() {
    todo("Tests Needed!");
}

method test_method_resize() {
    todo("Tests Needed!");
}

method test_method_fill() {
    todo("Tests Needed!");
}

method test_method_transpose() {
    my $m := matrix2x2str("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2str("1+1i", "3+3i", "2+2i", "4+4i");
    $m.transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_method_mem_transpose() {
    my $m := matrix2x2str("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2str("1+1i", "3+3i", "2+2i", "4+4i");
    $m.mem_transpose();
    assert_equal($m, $n, "mem_transpose does not work");
}

method test_method_conjugate() {
    my $m := matrix2x2str("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2str("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    assert_equal($m, $n, "conjugate does not work");
}

method test_method_iterate_function_inplace() {
    my $m := matrix2x2str("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2str("3.5+1i", "4.5+1i", "5.5+1i", "6.5+1i");
    $m.iterate_function_inplace(-> $matrix, $value, $row, $col {
        return ($value + 2.5);
    });
    assert_equal($m, $n, "Cannot iterate function in place");
}

