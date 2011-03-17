Rosella::Test::test(Test::PMCMatrix2D::ConvertToPmcMatrix);

class Test::PMCMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
