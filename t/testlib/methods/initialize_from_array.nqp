class Pla::Methods::InitializeFromArray is Pla::MatrixTestBase {
    # Test that we can initialize from an array
    method test_initialize_from_array() {
        my $a := [$!context.factory.fancyvalue(0), $!context.factory.fancyvalue(1),
                  $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3)];
        my $m := $!context.factory.matrix2x2($!context.factory.fancyvalue(0), $!context.factory.fancyvalue(1),
                                $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3));
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(2, 2, $a);
        $!assert.equal($n, $m, "cannot initialize_from_array");
    }

    # Test that we can initialize from array, including zero padding
    method test_null_pad_extra_items() {
        my $a := [$!context.factory.fancyvalue(0), $!context.factory.fancyvalue(1),
                  $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3)];
        my $m := $!context.factory.matrix3x3($!context.factory.fancyvalue(0), $!context.factory.fancyvalue(1), $!context.factory.fancyvalue(2),
                                $!context.factory.fancyvalue(3), $!context.factory.nullvalue,     $!context.factory.nullvalue,
                                $!context.factory.nullvalue,     $!context.factory.nullvalue,     $!context.factory.nullvalue);
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(3, 3, $a);
        $!assert.equal($n, $m, "cannot initalize from array with zero padding");
    }

    # Test that when we initialize from an array, that we only use as many
    # values as required
    method test_ignore_extra_values() {
        my $a := [$!context.factory.fancyvalue(0), $!context.factory.fancyvalue(1),
                  $!context.factory.fancyvalue(2), $!context.factory.fancyvalue(3)];
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := $!context.factory.fancyvalue(0);
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(1, 1, $a);
        $!assert.equal($n, $m, "cannot initialize from array undersized");
    }
}
