# 1-year projected male, female and total population summed across ages in long format (as data.table)

popproj1dt <- local({
    e <- new.env()
    load("popproj1dt.rda", envir= e)
    data.table::setDT(e$popproj1dt)
    e$popproj1dt[, pop := popM + popF]
    data.table::setcolorder(e$popproj1dt, c("country_code", "year", "popM", "popF", "pop"))
    load("countries.rda", envir= e)
    merge(data.table::as.data.table(e$countries)[, .(country_code, name)], 
          data.table::as.data.table(e$popproj1dt), by = "country_code", sort = FALSE)
})
