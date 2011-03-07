Rosella::Test::test(Test::PMCMatrix2D::Transpose);

class Test::PMCMatrix2D::Transpose is Pla::Methods::Transpose {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
