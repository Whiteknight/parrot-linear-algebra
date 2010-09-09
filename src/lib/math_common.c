#include "pla.h"

/* Relative error between two large numbers */
#define FLOATVAL_EPSILON_REL 0.0001

/* Absolute difference between two small numbers */
#define FLOATVAL_EPSILON_ABS 0.00001

/* Above we do relative error, below we use abs */
#define FLOATVAL_REL_THRESHOLD 10

/* Check if two floats are equalish. Above a certain threshold we want to do a
   relative error calculation because precision between subsequent large
   numbers can be much larger than standard epsilon values. Below the threshold
   we want to do an absolute calculation because as the values approach zero the
   error value quickly begins to diverge, even for very similar values. The
   values for absolute difference, relative error, and threshold need to be
   tuned. */
INTVAL
floats_are_equal(FLOATVAL a, FLOATVAL b)
{
    FLOATVAL diff = fabs(a - b);
    if (a == b)
        return 1;
    if (diff > FLOATVAL_EPSILON_ABS)
        return 0;
    if (a > FLOATVAL_REL_THRESHOLD) {
        FLOATVAL err = diff / b;
        if (err > FLOATVAL_EPSILON_REL)
            return 0;
    }
    return 1;
}

void
get_complex_value_from_pmc(PARROT_INTERP, PMC * value, FLOATVAL * real,
    FLOATVAL * imag)
{
    if (PMC_IS_NULL(value)) {
        *real = 0.0;
        *imag = 0.0;
    }
    else if (VTABLE_does(interp, value, Parrot_str_new(interp, "complex", 7))) {
        *real = VTABLE_get_number_keyed_int(interp, value, 0);
        *imag = VTABLE_get_number_keyed_int(interp, value, 1);
    }
    else if (VTABLE_does(interp, value, Parrot_str_new(interp, "float", 5))) {
        *real = VTABLE_get_number(interp, value);
        *imag = 0.0;
    }
    else if (VTABLE_does(interp, value, Parrot_str_new(interp, "integer", 7))) {
        const INTVAL _r = VTABLE_get_integer(interp, value);
        *real = (FLOATVAL)_r;
        *imag = 0.0;
    }
    else if (VTABLE_does(interp, value, Parrot_str_new(interp, "string", 6))) {
        PMC * const c = get_external_pmc_init(interp, enum_class_Complex, value);
        *real = VTABLE_get_number_keyed_int(interp, c, 0);
        *imag = VTABLE_get_number_keyed_int(interp, c, 1);
    }
    else {
        Parrot_ex_throw_from_c_args(interp, NULL, EXCEPTION_OUT_OF_BOUNDS,
            "PLA: cannot set unknown PMC type");
    }
}
