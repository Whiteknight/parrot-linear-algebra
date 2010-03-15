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
    $m{Key.new(0,0)} := pir::new__PSP("Complex", $aa);
    $m{Key.new(0,1)} := pir::new__PSP("Complex", $ab);
    $m{Key.new(1,0)} := pir::new__PSP("Complex", $ba);
    $m{Key.new(1,1)} := pir::new__PSP("Complex", $bb);
    return ($m);
}

method test_OP_new() {
    assert_throws_nothing("Cannot create ComplexMatrix2D", {
        my $c := Parrot::new("ComplexMatrix2D");
        assert_not_null($c, "Could not create a ComplexMatrix2D");
    });
}

method test_OP_does() {
    my $c := Parrot::new("ComplexMatrix2D");
    assert_true(pir::does($c, "matrix"), "Does not do matrix");
    assert_false(pir::does($c, "gobbledegak"), "Does gobbledegak");
}

method test_VTABLE_get_number_keyed() {
    todo("Tests Needed!");
}

method test_VTABLE_get_integer_keyed() {
    todo("Tests Needed!");
}

method test_VTABLE_get_string_keyed() {
    todo("Tests Needed!");
}

method test_VTABLE_get_pmc_keyed() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := pir::new__PSP("Complex", "1+1i");
    $m{Key.new(0,0)} := $a;
    my $b := $m{Key.new(0,0)};
    assert_equal($a, $b, "get_pmc_keyed doesn't work");
}

method test_VTABLE_set_pmc_keyed() {
    assert_throws_nothing("Cannot set_pmc_keyed", {
        my $m := Parrot::new("ComplexMatrix2D");
        my $a := pir::new__PSP("Complex", "1+1i");
        $m{Key.new(0,0)} := $a;
    });
}

method test_VTABLE_set_pmc_keyed_TYPEFAIL() {
    assert_throws(Exception::OutOfBounds, "Cannot set_pmc_keyed", {
        my $m := Parrot::new("ComplexMatrix2D");
        my $a := "1+1i";  # a String PMC, not a Complex
        $m{Key.new(0,0)} := $a;
    });
}

method test_VTABLE_set_string_keyed() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := Parrot::new("Complex");
    # Keep this as raw PIR for now to make sure we are calling the correct vtable
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[0;0] = "1+1i"
        $P1 = $P0[0;0]
        store_lex "$a", $P1
    };
    assert_equal($a, "1+1i", "set_string_keyed doesn't work");
}

method test_VTABLE_get_string() {
    todo("Tests Needed!");
}

method test_VTABLE_get_attr_str_EMPTY() {
    my $m := Parrot::new("ComplexMatrix2D");
    assert_equal(pir::getattribute__PPS($m, "rows"), 0, "empty matrix has non-zero row count");
    assert_equal(pir::getattribute__PPS($m, "cols"), 0, "empty matrix has non-zero col count");
}

method test_VTABLE_get_attr_str() {
    my $m := Parrot::new("ComplexMatrix2D");
    $m{Key.new(5,7)} := 1;
    assert_equal(pir::getattribute__PPS($m, "rows"), 6, "matrix does not have right size");
    assert_equal(pir::getattribute__PPS($m, "cols"), 8, "matrix does not have right size");
}

method test_VTABLE_clone() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := pir::clone($m);
    assert_equal($m, $n, "clones are not equal");
    assert_not_same($m, $n, "clones are the same PMC!");
}

method test_VTABLE_is_equal() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    assert_equal($m, $n, "equal matrices are not equal");
}

method test_VTABLE_is_equal_SIZEFAIL() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    $n{Key.new(2, 2)} := pir::new__PSP("Complex", "0+0i");
    assert_not_equal($m, $n, "different sized matrices are equal");
}

method test_VTABLE_is_equal_ELEMSFAIL() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1+1i", "2+2i", "3+3i", "5+5i");
    assert_not_equal($m, $n, "non-equal matrices are equal");
}

method test_METHOD_resize() {
    my $m := Parrot::new("ComplexMatrix2D");
    $m.resize(3,3);
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not have right size");
    assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not have right size");
}

method test_METHOD_resize_SHRINK() {
    my $m := Parrot::new("ComplexMatrix2D");
    $m.resize(3,3);
    $m.resize(1,1);
    assert_equal(pir::getattribute__PPS($m, "rows"), 3, "matrix does not have right size");
    assert_equal(pir::getattribute__PPS($m, "cols"), 3, "matrix does not have right size");
}

method test_METHOD_fill() {
    my $m := matrix2x2("1+1i", "1+1i", "1+1i", "1+1i");
    my $n := Parrot::new("ComplexMatrix2D");
    $n.fill(pir::new__PSP("Complex", "1+1i"), 2, 2);
    assert_equal($n, $m, "Cannot fill");
}

method test_METHOD_transpose() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1+1i", "3+3i", "2+2i", "4+4i");
    $m.transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_METHOD_mem_transpose() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1+1i", "3+3i", "2+2i", "4+4i");
    $m.mem_transpose();
    assert_equal($m, $n, "mem_transpose does not work");
}

method test_METHOD_conjugate() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    assert_equal($m, $n, "conjugate does not work");
}

method test_METHOD_iterate_function_inplace() {
    my $m := matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := matrix2x2("3.5+1i", "4.5+1i", "5.5+1i", "6.5+1i");
    $m.iterate_function_inplace(-> $matrix, $value, $row, $col {
        return ($value + 2.5);
    });
    assert_equal($m, $n, "Cannot iterate function in place");
}

