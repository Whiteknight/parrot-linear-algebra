my $tests := Test::PMCMatrix2D::Fill.new();
$tests.suite.run;

class Test::PMCMatrix2D::Fill is Pla::Methods::Fill {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
