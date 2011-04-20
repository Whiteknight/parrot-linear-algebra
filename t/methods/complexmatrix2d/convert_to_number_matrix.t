my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::ConvertToNumberMatrix, :context($context));

class Test::ComplexMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {

}
