migrationM5 <- local({
    e <- new.env()
    load("migprojAge5dt.rda", envir= e)
    load("countries.rda", envir= e)
    e$migprojAge5dt <- merge(data.table::as.data.table(e$migprojAge5dt), e$countries, 
                             by = "country_code", sort = FALSE)
    as.data.frame(data.table::dcast(e$migprojAge5dt, country_order + country_code + name + age ~ year, value.var = "migM")[, `:=`(country_order = NULL)][])
})

