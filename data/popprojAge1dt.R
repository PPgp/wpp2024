# 1x1 projected median female age-specific population in long format (as data.table)
popprojAge1dt <- local({
    e <- new.env()
    load("popprojAge1dt.rda", envir= e)
    data.table::setDT(e$popprojAge1dt)
    e$popprojAge1dt[, `:=`(pop = popM + popF, pop_low = popM_low + popF_low, pop_high = popM_high + popF_high)]
    data.table::setcolorder(e$popprojAge1dt, c("country_code", "year", "age", "popM", "popF", "pop"))
    load("countries.rda", envir= e)
    merge(e$countries[, c("country_code", "name")], data.table::as.data.table(e$popprojAge1dt), by = "country_code", sort = FALSE)
})
