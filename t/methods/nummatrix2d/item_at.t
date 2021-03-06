INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::NumMatrix2D::ItemAt, Pla::MatrixFactory::NumMatrix2D);

class Test::NumMatrix2D::ItemAt is Pla::Methods::ItemAt {

    method test_get_item_at_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        my $expected := 22;

        $!assert.equal($m.item_at(1,1), $expected, "cannot item_at with numerical matrix");
    }

    method test_get_item_at_out_of_bounds_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(2, 2);
        });
    }

    method test_set_item_at_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        $m.item_at(0, 0, 99);

        $!assert.equal($m.item_at(0,0), 99, "cannot set item_at with numerical matrix");
    }

    method test_set_item_at_out_of_bounds_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(2, 2, 99);
        });
    }

    method test_set_item_at_negative_index_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        $!assert.throws("can item_at out of bounds (negative index)",
        {
            $m.item_at(-1, -1, 99);
        });
    }
}

