Rosella::Test::test(Test::NumMatrix2D::GetBlock);

class Test::NumMatrix2D::GetBlock is Pla::Methods::GetBlock {

    has $!factory;
    method factory() {
        unless pir::defined__IP($!factory) {
            $!factory := Pla::MatrixFactory::NumMatrix2D.new();
        }
        return $!factory;
    }

    method test_get_block_numerical_1() {
        my $m := self.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        my $n := self.factory.matrix2x2(11, 12,
                                        21, 22);

        my $o := $m.get_block(0, 0, 2, 2);

        Assert::equal($n, $o, "cannot get block with numerical matrix");
    }

    method test_get_block_numerical_2() {
        my $m := self.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        my $n := self.factory.matrix2x2(22, 23,
                                        32, 33);

        my $o := $m.get_block(1, 1, 2, 2);

        Assert::equal($n, $o, "cannot get block with numerical matrix");
    }

    method test_get_block_numerical_out_of_bounds() {
        my $m := self.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        Assert::throws("can get_block numerical out of bounds",
        {
            $m.get_block(2, 2, 2, 2);
        });
    }

    method test_get_block_numerical_negative_index() {
        my $m := self.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        Assert::throws("can get_block numerical with negative index",
        {
            $m.get_block(-1, -1, 2, 2);
        });
    }
}
