class Pla::Methods::ItemAt is Pla::MatrixTestBase {
    method test_item_at() {
        my $m := $!context.factory.fancymatrix2x2();
        Assert::equal($!context.factory.fancyvalue(0), $m.item_at(0, 0), "cannot get item 0,0");
        Assert::equal($!context.factory.fancyvalue(1), $m.item_at(0, 1), "cannot get item 0,1");
        Assert::equal($!context.factory.fancyvalue(2), $m.item_at(1, 0), "cannot get item 1,0");
        Assert::equal($!context.factory.fancyvalue(3), $m.item_at(1, 1), "cannot get item 1,1");
    }

    method test_out_of_bounds_index_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(1, 4);
        });
    }

    method test_out_of_bounds_index_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(4, 1);
        });
    }

    method test_negative_index_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(-1, 0);
        });
    }

    method test_negative_index_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(0, -1);
        });
    }

    method test_item_from_empty_matrix() {
        my $m := $!context.factory.matrix();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(0, 0);
        });
    }

    method test_set_optional_third_parameter() {
        my $m := $!context.factory.fancymatrix2x2();
        my $n := $!context.factory.fancymatrix2x2();
        $n{$!context.factory.key(1, 1)} := $!context.factory.fancyvalue(0);
        $m.item_at(1, 1, $!context.factory.fancyvalue(0));
        Assert::equal($m, $n, "item_at(VALUE) does not work like keyed access");
    }

    method test_set_out_of_bounds_index_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(4, 1, $!context.factory.fancyvalue(0));
        });
    }

    method test_set_out_of_bounds_index_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(1, 4, $!context.factory.fancyvalue(0));
        });
    }

    method test_set_at_negative_index_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(-1, -1, $!context.factory.fancyvalue(0));
        });
    }

    method test_set_at_negative_index_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(-1, -1, $!context.factory.fancyvalue(0));
        });
    }

    method test_set_empty_matrix_does_not_grow() {
        my $m := $!context.factory.matrix();
        Assert::throws("can item_at out of bounds",
        {
            $m.item_at(0, 0, $!context.factory.fancyvalue(0));
        });
    }


}
