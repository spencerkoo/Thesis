/*******************************************************************************
Spencer Koo
Senior Thesis
MONTLY_WEIGHTING.do

ARGUMENTS: weight

This calculates the MONTHLY-mweights and returns the MONTHLY-WEIGHTED-RETURN for
the ENTIRE SINGULAR YEAR.
*******************************************************************************/
 
*ARGUMENT for the file
args weight

*First sort by date:
sort date

*Create variable to hold the monthly weights of the stocks.
gen float mweights = 0
*Format it so it's NOT in scientific notation.
format %13.0g mweights
*Move the monthly weight variable after return.
order mweights, after(returns)

*Create TOTAL ANNUAL CAP variable.
gen double total_cap = 0
*Format it so it's NOT in scientific notation.
format %13.0g total_cap

if `weight' == 0 {
	*Calculate the TOTAL_CAP for the YEAR. This is ONLY NECESSARY for value-weighted.
	*****JANUARY*****
	capture sum cap if substr(string(date), 5, 6) == "01"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "01"
	*****FEBRUARY*****
	capture sum cap if substr(string(date), 5, 6) == "02"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "02"
	*****MARCH*****
	capture sum cap if substr(string(date), 5, 6) == "03"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "03"
	*****APRIL*****
	capture sum cap if substr(string(date), 5, 6) == "04"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "04"
	*****MAY*****
	capture sum cap if substr(string(date), 5, 6) == "05"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "05"
	*****JUNE*****
	capture sum cap if substr(string(date), 5, 6) == "06"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "06"
	*****JULY*****
	capture sum cap if substr(string(date), 5, 6) == "07"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "07"
	*****AUGUST*****
	capture sum cap if substr(string(date), 5, 6) == "08"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "08"
	*****SEPTEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "09"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "09"
	*****OCTOBER*****
	capture sum cap if substr(string(date), 5, 6) == "10"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "10"
	*****NOVEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "11"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "11"
	*****DECEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "12"
	replace total_cap = r(sum) if substr(string(date), 5, 6) == "12"
	*Use VALUE-WEIGHTED returns.
	*Calculate it by using the total caps to calculate mweights.
	replace mweights = cap / total_cap
}

if `weight' == 1 {
	*Use EQUAL-WEIGHTED returns.
	*****JANUARY*****
	capture sum mweights if substr(string(date), 5, 6) == "01" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "01" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "01"
	*****FEBRUARY*****
	capture sum mweights if substr(string(date), 5, 6) == "02" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "02" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "02"
	*****MARCH*****
	capture sum mweights if substr(string(date), 5, 6) == "03" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "03" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "03"
	*****APRIL*****
	capture sum mweights if substr(string(date), 5, 6) == "04" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "04" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "04"
	*****MAY*****
	capture sum mweights if substr(string(date), 5, 6) == "05" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "05" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "05"
	*****JUNE*****
	capture sum mweights if substr(string(date), 5, 6) == "06" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "06" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "06"
	*****JULY*****
	capture sum mweights if substr(string(date), 5, 6) == "07" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "07" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "07"
	*****AUGUST*****
	capture sum mweights if substr(string(date), 5, 6) == "08" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "08" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "08"
	*****SEPTEMBER*****
	capture sum mweights if substr(string(date), 5, 6) == "09" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "09" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "09"
	*****OCTOBER*****
	capture sum mweights if substr(string(date), 5, 6) == "10" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "10" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "10"
	*****NOVEMBER*****
	capture sum mweights if substr(string(date), 5, 6) == "11" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "11" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "11"
	*****DECEMBER*****
	capture sum mweights if substr(string(date), 5, 6) == "12" & short == 0
	local i = `r(N)'
	capture sum mweights if substr(string(date), 5, 6) == "12" & short == 1
	local i = `i' - `r(N)'
	replace mweights = 1 / `i' if substr(string(date), 5, 6) == "12"
}

*Drop TOTAL_CAP.
drop total_cap
