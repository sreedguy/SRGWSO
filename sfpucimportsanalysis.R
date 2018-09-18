setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Imports")
imports <- read.csv("sfpucimport.csv")

startDate <- as.Date("2017-01-01") # start date of the audit period. Remember to use "2015-01-01" format here. 
endDate <- as.Date("2017-12-31") # end date of the audit period
#functions
naScan <- function(x) { # counting for NA value
  sum(is.na(x)) # or... x %>% is.na() %>% sum()
}

blankScan <- function(x) { # Identifying empty strings or strings with just spaces
  sum(grepl("^$|^[ \\t]+$" , x)) # or... x %>% is.na() %>% sum()
}

commaScan <- function(x) { # identifying if number fields have commas
  sum(grepl(",", x)) 
}

pasteThree <- function(x) {# List unique values in a character vector in a single character string seperated by commas.
  items <- paste(x[1:3], collapse = ", ")
  return(items)
}

###CHANGE COLUMN TYPES $ NAMES
standardize <- data.frame(
  "oldNames" = colnames(imports),
  "oldTypes" = sapply(imports, class),
  "naCount" = sapply(imports, naScan),
  "blankCount" = sapply(imports, blankScan),
  "commaCount" = sapply(imports, commaScan), # in case numeric fields just have a lot of commas, use numericCommas custom data class
  "sampleValues" = sapply(imports, pasteThree),
  "newNames" = "Enter new column names",
  "newTypes" = "character", # remember custom type, "numericCommas",
  stringsAsFactors = F
)
standardize <- edit(standardize)
write.csv(standardize, file = "standardize.csv", row.names=F)
imports <- read.csv("sfpucimport.csv", stringsAsFactors = F, header = T, col.names = standardize$newNames, colClasses = standardize$newTypes)

imports$currentRead <- as.numeric(imports$currentRead)
imports$flow <- as.numeric(imports$flow)

###DATE TIME FORMAT
library(tidyr)
imports <-separate(imports, readDateTime, into = c("readDate", "readTime"), sep = " (?=[^ ]+$)")


dateFormat <- "%Y-%m-%d"
timeFormat <- "%H:%M"
library(magrittr)
library(dplyr)
testDate <- imports %>% 
  mutate_at(vars(contains('date', ignore.case = T)), funs(as.Date(., format = dateFormat))) %>% 
  select(matches("date", ignore.case = T)) %>% 
  summarize_all(funs(naScan))

imports <- imports %>% # globally recode dates -- modify as needed to encode all dates correctly
  mutate_at(vars(contains('date', ignore.case = T)), funs(as.Date(., format = dateFormat)))

gsub(":", "", as.character(imports$readTime))

imports$readMonth <- strftime(imports$readDate, format = "%Y-%m-01")
imports$readMonth <- as.Date(imports$readMonth)

#testtime <- sort(imports$readTime)
#testdate2 <- sort(imports$readDate)
####CALCULATE CONSUMPTION
#need to group by meter, by date, order by time
readID <- c("readDate", "meterID")
imports$currentRead[is.na(imports$currentRead)] <- 0


#imports <- imports %>% mutate(calcCons = ifelse(imports$currentRead <= 34324 & imports$meterID == "3500000241", imports$currentRead+1000000, imports$currentRead))
#library(tidyverse)
imports$dateString <- strftime(imports$readDate)
imports$time <- paste(imports$dateString, imports$readTime, sep = " ")
imports$time <- as.POSIXct(imports$time)

importsTemp <- imports %>% 
  arrange(meterID, time) %>%
  group_by(meterID) %>% 
  mutate(prevRead = lag(currentRead, n = 1L)) %>%
  ungroup()

importsTemp <- importsTemp %>% # need to reqrite variabale names in master
  mutate(calc = ifelse(prevRead > currentRead, (10^nchar(prevRead) - prevRead) + currentRead, currentRead - prevRead)) 

importsTemp$calc[is.na(importsTemp$calc)] <- 0

auditimports <- importsTemp %>% filter(dateString >= "2017-01-01 00:59:00" & dateString <= "2017-12-31 23:59:00")
(sum(auditimports$calc)*100*7.48)/325851


monthmeter <- c("readMonth", "meterID")

monthSum <- auditimports %>%
group_by_(.dots = "readMonth", "meterID") %>%
summarise(monthmetercons = sum(calc)) %>%
  arrange(meterID) %>%
ungroup()
write.csv(monthSum, file = "AMImonthlysums.csv", row.names=F)
