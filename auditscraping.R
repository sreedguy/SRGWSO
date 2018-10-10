# due to website format, table from https://wuedata.water.ca.gov/awwa_plans was copied into excel
# macro was used to extract the URL as text
# see 2018SubmissionsRawXLMacro.xlsm (680 - Validations > 2 - Validation Reporting) for macro
library(magrittr)
library(dplyr)
library(tidyverse)

######### File Read & Format ############
setwd("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting")
rawsub <- read.csv("2018SubmissionsRawCSV.csv")

# renaming columns
colnames(rawsub)[1] <- "utilityName"
colnames(rawsub)[2] <- "date"
rawsub$Reviewed.by.DWR <- NULL
colnames(rawsub)[3] <- "url"
# retype columns
rawsub <- data.frame(lapply(rawsub, as.character), stringsAsFactors=FALSE)

# convert date to date format & type
dateFormat <- "%m/%d/%Y"
rawsub <- rawsub %>% 
  mutate_at(vars(contains('date', ignore.case = T)), funs(as.Date(., format = dateFormat)))

#remove formatting on any name with slashes like Cal Water Redondo/Hermosa & Los Alto/Suburban
rawsub$utilityName <- gsub('/', ' ', rawsub$utilityName)

#taking most recent entry
rawsub <- rawsub %>% 
  group_by(utilityName) %>%
  arrange(desc(date)) %>%
  filter(row_number()==1) %>%
  ungroup()

# removing dates before 2018 & arrange by utility name
rawsub <- rawsub %>%
  filter(date > "2017-12-31") %>%
  arrange(utilityName)

# append standard column ending
fileend <- "(2018 Submission).xls"
rawsub$utilityName <- paste(rawsub$utilityName, fileend)

# changing "Of" in 2018 files to "of" in 2017 files
rawsub$utilityName <- gsub('Of', 'of', rawsub$utilityName)

###### Download Loop #####
setwd("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting\\2018 Submissions")

for(i in seq_along(rawsub$url)) {
  url <- rawsub$url[i]
  destin <- rawsub$utilityName[i]
  url[i] <- rawsub$url[i]
  destin[i] <- rawsub$utilityName[i]
  download.file(url[i], destin[i], mode = "wb")
}

setwd(("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting\\Output"))
write.csv(rawsub, file = "clean2018submissions.csv")


######### ID Unmatched Names ############
#take previous name key and cross reference it to current list of names
setwd(("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting\\Output"))
#read in 2017 names
svntn <- read.csv("2017finalNameclean.csv")
colnames(svntn)[1] <- "utilityName"
svntn <- svntn %>%
  group_by(utilityName) %>%
  filter(row_number()==1) %>%
  ungroup()

# read in 2018 names
egttn <- read.csv("2018finalNameclean.csv")
colnames(egttn)[1] <- "utilityName"

# replacing capital 'O' with lower case 'o' more commonly used in previous versions
egttn$utilityName <- gsub('Of', 'of', egttn$utilityName)

# define and write a file of unmatched names
unmatched <- setdiff(egttn,svntn)
setwd(("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting"))
write.csv(unmatched, file = "unmatched2018names.csv")

###### List Files in Submission 2018 ######
# for final names in 2018 name key (original name, script renaming, and final names)
filep <- "G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting\\2018 Submissions"
finalnames <- list.files(filep)
setwd(("G:\\Team Drives\\WSO USA - Projects\\680 - Validations\\Validation\\2 - Validation Reporting\\Output"))
write.csv(finalnames, file = "final2018names.csv")
