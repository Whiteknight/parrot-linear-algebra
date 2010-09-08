.sub test_main
    .include 'test_more.pir'
    say "1..1"

    test_get_pmc_keyed()
.end

#.HLL 'NumMatrix2D_HLL_Test'

.sub '' :anon :init :load
    $P0 = get_class ['Float']
    $P1 = subclass $P0, ['TestFloat']
    $P2 = getinterp
    $P2.'hll_map'($P0, $P1)
    .include 'test_more.pir'
.end

.sub is_TestFloat
    .param pmc arg
    $S0 = typeof arg
    'is'($S0, 'TestFloat')
.end

.sub test_get_pmc_keyed
    $P0 = new ['NumMatrix2D']
    $P0.'initialize_from_args'(2, 2, 1, 2, 3, 4)
    $P1 = $P0[0;0]
    is_TestFloat($P1)
.end

# .HLL 'parrot'
