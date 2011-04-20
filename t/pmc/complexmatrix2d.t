my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D, :context($context));

class Test::ComplexMatrix2D is Pla::NumericMatrixTest;

sub equal($a, $b, $r) { Assert::equal($a, $b, $r); }

method test_VTABLE_get_number_keyed() {
    $!context.todo("Tests Needed!");
}

method test_VTABLE_get_integer_keyed() {
    $!context.todo("Tests Needed!");
}

method test_VTABLE_get_string_keyed() {
    $!context.todo("Tests Needed!");
}

method test_VTABLE_set_pmc_keyed_STRING() {
    my $m := $!context.factory.matrix();
    my $a := "1+1i";  # a String PMC, not a Complex
    $m{$!context.factory.key(0,0)} := $a;
    my $b := $m{$!context.factory.key(0,0)};
    Assert::instance_of($b, "Complex", "Cannot set_pmc_keyed<String>");
    my $c := pir::new__PSP("Complex", "1+1i");
    Assert::equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_pmc_keyed_ARRAY() {
    my $m := $!context.factory.matrix();
    my $a := (1,1);
    $m{$!context.factory.key(0,0)} := $a;
    my $b := $m{$!context.factory.key(0,0)};
    Assert::instance_of($b, "Complex", "Cannot set_pmc_keyed<Array>");
    my $c := pir::new__PSP("Complex", "1+1i");
    Assert::equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_pmc_keyed_INTEGER() {
    my $m := $!context.factory.matrix();
    my $a := pir::box__PI(1);
    $m{$!context.factory.key(0,0)} := $a;
    my $b := $m{$!context.factory.key(0,0)};
    Assert::instance_of($b, "Complex", "Cannot set_pmc_keyed<Integer>");
    my $c := pir::new__PSP("Complex", "1+0i");
    Assert::equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_pmc_keyed_FLOAT() {
    my $m := $!context.factory.matrix();
    my $a := pir::box__PN(3.5);
    $m{$!context.factory.key(0,0)} := $a;
    my $b := $m{$!context.factory.key(0,0)};
    Assert::instance_of($b, "Complex", "Cannot set_pmc_keyed<Float>");
    my $c := pir::new__PSP("Complex", "3.5+0i");
    Assert::equal($b, $c, "did not get the correct value back");
}

method test_VTABLE_set_string_keyed() {
    my $m := $!context.factory.matrix();
    my $a := pir::new__PS("Complex");
    # Keep this as raw PIR for now to make sure we are calling the correct vtable
    Q:PIR {
        $P0 = find_lex "$m"
        $P0[0;0] = "1+1i"
        $P1 = $P0[0;0]
        store_lex "$a", $P1
    };
    Assert::equal(~$a, "1+1i", "set_string_keyed doesn't work");
}

method test_VTABLE_get_string() {
    $!context.todo("Tests Needed!");
}

method test_METHOD_conjugate() {
    my $m := $!context.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
    my $n := $!context.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
    $m.conjugate();
    Assert::equal($m, $n, "conjugate does not work");
}

method test_add_nummatrix() {
    Q:PIR {
      $P1 = new 'ComplexMatrix2D'
      $P1.'resize'(5,5)
      $P1[1;1] = 4.
      $P1[1;2] = 8.

      $P2 = new 'NumMatrix2D'
      $P2.'resize'(5,5)
      $P2[1;1] = 3.
      $P2[1;2] = 4.

      $P3 = $P1 + $P2
      $I0 = $P3[1;1]
      equal($I0, 7, "ComplexMatrix+NumMatrix Adding Failed.")
      $I0 = $P3[1;2]
      equal($I0, 12, "ComplexMatrix+NumMatrix Adding Failed.")

      $P3 = $P1 - $P2
      $I0 = $P3[1;1]
      equal($I0, 1, "ComplexMatrix-NumMatrix Subtraction Failed.")
      $I0 = $P3[1;2]
      equal($I0, 4, "ComplexMatrix-NumMatrix Subtraction Failed.")
    }
}

method test_add_pmcmatrix() {
    Q:PIR {
      $P1 = new 'ComplexMatrix2D'
      $P1.'resize'(5,5)
      $P1[1;1] = 4.
      $P1[1;2] = 8.

      $P2 = new 'PMCMatrix2D'
      $P2.'resize'(5,5)
      $P2[1;1] = 3.
      $P2[1;2] = 4.

      $P3 = $P1 + $P2
      $I0 = $P3[1;1]
      equal($I0, 7, "ComplexMatrix+PMCMatrix Adding Failed.")
      $I0 = $P3[1;2]
      equal($I0, 12, "ComplexMatrix+PMCMatrix Adding Failed.")

      $P3 = $P1 - $P2
      $I0 = $P3[1;1]
      equal($I0, 1, "ComplexMatrix-PMCMatrix Subtraction Failed.")
      $I0 = $P3[1;2]
      equal($I0, 4, "ComplexMatrix-PMCMatrix Subtraction Failed.")
    }
}
