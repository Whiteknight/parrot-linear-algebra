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

#define ITEM_XY_ROWMAJOR(s, x_max, y_max, x, y) \
    (s)[((y_max) * (x)) + (y)]

#define ITEM_XY_COLMAJOR(s, x_max, y_max, x, y) \
    (s)[((x_max) * (y)) + (x)]

#define INDEX_MIN(a, b) (((a) <= (b))?(a):(b))
#define INDEX_MAX(a, b) (((a) >= (b))?(a):(b))

#define FLAG_TRANSPOSED 1

#define IS_TRANSPOSED(flags) (((flags) & (FLAG_TRANSPOSED)) != 0)
#define IS_TRANSPOSED_BLAS(flags) (IS_TRANSPOSED(flags) ? CblasTrans : CblasNoTrans)
#endif
