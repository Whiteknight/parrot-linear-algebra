my $tests := Test::ComplexMatrix2D::ConvertToNumberMatrix.new();
$tests.suite.run;

class Test::ComplexMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {
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
