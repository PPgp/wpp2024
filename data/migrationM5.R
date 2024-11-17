migrationM5 <- local({
    e <- new.env()
    load("migprojAge5dt.rda", envir= e)
    data.table::setDT(e$migprojAge5dt)
    load("countries.rda", envir= e)
    e$migprojAge5dt <- merge(e$migprojAge5dt, e$countries, by = "country_code", sort = FALSE)
    e$migprojAge5dt[, agecat := rep(1:21, nrow(e$migprojAge5dt)/21)]
    as.data.frame(data.table::dcast(e$migprojAge5dt, country_order + country_code + name + agecat + age ~ year, 
                                    value.var = "migM")[, `:=`(country_order = NULL, agecat = NULL)][])
})

