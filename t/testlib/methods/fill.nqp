class Pla::Methods::Fill is Pla::MatrixTestBase {
    # Test that we can fill a matrix
    method test_fill() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix2x2(
            self.factory.fancyvalue(0),
            self.factory.fancyvalue(0),
            self.factory.fancyvalue(0),
            self.factory.fancyvalue(0)
        );
        $m.fill(self.factory.fancyvalue(0));
        assert_equal($n, $m, "Cannot fill");
    }

    # test that the fill method can be used to resize the matrix
    method test_fill_with_resizing() {
        my $m := self.factory.defaultmatrix2x2();
        my $n := self.factory.matrix();
        $n.fill(self.factory.defaultvalue(), 2, 2);
        assert_equal($n, $m, "Cannot fill+Resize");
    }
}
