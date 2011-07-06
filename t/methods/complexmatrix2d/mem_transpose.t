my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::MemTranspose, :context($context));

class Test::ComplexMatrix2D::MemTranspose is Pla::Methods::MemTranspose {

    method test_mem_transpose_complex() {
        my $m := $!context.factory.matrix2x2(
            "1+1i",
            "2+2i",
            "3+3i",
            "4+4i"
        );
        my $n := $!context.factory.matrix2x2(
            "1+1i",
            "3+3i",
            "2+2i",
            "4+4i"
        );
        $m.mem_transpose();
        $!assert.equal($n, $m, "cannot mem_transpose complex matrix");
    }

    method test_non_square_matrix_complex() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := "1+1i";
        $m{$!context.factory.key(0,1)} := "2+2i";
        $m{$!context.factory.key(0,2)} := "3+3i";
        $m{$!context.factory.key(0,3)} := "4+4i";

        my $n := $!context.factory.matrix();
        $n{$!context.factory.key(0,0)} := "1+1i";
        $n{$!context.factory.key(1,0)} := "2+2i";
        $n{$!context.factory.key(2,0)} := "3+3i";
        $n{$!context.factory.key(3,0)} := "4+4i";

        $m.mem_transpose();
        $!assert.equal($m, $n, "cannot mem_transpose complex matrix with non-square dimensions");
    }
}
