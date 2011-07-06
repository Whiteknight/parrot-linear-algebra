my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
my $asserter := Pla::MatrixAsserter.new;
Rosella::Test::test(Test::ComplexMatrix2D::ConvertToNumberMatrix, :context($context), :asserter($asserter));

class Test::ComplexMatrix2D::ConvertToNumberMatrix is Pla::Methods::ConvertToNumberMatrix {

}
