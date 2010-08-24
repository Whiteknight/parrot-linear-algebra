#ifndef _PLA_H_
#define _PLA_H_

#include <math.h>
#include <parrot/parrot.h>

#include "pla_blas.h"

#ifdef _PLA_HAVE_LAPACK
#  include "pla_lapack.h"
#endif

#include "pla_matrix_types.h"
#include "pla_matrix_library.h"

#endif /* _PLA_H_ */
