my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::RowScale, :context($context));

class Test::ComplexMatrix2D::RowScale is Pla::Methods::RowScale {

}
