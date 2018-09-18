setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Westborough County Water District\\Data Transfer")
library(xlsx)
marchbill <- read.xlsx("20170315_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
marchcomplete <- marchbill[complete.cases(marchbill), ]
newcolnames<- c("Rte/Serv",
"A",
"Cust.ID",
"Loc.ID",
"CL",
"SZ",
"Class Name",
"Service",
"Units",
"Prior",
"Current",
"Usage",
"Rate",
"Use-Amt",
"Total")
colnames(marchcomplete) = newcolnames
marchcomplete$readDate <- "03/01/17"
maybill <- read.xlsx("20170515_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
maycomplete <- maybill[complete.cases(maybill), ]
colnames(maycomplete) = newcolnames
maycomplete$readDate <- "05/01/17"
julybill <-read.xlsx("20170715_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
julycomplete <- julybill[complete.cases(julybill), ]
colnames(julycomplete) = newcolnames
julycomplete$readDate <- "07/01/17"
septbill <-read.xlsx("20170915_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
septcomplete <- septbill[complete.cases(septbill), ]
colnames(septcomplete) = newcolnames
septcomplete$readDate <- "09/01/17"
novbill <-read.xlsx("20171115_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
novcomplete <- novbill[complete.cases(novbill), ]
colnames(novcomplete) = newcolnames
novcomplete$readDate <- "11/01/17"
janbill <-read.xlsx("20180115_Billing Run.xlsx", sheetIndex = 1, as.data.frame = TRUE, header = FALSE)
jancomplete <- janbill[complete.cases(janbill), ]
colnames(jancomplete) = newcolnames
jancomplete$readDate <- "01/01/18"

l <- list(marchcomplete,maycomplete,julycomplete,septcomplete,novcomplete,jancomplete)
library(dplyr)
billing <- rbind_list(l)
write.csv(billing, file = "BillingDataWSO2.csv")



