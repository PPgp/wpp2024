# 5x5 migration median projection in long format (as data.table)
migprojAge5dt <- local({
    e <- new.env()
    load("migprojAge5dt.rda", envir= e)
    data.table::setDT(e$migprojAge5dt)
    e$migprojAge5dt[, mig := migM + migF]
    load("countries.rda", envir= e)
    merge(data.table::as.data.table(e$countries)[, .(country_code, name)], 
          data.table::as.data.table(e$migprojAge5dt), by = "country_code", sort = FALSE)
})
