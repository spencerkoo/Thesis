/*******************************************************************************
Spencer Koo
Senior Thesis
FORMAT.DO

ARGUMENTS: none

Format the merged data to make it easier to do for each portfolio. And solve
for weights. Use the output of this do file for each one of the portfolios
since I will have to do these manipulations regardless.
*******************************************************************************/
/*
set working directory to "C:\Users\Spencer\Dropbox\School\Princeton\4 Senior\
Thesis\Socially Responsible Investing\Data\1 Combined\2 Portfolios"
*/

use 1_merged, clear


replace returns = returns * 100
replace mom = mom * 100
replace smb = smb * 100
replace hml = hml * 100
replace rf = rf * 100
replace rmrf = rmrf * 100


**********INCREMENT YEAR***********
*so... I realize that I already had a year variable... so I'm just going to go
*back to the merge.do file and not drop the year variable.
*that means that I do have to add 1 to each year so that it's not so confusing
*REMEMBER: KLD data is from 91-03 while the CRSP financial data is from 92-04
*recode the year to +1
gen yr = year + 1
*drop original variable and move the new one to the front and rename it to
*original name
drop year
order yr, before(date)
rename yr year


**********REMOVE DAYS from DATE**********
*Getting rid of the days digits in the date & taking the var name date.
gen month = int(date/100)
*Apparently ints cut off the decimal too without rounding when casting.
order month, before(date)
drop date
rename month date


**********RENAME CATEGORIES**********
rename alc_con_a alcohol
rename gam_con_a gambling
rename mil_con_a military
rename nuc_con_a nuclear
rename tob_con_a tobacco
rename fir_con_a firearms


**********ADD VARIABLE for COMBO SCREENS**********
*Create a variable that sums the total number of strs (+ complement cons).
gen sum_all_total = com_total + hum_total + emp_total + env_total + div_total + pro_total
*Create a variable that sums the total number of all the subcategories.
gen sum_all_subcats = com_sum_subcats + hum_sum_subcats + emp_sum_subcats + env_sum_subcats + div_sum_subcats + pro_sum_subcats
*Now find the average.
gen avg_rank = sum_all_total / sum_all_subcats
*Drop the uncessary ones.
drop sum_all_total sum_all_subcats
*Move this average score after all the KLD data.
order avg_rank, after(pro_rank)


**********REORDER CATEGORIES to SAME as PAPER**********
order alcohol gambling military nuclear tobacco firearms, before(env_str_a)
order env_str_a env_str_b env_str_c env_str_d env_str_f env_str_x env_con_a env_con_b env_con_c env_con_d env_con_e env_con_f env_con_x env_total env_sum_subcats env_rank, after(emp_rank)
order hum_str_a hum_str_d hum_str_g hum_str_x hum_con_a hum_con_b hum_con_c hum_con_d hum_con_f hum_con_g hum_con_x hum_total hum_sum_subcats hum_rank, after(env_rank)
order div_str_a div_str_b div_str_c div_str_d div_str_e div_str_f div_str_g div_str_x div_con_a div_con_b div_con_x div_total div_sum_subcats div_rank, after(com_rank)


**********RENAME RANK VARS WITH NUMBERS**********
rename com_rank rank1
rename div_rank rank2
rename emp_rank rank3
rename env_rank rank4
rename hum_rank rank5
rename pro_rank rank6


**********SEE WHERE NEXT PERMNO STARTS**********
*I'm sorting here because, in order for the newpermno function to work, the
*data must be sorted by year, then permno, then date
*sort by year, permno, then date
sort year permno date

*next, I am going to generate another boolean that compares the current obs
*to the previous one. if the value is the same, then the new boolean gets a 0.
*this is used to know where the new PERMNOs begin so that I can compare the KLD
*data easily without deleting all the observations (since there are so many
*copies for each company).
gen byte newpermno = 0 if permno[_n] == permno[_n-1]
*now recode the missing values to 1 (meaning it's a new permno)
*and relocate it with the other identifiers
recode newpermno (mis = 1)
order newpermno, after(permno)

**********ADD INTEGER VARIABLE for SPECIFIC SECTOR**********
gen int sector = 0
order sector, after(sic)

**********ADD BOOLEAN VARIABLE for SHORTED PORTFOLIO IN LS**********
gen byte short = 0

*save the formatted data
save 2_formatted, replace
