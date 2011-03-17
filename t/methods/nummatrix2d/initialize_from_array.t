Rosella::Test::test(Test::NumMatrix2D::InitializeFromArray);

class Test::NumMatrix2D::InitializeFromArray is Pla::Methods::InitializeFromArray {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
