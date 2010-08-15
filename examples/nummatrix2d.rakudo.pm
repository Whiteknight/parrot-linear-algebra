use v6;
use src::rakudo::nummatrix2d;

my $matrix = P6NumMatrix2D.new();
$matrix.fill(1.0, 2, 2);
say $matrix;

$matrix.set(1, 0, 3);
say $matrix;

$matrix.transpose();
say $matrix;

my $other = $matrix.map({$_ * 2;});
say $other;
