Rosella::Testcase::test(Test::ComplexMatrix2D::ConvertToNumberMatrix.new);

class Test::ComplexMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }
}
