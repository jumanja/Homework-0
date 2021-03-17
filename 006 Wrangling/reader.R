#Key points
#readr is the tidyverse library that includes functions for reading data stored in text file spreadsheets into R. Functions in the package include read_csv(), read_tsv(), read_delim() and more. These differ by the delimiter they use to split columns.
#The readxl package provides functions to read Microsoft Excel formatted files.
#The excel_sheets() function gives the names of the sheets in the Excel file. These names are passed to the sheet argument for the readxl functions read_excel(), read_xls() and read_xlsx().
#The read_lines() function shows the first few lines of a file in R.
#Code
library(dslabs)
library(tidyverse)    # includes readr
library(readxl)

# inspect the first 3 lines
read_lines("murders.csv", n_max = 3)

# read file in CSV format
dat <- read_csv(filename)

#read using full path
dat <- read_csv(fullpath)
head(dat)

#Ex：
path <- system.file("extdata", package = "dslabs")
files <- list.files(path)
files

filename <- "murders.csv"
filename1 <- "life-expectancy-and-fertility-two-countries-example.csv"
filename2 <- "fertility-two-countries-example.csv"
dat=read.csv(file.path(path, filename))
dat1=read.csv(file.path(path, filename1))
dat2=read.csv(file.path(path, filename2))

#Key point
#R-base import functions (read.csv(), read.table(), read.delim()) generate data frames rather than tibbles and character variables are converted to factors. This can be avoided by setting the argument stringsAsFactors=FALSE.
#Code
# filename is defined in the previous video
# read.csv converts strings to factors
dat2 <- read.csv(filename)
class(dat2$abb)
class(dat2$region)
