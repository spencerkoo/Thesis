/*******************************************************************************
Spencer Koo
Senior Thesis
MAKE_ONE_YEAR_PORT.do

ARGUMENTS: year, neg, cat, combo, bic, cutoff, weight, type
	
This do file creates a singular year of a portfolio.
*******************************************************************************/

*ARGUMENTS for this do file.
args year neg cat combo bic cutoff weight type

*Use the file that has ALL the years and observations.
use 2_formatted, clear

*Keep the year I want.
keep if year == `year'

*This SAVE contains ALL observations for ONE YEAR.
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_1, replace

*Get rid of duplicate PERMNOs; only want one of each so that I can get
*appropriate numbers/formatting for this do file.
keep if newpermno

*This SAVE contains the OBS of ONE YEAR that I want; NO DUPE PERMNOS.
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_2, replace

*Create the separate data files for the BIC individual years without DUPE PERMNOs.
if `bic' == 1 {
	*Need to reuse this data to get each INDUSTRY SECTOR CLASS:
	save bic_`year'_base, replace
	do bic.do `year'
	*Load the results of bic.do with the new sector variable and order it for
	*screening: PERMNO, then DATE
	use temp, clear
	*Save this data with the naming convention and delete the temp file.
	*It contains ONE YEAR, NO DUPE PERMNOs + SECTOR variable:
	save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, replace
	erase temp.dta
}
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3, replace
sort permno date

*Screen the data
do screens.do `year' `neg' `cat' `combo' `bic' `cutoff' `weight' `type'


*******************GETTING ALL MONTHS of PERMNOs in PORTFOLIO*******************
*MUST MAKE SURE THAT (FOR BIC) SECTOR VAR GETS CARRIED TO OTHER WITH SAME PERMNO!*

*Add the PERMNOs that I know are in the portfolio to the list of all of that
*year's observations.
use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_1, clear

*Find the number of observations in that year and add on the observations that
*are definitely in that year's portfolio to the end.
sum permno
scalar original_obs = r(N)
*Now append the IN_PORTFOLIO observations.
append using `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened

*Create boolean variable that shows which observations are in the portfolio.
gen byte in_port = 0

*Run a loop to compare those observations (definitely in the portfolio) to
*mark the observations with the same PERMNOs as those that should be kept.
*Also, in case needed later, mark the same PERMNOs with the sector number that
*that company belongs to.
local n = _N
forval i = `=scalar(original_obs)+1'/`n' {
	replace in_port = 1 if permno[_n] == permno[`i']
	*replace short = short[`i'] if permno[_n] == permno[`i'] & `type' == 2
	replace short = 1 if permno[_n] == permno[`i'] & `type' == 2 & short[`i'] == 1
	replace sector = 1 if permno[_n] == permno[`i'] & sector[`i'] == 1 & `bic' == 1
	replace sector = 2 if permno[_n] == permno[`i'] & sector[`i'] == 2 & `bic' == 1
	replace sector = 3 if permno[_n] == permno[`i'] & sector[`i'] == 3 & `bic' == 1
	replace sector = 4 if permno[_n] == permno[`i'] & sector[`i'] == 4 & `bic' == 1
	replace sector = 5 if permno[_n] == permno[`i'] & sector[`i'] == 5 & `bic' == 1
	replace sector = 6 if permno[_n] == permno[`i'] & sector[`i'] == 6 & `bic' == 1
	replace sector = 7 if permno[_n] == permno[`i'] & sector[`i'] == 7 & `bic' == 1
	replace sector = 8 if permno[_n] == permno[`i'] & sector[`i'] == 8 & `bic' == 1
	replace sector = 9 if permno[_n] == permno[`i'] & sector[`i'] == 9 & `bic' == 1
	replace sector = 10 if permno[_n] == permno[`i'] & sector[`i'] == 10 & `bic' == 1
}
local n = _N
*Drop the appended extra observations used to mark which PERMNOs would be in
*the portfolio.
if `=scalar(original_obs)' < `n' {
	drop in `=scalar(original_obs)+1'/`n'
}
*Drop those observations not in the portfolio.
drop if in_port == 0
*Drop var completely.
drop in_port
*Erase the screened file after appending it.
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_type`type'_screened.dta
if `type' == 2 {
	replace cap = cap * -1 if short == 1
}
*Save as the newest file: ONE YEAR, ALL PERMNOs, SECTOR var
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_4, replace
*Make the cap negative if the company is in the shorted portfolio.


**************************CALCULATE the SECTOR-WEIGHTS**************************
*Weights will vary BY MONTH + BY SECTOR for this ONE YEAR.
*Need all the observations for the year (i.e. all the months too).
use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_4, clear
*Find the sector weights and sector returns.
do sector_weighting.do `bic' `year'
*If BIC, then has gone thru sector-weighting. Still want those companies that
*will be shorted to have the correct weighting like they will be shorted, but
*that prematurely changes the returns to negative so just switch them back
*prior to monthly-weighting.
if `bic' == 1 {
	replace returns = returns * -1 if short == 1
}
*Make a fresh save with the new sector weighted monthly returns.
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_5, replace


*************************CALCULATE the MONTHLY-WEIGHTS*************************
*Weights will vary BY MONTH for this ONE YEAR.
*Need all the observations for the year (i.e. all the months too).
use `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_5, clear
*Find the montly weights and weighted returns.
do monthly_weighting.do `weight'
*Make a fresh save with the new sector weighted monthly returns.
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_6, replace
*If the portfolio is equally-weighted, then the caps don't matter so I have
*to manually alter the weights.
replace mweights = mweights * -1 if `weight' == 1 & short == 1
*Moved the calculation for the weighted returns here.
*Create a variable for the weighted returns (regardless of what kind of weighting).
gen float wreturns = returns * mweights
*Move WEIGHTED RETURNS (wreturns) after MONTHLY WEIGHTS (mweights).
order wreturns, after(mweights)


***********************CALC WEIGHTED TOTAL MONTHLY RETURN***********************
*Create variable the TOTAL WEIGHTED RETURN for each MONTH of the entire portfolio.
gen float total_monthly_return = 0
*Summarize the wreturns for the month ONLY. Then use the temporarily held data.
**********JANUARY**********
sum wreturns if substr(string(date), 5, 6) == "01"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "01"
**********FEBRUARY**********
sum wreturns if substr(string(date), 5, 6) == "02"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "02"
**********MARCH**********
sum wreturns if substr(string(date), 5, 6) == "03"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "03"
**********APRIL**********
sum wreturns if substr(string(date), 5, 6) == "04"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "04"
**********MAY**********
sum wreturns if substr(string(date), 5, 6) == "05"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "05"
**********JUNE**********
sum wreturns if substr(string(date), 5, 6) == "06"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "06"
**********JULY**********
sum wreturns if substr(string(date), 5, 6) == "07"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "07"
**********AUGUST**********
sum wreturns if substr(string(date), 5, 6) == "08"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "08"
**********SEPTEMBER**********
sum wreturns if substr(string(date), 5, 6) == "09"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "09"
**********OCTOBER**********
sum wreturns if substr(string(date), 5, 6) == "10"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "10"
**********NOVEMBER**********
sum wreturns if substr(string(date), 5, 6) == "11"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "11"
**********DECEMBER**********
sum wreturns if substr(string(date), 5, 6) == "12"
replace total_monthly_return = r(sum) if substr(string(date), 5, 6) == "12"

*Rename the market portfolio variable.
rename rmrf market
*Move the monthly_return variable before the other independent vars.
order total_monthly_return, before(market)
*Move the RISK FREE after the monthly returns.
order rf, after(total_monthly_return)

save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_7, replace


*************CREATE NEWEST dta WITH `year''s RETURNS for EACH MONTH*************
*Create the dependent variable.
gen float excess = total_monthly_return - rf

*Move the dependent variable before the independent ones.
order excess, before(market)

*Now only need one copy of each month = 12 observations total.
*Do this in the same way that I found where new permnos were.
gen byte nextmonth = 0 if date[_n] == date[_n-1]
*now recode the missing values to 1 (meaning it's a new permno)
*and relocate it with the other identifiers
recode nextmonth (mis = 1)
order nextmonth, after(date)

*Drop the extra copies.
drop if nextmonth == 0

*Drop KLD vars and other vars that I don't need anymore.
keep date excess market smb hml mom

*This contains the 12 observations with all the variables needed for regression.
*This is for ONE YEAR, and it should be SAVED for periods and for appending to
*make overall regressions.
save `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_ready, replace

*Delete the prior saves that I don't need.

erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_1.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_2.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_3.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_4.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_5.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_6.dta
erase `year'_neg`neg'_cat`cat'_combo`combo'_bic`bic'_`cutoff'%_weight`weight'_type`type'_7.dta

