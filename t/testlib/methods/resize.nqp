class Pla::Methods::Resize is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test the resize method
    method test_resize() {
        my $m := self.factory.matrix();
        $m.resize(3,3);
        self.AssertSize($m, 3, 3);
    }

    # Test that we cannot shrink a matrix using the resize method
    method test_resize_does_not_shrink() {
        my $m := self.factory.matrix();
        $m.resize(3,3);
        $m.resize(1,1);
        self.AssertSize($m, 3, 3);
    }

    # Test that resize method with negative indices does nothing
    method test_negative_indices() {
        my $m := self.factory.matrix();
        $m.resize(-1, -1);
        self.AssertSize($m, 0, 0);
    }

}
