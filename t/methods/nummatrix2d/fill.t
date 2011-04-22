my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::Fill, :context($context));

class Test::NumMatrix2D::Fill is Pla::Methods::Fill {

    method test_fill_numerical() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix2x2(4, 4, 4, 4);

        $m.fill(4);

        Assert::equal($m, $n, "cannot fill numerical");
    }

    method test_fill_with_resizing_numerical() {
        my $m := $!context.factory.matrix();
        my $n := $!context.factory.matrix3x3(2, 2, 2,
                                        2, 2, 2,
                                        2, 2, 2);

        $m.fill(2, 3, 3);

        Assert::equal($m, $n, "cannot fill (with resize) numerical");
    }
}
