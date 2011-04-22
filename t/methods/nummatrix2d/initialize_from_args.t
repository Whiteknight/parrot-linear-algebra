my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::NumMatrix2D);
Rosella::Test::test(Test::NumMatrix2D::InitializeFromArgs, :context($context));

class Test::NumMatrix2D::InitializeFromArgs is Pla::Methods::InitializeFromArgs {

}
