my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::PMCMatrix2D);
Rosella::Test::test(Test::PMCMatrix2D::ItemAt, :context($context));

class Test::PMCMatrix2D::ItemAt is Pla::Methods::ItemAt {

}
