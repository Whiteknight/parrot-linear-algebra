my $tests := Test::ComplexMatrix2D::Resize.new();
$tests.suite.run;

class Test::ComplexMatrix2D::Resize is Pla::Methods::Resize {
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
}
