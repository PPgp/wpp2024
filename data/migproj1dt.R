# annual projections of migration (median,80 & 95% PIs) in long format (as data.table)
migproj1dt <- local({
    e <- new.env()
    load("migproj1dt.rda", envir= e)
    load("countries.rda", envir= e)
    merge(data.table::as.data.table(e$countries[, .(country_code, name)]), data.table::as.data.table(e$migproj1dt), by = "country_code", sort = FALSE)
})    
