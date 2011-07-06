my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
my $asserter := Pla::MatrixAsserter.new;
Rosella::Test::test(Test::NumMatrix2D::ConvertToPmcMatrix, :context($context), :asserter($asserter));

class Test::NumMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {
}
