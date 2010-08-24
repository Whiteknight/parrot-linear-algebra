#include "pla.h"

/* Wrapper to call the dgemm function from BLAS with PMC arguments. Assumes
   A, B, and C are all NumMatrix2D. */
void
call_dgemm(FLOATVAL alpha,
    INTVAL flags_A, FLOATVAL * A, INTVAL rows_A, INTVAL cols_A,
    INTVAL flags_B, FLOATVAL * B, INTVAL cols_B,
    FLOATVAL beta,  FLOATVAL * C)
{
    const INTVAL M = rows_A;
    const INTVAL N = cols_B;
    const INTVAL K = cols_A;
    dgemm(CblasRowMajor,
        IS_TRANSPOSED_BLAS(flags_A),
        IS_TRANSPOSED_BLAS(flags_B),
        M,
        N,
        K,
        alpha,
        A,
        M,
        B,
        N,
        beta,
        C,
        M
    );
}

/* Wrapper to call the zdgemm function from BLAS with PMC arguments. Assumes
   A, B, and C are all ComplexMatrix2D. */
void
call_zgemm(FLOATVAL alpha_r, FLOATVAL alpha_i,
    INTVAL flags_a, FLOATVAL * A, INTVAL rows_a, INTVAL cols_a,
    INTVAL flags_b, FLOATVAL * B, INTVAL cols_b,
    FLOATVAL beta_r, FLOATVAL beta_i, FLOATVAL * C)
{
    const INTVAL M = rows_a;
    const INTVAL N = cols_b;
    const INTVAL K = cols_a;
    FLOATVAL alpha_p[2];
    FLOATVAL beta_p[2];

    alpha_p[0] = alpha_r;
    alpha_p[1] = alpha_i;
    beta_p[0] = beta_r;
    beta_p[1] = beta_i;
    zgemm(CblasRowMajor,
        IS_TRANSPOSED_BLAS(flags_a),
        IS_TRANSPOSED_BLAS(flags_b),
        M,
        N,
        K,
        alpha_p,
        A,
        M,
        B,
        N,
        beta_p,
        C,
        M
    );
}

