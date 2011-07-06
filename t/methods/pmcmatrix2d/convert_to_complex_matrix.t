my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::PMCMatrix2D);
my $asserter := Pla::MatrixAsserter.new;
Rosella::Test::test(Test::PMCMatrix2D::ConvertToComplexMatrix, :context($context), :asserter($asserter));

class Test::PMCMatrix2D::ConvertToComplexMatrix is Pla::Methods::ConvertToComplexMatrix {

}
