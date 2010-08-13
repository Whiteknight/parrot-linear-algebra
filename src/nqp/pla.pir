
.namespace []
.sub "_block11"  :anon :subid("10_1281738242.41929")
.annotate 'line', 0
    .const 'Sub' $P18 = "12_1281738242.41929" 
    capture_lex $P18
.annotate 'line', 1
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    .return ()
    .const 'Sub' $P14 = "11_1281738242.41929" 
    .return ($P14)
.end


.namespace []
.sub "" :load :init :subid("post13") :outer("10_1281738242.41929")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1281738242.41929" 
    .local pmc block
    set block, $P12
.annotate 'line', 1
    .const 'Sub' $P18 = "12_1281738242.41929" 
    capture_lex $P18
    $P18()
.end


.namespace []
.sub "_block17"  :anon :subid("12_1281738242.41929") :outer("10_1281738242.41929")
.annotate 'line', 3
    new $P19, "Undef"
    .lex "$pla", $P19
.annotate 'line', 2
    new $P20, "String"
    assign $P20, "P6object.pbc"
    set $S21, $P20
    load_bytecode $S21
.annotate 'line', 3
    new $P22, "String"
    assign $P22, "./dynext/linalg_group"
    set $S23, $P22
    loadlib $P24, $S23
    store_lex "$pla", $P24
.annotate 'line', 4
    new $P25, "String"
    assign $P25, "$PLALibrary"
    set $S26, $P25
    find_lex $P27, "$pla"
    set_hll_global $S26, $P27
.annotate 'line', 5
    get_hll_global $P28, "P6metaclass"
    $P28."register"("NumMatrix2D")
.annotate 'line', 6
    get_hll_global $P29, "P6metaclass"
    $P29."register"("PMCMatrix2D")
.annotate 'line', 7
    get_hll_global $P30, "P6metaclass"
    $P31 = $P30."register"("ComplexMatrix2D")
.annotate 'line', 1
    .return ($P31)
.end


.namespace []
.sub "_block13" :load :anon :subid("11_1281738242.41929")
.annotate 'line', 1
    .const 'Sub' $P15 = "10_1281738242.41929" 
    $P16 = $P15()
    .return ($P16)
.end

