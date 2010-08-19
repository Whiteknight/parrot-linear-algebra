
.sub "" :load :init
    load_bytecode "nqp-rx.pbc"
    load_bytecode "./library/kakapo_full.pbc"
    load_bytecode "t/testlib/pla_test.pbc"
    loadlib $P33, "./linalg_group"
.end

.sub "main" :main
    .param pmc args
    $P0 = shift args
    .local pmc args_iter
    .local pmc testfile
    args_iter = iter args
    #$S0 = "t/pmc/"
  loop_top:
    unless args_iter goto file_end
    testfile = shift args_iter
    $P0 = get_hll_global ["Nqp"], "compile_file"
    $S1 = testfile
    #$S2 = $S0 . $S1
    $P1 = $P0($S1)
    $P2 = $P1[0]
    $P2()
    goto loop_top
  file_end:
.end
