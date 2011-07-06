class Pla::Methods::Transpose is Pla::MatrixTestBase {
    # Test transposing square matrices
    method test_transpose() {
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
        $m.transpose();
        $!assert.equal($n, $m, "cannot transpose matrix");
    }

    # Test transposing non-square matrices
    method test_nonsquare_matrix_transpose() {
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

        $m.transpose();
        $!assert.equal($m, $n, "cannot transpose with non-square dimensions");
    }
}
