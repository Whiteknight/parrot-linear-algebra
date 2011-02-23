Rosella::Testcase::test(Test::ComplexMatrix2D::ConvertToComplexMatrix);


class Test::ComplexMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
