my $tests := Test::PMCMatrix2D::GetBlock.new();
$tests.suite.run;

class Test::PMCMatrix2D::GetBlock is Pla::Methods::GetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
