#include "pla.h"

/* Wrapper to call the dgemm function from BLAS with PMC arguments. Assumes
   A, B, and C are all NumMatrix2D. */
void
call_dgemm(PARROT_INTERP, FLOATVAL alpha, PMC * A, PMC *B, FLOATVAL beta, PMC *C)
{
    DECLATTRS(A, attrs_a);
    DECLATTRS(B, attrs_b);
    DECLATTRS(C, attrs_c);
    const INTVAL M = attrs_a->rows;
    const INTVAL N = attrs_b->cols;
    const INTVAL K = attrs_a->cols;
    if (attrs_c->rows != M)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA DGEMM: A, C indices do not match in gemm");
    if (attrs_c->cols != N)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA DGEMM: B, C indices do not match in gemm");
    if (attrs_b->rows != K)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA DGEMM: A, B indeces do not match in gemm");
    dgemm(CblasRowMajor,
        IS_TRANSPOSED_BLAS(attrs_a->flags),
        IS_TRANSPOSED_BLAS(attrs_b->flags),
        M,
        N,
        K,
        alpha,
        attrs_a->storage,
        M,
        attrs_b->storage,
        N,
        beta,
        attrs_c->storage,
        M
    );
}

/* Wrapper to call the zdgemm function from BLAS with PMC arguments. Assumes
   A, B, and C are all ComplexMatrix2D. */
static void
call_zgemm(PARROT_INTERP, FLOATVAL alpha_r, FLOATVAL alpha_i, PMC * A, PMC *B,
    FLOATVAL beta_r, FLOATVAL beta_i, PMC *C)
{
    DECLATTRS(A, attrs_a);
    DECLATTRS(B, attrs_b);
    DECLATTRS(C, attrs_c);
    const INTVAL M = attrs_a->rows;
    const INTVAL N = attrs_b->cols;
    const INTVAL K = attrs_a->cols;
    FLOATVAL alpha_p[2];
    FLOATVAL beta_p[2];
    if (attrs_c->rows != M)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA ZGEMM: A, C indices do not match in gemm");
    if (attrs_c->cols != N)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA ZGEMM: B, C indices do not match in gemm");
    if (attrs_b->rows != K)
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA ZGEMM: A, B indeces do not match in gemm");
    alpha_p[0] = alpha_r;
    alpha_p[1] = alpha_i;
    beta_p[0] = beta_r;
    beta_p[1] = beta_i;
    zgemm(CblasRowMajor,
        IS_TRANSPOSED_BLAS(attrs_a->flags),
        IS_TRANSPOSED_BLAS(attrs_b->flags),
        M,
        N,
        K,
        alpha_p,
        attrs_a->storage,
        M,
        attrs_b->storage,
        N,
        beta_p,
        attrs_c->storage,
        M
    );
}

