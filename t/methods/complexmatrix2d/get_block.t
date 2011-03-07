Rosella::Test::test(Test::ComplexMatrix2D::GetBlock);

class Test::ComplexMatrix2D::GetBlock is Pla::Methods::GetBlock {
    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::ComplexMatrix2D.new();
        }
        return $!factory;
    }

    # TODO: Other tests for this method with other argument combinations and
    #       boundary checks.
    method test_get_block_complex_1() {
        my $m := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $n := self.factory.matrix2x2("1+1i", "2+2i",
                                "4+4i", "5+5i");
        my $o := $m.get_block(0, 0, 2, 2);
        Assert::equal($n, $o, "cannot get block with complex matrix");
    }

    method test_get_block_complex_2() {
        my $m := self.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", "5+5i", "6+6i",
                                "7+7i", "8+8i", "9+9i");
        my $n := self.factory.matrix2x2("5+5i", "6+6i",
                                "8+8i", "9+9i");
        my $o := $m.get_block(1, 1, 2, 2);
        Assert::equal($n, $o, "cannot get block with complex matrix");
    }
}
