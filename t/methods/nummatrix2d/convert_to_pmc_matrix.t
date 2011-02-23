Rosella::Testcase::test(Test::NumMatrix2D::ConvertToPmcMatrix);

class Test::NumMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
