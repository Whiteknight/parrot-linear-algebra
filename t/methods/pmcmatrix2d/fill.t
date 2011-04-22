my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::PMCMatrix2D);
Rosella::Test::test(Test::PMCMatrix2D::Fill, :context($context));

class Test::PMCMatrix2D::Fill is Pla::Methods::Fill {

}
