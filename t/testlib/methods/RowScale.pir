
.namespace []
.sub "_block11"  :anon :subid("10_1282252087.81622")
.annotate 'line', 0
    get_hll_global $P14, ["Pla";"Methods";"RowScale"], "_block13" 
    capture_lex $P14
.annotate 'line', 1
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    get_hll_global $P14, ["Pla";"Methods";"RowScale"], "_block13" 
    capture_lex $P14
    $P129 = $P14()
    .return ($P129)
    .const 'Sub' $P131 = "17_1282252087.81622" 
    .return ($P131)
.end


.namespace []
.sub "" :load :init :subid("post18") :outer("10_1282252087.81622")
.annotate 'line', 0
    .const 'Sub' $P12 = "10_1282252087.81622" 
    .local pmc block
    set block, $P12
    $P134 = get_root_global ["parrot"], "P6metaclass"
    $P134."new_class"("Pla::Methods::RowScale", "Pla::MatrixTestBase" :named("parent"))
.end


.namespace ["Pla";"Methods";"RowScale"]
.sub "_block13"  :subid("11_1282252087.81622") :outer("10_1282252087.81622")
.annotate 'line', 1
    .const 'Sub' $P113 = "15_1282252087.81622" 
    capture_lex $P113
    .const 'Sub' $P98 = "13_1282252087.81622" 
    capture_lex $P98
    .const 'Sub' $P15 = "12_1282252087.81622" 
    capture_lex $P15
.annotate 'line', 34
    .const 'Sub' $P113 = "15_1282252087.81622" 
    newclosure $P128, $P113
.annotate 'line', 1
    .return ($P128)
.end


.namespace ["Pla";"Methods";"RowScale"]
.sub "" :load :init :subid("post19") :outer("11_1282252087.81622")
.annotate 'line', 1
    get_hll_global $P14, ["Pla";"Methods";"RowScale"], "_block13" 
    .local pmc block
    set block, $P14
.annotate 'line', 4
    "use"("UnitTest::Testcase")
.annotate 'line', 5
    "use"("UnitTest::Assertions")
.end


.namespace ["Pla";"Methods";"RowScale"]
.include "except_types.pasm"
.sub "test_METHOD_row_scale"  :subid("12_1282252087.81622") :method :outer("11_1282252087.81622")
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
    $P57 = $P56."fancyvalue"(0)
    mul $P58, $P57, 2
    find_lex $P59, "self"
    $P60 = $P59."factory"()
    $P61 = $P60."fancyvalue"(0)
    mul $P62, $P61, 2
    find_lex $P63, "self"
    $P64 = $P63."factory"()
    $P65 = $P64."fancyvalue"(0)
    mul $P66, $P65, 2
.annotate 'line', 18
    find_lex $P67, "self"
    $P68 = $P67."factory"()
    $P69 = $P68."fancyvalue"(1)
    mul $P70, $P69, 3
    find_lex $P71, "self"
    $P72 = $P71."factory"()
    $P73 = $P72."fancyvalue"(1)
    mul $P74, $P73, 3
    find_lex $P75, "self"
    $P76 = $P75."factory"()
    $P77 = $P76."fancyvalue"(1)
    mul $P78, $P77, 3
.annotate 'line', 19
    find_lex $P79, "self"
    $P80 = $P79."factory"()
    $P81 = $P80."fancyvalue"(2)
    mul $P82, $P81, 4
    find_lex $P83, "self"
    $P84 = $P83."factory"()
    $P85 = $P84."fancyvalue"(2)
    mul $P86, $P85, 4
    find_lex $P87, "self"
    $P88 = $P87."factory"()
    $P89 = $P88."fancyvalue"(2)
    mul $P90, $P89, 4
    $P54."initialize_from_args"(3, 3, $P58, $P62, $P66, $P70, $P74, $P78, $P82, $P86, $P90)
.annotate 'line', 20
    find_lex $P91, "$A"
    $P91."row_scale"(0, 2)
.annotate 'line', 21
    find_lex $P92, "$A"
    $P92."row_scale"(1, 3)
.annotate 'line', 22
    find_lex $P93, "$A"
    $P93."row_scale"(2, 4)
.annotate 'line', 23
    find_lex $P94, "$A"
    find_lex $P95, "$B"
    $P96 = "assert_equal"($P94, $P95, "cannot scale rows")
.annotate 'line', 8
    .return ($P96)
  control_16:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P97, exception, "payload"
    .return ($P97)
.end


.namespace ["Pla";"Methods";"RowScale"]
.include "except_types.pasm"
.sub "test_METHOD_row_scale_NEGINDICES"  :subid("13_1282252087.81622") :method :outer("11_1282252087.81622")
.annotate 'line', 26
    .const 'Sub' $P103 = "14_1282252087.81622" 
    capture_lex $P103
    new $P100, 'ExceptionHandler'
    set_addr $P100, control_99
    $P100."handle_types"(.CONTROL_RETURN)
    push_eh $P100
    .lex "self", self
.annotate 'line', 27
    get_hll_global $P101, ["Exception"], "OutOfBounds"
.annotate 'line', 28
    .const 'Sub' $P103 = "14_1282252087.81622" 
    newclosure $P110, $P103
    $P111 = "assert_throws"($P101, "index is negative", $P110)
.annotate 'line', 26
    .return ($P111)
  control_99:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P112, exception, "payload"
    .return ($P112)
.end


.namespace ["Pla";"Methods";"RowScale"]
.sub "_block102"  :anon :subid("14_1282252087.81622") :outer("13_1282252087.81622")
.annotate 'line', 29
    new $P104, "Undef"
    .lex "$A", $P104
    find_lex $P105, "self"
    $P106 = $P105."factory"()
    $P107 = $P106."defaultmatrix3x3"()
    store_lex "$A", $P107
.annotate 'line', 30
    find_lex $P108, "$A"
    $P109 = $P108."row_scale"(-1, 1)
.annotate 'line', 28
    .return ($P109)
.end


.namespace ["Pla";"Methods";"RowScale"]
.include "except_types.pasm"
.sub "test_METHOD_row_scale_BOUNDS"  :subid("15_1282252087.81622") :method :outer("11_1282252087.81622")
.annotate 'line', 34
    .const 'Sub' $P118 = "16_1282252087.81622" 
    capture_lex $P118
    new $P115, 'ExceptionHandler'
    set_addr $P115, control_114
    $P115."handle_types"(.CONTROL_RETURN)
    push_eh $P115
    .lex "self", self
.annotate 'line', 35
    get_hll_global $P116, ["Exception"], "OutOfBounds"
.annotate 'line', 36
    .const 'Sub' $P118 = "16_1282252087.81622" 
    newclosure $P125, $P118
    $P126 = "assert_throws"($P116, "index is negative", $P125)
.annotate 'line', 34
    .return ($P126)
  control_114:
    .local pmc exception 
    .get_results (exception) 
    getattribute $P127, exception, "payload"
    .return ($P127)
.end


.namespace ["Pla";"Methods";"RowScale"]
.sub "_block117"  :anon :subid("16_1282252087.81622") :outer("15_1282252087.81622")
.annotate 'line', 37
    new $P119, "Undef"
    .lex "$A", $P119
    find_lex $P120, "self"
    $P121 = $P120."factory"()
    $P122 = $P121."defaultmatrix3x3"()
    store_lex "$A", $P122
.annotate 'line', 38
    find_lex $P123, "$A"
    $P124 = $P123."row_scale"(7, 1)
.annotate 'line', 36
    .return ($P124)
.end


.namespace []
.sub "_block130" :load :anon :subid("17_1282252087.81622")
.annotate 'line', 1
    .const 'Sub' $P132 = "10_1282252087.81622" 
    $P133 = $P132()
    .return ($P133)
.end

