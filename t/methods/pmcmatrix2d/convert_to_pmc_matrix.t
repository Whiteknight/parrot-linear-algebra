my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::PMCMatrix2D);
Rosella::Test::test(Test::PMCMatrix2D::ConvertToPmcMatrix, :context($context));

class Test::PMCMatrix2D::ConvertToPmcMatrix is Pla::Methods::ConvertToPmcMatrix {

}
