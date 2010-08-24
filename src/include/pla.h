#ifndef _PLA_H_
#define _PLA_H_

#include <math.h>
#include <parrot/parrot.h>

/* If we don't have cblas.h, we are probably linking to BLAS directly. We'll
   need to manually write bindings for that */
#ifdef _PLA_HAVE_CBLAS_H
#  include <cblas.h>
#else
#  include "pla_blas.h"
#endif

#ifdef _PLA_HAVE_LAPACK
#  include "pla_lapack.h"
#endif

#include "pla_matrix_types.h"
#include "pla_matrix_library.h"

#endif /* _PLA_H_ */
