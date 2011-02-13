my $tests := Test::PMCMatrix2D::SetBlock.new();
$tests.suite.run;

class Test::PMCMatrix2D::SetBlock is Pla::Methods::SetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
