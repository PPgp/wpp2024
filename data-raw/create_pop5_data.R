library(data.table)
library(usethis)

# Run this from the data-raw directory
setwd("~/bayespop/R/wpps/wpp2024/data-raw")
wrkdir <- getwd()
data.dir <- "../data" # data directory 

#source("functions.R")

# Population
#############
# 5-year age-specific pop estimates 
# pop1 <- merge.with.age5(popAge1dt)
# pop5 <- pop1[, .(popM = sum(popM), popF = sum(popF), pop = sum(pop)), by = c("country_code", "name", "year", "agecat", "age5")][, agecat := NULL]
# pop5.1 <- pop5[year %in% seq(1949, 2019, by = 5)]
# pop5.2 <- pop5[year %in% seq(1950, 2020, by = 5)]
# pop5 <- pop5.2[, .(country_code, name, year, age = age5, popM = round((pop5.1$popM + pop5.2$popM)/2,3), 
#                    popF = round((pop5.1$popF + pop5.2$popF)/2,3))][, pop := popM + popF]
# 
# popAge5dt <- pop5[]


setwd(data.dir)

source("popAge5dt.R")
popAge5dt[, name := NULL]
use_data(popAge5dt, overwrite = TRUE)

source("popprojAge5dt.R")
popprojAge5dt[, name := NULL]
use_data(popprojAge5dt, overwrite = TRUE)

files.to.remove <- c("popprojAge1dt.rda", "popprojAge1dt.R", "popAge1dt.rda", "popAge1dt.R", "mx1dt.rda", "mx1dt.R")
for(f in files.to.remove) unlink(f)

setwd(wrkdir)

files.to.copy <- c("popAge5dt.R", "popprojAge5dt.R")
file.copy(files.to.copy, data.dir, overwrite = TRUE)

tools::add_datalist("..", force = TRUE)