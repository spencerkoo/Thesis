/*******************************************************************************
Spencer Koo
Senior Thesis
BIC.do

ARGUMENT: year

Here are the names of the industry classes:
1 Consumer Non-Durables
2 Consumer Durables
3 Manufacturing
4 Energy
5 Business Equipment
6 Telecom
7 Shopping
8 Healthcare
9 Utilities
0 All Other

This function just separates ONE YEAR'S companies by sector to keep it in the
main file to keep for later since the sector will need to be known later.
*******************************************************************************/

*Arguments for this function.
args year

*This data is ONE YEAR, NO DUPE PERMNOs.
use bic_`year'_base, clear

**********************Save each SECTOR as a separate file.**********************
*1 Consumer Non-Durables - Food, Tobacco, Textiles, Apparel, Leather, Toys*
use bic_`year'_base, clear
keep if sic >= 100 & sic <= 999
save bic_`year'_1a, replace
use bic_`year'_base, clear
keep if sic >= 2000 & sic <= 2399
save bic_`year'_1b, replace
use bic_`year'_base, clear
keep if sic >= 2700 & sic <= 2749
save bic_`year'_1c, replace
use bic_`year'_base, clear
keep if sic >= 2770 & sic <= 2799
save bic_`year'_1d, replace
use bic_`year'_base, clear
keep if sic >= 3100 & sic <= 3199
save bic_`year'_1e, replace
use bic_`year'_base, clear
keep if sic >= 3940 & sic <= 3989
save bic_`year'_1f, replace
*Append them together.
use bic_`year'_1a, clear
append using bic_`year'_1b
append using bic_`year'_1c
append using bic_`year'_1d
append using bic_`year'_1e
append using bic_`year'_1f
*Change sector variable.
replace sector = 1
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector1, replace
*Erase leftover files.
erase bic_`year'_1a.dta
erase bic_`year'_1b.dta
erase bic_`year'_1c.dta
erase bic_`year'_1d.dta
erase bic_`year'_1e.dta
erase bic_`year'_1f.dta

*2 Consumer Durables - Cars, TV's, Furniture, Household Appliances*
use bic_`year'_base, clear
keep if sic >= 2500 & sic <= 2519
save bic_`year'_2a, replace
use bic_`year'_base, clear
keep if sic >= 2590 & sic <= 2599
save bic_`year'_2b, replace
use bic_`year'_base, clear
keep if sic >= 3630 & sic <= 3659
save bic_`year'_2c, replace
use bic_`year'_base, clear
keep if sic >= 3710 & sic <= 3711
save bic_`year'_2d, replace
use bic_`year'_base, clear
keep if sic >= 3714 & sic <= 3714
save bic_`year'_2e, replace
use bic_`year'_base, clear
keep if sic >= 3716 & sic <= 3716
save bic_`year'_2f, replace
use bic_`year'_base, clear
keep if sic >= 3750 & sic <= 3751
save bic_`year'_2g, replace
use bic_`year'_base, clear
keep if sic >= 3792 & sic <= 3792
save bic_`year'_2h, replace
use bic_`year'_base, clear
keep if sic >= 3900 & sic <= 3939
save bic_`year'_2i, replace
use bic_`year'_base, clear
keep if sic >= 3990 & sic <= 3999
save bic_`year'_2j, replace
*Append them together.
use bic_`year'_2a, clear
append using bic_`year'_2b
append using bic_`year'_2c
append using bic_`year'_2d
append using bic_`year'_2e
append using bic_`year'_2f
append using bic_`year'_2g
append using bic_`year'_2h
append using bic_`year'_2i
append using bic_`year'_2j
*Change sector variable.
replace sector = 2
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector2, replace
*Erase leftover files.
erase bic_`year'_2a.dta
erase bic_`year'_2b.dta
erase bic_`year'_2c.dta
erase bic_`year'_2d.dta
erase bic_`year'_2e.dta
erase bic_`year'_2f.dta
erase bic_`year'_2g.dta
erase bic_`year'_2h.dta
erase bic_`year'_2i.dta
erase bic_`year'_2j.dta

*3 Manufacturing - Machinery, Trucks, Planes, Chemicals, Off Furn, Paper, Com Printing*
use bic_`year'_base, clear
keep if sic >= 2520 & sic <= 2589
save bic_`year'_3a, replace
use bic_`year'_base, clear
keep if sic >= 2600 & sic <= 2699
save bic_`year'_3b, replace
use bic_`year'_base, clear
keep if sic >= 2750 & sic <= 2769
save bic_`year'_3c, replace
use bic_`year'_base, clear
keep if sic >= 2800 & sic <= 2829
save bic_`year'_3d, replace
use bic_`year'_base, clear
keep if sic >= 2840 & sic <= 2899
save bic_`year'_3e, replace
use bic_`year'_base, clear
keep if sic >= 3000 & sic <= 3099
save bic_`year'_3f, replace
use bic_`year'_base, clear
keep if sic >= 3200 & sic <= 3569
save bic_`year'_3g, replace
use bic_`year'_base, clear
keep if sic >= 3580 & sic <= 3621
save bic_`year'_3h, replace
use bic_`year'_base, clear
keep if sic >= 3623 & sic <= 3629
save bic_`year'_3i, replace
use bic_`year'_base, clear
keep if sic >= 3700 & sic <= 3709
save bic_`year'_3j, replace
use bic_`year'_base, clear
keep if sic >= 3712 & sic <= 3713
save bic_`year'_3k, replace
use bic_`year'_base, clear
keep if sic >= 3715 & sic <= 3715
save bic_`year'_3l, replace
use bic_`year'_base, clear
keep if sic >= 3717 & sic <= 3749
save bic_`year'_3m, replace
use bic_`year'_base, clear
keep if sic >= 3752 & sic <= 3791
save bic_`year'_3n, replace
use bic_`year'_base, clear
keep if sic >= 3793 & sic <= 3799
save bic_`year'_3o, replace
use bic_`year'_base, clear
keep if sic >= 3860 & sic <= 3899
save bic_`year'_3p, replace
*Append them together.
use bic_`year'_3a, clear
append using bic_`year'_3b
append using bic_`year'_3c
append using bic_`year'_3d
append using bic_`year'_3e
append using bic_`year'_3f
append using bic_`year'_3g
append using bic_`year'_3h
append using bic_`year'_3i
append using bic_`year'_3j
append using bic_`year'_3k
append using bic_`year'_3l
append using bic_`year'_3m
append using bic_`year'_3n
append using bic_`year'_3o
append using bic_`year'_3p
*Change sector variable.
replace sector = 3
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector3, replace
*Erase leftover files.
erase bic_`year'_3a.dta
erase bic_`year'_3b.dta
erase bic_`year'_3c.dta
erase bic_`year'_3d.dta
erase bic_`year'_3e.dta
erase bic_`year'_3f.dta
erase bic_`year'_3g.dta
erase bic_`year'_3h.dta
erase bic_`year'_3i.dta
erase bic_`year'_3j.dta
erase bic_`year'_3k.dta
erase bic_`year'_3l.dta
erase bic_`year'_3m.dta
erase bic_`year'_3n.dta
erase bic_`year'_3o.dta
erase bic_`year'_3p.dta

*4 Oil, Gas, and Coal Extraction and Products*
use bic_`year'_base, clear
keep if sic >= 1200 & sic <= 1399
save bic_`year'_4a, replace
use bic_`year'_base, clear
keep if sic >= 2900 & sic <= 2999
save bic_`year'_4b, replace
*Change sector variable.
replace sector = 4
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector4, replace
*Erase leftover files.
erase bic_`year'_4a.dta
erase bic_`year'_4b.dta

*5 Tech - Business Equipment - Computers, Software, and Electronic Equipment*
use bic_`year'_base, clear
keep if sic >=3570 & sic <= 3579
save bic_`year'_5a, replace
use bic_`year'_base, clear
keep if sic >=3622 & sic <= 3622
save bic_`year'_5b, replace
use bic_`year'_base, clear
keep if sic >=3660 & sic <= 3692
save bic_`year'_5c, replace
use bic_`year'_base, clear
keep if sic >=3694 & sic <= 3699
save bic_`year'_5d, replace
use bic_`year'_base, clear
keep if sic >=3810 & sic <= 3839
save bic_`year'_5e, replace
use bic_`year'_base, clear
keep if sic >=7370 & sic <= 7372
save bic_`year'_5f, replace
use bic_`year'_base, clear
keep if sic >=7373 & sic <= 7373
save bic_`year'_5g, replace
use bic_`year'_base, clear
keep if sic >=7374 & sic <= 7374
save bic_`year'_5h, replace
use bic_`year'_base, clear
keep if sic >=7375 & sic <= 7375
save bic_`year'_5i, replace
use bic_`year'_base, clear
keep if sic >=7376 & sic <= 7376
save bic_`year'_5j, replace
use bic_`year'_base, clear
keep if sic >=7377 & sic <= 7377
save bic_`year'_5k, replace
use bic_`year'_base, clear
keep if sic >=7378 & sic <= 7378
save bic_`year'_5l, replace
use bic_`year'_base, clear
keep if sic >=7379 & sic <= 7379
save bic_`year'_5m, replace
use bic_`year'_base, clear
keep if sic >=7391 & sic <= 7391
save bic_`year'_5n, replace
use bic_`year'_base, clear
keep if sic >=8730 & sic <= 8734
save bic_`year'_5o, replace
*Append them together.
use bic_`year'_5a, clear
append using bic_`year'_5b
append using bic_`year'_5c
append using bic_`year'_5d
append using bic_`year'_5e
append using bic_`year'_5f
append using bic_`year'_5g
append using bic_`year'_5h
append using bic_`year'_5i
append using bic_`year'_5j
append using bic_`year'_5k
append using bic_`year'_5l
append using bic_`year'_5m
append using bic_`year'_5n
append using bic_`year'_5o
*Change sector variable.
replace sector = 5
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector5, replace
*Erase leftover files.
erase bic_`year'_5a.dta
erase bic_`year'_5b.dta
erase bic_`year'_5c.dta
erase bic_`year'_5d.dta
erase bic_`year'_5e.dta
erase bic_`year'_5f.dta
erase bic_`year'_5g.dta
erase bic_`year'_5h.dta
erase bic_`year'_5i.dta
erase bic_`year'_5j.dta
erase bic_`year'_5k.dta
erase bic_`year'_5l.dta
erase bic_`year'_5m.dta
erase bic_`year'_5n.dta
erase bic_`year'_5o.dta

*6 Telecom - Telephone and Television Transmission*
use bic_`year'_base, clear
keep if sic >= 4800 & sic <= 4899
*Change sector variable.
replace sector = 6
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector6, replace

*7 Shops - Wholesale, Retail, and Some Services (Laundries, Repair Shops)*
use bic_`year'_base, clear
keep if sic >= 5000 & sic <= 5999
save bic_`year'_7a, replace
use bic_`year'_base, clear
keep if sic >= 7200 & sic <= 7299
save bic_`year'_7b, replace
use bic_`year'_base, clear
keep if sic >= 7600 & sic <= 7699
save bic_`year'_7c, replace
*Append them together.
use bic_`year'_7a, clear
append using bic_`year'_7b
append using bic_`year'_7c
*Change sector variable.
replace sector = 7
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector7, replace
*Erase leftover files.
erase bic_`year'_7a.dta
erase bic_`year'_7b.dta
erase bic_`year'_7c.dta

*8 Heatlh - Healthcare, Medical Equipment, and Drugs*
use bic_`year'_base, clear
keep if sic >= 2830 & sic <= 2839
save bic_`year'_8a, replace
use bic_`year'_base, clear
keep if sic >= 3693 & sic <= 3693
save bic_`year'_8b, replace
use bic_`year'_base, clear
keep if sic >= 3840 & sic <= 3859
save bic_`year'_8c, replace
use bic_`year'_base, clear
keep if sic >= 8000 & sic <= 8099
save bic_`year'_8d, replace
*Append them together.
use bic_`year'_8a, clear
append using bic_`year'_8b
append using bic_`year'_8c
append using bic_`year'_8d
*Change sector variable.
replace sector = 8
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector8, replace
*Erase leftover files.
erase bic_`year'_8a.dta
erase bic_`year'_8b.dta
erase bic_`year'_8c.dta
erase bic_`year'_8d.dta

*9 Utilities*
use bic_`year'_base, clear
keep if sic >= 4900 & sic <= 4949
*Change sector variable.
replace sector = 9
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector9, replace

*10 Other - Mines, Constr, BldMt, Trans, Hotels, Bus Serv, Entertainment, Finance*
*********************SECTOR 1*********************
*Start with sector 1.
use bic_`year'_sector1, clear
*Save as representing all sectors except for 10.
save bic_`year'_not10, replace
*Erase sector 1 file.
*erase bic_`year'_sector1.dta
*Create a list of all the companies in all the other sectors for that year.
*And then erase the the sector dta files for that year.
foreach i of num 2/9 {
	append using bic_`year'_sector`i'
	*erase bic_`year'_sector`i'.dta
}
*Resave not10 file.
save bic_`year'_not10, replace
*Go back to the original bic_`year'_base file.
use bic_`year'_base, clear
*Find total number of obs in that in bic_`year'_base.
sum permno
scalar sector_obs = `r(N)'
*Add all the companies except for those in industry sector 10.
append using bic_`year'_not10
*Create boolean variable that shows which observations are not in sector 10.
gen byte in_it = 0
*Run loop to find duplicates. I.e. already in a sector.
local n = _N
forval i = `=scalar(sector_obs)+1'/`n' {
	replace in_it = 1 if permno[_n] == permno[`i']
}
*Drop the appended extra observations used to mark which PERMNOs would be in
*the sector.
local n = _N
drop in `=scalar(sector_obs)+1'/`n'
*Drop those observations already assigned a sector.
drop if in_it == 1
*Drop var completely.
drop in_it
*The remaining observations are unassigned prior so must be in sector 10.
*Change sector variable.
replace sector = 10
*Sort the file to be ready for screening.
sort permno date
*Save as one file.
save bic_`year'_sector10, replace

*Create an updated file, which is for ONE YEAR, NO DUPE PERMNOs, but it also has
*the sector variable.
use bic_`year'_sector1, clear
append using bic_`year'_sector2
append using bic_`year'_sector3
append using bic_`year'_sector4
append using bic_`year'_sector5
append using bic_`year'_sector6
append using bic_`year'_sector7
append using bic_`year'_sector8
append using bic_`year'_sector9
append using bic_`year'_sector10
*Save as a temp file that will be renamed when the script returns to make_one_year_port.do.
*The necessary arguments are not in this do file to name it properly.
save temp, replace

*Erase the individual files.
erase bic_`year'_sector1.dta
erase bic_`year'_sector2.dta
erase bic_`year'_sector3.dta
erase bic_`year'_sector4.dta
erase bic_`year'_sector5.dta
erase bic_`year'_sector6.dta
erase bic_`year'_sector7.dta
erase bic_`year'_sector8.dta
erase bic_`year'_sector9.dta
erase bic_`year'_sector10.dta

*Get rid of the extra files.
erase bic_`year'_base.dta
erase bic_`year'_not10.dta
