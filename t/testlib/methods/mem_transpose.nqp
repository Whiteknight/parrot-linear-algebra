class Pla::Methods::MemTranspose is Pla::MatrixTestBase {

    INIT {
        use('UnitTest::Testcase');
        use('UnitTest::Assertions');
    }

    # Test mem transposing square matrices
    method test_mem_transpose() {
        my $m := self.factory.matrix2x2(
            self.factory.fancyvalue(0),
            self.factory.fancyvalue(1),
            self.factory.fancyvalue(2),
            self.factory.fancyvalue(3)
        );
        my $n := self.factory.matrix2x2(
            self.factory.fancyvalue(0),
            self.factory.fancyvalue(2),
            self.factory.fancyvalue(1),
            self.factory.fancyvalue(3)
        );
        $m.mem_transpose();
        assert_equal($n, $m, "cannot mem_transpose matrix");
    }

    # Test mem transposing non-square matrices
    method test_non_square_matrix() {
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := self.factory.fancyvalue(0);
        $m{Key.new(0,1)} := self.factory.fancyvalue(1);
        $m{Key.new(0,2)} := self.factory.fancyvalue(2);
        $m{Key.new(0,3)} := self.factory.fancyvalue(3);

        my $n := self.factory.matrix();
        $n{Key.new(0,0)} := self.factory.fancyvalue(0);
        $n{Key.new(1,0)} := self.factory.fancyvalue(1);
        $n{Key.new(2,0)} := self.factory.fancyvalue(2);
        $n{Key.new(3,0)} := self.factory.fancyvalue(3);

        $m.mem_transpose();
        assert_equal($m, $n, "cannot mem_transpose with non-square dimensions");
    }

}
