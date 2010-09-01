#ifndef _PLA_BLAS_H_
#define _PLA_BLAS_H_

/* If we don't have cblas.h, we are probably linking to BLAS directly. We'll
   need to manually write bindings for that */
#ifdef _PLA_HAVE_CBLAS_H
#  include <cblas.h>
#  define PLA_HAVE_CBLAS
#  define IS_TRANSPOSED_BLAS(flags) (IS_TRANSPOSED(flags) ? CblasTrans : CblasNoTrans)
#else
#  define IS_TRANSPOSED_BLAS(flags) (IS_TRANSPOSED(flags) ? "T" : "N")
#  ifdef PLA_HAVE_CBLAS
#    undef PLA_HAVE_CBLAS
#  endif

/* Define manual mappings to the BLAS library here, and map them to the same
   function names that would be used by ATLAS/cblas.h */

extern void dgemm_(
    const void *TransA,
    const void *TransB,
    const void *M,
    const void *N,
    const void *K,
    const double *alpha,
    const double *A,
    const void *lda,
    const double *B,
    const void *ldb,
    const double *beta,
    double *C,
    const void *ldc
);

extern void zgemm_(
    const void *TransA,
    const void *TransB,
    const void *M,
    const void *N,
    const void *K,
    const void *alpha,
    const void *A,
    const void *lda,
    const void *B,
    const void *ldb,
    const void *beta,
    void *C,
    const void *ldc
);

#  endif /* _PLA_HAVE_CBLAS_H */

void call_dgemm(
    FLOATVAL alpha,
    INTVAL flags_A, FLOATVAL * A, INTVAL rows_A, INTVAL cols_A,
    INTVAL flags_B, FLOATVAL * B, INTVAL cols_B,
    FLOATVAL beta,
    FLOATVAL * C
);

void call_zgemm(
    FLOATVAL alpha_r, FLOATVAL alpha_i,
    INTVAL flags_a, FLOATVAL * A, INTVAL rows_a, INTVAL cols_a,
    INTVAL flags_b, FLOATVAL * B, INTVAL cols_b,
    FLOATVAL beta_r, FLOATVAL beta_i,
    FLOATVAL * C
);



#endif /* _PLA_BLAS_H_ */
