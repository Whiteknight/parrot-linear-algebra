INIT {
    my $rosella := pir::load_bytecode__Ps("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('t/testlib/pla_test.pbc', "load");
}
Pla::MatrixTestBase::Test(Test::ComplexMatrix2D::RowSwap, Pla::MatrixFactory::ComplexMatrix2D);

class Test::ComplexMatrix2D::RowSwap is Pla::Methods::RowSwap {

}
