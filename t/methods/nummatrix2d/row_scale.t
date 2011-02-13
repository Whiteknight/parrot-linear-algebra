my $tests := Test::NumMatrix2D::RowScale.new();
$tests.suite.run;

class Test::NumMatrix2D::RowScale is Pla::Methods::RowScale {

    has $!factory;

    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
