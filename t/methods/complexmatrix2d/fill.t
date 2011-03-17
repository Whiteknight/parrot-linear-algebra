Rosella::Test::test(Test::ComplexMatrix2D::Fill);

class Test::ComplexMatrix2D::Fill is Pla::Methods::Fill {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    # Test that we can fill a matrix
    method test_fill_complex() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix2x2(
            "1+1i",
            "1+1i",
            "1+1i",
            "1+1i"
        );
        $m.fill("1+1i");
        Assert::equal($n, $m, "Cannot fill complex");
    }

    # test that the fill method can be used to resize the matrix
    method test_fill_with_resizing_complex() {
        my $m := self.factory.matrix2x2(
            "1+1i", "1+1i",
            "1+1i", "1+1i"
        );

        my $n := self.factory.matrix();

        $n.fill("1+1i", 2, 2);
        Assert::equal($n, $m, "Cannot fill+Resize complex");
    }

    method test_fill_array() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix2x2(
            "1+1i",
            "1+1i",
            "1+1i",
            "1+1i"
        );
        my $array := (1, 1);
        $m.fill($array);
        Assert::equal($n, $m, "Cannot fill using an array");
    }

    method test_fill_with_resizing_array() {
        my $m := self.factory.matrix2x2(
            "1+1i", "1+1i",
            "1+1i", "1+1i"
        );

        my $n := self.factory.matrix();

        my $array := (1, 1);
        $n.fill($array, 2, 2);
        Assert::equal($n, $m, "Cannot fill+Resize using an array");
    }
}
