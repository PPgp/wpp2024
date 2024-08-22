# 1-year projected male, female and total net migration summed across ages in long format (as data.table)

migprojAge1dt <- local({
    e <- new.env()
    load("migprojAge1dt.rda", envir= e)
    data.table::setDT(e$migprojAge1dt)
    e$migprojAge1dt[, mig := migM + migF]
    load("countries.rda", envir= e)
    merge(data.table::as.data.table(e$countries)[, .(country_code, name)], 
          data.table::as.data.table(e$migprojAge1dt), by = "country_code", sort = FALSE)
})
