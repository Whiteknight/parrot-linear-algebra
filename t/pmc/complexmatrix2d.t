class Test::ComplexMatrix2D is Pla::Matrix::NumericMatrixTest;

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

our method defaultvalue() {
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

method complex($x) {
    my $t := pir::typeof__SP($x);
    if ($t eq "Complex") { return $x; }
    if ($t eq "String") {
        my $c;
        Q:PIR {
            $P0 = find_lex "$x"
            $P1 = new "Complex", $P0
            store_lex "$c", $P1
        };
        return $c;
    }
}

our method matrix() {
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

method test_METHOD_gemm_aA() {
    my $A := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $B := self.matrix3x3(1.0, 0.0, 0.0,
                            0.0, 1.0, 0.0,
                            0.0, 0.0, 1.0);
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3("2+2i", "4+4i", "6+6i",
                            "8+8i", "10+10i", "12+12i",
                            "14+14i", "16+16i", "18+18i");
    my $alpha := self.complex("2+0i");
    my $beta := self.complex("0+0i");
    my $Z := $A.'gemm'($alpha, $A, $B, $beta, $C);
    assert_equal($Y, $Z, "cannot GEMM aA");
}

method test_METHOD_gemm_AB() {
    my $A := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $B := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3("0+60i", "0+72i", "0+84i",
                            "0+132i", "0162i", "0+192i",
                            "0+204i", "0+252i", "0+300i");
    my $Z := $A.'gemm'(self.complex("1"), $A, $B, self.complex("0.0"), $C);
    assert_equal($Y, $Z, "gemm aAB does not work");
}

method test_METHOD_gemm_aAB() {
    my $A := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $B := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $C := self.matrix3x3(0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0);
    my $Y := self.matrix3x3("0+15i", "0+18i", "0+21i",
                            "0+33i", "0+40.5i", "0+48i",
                            "0+51i", "0+63i", "0+75i");
    my $Z := $A.'gemm'(self.complex("0.25"), $A, $B, self.complex("0.0"), $C);
    assert_equal($Y, $Z, "gemm aAB does not work");
}

method test_METHOD_gemm_aABbC() {
    my $A := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $B := self.matrix3x3("1+1i", "2+2i", "3+3i",
                            "4+4i", "5+5i", "6+6i",
                            "7+7i", "8+8i", "9+9i");
    my $C := self.matrix3x3(1.0, 2.0, 3.0,
                            4.0, 5.0, 6.0,
                            7.0, 8.0, 9.0);
    my $Y := self.matrix3x3("1+15i", "2+18i", "3+21i",
                            "4+33i", "5+40.5i", "6+48i",
                            "7+51i", "8+63i", "9+75i");
    my $Z := $A.'gemm'(self.complex("0.25"), $A, $B, self.complex("0.0"), $C);
}

method test_METHOD_conjugate() {
    my $m := self.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := self.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    assert_equal($m, $n, "conjugate does not work");
}


