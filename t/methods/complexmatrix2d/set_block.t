Rosella::Testcase::test(Test::ComplexMatrix2D::SetBlock);

class Test::ComplexMatrix2D::SetBlock is Pla::Methods::SetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
