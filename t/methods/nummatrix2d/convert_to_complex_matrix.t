Rosella::Testcase::test(Test::NumMatrix2D::ConvertToComplexMatrix);

class Test::NumMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
