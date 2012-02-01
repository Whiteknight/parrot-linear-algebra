class Pla::Methods::Resize is Pla::MatrixTestBase {
    # Test the resize method
    method test_resize() {
        my $m := $!context.factory.matrix();
        $m.resize(3,3);
        $!assert.Size($m, 3, 3);
    }

    # Test that we cannot shrink a matrix using the resize method
    method test_resize_does_not_shrink() {
        my $m := $!context.factory.matrix();
        $m.resize(3,3);
        $m.resize(1,1);
        $!assert.Size($m, 3, 3);
    }

    # Test that resize method with negative indices does nothing
    method test_negative_indices() {
        my $m := $!context.factory.matrix();
        $m.resize(-1, -1);
        $!assert.Size($m, 0, 0);
    }
}
