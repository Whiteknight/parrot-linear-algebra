my $tests := Test::NumMatrix2D::GetBlock.new();
$tests.suite.run;

class Test::NumMatrix2D::GetBlock is Pla::Methods::GetBlock {
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
