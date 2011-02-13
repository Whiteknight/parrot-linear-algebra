my $tests := Test::NumMatrix2D::RowCombine.new();
$tests.suite.run;

class Test::NumMatrix2D::RowCombine is Pla::Methods::RowCombine {
    has $!factory;

    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
