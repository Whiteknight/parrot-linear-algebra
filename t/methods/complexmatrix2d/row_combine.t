my $tests := Test::NumMatrix2D::RowCombine.new();
$tests.suite.run;

class Test::ComplexMatrix2D::RowCombine is Pla::Methods::RowCombine {
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
