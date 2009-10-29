.sub main :main
    .local pmc lib

    lib = loadlib "linalg_group"
    unless lib goto not_loaded
    say "library loaded successfully."

    $P0 = new 'NumMatrix2D'
    $P0.'resize'(2,2)
    $P0[0;0] = 1
    $P0[1;0] = 2
    $P0[0;1] = 1
    $P0[1;1] = 3

    $P1 = new 'NumMatrix2D'
    $P1.'resize'(2,2)
    $P1[0;0] = 3
    $P1[1;1] = 4

    say $P0
    say $P1

    $P2 = $P0 * $P1
    $P0.'transpose'()
    $P3 = $P1 * $P0
    $P3.'transpose'()

    say $P2
    say $P3

    end

  not_loaded:
    say "Could not load library"
.end
