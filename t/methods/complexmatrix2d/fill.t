my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::Fill, :context($context));

class Test::ComplexMatrix2D::Fill is Pla::Methods::Fill {

    # Test that we can fill a matrix
    method test_fill_complex() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix2x2(
            "1+1i",
            "1+1i",
            "1+1i",
            "1+1i"
        );
        $m.fill("1+1i");
        $!assert.equal($n, $m, "Cannot fill complex");
    }

    # test that the fill method can be used to resize the matrix
    method test_fill_with_resizing_complex() {
        my $m := $!context.factory.matrix2x2(
            "1+1i", "1+1i",
            "1+1i", "1+1i"
        );

        my $n := $!context.factory.matrix();

        $n.fill("1+1i", 2, 2);
        $!assert.equal($n, $m, "Cannot fill+Resize complex");
    }

    method test_fill_array() {
        my $m := $!context.factory.defaultmatrix2x2();
        my $n := $!context.factory.matrix2x2(
            "1+1i",
            "1+1i",
            "1+1i",
            "1+1i"
        );
        my $array := (1, 1);
        $m.fill($array);
        $!assert.equal($n, $m, "Cannot fill using an array");
    }

    method test_fill_with_resizing_array() {
        my $m := $!context.factory.matrix2x2(
            "1+1i", "1+1i",
            "1+1i", "1+1i"
        );

        my $n := $!context.factory.matrix();

        my $array := (1, 1);
        $n.fill($array, 2, 2);
        $!assert.equal($n, $m, "Cannot fill+Resize using an array");
    }
}
