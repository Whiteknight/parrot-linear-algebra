Rosella::Testcase::test(Test::NumMatrix2D::ConvertToNumberMatrix);

class Test::NumMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
