/*******************************************************************************
Spencer Koo
Senior Thesis
MAKE_PORT.do

ARGUMENTS: neg, cat, combo, bic, cutoff, weight, type
	
This creates a portfolio in full by appending all the individual years of a
singular portfolio together.
Since there is no period variable, this function looks for other conditions in
which three periods should be made and makes the appropriate saves.
*******************************************************************************/

*Arguments for this function.
args neg cat combo bic cutoff weight type

*Use a local macro for the regressions since I will be calling them a lot.
local yay excess market smb hml mom

*Use the formatted merge data.
use 2_formatted, clear


*Run through this while loop 13 times. Once for each year: [1992-2004], meaning
*that the end years are inclusive.
local i 1992
while `i' < 2005 {
	do make_one_year_port.do `i' `neg' `cat' `combo' `bic' `cutoff' `weight' `type'
	local i = `i' + 1
}


*There is NO PERIOD argument so just append and name with period based on which
*portfolios use what data. My code can made many more portfolios. It's pretty
*generalized, but there's no point in making cluttering my directory with excess
*dta files and log files that may confuse me.

*Regardless of the type of portfolio made, I have to run the Newey regression to
*get the standard errors b/c of the heteroskedasticity of the long-short portfolios.

*I will also run an autocorrelate test to see just how needed the Newey-West
*regression was.

***********************************ALL YEARS***********************************
                *CUTOFFs: 5%, 25%, 50%, NEG: always 0 already*
                               *ONLY LONG-SHORT*
if `cutoff' != 10 {
	use 1992_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, clear
	local i 1993
	while `i' < 2005 {
		append using `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready
		local i = `i' + 1
	}
	*Save this complete portfolio.
	*save DONE_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type', replace
	*Run the regression and log for these portfolios.
	*Open log file.
	cap log close
	log using DONE_ALL_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'.log, replace
	*The y-intercept will be my excess return (alpha).
	*CARHART 4-FACTOR MODEL:
	reg `yay'	
	*Run Newey-West regression with lag 12 to be safe since it's a monthly portfolio.
	gen mdate = tm(1992m1) + _n-1
	format mdate %tm
	order mdate, after(date)
	drop date
	tsset mdate
	newey `yay', lag(12)
	log close
}

						        *CUTOFF: 10%*
if `cutoff' == 10 {
	if `weight' == 0 {
                        *VALUE-WEIGHTING (weight = 0)*
		use 1992_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, clear
		local i 1993
		while `i' < 2005 {
			append using `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready
			local i = `i' + 1
		}
		*Save this complete portfolio.
		*save DONE_ALL_neg`neg'_cat`cat'_combo`combo'_bic`bic'_10%_weight`weight'_type`type', replace
		*Run reg and log it.
		cap log close
		log using DONE_ALL_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'.log, replace
		reg `yay'
		*Run Newey-West regression with lag 12 to be safe since it's a monthly portfolio.
		gen mdate = tm(1992m1) + _n-1
		format mdate %tm
		order mdate, after(date)
		drop date
		tsset mdate
		newey `yay', lag(12)
		log close
	}
                        *EQUAL-WEIGHTING (weight = 1)*
						      *LONG-SHORT ONLY*
	if `weight' == 1 {
		use 1992_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, clear
		local i 1993
		while `i' < 2005 {
			append using `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready
			local i = `i' + 1
		}
		*Save this complete portfolio.
		*save DONE_ALL_neg`neg'_cat`cat'_combo`combo'_bic`bic'_10%_weight`weight'_type`type', replace
		*Run reg and log it.
		cap log close
		log using DONE_ALL_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'.log, replace
		reg `yay'
		*Run Newey-West regression with lag 12 to be safe since it's a monthly portfolio.
		gen mdate = tm(1992m1) + _n-1
		format mdate %tm
		order mdate, after(date)
		drop date
		tsset mdate
		newey `yay', lag(12)
		log close
	}
}

********************************SMALLER PERIODS********************************
*1992-1997 + 1998-2004
*The only time that both portfolios can be made without specifying is to
*have make_port.do automatically create saves for the three periods if certain
*conditions are met.
         *10% cutoff, value-weighted (weight = 0), long-short (type = 2)*
if `cutoff' == 10 {
	if `weight' == 0 {
		if `type' == 2 {
			*Here, when the cutoff is 10% and the it is value weighted, then the
			*smaller periods will be run.
			
			*RUNNING 1992-97
			use 1992_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, clear
			local i 1993
			while `i' < 1998 {
				append using `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready
				local i = `i' + 1
			}
			*Save this complete portfolio.
			*save DONE_1992-97_neg`neg'_cat`cat'_combo`combo'_bic`bic'_10%_weight`weight'_type`type', replace
			*Run the regression and log for this portfolio.
			*Open log file.
			cap log close
			log using DONE_1992-97_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'.log, replace
			*The y-int will be alpha.
			*CARHART 4-FACTOR MODEL:
			reg `yay'
			*Run Newey-West regression with lag 12 to be safe since it's a monthly portfolio.
			gen mdate = tm(1992m1) + _n-1
			format mdate %tm
			order mdate, after(date)
			drop date
			tsset mdate
			newey `yay', lag(12)
			log close
		
			*RUNNING 1998-04
			use 1998_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, clear
			local i 1999
			while `i' < 2005 {
				append using `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready
				local i = `i' + 1
			}
			*Save this complete portfolio.
			*save DONE_1998-04_neg`neg'_cat`cat'_combo`combo'_bic`bic'_10%_weight`weight'_type`type', replace
			*Run the regression and log for this portfolio.
			*Open log file.
			cap log close
			log using DONE_1998-04_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'.log, replace
			*The y-int will be alpha.
			*CARHART 4-FACTOR MODEL:
			reg `yay'
			*Run Newey-West regression with lag 12 to be safe since it's a monthly portfolio.
			gen mdate = tm(1992m1) + _n-1
			format mdate %tm
			order mdate, after(date)
			drop date
			tsset mdate
			newey `yay', lag(12)
			log close
		}
	}
}
*Remove the cluttering smaller dta files.
		local i 1992
		while `i' < 2005 {
			erase `i'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready.dta
			local i = `i' + 1
		}
