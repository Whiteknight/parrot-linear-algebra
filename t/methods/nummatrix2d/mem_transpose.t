my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::MemTranspose, :context($context));

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
        Assert::equal($m, $n, "cannot tranpose numerical");
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
        Assert::equal($m, $n, "cannot transpose numerical matrix with non-square dimensions");
    }
}
