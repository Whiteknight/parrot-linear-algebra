my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::ConvertToComplexMatrix. :context($context));

class Test::ComplexMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {

}
