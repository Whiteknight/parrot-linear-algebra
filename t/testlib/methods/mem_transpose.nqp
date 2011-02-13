class Pla::Methods::MemTranspose is Pla::MatrixTestBase {
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
        Assert::equal($n, $m, "cannot mem_transpose matrix");
    }

    # Test mem transposing non-square matrices
    method test_non_square_matrix() {
        my $m := self.factory.matrix();
        $m{self.factory.key(0,0)} := self.factory.fancyvalue(0);
        $m{self.factory.key(0,1)} := self.factory.fancyvalue(1);
        $m{self.factory.key(0,2)} := self.factory.fancyvalue(2);
        $m{self.factory.key(0,3)} := self.factory.fancyvalue(3);

        my $n := self.factory.matrix();
        $n{self.factory.key(0,0)} := self.factory.fancyvalue(0);
        $n{self.factory.key(1,0)} := self.factory.fancyvalue(1);
        $n{self.factory.key(2,0)} := self.factory.fancyvalue(2);
        $n{self.factory.key(3,0)} := self.factory.fancyvalue(3);

        $m.mem_transpose();
        Assert::equal($m, $n, "cannot mem_transpose with non-square dimensions");
    }

}
