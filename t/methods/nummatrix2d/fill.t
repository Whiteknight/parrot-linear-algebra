Rosella::Test::test(Test::NumMatrix2D::Fill);

class Test::NumMatrix2D::Fill is Pla::Methods::Fill {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }

    method test_fill_numerical() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix2x2(4, 4, 4, 4);

        $m.fill(4);

        Assert::equal($m, $n, "cannot fill numerical");
    }

    method test_fill_with_resizing_numerical() {
        my $m := self.factory.matrix();
        my $n := self.factory.matrix3x3(2, 2, 2,
                                        2, 2, 2,
                                        2, 2, 2);

        $m.fill(2, 3, 3);

        Assert::equal($m, $n, "cannot fill (with resize) numerical");
    }
}
