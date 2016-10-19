set more off
cap log close
log using 0time_start.log, replace
display "START!"
log close
/*******************************************************************************
Spencer Koo
Senior Thesis
RUN.do

Description of all ARGUMENTS throughout script:
	YEAR, int: year I want of portfolio
	NEG, boolean: if using a negative screen
		-> 0 means that a negative screen is NOT used
		-> 1 means that companies involved in controversial areas are removed
	CAT, int: category of the portfolio
		-> 1 means COMMUNITY
		-> 2 means DIVERSITY
		-> 3 means EMPLOYEE RELATIONS
		-> 4 means ENVIRONMENT
		-> 5 means HUMAN RIGHTS
		-> 6 means PRODUCT
	COMBO, int: if using a combination portfolio
		-> 0 means not a combination portfolio
		-> 1 means the avg of all the positive screens
		-> 2 means NEG screen, then the avg for remaining companies (COMBO 1)
	BIC, boolean: if using a Best-In-Class portfolio
		-> 0 means not Best-In-Class
		-> 1 means Best-In-Class (separated into 10 industry class sectors)
	CUTOFF, int: where the positive portfolios are separated into high and low
		-> 10 means 10% (default)
		-> 5 means 5%
		-> 25 means 25%
		-> 50 means 50%
		=> If there is a tie in the rankings of the screens, then the portfolio
		include the companies >= for the high-ranked portfolio and <= for the
		low-ranked portfolio. In the case of 50%, all those companies tied with
		the cut-off will be included in the low-ranked portfolio.
	WEIGHT: 0, 1
		-> 0 means value weighting
		-> 1 means equal weighting
	TYPE, int: screening of portfolios
		-> 0 means high
		-> 1 means low
		-> 2 means long-short
		
Depends on:
	MAKE_PORT.do: neg, cat, combo, bic, cutoff, weight, type

Arguments: none

This do file is at the top of the pyramid. I just run this one do file, and it
runs the entire program just spitting out the results.
*******************************************************************************/

*Format the original merged data.
do format.do

*If NEG == 1, then I manually set CAT to 0 & COMBO to 0.
*If COMBO == 1 or 2, then I manually set CAT to 0.
*If WEIGHT == 1, then I manually set type to 2.

do make_port.do 0 1 0 0 10 0 0
do make_port.do 0 2 0 0 10 0 0
do make_port.do 0 3 0 0 10 0 0
do make_port.do 0 4 0 0 10 0 0
do make_port.do 0 5 0 0 10 0 0
do make_port.do 0 6 0 0 10 0 0

do make_port.do 0 1 0 0 10 0 1
do make_port.do 0 2 0 0 10 0 1
do make_port.do 0 3 0 0 10 0 1
do make_port.do 0 4 0 0 10 0 1
do make_port.do 0 5 0 0 10 0 1
do make_port.do 0 6 0 0 10 0 1

do make_port.do 0 1 0 0 10 0 2
do make_port.do 0 2 0 0 10 0 2
do make_port.do 0 3 0 0 10 0 2
do make_port.do 0 4 0 0 10 0 2
do make_port.do 0 5 0 0 10 0 2
do make_port.do 0 6 0 0 10 0 2

do make_port.do 1 0 0 0 10 0 0
do make_port.do 1 0 0 0 10 0 1
do make_port.do 1 0 0 0 10 0 2
do make_port.do 0 0 2 0 10 0 0
do make_port.do 0 0 2 0 10 0 1
do make_port.do 0 0 2 0 10 0 2
do make_port.do 0 0 1 0 10 0 0
do make_port.do 0 0 1 0 10 0 1
do make_port.do 0 0 1 0 10 0 2

do make_port.do 0 1 0 0 10 1 2
do make_port.do 0 2 0 0 10 1 2
do make_port.do 0 3 0 0 10 1 2
do make_port.do 0 4 0 0 10 1 2
do make_port.do 0 5 0 0 10 1 2
do make_port.do 0 6 0 0 10 1 2

do make_port.do 1 0 0 0 10 1 2
do make_port.do 0 0 2 0 10 1 2
do make_port.do 0 0 1 0 10 1 2

*Run MAKE_PORT.do for portfolios that ARE BIC; that means that neg will always
*be 0.
do make_port.do 0 1 0 1 10 0 0
do make_port.do 0 2 0 1 10 0 0
do make_port.do 0 3 0 1 10 0 0
do make_port.do 0 4 0 1 10 0 0
do make_port.do 0 5 0 1 10 0 0
do make_port.do 0 6 0 1 10 0 0

do make_port.do 0 1 0 1 10 0 1
do make_port.do 0 2 0 1 10 0 1
do make_port.do 0 3 0 1 10 0 1
do make_port.do 0 4 0 1 10 0 1
do make_port.do 0 5 0 1 10 0 1
do make_port.do 0 6 0 1 10 0 1

do make_port.do 0 1 0 1 10 0 2
do make_port.do 0 2 0 1 10 0 2
do make_port.do 0 3 0 1 10 0 2
do make_port.do 0 4 0 1 10 0 2
do make_port.do 0 5 0 1 10 0 2
do make_port.do 0 6 0 1 10 0 2

do make_port.do 0 1 0 1 10 1 2
do make_port.do 0 2 0 1 10 1 2
do make_port.do 0 3 0 1 10 1 2
do make_port.do 0 4 0 1 10 1 2
do make_port.do 0 5 0 1 10 1 2
do make_port.do 0 6 0 1 10 1 2

do make_port.do 0 0 1 1 10 0 0
do make_port.do 0 0 1 1 10 0 1
do make_port.do 0 0 1 1 10 0 2
do make_port.do 0 0 2 1 10 0 0
do make_port.do 0 0 2 1 10 0 1
do make_port.do 0 0 2 1 10 0 2
do make_port.do 0 0 1 1 10 1 2
do make_port.do 0 0 2 1 10 1 2

*Run MAKE_PORT.do for portfolios that have different cutoffs; neg will always
*be 0. Type will always be 2. Weight will always be 0.
do make_port.do 0 1 0 1 25 0 2
do make_port.do 0 2 0 1 25 0 2
do make_port.do 0 3 0 1 25 0 2
do make_port.do 0 4 0 1 25 0 2
do make_port.do 0 5 0 1 25 0 2
do make_port.do 0 6 0 1 25 0 2

do make_port.do 0 0 1 1 25 0 2
do make_port.do 0 0 2 1 25 0 2

do make_port.do 0 1 0 0 25 0 2
do make_port.do 0 2 0 0 25 0 2
do make_port.do 0 3 0 0 25 0 2
do make_port.do 0 4 0 0 25 0 2
do make_port.do 0 5 0 0 25 0 2
do make_port.do 0 6 0 0 25 0 2

do make_port.do 0 0 1 0 25 0 2
do make_port.do 0 0 2 0 25 0 2

do make_port.do 0 1 0 1 5 0 2
do make_port.do 0 2 0 1 5 0 2
do make_port.do 0 3 0 1 5 0 2
do make_port.do 0 4 0 1 5 0 2
do make_port.do 0 5 0 1 5 0 2
do make_port.do 0 6 0 1 5 0 2

do make_port.do 0 0 1 1 5 0 2
do make_port.do 0 0 2 1 5 0 2

do make_port.do 0 1 0 0 5 0 2
do make_port.do 0 2 0 0 5 0 2
do make_port.do 0 3 0 0 5 0 2
do make_port.do 0 4 0 0 5 0 2
do make_port.do 0 5 0 0 5 0 2
do make_port.do 0 6 0 0 5 0 2

do make_port.do 0 0 1 0 5 0 2
do make_port.do 0 0 2 0 5 0 2

do make_port.do 0 1 0 1 50 0 2
do make_port.do 0 2 0 1 50 0 2
do make_port.do 0 3 0 1 50 0 2
do make_port.do 0 4 0 1 50 0 2
do make_port.do 0 5 0 1 50 0 2
do make_port.do 0 6 0 1 50 0 2

do make_port.do 0 0 1 1 50 0 2
do make_port.do 0 0 2 1 50 0 2

do make_port.do 0 1 0 0 50 0 2
do make_port.do 0 2 0 0 50 0 2
do make_port.do 0 3 0 0 50 0 2
do make_port.do 0 4 0 0 50 0 2
do make_port.do 0 5 0 0 50 0 2
do make_port.do 0 6 0 0 50 0 2

do make_port.do 0 0 1 0 50 0 2
do make_port.do 0 0 2 0 50 0 2

cap log close
log using 1time_done.log, replace
display "DONE!"
log close
