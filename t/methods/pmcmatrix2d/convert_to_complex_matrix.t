Rosella::Testcase::test(Test::PMCMatrix2D::ConvertToComplexMatrix);

class Test::PMCMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
