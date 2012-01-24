INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::ComplexMatrix2D::ItemAt, Pla::MatrixFactory::ComplexMatrix2D);

class Test::ComplexMatrix2D::ItemAt is Pla::Methods::ItemAt {

    method test_set_optional_third_parameter_complex() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.defaultmatrix2x2();
        $n{$!context.factory.key(1, 1)} := "1+1i";
        $m.item_at(1, 1, "1+1i");
        $!assert.equal($m, $n, "item_at(VALUE) does not work like keyed access");
    }

    method test_set_optional_third_parameter_array() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.defaultmatrix2x2();
        $n{$!context.factory.key(1, 1)} := (1,1);
        $m.item_at(1, 1, (1,1));
        $!assert.equal($m, $n, "item_at(VALUE) does not work like keyed access when VALUE is an array");
    }

    method test_set_out_of_bounds_index_complex_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(4, 1, "1+1i");
        });
    }

    method test_set_out_of_bounds_index_complex_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(1, 4, "1+1i");
        });
    }

    method test_set_at_negative_index_complex_A() {
        my $m := $!context.factory.defaultmatrix2x2();
        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(-1, -1, "1+1i");
        });
    }

    method test_set_at_negative_index_complex_B() {
        my $m := $!context.factory.defaultmatrix2x2();
        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(-1, -1, "1+1i");
        });
    }

    method test_set_empty_matrix_does_not_grow_complex() {
        my $m := $!context.factory.matrix();
        $!assert.throws("can item_at out of bounds",
        {
            $m.item_at(0, 0, "1+1i");
        });
    }
}
