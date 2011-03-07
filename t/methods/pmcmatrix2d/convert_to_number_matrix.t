Rosella::Test::test(Test::PMCMatrix2D::ConvertToNumberMatrix);

class Test::PMCMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
