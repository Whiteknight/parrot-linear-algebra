INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::NumMatrix2D::ConvertToPmcMatrix, Pla::MatrixFactory::NumMatrix2D);

class Test::NumMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {
}
