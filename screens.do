/*******************************************************************************
Spencer Koo
Senior Thesis
SCREENS.do

Arguments: year, neg, cat, combo, bic, cutoff, weight, type
This screens the stocks to add only the ones that I want in each portfolio for
this particular year.
*******************************************************************************/
*ARGUMENTS for this do file.
args year neg cat combo bic cutoff weight type
*Use the latest data.
use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear

*************************************NO BIC*************************************
if `bic' == 0 {
	               *************NEGATIVE SCREEN*************
	if `neg' == 1 {
		                      *HIGH OBSERVATIONS*
		if `type' == 0 {
			drop if alcohol == 1
			drop if gambling == 1
			drop if military == 1
			drop if nuclear == 1
			drop if tobacco == 1
			drop if firearms == 1
			save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
		}
		                      *LOW OBSERVATIONS*
		if `type' == 1 {
			keep if alcohol == 1 | gambling == 1 | military == 1 | nuclear == 1 | tobacco == 1 | firearms == 1
			save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
		}
		                         *LONG-SHORT*
		if `type' == 2 {
			*Shorting the returns of the low observations.
			keep if alcohol == 1 | gambling == 1 | military == 1 | nuclear == 1 | tobacco == 1 | firearms == 1
			replace short = 1
			save temp, replace
			*Go back to the original file and keep only the high observations.
			use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
			drop if alcohol == 1
			drop if gambling == 1
			drop if military == 1
			drop if nuclear == 1
			drop if tobacco == 1
			drop if firearms == 1
			*Now append the shorted low observation temp file.
			append using temp
			*Save in the convention.
			save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
			*Erase the temp file.
			erase temp.dta
		}
	}
	               *************POSITIVE SCREENS*************
	if `neg' == 0 {
	                           ****CATEGORIES****
		if `combo' == 0 {
		                             *HIGH*
			if `type' == 0 {
					local i = 100 - `cutoff'
					centile rank`cat', centile (`i')
					keep if rank`cat' >= r(ub_1)
					*Save in convention
					save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				}
		                             *LOW*
			if `type' == 1 {
					centile rank`cat', centile (`cutoff')
					keep if rank`cat' <= r(lb_1)
					*Save
					save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile rank`cat', centile (`cutoff')
				keep if rank`cat' <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile rank`cat', centile (`i')
				keep if rank`cat' > r(ub_1)
				append using temp
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				erase temp.dta
			}
		}
	                         ****COMBINATION 1****
		if `combo' == 1 {
		                             *HIGH*
			if `type' == 0 {
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				}
		                             *LOW*
			if `type' == 1 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
			}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				append using temp
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				erase temp.dta
			}
		}
	                         ****COMBINATION 2****
		if `combo' == 2 {
			drop if alcohol == 1
			drop if gambling == 1
			drop if military == 1
			drop if nuclear == 1
			drop if tobacco == 1
			drop if firearms == 1
                                    *HIGH*
			if `type' == 0 {
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
			}
		                             *LOW*
			if `type' == 1 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
			}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				append using temp
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				erase temp.dta
			}
		}
	}
}

**************************************BIC**************************************
if `bic' == 1 {
	foreach x of num 1/10 {
		*Use the latest data still, but only keep whichever sector is being worked on.
		*This data set contains ONE COPY of each PERMNO for ONE YEAR with SECTORS MARKED.
		use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
		keep if sector == `x'
		if `combo' == 0 {
		                             *HIGH*
			if `type' == 0 {
					local i = 100 - `cutoff'
					centile rank`cat', centile (`i')
					keep if rank`cat' >= r(ub_1)
					*Save in convention
				}
		                             *LOW*
			if `type' == 1 {
					centile rank`cat', centile (`cutoff')
					keep if rank`cat' <= r(lb_1)
					*Save
				}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile rank`cat', centile (`cutoff')
				keep if rank`cat' <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile rank`cat', centile (`i')
				keep if rank`cat' > r(ub_1)
				append using temp
				save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
				erase temp.dta
			}
		}
	                         ****COMBINATION 1****
		if `combo' == 1 {
		                             *HIGH*
			if `type' == 0 {
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				}
		                             *LOW*
			if `type' == 1 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
			}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				append using temp
				erase temp.dta
			}
		}
	                         ****COMBINATION 2****
		if `combo' == 2 {
			drop if alcohol == 1
			drop if gambling == 1
			drop if military == 1
			drop if nuclear == 1
			drop if tobacco == 1
			drop if firearms == 1
                                    *HIGH*
			if `type' == 0 {
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
			}
		                             *LOW*
			if `type' == 1 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
			}
		                          *LONG-SHORT*
			if `type' == 2 {
				centile avg_rank, centile (`cutoff')
				keep if avg_rank <= r(lb_1)
				replace short = 1
				save temp, replace
				use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, clear
				local i = 100 - `cutoff'
				centile avg_rank, centile (`i')
				keep if avg_rank >= r(ub_1)
				append using temp
				erase temp.dta
			}
		}
		*Save this sector after the screens.
		save bic_temp_sector`x', replace
	}
	*Combine all sectors together for this year after screening.
	use bic_temp_sector1, clear
	foreach x of num 2/10 {
		append using bic_temp_sector`x'
		erase bic_temp_sector`x'.dta
	}
	save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened, replace
	erase bic_temp_sector1.dta
}
