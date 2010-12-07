#ifndef _PLA_MATRIX_LIBRARY_H_
#define _PLA_MATRIX_LIBRARY_H_

INTVAL floats_are_equal(FLOATVAL a, FLOATVAL b);
void get_complex_value_from_pmc(PARROT_INTERP, PMC * value, FLOATVAL * real,
    FLOATVAL * imag);

void intkey_to_coords(PARROT_INTERP, const INTVAL rows, const INTVAL cols,
    const INTVAL key, INTVAL * row, INTVAL * col);

void pmckey_to_coords(PARROT_INTERP, PMC * key, INTVAL * row, INTVAL * col);

PMC * get_external_pmc(PARROT_INTERP, const INTVAL type);
PMC * get_external_pmc_init(PARROT_INTERP, const INTVAL type, PMC * const value);

#endif /* _PLA_MATRIX_LIBRARY_H */
