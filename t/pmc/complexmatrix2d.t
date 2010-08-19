my $tests := Test::ComplexMatrix2D.new();
$tests.suite.run();

class Test::ComplexMatrix2D is Pla::NumericMatrixTest;

INIT {
    use('UnitTest::Testcase');
    use('UnitTest::Assertions');
}

has $!factory;
method factory() {
    unless pir::defined__IP($!factory) {
        $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
    }
    return $!factory;
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
    my $m := self.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    assert_equal($m, $n, "conjugate does not work");
}


