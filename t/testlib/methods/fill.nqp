class Pla::Methods::Fill is Pla::MatrixTestBase {
    # Test that we can fill a matrix
    method test_fill() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix2x2(
            $!context.factory.fancyvalue(0),
            $!context.factory.fancyvalue(0),
            $!context.factory.fancyvalue(0),
            $!context.factory.fancyvalue(0)
        );
        $m.fill($!context.factory.fancyvalue(0));
        Assert::equal($n, $m, "Cannot fill");
    }

    # test that the fill method can be used to resize the matrix
    method test_fill_with_resizing() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix();
        $n.fill($!context.factory.defaultvalue(), 2, 2);
        Assert::equal($n, $m, "Cannot fill+Resize");
    }
}
