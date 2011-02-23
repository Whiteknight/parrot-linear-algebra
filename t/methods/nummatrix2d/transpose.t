Rosella::Testcase::test(Test::NumMatrix2D::Transpose);

class Test::NumMatrix2D::Transpose is Pla::Methods::Transpose {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }

    method test_transpose_square_numerical() {
        my $m := self.factory.matrix2x2(
            11, 12,
            21, 22
        );

        my $n := self.factory.matrix2x2(
            11, 21,
            12, 22
        );

        $m.transpose();
        Assert::equal($m, $n, "cannot tranpose numerical");
    }

    method test_non_square_tranpose_numerical() {
        my $m := self.factory.matrix();
        $m{self.factory.key(0,0)} := 11;
        $m{self.factory.key(0,1)} := 12;
        $m{self.factory.key(0,2)} := 13;
        $m{self.factory.key(1,0)} := 21;
        $m{self.factory.key(1,1)} := 22;
        $m{self.factory.key(1,2)} := 23;

        my $n := self.factory.matrix();
        $n{self.factory.key(0,0)} := 11;
        $n{self.factory.key(0,1)} := 21;
        $n{self.factory.key(1,0)} := 12;
        $n{self.factory.key(1,1)} := 22;
        $n{self.factory.key(2,0)} := 13;
        $n{self.factory.key(2,1)} := 23;

        $m.transpose();
        Assert::equal($m, $n, "cannot transpose numerical matrix with non-square dimensions");
    }
}
