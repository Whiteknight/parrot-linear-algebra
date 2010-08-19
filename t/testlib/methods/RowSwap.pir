
.namespace []
.sub "_block11"  :anon :subid("10_1282252101.93213")
.annotate 'line', 0
    get_hll_global $P14, ["Pla";"Methods";"RowSwap"], "_block13" 
    capture_lex $P14
.annotate 'line', 1
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    get_hll_global $P14, ["Pla";"Methods";"RowSwap"], "_block13" 
    capture_lex $P14
    $P149 = $P14()
    .return ($P149)
    .const 'Sub' $P151 = "21_1282252101.93213" 
    .return ($P151)
.end


.namespace []
.sub "" :load :init :subid("post22") :outer("10_1282252101.93213")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1282252101.93213" 
    .local pmc block
    set block, $P12
    $P154 = get_root_global ["parrot"], "P6metaclass"
    $P154."new_class"("Pla::Methods::RowSwap", "Pla::MatrixTestBase" :named("parent"))
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "_block13"  :subid("11_1282252101.93213") :outer("10_1282252101.93213")
.annotate 'line', 1
    .const 'Sub' $P133 = "19_1282252101.93213" 
    capture_lex $P133
    .const 'Sub' $P118 = "17_1282252101.93213" 
    capture_lex $P118
    .const 'Sub' $P103 = "15_1282252101.93213" 
    capture_lex $P103
    .const 'Sub' $P88 = "13_1282252101.93213" 
    capture_lex $P88
    .const 'Sub' $P15 = "12_1282252101.93213" 
    capture_lex $P15
.annotate 'line', 49
    .const 'Sub' $P133 = "19_1282252101.93213" 
    newclosure $P148, $P133
.annotate 'line', 1
    .return ($P148)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "" :load :init :subid("post23") :outer("11_1282252101.93213")
.annotate 'line', 1
    get_hll_global $P14, ["Pla";"Methods";"RowSwap"], "_block13" 
    .local pmc block
    set block, $P14
.annotate 'line', 4
    "use"("UnitTest::Testcase")
.annotate 'line', 5
    "use"("UnitTest::Assertions")
.end


.namespace ["Pla";"Methods";"RowSwap"]
.include "except_types.pasm"
.sub "test_METHOD_row_swap"  :subid("12_1282252101.93213") :method :outer("11_1282252101.93213")
.annotate 'line', 8
    new $P17, 'ExceptionHandler'
    set_addr $P17, control_16
    $P17."handle_types"(.CONTROL_RETURN)
    push_eh $P17
    .lex "self", self
.annotate 'line', 9
    new $P18, "Undef"
    .lex "$A", $P18
.annotate 'line', 15
    new $P19, "Undef"
    .lex "$B", $P19
.annotate 'line', 9
    find_lex $P20, "self"
    $P21 = $P20."factory"()
    $P22 = $P21."matrix"()
    store_lex "$A", $P22
.annotate 'line', 10
    find_lex $P23, "$A"
.annotate 'line', 11
    find_lex $P24, "self"
    $P25 = $P24."factory"()
    $P26 = $P25."fancyvalue"(0)
    find_lex $P27, "self"
    $P28 = $P27."factory"()
    $P29 = $P28."fancyvalue"(0)
    find_lex $P30, "self"
    $P31 = $P30."factory"()
    $P32 = $P31."fancyvalue"(0)
.annotate 'line', 12
    find_lex $P33, "self"
    $P34 = $P33."factory"()
    $P35 = $P34."fancyvalue"(1)
    find_lex $P36, "self"
    $P37 = $P36."factory"()
    $P38 = $P37."fancyvalue"(1)
    find_lex $P39, "self"
    $P40 = $P39."factory"()
    $P41 = $P40."fancyvalue"(1)
.annotate 'line', 13
    find_lex $P42, "self"
    $P43 = $P42."factory"()
    $P44 = $P43."fancyvalue"(2)
    find_lex $P45, "self"
    $P46 = $P45."factory"()
    $P47 = $P46."fancyvalue"(2)
    find_lex $P48, "self"
    $P49 = $P48."factory"()
    $P50 = $P49."fancyvalue"(2)
    $P23."initialize_from_args"(3, 3, $P26, $P29, $P32, $P35, $P38, $P41, $P44, $P47, $P50)
.annotate 'line', 15
    find_lex $P51, "self"
    $P52 = $P51."factory"()
    $P53 = $P52."matrix"()
    store_lex "$B", $P53
.annotate 'line', 16
    find_lex $P54, "$B"
.annotate 'line', 17
    find_lex $P55, "self"
    $P56 = $P55."factory"()
    $P57 = $P56."fancyvalue"(1)
    find_lex $P58, "self"
    $P59 = $P58."factory"()
    $P60 = $P59."fancyvalue"(1)
    find_lex $P61, "self"
    $P62 = $P61."factory"()
    $P63 = $P62."fancyvalue"(1)
.annotate 'line', 18
    find_lex $P64, "self"
    $P65 = $P64."factory"()
    $P66 = $P65."fancyvalue"(2)
    find_lex $P67, "self"
    $P68 = $P67."factory"()
    $P69 = $P68."fancyvalue"(2)
    find_lex $P70, "self"
    $P71 = $P70."factory"()
    $P72 = $P71."fancyvalue"(2)
.annotate 'line', 19
    find_lex $P73, "self"
    $P74 = $P73."factory"()
    $P75 = $P74."fancyvalue"(0)
    find_lex $P76, "self"
    $P77 = $P76."factory"()
    $P78 = $P77."fancyvalue"(0)
    find_lex $P79, "self"
    $P80 = $P79."factory"()
    $P81 = $P80."fancyvalue"(0)
    $P54."initialize_from_args"(3, 3, $P57, $P60, $P63, $P66, $P69, $P72, $P75, $P78, $P81)
.annotate 'line', 20
    find_lex $P82, "$A"
    $P82."row_swap"(0, 2)
.annotate 'line', 21
    find_lex $P83, "$A"
    $P83."row_swap"(0, 1)
.annotate 'line', 22
    find_lex $P84, "$A"
    find_lex $P85, "$B"
    $P86 = "assert_equal"($P84, $P85, "cannot row_swap")
.annotate 'line', 8
    .return ($P86)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P87, exception, "payload"
    .return ($P87)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.include "except_types.pasm"
.sub "test_METHOD_row_swap_NEGINDICES_A"  :subid("13_1282252101.93213") :method :outer("11_1282252101.93213")
.annotate 'line', 25
    .const 'Sub' $P93 = "14_1282252101.93213" 
    capture_lex $P93
    new $P90, 'ExceptionHandler'
    set_addr $P90, control_89
    $P90."handle_types"(.CONTROL_RETURN)
    push_eh $P90
    .lex "self", self
.annotate 'line', 26
    get_hll_global $P91, ["Exception"], "OutOfBounds"
.annotate 'line', 27
    .const 'Sub' $P93 = "14_1282252101.93213" 
    newclosure $P100, $P93
    $P101 = "assert_throws"($P91, "Index A is out of bounds", $P100)
.annotate 'line', 25
    .return ($P101)
  control_89:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P102, exception, "payload"
    .return ($P102)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "_block92"  :anon :subid("14_1282252101.93213") :outer("13_1282252101.93213")
.annotate 'line', 28
    new $P94, "Undef"
    .lex "$A", $P94
    find_lex $P95, "self"
    $P96 = $P95."factory"()
    $P97 = $P96."defaultmatrix3x3"()
    store_lex "$A", $P97
.annotate 'line', 29
    find_lex $P98, "$A"
    $P99 = $P98."row_swap"(-1, 1)
.annotate 'line', 27
    .return ($P99)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.include "except_types.pasm"
.sub "test_METHOD_row_swap_BOUNDS_A"  :subid("15_1282252101.93213") :method :outer("11_1282252101.93213")
.annotate 'line', 33
    .const 'Sub' $P108 = "16_1282252101.93213" 
    capture_lex $P108
    new $P105, 'ExceptionHandler'
    set_addr $P105, control_104
    $P105."handle_types"(.CONTROL_RETURN)
    push_eh $P105
    .lex "self", self
.annotate 'line', 34
    get_hll_global $P106, ["Exception"], "OutOfBounds"
.annotate 'line', 35
    .const 'Sub' $P108 = "16_1282252101.93213" 
    newclosure $P115, $P108
    $P116 = "assert_throws"($P106, "Index A is out of bounds", $P115)
.annotate 'line', 33
    .return ($P116)
  control_104:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P117, exception, "payload"
    .return ($P117)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "_block107"  :anon :subid("16_1282252101.93213") :outer("15_1282252101.93213")
.annotate 'line', 36
    new $P109, "Undef"
    .lex "$A", $P109
    find_lex $P110, "self"
    $P111 = $P110."factory"()
    $P112 = $P111."defaultmatrix3x3"()
    store_lex "$A", $P112
.annotate 'line', 37
    find_lex $P113, "$A"
    $P114 = $P113."row_swap"(7, 1)
.annotate 'line', 35
    .return ($P114)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.include "except_types.pasm"
.sub "test_METHOD_row_swap_NEGINDICES_B"  :subid("17_1282252101.93213") :method :outer("11_1282252101.93213")
.annotate 'line', 41
    .const 'Sub' $P123 = "18_1282252101.93213" 
    capture_lex $P123
    new $P120, 'ExceptionHandler'
    set_addr $P120, control_119
    $P120."handle_types"(.CONTROL_RETURN)
    push_eh $P120
    .lex "self", self
.annotate 'line', 42
    get_hll_global $P121, ["Exception"], "OutOfBounds"
.annotate 'line', 43
    .const 'Sub' $P123 = "18_1282252101.93213" 
    newclosure $P130, $P123
    $P131 = "assert_throws"($P121, "Index B is out of bounds", $P130)
.annotate 'line', 41
    .return ($P131)
  control_119:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P132, exception, "payload"
    .return ($P132)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "_block122"  :anon :subid("18_1282252101.93213") :outer("17_1282252101.93213")
.annotate 'line', 44
    new $P124, "Undef"
    .lex "$A", $P124
    find_lex $P125, "self"
    $P126 = $P125."factory"()
    $P127 = $P126."defaultmatrix3x3"()
    store_lex "$A", $P127
.annotate 'line', 45
    find_lex $P128, "$A"
    $P129 = $P128."row_swap"(1, -1)
.annotate 'line', 43
    .return ($P129)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.include "except_types.pasm"
.sub "test_METHOD_row_swap_BOUNDS_B"  :subid("19_1282252101.93213") :method :outer("11_1282252101.93213")
.annotate 'line', 49
    .const 'Sub' $P138 = "20_1282252101.93213" 
    capture_lex $P138
    new $P135, 'ExceptionHandler'
    set_addr $P135, control_134
    $P135."handle_types"(.CONTROL_RETURN)
    push_eh $P135
    .lex "self", self
.annotate 'line', 50
    get_hll_global $P136, ["Exception"], "OutOfBounds"
.annotate 'line', 51
    .const 'Sub' $P138 = "20_1282252101.93213" 
    newclosure $P145, $P138
    $P146 = "assert_throws"($P136, "Index B is out of bounds", $P145)
.annotate 'line', 49
    .return ($P146)
  control_134:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P147, exception, "payload"
    .return ($P147)
.end


.namespace ["Pla";"Methods";"RowSwap"]
.sub "_block137"  :anon :subid("20_1282252101.93213") :outer("19_1282252101.93213")
.annotate 'line', 52
    new $P139, "Undef"
    .lex "$A", $P139
    find_lex $P140, "self"
    $P141 = $P140."factory"()
    $P142 = $P141."defaultmatrix3x3"()
    store_lex "$A", $P142
.annotate 'line', 53
    find_lex $P143, "$A"
    $P144 = $P143."row_swap"(1, 7)
.annotate 'line', 51
    .return ($P144)
.end


.namespace []
.sub "_block150" :load :anon :subid("21_1282252101.93213")
.annotate 'line', 1
    .const 'Sub' $P152 = "10_1282252101.93213" 
    $P153 = $P152()
    .return ($P153)
.end

