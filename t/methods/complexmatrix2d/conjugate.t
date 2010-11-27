my $tests := Test::ComplexMatrix2D::Conjugate.new();
$tests.suite.run;

class Test::ComplexMatrix2D::Conjugate is Pla::MatrixTestBase {
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

    method test_conjugate() {
        my $m := self.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
        my $n := self.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
        $m.conjugate();
        assert_equal($m, $n, "conjugate does not work");
    }

    method test_conjugate_non_square() {
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := "1+1i";
        $m{Key.new(0,1)} := "2+2i";
        $m{Key.new(0,2)} := "3+3i";
        $m{Key.new(0,3)} := "4+4i";

        my $n := self.factory.matrix();
        $n{Key.new(0,0)} := "1-1i";
        $n{Key.new(0,1)} := "2-2i";
        $n{Key.new(0,2)} := "3-3i";
        $n{Key.new(0,3)} := "4-4i";
        
        $m.conjugate();
        assert_equal($m, $n, "non-square conjugate does not work");
    }
}
