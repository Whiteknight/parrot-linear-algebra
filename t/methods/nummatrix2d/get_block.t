my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
my $asserter := Pla::MatrixAsserter.new;
Rosella::Test::test(Test::NumMatrix2D::GetBlock, :context($context), :asserter($asserter));

class Test::NumMatrix2D::GetBlock is Pla::Methods::GetBlock {

    method test_get_block_numerical_1() {
        my $m := $!context.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        my $n := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        my $o := $m.get_block(0, 0, 2, 2);

        $!assert.equal($n, $o, "cannot get block with numerical matrix");
    }

    method test_get_block_numerical_2() {
        my $m := $!context.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        my $n := $!context.factory.matrix2x2(22, 23,
                                        32, 33);

        my $o := $m.get_block(1, 1, 2, 2);

        $!assert.equal($n, $o, "cannot get block with numerical matrix");
    }

    method test_get_block_numerical_out_of_bounds() {
        my $m := $!context.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        $!assert.throws("can get_block numerical out of bounds",
        {
            $m.get_block(2, 2, 2, 2);
        });
    }

    method test_get_block_numerical_negative_index() {
        my $m := $!context.factory.matrix3x3(11, 12, 13,
                                        21, 22, 23,
                                        31, 32, 33);

        $!assert.throws("can get_block numerical with negative index",
        {
            $m.get_block(-1, -1, 2, 2);
        });
    }
}
