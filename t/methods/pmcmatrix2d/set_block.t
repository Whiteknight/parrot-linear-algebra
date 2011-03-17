Rosella::Test::test(Test::PMCMatrix2D::SetBlock);

class Test::PMCMatrix2D::SetBlock is Pla::Methods::SetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
