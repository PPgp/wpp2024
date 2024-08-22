# annual historical total net migration in long format (as data.table)
mig1dt <- local({
    e <- new.env()
    load("mig1dt.rda", envir= e)
    load("countries.rda", envir= e)
    merge(e$countries[, c("country_code", "name")], data.table::as.data.table(e$mig1dt), by = "country_code", sort = FALSE)
})
