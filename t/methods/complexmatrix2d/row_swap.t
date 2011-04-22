my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::RowSwap, :context($context));

class Test::ComplexMatrix2D::RowSwap is Pla::Methods::RowSwap {

}
