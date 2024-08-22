# annual total net migration (historical and projected) in long format (as data.table)
migration1dt <- local({
    source("mig1dt.R", local = TRUE)
    source("migproj1dt.R", local = TRUE)
    rbind(mig1dt, migproj1dt[, .(country_code, name, year, mig)])
})
