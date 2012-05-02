INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::NumMatrix2D::Fill, Pla::MatrixFactory::NumMatrix2D);

class Test::NumMatrix2D::Fill is Pla::Methods::Fill {

    method test_fill_numerical() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix2x2(4, 4, 4, 4);

        $m.fill(4);

        $!assert.equal($m, $n, "cannot fill numerical");
    }

    method test_fill_with_resizing_numerical() {
        my $m := $!context.factory.matrix();
        my $n := $!context.factory.matrix3x3(2, 2, 2,
                                        2, 2, 2,
                                        2, 2, 2);

        $m.fill(2, 3, 3);

        $!assert.equal($m, $n, "cannot fill (with resize) numerical");
    }

    method test_fill_numerical() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix2x2(4, 4, 4, 4);

        $m.fill(4);

        assert_equal($m, $n, "cannot fill numerical");
    }

    method test_fill_with_resizing_numerical() {
        my $m := self.factory.matrix();
        my $n := self.factory.matrix3x3(2, 2, 2, 
                                        2, 2, 2, 
                                        2, 2, 2);

        $m.fill(3, 3, 2);

        assert_equal($m, $n, "cannot fill (with resize) numerical");
    }
}
