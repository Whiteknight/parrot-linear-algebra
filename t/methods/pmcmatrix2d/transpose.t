my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::PMCMatrix2D);
Rosella::Test::test(Test::PMCMatrix2D::Transpose, :context($context));

class Test::PMCMatrix2D::Transpose is Pla::Methods::Transpose {

}
