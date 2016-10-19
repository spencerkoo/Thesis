/*******************************************************************************
Spencer Koo
Senior Thesis
SECTOR_WEIGHTING.do

ARGUMENTS: bic
1) BIC: 0, 1

This calculates the sector weights by summing the total market cap for one
indusry sector and then taking each individual company's cap in that sector and
dividing it by the total sector cap. That's the sector weight (SWEIGHT).
These sector weights will ALL be VALUE-WEIGHTED.
*******************************************************************************/
 
*ARGUMENT for the file
args bic

if `bic' == 1 {
	*Create variable to hold the sector weights of the stocks.
	gen float sweights = 0
	*Format it so it's NOT in scientific notation.
	format %13.0g sweights
	*Move SECTOR WEIGHTS (sweights) after default returns.
	order sweights, after(returns)

	*Go through ALL MONTHS.
	*Calculations will be:
	*1) Total cap of ALL SECTORS per month (i.e. total market cap per month).
	*2) Total cap of INDIVIDUAL SECTOR per month.
	*3) Divide 2)/1) to get the sector weight.
	*4) Must be bic == 1.
	*****JANUARY*****
	capture sum cap if substr(string(date), 5, 6) == "01"
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "01"
		replace sweights = r(sum)/`x' if sector == `i' & substr(string(date), 5, 6) == "01" 
	}
	*****FEBRUARY*****
	capture sum cap if substr(string(date), 5, 6) == "02" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "02" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "02" 
	}
	*****MARCH*****
	capture sum cap if substr(string(date), 5, 6) == "03" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "03" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "03" 
	}
	*****APRIL*****
	capture sum cap if substr(string(date), 5, 6) == "04" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "04" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "04" 
	}
	*****MAY*****
	capture sum cap if substr(string(date), 5, 6) == "05" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "05" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "05" 
	}
	*****JUNE*****
	capture sum cap if substr(string(date), 5, 6) == "06" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "06" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "06" 
	}
	*****JULY*****
	capture sum cap if substr(string(date), 5, 6) == "07" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "07" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "07" 
	}
	*****AUGUST*****
	capture sum cap if substr(string(date), 5, 6) == "08" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "08" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "08" 
	}
	*****SEPTEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "09" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "09" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "09" 
	}
	*****OCTOBER*****
	capture sum cap if substr(string(date), 5, 6) == "10" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "10" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "10" 
	}
	*****NOVEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "11" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "11" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "11" 
	}
	*****DECEMBER*****
	capture sum cap if substr(string(date), 5, 6) == "12" 
	*This local macro is the total monthly market cap (i.e. all sectors for that month).
	local x = `r(sum)'
	*For this month, loop through each of the 10 industry sectors.
	foreach i of num 1/10 {
		capture sum cap if sector == `i' & substr(string(date), 5, 6) == "12" 
		replace sweights = r(sum) / `x' if sector == `i' & substr(string(date), 5, 6) == "12" 
	}


	*Use these calculated sector weights to find the total monthly returns of all
	*the sectors together.
	replace returns = returns * sweights
	format %13.0g sweights
}
