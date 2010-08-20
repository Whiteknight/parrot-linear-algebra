my $tests := Test::NumMatrix2D::IterateFunctionInplace.new();
$tests.suite.run;

class Test::NumMatrix2D::IterateFunctionInplace is Pla::Methods::IterateFunctionInplace {
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
