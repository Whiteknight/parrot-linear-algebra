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

class Test::ComplexMatrix2D is Pla::Testcase;

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

method defaultvalue() {
    return (pir::new__PSP("Complex", "1+1i"));
}

method nullvalue() {
    return (pir::new__PSP("Complex", "0+0i"));
}

method fancyvalue() {
    return (pir::new__PSP("Complex", "9+9i"));
}

method matrix() {
    my $m := Parrot::new("ComplexMatrix2D");
    return ($m);
}

method matrix2x2($aa, $ab, $ba, $bb) {
    my $m := self.matrix();
    if (pir::typeof__SP($aa) eq "String") { $aa := pir::new__PSP("Complex", $aa); }
    if (pir::typeof__SP($ab) eq "String") { $ab := pir::new__PSP("Complex", $ab); }
    if (pir::typeof__SP($ba) eq "String") { $ba := pir::new__PSP("Complex", $ba); }
    if (pir::typeof__SP($bb) eq "String") { $bb := pir::new__PSP("Complex", $bb); }
    $m{Key.new(0,0)} := $aa;
    $m{Key.new(0,1)} := $ab;
    $m{Key.new(1,0)} := $ba;
    $m{Key.new(1,1)} := $bb;
    return ($m);
}

method defaultmatrix2x2() {
    return (self.matrix2x2("1+1i", "1+1i", "1+1i", "1+1i"));
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

method test_METHOD_transpose() {
    my $m := self.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.matrix2x2("1+1i", "3+3i", "2+2i", "4+4i");
    $m.transpose();
    assert_equal($m, $n, "transpose does not work");
}

method test_METHOD_mem_transpose() {
    my $m := self.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.matrix2x2("1+1i", "3+3i", "2+2i", "4+4i");
    $m.mem_transpose();
    assert_equal($m, $n, "mem_transpose does not work");
}

method test_METHOD_conjugate() {
    my $m := self.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    assert_equal($m, $n, "conjugate does not work");
}

method test_METHOD_iterate_function_inplace() {
    my $m := self.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.matrix2x2("3.5+1i", "4.5+1i", "5.5+1i", "6.5+1i");
    $m.iterate_function_inplace(-> $matrix, $value, $row, $col {
        return ($value + 2.5);
    });
    assert_equal($m, $n, "Cannot iterate function in place");
}

