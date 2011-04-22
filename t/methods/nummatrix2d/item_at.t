my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::ItemAt, :context($context));

class Test::NumMatrix2D::ItemAt is Pla::Methods::ItemAt {

    method test_get_item_at_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        my $expected := 22;

        Assert::equal($m.item_at(1,1), $expected, "cannot item_at with numerical matrix");
    }

    method test_get_item_at_out_of_bounds_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(2, 2);
        });
    }

    method test_set_item_at_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        $m.item_at(0, 0, 99);

        Assert::equal($m.item_at(0,0), 99, "cannot set item_at with numerical matrix");
    }

    method test_set_item_at_out_of_bounds_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(2, 2, 99);
        });
    }

    method test_set_item_at_negative_index_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        Assert::throws("can item_at out of bounds (negative index)",
        {
            $m.item_at(-1, -1, 99);
        });
    }
}

