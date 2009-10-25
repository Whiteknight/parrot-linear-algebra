.sub main :main
  .local pmc lib

  lib = loadlib "NumMatrix2D"
  unless lib goto not_loaded
  say "library loaded successfully."

  $P1 = new 'NumMatrix2D'
  $P1.'resize'(5,5)
  $P1[1;1] = 4.
  $S1 = $P1
  say $S1

  $P2 = new 'NumMatrix2D'
  $P2.'resize'(5,5)
  $P2[1;1] = 3.
  $P2[1;2] = 4.
  $S2 = $P2
  say $S2

  $P3 = $P1 + $P2
  $S3 = $P3
  say $S3

  end

not_loaded:
  say "Could not load library."
.end
