INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::ComplexMatrix2D::InitializeFromArray, Pla::MatrixFactory::ComplexMatrix2D);

class Test::ComplexMatrix2D::InitializeFromArray is Pla::Methods::InitializeFromArray {

    method test_initialize_from_array_complex() {
        my $m := $!context.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(2, 2, [ "1+1i", "2+2i",
                                         "3+3i", "4+4i" ]);
        $!assert.equal($n, $m, "cannot initialize_from_array with complex matrix");
    }

	method test_initialize_from_array_array() {
        my $m := $!context.factory.matrix2x2("1+1i", "2+2i",
                                "3+3i", "4+4i");
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(2, 2, [ (1,1), (2,2),
                                         (3,3), (4,4) ]);
        $!assert.equal($n, $m, "cannot initialize_from_array with array");
    }

    method test_null_pad_extra_spaces_complex() {
        my $m := $!context.factory.matrix3x3("1+1i", "2+2i", "3+3i",
                                "4+4i", $!context.factory.nullvalue,     $!context.factory.nullvalue,
                                $!context.factory.nullvalue,     $!context.factory.nullvalue,     $!context.factory.nullvalue);
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(3, 3, [ "1+1i", "2+2i", "3+3i",
                                         "4+4i" ]);
        $!assert.equal($n, $m, "cannot initalize from array with zero padding with complex matrix");
    }

    method test_ignore_extra_values_complex() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := "1+1i";
        my $n := $!context.factory.matrix();
        $n.initialize_from_array(1, 1, [ "1+1i", "2+2i",
                                         "3+3i", "4+4i" ]);
        $!assert.equal($n, $m, "cannot initialize from array undersized with complex matrix");
    }
}
