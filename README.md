# Thesis
Showcasing my data manipulation skills using Stata.

The data comes from multiple sources including KLD Research & Analytics, Ken French of Dartmouth University, and the CRSP database. Because my work is from an academic setting, I do not have the rights to post any of the relevant data. However, the scripting I wrote in Stata as well as the final product are posted in the repository.
At the time, I was attempting to improve my skills in Stata so I wrote the scripts in Stata .do files. I could have easily done the data manipulation in SQL or Python or learned another language such as R.

This research paper focuses on the viability of socially responsible investing (SRI) using historical stock data from the S&P 500 and the Russell 3000 over the course of 13 years. In other words, does investing in socially responsible firms deliver excess returns compared to the market?

The project was fully comprehensive. I had to find the data sources, download the data, format and combine the datasets/tables, run regressions on the manipulated data, and then analyze my results.

Requisites:
Stata13

In order to run the code, the data (.dta files; I did not include my .do files used to combine and format the multiple tables I had originally) and the .do files should be placed in the same directory. Then, in Stata, the run.do file should be called. The entire process takes around 10-15 minutes because the data files contain hundreds of thousands of data points. Multiple instances can be run on smaller chunks of the data to expedite the run time.
