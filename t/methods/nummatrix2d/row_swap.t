my $tests := Test::NumMatrix2D::RowSwap.new();
$tests.suite.run;

class Test::NumMatrix2D::RowSwap is Pla::Methods::RowSwap {
    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
