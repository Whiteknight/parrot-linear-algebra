class Pla::Methods::InitializeFromArray is Pla::MatrixTestBase {
    # Test that we can initialize from an array
    method test_initialize_from_array() {
        my $a := [self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                  self.factory.fancyvalue(2), self.factory.fancyvalue(3)];
        my $m := self.factory.matrix2x2(self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                self.factory.fancyvalue(2), self.factory.fancyvalue(3));
        my $n := self.factory.matrix();
        $n.initialize_from_array(2, 2, $a);
        assert_equal($n, $m, "cannot initialize_from_array");
    }

    # Test that we can initialize from array, including zero padding
    method test_null_pad_extra_items() {
        my $a := [self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                  self.factory.fancyvalue(2), self.factory.fancyvalue(3)];
        my $m := self.factory.matrix3x3(self.factory.fancyvalue(0), self.factory.fancyvalue(1), self.factory.fancyvalue(2),
                                self.factory.fancyvalue(3), self.factory.nullvalue,     self.factory.nullvalue,
                                self.factory.nullvalue,     self.factory.nullvalue,     self.factory.nullvalue);
        my $n := self.factory.matrix();
        $n.initialize_from_array(3, 3, $a);
        assert_equal($n, $m, "cannot initalize from array with zero padding");
    }

    # Test that when we initialize from an array, that we only use as many
    # values as required
    method test_ignore_extra_values() {
        my $a := [self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                  self.factory.fancyvalue(2), self.factory.fancyvalue(3)];
        my $m := self.factory.matrix();
        $m{Key.new(0,0)} := self.factory.fancyvalue(0);
        my $n := self.factory.matrix();
        $n.initialize_from_array(1, 1, $a);
        assert_equal($n, $m, "cannot initialize from array undersized");
    }

}
