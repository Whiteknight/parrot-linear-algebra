INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::NumMatrix2D::MemTranspose, Pla::MatrixFactory::NumMatrix2D);

class Test::NumMatrix2D::MemTranspose is Pla::Methods::MemTranspose {

    method test_mem_transpose_square_numerical() {
        my $m := $!context.factory.matrix2x2(
              11, 12,
              21, 22
        );

        my $n := $!context.factory.matrix2x2(
              11, 21,
              12, 22
        );

        $m.transpose();
        $!assert.equal($m, $n, "cannot tranpose numerical");
    }

    method test_non_square_mem_tranpose_numerical() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := 11;
        $m{$!context.factory.key(0,1)} := 12;
        $m{$!context.factory.key(0,2)} := 13;
        $m{$!context.factory.key(1,0)} := 21;
        $m{$!context.factory.key(1,1)} := 22;
        $m{$!context.factory.key(1,2)} := 23;

        my $n := $!context.factory.matrix();
        $n{$!context.factory.key(0,0)} := 11;
        $n{$!context.factory.key(0,1)} := 21;
        $n{$!context.factory.key(1,0)} := 12;
        $n{$!context.factory.key(1,1)} := 22;
        $n{$!context.factory.key(2,0)} := 13;
        $n{$!context.factory.key(2,1)} := 23;

        $m.transpose();
        $!assert.equal($m, $n, "cannot transpose numerical matrix with non-square dimensions");
    }
    
    method test_mem_transpose_square_numerical() {
        my $m := self.factory.matrix2x2(
              11, 12,
              21, 22
        );	

        my $n := self.factory.matrix2x2(
              11, 21,
              12, 22
        );

        $m.transpose();
        assert_equal($m, $n, "cannot tranpose numerical");
    }
	
    method test_non_square_mem_tranpose_numerical() {
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := 11;
        $m{Key.new(0,1)} := 12;
        $m{Key.new(0,2)} := 13;
        $m{Key.new(1,0)} := 21;
        $m{Key.new(1,1)} := 22;
        $m{Key.new(1,2)} := 23;

        my $n := self.factory.matrix();
        $n{Key.new(0,0)} := 11;
        $n{Key.new(0,1)} := 21;
        $n{Key.new(1,0)} := 12;
        $n{Key.new(1,1)} := 22;
        $n{Key.new(2,0)} := 13;
        $n{Key.new(2,1)} := 23;

        $m.transpose();
        assert_equal($m, $n, "cannot transpose numerical matrix with non-square dimensions");
    }
}
