my $tests := Test::NumMatrix2D::MemTranspose.new();
$tests.suite.run;

class Test::NumMatrix2D::MemTranspose is Pla::Methods::MemTranspose {
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
