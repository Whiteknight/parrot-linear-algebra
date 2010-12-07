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

void
pmckey_to_coords(PARROT_INTERP, PMC * key, INTVAL * row, INTVAL * col)
{
    if (VTABLE_does(interp, key, Parrot_str_new(interp, "array", 5))) {
        INTVAL size = VTABLE_elements(interp, key);

        if (size == 1) {
            Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
                "PLA: 1 element array to get matrix element. NOT IMPLEMENTED"); 
        }
        else if (size == 2) {
            *row = VTABLE_shift_integer(interp, key);
            *col = VTABLE_shift_integer(interp, key);
        }
        else
            Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
                "PLA: array to get matrix element must have 1 or 2 elements");
    }
    else if (key->vtable->base_type == enum_class_Key) {
        INTVAL element1, element2;

        element1 = VTABLE_get_integer(interp, key);
        key = VTABLE_shift_pmc(interp, key);

        if (!key) {
            Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
                "PLA: 1 element PMC key to get matrix element. NOT IMPLEMENTED");
        }
        else {
            element2 = VTABLE_get_integer(interp, key);

            *row = element1;
            *col = element2;

            key = VTABLE_shift_pmc(interp, key);

            if (key)
                Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
                    "PLA: PMC key to get matrix element must have only 1 or 2 elements");
        }
    }
    else {
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA: you should provide a PMC Key or array with 1 or 2 elements");
    }
}

/* Get an instance of an externally-defined (non-PLA) PMC type. Account for
   subtypes */
PMC *
get_external_pmc(PARROT_INTERP, const INTVAL type)
{
    INTVAL realtype = Parrot_hll_get_ctx_HLL_type(interp, type);
    return Parrot_pmc_new(interp, realtype);
}

PMC *
get_external_pmc_init(PARROT_INTERP, const INTVAL type, PMC * const val)
{
    INTVAL realtype = Parrot_hll_get_ctx_HLL_type(interp, type);
    return Parrot_pmc_new_init(interp, realtype, val);
}
