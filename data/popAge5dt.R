# 5x5 male, female and total age-specific observed population in long format (as data.table)
popAge5dt <- local({
    e <- new.env()
    load("popAge5dt.rda", envir= e)
    load("countries.rda", envir= e)
    merge(e$countries[, c("country_code", "name")], data.table::as.data.table(e$popAge5dt), by = "country_code", sort = FALSE)
})
