my $context := PLA::TestContext.new;
$context.set_factory(Pla::MatrixFactory::ComplexMatrix2D);
Rosella::Test::test(Test::ComplexMatrix2D::Conjugate, :context($context));

class Test::ComplexMatrix2D::Conjugate is Pla::MatrixTestBase {

    method test_conjugate() {
        my $m := $!context.factory.matrix2x2("1+1i", "2+2i", "3+3i", "4+4i");
        my $n := $!context.factory.matrix2x2("1-1i", "2-2i", "3-3i", "4-4i");
        $m.conjugate();
        Assert::equal($m, $n, "conjugate does not work");
    }

    method test_conjugate_non_square() {
        my $m := $!context.factory.matrix();
        $m{$!context.factory.key(0,0)} := "1+1i";
        $m{$!context.factory.key(0,1)} := "2+2i";
        $m{$!context.factory.key(0,2)} := "3+3i";
        $m{$!context.factory.key(0,3)} := "4+4i";

        my $n := $!context.factory.matrix();
        $n{$!context.factory.key(0,0)} := "1-1i";
        $n{$!context.factory.key(0,1)} := "2-2i";
        $n{$!context.factory.key(0,2)} := "3-3i";
        $n{$!context.factory.key(0,3)} := "4-4i";

        $m.conjugate();
        Assert::equal($m, $n, "non-square conjugate does not work");
    }
}
