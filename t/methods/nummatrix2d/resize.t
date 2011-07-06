my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
my $asserter := Pla::MatrixAsserter.new;
Rosella::Test::test(Test::NumMatrix2D::Resize, :context($context), :asserter($asserter));

class Test::NumMatrix2D::Resize is Pla::Methods::Resize {

    # resize method should never shrink a matrix
    method test_resize_to_smaller_numerical() {
        my $m := $!context.factory.matrix3x3(11, 12, 13,
                                      21, 22, 23,
                                      31, 32, 33);

        my $n := pir::clone($m);

        $m.resize(1,1);

        $!assert.equal($m, $n, "resize should not shrink the matrix");
    }

    method test_resize_to_bigger_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        my $n := $!context.factory.matrix3x3(11, 12,  0,
                                        21, 22,  0,
                                         0,  0,  0);

        $m.resize(3,3);

        $!assert.equal($m, $n, "cannot resize with numerical matrix");
    }

    method test_resize_to_same_size_numerical() {
        my $m := $!context.factory.matrix2x2(11, 12,
                                        21, 22);

        my $n := pir::clone($m);

        $n.resize(2,2);

        $!assert.equal($m, $n, "resize to same size is changing numerical matrix");
    }
}
