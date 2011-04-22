class Pla::Methods::MemTranspose is Pla::MatrixTestBase {
    # Test mem transposing square matrices
    method test_mem_transpose() {
        my $m := $!context.factory.matrix2x2(
            $!context.factory.fancyvalue(0),
            $!context.factory.fancyvalue(1),
            $!context.factory.fancyvalue(2),
            $!context.factory.fancyvalue(3)
        );
        my $n := $!context.factory.matrix2x2(
            $!context.factory.fancyvalue(0),
            $!context.factory.fancyvalue(2),
            $!context.factory.fancyvalue(1),
            $!context.factory.fancyvalue(3)
        );
        $m.mem_transpose();
        Assert::equal($n, $m, "cannot mem_transpose matrix");
    }

    # Test mem transposing non-square matrices
    method test_non_square_matrix() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := $!context.factory.fancyvalue(0);
        $m{$!context.factory.key(0,1)} := $!context.factory.fancyvalue(1);
        $m{$!context.factory.key(0,2)} := $!context.factory.fancyvalue(2);
        $m{$!context.factory.key(0,3)} := $!context.factory.fancyvalue(3);

        my $n := $!context.factory.matrix();
        $n{$!context.factory.key(0,0)} := $!context.factory.fancyvalue(0);
        $n{$!context.factory.key(1,0)} := $!context.factory.fancyvalue(1);
        $n{$!context.factory.key(2,0)} := $!context.factory.fancyvalue(2);
        $n{$!context.factory.key(3,0)} := $!context.factory.fancyvalue(3);

        $m.mem_transpose();
        Assert::equal($m, $n, "cannot mem_transpose with non-square dimensions");
    }

}
