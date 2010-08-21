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

    method test_METHOD_conjugate() {
        my $m := self.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
        my $n := self.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
        $m.conjugate();
        assert_equal($m, $n, "conjugate does not work");
    }
}
