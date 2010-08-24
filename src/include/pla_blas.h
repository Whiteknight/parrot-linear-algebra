#ifndef _PLA_BLAS_H_
#define _PLA_BLAS_H_

/* If we don't have cblas.h, we are probably linking to BLAS directly. We'll
   need to manually write bindings for that */
#ifdef _PLA_HAVE_CBLAS_H
#  include <cblas.h>
#  define dgemm cblas_dgemm
#  define zgemm cblas_zgemm
#else

/* Define manual mappings to the BLAS library here, and map them to the same
   function names that would be used by ATLAS/cblas.h */

/* Using the same names for these enums as cblas.h does, so that we can be
   transparent between the two */
typedef enum CBLAS_ORDER_ {
    CblasRowMajor = 101,
    CblasColMajor=102
} CBLAS_ORDER;

typedef enum CBLAS_TRANSPOSE_ {
    CblasNoTrans = 111,
    CblasTrans = 112,
    CblasConjTrans = 113
} CBLAS_TRANSPOSE;

extern void dgemm_(
    const CBLAS_ORDER Order,
    const CBLAS_TRANSPOSE TransA,
    const CBLAS_TRANSPOSE TransB,
    const int M,
    const int N,
    const int K,
    const double alpha,
    const double *A,
    const int lda,
    const double *B,
    const int ldb,
    const double beta,
    double *C,
    const int ldc
);
#define dgemm dgemm_

extern void zgemm_(
    const CBLAS_ORDER Order,
    const CBLAS_TRANSPOSE TransA,
    const CBLAS_TRANSPOSE TransB,
    const int M,
    const int N,
    const int K,
    const void *alpha,
    const void *A,
    const int lda,
    const void *B,
    const int ldb,
    const void *beta,
    void *C,
    const int ldc
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
