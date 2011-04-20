class Pla::Methods::InitializeFromArgs is Pla::MatrixTestBase {
    # Test that we can initialize from a list of arguments
    method test_initialize_from_args() {
        my $m := $!context.factory.matrix2x2(self.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                $!context.factory.fancyvalue(2), self.factory.fancyvalue(3));
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(2, 2, $!context.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                      $!context.factory.fancyvalue(2), self.factory.fancyvalue(3));
        Assert::equal($n, $m, "cannot initialize_from_args");
    }

    # Test that we can initialize from an arg list with zero padding
    method test_null_pad_extra_spaces() {
        my $m := $!context.factory.matrix3x3(self.factory.fancyvalue(0), self.factory.fancyvalue(1), self.factory.fancyvalue(2),
                                $!context.factory.fancyvalue(3), self.factory.nullvalue,     self.factory.nullvalue,
                                $!context.factory.nullvalue,     self.factory.nullvalue,     self.factory.nullvalue);
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(3, 3, $!context.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                      $!context.factory.fancyvalue(2), self.factory.fancyvalue(3));
        Assert::equal($n, $m, "cannot initalize from args with zero padding");
    }

    # Test that we can initialize from an arg list, ignoring values that we
    # don't need
    method test_ignore_extra_values() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := self.factory.fancyvalue(0);
        my $n := $!context.factory.matrix();
        $n.initialize_from_args(1, 1, $!context.factory.fancyvalue(0), self.factory.fancyvalue(1),
                                      $!context.factory.fancyvalue(2), self.factory.fancyvalue(3));
        Assert::equal($n, $m, "cannot initialize from args undersized");
    }


}
