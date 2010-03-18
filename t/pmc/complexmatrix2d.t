#! parrot-nqp

INIT {
    pir::load_bytecode('./library/kakapo_full.pbc');
    pir::loadlib__ps("./linalg_group");
    Nqp::compile_file('t/testlib/matrixtest.nqp');
}

class Test::ComplexMatrix2D is Pla::Matrix::Testcase;

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

method fancyvalue($idx) {
    return (
        pir::new__PSP("Complex",
            ["6+6i", "7+7i", "8+8i", "9+9i"][$idx]
        )
    );
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

method test_VTABLE_set_pmc_keyed_STRING() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := "1+1i";  # a String PMC, not a Complex
    $m{Key.new(0,0)} := $a;
    my $b := $m{Key.new(0,0)};
    assert_instance_of($b, "Complex", "Cannot set_pmc_keyed<String>");
    my $c := pir::new__PSP("Complex", "1+1i");
    assert_equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_pmc_keyed_INTEGER() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := pir::box__PI(1);
    $m{Key.new(0,0)} := $a;
    my $b := $m{Key.new(0,0)};
    assert_instance_of($b, "Complex", "Cannot set_pmc_keyed<Integer>");
    my $c := pir::new__PSP("Complex", "1+0i");
    assert_equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_pmc_keyed_FLOAT() {
    my $m := Parrot::new("ComplexMatrix2D");
    my $a := pir::box__PN(3.5);
    $m{Key.new(0,0)} := $a;
    my $b := $m{Key.new(0,0)};
    assert_instance_of($b, "Complex", "Cannot set_pmc_keyed<Float>");
    my $c := pir::new__PSP("Complex", "3.5+0i");
    assert_equal($b, $c, "did not get the correct value back");
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

