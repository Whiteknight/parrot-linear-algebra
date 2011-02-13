my $tests := Test::ComplexMatrix2D::SetBlock.new();
$tests.suite.run;

class Test::ComplexMatrix2D::SetBlock is Pla::Methods::SetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
