Rosella::Test::test(Test::NumMatrix2D::InitializeFromArgs);

class Test::NumMatrix2D::InitializeFromArgs is Pla::Methods::InitializeFromArgs {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }
}
