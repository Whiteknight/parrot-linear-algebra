Rosella::Testcase::test(Test::PMCMatrix2D::GetBlock);

class Test::PMCMatrix2D::GetBlock is Pla::Methods::GetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::PMCMatrix2D.new();
        }
        return $!factory;
    }
}
