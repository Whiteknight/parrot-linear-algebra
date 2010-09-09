#include "pla.h"

void
intkey_to_coords(PARROT_INTERP, const INTVAL rows, const INTVAL cols,
    const INTVAL key, INTVAL * row, INTVAL * col)
{
    if (rows == 0) {
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA: Index out of bounds.");
    } else {
        const INTVAL r = key / rows;
        const INTVAL c = key % rows;
        if (key < 0 || r > rows || c > cols) {
            Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
                "PLA: Index out of bounds.");
        }
        *row = r;
        *col = c;
    }
}

/* Get an instance of an externally-defined (non-PLA) PMC type. Account for
   subtypes */
PMC *
get_external_pmc(PARROT_INTERP, const INTVAL type)
{
    INTVAL realtype = Parrot_get_ctx_HLL_type(interp, type);
    return Parrot_pmc_new(interp, realtype);
}

PMC *
get_external_pmc_init(PARROT_INTERP, const INTVAL type, PMC * const val)
{
    INTVAL realtype = Parrot_get_ctx_HLL_type(interp, type);
    return Parrot_pmc_new_init(interp, realtype, val);
}
