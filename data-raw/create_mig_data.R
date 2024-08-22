library(data.table)
library(usethis)

# Run this from the data-raw directory

source("functions.R")

# Migration
###########

# annual 
migration1 <- data.table::fread('migration.txt', sep = "\t")[, country := NULL][, last.observed := NULL]
mig1 <- merge.with.countries(migration1)
mig1dt <- melt.and.merge(NULL, mig1, "mig", ids = c("country_order", "country_code"))
mig1dt[, year := as.integer(year)][, country_order := NULL]
use_data(mig1dt, overwrite = TRUE)

# annual age-specific projections
migM1w <- data.table::fread('migrationMproj.txt', sep = "\t")[, country := NULL]
migF1w <- data.table::fread('migrationFproj.txt', sep = "\t")[, country := NULL]
migM1w <- merge.with.countries(migM1w)
mig1 <- melt.and.merge(NULL, migM1w, "migM", ids = c("country_order", "country_code", "age"))
mig1 <- melt.and.merge(mig1, migF1w, "migF", ids = c("country_code", "age"), by = c("country_code", "year", "age"))
migprojAge1dt <- mig1[, year := as.integer(year)][order(country_order, year, age)][, country_order := NULL]
use_data(migprojAge1dt, overwrite = TRUE)

# annual projections
mig1 <- data.table::fread('migrationprojMed.txt', sep = "\t")[, country := NULL]
mig80l <- data.table::fread('migrationproj80l.txt', sep = "\t")[, country := NULL]
mig80u <- data.table::fread('migrationproj80u.txt', sep = "\t")[, country := NULL]
mig95l <- data.table::fread('migrationproj95l.txt', sep = "\t")[, country := NULL]
mig95u <- data.table::fread('migrationproj95u.txt', sep = "\t")[, country := NULL]

mig <- merge.with.countries(mig1)
mig <- melt.and.merge(NULL, mig, "mig", ids = c("country_order", "country_code"))
mig <- melt.and.merge(mig, mig80l, "mig_80l")
mig <- melt.and.merge(mig, mig80u, "mig_80u")
mig <- melt.and.merge(mig, mig95l, "mig_95l")
mig <- melt.and.merge(mig, mig95u, "mig_95u")
migproj1dt <- mig[, year := as.integer(year)][order(country_order, year)][, country_order := NULL][]

use_data(migproj1dt, overwrite = TRUE)

# 5-year age-specific projections
migMw <- data.table::fread('migrationM5.txt', sep = "\t")[, country := NULL]
migFw <- data.table::fread('migrationF5.txt', sep = "\t")[, country := NULL]
migMw <- merge.with.countries(migMw)
mig5 <- melt.and.merge(NULL, migMw, "migM", ids = c("country_order", "country_code", "age"))
mig5 <- melt.and.merge(mig5, migFw, "migF", ids = c("country_code", "age"), 
                       by = c("country_code", "year", "age"))
setnames(mig5, "year", "period")
mig5 <- assign.midyear(mig5)
migprojAge5dt <- mig5[order(country_order, year)][, country_order := NULL][]
use_data(migprojAge5dt, overwrite = TRUE)
