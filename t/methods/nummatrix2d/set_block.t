Rosella::Test::test(Test::NumMatrix2D::SetBlock);

class Test::NumMatrix2D::SetBlock is Pla::Methods::SetBlock {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
