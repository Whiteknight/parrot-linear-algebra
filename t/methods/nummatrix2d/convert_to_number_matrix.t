my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::ConvertToNumberMatrix, :context($context));

class Test::NumMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {
}
