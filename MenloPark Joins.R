library(readxl)
library(dplyr)
##Menlo Park Joins
####binding meter reads
setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Meter Reads")

a <- read.csv("02 Menlo Park Reads 12-2016.csv")
b <- read.csv("02 Menlo Park Reads 1-2017.csv", header = T)
c <- read.csv("02 Menlo Park Reads 2-2017.csv", header = T)
d <- read.csv("02 Menlo Park Reads 3-2017.csv", header = T)
nameD <- colnames(d)
e <- read.csv("02 Menlo Park Reads 4-2017.csv", header = T)
nameE <- colnames(e)
setdiff(nameE,nameD)### checking for and nullifying column names that do not match 
e$D_PRDATE <- NULL
f <- read.csv("02 Menlo Park Reads 5-2017.csv", header = T)
nameF <- colnames(f)
setdiff(nameF,nameD)
f$D_PRDATE <- NULL
f$X <- NULL
g <- read.csv("02 Menlo Park Reads 6-2017.csv", header = T)
colnames(g)
g$D_PRDATE <- NULL
h <- read.csv("02 Menlo Park Reads 7-2017.csv", header = T)
h$D_PRDATE <- NULL
i <- read.csv("02 Menlo Park Reads 8-2017.csv", header = T)
i$D_PRDATE <- NULL
j <- read.csv("02 Menlo Park Reads 9-2017.csv", header = T)
j$D_PRDATE <- NULL
k <- read.csv("02 Menlo Park Reads 10-2017.csv", header = T)
k$D_PRDATE <- NULL
l <- read.csv("02 Menlo Park Reads 11-2017.csv", header = T)
l$D_PRDATE <- NULL
m <- read.csv("02 Menlo Park Reads 12-2017.csv", header = T)
m$D_PRDATE <- NULL
n <- read.csv("02 Menlo Park Reads 1-2018.csv", header = T)
n$D_PRDATE <- NULL

ab <- rbind(a, b)
bc <- rbind(ab, c)
cd <- rbind(bc, d)
de <- rbind(cd, e) 
ef <- rbind(de, f)
fg <- rbind(ef, g)
gh <- rbind(fg, h)
hi <- rbind(gh, i)
ij <- rbind(hi, j)
jk <- rbind(ij, k)
kl <- rbind(jk, l)
lm <- rbind(kl, m)
mn <- rbind(lm, n)

meterreads <- mn
####binding reporting package
setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package")

a <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 12-2016.xlsx", sheet = 12, skip = 4)
b <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 1-2017.xlsx", sheet = 12, skip = 4)
c <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 2-2017.xlsx", sheet = 12, skip = 4)
d <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 3-2017.xlsx", sheet = 12, skip = 4)
e <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 4-2017.xlsx", sheet = 12, skip = 4)
f <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 5-2017.xlsx", sheet = 12, skip = 4)
g <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 6-2017.xlsx", sheet = 12, skip = 4)
h <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 7-2017.xlsx", sheet = 12, skip = 4)
i <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 8-2017.xlsx", sheet = 12, skip = 4)
j <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 9-2017.xlsx", sheet = 12, skip = 4)
k <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 10-2017.xlsx", sheet = 12, skip = 4)
l <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 11-2017.xlsx", sheet = 12, skip = 4)
m <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 12-2017.xlsx", sheet = 12, skip = 4)
n <- read_excel("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer\\Reporting Package\\01 Menlo Park Reporting Package 1-2018.xlsx", sheet = 12, skip = 4)

# renaming column 24, current month's consumption 
#colnames(a)[24] <- "cons"
#colnames(b)[24] <- "cons"
#colnames(c)[24] <- "cons"
#colnames(d)[24] <- "cons"
#colnames(e)[24] <- "cons"
#colnames(f)[25] <- "cons"
#colnames(g)[24] <- "cons"
#colnames(h)[24] <- "cons"
#colnames(i)[25] <- "cons"
#colnames(j)[24] <- "cons"
#colnames(k)[24] <- "cons"
#colnames(l)[24] <- "cons"
#colnames(m)[24] <- "cons"
#colnames(n)[24] <- "cons"




#nullifying monthly consumption column

a <- select(a, - contains("Consumption"))
b <- select(b, - contains("Consumption"))
c <- select(c, - contains("Consumption"))
d <- select(d, - contains("Consumption"))
e <- select(e, - contains("Consumption"))
f <- select(f, - contains("Consumption"))
g <- select(g, - contains("Consumption"))
h <- select(h, - contains("Consumption"))
i <- select(i, - contains("Consumption"))
j <- select(j, - contains("Consumption"))
k <- select(k, - contains("Consumption"))
l <- select(l, - contains("Consumption"))
m <- select(m, - contains("Consumption"))
n <- select(n, - contains("Consumption"))
i$X__1 <- NULL
f $X__1 <- NULL

ab <- rbind(a, b)
bc <- rbind(ab, c)
cd <- rbind(bc, d)
de <- rbind(cd, e) 
ef <- rbind(de, f)
fg <- rbind(ef, g)
gh <- rbind(fg, h)
hi <- rbind(gh, i)
ij <- rbind(hi, j)
jk <- rbind(ij, k)
kl <- rbind(jk, l)
lm <- rbind(kl, m)
mn <- rbind(lm, n)
meterreport <- mn

##write meter reads and meter reports csvs
setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer")
write.csv(meterreads, file = "MeterReadsWSO.csv")
write.csv(meterreport, file = "MeterReportWSO.csv")
##join reads and reporting- join billing code
#meterreads$C_CUSTOMER <- "Customer"
#meterreads$C_ACCOUNT <- "Account"
names(meterreads)[names(meterreads) == 'C_CUSTOMER'] <- "Customer"
names(meterreads)[names(meterreads) == 'C_ACCOUNT'] <- "Account"
names(meterreport)[names(meterreport) == 'CUSTOMER'] <- "Customer"
names(meterreport)[names(meterreport) == 'ACCOUNT'] <- "Account"

#trim leading zeroes from meter report customer and account 
meterreport$Customer <- gsub("0000", "", meterreport$Customer)
meterreport$Account <- gsub("^00", "", meterreport$Account)
meterreads$Customer <- as.character(meterreads$Customer)
meterreads$Account <- as.character(meterreads$Account)
#dropping NA rows
meterreads <- meterreads[!apply(is.na(meterreads) | meterreads == "", 1, all),]
#meterreport$CUSTOMER <- "Customer"
#meterreport$ACCOUNT <- "Account"
#joined <- left_join(x = meterreads, y = meterreport[, c("BILLING CODE")], by = c("Customer"), all.x = TRUE)
#changing customer character type
#changing account character type

report <- data.frame(meterreport)
meterDist <- report %>% group_by(Account,Customer) %>% summarize(sizeType = last(BILLING.CODE), meterID = last(METER..))


joined4 <- left_join(meterreads, meterDist, by=c("Account", "Customer"))

billingdata <-joined4

##seperate columns
billingdata$sizeType <- gsub("Menlo Park - ", "", billingdata$sizeType)
library(tidyr)
#seperate on any letter
billingdata <- separate(billingdata, sizeType, c("Size", "Type"), sep = "[\"]\\s", remove = TRUE)
#trim space at end

sum(is.na(billingdata$Size))

setwd("G:\\Team Drives\\WSO USA - Projects\\690 - BAWSCA\\Menlo Park\\Menlo Park Data Transfer")
write.csv(billingdata, file = "BillingDataWSO8-23.csv")



