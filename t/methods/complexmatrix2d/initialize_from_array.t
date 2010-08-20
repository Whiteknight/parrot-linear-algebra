my $tests := Test::ComplexMatrix2D::InitializeFromArray.new();
$tests.suite.run;

class Test::ComplexMatrix2D::InitializeFromArray is Pla::Methods::InitializeFromArray {
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
