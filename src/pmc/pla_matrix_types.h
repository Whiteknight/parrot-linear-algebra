#ifndef _PLA_MATRIX_TYPES_H_
#define _PLA_MATRIX_TYPES_H_

#include <cblas.h>

#define GET_INDICES_FROM_KEY(i, k, x, y) \
do { \
    (x) = VTABLE_get_integer((i), (k)); \
    (k) = VTABLE_shift_pmc((i), (k)); \
    (y) = VTABLE_get_integer((i), (k)); \
} while(0);

#define INDEX_XY_ROWMAJOR(x_max, y_max, x, y) \
    (((y_max) * (x)) + (y))

#define INDEX_XY_COLMAJOR(x_max, y_max, x, y) \
    (((x_max) * (y)) + (x))

#define INDEX_XY(flags, x_max, y_max, x, y) \
    (((IS_TRANSPOSED(flags)) ? INDEX_XY_COLMAJOR(x_max, y_max, x, y) : \
                               INDEX_XY_ROWMAJOR(x_max, y_max, x, y)))

#define ITEM_XY_ROWMAJOR(s, x_max, y_max, x, y) \
    (s)[INDEX_XY_ROWMAJOR(x_max, y_max, x, x)]

#define ITEM_XY_COLMAJOR(s, x_max, y_max, x, y) \
    (s)[INDEX_XY_COLMAJOR(x_max, y_max, x, y)]

#define ITEM_XY(s, flags, x_max, y_max, x, y) \
    (s)[INDEX_XY(flags, x_max, y_max, x, y)]

#define INDEX_MIN(a, b) (((a) <= (b))?(a):(b))
#define INDEX_MAX(a, b) (((a) >= (b))?(a):(b))

#define FLAG_TRANSPOSED    1
#define FLAG_SYMMETRIC     2
#define FLAG_HERMITIAN     4
#define FLAG_UTRIANGLE     8
#define FLAG_LTRIANGLE    16
#define FLAG_TRIANGLE    (FLAG_UTRIANGLE) | (FLAG_LTRIANGLE)
#define FLAG_TRIDIAGONAL  32
#define FLAG_TINY         64
#define FLAG_DIAGONAL    (FLAG_SYMMETRIC) | (FLAG_HERMITIAN) | (FLAG_LTRIANGLE) |\
                            (FLAG_UTRIANGLE) | (FLAG_TRIDIAGONAL)

#define IS_GENERAL(flags)         ((! (flags)))
#define IS_TINY(flags)            (((flags) & (FLAG_TINY)))
#define IS_SYMMETRIC(flags)       (((flags) & (FLAG_SYMMETRIC)))
#define IS_HERMITIAN(flags)       (((flags) & (FLAG_HERMITIAN)))
#define IS_UTRIANGLE(flags)       (((flags) & (FLAG_UTRIANGLE)))
#define IS_LTRIANGLE(flags)       (((flags) & (FLAG_LTRIANGLE)))
#define IS_TRIANGLE(flags)        (((flags) & (FLAG_TRIANGLE)))
#define IS_DIAGONAL(flags)        ((((flags) & (FLAG_DIAGONAL)) == FLAG_DIAGONAL))
#define IS_TRIDIAGONAL(flags)     (((flags) & (FLAG_TRIDIAGONAL)))
#define IS_TRANSPOSED(flags)      (((flags) & (FLAG_TRANSPOSED)))
#define IS_TRANSPOSED_BLAS(flags) (IS_TRANSPOSED(flags) ? CblasTrans : CblasNoTrans)

#endif
