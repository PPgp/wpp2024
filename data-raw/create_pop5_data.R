# Create a 5x5 version of the wpp2024 package to be used in wppExplorer
# (if using 1x1 population it's very slow and crashes on shinyio)

library(data.table)
library(usethis)

# Run this from the data-raw directory
setwd("~/bayespop/R/wpps/wpp2024/data-raw")
wrkdir <- getwd()
data.dir <- "../data" # data directory 
setwd(data.dir)

# 5-year age-specific pop estimates 
source("popAge5dt.R")
popAge5dt[, name := NULL]
use_data(popAge5dt, overwrite = TRUE)

# 5-year projections
source("popprojAge5dt.R")
popprojAge5dt[, name := NULL]
use_data(popprojAge5dt, overwrite = TRUE)

# remove big 1x1 datasets
files.to.remove <- c("popprojAge1dt.rda", "popprojAge1dt.R", "popAge1dt.rda", "popAge1dt.R", "mx1dt.rda", "mx1dt.R")
for(f in files.to.remove) unlink(f)

# copy new version of the corresponding R files for the 5x5 pop
setwd(wrkdir)
files.to.copy <- c("popAge5dt.R", "popprojAge5dt.R")
file.copy(files.to.copy, data.dir, overwrite = TRUE)

# update datalist
tools::add_datalist("..", force = TRUE)
